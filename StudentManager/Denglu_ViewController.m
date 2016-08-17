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
    
    NSMutableArray *Values;

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
    self.fanhui1 = [[UIButton alloc] initWithFrame:CGRectMake(15, 25, 25, 25)];
    [self.fanhui1 setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    self.fanhui1.backgroundColor = [UIColor clearColor];
    [self.fanhui1 addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    //学校名字
    self.xuexiaomingzi = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-100, self.view.frame.size.height/5, 200, 40)];
    self.xuexiaomingzi.textColor = [UIColor whiteColor];
    self.xuexiaomingzi.font = [UIFont systemFontOfSize:40];
    self.xuexiaomingzi.text = self.name;
    self.xuexiaomingzi.adjustsFontSizeToFitWidth = YES;
    self.yingwen.adjustsFontSizeToFitWidth = YES;
    self.yingwen = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-80, self.view.frame.size.height/5+40, 160, 15)];
    self.yingwen.textColor = [UIColor whiteColor];
    self.yingwen.text = @"The name of school";
    [self.view addSubview:self.xuexiaomingzi];
    [self.view addSubview:self.yingwen];
    
    
    //账号
    
    self.zhanghao1.backgroundColor = [UIColor clearColor];
    self.zhanghao1.borderStyle = UITextBorderStyleRoundedRect;
    //self.zhanghao1.layer.cornerRadius = 30.0;
    if (self.view.frame.size.width == 414) {
        self.zhanghao= [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-90, self.view.frame.size.height/3, 250, self.view.frame.size.height/10-10)];
        self.zhanghao1 = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-140, self.view.frame.size.height/3, 280, self.view.frame.size.height/10-10)];
        self.zhanghao1.layer.cornerRadius = 30.0;
        self.mima = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-90, self.view.frame.size.height/3+75, 200, self.view.frame.size.height/10)];
        self.mima1 = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-140, self.view.frame.size.height/3+80, 280, self.view.frame.size.height/10-10)];
        self.mima1.layer.cornerRadius = 30.0;
        self.denglu1 = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-140, self.view.frame.size.height/3+160, 280, self.view.frame.size.height/10-10)];
        self.denglu1.layer.cornerRadius = 30.0;
        self.lijidenglu = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-120, self.view.frame.size.height/3+160, 240, self.view.frame.size.height/10-10)];
        self.checkbox1 = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-40, self.view.frame.size.height/3+240, 80, 20)];
        //self.jizhu = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-5, self.view.frame.size.height/3+240, 60, 25)];

        
        
    }else if(self.view.frame.size.width == 375){
        self.zhanghao= [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-90, self.view.frame.size.height/3, 200, self.view.frame.size.height/10-10)];
        self.zhanghao1 = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-140, self.view.frame.size.height/3, 280, self.view.frame.size.height/10-10)];
        self.zhanghao1.layer.cornerRadius = 28.0;
        self.mima = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-90, self.view.frame.size.height/3+75, 200, self.view.frame.size.height/10)];
        self.mima1 = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-140, self.view.frame.size.height/3+80, 280, self.view.frame.size.height/10-10)];
        self.mima1.layer.cornerRadius = 28.0;
        self.denglu1 = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-140, self.view.frame.size.height/3+160, 280, self.view.frame.size.height/10-10)];
        self.denglu1.layer.cornerRadius = 28.0;
        self.lijidenglu = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-120, self.view.frame.size.height/3+160, 240, self.view.frame.size.height/10-10)];
        self.checkbox1 = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-40, self.view.frame.size.height/3+240, 80, 20)];
        //self.jizhu = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-5, self.view.frame.size.height/3+240, 60, 25)];

        
    }else if(self.view.frame.size.width == 320 && self.view.frame.size.height == 568){
        self.zhanghao= [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-70, self.view.frame.size.height/3, 200, self.view.frame.size.height/10-10)];
        self.zhanghao1 = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-120, self.view.frame.size.height/3, 240, self.view.frame.size.height/10-10)];
        self.zhanghao1.layer.cornerRadius = 22.0;
        self.mima = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-70, self.view.frame.size.height/3+55, 200, self.view.frame.size.height/10)];
        self.mima1 = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-120, self.view.frame.size.height/3+60, 240, self.view.frame.size.height/10-10)];
        self.mima1.layer.cornerRadius = 22.0;
        self.denglu1 = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-120, self.view.frame.size.height/3+120, 240, self.view.frame.size.height/10-10)];
        self.denglu1.layer.cornerRadius = 22.0;
        self.lijidenglu = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-120, self.view.frame.size.height/3+120, 240, self.view.frame.size.height/10-10)];
        self.checkbox1 = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-40, self.view.frame.size.height/3+180, 80, 20)];
        //self.jizhu = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-5, self.view.frame.size.height/3+180, 60, 25)];
        
    }else if(self.view.frame.size.width == 320 && self.view.frame.size.height == 480){
        self.zhanghao= [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-80+5, self.view.frame.size.height/3+5, 250, self.view.frame.size.height/10-10)];
        self.zhanghao1 = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-120, self.view.frame.size.height/3, 240, self.view.frame.size.height/10)];
        self.zhanghao1.layer.cornerRadius = 22.0;
        self.mima = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-80+5, self.view.frame.size.height/3+65, 250, self.view.frame.size.height/10)];
        self.mima1 = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-120, self.view.frame.size.height/3+65, 240, self.view.frame.size.height/10)];
        self.mima1.layer.cornerRadius = 22.0;
        self.denglu1 = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-120, self.view.frame.size.height/3+130, 240, self.view.frame.size.height/10)];
        self.denglu1.layer.cornerRadius = 22.0;
        self.lijidenglu = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-120, self.view.frame.size.height/3+130, 240, self.view.frame.size.height/10)];
        self.checkbox1 = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-40, self.view.frame.size.height/3+195, 80, 20)];
        //self.jizhu = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-5, self.view.frame.size.height/3+190, 60, 25)];
        
    }
    self.zhanghao1.placeholder = @"账号:";
    self.zhanghao1.backgroundColor = [UIColor clearColor];
    self.zhanghao1.borderStyle = UITextBorderStyleRoundedRect;
    self.zhanghao1.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.zhanghao1.layer.borderWidth = 2.0;
    self.zhanghao1.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.zhanghao1.enabled = NO;
    self.zhanghao1.delegate = self;
    
    
    self.zhanghao.backgroundColor = [UIColor clearColor];
    self.zhanghao.textColor = [UIColor whiteColor];
    self.zhanghao.layer.borderColor = [[UIColor clearColor]CGColor];
    self.zhanghao.delegate = self;
    //密码
    
    self.mima1.backgroundColor = [UIColor clearColor];
    self.mima1.borderStyle = UITextBorderStyleRoundedRect;
    
    self.mima1.placeholder = @"密码:";
    self.mima1.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.mima1.layer.borderWidth = 2.0;
    self.mima1.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.mima1.enabled = NO;
    self.mima1.delegate = self;
    
    
    self.mima.textColor = [UIColor whiteColor];
    self.mima.backgroundColor = [UIColor clearColor];
    self.mima.layer.borderColor = [[UIColor clearColor]CGColor];
    self.mima.secureTextEntry = YES;
    self.mima.delegate = self;
    //登录按钮
    
    self.denglu1.borderStyle = UITextBorderStyleRoundedRect;
    
    self.denglu1.enabled = NO;
    self.denglu1.backgroundColor = [UIColor whiteColor];
    
    
    self.lijidenglu.backgroundColor = [UIColor clearColor];
    [self.lijidenglu setTitle:@"立即登录" forState:UIControlStateNormal];
    [self.lijidenglu setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.lijidenglu setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    self.lijidenglu.titleLabel.font = [UIFont systemFontOfSize:24];
    [self.lijidenglu addTarget:self action:@selector(lijidenglu1) forControlEvents:UIControlEventTouchUpInside];
    //记住密码
    
    [self.checkbox1 setImage:[UIImage imageNamed:@"checkbox@2x.png"] forState:UIControlStateNormal];
    [self.checkbox1 setTitle:@"记住密码" forState:UIControlStateNormal];
    _checkbox1.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.checkbox1 setImageEdgeInsets:UIEdgeInsetsMake(1, 0, 0, 60)];
    
    [self.checkbox1 addTarget:self action:@selector(choose) forControlEvents:UIControlEventTouchUpInside];
    //记住密码文本
    
