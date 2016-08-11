//
//  Denglu_ViewController.m
//  ishixi
//
//  Created by csh on 16/7/28.
//  Copyright © 2016年 csh. All rights reserved.
//

#import "Denglu_ViewController.h"
#import "Zhuye_ViewController.h"
#import "Gonggao_ViewController.h"
#import "ViewController.h"
#import "SBJson.h"
#import "CommonFunc.h"
#import "Color+Hex.h"
#import "AFHTTPSessionManager.h"
#import "WarningBox.h"

@interface Denglu_ViewController ()<UITextFieldDelegate>
{
    int flog;
    NSMutableDictionary *Passdic;
    NSString *Rempath;
    NSUserDefaults *defaults;
    BOOL isRemember;
}
@end

@implementation Denglu_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    defaults=[NSUserDefaults standardUserDefaults];
    self.view.backgroundColor = [UIColor colorWithHexString:@"63d5ff"];
    
    self.xuexiaomingzi.text =self.name;
    
    //NSLog(@"--%@",self.xuexiaomingzi.text);
    //NSLog(@"--%@",self.ip);
    //NSLog(@"--%@",self.serial);
    //返回按钮
    self.fanhui1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 40, 40)];
    [self.fanhui1 setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    self.fanhui1.backgroundColor = [UIColor clearColor];
    [self.fanhui1 addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    //学校名字
    self.xuexiaomingzi.textColor = [UIColor whiteColor];
    self.xuexiaomingzi.adjustsFontSizeToFitWidth = YES;
    self.yingwen.adjustsFontSizeToFitWidth = YES;
    //账号
    self.zhanghao1 = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-150, self.view.frame.size.height/3, 300, self.view.frame.size.height/10-10)];
    self.zhanghao1.backgroundColor = [UIColor clearColor];
    self.zhanghao1.borderStyle = UITextBorderStyleRoundedRect;
    self.zhanghao1.layer.cornerRadius = 30.0;
    self.zhanghao1.placeholder = @"账号";
    self.zhanghao1.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.zhanghao1.layer.borderWidth = 2.0;
    self.zhanghao1.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.zhanghao1.enabled = NO;
    self.zhanghao1.delegate = self;
    
    self.zhanghao= [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-100, self.view.frame.size.height/3, 250, self.view.frame.size.height/10-10)];
    self.zhanghao.backgroundColor = [UIColor clearColor];
    self.zhanghao.textColor = [UIColor whiteColor];
    self.zhanghao.layer.borderColor = [[UIColor clearColor]CGColor];
    self.zhanghao.delegate = self;
    //密码
    self.mima1 = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-150, self.view.frame.size.height/3+80, 300, self.view.frame.size.height/10-10)];
    self.mima1.backgroundColor = [UIColor clearColor];
    self.mima1.borderStyle = UITextBorderStyleRoundedRect;
    self.mima1.layer.cornerRadius = 30.0;
    self.mima1.placeholder = @"密码";
    self.mima1.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.mima1.layer.borderWidth = 2.0;
    self.mima1.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.mima1.enabled = NO;
    self.mima1.delegate = self;
    
    self.mima = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-100, self.view.frame.size.height/3+80, 250, self.view.frame.size.height/10-10)];
    self.mima.textColor = [UIColor whiteColor];
    self.mima.backgroundColor = [UIColor clearColor];
    self.mima.layer.borderColor = [[UIColor clearColor]CGColor];
    self.mima.secureTextEntry = YES;
    self.mima.delegate = self;
    //登录按钮
    self.denglu1 = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-150, self.view.frame.size.height/3+160, 300, self.view.frame.size.height/10-10)];
    self.denglu1.borderStyle = UITextBorderStyleRoundedRect;
    self.denglu1.layer.cornerRadius = 30.0;
    self.denglu1.enabled = NO;
    self.denglu1.backgroundColor = [UIColor whiteColor];
    
    self.lijidenglu = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-150, self.view.frame.size.height/3+160, 300, self.view.frame.size.height/10-10)];
    self.lijidenglu.backgroundColor = [UIColor clearColor];
    [self.lijidenglu setTitle:@"立即登录" forState:UIControlStateNormal];
    [self.lijidenglu setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.lijidenglu setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    self.lijidenglu.titleLabel.font = [UIFont systemFontOfSize:24];
    [self.lijidenglu addTarget:self action:@selector(lijidenglu1) forControlEvents:UIControlEventTouchUpInside];
    //记住密码
    self.checkbox1 = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-30, self.view.frame.size.height/3+240, 15, 15)];
    [self.checkbox1 setImage:[UIImage imageNamed:@"mempass.png"] forState:UIControlStateNormal];
    [self.checkbox1 addTarget:self action:@selector(choose) forControlEvents:UIControlEventTouchUpInside];
    //记住密码文本
    self.jizhu = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-15, self.view.frame.size.height/3+240, 60, 15)];
    self.jizhu.backgroundColor = [UIColor clearColor];
    self.jizhu.font = [UIFont systemFontOfSize:12];
    self.jizhu.text = @"记住密码";
    self.jizhu.textColor = [UIColor whiteColor];
    self.jizhu.textAlignment = UITextAlignmentCenter;
    
    [self.view addSubview:self.fanhui1];
    [self.view addSubview:self.zhanghao1];
    [self.view addSubview:self.zhanghao];
    [self.view addSubview:self.mima1];
    [self.view addSubview:self.mima];
    [self.view addSubview:self.denglu1];
    [self.view addSubview:self.lijidenglu];
    [self.view addSubview:self.checkbox1];
    [self.view addSubview:self.jizhu];
    
  
    
    //键盘回收
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    
    
    isRemember=NO;

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    NSString *isZiDongdenglu =  [defaults objectForKey:@"zddl"];
    
    if ([isZiDongdenglu  isEqual: @"1"]) {
        isRemember = YES;
        [self.checkbox1 setImage:[UIImage imageNamed:@"mempass-1.png"] forState:UIControlStateNormal];
        self.zhanghao.text = [NSString stringWithFormat:@"%@",[defaults objectForKey:@"hahahaha"]];
        
        self.mima.text = [NSString stringWithFormat:@"%@",[defaults objectForKey:@"password"]];

    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark - button

- (void)fanhui
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)lijidenglu1 {
    [self.view endEditing:YES];
    if([self.zhanghao.text isEqualToString:@""]){
        [WarningBox warningBoxModeText:@"请输入用户名!" andView:self.view];
    }else if([self.mima.text isEqualToString:@""]){
        [WarningBox warningBoxModeText:@"请输入密码!" andView:self.view];
    }else{
        [WarningBox warningBoxModeIndeterminate:@"正在登录..." andView:self.view];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
        
        SBJsonWriter *writer = [[SBJsonWriter alloc]init];
        
        //出入参数：
        NSDictionary*datadic=[NSDictionary dictionaryWithObjectsAndKeys:self.zhanghao.text,@"username",self.mima.text,@"password",self.serial,@"serial", nil];
        //NSLog(@"%@--%@",self.zhanghao.text,self.mima.text);
        NSString *jsonstring =[writer stringWithObject:datadic];
        //base64解码
        NSString *s1 = [CommonFunc textFromBase64String:self.ip];
        NSString *s2 = [CommonFunc textFromBase64String:s1];

        NSString *url = [NSString stringWithFormat:@"http://%@/job/intf/mobile/gate.shtml?command=login",s2];
     
        
        //拿到学校IP
        [[NSUserDefaults standardUserDefaults]setObject:s2 forKey:@"IP"];
      
     
        
        NSDictionary *msg = [NSDictionary dictionaryWithObjectsAndKeys:jsonstring,@"MSG", nil];
        
        
        [manager POST:url parameters:msg progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [WarningBox warningBoxHide:YES andView:self.view];
           // NSLog(@"%@",responseObject);
            NSString *studentId = [responseObject objectForKey:@"studentId"];
            //NSLog(@"%@",studentId);

            @try {

                
                if ([[responseObject objectForKey:@"result"] intValue]==0) {
                    
                    //拿到studentId
                    [[NSUserDefaults standardUserDefaults]setObject:[responseObject objectForKey:@"studentId"] forKey:@"studentId"];
                  
                    
                    [WarningBox warningBoxModeText:@"登录成功" andView:self.view];
                    [defaults setObject:[NSString stringWithFormat:@"%@", self.mima.text ] forKey:@"password"];
                    [defaults setObject:[NSString stringWithFormat:@"%@",_zhanghao.text] forKey:@"hahahaha"];
                    Zhuye_ViewController *zhuye = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"zhuye"];
//                    zhuye.studentId = studentId;
//                    zhuye.ip = self.ip;
                    [self.navigationController pushViewController:zhuye animated:YES];
                }else{
                    
                    [WarningBox warningBoxModeText:@"登录失败,用户名或密码不正确!" andView:self.view];
                }

            } @catch (NSException *exception) {
                [WarningBox warningBoxModeText:@"请仔细检查您的网络!" andView:self.view];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [WarningBox warningBoxHide:YES andView:self.view];
            [WarningBox warningBoxModeText:@"网络连接失败!" andView:self.view];
           // NSLog(@"%@",error);
        }];


    }
}

-(void)choose//记住密码
{
    [self.view endEditing:YES];
    if (isRemember == NO) {
        isRemember = YES;
        [defaults setObject:@"1" forKey:@"zddl"];
        [self.checkbox1 setImage:[UIImage imageNamed:@"mempass-1.png"] forState:UIControlStateNormal];
    }else{
        [defaults setObject:@"0" forKey:@"zddl"];
        isRemember=NO;
        [self.checkbox1 setImage:[UIImage imageNamed:@"mempass.png"] forState:UIControlStateNormal];
    }

}

@end
