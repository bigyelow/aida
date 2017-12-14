//
//  DOUAPIClient+Question.m
//  aida
//
//  Created by bigyelow on 14/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

#import "DOUAPIClient+Question.h"

#import "AIQuestionSet.h"

@implementation DOUAPIClient (Question)

- (void)getQuestionSetSuccess:(void (^)(AIQuestionSet *questionSet))successBlock
                      failure:(DOUAPIRequestFailErrorBlock)failureBlock
{
  [self getPath:@"question_set"
     parameters:nil
        success:^(NSString *resultStr) {
          if (successBlock) {
            successBlock([AIQuestionSet objectWithString:resultStr]);
          }
        } failure:failureBlock];
}

- (void)postCompleteQuestionSetWithSetID:(NSString *)setID
                        rightQuestionIDs:(NSArray<NSString *> *)rightQuestionIDs
                                   point:(NSInteger)point
                                 success:(DOUAPIRequestSuccessResultStrBlock)successBlock
                                 failure:(DOUAPIRequestFailErrorBlock)failureBlock
{
  NSParameterAssert(setID != nil);
  if (!setID) {
    return;
  }

  NSMutableDictionary *dict = [NSMutableDictionary dictionary];
  dict[@"question_set_id"] = setID;
  dict[@"right_questions"] = [rightQuestionIDs componentsJoinedByString:@"|"] ?: @"";
  dict[@"got_point"] = @(point);

  [self postPath:@"complete_question_set"
      parameters:dict
         success:successBlock
         failure:failureBlock];
}

@end
