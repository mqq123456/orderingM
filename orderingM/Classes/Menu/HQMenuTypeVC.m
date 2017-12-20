//
//  HQMenuTypeVC.m
//  orderingM
//
//  Created by HeQin on 2017/11/6.
//  Copyright © 2017年 HeQin. All rights reserved.
//

#import "HQMenuTypeVC.h"
#import "HQSortVC.h"
#import "AFRequest.h"

@interface HQMenuTypeVC ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)UITableView*myTableview;
@property(strong,nonatomic)UIImageView *cellImage;
@property(strong,nonatomic)NSIndexPath *currentPath;
@property(strong,nonatomic)UITableViewCell *currentCell;
@property(assign,nonatomic)CGFloat orignY;
@property (nonatomic ,strong) NSMutableArray *typeArray;
@end

@implementation HQMenuTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑分类";
    self.view = self.myTableview;
    [self getTypeData];
    _typeArray = [NSMutableArray array];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClick)];
}
- (void)getTypeData {
    NSString *url = [NSString stringWithFormat:@"http://10.1.1.14/heqinuc.5/index.php/getmenu/type/%@",@"1"];
    __weak HQMenuTypeVC *tmpSelf = self;
    [AFRequest GET:url success:^(id responseObject) {
        if ([responseObject[@"status"] isEqualToString:@"ok"]) {
            _typeArray = responseObject[@"data"];
            [tmpSelf.myTableview reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)rightBtnClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"testIdentify";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
        UILongPressGestureRecognizer *pan=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(panReg:)];
        [cell addGestureRecognizer:pan];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
        delete.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 120, 15, 30, 30);
        [delete setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [delete addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:delete];
        UIButton *edit = [UIButton buttonWithType:UIButtonTypeCustom];
        edit.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 70, 15, 30, 30);
        [edit addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [edit setImage:[UIImage imageNamed:@"type_name_edit"] forState:UIControlStateNormal];
        [cell.contentView addSubview:edit];
    }
    NSString *name = _typeArray[indexPath.row][@"type_name"];
    cell.textLabel.text=name;
    return cell;
}
- (void)deleteBtnClick:(UIButton *)deleteBtn {
    UITableViewCell *cell = (UITableViewCell *)deleteBtn.superview.superview;
    NSIndexPath *indexPath = [self.myTableview indexPathForCell:cell];
    [self.typeArray removeObjectAtIndex:indexPath.row];
    [self.myTableview reloadData];
}
- (void)editBtnClick:(UIButton *)editBtn {
    UITableViewCell *cell = (UITableViewCell *)editBtn.superview.superview;
    NSIndexPath *indexPath = [self.myTableview indexPathForCell:cell];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入类别" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"输入类别";
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (alert.textFields[0].text.length != 0 ) {
            [_typeArray setObject:alert.textFields[0].text atIndexedSubscript:indexPath.row];
            [_myTableview reloadData];
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
//MARK:-PAN GESTURE
- (void)panReg:(UILongPressGestureRecognizer*)recognise{
    
    CGPoint currentPoint = [recognise locationInView:self.view];
    
    
    if (recognise.state==UIGestureRecognizerStateBegan) {
        _orignY=currentPoint.y;
        _currentPath = [_myTableview indexPathForRowAtPoint:currentPoint];
        _currentCell=[_myTableview cellForRowAtIndexPath:_currentPath];
        _currentCell.hidden=YES;
        _cellImage=[UIImageView new];
        _cellImage.image=[self getImageWithCell:_currentCell];
        _cellImage.frame=CGRectMake(0,currentPoint.y-30, [[UIScreen mainScreen] bounds].size.width, 60);
        _cellImage.backgroundColor =[UIColor clearColor];
        [self.view addSubview:_cellImage];
        
    }else if(recognise.state==UIGestureRecognizerStateChanged){
        _cellImage.frame=CGRectMake(0, currentPoint.y-30, [[UIScreen mainScreen] bounds].size.width, 60);
        //判断方向
        if (currentPoint.y>_orignY) {
            if (currentPoint.y-_orignY>30) {
                NSIndexPath *newIndexPath=[NSIndexPath indexPathForRow:_currentPath.row+1 inSection:0];
                if(newIndexPath.row<10){
                    [self.myTableview moveRowAtIndexPath:_currentPath toIndexPath:newIndexPath];
                    _currentPath=newIndexPath;
                    _orignY+=60;
                }
                
            }
            
        }else{
            if (_orignY-currentPoint.y>30) {
                NSIndexPath *newIndexPath=[NSIndexPath indexPathForRow:_currentPath.row-1 inSection:0];
                [self.myTableview moveRowAtIndexPath:_currentPath toIndexPath:newIndexPath];
                _currentPath=newIndexPath;
                _orignY-=60;
            }
            
        }
        
    }else if(recognise.state==UIGestureRecognizerStateEnded){
        
        [_cellImage removeFromSuperview];
        _cellImage=nil;
        _currentCell.hidden=NO;
        
        
    }
    
}
//MARK:截图
- (UIImage *)getImageWithCell:(UITableViewCell*)cell {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake([[UIScreen mainScreen] bounds].size.width, 60), NO, 1.0);
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, CGRectMake(0, 3, [[UIScreen mainScreen] bounds].size.width, 60), [UIImage imageNamed:@"shadow"].CGImage);
    
    [cell.contentView.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _typeArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HQSortVC *sort = [[HQSortVC alloc] init];
    [self.navigationController pushViewController:sort animated:YES];
}
- (UITableView *)myTableview
{
    if (!_myTableview) {
        _myTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-64)];
        _myTableview.delegate = self;
        _myTableview.dataSource = self;
        _myTableview.contentSize=CGSizeMake(0, [UIScreen mainScreen].bounds.size.height-64);
        _myTableview.scrollEnabled = YES;
    }
    UIButton *footerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [footerBtn setTitle:@"添加菜系" forState:UIControlStateNormal];
    footerBtn.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50);
    footerBtn.backgroundColor = [UIColor greenColor];
    [footerBtn setTintColor:[UIColor whiteColor]];
    [footerBtn addTarget:self action:@selector(setTypeClick:indexPath:) forControlEvents:UIControlEventTouchUpInside];
    _myTableview.tableFooterView = footerBtn;
    return _myTableview;
}
- (void)setTypeClick:(UIControl* )control indexPath:(NSInteger)indexPath{
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入类别" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"输入类别";
    }];

    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (alert.textFields[0].text != 0 ) {
            if ([control isKindOfClass:[UIButton class]]) {
                [_typeArray addObject:alert.textFields[0].text];
            }else{
                _typeArray[indexPath] = alert.textFields[0].text;
            }
            [_myTableview reloadData];
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alert animated:YES completion:nil];

}
- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellAccessoryDisclosureIndicator;
}

@end
