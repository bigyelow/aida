//
//  DOUAPIClient+Rank.h
//  aida
//
//  Created by bigyelow on 14/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

@import DoubanObjCClient;

NS_ASSUME_NONNULL_BEGIN
@interface DOUAPIClient (Rank)

- (void)getRanklistWithStart:(NSInteger)start
                       count:(NSInteger)count
                     success:(void(^)(DOUObjectArray * _Nullable array))successBlock
                     failure:(DOUAPIRequestFailErrorBlock)failureBlock;

@end
NS_ASSUME_NONNULL_END
