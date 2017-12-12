//
//  UserAccount.h
//  aida
//
//  Created by bigyelow on 12/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

/// Note: 这个类的名字不能修改，在DOUAccountManager中使用了Key-Value coding用到了这个名字！！！

#import <DOUUserManager/DOUBasicAccount.h>

@class DOUOAuth;
@class AIUser;

@interface UserAccount : DOUBasicAccount

@property (nonatomic, strong) DOUOAuth *oauth;
@property (nonatomic, strong) AIUser *user;

- (instancetype)initWithOauth:(DOUOAuth *)oauth user:(AIUser *)user;

@end
