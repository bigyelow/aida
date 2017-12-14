//
//  DOUAPIClient+Rank.m
//  aida
//
//  Created by bigyelow on 14/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

#import "DOUAPIClient+Rank.h"
#import "DOUObjectArray+Builder.h"
#import "AIUser.h"

@implementation DOUAPIClient (Rank)

- (void)getRanklistWithStart:(NSInteger)start
                       count:(NSInteger)count
                     success:(void(^)(DOUObjectArray *array))successBlock
                     failure:(DOUAPIRequestFailErrorBlock)failureBlock
{
  [self getPath:@"user_rank_list"
     parameters:@{@"start": @(start), @"count": @(count)}
        success:^(NSString *resultStr) {
          if (successBlock) {
            Class cls = [DOUObjectArray arrayClassForModel:[AIUser class] fieldName:@"user"];
            DOUObjectArray *array = [cls objectWithString:resultStr];
            successBlock(array);
          }

        } failure:failureBlock];
}

@end
