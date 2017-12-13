//
//  AIQuestionSet.m
//  aida
//
//  Created by bigyelow on 13/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

@import Polymorph;

#import "AIQuestionSet.h"
#import "AITransformers.h"
#import "AIQuestion.h"

@implementation AIQuestionSet

@plm_dynamic_nonnull(startTimeStr, @"start_time", @"")
@plm_dynamic(startTime, @"start_time", AICommonDateTransformer)
@plm_dynamic_nonnull(endTimeStr, @"end_time", @"")
@plm_dynamic(endTime, @"end_time", AICommonDateTransformer)
@plm_dynamic(questions, @"questions", PLMArrayTransformerForClass([AIQuestion class]))

@end
