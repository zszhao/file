//
//  QYTableViewCell.h
//  二手房-02
//
//  Created by qingyun on 15/10/15.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconurl;
@property (weak, nonatomic) IBOutlet UILabel *temprownumber;
@property (weak, nonatomic) IBOutlet UILabel *community;
@property (weak, nonatomic) IBOutlet UILabel *simpleadd;
@property (weak, nonatomic) IBOutlet UILabel *housetype;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end
