//
//  HQMenuFrame.m
//  orderingM
//
//  Created by HeQin on 2017/11/6.
//  Copyright © 2017年 HeQin. All rights reserved.
//

#import "HQMenuFrame.h"
#import "HQMenuModel.h"
@implementation HQMenuFrame
- (void)setStatus:(HQMenuModel *)status {
    _status = status;
    // cell的宽度
    CGFloat gap = 0;
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - (gap*2);
    CGFloat cellH = (cellW/2)/status.imgW*status.imgH +(gap*2);
    CGFloat labelX = cellW/2+gap;
    self.cellHeight = cellH;

    if (status.index%2 == 0) {
        self.imgViewF = CGRectMake(gap, gap, cellW/2, cellH -(gap*2));
        self.nameLabF = CGRectMake(labelX, gap*2, labelX, 40);
        self.priceLabF = CGRectMake(labelX, cellH/2 - 15, labelX, 30);
        self.descLabF = CGRectMake(labelX, CGRectGetMaxY(self.priceLabF), labelX, 15);
    }else{
        self.imgViewF = CGRectMake(labelX, gap, cellW/2, cellH -(gap*2));
        self.nameLabF = CGRectMake(0, gap*2, labelX, 40);
        self.priceLabF = CGRectMake(0, cellH/2 - 15, labelX, 30);
        self.descLabF = CGRectMake(0, CGRectGetMaxY(self.priceLabF), labelX, 15);
    }
}
@end
