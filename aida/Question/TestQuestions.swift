//
//  TestQuestions.swift
//  aida
//
//  Created by bigyelow on 18/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

import Foundation

// MARK: question0
private let questionOption00 = AIQuestionOption(dictionary: ["id":"1",
                                                             "refer_id": "1",
                                                             "text": "神秀"])
private let questionOption01 = AIQuestionOption(dictionary: ["id":"2",
                                                             "refer_id": "1",
                                                             "text": "唐曾"])
private let questionOption02 = AIQuestionOption(dictionary: ["id":"3",
                                                             "refer_id": "1",
                                                             "text": "弘仁"])
private let questionOption03 = AIQuestionOption(dictionary: ["id":"4",
                                                             "refer_id": "1",
                                                             "text": "慧能"])
private let answer0 = AIAnswer(dictionary: ["id": "1",
                                            "refer_id": "1",
                                            "type": 0,
                                            "value": ["4", "1"]])

private let question0 = AIQuestion(dictionary: ["id": "1",
                                                "title": "",
                                                "description": "身是菩提树，心如明镜台。是谁写的？",
                                                "time_limit": 30,
                                                "index": 1,
                                                "type": 0,
                                                "answer": answer0!.dictionary,
                                                "options": [questionOption00!.dictionary,
                                                            questionOption01!.dictionary,
                                                            questionOption02!.dictionary,
                                                            questionOption03!.dictionary],
                                                "point": 2])

// MARK: question1
private let questionOption10 = AIQuestionOption(dictionary: ["id":"5",
                                                             "refer_id": "2",
                                                             "text": "中国"])
private let questionOption11 = AIQuestionOption(dictionary: ["id":"6",
                                                             "refer_id": "2",
                                                             "text": "美国"])
private let questionOption12 = AIQuestionOption(dictionary: ["id":"7",
                                                             "refer_id": "2",
                                                             "text": "俄罗斯"])
private let questionOption13 = AIQuestionOption(dictionary: ["id":"8",
                                                             "refer_id": "2",
                                                             "text": "加拿大"])
private let answer1 = AIAnswer(dictionary: ["id": "2",
                                            "refer_id": "2",
                                            "type": 0,
                                            "value": ["7"]])

private let question1 = AIQuestion(dictionary: ["id": "2",
                                                "title": "",
                                                "description": "世界上最大的国家是？",
                                                "time_limit": 30,
                                                "index": 1,
                                                "type": 0,
                                                "answer": answer1!.dictionary,
                                                "options": [questionOption10!.dictionary,
                                                            questionOption11!.dictionary,
                                                            questionOption12!.dictionary,
                                                            questionOption13!.dictionary],
                                                "point": 2])
let testQuestionSet = AIQuestionSet(dictionary: ["id": "1",
                                                          "start_time": "2017-12-17 12:00:00",
                                                          "end_time": "2017-12-17 13:00:00",
                                                          "questions": [question0!.dictionary,
                                                                        question1!.dictionary]])!
