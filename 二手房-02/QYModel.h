//
//  QYModel.h
//  二手房-02
//
//  Created by qingyun on 15/10/15.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYModel : NSObject
@property (nonatomic,strong) NSString *nid;
@property (nonatomic,strong) NSString *iconurl;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *community;
@property (nonatomic,strong) NSString *cid;
@property (nonatomic,strong) NSString *simpleadd;
@property (nonatomic,strong) NSString *camera;
@property (nonatomic,strong) NSString *housetype;
@property (nonatomic,assign) int temprownumber;
@property (nonatomic,assign) int price;
- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
