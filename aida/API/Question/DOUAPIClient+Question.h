//
//  DOUAPIClient+Question.h
//  aida
//
//  Created by bigyelow on 14/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

@import DoubanObjCClient;
@class AIQuestionSet;

NS_ASSUME_NONNULL_BEGIN
@interface DOUAPIClient (Question)

- (void)getQuestionSetSuccess:(void (^)(AIQuestionSet *questionSet))successBlock
                      failure:(DOUAPIRequestFailErrorBlock)failureBlock;

- (void)postCompleteQuestionSetWithSetID:(NSString *)setID
                        rightQuestionIDs:(nullable NSArray<NSString *> *)rightQuestionIDs
                                   point:(NSInteger)point
                                 success:(DOUAPIRequestSuccessResultStrBlock)successBlock
                                 failure:(DOUAPIRequestFailErrorBlock)failureBlock;

@end
NS_ASSUME_NONNULL_END
