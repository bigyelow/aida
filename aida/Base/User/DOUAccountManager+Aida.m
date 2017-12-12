//
//  DOUAccountManager+Aida.m
//  aida
//
//  Created by bigyelow on 12/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

@import DoubanObjCClient;

#import "DOUAccountManager+Aida.h"
#import "UserAccount.h"
#import "aida-Swift.h"

@implementation DOUAccountManager (Aida)

#pragma mark - Client oauth

+ (void)setupClientUserInfo
{
  id account = [[DOUAccountManager sharedInstance] currentActiveAccount];
  if ([account isKindOfClass:[UserAccount class]]) {
    [DOUAPIClient setOAuth:((UserAccount *)account).oauth];
  }
}

#pragma mark - User

+ (AIUser *)currentUser
{
  return [[self currentAccount] user];
}

+ (void)setCurrentUser:(AIUser *)currentUser
{
  UserAccount *account = [self currentAccount];
  account.user = currentUser;
  [self addOrUpdateCurrentAccount:account];
}

#pragma mark - Account

+ (UserAccount *)currentAccount
{
  UserAccount *account = [[DOUAccountManager sharedInstance] currentActiveAccount];
  return account;
}

+ (NSString *)currentUid
{
  return [self currentAccount].oauth.doubanUserID;
}

+ (void)addOrUpdateCurrentAccount:(UserAccount *)account
{
  UserAccount *cuurentAccount = [[DOUAccountManager sharedInstance] currentActiveAccount];

  if (cuurentAccount && [cuurentAccount.oauth.doubanUserID isEqualToString:account.oauth.doubanUserID]) {
    [[DOUAccountManager sharedInstance] updateAccount:account];
  } else if (cuurentAccount) {
    [[DOUAccountManager sharedInstance] logoutCurrentAccount];
    [[DOUAccountManager sharedInstance] setCurrentAccount:account];
  } else {
    [[DOUAccountManager sharedInstance] addCurrentAccount:account];
  }

  [self setupClientUserInfo];
}

+ (void)removeCurrentAccount
{
  [[NSNotificationCenter defaultCenter] postNotificationName:[AccountNotification logout] object:nil];
  [[DOUAccountManager sharedInstance] logoutCurrentAccount];

  [DOUAPIClient setOAuth:nil];
}

@end
