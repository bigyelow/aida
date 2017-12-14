//
//  AIQuestionSet.h
//  aida
//
//  Created by bigyelow on 13/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

@import DoubanObjCClient;
@class AIQuestion;

NS_ASSUME_NONNULL_BEGIN
@interface AIQuestionSet : DOUEQObject

@property (nonatomic, readonly) NSString *startTimeStr;
@property (nonatomic, readonly, nullable) NSDate *startTime;
@property (nonatomic, readonly) NSString *endTimeStr;
@property (nonatomic, readonly, nullable) NSDate *endTime;
@property (nonatomic, readonly, nullable) NSArray<AIQuestion *> *questions;

@end
NS_ASSUME_NONNULL_END
