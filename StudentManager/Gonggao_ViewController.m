//
//  Gonggao_ViewController.m
//  ishixi
//
//  Created by csh on 16/8/3.
//  Copyright © 2016年 csh. All rights reserved.
//

#import "Gonggao_ViewController.h"
#import "Xiangqing_ViewController.h"
#import "Zhuye_ViewController.h"
#import "Color+Hex.h"
#import "SBJson.h"
#import "WarningBox.h"
#import "CommonFunc.h"
#import "AFHTTPSessionManager.h"

@interface Gonggao_ViewController()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *title;
    NSMutableArray *time;
    NSMutableArray *noticeidarr;
}
@end


@implementation Gonggao_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"公告管理";
    self.navigationController.navigationBar.hidden = NO;
    //设置导航栏的文字大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //设置导航条为透明
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"5fc1ff"];
    self.view.backgroundColor = [UIColor colorWithHexString:@"5fc1ff"];
    //按钮大小
    int MinWidth=20,MaxHeigth=20;
    
    //设置导航栏左侧按钮
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, MinWidth, MaxHeigth)];
    [leftBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    //[leftBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc]initWithCustomView: leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-34)];
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    self.myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTable.backgroundColor = [UIColor colorWithHexString:@"5fc1ff"];
    [self.view addSubview:self.myTable];
    //NSLog(@"=======%@",self.ip);
    [WarningBox warningBoxModeIndeterminate:@"正在搜索中..." andView:self.view];
    
    //拿到学校IP和studentID
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    //    [def objectForKey:@"IP"];
    //    [def objectForKey:@"studentId"];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc]init];
    //出入参数：
    NSDictionary*datadic=[NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId", nil];
    
    NSString *jsonstring =[writer stringWithObject:datadic];
 
    NSString *url=[NSString stringWithFormat:@"http://%@/job/intf/mobile/gate.shtml?command=stuallnoticelook",[def objectForKey:@"IP"]];
    
    NSDictionary *msg = [NSDictionary dictionaryWithObjectsAndKeys:jsonstring,@"MSG", nil];
    
    [manager POST:url parameters:msg progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @try {
            [WarningBox warningBoxHide:YES andView:self.view];
            [WarningBox warningBoxModeText:@"搜索成功" andView:self.view];
            //NSLog(@"公告－－%@",responseObject);
            NSDictionary *array = [responseObject objectForKey:@"stuNoticeResSimpleDTOs"];
            //NSLog(@"数组－－%@",array);
            title = [[NSMutableArray alloc]init];
            time = [[NSMutableArray alloc]init];
            noticeidarr = [[NSMutableArray alloc] init];
            for (NSDictionary *aa in array) {
                
                [title addObject:[aa objectForKey:@"noticeTitle"]];
                [time addObject:[aa objectForKey:@"issueTime"]];
                [noticeidarr addObject:[aa objectForKey:@"noticeId"]];
            }

            
            [self.myTable reloadData];
                        
        } @catch (NSException *exception) {
            //NSLog(@"网络");
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //NSLog(@"- -%@",error);
    }];

    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"5fc1ff"];
    
}

#pragma mark - create list array

