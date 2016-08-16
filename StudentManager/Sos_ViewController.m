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
#import <CoreLocation/CoreLocation.h>
@interface Sos_ViewController()
{
    NSString*street;
    NSString*jing;
    NSString*wei;
     CLLocationManager *_locationManager;
}
@end
@implementation Sos_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initializeLocationService];
    
    self.title = @"紧急情况上报";
    self.navigationController.navigationBar.hidden = NO;
    //设置导航栏的文字大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //设置导航条为透明
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
   // self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"5fc1ff"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"5fc1ff"];
    //按钮大小
    int MinWidth=20,MaxHeigth=20;
    
    //设置导航栏左侧按钮
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, MinWidth, MaxHeigth)];
    [leftBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    //[leftBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc]initWithCustomView: leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [_TextView.layer setCornerRadius:10];
    [_TextView.layer setBorderWidth:1];
    [_TextView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [_tijiaoBtn.layer setCornerRadius:10];
    
    //设置输入文字顶行【有导航栏时】
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    UILabel *l1;
//    UITextField *tf5;
//    self.myTF = [[UITextField alloc] initWithFrame:CGRectMake(50, 80, self.view.frame.size.width-100, self.view.frame.size.height/2)];
//    self.myTV = [[UITextView alloc] initWithFrame:CGRectMake(55, 90, self.view.frame.size.width-110, self.view.frame.size.height/2-10)];
//    if (self.view.frame.size.width == 414){
//        tf5 = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, self.view.frame.size.height/3*2+10, 100, 40)];
//        l1 = [[UILabel alloc] initWithFrame:CGRectMake(50, self.view.frame.size.height/2+90, self.view.frame.size.width-90, 20)];
//
//        
//        self.myBt = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, self.view.frame.size.height/3*2+10, 100, 40)];
//        l1.font = [UIFont systemFontOfSize:15];
//    }else if (self.view.frame.size.width == 375){
//        tf5 = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, self.view.frame.size.height/3*2+10, 100, 40)];
//        self.myBt = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, self.view.frame.size.height/3*2+10, 100, 40)];
//        l1 = [[UILabel alloc] initWithFrame:CGRectMake(50, self.view.frame.size.height/2+90, self.view.frame.size.width-100, 20)];
//        l1.font = [UIFont systemFontOfSize:13];
//        
//    }else if (self.view.frame.size.width == 320 && self.view.frame.size.height == 568){
//        tf5 = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, self.view.frame.size.height/3*2+30, 80, 30)];
//        self.myBt = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, self.view.frame.size.height/3*2+30, 80, 30)];
//        l1 = [[UILabel alloc] initWithFrame:CGRectMake(50, self.view.frame.size.height/2+90, self.view.frame.size.width-100, 20)];
//        l1.font = [UIFont systemFontOfSize:10];
//        
//    }else if (self.view.frame.size.width == 320 && self.view.frame.size.height == 480){
//        tf5 = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, self.view.frame.size.height/3*2+40, 60, 25)];
//        self.myBt = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, self.view.frame.size.height/3*2+40, 60, 25)];
//        l1 = [[UILabel alloc] initWithFrame:CGRectMake(60, self.view.frame.size.height/2+90, self.view.frame.size.width-100, 20)];
//        l1.font = [UIFont systemFontOfSize:9];
//    }

//    self.myTF.backgroundColor = [UIColor clearColor];
//    self.myTF.enabled = NO;
//    self.myTF.borderStyle = UITextBorderStyleRoundedRect;
//    self.myTF.layer.cornerRadius = 8.0;
//    self.myTF.layer.borderColor = [[UIColor whiteColor]CGColor];
//    self.myTF.layer.borderWidth = 2.0;
//    self.myTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//    [self.view addSubview:self.myTF];
    
//    self.myTV.backgroundColor = [UIColor clearColor];
//    self.myTV.font = [UIFont systemFontOfSize:18];
//    self.myTV.textColor = [UIColor whiteColor];
//    [self.view addSubview:self.myTV];
    
    
//    l1.textColor = [UIColor whiteColor];
//    l1.text = @"注:把你的紧急情况进行上报，我们会立马查收!";
//    [self.view addSubview:l1];
//    
//    
//    tf5.backgroundColor = [UIColor clearColor];
//    tf5.textColor = [UIColor whiteColor];
//    tf5.enabled = NO;
//    tf5.borderStyle = UITextBorderStyleRoundedRect;
//    tf5.layer.cornerRadius = 8.0;
//    tf5.layer.borderColor = [[UIColor whiteColor]CGColor];
//    tf5.layer.borderWidth = 2.0;
//    tf5.clearButtonMode = UITextFieldViewModeWhileEditing;
//    [self.view addSubview:tf5];
//    
//    
//    [self.myBt setTitle:@"提交" forState:UIControlStateNormal];
//    [self.myBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.myBt.backgroundColor = [UIColor clearColor];
//    [self.myBt addTarget:self action:@selector(tj) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.myBt];
    
    //键盘回收
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];

    NSLog(@"%@",self.ip);
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"5fc1ff"];
    
}
#pragma mark - button
- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (IBAction)tj:(id)sender {
    
    if([self.TextView.text isEqualToString:@""]){
        [WarningBox warningBoxModeText:@"请输入内容!" andView:self.view];
    }else{
        [WarningBox warningBoxModeIndeterminate:@"正在上报..." andView:self.view];
        
        //拿到学校IP和studentID
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        
        
        //接口
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
        
        SBJsonWriter *writer = [[SBJsonWriter alloc]init];
        //出入参数：
        NSDictionary*datadic=[NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId",jing,@"longitude",wei,@"latitude",street,@"locationinfo",self.TextView.text,@"soscontent", nil];
        
        
        NSString *jsonstring =[writer stringWithObject:datadic];
        NSString *url=[NSString stringWithFormat:@"http://%@/job/intf/mobile/gate.shtml?command=sosup",[def objectForKey:@"IP"]];
        NSDictionary *msg = [NSDictionary dictionaryWithObjectsAndKeys:jsonstring,@"MSG", nil];
        
        [manager POST:url parameters:msg progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [WarningBox warningBoxHide:YES andView:self.view];
            @try {
                //if ([[responseObject objectForKey:@"result"] intValue]==0){
                [WarningBox warningBoxModeText:@"上报成功" andView:self.view];
                
                NSLog(@"上报1－－%@",responseObject);
                NSLog(@"--%@",[responseObject objectForKey:@"soscontent"]);
                //[responseObject setObject:self.myTV.text forKey:@"soscontent"];
                self.result = [responseObject objectForKey:@"result"];
                Zhuye_ViewController *zvc = [[Zhuye_ViewController alloc]init];
                zvc.result2 = self.result;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
                
                
                //}
                
            } @catch (NSException *exception) {
                NSLog(@"网络");
                //[self.navigationController popViewControllerAnimated:YES];
            }
            
        }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //NSLog(@"- -%@",error);
        }];
    }

    
}


