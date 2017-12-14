//
//  DOUAPIClient+Account.h
//  aida
//
//  Created by bigyelow on 13/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

@import DoubanObjCClient;
@class AIUser;

NS_ASSUME_NONNULL_BEGIN
@interface DOUAPIClient (Account)

#pragma mark - Registration

- (void)ai_getVericationCodeWithPhone:(NSString *)phone
                              success:(DOUAPIRequestSuccessResultStrBlock)successBlock
                              failure:(DOUAPIRequestFailErrorBlock)failureBlock;

- (void)ai_postOAuthWithPhone:(NSString *)phone
             verificationCode:(NSString *)code
                      success:(void (^)(DOUOAuth *oauth))successBlock
                      failure:(DOUAPIRequestFailErrorBlock)failureBlock;

#pragma mark - Login

- (void)ai_getUserWithUserID:(NSString *)userID
                     success:(void (^)(AIUser *user))successBlock
                     failure:(DOUAPIRequestFailErrorBlock)failureBlock;

@end
NS_ASSUME_NONNULL_END
