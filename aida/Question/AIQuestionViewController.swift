//
//  AIQuestionViewController.swift
//  aida
//
//  Created by bigyelow on 14/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

import UIKit

fileprivate let questionInfoHorizontalMargin: CGFloat = 15
class AIQuestionViewController: AIBaseViewController {
  private let questionInfoView = AIQuestionInfoView()
  // MARK: debug
  private let questionSet = AIQuestionSet(dictionary: ["id": "1",
                                                       "start_time": "12:00",
                                                       "end_time": "13:00",
                                                       "questions": []])!

  override func viewDidLoad() {
    super.viewDidLoad()

    // MARK: get question set
    view.addSubview(questionInfoView)
    questionInfoView.update(with: questionSet)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    let questionInfoHeight = questionInfoView.sizeThatFits(view.bounds.size).height
    let questionInfoWidth = view.bounds.width - 2 * questionInfoHorizontalMargin
    questionInfoView.frame.size = CGSize(width: questionInfoWidth, height: questionInfoHeight)
    questionInfoView.center = view.center
  }

}
