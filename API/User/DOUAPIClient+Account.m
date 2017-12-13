//
//  DOUAPIClient+Account.m
//  aida
//
//  Created by bigyelow on 13/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

#import "DOUAPIClient+Account.h"
#import "AIUser.h"

@implementation DOUAPIClient (Account)


#pragma mark - Registration

- (void)ai_getVericationCodeWithPhone:(NSString *)phone
                              success:(DOUAPIRequestSuccessResultStrBlock)successBlock
                              failure:(DOUAPIRequestFailErrorBlock)failureBlock
{
  NSParameterAssert(phone != nil);
  if (!phone) {
    return;
  }

  [self getPath:@"verification_code"
     parameters:@{@"phone": phone}
        success:successBlock
        failure:failureBlock];
}

- (void)ai_postOAuthWithPhone:(NSString *)phone
             verificationCode:(NSString *)code
                      success:(void (^)(DOUOAuth *oauth))successBlock
                      failure:(DOUAPIRequestFailErrorBlock)failureBlock
{
  NSParameterAssert(phone != nil && code != nil);
  if (!phone || !code) {
    return;
  }

  [self postPath:@"auth2/token"
      parameters:@{@"phone": phone, @"verification_code": code}
         success:^(NSString *resultStr) {
           if (successBlock) {
             successBlock([DOUOAuth objectWithString:resultStr]);
           }
         } failure:failureBlock];
}

#pragma mark - Login

- (void)ai_getUserWithUserID:(NSString *)userID
                     success:(void (^)(AIUser *user))successBlock
                     failure:(DOUAPIRequestFailErrorBlock)failureBlock
{
  NSParameterAssert(userID != nil);
  if (!userID) {
    return;
  }

  [self getPath:[NSString stringWithFormat:@"user/%@", userID]
     parameters:nil
        success:^(NSString *resultStr) {
          if (successBlock) {
            successBlock([AIUser objectWithString:resultStr]);
          }
        } failure:failureBlock];
}


@end
