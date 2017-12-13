//
//  AIUtilsMacros.h
//  aida
//
//  Created by bigyelow on 13/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

#ifndef AIUtilsMacros_h
#define AIUtilsMacros_h

#define strongify_return_if_nil(VAR, ...) strongify(VAR); if (VAR == nil) { return __VA_ARGS__; }

#if __LP64__ || (TARGET_OS_EMBEDDED && !TARGET_OS_IPHONE) || TARGET_OS_WIN32 || NS_BUILD_32_LIKE_64
#define PRI_NSInteger   "ld"
#define PRI_NSUInteger  "lu"
#else
#define PRI_NSInteger   "d"
#define PRI_NSUInteger  "u"
#endif

#endif /* AIUtilsMacros_h */