//    self.jizhu.backgroundColor = [UIColor clearColor];
//    self.jizhu.font = [UIFont systemFontOfSize:15];
//    self.jizhu.text = @"记住密码";
//    self.jizhu.textColor = [UIColor whiteColor];
//    self.jizhu.textAlignment = UITextAlignmentCenter;
    
    [self.view addSubview:self.fanhui1];
    [self.view addSubview:self.zhanghao1];
    [self.view addSubview:self.zhanghao];
    [self.view addSubview:self.mima1];
    [self.view addSubview:self.mima];
    [self.view addSubview:self.denglu1];
    [self.view addSubview:self.lijidenglu];
    [self.view addSubview:self.checkbox1];
    //[self.view addSubview:self.jizhu];
    
  
    
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
        [self.checkbox1 setImage:[UIImage imageNamed:@"xuanzhong@2x.png"] forState:UIControlStateNormal];
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
                   
                    //加载省市
                    [self shengshi];
                    [self gerenxixin];
                    //[self presentViewController:zhuye animated:NO completion:nil];
                    
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
        [self.checkbox1 setImage:[UIImage imageNamed:@"xuanzhong@2x.png"] forState:UIControlStateNormal];
    }else{
        [defaults setObject:@"0" forKey:@"zddl"];
        isRemember=NO;
        [self.checkbox1 setImage:[UIImage imageNamed:@"checkbox@2x.png"] forState:UIControlStateNormal];
    }

}

