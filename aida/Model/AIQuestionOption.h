//
//  AIQuestionOption.h
//  aida
//
//  Created by bigyelow on 16/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

@import DoubanObjCClient;

@interface AIQuestionOption : DOUEQObject

@property (nonatomic, readonly) NSString *referQuestionID;
@property (nonatomic, readonly) NSString *text;

@end
