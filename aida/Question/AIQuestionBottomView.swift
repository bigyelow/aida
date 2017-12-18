//
//  AIQuestionBottomView.swift
//  aida
//
//  Created by bigyelow on 18/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

import UIKit

private let topMargin: CGFloat = 10
private let bottomMargin: CGFloat = 10
private let pointRightMargin: CGFloat = 10

/// 确定 + 积分
class AIQuestionBottomView: UIView {
  var confirmationEnabled: Bool {
    return confirmButton.isEnabled
  }

  private let confirmButton = UIButton(type: .system)
  private let pointLabel = UILabel(frame: CGRect.zero)

  override init(frame: CGRect) {
    super.init(frame: frame)

    confirmButton.setTitle("确定", for: .normal)
    confirmButton.setTitle("确定", for: .disabled)
    confirmButton.setTitleColor(UIColor.gray, for: .disabled)
    addSubview(confirmButton)

    pointLabel.text = "0分"
    addSubview(pointLabel)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    confirmButton.sizeToFit()
    pointLabel.sizeToFit()

    let centerY = bounds.size.height / 2
    let centerX = bounds.size.width / 2
    confirmButton.center = 	CGPoint(x: centerX, y: centerY)
    pointLabel.frame.origin.x = bounds.size.width - pointRightMargin - pointLabel.bounds.size.width
    pointLabel.center.y = centerY
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    confirmButton.sizeToFit()
    pointLabel.sizeToFit()

    return CGSize(width: size.width,
                  height: topMargin + bottomMargin + max(confirmButton.bounds.size.height, pointLabel.bounds.size.height))
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func enableConfirmation(enable: Bool) {
    confirmButton.isEnabled = enable
  }

  func updatePoint(point: Int) {
    pointLabel.text = "\(point)分"
    setNeedsLayout()
  }
}