//加载省市
- (void)shengshi{
    
    //拿到学校IP和studentID
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    //    [def objectForKey:@"IP"];
    //    [def objectForKey:@"studentId"];
    
    
    //请求省市列表
    //将上传对象转换为json类型
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    
    
    NSString *url = [NSString stringWithFormat:@"http://%@/job/intf/mobile/gate.shtml?command=procity",[def objectForKey:@"IP"]];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSArray *cityArr = [NSArray arrayWithArray:responseObject[@"cityDTOs"]];
        
        NSArray *provinceArr = [NSArray arrayWithArray:responseObject[@"provinceDTOs"]];
        
        
        //最大的数组，里边包含省市
        NSMutableArray*Array=[[NSMutableArray alloc] init];
        for (int i=0; i<provinceArr.count; i++) {
            //判断这个省中有没有市
            int ss=0;
            //省的字典，包含这个省的所有市、省的id 和省的名字
            NSMutableDictionary*ddsheng=[[NSMutableDictionary alloc] init];
            //这个省里边有多少个市
            NSMutableArray*citys=[[NSMutableArray alloc] init];
            for (int j=0; j<cityArr.count; j++) {
                //市的字典，包含市的id 和市的名字
                NSMutableDictionary* ddcity=[[NSMutableDictionary alloc] init];
                if ([[provinceArr[i] objectForKey:@"provinceId"] isEqual:[cityArr[j] objectForKey:@"provinceId"]] ) {
                    ss=1;
                    [ddcity setValue:[cityArr[j] objectForKey:@"cityId"] forKey:@"cityId"];
                    [ddcity setValue:[cityArr[j] objectForKey:@"cityName"] forKey:@"cityName"];
                    
                    [citys addObject:ddcity];
                }
                
            }
            if (ss==1) {
                [ddsheng setObject:citys forKey:@"citys"];
                [ddsheng setObject:[NSString stringWithFormat:@"%@",[provinceArr[i] objectForKey:@"provinceId"]] forKey:@"provinceId"];
                [ddsheng setObject:[NSString stringWithFormat:@"%@",[provinceArr[i] objectForKey:@"provinceName"]] forKey:@"provinceName"];
                [Array addObject:ddsheng];
            }else{
                NSLog(@"没有对应的城市");
            }
            
        }
        
        //把数据存入plist文件
        NSString *path1=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/province.plist"];
        NSLog(@"NSHomeDirectory()=====%@",NSHomeDirectory());
        
        [Array writeToFile:path1 atomically:YES];
        
        [WarningBox warningBoxHide:YES andView:self.view];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络异常，请重试！" andView:self.view];
        NSLog(@"%@",error);
        
    }];
    
}


-(void)gerenxixin{
    
    //拿到学校IP和studentID
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    //    [def objectForKey:@"IP"];
    //    [def objectForKey:@"studentId"];
    
    //请求学生信息
    //将上传对象转换为json类型
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    
    //上传参数
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId", nil];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSString *jsonstring = [writer stringWithObject:dic];
    
    NSDictionary *MSG = [NSDictionary dictionaryWithObjectsAndKeys:jsonstring,@"MSG", nil];
    NSString *url = [NSString stringWithFormat:@"http://%@/job/intf/mobile/gate.shtml?command=stuinformation",[def objectForKey:@"IP"]];
    
    [manager POST:url parameters:MSG progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        //把返回数据存入可变字典
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:responseObject];
        NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
        
        //将字典里的空指针转化为空字符串
        Values = [[NSMutableArray alloc] init];
        NSString *aa = [[NSString alloc] init];
        for (aa in [dic allValues]) {
            if ([aa isEqual:[NSNull null]]) {
                aa=@"";
            }
            [Values addObject:aa];
        }
        
        NSLog(@"%@",Values);
        
        NSMutableArray *Keys = [[NSMutableArray alloc] init];
        for (NSString *bb in [dic allKeys]) {
            [Keys addObject:bb];
        }
        
        NSLog(@"%@",Keys);
        
        for (int i=0; i<[dic count]; i++) {
            
            [dataDic setValue:Values[i] forKey:Keys[i]];
        }
        
        NSLog(@"data------%@",dataDic);
        
        //把数据存入plist文件
        NSString *path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/userInfo.plist"];
        /// NSLog(@"NSHomeDirectory()=====%@",NSHomeDirectory());
        
        [dataDic writeToFile:path atomically:YES];
        
        [WarningBox warningBoxHide:YES andView:self.view];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        [WarningBox warningBoxHide:YES andView:self.view];
        
        [WarningBox warningBoxModeText:@"网络异常，请重试！" andView:self.view];
        
        NSLog(@"%@",error);
        
    }];

}

@end
