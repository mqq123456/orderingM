//
//  HQMenuModel.h
//  orderingM
//
//  Created by HeQin on 2017/11/6.
//  Copyright © 2017年 HeQin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQMenuModel : NSObject
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) float price;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) float imgW;
@property (nonatomic, assign) float imgH;
@property (nonatomic, assign) NSInteger index;
@end
