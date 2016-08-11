//
//  Shangbao_ViewController.m
//  ishixi
//
//  Created by csh on 16/8/5.
//  Copyright © 2016年 csh. All rights reserved.
//

#import "Shangbao_ViewController.h"
#import "Color+Hex.h"
#import "WarningBox.h"
#import "CommonFunc.h"
#import "SBJson.h"
#import "AFHTTPSessionManager.h"
#import "Zhuye_ViewController.h"

@interface Shangbao_ViewController() <UITextFieldDelegate>
{
    int advisoryType;
}

@end



@implementation Shangbao_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    advisoryType = 2;
    
    self.title = @"咨询上报";
    self.navigationController.navigationBar.hidden = NO;
    //设置导航栏的文字大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //设置导航条为透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"5fc1ff"];
    //按钮大小
    int MinWidth=20,MaxHeigth=20;
    //设置导航栏左侧按钮
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, MinWidth, MaxHeigth)];
    [leftBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc]initWithCustomView: leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UILabel *l1 = [[UILabel alloc] initWithFrame:CGRectMake(60, self.view.frame.size.height/8+10, 100, 40)];
    l1.text = @"咨询类型:";
    l1.textColor = [UIColor whiteColor];
    l1.font = [UIFont boldSystemFontOfSize:20];
    l1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:l1];
    self.b1 = [[UIButton alloc] initWithFrame:CGRectMake(180, self.view.frame.size.height/8+20, 15, 15)];
    [self.b1 setImage:[UIImage imageNamed:@"mempass.png"] forState:UIControlStateNormal];
    self.b1.backgroundColor = [UIColor clearColor];
    [self.b1 addTarget:self action:@selector(anniu1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.b1];
    UILabel *l2 = [[UILabel alloc] initWithFrame:CGRectMake(200, self.view.frame.size.height/8+10, 50, 40)];
    l2.text = @"实习";
    l2.textColor = [UIColor whiteColor];
    l2.font = [UIFont boldSystemFontOfSize:20];
    l2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:l2];
    self.b2 = [[UIButton alloc] initWithFrame:CGRectMake(280, self.view.frame.size.height/8+20, 15, 15)];
    [self.b2 setImage:[UIImage imageNamed:@"mempass.png"] forState:UIControlStateNormal];
    self.b2.backgroundColor = [UIColor clearColor];
    [self.b2 addTarget:self action:@selector(anniu2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.b2];

    UILabel *l3 = [[UILabel alloc] initWithFrame:CGRectMake(300, self.view.frame.size.height/8+10, 50, 40)];
    l3.text = @"就业";
    l3.textColor = [UIColor whiteColor];
    l3.font = [UIFont boldSystemFontOfSize:20];
    l3.backgroundColor = [UIColor clearColor];
    [self.view addSubview:l3];
    UILabel *l4 = [[UILabel alloc] initWithFrame:CGRectMake(50, self.view.frame.size.height/8+85, 50, 30)];
    l4.text = @"标题";
    l4.textColor = [UIColor whiteColor];
    l4.font = [UIFont boldSystemFontOfSize:20];
    l4.backgroundColor = [UIColor clearColor];
    [self.view addSubview:l4];
    UITextField *tf1 = [[UITextField alloc] initWithFrame:CGRectMake(100, self.view.frame.size.height/8+80, self.view.frame.size.width-150, 50)];
    tf1.backgroundColor = [UIColor clearColor];
    tf1.textColor = [UIColor whiteColor];
    tf1.enabled = NO;
    tf1.borderStyle = UITextBorderStyleRoundedRect;
    tf1.layer.cornerRadius = 8.0;
    tf1.layer.borderColor = [[UIColor whiteColor]CGColor];
    tf1.layer.borderWidth = 2.0;
    tf1.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:tf1];
    self.biaoti = [[UITextField alloc] initWithFrame:CGRectMake(100+5, self.view.frame.size.height/8+80, self.view.frame.size.width-150, 50)];
    self.biaoti.clearsOnBeginEditing = NO;
    self.biaoti.backgroundColor = [UIColor clearColor];
    self.biaoti.textColor = [UIColor whiteColor];
    [self.view addSubview:self.biaoti];
    UILabel *l5 = [[UILabel alloc] initWithFrame:CGRectMake(50, self.view.frame.size.height/8+165, 50, 30)];
    l5.text = @"内容";
    l5.textColor = [UIColor whiteColor];
    l5.font = [UIFont boldSystemFontOfSize:20];
    l5.backgroundColor = [UIColor clearColor];
    [self.view addSubview:l5];
    UITextField *tf2 = [[UITextField alloc] initWithFrame:CGRectMake(100, self.view.frame.size.height/8+160, self.view.frame.size.width-150, 250)];
    tf2.backgroundColor = [UIColor clearColor];
    tf2.textColor = [UIColor whiteColor];
    tf2.enabled = NO;
    tf2.borderStyle = UITextBorderStyleRoundedRect;
    tf2.layer.cornerRadius = 10.0;
    tf2.layer.borderColor = [[UIColor whiteColor]CGColor];
    tf2.layer.borderWidth = 2.0;
    tf2.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:tf2];
    self.neirong = [[UITextView alloc] initWithFrame:CGRectMake(100+5, self.view.frame.size.height/8+160, self.view.frame.size.width-150, 250)];
    self.neirong.backgroundColor = [UIColor clearColor];
    //再次编辑textview不清空
    self.neirong.font = [UIFont systemFontOfSize:18];
    self.neirong.textColor = [UIColor whiteColor];
    [self.view addSubview:self.neirong];
    
    
    UITextField *tf5 = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, self.view.frame.size.height/3*2+100, 100, 40)];
    tf5.backgroundColor = [UIColor clearColor];
    tf5.textColor = [UIColor whiteColor];
    tf5.enabled = NO;
    tf5.borderStyle = UITextBorderStyleRoundedRect;
    tf5.layer.cornerRadius = 8.0;
    tf5.layer.borderColor = [[UIColor whiteColor]CGColor];
    tf5.layer.borderWidth = 2.0;
    tf5.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:tf5];
    
    self.tijiao = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, self.view.frame.size.height/3*2+100, 100, 40)];
    [self.tijiao setTitle:@"提交" forState:UIControlStateNormal];
    [self.tijiao setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.tijiao.backgroundColor = [UIColor clearColor];
    [self.tijiao addTarget:self action:@selector(tj) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.tijiao];
    
    //键盘回收
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    
    
    //NSLog(@"%@--%@",self.ip,self.studentId);
    
}
#pragma mark - button
- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)anniu1
{
        [self.b1 setImage:[UIImage imageNamed:@"mempass-1.png"] forState:UIControlStateNormal];
        [self.b2 setImage:[UIImage imageNamed:@"mempass.png"] forState:UIControlStateNormal];
    advisoryType = 0;
    //NSLog(@"---%d",advisoryType);


}
-(void)anniu2
{
    
        [self.b1 setImage:[UIImage imageNamed:@"mempass.png"] forState:UIControlStateNormal];
        [self.b2 setImage:[UIImage imageNamed:@"mempass-1.png"] forState:UIControlStateNormal];
    advisoryType = 1;

}
-(void)tj//添加
{
    //获取textfield和textview中的text，传到字典中就好了
    NSLog(@"%@--%@--%@--%d",self.biaoti.text,self.neirong.text,self.studentId,advisoryType);
    if (advisoryType != 0 && advisoryType != 1){
        [WarningBox warningBoxModeText:@"请选择咨询类型!" andView:self.view];
        
    }else if([self.biaoti.text isEqualToString:@""]){
        [WarningBox warningBoxModeText:@"请输入标题!" andView:self.view];
    }else if([self.neirong.text isEqualToString:@""]){
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
    //NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@", _studentId ],@"studentId",[NSString stringWithFormat:@"%@",self.biaoti.text],@"advisoryTitle",[NSString stringWithFormat:@"%@",self.neirong.text],@"advisoryContent",[NSString stringWithFormat:@"%d",advisoryType],@"advisoryType", nil];
        
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId",[NSString stringWithFormat:@"%@",self.biaoti.text],@"advisoryTitle",[NSString stringWithFormat:@"%@",self.neirong.text],@"advisoryContent",[NSString stringWithFormat:@"%d",advisoryType],@"advisoryType", nil];
        
        
        NSLog(@"\n\n\nxiaolang\n\n\n%@",datadic);
    NSString *jsonstring =[writer stringWithObject:datadic];
   
    NSString *url = [NSString stringWithFormat:@"http://%@/job/intf/mobile/gate.shtml?command=stuadvisoryup",[def objectForKey:@"IP"]];
    NSDictionary *msg = [NSDictionary dictionaryWithObjectsAndKeys:jsonstring,@"MSG", nil];
    
    [manager POST:url parameters:msg progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [WarningBox warningBoxHide:YES andView:self.view];
        NSLog(@"上报1－－%@",responseObject);
        @try {
            if ([[responseObject objectForKey:@"result"] intValue] == 0){
                [WarningBox warningBoxModeText:@"上报成功" andView:self.view];


                [WarningBox warningBoxHide:YES andView:self.view];
                self.result = [responseObject objectForKey:@"result"];

                NSLog(@"---%@--%@--%@--%@",[responseObject objectForKey:@"advisoryTitle"],[responseObject objectForKey:@"advisoryContent"],[responseObject objectForKey:@"advisoryType"],[responseObject objectForKey:@"studentId"]);
                Zhuye_ViewController *zvc = [[Zhuye_ViewController alloc]init];
                zvc.result1 = self.result;
                [self.navigationController popViewControllerAnimated:YES];


            }

        } @catch (NSException *exception) {
            if ([self.biaoti.text isEqualToString:@"(null)"] || [self.neirong.text isEqualToString:@"(null)"]) {
                
                self.biaoti.text = @"";
                self.neirong.text = @"";
                
            }

            NSLog(@"上报2－－%@",responseObject);
            NSLog(@"网络");
            
            
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"- -%@",error);
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
