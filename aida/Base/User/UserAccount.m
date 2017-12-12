//
//  UserAccount.m
//  aida
//
//  Created by bigyelow on 12/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

@import DoubanObjCClient;

#import "UserAccount.h"
#import "AIUser.h"

@interface UserAccount (AccountSharing) <DOUSharedAccount>

@end

@implementation UserAccount

- (instancetype)initWithOauth:(DOUOAuth *)oauth user:(AIUser *)user;
{
  if (self = [super initWithUserUUID:oauth.doubanUserID]) {
    self.oauth = oauth;
    self.user = user;
  }
  return self;
}

@end


@implementation UserAccount (AccountSharing)

- (DOUCommonAccount *)sharedAccount
{
  if (self.oauth == nil) {
    return nil;
  }
  DOUCommonAccount *commonAccount = [[DOUCommonAccount alloc] initWithUserUUID:self.userUUID];
  commonAccount.userName = self.user.name;
  commonAccount.oAuthToken = self.oauth.accessToken;
  return commonAccount;
}

@end
