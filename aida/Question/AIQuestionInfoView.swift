//
//  AIQuestionInfoView.swift
//  aida
//
//  Created by bigyelow on 14/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

import UIKit

fileprivate let durationTop: CGFloat = 20.0
fileprivate let countTop: CGFloat = 20.0
fileprivate let infoTop: CGFloat = 20.0

class AIQuestionInfoView: UIView {
  private let answerButton = UIButton(type: .system)
  private let durationLabel = UILabel()
  private let questionCountLabel = UILabel()
  private let infoLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)

    infoLabel.text = "答题获积分，积分可换现金"
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    let centerX = bounds.size.width / 2
    let centerY = bounds.size.height / 2

    answerButton.sizeToFit()
    answerButton.frame = CGRect(x: 0, y: centerY, width: answerButton.frame.width, height: answerButton.frame.height)
    answerButton.center.x = centerX

    durationLabel.sizeToFit()
    durationLabel.center.x = centerX
    durationLabel.frame.origin.y = answerButton.frame.maxY + durationTop

    questionCountLabel.sizeToFit()
    questionCountLabel.center.x = centerX
    questionCountLabel.frame.origin.y = durationLabel.frame.maxY + countTop

    infoLabel.sizeToFit()
    infoLabel.center.x = centerX
    infoLabel.frame.origin.y = questionCountLabel.frame.maxY + infoTop
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    super.sizeThatFits(size)

    answerButton.sizeToFit()
    durationLabel.sizeToFit()
    questionCountLabel.sizeToFit()
    infoLabel.sizeToFit()

    let height = (durationTop + durationLabel.frame.height
    + countTop + questionCountLabel.frame.height
    + infoTop + infoLabel.frame.height + (answerButton.frame.height / 2)) * 2

    return CGSize(width: size.width, height: height)
  }

  func update(with questionSet: AIQuestionSet) {
    guard let questionCount = questionSet.questions?.count, questionCount > 0 else { return }

    // MARK: 下一场
    answerButton.setTitle("开始答题", for: .normal)
    questionCountLabel.text = "\(questionCount)道题"
    durationLabel.text = "12:00~13:00"
  }

}
