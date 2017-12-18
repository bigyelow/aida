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
  // UI
  private let questionInfoView = AIQuestionInfoView()
  private let questionView = UITableView(frame: CGRect.zero, style: .plain)
  private let questionHeaderView = AIQuestionHeaderView(frame: CGRect.zero)
  private let questionBottomView = AIQuestionBottomView(frame: CGRect.zero)

  // MAKR: debug
  // Data
  private let questionSet = testQuestionSet
  private var checkingArray = [Bool]()
  private var heightCell = AIQuestionOptionTableViewCell(frame: CGRect.zero)
  private var currentPoint: Int = 0
  private var currentQuestion: AIQuestion? {
    get {
      guard let questions = questionSet.questions, questions.count > currentIndex else { return nil }
      return questions[currentIndex]
    }
  }
  private var currentIndex: Int = 0 {
    didSet {
      guard let currentQuestion = currentQuestion else { return }

      // update checkingArray
      checkingArray.removeAll()
      for _ in currentQuestion.options {
        checkingArray.append(false)
      }

      // update headerView
      updateQuestionHeaderView(index: currentIndex)

      // update questionView
      questionView.reloadData()

      // update bottomView
      questionBottomView.enableConfirmation(enable: false)
      questionBottomView.updatePoint(point: 0)
    }
  }

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

//    edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)

    // questionInfoView
    questionInfoView.answerAction = {
      [weak self] in
      guard let sself = self else { return }

      sself.questionInfoView.isHidden = true
      sself.questionView.isHidden = false
      sself.questionBottomView.isHidden = false

      sself.currentIndex = 0
    }

    // questionView
    questionView.delegate = self
    questionView.dataSource = self
    questionView.register(AIQuestionOptionTableViewCell.self)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // MARK: get question set

    // questionInfoView
    view.addSubview(questionInfoView)
    questionInfoView.update(with: questionSet)

    // questionView
    questionView.isHidden = true
    questionView.separatorStyle = .none
    view.addSubview(questionView)

    // bottomView
    questionBottomView.isHidden = true
    view.addSubview(questionBottomView)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    if questionInfoView.isHidden == false {
      let questionInfoHeight = questionInfoView.sizeThatFits(view.bounds.size).height
      let questionInfoWidth = view.bounds.width - 2 * questionInfoHorizontalMargin
      questionInfoView.frame.size = CGSize(width: questionInfoWidth, height: questionInfoHeight)
      questionInfoView.center = view.center

      // questionBottomView
      let bottomSize = questionBottomView.sizeThatFits(view.bounds.size)
      questionBottomView.frame.origin = CGPoint(x: 0, y: view.bounds.size.height - bottomSize.height)
      questionBottomView.frame.size = bottomSize

      questionView.frame.size = CGSize(width: view.bounds.size.width, height: view.bounds.size.height - bottomSize.height)
      questionView.frame.origin = CGPoint.zero
    }
  }
}

// MARK: upate
fileprivate extension AIQuestionViewController {
  func updateQuestionHeaderView(index: Int) {
    guard let questions = questionSet.questions else { return }
    guard questions.count > index else { return }

    questionHeaderView.update(with: questions[index], questionsCount: index)
    questionHeaderView.frame.size = questionHeaderView.sizeThatFits(view.frame.size)

    questionView.tableHeaderView = questionHeaderView
  }

  func selectOption(index: Int) {
    guard checkingArray.count > index else { return }
    checkingArray[index] = !checkingArray[index]

    let indexPath = IndexPath(row: index, section: 0)
    questionView.reloadRows(at: [indexPath], with: .none)

    if checkingArray.contains(true) && !questionBottomView.confirmationEnabled {
      questionBottomView.enableConfirmation(enable: true)
    }
    else if !checkingArray.contains(true) && questionBottomView.confirmationEnabled {
      questionBottomView.enableConfirmation(enable: false)
    }
  }
}

// MARK: tableview delegate & datasource
extension AIQuestionViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let currentQuestion = currentQuestion else { return 0 }
    return currentQuestion.options.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let currentQuestion = currentQuestion,
      currentQuestion.options.count > indexPath.row,
      checkingArray.count > indexPath.row else { return UITableViewCell() }

    let cell: AIQuestionOptionTableViewCell = tableView.dequeue(indexPath)
    cell.update(with: currentQuestion.options[indexPath.row], index: indexPath.row, toCheck: checkingArray[indexPath.row])
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)

    guard let currentQuestion = currentQuestion, currentQuestion.options.count > indexPath.row else { return }
    selectOption(index: indexPath.row)
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    guard let currentQuestion = currentQuestion,
      currentQuestion.options.count > indexPath.row,
      checkingArray.count > indexPath.row else { return 0 }

    heightCell.update(with: currentQuestion.options[indexPath.row], index: indexPath.row, toCheck: checkingArray[indexPath.row])

    return heightCell.sizeThatFits(view.bounds.size).height
  }
}