//-(void)tj//添加
//{
//    if([self.myTV.text isEqualToString:@""]){
//        [WarningBox warningBoxModeText:@"请输入内容!" andView:self.view];
//    }else{
//        [WarningBox warningBoxModeIndeterminate:@"正在上报..." andView:self.view];
//        
//        //拿到学校IP和studentID
//        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
// 
//        
//    //接口
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
//    
//    SBJsonWriter *writer = [[SBJsonWriter alloc]init];
//    //出入参数：
//     NSDictionary*datadic=[NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId",jing,@"longitude",wei,@"latitude",street,@"locationinfo",self.myTV.text,@"soscontent", nil];
//        
//        
//    NSString *jsonstring =[writer stringWithObject:datadic];
//    NSString *url=[NSString stringWithFormat:@"http://%@/job/intf/mobile/gate.shtml?command=sosup",[def objectForKey:@"IP"]];
//    NSDictionary *msg = [NSDictionary dictionaryWithObjectsAndKeys:jsonstring,@"MSG", nil];
//    
//    [manager POST:url parameters:msg progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [WarningBox warningBoxHide:YES andView:self.view];
//        @try {
//            //if ([[responseObject objectForKey:@"result"] intValue]==0){
//                [WarningBox warningBoxModeText:@"上报成功" andView:self.view];
//                [WarningBox warningBoxHide:YES andView:self.view];
//                NSLog(@"上报1－－%@",responseObject);
//                NSLog(@"--%@",[responseObject objectForKey:@"soscontent"]);
//            //[responseObject setObject:self.myTV.text forKey:@"soscontent"];
//                self.result = [responseObject objectForKey:@"result"];
//                Zhuye_ViewController *zvc = [[Zhuye_ViewController alloc]init];
//                zvc.result2 = self.result;
//                [self.navigationController popViewControllerAnimated:YES];
//            //}
//            
//        } @catch (NSException *exception) {
//            NSLog(@"网络");
//            //[self.navigationController popViewControllerAnimated:YES];
//        }
//    
//    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        //NSLog(@"- -%@",error);
//    }];
//    }
//
//}

#pragma mark - textfield
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    
//    return YES;
//}
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}


#pragma mark - CLLocationManagerDelegate methods 定位

-(void)initializeLocationService{
    
    if ([CLLocationManager locationServicesEnabled]){
        // 初始化定位管理器
        _locationManager = [[CLLocationManager alloc] init];
        // 设置代理
        _locationManager.delegate = self;
        // 设置定位精确度到米
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        // 设置过滤器为无
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        // 开始定位
        // 取得定位权限，有两个方法，取决于你的定位使用情况
        // 一个是requestAlwaysAuthorization，一个是requestWhenInUseAuthorization
        [_locationManager requestAlwaysAuthorization];//这句话ios8以上版本使用。
        [_locationManager startUpdatingLocation];
        
    }else{
        NSLog(@"我们找不到你");
    }
    
    
    
}


-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    //将经度显示到label上
    jing = [NSString stringWithFormat:@"%lf", newLocation.coordinate.longitude];
    //将纬度现实到label上
    wei = [NSString stringWithFormat:@"%lf", newLocation.coordinate.latitude];
    // 获取当前所在的城市名
    // NSLog(@"经纬度------%@,%@",jing,wei);
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地 址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            
            NSLog(@"-------------------------------具体位置%@",placemark);
            
            street = [NSString stringWithFormat:@"%@",placemark];
            
            
            
            //获取城市
            NSString *city = placemark.locality;
            
            if (city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
                //市
                //shi=[NSString stringWithFormat:@"%@",placemark.locality];
                //区
                //qu=[NSString stringWithFormat:@"%@",placemark.subLocality];
            }
            
        }
        else if (error == nil && [array count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
    
}

@end
