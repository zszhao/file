//
//  QYModel.m
//  二手房-02
//
//  Created by qingyun on 15/10/15.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "QYModel.h"

@implementation QYModel
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
@end
