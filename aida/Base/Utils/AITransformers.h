//
//  AITransformers.h
//  aida
//
//  Created by bigyelow on 13/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

#ifndef AITransformers_h
#define AITransformers_h

#define AICommonDateTransformer AIDateTransformerWithFormat(@"yyyy-MM-dd HH:mm:ss")

FOUNDATION_EXTERN NSValueTransformer *AIDateTransformerWithFormat(NSString *format);

#endif /* AITransformers_h */
