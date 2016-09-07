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
#import "RCAnimatedImagesView.h"
@interface Denglu_ViewController ()<UITextFieldDelegate,RCAnimatedImagesViewDelegate>
{
    int flog;
    NSMutableDictionary *Passdic;
    NSString *Rempath;
    //NSUserDefaults *defaults;
    BOOL isRemember;
    
    NSString *SchoolIP;
    
    NSMutableArray *Values;

    NSUserDefaults *def;
    
}
@property (retain, nonatomic) IBOutlet RCAnimatedImagesView* animatedImagesView;
@property (nonatomic)BOOL rcDebug;
@end

@implementation Denglu_ViewController
@synthesize animatedImagesView = _animatedImagesView;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    //解密IP方法
    [self schoolIP];
    
    
    //添加动态图
    self.animatedImagesView = [[RCAnimatedImagesView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    //[self.animatedImagesView addSubview:self.view];
    self.animatedImagesView.delegate = self;
    
   
    
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    

    [self.view addSubview:backview];
    [backview addSubview:self.animatedImagesView];
    [self.view sendSubviewToBack:backview];
    
 
    if([def objectForKey:@"schoolname"]==nil){
        _Eschoolname.text = @"Choose Your School";
        _schoolname.text = @"请选择学校";
    }else{
    self.schoolname.text = [NSString stringWithFormat:@"%@",[def objectForKey:@"schoolname"]];
        _Eschoolname.text = @"The name of the school";
    
    }

    
    [self.queding.layer setBorderWidth:1.0];
    [self.queding.layer setCornerRadius:5.0];
    [self.queding.layer setBorderColor:[[UIColor whiteColor]CGColor]];
    [self.genghuan.layer setBorderWidth:1.0];
    [self.genghuan.layer setCornerRadius:5.0];
    [self.genghuan.layer setBorderColor:[[UIColor whiteColor]CGColor]];
    
    
    self.username.delegate = self;
    self.password.delegate =self;
    self.username.textColor = [UIColor whiteColor];
    self.password.textColor = [UIColor whiteColor];
    [_username setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_username setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    
    [_password setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_password setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    
    
    [self.checkbox1 setImage:[UIImage imageNamed:@"checkbox@2x.png"] forState:UIControlStateNormal];
    [self.checkbox1 setTitle:@"记住密码" forState:UIControlStateNormal];
    _checkbox1.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.checkbox1 setImageEdgeInsets:UIEdgeInsetsMake(1, 0, 0, 60)];
    //[self.checkbox1 addTarget:self action:@selector(choose) forControlEvents:UIControlEventTouchUpInside];
    
    isRemember=NO;
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{self.navigationController.navigationBarHidden=YES;
    [super viewWillAppear:animated];
    [self.animatedImagesView startAnimating];
    if (self.rcDebug) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
   
    
    NSString *isZiDongdenglu =  [def objectForKey:@"zddl"];
    
        if ([isZiDongdenglu  isEqual: @"1"]) {
            isRemember = YES;
            [self.checkbox1 setImage:[UIImage imageNamed:@"xuanzhong@2x.png"] forState:UIControlStateNormal];
            self.username.text = [NSString stringWithFormat:@"%@",[def objectForKey:@"hahahaha"]];
    
            self.password.text = [NSString stringWithFormat:@"%@",[def objectForKey:@"password"]];
    
        }
  
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==_username){
        [_password becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}
#pragma mark-----图片滚动
- (NSUInteger)animatedImagesNumberOfImages:(RCAnimatedImagesView*)animatedImagesView
{
    return 2;
}

- (UIImage*)animatedImagesView:(RCAnimatedImagesView*)animatedImagesView imageAtIndex:(NSUInteger)index
{
    
   return [UIImage imageNamed:@"bizhi"];
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//加载省市
- (void)shengshi{
    
  
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
               // NSLog(@"没有对应的城市");
            }
            
        }
        
        //把数据存入plist文件
        NSString *path1=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/province.plist"];
       // NSLog(@"NSHomeDirectory()=====%@",NSHomeDirectory());
        
        [Array writeToFile:path1 atomically:YES];
        
        [WarningBox warningBoxHide:YES andView:self.view];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络异常，请重试！" andView:self.view];
       // NSLog(@"%@",error);
        
    }];
    
}


//解码学校ip
-(void)schoolIP{

    
    def = [NSUserDefaults standardUserDefaults];
    //base64解码
    NSString *s1 = [CommonFunc textFromBase64String:[def objectForKey:@"scip"]];
    SchoolIP = [CommonFunc textFromBase64String:s1];
    [def setObject:SchoolIP forKey:@"IP"];
    
    
}


- (IBAction)change:(id)sender {
    
    ViewController *view = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"viewc"];
   [self.navigationController pushViewController:view animated:YES];
  
   //[self.navigationController popViewControllerAnimated:YES];
    
   }

