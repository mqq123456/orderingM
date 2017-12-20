//
//  HQModifyVC.m
//  orderingM
//
//  Created by HeQin on 2017/11/3.
//  Copyright © 2017年 HeQin. All rights reserved.
//

#import "HQModifyVC.h"
#import "PhotoPickerViewController.h"
#import "UIView+Extension.h"
#import "HQPickerView.h"
@interface HQModifyVC ()<PhotoPickerControllerDelegate,HQPickerViewDelegate>
{
    UIView *_bgView;
    UIImageView *_imgView;
    UITextField *_nameLab;
    UITextField *_priceLab;
    UITextField *_descLab;
    PhotoPickerViewController *photoPicker;
    UIButton *_typeTF;
}
@end

@implementation HQModifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑菜单";
    self.view.backgroundColor = [UIColor whiteColor];
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 74, [UIScreen mainScreen].bounds.size.width - 20, ([UIScreen mainScreen].bounds.size.width - 20)/2)];
    _bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_bgView];
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width - 20)/2, ([UIScreen mainScreen].bounds.size.width - 20)/2)];
    _imgView.image = [UIImage imageNamed:@"add_img"];
    _imgView.userInteractionEnabled = YES;
    [_imgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTap)]];
    [_bgView addSubview:_imgView];
    _nameLab = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imgView.frame), 0, ([UIScreen mainScreen].bounds.size.width - 20)/2, 40)];
    _nameLab.textAlignment = NSTextAlignmentCenter;
    _nameLab.placeholder = @"请输入菜名";
    _nameLab.borderStyle = UITextBorderStyleNone;
    _nameLab.font = [UIFont systemFontOfSize:18];
    [_bgView addSubview:_nameLab];
    
    _priceLab = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imgView.frame), _bgView.frame.size.height/2 - 30, ([UIScreen mainScreen].bounds.size.width - 20)/2, 60)];
    _priceLab.textAlignment = NSTextAlignmentCenter;
    _priceLab.placeholder = @"请输入单价";
    _priceLab.borderStyle = UITextBorderStyleNone;
    _priceLab.font = [UIFont boldSystemFontOfSize:22];
    [_bgView addSubview:_priceLab];
    _descLab = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imgView.frame), CGRectGetMaxY(_priceLab.frame), ([UIScreen mainScreen].bounds.size.width - 20)/2, 12)];
    _descLab.textAlignment = NSTextAlignmentCenter;
    _descLab.placeholder = @"请输入描述";
    _descLab.borderStyle = UITextBorderStyleNone;
    _descLab.font = [UIFont systemFontOfSize:12];
    [_bgView addSubview:_descLab];
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    doneBtn.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.height - 60, [UIScreen mainScreen].bounds.size.width - 20, 50);
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setTintColor:[UIColor whiteColor]];
    [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setBackgroundColor:[UIColor greenColor]];
    doneBtn.layer.cornerRadius = 5;
    doneBtn.clipsToBounds = YES;
    [self.view addSubview:doneBtn];

    _typeTF = [UIButton buttonWithType:UIButtonTypeSystem];
    _typeTF.frame = CGRectMake(10, CGRectGetMaxY(_bgView.frame)+10, [UIScreen mainScreen].bounds.size.width - 20, 50);
    [_typeTF setTitle:@"选择菜品分类" forState:UIControlStateNormal];
    [_typeTF addTarget:self action:@selector(typeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_typeTF];
}
- (void)typeClick {
    HQPickerView *picker = [[HQPickerView alloc] init];
    picker.customArr = @[@"推荐",@"家常菜",@"素菜",@"凉菜",@"面食",@"粥",@"私房菜",@"主食",@"糕点",@"饮品",@"海鲜"];
    picker.delegate = self;
    [self.view addSubview:picker];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectText:(NSString *)text {
    [_typeTF setTitle:text forState:UIControlStateNormal];
}

- (void)doneBtnClick {
    NSLog(@"%@,%@,%@",_nameLab.text,_priceLab.text,_descLab.text);
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)imgTap {
    photoPicker = [[PhotoPickerViewController alloc] initWithDelegate:self IsCamera:NO IsEdit:NO];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:photoPicker];
    nav.navigationBar.hidden=YES;
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark - PhotoPickerDelegate
- (void)didFinishPickingWithImage:(UIImage *)image isFromCamera:(BOOL)isFromCamera {
    [self dismissViewControllerAnimated:NO completion:nil];
    _imgView.image = image;
    _bgView.height = ([UIScreen mainScreen].bounds.size.width - 20)/2 * ( image.size.height/image.size.width);
    _imgView.height = ([UIScreen mainScreen].bounds.size.width - 20)/2 * ( image.size.height/image.size.width);
    _priceLab.y = _bgView.frame.size.height/2 - 30;
    _descLab.y = CGRectGetMaxY(_priceLab.frame);
    _typeTF.y = CGRectGetMaxY(_bgView.frame)+10;
    photoPicker = nil;
}

-(void) PhotoPickerCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
    photoPicker = nil;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
