//
//  AIUser.h
//  aida
//
//  Created by bigyelow on 12/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

@import DoubanObjCClient;

NS_ASSUME_NONNULL_BEGIN
@interface AIUser : DOUEQObject

@property (nonatomic, readonly, nullable) NSString *name;
@property (nonatomic, readonly) NSInteger point;
@property (nonatomic, readonly, nullable) NSURL *avatar;
@property (nonatomic, readonly) NSString *phone;

@end
NS_ASSUME_NONNULL_END
