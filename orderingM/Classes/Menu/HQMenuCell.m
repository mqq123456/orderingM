//
//  HQMenuCell.m
//  orderingM
//
//  Created by HeQin on 2017/11/6.
//  Copyright © 2017年 HeQin. All rights reserved.
//

#import "HQMenuCell.h"
#import "HQMenuFrame.h"
#import "HQMenuModel.h"
#import "UIImageView+AFNetworking.h"
@interface HQMenuCell ()
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *nameLab;
@property (nonatomic, weak) UILabel *priceLab;
@property (nonatomic, weak) UILabel *descLab;
@end
@implementation HQMenuCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"HQMenuCell";
    HQMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HQMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 初始化动态
        [self setupOriginal];
    }
    return self;
}
- (void)setupOriginal {
    
    UIImageView *imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:imgView];
    //imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.backgroundColor = [UIColor redColor];
    self.imgView = imgView;
    
    UILabel *nameLab = [[UILabel alloc] init];
    [self.contentView addSubview:nameLab];
    nameLab.font = [UIFont systemFontOfSize:18];
    nameLab.textAlignment = NSTextAlignmentCenter;
    self.nameLab = nameLab;
    
    UILabel *priceLab = [[UILabel alloc] init];
    [self.contentView addSubview:priceLab];
    priceLab.font = [UIFont boldSystemFontOfSize:22];
    priceLab.textAlignment = NSTextAlignmentCenter;
    self.priceLab = priceLab;
    
    UILabel *descLab = [[UILabel alloc] init];
    [self.contentView addSubview:descLab];
    descLab.font = [UIFont systemFontOfSize:12];
    descLab.textAlignment = NSTextAlignmentCenter;
    self.descLab = descLab;
    
}

- (void)setStatusFrame:(HQMenuFrame *)statusFrame {
    _statusFrame = statusFrame;
    [self setupFrame];
    
    HQMenuModel *model = statusFrame.status;
    [self.imgView setImageWithURL:[NSURL URLWithString:model.img]];
    self.nameLab.text = model.name;
    self.priceLab.text = [NSString stringWithFormat:@"%.2f",model.price];
    self.descLab.text = model.desc;
    
}

- (void)setupFrame {
    self.imgView.frame = self.statusFrame.imgViewF;
    self.nameLab.frame = self.statusFrame.nameLabF;
    self.priceLab.frame = self.statusFrame.priceLabF;
    self.descLab.frame = self.statusFrame.descLabF;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
