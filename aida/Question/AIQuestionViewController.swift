//
//  AIQuestionViewController.swift
//  aida
//
//  Created by bigyelow on 14/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

import UIKit

// MARK: debug
private let questionOption0 = AIQuestionOption(dictionary: ["id":"1",
                                                            "refer_id": "1",
                                                            "text": "神秀"])
private let questionOption1 = AIQuestionOption(dictionary: ["id":"2",
                                                            "refer_id": "1",
                                                            "text": "唐曾"])
private let questionOption2 = AIQuestionOption(dictionary: ["id":"3",
                                                            "refer_id": "1",
                                                            "text": "弘仁"])
private let questionOption3 = AIQuestionOption(dictionary: ["id":"4",
                                                            "refer_id": "1",
                                                            "text": "慧能"])
private let answer = AIAnswer(dictionary: ["id": "1",
                                           "refer_id": "1",
                                           "type": 0,
                                           "value": ["4"]])

private let question = AIQuestion(dictionary: ["id": "1",
                                               "title": "",
                                               "description": "身是菩提树，心如明镜台。是谁写的？",
                                               "time_limit": 30,
                                               "index": 1,
                                               "type": 0,
                                               "answer": answer!.dictionary,
                                               "options": [questionOption0!.dictionary,
                                                           questionOption1!.dictionary,
                                                           questionOption2!.dictionary,
                                                           questionOption3!.dictionary],
                                               "point": 2])
private let debugQuestionSet = AIQuestionSet(dictionary: ["id": "1",
                                                          "start_time": "2017-12-17 12:00:00",
                                                          "end_time": "2017-12-17 13:00:00",
                                                          "questions": [question!.dictionary]])!

fileprivate let questionInfoHorizontalMargin: CGFloat = 15
class AIQuestionViewController: AIBaseViewController {
  // UI
  private let questionInfoView = AIQuestionInfoView()
  private let questionView = UITableView(frame: CGRect.zero, style: .plain)
  private let questionHeaderView = AIQuestionHeaderView(frame: CGRect.zero)

  // MAKR: debug
  // Data
  private let questionSet = debugQuestionSet
  private let questionIndex: Int = 0

  override func viewDidLoad() {
    super.viewDidLoad()

    // MARK: get question set

    // questionInfoView
    questionInfoView.answerAction = {
      [weak self] in
      guard let sself = self else { return }

      sself.questionInfoView.isHidden = true
      sself.questionView.isHidden = false

      sself.updateQuestionHeaderView(withIndex: 0)
    }
    view.addSubview(questionInfoView)
    questionInfoView.update(with: questionSet)

    // questionView
    questionView.isHidden = true
    questionView.delegate = self
    questionView.dataSource = self
    view.addSubview(questionView)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    let questionInfoHeight = questionInfoView.sizeThatFits(view.bounds.size).height
    let questionInfoWidth = view.bounds.width - 2 * questionInfoHorizontalMargin
    questionInfoView.frame.size = CGSize(width: questionInfoWidth, height: questionInfoHeight)
    questionInfoView.center = view.center

    questionView.frame = view.bounds
  }
}

// MARK: question header
fileprivate extension AIQuestionViewController {
  func updateQuestionHeaderView(withIndex index: Int) {
    guard let questions = questionSet.questions else { return }
    guard questions.count > index else { return }

    questionHeaderView.update(with: questions[index], questionsCount: index)
    questionHeaderView.frame.size = questionHeaderView.sizeThatFits(view.frame.size)

    questionView.tableHeaderView = questionHeaderView
  }
}

// MARK: tableview delegate & datasource
extension AIQuestionViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}
