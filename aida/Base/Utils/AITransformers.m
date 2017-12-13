//
//  AITransformers.m
//  aida
//
//  Created by bigyelow on 13/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

@import Foundation;
@import Polymorph;

#import "DOUDateUtils.h"

NSValueTransformer *AIDateTransformerWithFormat(NSString *format)
{
  NSCParameterAssert(format.length > 0);

  return [PLMValueTransformer transformerUsingForwardBlock:^id(NSString *value) {
    if (![value isKindOfClass:[NSString class]] || value.length > 0) {
      return [DOUDateUtils dateFromString:value format:format];
    }
    return nil;
  } reverseBlock:^id(NSDate *value) {
    return [DOUDateUtils stringFromDate:value format:format];
  }];
}
