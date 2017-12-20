//
//  HQMenuVC.m
//  orderingM
//
//  Created by HeQin on 2017/11/3.
//  Copyright © 2017年 HeQin. All rights reserved.
//

#import "HQMenuVC.h"
#import "HQMenuCell.h"
#import "HQMenuFrame.h"
#import "HQModifyVC.h"
#import "HQMenuModel.h"
#import "FSSegmentTitleView.h"
#import "HQMenuTypeVC.h"
#import "AFRequest.h"

@interface HQMenuVC ()<UITableViewDelegate,UITableViewDataSource,FSSegmentTitleViewDelegate>
@property (nonatomic ,strong) NSMutableArray *dataArray;
@property (nonatomic ,strong) NSMutableArray *typeArray;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@end

@implementation HQMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"菜单";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"order_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarBtnClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_add"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarBtnClick)];
    [self addcontentView];
    
    [self getMenuData];
    
}

- (void)getMenuData {
    NSString *url = [NSString stringWithFormat:@"http://10.1.1.14/heqinuc.5/index.php/getmenu/method/%@",@"1"];
    __weak HQMenuVC *tmpSelf = self;
    [AFRequest GET:url success:^(id responseObject) {
        if ([responseObject[@"status"] isEqualToString:@"ok"]) {
            NSArray *data = responseObject[@"data"];
            for (int i = 0; i < data.count; i++) {
                [_typeArray addObject:data[i][@"type"][@"type_name"]];
                NSArray *menus = data[i][@"menus"];
                NSMutableArray *items = [NSMutableArray array];
                for (int j =0; j<menus.count; j++) {
                    NSDictionary *item = menus[j];
                    HQMenuFrame *frame = [[HQMenuFrame alloc] init];
                    HQMenuModel *model = [[HQMenuModel alloc] init];
                    model.img = item[@"img"];
                    model.name = item[@"name"];
                    model.price = [item[@"price"] floatValue];
                    model.desc = item[@"desc"];
                    model.imgW = [item[@"img_w"] floatValue];
                    model.imgH = [item[@"img_h"] floatValue];
                    model.index = [item[@"index_path"] integerValue];
                    frame.status = model;
                    [items addObject:frame];
                }
                [_dataArray addObject:items];
            }
            [_tableView reloadData];
            self.titleView.titlesArr = _typeArray;
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)addcontentView {

    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds)-50, 49.5) delegate:self indicatorType:0];
    self.titleView.delegate = self;
    self.titleView.indicatorColor = [UIColor blueColor];
    [self.view addSubview:_titleView];
    self.titleView.backgroundColor = [UIColor whiteColor];
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn setImage:[UIImage imageNamed:@"type_name_edit"] forState:UIControlStateNormal];
    editBtn.layer.borderWidth = 0.5;
    editBtn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    editBtn.frame = CGRectMake(CGRectGetWidth(self.view.bounds)-40, 74, 30, 30);
    [editBtn addTarget:self action:@selector(editTypeClick) forControlEvents:UIControlEventTouchUpInside];
    editBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:editBtn];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 64+49.5, CGRectGetWidth(self.view.bounds)-50, 0.5)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:line];
    _dataArray = [[NSMutableArray alloc] init];
    _typeArray = [NSMutableArray array];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 114 , [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-114) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
- (void)editTypeClick {
    HQMenuTypeVC *type = [[HQMenuTypeVC alloc] init];
    [self.navigationController pushViewController:type animated:YES];
}
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
   
    NSIndexPath *idxPath = [NSIndexPath indexPathForRow:0 inSection:endIndex];
    [self.tableView scrollToRowAtIndexPath:idxPath
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:YES];
}

- (void)leftBarBtnClick {
    
}
- (void)rightBarBtnClick {
    // 添加菜品
    HQModifyVC *modify = [[HQModifyVC alloc] init];
    [self.navigationController pushViewController:modify animated:YES];
 
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //HQMenuFrame *frame = self.dataArray[indexPath.row];
    HQModifyVC *modify = [[HQModifyVC alloc] init];
    [self.navigationController pushViewController:modify animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HQMenuFrame *frame = self.dataArray[indexPath.section][indexPath.row];
    return frame.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HQMenuCell *cell = [HQMenuCell cellWithTableView:tableView];
    cell.statusFrame = self.dataArray[indexPath.section][indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.dataArray[section];
    return array.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _typeArray.count;
}

@end
