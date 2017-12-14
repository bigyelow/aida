//
//  AIAnswer.h
//  aida
//
//  Created by bigyelow on 13/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

@import DoubanObjCClient;

typedef NS_ENUM(NSUInteger, AIQuestionType) {
  AIQuestionTypeSingleChoice,
  AIQuestionTypeMultiChoice,
  AIQuestionTypeUnknown,
};

NS_ASSUME_NONNULL_BEGIN
@interface AIAnswer : DOUEQObject

@property (nonatomic, readonly) NSString *referQuestionID;
@property (nonatomic, readonly) AIQuestionType type;
@property (nonatomic, readonly) NSArray<NSString *> *value;

@end
NS_ASSUME_NONNULL_END