#pragma mark - tableview method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return time.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.view.frame.size.width == 414) {
        return 80;
    }else if (self.view.frame.size.width == 375){
        return 80;
    }else if (self.view.frame.size.width == 320 && self.view.frame.size.height == 568){
        return 50;
    }else{
        return 40;
    }
}
// 数据源方法,每一组的每一行应该显示怎么的界面(含封装的数据),重点!!!
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"cell";
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
    }
    cell.backgroundColor = [UIColor colorWithHexString:@"5fc1ff"];
    //选中cell不变色
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UIView *haha;
    UIButton *lala;
    UILabel *l;
    UILabel *tongzhi;
    UILabel *shijian;
    if (self.view.frame.size.width == 414) {
        
        haha = [[UIView alloc] initWithFrame:CGRectMake(15, 5, self.view.frame.size.width-30, 70)];
        lala = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-50, 25, 15, 15)];
        l = [[UILabel alloc]initWithFrame:CGRectMake(25, 10, 50, 30)];
        tongzhi = [[UILabel alloc]initWithFrame:CGRectMake(75, 10, self.view.frame.size.width-50, 30)];
        shijian = [[UILabel alloc] initWithFrame:CGRectMake(25, 40, self.view.frame.size.width-50, 30)];
        l.font = [UIFont boldSystemFontOfSize:20];
        tongzhi.font = [UIFont boldSystemFontOfSize:20];
        shijian.font = [UIFont boldSystemFontOfSize:18];

    }else if (self.view.frame.size.width == 375){
        
        haha = [[UIView alloc] initWithFrame:CGRectMake(15, 5, self.view.frame.size.width-30, 70)];
        lala = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-50, 25, 15, 15)];
        l = [[UILabel alloc]initWithFrame:CGRectMake(25, 10, 50, 30)];
        tongzhi = [[UILabel alloc]initWithFrame:CGRectMake(75, 10, self.view.frame.size.width-50, 30)];
        shijian = [[UILabel alloc] initWithFrame:CGRectMake(25, 40, self.view.frame.size.width-50, 30)];
        l.font = [UIFont boldSystemFontOfSize:20];
        tongzhi.font = [UIFont boldSystemFontOfSize:20];
        shijian.font = [UIFont boldSystemFontOfSize:18];
    }else if (self.view.frame.size.width == 320 && self.view.frame.size.height == 568){
        
        haha = [[UIView alloc] initWithFrame:CGRectMake(15, 3, self.view.frame.size.width-30, 44)];
        lala = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-50, 15, 15, 15)];
        l = [[UILabel alloc]initWithFrame:CGRectMake(15, 3, 50, 20)];
        tongzhi = [[UILabel alloc]initWithFrame:CGRectMake(45, 3, self.view.frame.size.width-50, 20)];
        shijian = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, self.view.frame.size.width-50, 20)];
        l.font = [UIFont boldSystemFontOfSize:12];
        tongzhi.font = [UIFont boldSystemFontOfSize:12];
        shijian.font = [UIFont boldSystemFontOfSize:10];
    }else if (self.view.frame.size.width == 320 && self.view.frame.size.height == 480){
        
        haha = [[UIView alloc] initWithFrame:CGRectMake(15, 3, self.view.frame.size.width-30, 34)];
        lala = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-50, 10, 10, 10)];
        l = [[UILabel alloc]initWithFrame:CGRectMake(15, 3, 25, 15)];
        tongzhi = [[UILabel alloc]initWithFrame:CGRectMake(45, 3, self.view.frame.size.width-50, 15)];
        shijian = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, self.view.frame.size.width-50, 15)];
        l.font = [UIFont boldSystemFontOfSize:10];
        tongzhi.font = [UIFont boldSystemFontOfSize:10];
        shijian.font = [UIFont boldSystemFontOfSize:8];
    }
    
    
    haha.backgroundColor = [UIColor whiteColor];
    haha.layer.cornerRadius = 5.0;

    
    [lala setImage:[UIImage imageNamed:@"jinru_03.png"]forState:UIControlStateNormal];
    [haha addSubview:lala];
    l.text = @"通知:";
    tongzhi.text = title[indexPath.row];
    shijian.text = time[indexPath.row];
    
    //字体加深
    l.backgroundColor = [UIColor clearColor];
    tongzhi.backgroundColor = [UIColor clearColor];
    shijian.backgroundColor = [UIColor clearColor];
    l.textColor = [UIColor grayColor];
    tongzhi.textColor = [UIColor grayColor];
    shijian.textColor = [UIColor grayColor];
    [haha addSubview:l];
    [haha addSubview:tongzhi];
    [haha addSubview:shijian];
    [cell.contentView addSubview:haha];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.isEditing) {
        return;
    }if (tableView == self.myTable) {

        //NSLog(@"%@",noticeidarr[(long)indexPath.row]);
        //NSLog(@"进入第%ld个公告通知",(long)indexPath.row);
        Xiangqing_ViewController *xqvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"xiangqing"];
        xqvc.ip = self.ip;
        xqvc.studentId = self.studentId;
        xqvc.noticeId = noticeidarr[(long)indexPath.row];

        [self.navigationController pushViewController:xqvc animated:YES];
    }
    
}









- (void)back {

    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)fanhui1{
    
    Zhuye_ViewController *zhuye = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"zhuye"];
    [self presentViewController:zhuye animated:YES completion:nil];
}

@end
