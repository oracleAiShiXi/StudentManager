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
#import "Color+Hex.h"
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
    
    _mytable1.separatorStyle=UITableViewCellSeparatorStyleNone;
    _mytable1.backgroundColor=[UIColor colorWithRed:95/255.0 green:193/255.0 blue:255/255.0 alpha:1];
    _mytable1.showsVerticalScrollIndicator = NO;
    _mytable1.dataSource =self;
    _mytable1.delegate  =self;

    flag = 1;
    self.view.backgroundColor = [UIColor colorWithHexString:@"5fc1ff"];
    
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
    
     [WarningBox warningBoxModeIndeterminate:@"正在加载" andView:self.view];
    //拿到存的学校IP和studentId
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
 
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
         
           // NSLog(@"%@",responseObject);
            if  ([[responseObject objectForKey:@"result"] intValue]==0){
            
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

            }
            else{
            [WarningBox warningBoxModeText:@"获取失败，请重试" andView:self.view];
            }
            
            
            
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
    //return 1;
    if (flag==1) {
        return [arr2 count];
    }else {
        return [arr6 count];
    }

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;

  
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UIView *as;
    as = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 5)];
    as.backgroundColor = [UIColor clearColor];
  
    return as;
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 5;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;

    
    
        static  NSString *id1 = @"cell1";
        cell = [tableView dequeueReusableCellWithIdentifier:id1];
        if (cell==nil) {
            cell=  [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id1];
        }
        UIView  *v1 = (UIView*)[cell.contentView viewWithTag:200];
        [v1.layer setCornerRadius:5.0];
        [cell.contentView addSubview:v1];
    
         UILabel *ll1 = (UILabel*)[cell.contentView viewWithTag:100];
        ll1.text = @"咨询标题:";
        ll1.font = [UIFont systemFontOfSize:14.0];
    
//        UILabel *ll2 = (UILabel*)[cell.contentView viewWithTag:101];
//        ll2.text = @"咨询时间:";
//        ll2.font = [UIFont systemFontOfSize:14.0];
    
        UILabel *l1 = (UILabel*)[cell.contentView viewWithTag:101];
        UILabel *l2 = (UILabel*)[cell.contentView viewWithTag:102];
        l1.font = [UIFont systemFontOfSize:14.0];
        l1.adjustsFontSizeToFitWidth = YES;
        l2.font = [UIFont systemFontOfSize:14.0];
    
    UIImageView *img =(UIImageView *)[cell.contentView viewWithTag:201];
    
    
    [v1 addSubview:img];
    [v1 addSubview:ll1];
    [v1 addSubview:l1];
    [v1 addSubview:l2];
    

    
      cell.backgroundColor = [UIColor clearColor];
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    
        if (flag==1){
        
            if (![arr[indexPath.section] isEqual:[NSNull null]]) {
                l1.text = arr[indexPath.section];
                
            }else{
                l1.text = @" ";
            }
            l2.text = arr1[indexPath.section];
        
        
        }else{
            if (![arr4[indexPath.section] isEqual:[NSNull null]]) {
                    l1.text = arr4[indexPath.section];
        
            }else{
                l1.text = @" ";
            }
                l2.text = arr5[indexPath.section];
        
        }
       
 
    
       
        return cell;
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [  tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (flag==1){
        [[NSUserDefaults standardUserDefaults]setObject:arr2[indexPath.section] forKey:@"xiangxi"];
        
        //NSLog(@"dasdasd-----%@",arr2[indexPath.row]);
       InfoMinuteViewController  *minute = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"minute"];
        [self.navigationController pushViewController:minute animated:YES];
        
    }else {
        [[NSUserDefaults standardUserDefaults]setObject:arr6[indexPath.section] forKey:@"xiangxi"];
       
        // NSLog(@"------==--=-=%@",arr6[indexPath.row]);
        InfoMinuteViewController  *minute = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"minute"];
        [self.navigationController pushViewController:minute animated:YES];

    }
    
}

@end
