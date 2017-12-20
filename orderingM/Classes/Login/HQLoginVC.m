//
//  HQLoginVC.m
//  orderingM
//
//  Created by HeQin on 2017/11/3.
//  Copyright © 2017年 HeQin. All rights reserved.
//

#import "HQLoginVC.h"
#import "HQMenuVC.h"
#import "AFRequest.h"

@interface HQLoginVC ()
{
    UITextField *_usernameTF;
    UITextField *_passwordTF;
}
@end

@implementation HQLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgImg.image = [UIImage imageNamed:@"login_bg.jpg"];
    [self.view addSubview:bgImg];
    _usernameTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 74, [UIScreen mainScreen].bounds.size.width - 20, 50)];
    _usernameTF.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"username"]];
    _usernameTF.leftViewMode = UITextFieldViewModeAlways;
    _usernameTF.textColor = [UIColor whiteColor];
    _usernameTF.borderStyle = UITextBorderStyleNone;
    _usernameTF.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    _usernameTF.placeholder = @"请输入用户";
    _usernameTF.layer.cornerRadius = 5;
    _usernameTF.clipsToBounds = YES;
    [self.view addSubview:_usernameTF];
    _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 134, [UIScreen mainScreen].bounds.size.width - 20, 50)];
    _passwordTF.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
    _passwordTF.leftViewMode = UITextFieldViewModeAlways;
    _passwordTF.textColor = [UIColor whiteColor];
    _passwordTF.borderStyle = UITextBorderStyleNone;
    _passwordTF.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    _passwordTF.layer.cornerRadius = 5;
    _passwordTF.clipsToBounds = YES;
    _passwordTF.placeholder = @"请输入密码";
    _passwordTF.secureTextEntry = YES;
    [self.view addSubview:_passwordTF];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    loginBtn.frame = CGRectMake(10, 204, [UIScreen mainScreen].bounds.size.width - 20, 50);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTintColor:[UIColor whiteColor]];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setBackgroundColor:[UIColor greenColor]];
    loginBtn.layer.cornerRadius = 5;
    loginBtn.clipsToBounds = YES;
    [self.view addSubview:loginBtn];
}

- (void)loginBtnClick {
    [self loginSuccess];
//    NSString *url = [NSString stringWithFormat:@"http://10.1.1.14/heqinuc.5/index.php/login/method/%@/%@",_usernameTF.text,_passwordTF.text];
//    __weak HQLoginVC *tmpSelf = self;
//    [AFRequest GET:url success:^(id responseObject) {
//        if ([responseObject[@"status"] isEqualToString:@"ok"]) {
//            [tmpSelf loginSuccess];
//        }
//    } failure:^(NSError *error) {
//
//    }];
    
}
- (void)loginSuccess {
    HQMenuVC *menu = [[HQMenuVC alloc] init];
    [self.navigationController pushViewController:menu animated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
