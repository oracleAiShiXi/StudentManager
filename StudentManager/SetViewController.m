//
//  SetViewController.m
//  StudentManager
//
//  Created by newmac on 16/7/29.
//  Copyright © 2016年 newmac. All rights reserved.
//

#import "SetViewController.h"
#import "AdviceViewController.h"
#import "HelpViewController.h"

#import "ViewController.h"

#import "AFHTTPSessionManager.h"
#import "SBJson.h"
@interface SetViewController ()
{
    NSMutableArray *shuju;
    NSMutableArray *attpe;
    NSMutableArray *endtime;
    NSMutableArray *typename;
    NSMutableArray *starttime;
    

}
@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
   
    
    //去掉导航条下方自带分割线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
 
    
    //设置导航条属性
    self.navigationController.navigationBar.barTintColor =[UIColor colorWithRed:95/255.0 green:193/255.0 blue:255/255.0 alpha:1];
    self.title  =@"设置";
    UIButton  *backbtn = [[UIButton alloc]initWithFrame:CGRectMake(15,10, 25, 25)];
    [backbtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backbutton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftben = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    self.navigationItem.leftBarButtonItem =leftben;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    
    [self.mainView.layer setCornerRadius:10];
    [self.quit.layer setCornerRadius:10];
   
    
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backbutton:(UIButton*)btn{

    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
    [self banben];
}
//当前版本信息
-(void)banben {
    
    //拿到存的学校IP和studentId
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
//    [def objectForKey:@"IP"];
//    [def objectForKey:@"studentId"];
    
    
    //将上传对象转换为json格式字符串
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    
    
    NSString *url = [NSString stringWithFormat:@"http://%@/job/intf/mobile/gate.shtml?command=iphone",[def objectForKey:@"IP"]];
    
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @try {
            NSLog(@"%@",responseObject);
            
            //NSLog(@"%@",[responseObject objectForKey:@"programVersion"]);
            _edition.text = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"programVersion"]];
            
            
        } @catch (NSException *exception) {
            NSLog(@"wangluo");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)advice:(id)sender {
    
    AdviceViewController *advice = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"advice"];
    [self.navigationController pushViewController:advice animated:YES];
   
    
}
//使用帮助
- (IBAction)help:(id)sender {
    HelpViewController *help = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"help"];
    [self.navigationController pushViewController:help animated:YES];
  
}
//获取考勤时间
- (IBAction)kqtime:(id)sender {
    
    
    
    //拿到存的学校IP和studentId
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    //    [def objectForKey:@"IP"];
    //    [def objectForKey:@"studentId"];
    
    //将上传对象转换为json格式字符串
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
 
    NSString *url = [NSString stringWithFormat:@"http://%@/job/intf/mobile/gate.shtml?command=atttime",[def objectForKey:@"IP"]];
    
    
     // NSDictionary *msg = [NSDictionary dictionaryWithObjectsAndKeys:jsonstring,@"MSG", nil];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @try {
            NSLog(@"%@",responseObject);
      
            shuju=[NSMutableArray array];
            attpe=[NSMutableArray array];
            endtime=[NSMutableArray array];
            typename=[NSMutableArray array];
            starttime=[NSMutableArray array];
            
            NSDictionary *dic=(NSDictionary *)responseObject;
            NSDictionary *dict=[dic objectForKey:@"attTimeDTOs"];
            for (NSString *dd in dict) {
                [shuju addObject:dd];
            }
            
            for (int i=0; i<2; i++) {
                
                [attpe addObject:[shuju[i]objectForKey:@"attType"]];
                [endtime addObject:[shuju[i]objectForKey:@"endTime"]];
                [starttime addObject:[shuju[i]objectForKey:@"startTime"]];
                [typename addObject:[shuju[i]objectForKey:@"typeName"]];
                
            }
          
            NSLog(@"%@",typename);
            
            NSString *str=[NSString stringWithFormat:@"\r%@:%@-%@\n%@:%@-%@",typename[0],starttime[0],endtime[0],typename[1],starttime[1],endtime[1]];
            
//            NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
//            
//            [def setObject:starttime[0] forKey:@"update1"];
//            [def setObject:starttime[1] forKey:@"update2"];
            
        
            //初始化提示框；
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"考勤时间" message:str preferredStyle:  UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //点击按钮的响应事件；
            }]];
            
            //弹出提示框；
            [self presentViewController:alert animated:true completion:nil];
            
          
            
        } @catch (NSException *exception) {
            NSLog(@"wangluo");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    

  
}


//退出账号
- (IBAction)exit:(id)sender {
  
//    ViewController *view = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"viewc"];
//
//    [self.navigationController popToViewController:view animated:YES];
    [self.navigationController  popToRootViewControllerAnimated:YES];
    
    NSLog(@"退出账号");
}
@end
