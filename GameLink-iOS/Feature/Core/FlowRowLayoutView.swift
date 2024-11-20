//
//  FlowRowLayoutView.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/19/24.
//

import SwiftUI

public struct FlowRowLayoutView: Layout {
  var verticalSpacing: CGFloat
  var horizontalSpacing: CGFloat
  
  public init(verticalSpacing: CGFloat = 10, horizontalSpacing: CGFloat = 10) {
    self.verticalSpacing = verticalSpacing
    self.horizontalSpacing = horizontalSpacing
  }
  
  public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
    var width: CGFloat = 0
    var height: CGFloat = 0
    var rowWidth: CGFloat = 0
    var rowHeight: CGFloat = 0
    let maxWidth = proposal.replacingUnspecifiedDimensions().width
    
    for subview in subviews {
      let subviewSize = subview.sizeThatFits(ProposedViewSize(width: maxWidth, height: nil))
      
      if rowWidth + subviewSize.width > maxWidth {
        width = max(width, rowWidth)
        height += rowHeight + verticalSpacing
        rowWidth = 0
        rowHeight = 0
      }
      
      rowWidth += subviewSize.width + horizontalSpacing
      rowHeight = max(rowHeight, subviewSize.height)
    }
    
    width = max(width, rowWidth)
    height += rowHeight
    
    return CGSize(width: width, height: height)
  }
  
  public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
    var x: CGFloat = 0
    var y: CGFloat = 0
    var rowHeight: CGFloat = 0
    let maxWidth = bounds.width
    
    for subview in subviews {
      let subviewSize = subview.sizeThatFits(ProposedViewSize(width: maxWidth, height: nil))
      
      if x + subviewSize.width > maxWidth {
        x = 0
        y += rowHeight + verticalSpacing
        rowHeight = 0
      }
      
      subview.place(
        at: CGPoint(x: bounds.minX + x, y: bounds.minY + y),
        proposal: ProposedViewSize(width: subviewSize.width, height: subviewSize.height)
      )
      
      x += subviewSize.width + horizontalSpacing
      rowHeight = max(rowHeight, subviewSize.height)
    }
  }
}
