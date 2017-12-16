//
//  AIQuestion.h
//  aida
//
//  Created by bigyelow on 13/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

@import DoubanObjCClient;
@class AIQuestionOption;

#import "AIAnswer.h"

NS_ASSUME_NONNULL_BEGIN
@interface AIQuestion : DOUEQObject

@property (nonatomic, readonly, nullable) NSString *title;
@property (nonatomic, readonly, nullable) NSString *desc;
@property (nonatomic, readonly) NSInteger timeLimit;
@property (nonatomic, readonly) NSInteger index;
@property (nonatomic, readonly) AIQuestionType type;
@property (nonatomic, readonly) AIAnswer *answer;
@property (nonatomic, readonly) NSInteger point;
@property (nonatomic, readonly) NSArray<AIQuestionOption *> *options;

@end
NS_ASSUME_NONNULL_END
