//
//  DOUAccountManager+Aida.h
//  aida
//
//  Created by bigyelow on 12/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

@import DOUUserManager;

@class AIUser, UserAccount;

NS_ASSUME_NONNULL_BEGIN
@interface DOUAccountManager (Aida)

// OAuth client
+ (void)setupClientUserInfo;

// User related
+ (AIUser * __nullable)currentUser;
+ (void)setCurrentUser:(AIUser *)currentUser;
+ (NSString * __nullable)currentUid;

// Account related
+ (UserAccount * __nullable)currentAccount;
+ (void)addOrUpdateCurrentAccount:(UserAccount *)account;
+ (void)removeCurrentAccount;

@end
NS_ASSUME_NONNULL_END
