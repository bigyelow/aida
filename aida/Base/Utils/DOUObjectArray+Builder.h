//
//  DOUObjectArray+Builder.h
//  aida
//
//  Created by bigyelow on 14/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

@import DoubanObjCClient;

NS_ASSUME_NONNULL_BEGIN

@interface DOUObjectArray (Builder)

/**
 * 运行时创建 `DOUObjectArray` 子类。
 *
 * @param modelClass 数组中对象的类型。用于生成 `objectClass` 方法。
 * @param field JSON 中对象数组的字段名。用于生成 `objectName` 方法。
 */
+ (Class)arrayClassForModel:(Class)modelClass fieldName:(NSString *)field;

/**
 *  更新 DOUObjectArray 中的 objectArray 字段，返回新的 DOUObjectArray 对象
 */
- (DOUObjectArray *)arrayWithNewObjectArray:(NSArray *)objectArray class:(Class)class fieldName:(NSString *)fieldName;

@end

NS_ASSUME_NONNULL_END

