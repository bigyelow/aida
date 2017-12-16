//
//  AIQuestion.m
//  aida
//
//  Created by bigyelow on 13/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

@import Polymorph;

#import "AIQuestion.h"
#import "AIQuestionOption.h"

@implementation AIQuestion

@plm_dynamic_multi(title, index, type, point)
@plm_dynamic(desc, @"description")
@plm_dynamic(timeLimit, @"time_limit")
@plm_dynamic_nonnull(answer, @"answer", [AIAnswer new])
@plm_dynamic_nonnull(options, @"options", PLMArrayTransformerForClass([AIQuestionOption class]))

@end
