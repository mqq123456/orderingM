//
//  HQMenuCell.h
//  orderingM
//
//  Created by HeQin on 2017/11/6.
//  Copyright © 2017年 HeQin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HQMenuFrame;
@interface HQMenuCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) HQMenuFrame *statusFrame;
@end
