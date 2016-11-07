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
#import <MessageUI/MessageUI.h>

#import <CoreLocation/CoreLocation.h>
@interface Sos_ViewController()<CLLocationManagerDelegate,MFMessageComposeViewControllerDelegate>
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
    
    
    
    //键盘回收
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];

    
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
               // NSLog(@"sos上报－－%@",responseObject);
               
                if ([[responseObject objectForKey:@"result"] intValue]==0){
                [WarningBox warningBoxModeText:@"上报成功" andView:self.view];
                Zhuye_ViewController *zvc = [[Zhuye_ViewController alloc]init];
                zvc.result2 = self.result;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     [self sendsms];
                    [self.navigationController popViewControllerAnimated:YES];
                });
           
            }
            else{
                [WarningBox warningBoxModeText:@"上报失败 请重试" andView:self.view];
            }
                
            } @catch (NSException *exception) {
                //NSLog(@"网络");
                //[self.navigationController popViewControllerAnimated:YES];
            }
            
        }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //NSLog(@"- -%@",error);
        }];
    }

    
}





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


-(void)sendsms{
    if( [MFMessageComposeViewController canSendText] )// 判断设备能不能发送短信
    {
        MFMessageComposeViewController*picker = [[MFMessageComposeViewController alloc] init];
        // 设置委托
        picker.messageComposeDelegate= self;
        NSUserDefaults*def= [NSUserDefaults standardUserDefaults];
        
        NSRange range = [street rangeOfString:@"@"];
        NSString *addres = [street substringToIndex:range.location];
        // 默认信息内容
       
        NSString *text = [NSString stringWithFormat:@"求助！我在：%@%@%@,我是：%@",jing,wei,addres,[def objectForKey:@"studentName"]];
    
        picker.body = text;
        // 默认收件人(可多个)
       NSString *Ss = [NSString stringWithFormat:@"%@",[def objectForKey:@"teacherPhone"]];
       
       picker.recipients = [NSArray arrayWithObject:Ss];
     
     
        [self presentViewController:picker animated:YES completion:^{}];
        
        }else{
        [WarningBox warningBoxModeText:@" 该设备不能发送应用内SMS消息，请升级设备" andView:self.view];
       //NSLog(@"不支持");
    }
}

#pragma mark MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result){
        case MessageComposeResultCancelled:
           // NSLog(@"取消发送");
            break;
        case MessageComposeResultFailed:
            
           // NSLog(@"发送失败");
            break;
        case MessageComposeResultSent:
          //  NSLog(@"发送成功");
            break;
            
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:^{}];
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
       // NSLog(@"我们找不到你");
    }
    
    
    
}


-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    //将经度显示到label上
    jing = [NSString stringWithFormat:@"%lf", newLocation.coordinate.longitude];
    //将纬度现实到label上
    wei = [NSString stringWithFormat:@"%lf", newLocation.coordinate.latitude];
    // 获取当前所在的城市名
     //NSLog(@"经纬度------%@,%@",jing,wei);
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地 址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            
           // NSLog(@"-------------------------------具体位置%@",placemark);
            
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
           // NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
           // NSLog(@"An error occurred = %@", error);
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
    
}

@end
