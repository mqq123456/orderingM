//
//  HQMenuFrame.h
//  orderingM
//
//  Created by HeQin on 2017/11/6.
//  Copyright © 2017年 HeQin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class HQMenuModel;
@interface HQMenuFrame : NSObject
@property (nonatomic, strong) HQMenuModel *status;
@property (nonatomic, assign) CGRect imgViewF;
@property (nonatomic, assign) CGRect nameLabF;
@property (nonatomic, assign) CGRect priceLabF;
@property (nonatomic, assign) CGRect descLabF;
@property (nonatomic, assign) CGFloat cellHeight;
@end
