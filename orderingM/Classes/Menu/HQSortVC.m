//
//  HQSortVC.m
//  orderingM
//
//  Created by HeQin on 2017/11/10.
//  Copyright © 2017年 HeQin. All rights reserved.
//

#import "HQSortVC.h"
#import "AFRequest.h"

@interface HQSortVC ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)UITableView*myTableview;
@property(strong,nonatomic)UIImageView *cellImage;
@property(strong,nonatomic)NSIndexPath *currentPath;
@property(strong,nonatomic)UITableViewCell *currentCell;
@property(assign,nonatomic)CGFloat orignY;
@property (nonatomic ,strong) NSMutableArray *typeArray;
@end

@implementation HQSortVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"排序";
    self.view = self.myTableview;
    [self getTypeMenusData];
    _typeArray = [NSMutableArray array];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClick)];
}
- (void)getTypeMenusData {
    NSString *url = [NSString stringWithFormat:@"http://10.1.1.14/heqinuc.5/index.php/getmenu/typemenus/%@/%@",@"1",@"1"];
    __weak HQSortVC *tmpSelf = self;
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
    // Dispose of any resources that can be recreated.
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
        
    }
    NSString *name = _typeArray[indexPath.row][@"name"];
    cell.textLabel.text=name;
    
    return cell;
    
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

- (UITableView *)myTableview
{
    if (!_myTableview) {
        _myTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-64)];
        _myTableview.delegate = self;
        _myTableview.dataSource = self;
        _myTableview.contentSize=CGSizeMake(0, [UIScreen mainScreen].bounds.size.height-64);
        _myTableview.scrollEnabled = YES;
    }
    return _myTableview;
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellAccessoryDisclosureIndicator;
}

@end

