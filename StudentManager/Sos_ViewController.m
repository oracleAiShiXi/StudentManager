//
//  Sos_ViewController.m
//  ishixi
//
//  Created by csh on 16/8/9.
//  Copyright © 2016年 csh. All rights reserved.
//

#import "Sos_ViewController.h"
#import "Color+Hex.h"
#import "CommonFunc.h"
#import "WarningBox.h"
#import "SBJson.h"
#import "AFHTTPSessionManager.h"
#import "Zhuye_ViewController.h"

@implementation Sos_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"紧急情况上报";
    self.navigationController.navigationBar.hidden = NO;
    //设置导航栏的文字大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //设置导航条为透明
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"5fc1ff"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"5fc1ff"];
    //按钮大小
    int MinWidth=20,MaxHeigth=20;
    
    //设置导航栏左侧按钮
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, MinWidth, MaxHeigth)];
    [leftBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc]initWithCustomView: leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.myTF = [[UITextField alloc] initWithFrame:CGRectMake(50, 80, self.view.frame.size.width-100, self.view.frame.size.height/2)];
    self.myTF.backgroundColor = [UIColor clearColor];
    self.myTF.enabled = NO;
    self.myTF.borderStyle = UITextBorderStyleRoundedRect;
    self.myTF.layer.cornerRadius = 8.0;
    self.myTF.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.myTF.layer.borderWidth = 2.0;
    self.myTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.myTF];
    
    self.myTV = [[UITextView alloc] initWithFrame:CGRectMake(55, 90, self.view.frame.size.width-110, self.view.frame.size.height/2-10)];
    self.myTV.backgroundColor = [UIColor clearColor];
    self.myTV.font = [UIFont systemFontOfSize:18];
    self.myTV.textColor = [UIColor whiteColor];
    [self.view addSubview:self.myTV];
    
    UILabel *l1 = [[UILabel alloc] initWithFrame:CGRectMake(50, self.view.frame.size.height/2+90, self.view.frame.size.width-100, 20)];
    l1.textColor = [UIColor whiteColor];
    l1.text = @"注:把你的紧急情况进行上报，我们会立马查收!";
    l1.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:l1];
    
    UITextField *tf5 = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, self.view.frame.size.height/3*2, 100, 40)];
    tf5.backgroundColor = [UIColor clearColor];
    tf5.textColor = [UIColor whiteColor];
    tf5.enabled = NO;
    tf5.borderStyle = UITextBorderStyleRoundedRect;
    tf5.layer.cornerRadius = 8.0;
    tf5.layer.borderColor = [[UIColor whiteColor]CGColor];
    tf5.layer.borderWidth = 2.0;
    tf5.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:tf5];
    
    self.myBt = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, self.view.frame.size.height/3*2, 100, 40)];
    [self.myBt setTitle:@"提交" forState:UIControlStateNormal];
    [self.myBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.myBt.backgroundColor = [UIColor clearColor];
    [self.myBt addTarget:self action:@selector(tj) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.myBt];
    
    //键盘回收
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];

    NSLog(@"%@",self.ip);
}
#pragma mark - button
- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)tj//添加
{
    if([self.myTV.text isEqualToString:@""]){
        [WarningBox warningBoxModeText:@"请输入内容!" andView:self.view];
    }else{
        [WarningBox warningBoxModeIndeterminate:@"正在上报..." andView:self.view];
        
        //拿到学校IP和studentID
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        //    [def objectForKey:@"IP"];
        //    [def objectForKey:@"studentId"];
        
        
    //接口
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc]init];
    //出入参数：
    NSDictionary*datadic=[NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId",self.longitude,@"longitude",self.latitude,@"latitude",self.locationinfo,@"locationinfo",self.myTV.text,@"soscontent", nil];
    NSString *jsonstring =[writer stringWithObject:datadic];
    NSString *url=[NSString stringWithFormat:@"http://%@/job/intf/mobile/gate.shtml?command=sosup",[def objectForKey:@"studentId"]];
    NSDictionary *msg = [NSDictionary dictionaryWithObjectsAndKeys:jsonstring,@"MSG", nil];
    
    [manager POST:url parameters:msg progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [WarningBox warningBoxHide:YES andView:self.view];
        @try {
            if ([[responseObject objectForKey:@"result"] intValue]==0){
                [WarningBox warningBoxModeText:@"上报成功" andView:self.view];
                [WarningBox warningBoxHide:YES andView:self.view];
                NSLog(@"上报1－－%@",responseObject);
                NSLog(@"--%@",[responseObject objectForKey:@"soscontent"]);
            //[responseObject setObject:self.myTV.text forKey:@"soscontent"];
                self.result = [responseObject objectForKey:@"result"];
                Zhuye_ViewController *zvc = [[Zhuye_ViewController alloc]init];
                zvc.result2 = self.result;
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } @catch (NSException *exception) {
            
            
            NSLog(@"网络");
            
            //[self.navigationController popViewControllerAnimated:YES];
            
        }
        
        
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //NSLog(@"- -%@",error);
    }];
    }

}

#pragma mark - textfield
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}

@end
