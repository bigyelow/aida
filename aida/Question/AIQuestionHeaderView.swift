//
//  AIQuestionHeaderView.swift
//  aida
//
//  Created by bigyelow on 16/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

import UIKit

private let horizontalMargin: CGFloat = 10
private let topMargin: CGFloat = 10
private let descTopMargin: CGFloat = 10
private let bottomMargin: CGFloat = 10

class AIQuestionHeaderView: UIView {
  private let indexLabel = UILabel()
  private let countDownLable = UILabel()
  private let descLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(indexLabel)
    addSubview(countDownLable)
    addSubview(descLabel)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    indexLabel.sizeToFit()
    indexLabel.frame.origin = CGPoint(x: horizontalMargin, y: topMargin)

    countDownLable.sizeToFit()
    countDownLable.frame.origin = CGPoint(x: bounds.size.width - countDownLable.bounds.size.width - horizontalMargin,
                                          y: topMargin)

    descLabel.sizeToFit()
    descLabel.frame.origin.y = indexLabel.frame.maxY + descTopMargin
    descLabel.center.x = bounds.size.width / 2
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    indexLabel.sizeToFit()
    countDownLable.sizeToFit()
    descLabel.sizeToFit()

    return CGSize(width: size.width, height: topMargin + indexLabel.frame.size.height + descTopMargin + descLabel.bounds.size.height + bottomMargin)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func update(with question: AIQuestion, questionsCount count: Int) {
    indexLabel.text = "\(question.index)/\(count)"
    countDownLable.text = "\(question.timeLimit)sec"
    descLabel.text = question.desc

    setNeedsLayout()
  }
}