- (IBAction)sure:(id)sender {
    if([_schoolname.text isEqualToString:@"请选择学校"]){
     [WarningBox warningBoxModeText:@"请选择学校" andView:self.view];
    }else{
    if([self.username.text isEqualToString:@""]){
                [WarningBox warningBoxModeText:@"请输入用户名!" andView:self.view];
            }
    else if([self.password.text isEqualToString:@""]){
                [WarningBox warningBoxModeText:@"请输入密码!" andView:self.view];
            }
    else{
                [WarningBox warningBoxModeIndeterminate:@"正在登录..." andView:self.view];
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
        
                SBJsonWriter *writer = [[SBJsonWriter alloc]init];
        
                //出入参数：
                NSDictionary*datadic=[NSDictionary dictionaryWithObjectsAndKeys:self.username.text,@"username",self.password.text,@"password",[def objectForKey:@"serial"],@"serial", nil];
            
                NSString *jsonstring =[writer stringWithObject:datadic];
              
        
                NSString *url = [NSString stringWithFormat:@"http://%@/job/intf/mobile/gate.shtml?command=login",[def objectForKey:@"IP"]];
        
    
        
        
        
                NSDictionary *msg = [NSDictionary dictionaryWithObjectsAndKeys:jsonstring,@"MSG", nil];
        
        
                [manager POST:url parameters:msg progress:^(NSProgress * _Nonnull uploadProgress) {
        
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [WarningBox warningBoxHide:YES andView:self.view];
    
        
                    @try {
        
        
                        if ([[responseObject objectForKey:@"result"] intValue]==0) {
        
                            //拿到studentId
                            [[NSUserDefaults standardUserDefaults]setObject:[responseObject objectForKey:@"studentId"] forKey:@"studentId"];
                       
        
                            [WarningBox warningBoxModeText:@"登录成功" andView:self.view];
                        
                            Zhuye_ViewController *zhuye = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"zhuye"];
        
    
                            //加载省市
                            [self shengshi];
                       
               
                            [def setObject:@"1" forKey:@"kkey"];
                            [def setObject:[NSString stringWithFormat:@"%@", self.password.text ] forKey:@"password"];
                            [def setObject:[NSString stringWithFormat:@"%@",self.username.text] forKey:@"hahahaha"];
                            
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
                   //NSLog(@"%@",error);
                }];

            }
    
    }
        
   
}

- (IBAction)rember:(id)sender {
    
    if (isRemember == NO) {
                isRemember = YES;
                [def setObject:@"1" forKey:@"zddl"];
        
        [def setObject:[NSString stringWithFormat:@"%@", self.password.text ] forKey:@"password"];
        [def setObject:[NSString stringWithFormat:@"%@",self.username.text] forKey:@"hahahaha"];
        
                [self.checkbox1 setImage:[UIImage imageNamed:@"xuanzhong@2x.png"] forState:UIControlStateNormal];
            }else{
                [def setObject:@"0" forKey:@"zddl"];
                isRemember=NO;
                [self.checkbox1 setImage:[UIImage imageNamed:@"checkbox@2x.png"] forState:UIControlStateNormal];
            }
    
    
    // NSLog(@"13");
}
@end
