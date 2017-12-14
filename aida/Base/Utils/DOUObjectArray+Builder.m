//
//  DOUObjectArray+Builder.m
//  aida
//
//  Created by bigyelow on 14/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

#include <objc/runtime.h>

#import "DOUObjectArray+Builder.h"

@implementation DOUObjectArray (Builder)

+ (Class)arrayClassForModel:(Class)modelClass fieldName:(NSString *)field
{
  NSParameterAssert(modelClass != nil && field != nil);

  NSString *className = [NSString stringWithFormat:@"DOUObjectArray_%@_%@", NSStringFromClass(modelClass), field];
  Class cls = NSClassFromString(className);
  if (cls) {
    return cls;
  }

  cls = objc_allocateClassPair([DOUObjectArray class], [className UTF8String], 0);
  if (cls == nil) {
    NSAssert(NO, @"Should never happen");
    return nil;
  }

  objc_registerClassPair(cls);

  class_replaceMethod(objc_getMetaClass([className UTF8String]),
                      @selector(objectClass),
                      imp_implementationWithBlock(^{ return modelClass; }),
                      method_getTypeEncoding(class_getClassMethod([DOUObjectArray class], @selector(objectClass))));
  class_replaceMethod(objc_getMetaClass([className UTF8String]),
                      @selector(objectName),
                      imp_implementationWithBlock(^{ return field; }),
                      method_getTypeEncoding(class_getClassMethod([DOUObjectArray class], @selector(objectName))));

  return cls;
}

- (DOUObjectArray *)arrayWithNewObjectArray:(NSArray *)objectArray class:(Class)class fieldName:(NSString *)fieldName
{
  NSParameterAssert(objectArray != nil && class != nil && fieldName != nil);

  NSMutableDictionary *dict = [self.dictionary mutableCopy];

  NSAssert([dict[fieldName] isKindOfClass:[NSArray class]], @"filedName field should be array");

  __block NSMutableArray *array = [NSMutableArray array];
  [objectArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    if ([obj isKindOfClass:[DOUObject class]]) {
      [array addObject:((DOUObject *)obj).dictionary];
    }
  }];
  dict[fieldName] = [array copy];
  Class cls = [DOUObjectArray arrayClassForModel:class fieldName:fieldName];
  return [cls objectWithDictionary:dict];

}

@end
