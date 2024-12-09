//
//  DefaultStompService.swift
//  GameLink-iOS
//
//  Created by 정도현 on 12/6/24.
//

import Foundation
import Starscream
import Combine

public enum StompMessgeType: String, Hashable {
  case talk = "TALK"
  case enter = "ENTER"
  case leave = "LEAVE"
  
  public var destination: String {
    switch self {
    case .talk: return "sendMessage"
    case .enter: return "enterUser"
    case .leave: return "leaveUser"
    }
  }
}

final class DefaultStompService {
  
  private var socket: WebSocket?
  private let serverURL = Config.socketURL
  
  private let service: ChatService
  
  private var roomId: String?
  private var userId: String?
  private var userName: String?
  
  private var cancellables = Set<AnyCancellable>()
  
  private let messageSubject = PassthroughSubject<[ChatContentDTO], Error>()
  var messagesPublisher: AnyPublisher<[ChatContentDTO], Error> {
    messageSubject.eraseToAnyPublisher()
  }
  
  private(set) var page: Int = -1
  private(set) var hasNext: Bool = true
  
  init(service: ChatService) {
    self.service = service
  }
  
  func fetchPreviousMessages(page: Int, size: Int) {
    guard let roomId = self.roomId else { return }
    
    service.fetchChatMessage(roomId: roomId, page: page, size: size) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success(let data):
        self.hasNext = data.hasNext
        self.messageSubject.send(data.content)
        
        if data.hasNext {
          self.fetchPreviousMessages(page: page + 1, size: size)
        }
        
      case .failure(let error):
        self.messageSubject.send(completion: .failure(error))
      }
    }
  }
}

extension DefaultStompService: StompService {
  
  func connect(roomId: String, userId: String, userName: String) {
    self.roomId = roomId
    self.userId = userId
    self.userName = userName
    
    var request = URLRequest(url: URL(string: serverURL)!)
    request.timeoutInterval = 5
    
    self.page = -1
    
    socket = WebSocket(request: request)
    socket?.delegate = self
    socket?.connect()
  }
  
  func disconnect() {
    sendLeaveMessage()
    socket?.disconnect()
    socket = nil
  }
  
  func send(nickname: String, body: String) {
    sendMessage(type: .talk, body: body, fileType: "NONE")
  }
  
  private func sendMessage(type: StompMessgeType, body: String, fileType: String) {
    
    guard let roomId = self.roomId, let userId = self.userId, let userName = self.userName else {
      return
    }
    
    let messageData: [String: Any] = [
      "roomId": roomId,
      "userId": userId,
      "sender": userName,
      "content": body,
      "type": type.rawValue,
      "fileType": fileType
    ]
    
    guard let jsonData = try? JSONSerialization.data(withJSONObject: messageData, options: []),
          let jsonString = String(data: jsonData, encoding: .utf8) else {
      print("Failed to serialize JSON")
      return
    }
    
    let sendFrame = """
        SEND
        destination:/pub/chat/\(type.destination)
        content-type:application/json
        
        \(jsonString)\u{00}
        """
    
    print(sendFrame)
    socket?.write(string: sendFrame)
  }
  private func sendConnectFrame() {
    let connectFrame = "CONNECT\naccept-version:1.1,1.2\nhost:yourserver.com\n\n\u{00}"
    
    socket?.write(string: connectFrame)
    print("Sent CONNECT frame: \(connectFrame)")
  }
  
  private func sendEnterMessage() {
    sendMessage(type: .enter, body: "", fileType: "NONE")
  }
  
  private func sendLeaveMessage() {
    sendMessage(type: .leave, body: "", fileType: "NONE")
  }
  
  private func subscribeRoom() {
    guard let roomId = roomId else { return }
    
    let subscribeFrame = """
    SUBSCRIBE
    id:sub-\(roomId)
    destination:/sub/chatRoom/enter\(roomId)
    
    \u{00}
    """
    
    print(subscribeFrame)
    socket?.write(string: subscribeFrame)
  }
}

// MARK: - WebSocket Delegate
extension DefaultStompService: WebSocketDelegate {
  func didReceive(event: WebSocketEvent, client: WebSocketClient) {
    switch event {
    case .connected(_):
      sendConnectFrame()
      subscribeRoom()
      sendEnterMessage()
      
      page += 1
      self.fetchPreviousMessages(page: self.page, size: 10)
      
    case .text(let string):
      handleTextMessage(string)
      
    case .disconnected(let reason, let code):
      print("WebSocket disconnected: \(reason) with code: \(code)")
      
    case .error(let error):
      print("WebSocket error: \(error?.localizedDescription ?? "Unknown error")")
      
    default:
      break
    }
  }
  
  private func handleTextMessage(_ string: String) {
    // STOMP 헤더와 본문 분리
    guard let separatorRange = string.range(of: "\n\n") else {
      print("Invalid STOMP message format")
      return
    }
    
    let headers = string[string.startIndex..<separatorRange.lowerBound]
    let body = string[separatorRange.upperBound...].trimmingCharacters(in: .whitespacesAndNewlines).dropLast()
    
    // 헤더 출력
    print("Headers: \(headers)")
    print("Body: \(body)")
    
    // Body를 JSON으로 디코딩
    guard let data = body.data(using: .utf8) else {
      print("Body is not valid UTF-8 string: \(body)")
      return
    }
    
    do {
      let chatContent = try JSONDecoder().decode(ChatContentDTO.self, from: data)
      self.messageSubject.send([chatContent])
    } catch {
      print("Error decoding JSON into ChatContentDTO: \(error.localizedDescription)")
    }
  }
}
