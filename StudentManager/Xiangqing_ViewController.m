//
//  Xiangqing_ViewController.m
//  ishixi
//
//  Created by csh on 16/8/5.
//  Copyright © 2016年 csh. All rights reserved.
//

#import "Xiangqing_ViewController.h"
#import "Color+Hex.h"
#import "AFHTTPSessionManager.h"
#import "WarningBox.h"
#import "SBJson.h"
#import "CommonFunc.h"

@interface Xiangqing_ViewController ()<UITextFieldDelegate>
{

}
@end


@implementation Xiangqing_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"通知详情";
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
    //self.view.backgroundColor = [UIColor colorWithHexString:@"5fc1ff"];
    //按钮大小
    int MinWidth=20,MaxHeigth=20;
    //设置导航栏左侧按钮
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, MinWidth, MaxHeigth)];
    [leftBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    //[leftBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc]initWithCustomView: leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [_biankuangview.layer setBorderWidth:1];
    [_biankuangview.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [_biankuangview.layer setCornerRadius:10];
    
    
    self.neirongTextview.delegate  = self;
    self.neirongTextview.editable = NO;

//    self.myTF = [[UITextField alloc] initWithFrame:CGRectMake(30, 84, self.view.frame.size.width-60, self.view.frame.size.height-160)];
//    self.myTF.enabled = NO;
//    self.myTF.backgroundColor = [UIColor clearColor];
//    self.myTF.borderStyle = UITextBorderStyleRoundedRect;
//    self.myTF.layer.cornerRadius = 30.0;
//    self.myTF.layer.borderColor = [[UIColor whiteColor]CGColor];
//    self.myTF.layer.borderWidth = 2.0;
//    self.myTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//    self.myTF.delegate = self;
//    [self.view addSubview:self.myTF];
//    self.xq1 = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-70, 94, 140, 30)];
//    self.xq1.enabled = NO;
//    self.xq1.adjustsFontSizeToFitWidth = YES;
//    self.xq1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    self.xq1.backgroundColor = [UIColor clearColor];
//    self.xq1.font = [UIFont systemFontOfSize:24];
//    self.xq1.textColor = [UIColor whiteColor];
//    [self.view addSubview:self.xq1];
//    
//    self.xq2 = [[UITextView alloc] initWithFrame:CGRectMake(32, 134, self.view.frame.size.width-64, self.view.frame.size.height-190)];
//    //self.xq2.enabled = NO;
//    self.xq2.editable = NO;
//    
//    self.xq2.backgroundColor = [UIColor clearColor];
//    self.xq2.font = [UIFont systemFontOfSize:18];
//    self.xq2.textColor = [UIColor whiteColor];
//    [self.view addSubview:self.xq2];
    
    

    //NSLog(@"%@",self.studentId);
    //NSLog(@"%@",self.noticeId);
    [WarningBox warningBoxModeIndeterminate:@"正在加载中..." andView:self.view];
    
    //拿到学校IP和studentID
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    //    [def objectForKey:@"IP"];
    //    [def objectForKey:@"studentId"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc]init];
    //出入参数：
    NSDictionary*datadic=[NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId",self.noticeId,@"noticeId", nil];
    NSString *jsonstring =[writer stringWithObject:datadic];
   
    NSString *url=[NSString stringWithFormat:@"http://%@/job/intf/mobile/gate.shtml?command=stunoticedetail",[def objectForKey:@"IP"]];
    NSDictionary *msg = [NSDictionary dictionaryWithObjectsAndKeys:jsonstring,@"MSG", nil];
    
    [manager POST:url parameters:msg progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @try {
            [WarningBox warningBoxHide:YES andView:self.view];
            NSLog(@"公告－－%@",responseObject);
            NSString *str1 = [responseObject objectForKey:@"noticeTitle"];
            NSString *str2 = [responseObject objectForKey:@"noticeContent"];
            NSString *str3 = [responseObject objectForKey:@"issueTime"];
            
            self.tongzhiLabel.text = str1;
            self.neirongTextview.text = str2;
            self.shijianLabel.text = str3;
            
        } @catch (NSException *exception) {
            //NSLog(@"网络");
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxTopModeText:@"网络异常，请重试！" andView:self.view];
        //NSLog(@"- -%@",error);
    }];

    


}




-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    return NO;
}
- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
