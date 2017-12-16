//
//  DOUObject+DynamicProperty.m
//  aida
//
//  Created by bigyelow on 16/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

#import "DOUObject+DynamicProperty.h"

@implementation DOUObject (Polymorph)

+ (void)load
{
  @autoreleasepool { [self plm_activate]; }
}

- (NSMutableDictionary *)polymorphRawData
{
  return self.dictionary;
}

+ (instancetype)objectWithPolymorphRawData:(NSMutableDictionary *)data
{
  return [self objectWithDictionary:data];
}

@end
