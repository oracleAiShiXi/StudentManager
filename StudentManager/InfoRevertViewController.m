//
//  InfoRevertViewController.m
//  StudentManager
//
//  Created by newmac on 16/8/9.
//  Copyright © 2016年 newmac. All rights reserved.
//

#import "InfoRevertViewController.h"
#import "AFHTTPSessionManager.h"
#import "SBJson.h"
#import "InfoMinuteViewController.h"
#import "WarningBox.h"
@interface InfoRevertViewController ()
{
    NSMutableArray * arr ;
    NSMutableArray * arr1 ;
    NSMutableArray * arr2 ;
    NSMutableArray * arr4 ;
    NSMutableArray * arr5 ;
    NSMutableArray * arr6 ;
    int flag;
}
@end

@implementation InfoRevertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //_mytable1.separatorStyle=UITableViewCellSeparatorStyleNone;
    _mytable1.backgroundColor=[UIColor colorWithRed:95/255.0 green:193/255.0 blue:255/255.0 alpha:1];
    
    
 
    _mytable1.showsVerticalScrollIndicator = NO;
    _mytable1.dataSource =self;
    _mytable1.delegate  =self;

    flag = 1;
    
    
    [self wangluo];
    [self daohang];
    // Do any additional setup after loading the view.
}
-(void)daohang{
    //设置导航条属性
    self.navigationController.navigationBar.barTintColor =[UIColor colorWithRed:95/255.0 green:193/255.0 blue:255/255.0 alpha:1];
    self.title  =@"咨询回复";
    UIButton  *backbtn = [[UIButton alloc]initWithFrame:CGRectMake(15,10, 20, 20)];
    [backbtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backbutton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftben = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    self.navigationItem.leftBarButtonItem =leftben;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];

}

-(void)backbutton:(UIButton*)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

-(void)wangluo{
    
     [WarningBox warningBoxModeIndeterminate:@"正在加载中" andView:self.view];
    //拿到存的学校IP和studentId
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    //    [def objectForKey:@"IP"];
    //    [def objectForKey:@"studentId"];
    
    
    //将上传对象转换为json格式字符串
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc]init];
    
    //出入参数：
    //studentid需要传过来
    NSDictionary*datadic=[NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId", nil];
    
    
    NSString *jsonstring =[writer stringWithObject:datadic];
    
    
    NSString *url = [NSString stringWithFormat:@"http://%@/job/intf/mobile/gate.shtml?command=stuadvisorylook",[def objectForKey:@"IP"]];
    
    
    NSDictionary *msg = [NSDictionary dictionaryWithObjectsAndKeys:jsonstring,@"MSG", nil];
    
    [manager POST:url parameters:msg progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @try {
            
            [WarningBox warningBoxHide:YES andView:self.view];
         
            NSArray *array = [responseObject objectForKey:@"stuAdvisoryLookResSimpleDTOs"];
            arr = [[NSMutableArray alloc]init];
            arr1 = [[NSMutableArray alloc]init];
            arr4 = [[NSMutableArray alloc]init];
            arr5 = [[NSMutableArray alloc]init];
            arr2 = [[NSMutableArray alloc]init];
            arr6 = [[NSMutableArray alloc]init];
            for (NSDictionary *aa in array) {
                if ([[aa objectForKey:@"state" ]intValue]==1) {
                    [arr addObject:[aa objectForKey:@"advisoryTitle"]];
                    [arr1 addObject:[aa objectForKey:@"advisoryTime"]];
                    [arr2 addObject:[aa objectForKey:@"stuAdvisoryId"]];
                    
                }else {
                    [arr4 addObject:[aa objectForKey:@"advisoryTitle"]];
                    [arr5 addObject:[aa objectForKey:@"advisoryTime"]];
                    [arr6 addObject:[aa objectForKey:@"stuAdvisoryId"]];
                   
                }
               
            }
            
            [_mytable1 reloadData];


            
            
            
        } @catch (NSException *exception) {
            [WarningBox warningBoxModeText:@"" andView:self.view];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络连接失败！" andView:self.view];
    }];
    
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//segmentcontrol方法
- (IBAction)change:(id)sender {
    UISegmentedControl *cc = (UISegmentedControl *)sender;
    int index = (int)cc.selectedSegmentIndex;
    if (index==0) {
        
        flag=1;
        [_mytable1 reloadData];
    }else {
        
        flag=2;
        [_mytable1 reloadData];
    }
   
}


#pragma mark tableview datasouce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    if (flag==1) {
        return [arr2 count];
    }else {
        return [arr6 count];
    }
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    // _mytable1.separatorStyle=UITableViewCellSeparatorStyleNone;
    // _mytable2.separatorStyle=UITableViewCellSeparatorStyleNone;
   
        
        static  NSString *id1 = @"cell1";
        cell = [tableView dequeueReusableCellWithIdentifier:id1];
        if (cell==nil) {
            cell=  [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id1];
        }
        
         UILabel *ll1 = (UILabel*)[cell.contentView viewWithTag:100];
        ll1.text = @"咨询标题:";
        ll1.font = [UIFont systemFontOfSize:14.0];
        //ll1.textColor=[UIColor blackColor];
        UILabel *ll2 = (UILabel*)[cell.contentView viewWithTag:101];
        ll2.text = @"咨询时间:";
        ll2.font = [UIFont systemFontOfSize:14.0];
        //ll2.textColor=[UIColor blackColor];
        UILabel *l1 = (UILabel*)[cell.contentView viewWithTag:102];
        UILabel *l2 = (UILabel*)[cell.contentView viewWithTag:103];
        l1.font = [UIFont systemFontOfSize:14.0];
        //l1.textColor=[UIColor blackColor];
        //l2.textColor=[UIColor blackColor];
        l2.font = [UIFont systemFontOfSize:14.0];
        [cell.contentView addSubview:ll1];
        [cell.contentView addSubview:ll2];
        [cell.contentView addSubview:l1];
        [cell.contentView addSubview:l2];
        
   cell.backgroundColor = [UIColor clearColor];
    
        
    
    
        if (flag==1){
        
            if (![arr[indexPath.row] isEqual:[NSNull null]]) {
                l1.text = arr[indexPath.row];
                
            }else{
                l1.text = @" ";
            }
            l2.text = arr1[indexPath.row];
        
        
        }else{
            if (![arr4[indexPath.row] isEqual:[NSNull null]]) {
                    l1.text = arr4[indexPath.row];
        
            }else{
                l1.text = @" ";
            }
                l2.text = arr5[indexPath.row];
        
        }
       
   
    
//    for (id suView in cell.contentView.subviews) {//获取当前cell的全部子视图
//        [suView removeFromSuperview];//移除全部子视图
//    }
    
    
       
        return cell;
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [  tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (flag==1){
        [[NSUserDefaults standardUserDefaults]setObject:arr2[indexPath.row] forKey:@"xiangxi"];
        
        NSLog(@"dasdasd-----%@",arr2[indexPath.row]);
       InfoMinuteViewController  *minute = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"minute"];
        [self.navigationController pushViewController:minute animated:YES];
        
    }else {
        [[NSUserDefaults standardUserDefaults]setObject:arr6[indexPath.row] forKey:@"xiangxi"];
       
         NSLog(@"------==--=-=%@",arr6[indexPath.row]);
        InfoMinuteViewController  *minute = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"minute"];
        [self.navigationController pushViewController:minute animated:YES];

    }
    
}

@end
