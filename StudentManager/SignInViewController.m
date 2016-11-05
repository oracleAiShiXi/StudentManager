//
//  SignInViewController.m
//  StudentManager
//
//  Created by newmac on 16/8/3.
//  Copyright © 2016年 newmac. All rights reserved.
//

#import "SignInViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "AFHTTPSessionManager.h"
#import "SBJson.h"
#import "WarningBox.h"

@interface SignInViewController ()<CLLocationManagerDelegate>
{
    UIImagePickerController  *Imgpicker;
    CLLocationManager *_locationManager;
    NSString *filepath;
   
    NSString*sheng;
    NSString*shi;
    NSString*qu;
    NSString*street;
    NSString*jing;
    NSString*wei;
}
@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self phone];//调取相机
    [self  initializeLocationService];//开启定位
    [self daohang];
    
    // Do any additional setup after loading the view.
}
-(void)daohang{
    //设置导航条属性
    self.navigationController.navigationBar.barTintColor =[UIColor colorWithRed:95/255.0 green:193/255.0 blue:255/255.0 alpha:1];
    self.title  =@"签到";
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
   // NSLog(@"经纬度------%@,%@",jing,wei);
    
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
                 shi=[NSString stringWithFormat:@"%@",placemark.locality];
                //区
                 qu=[NSString stringWithFormat:@"%@",placemark.subLocality];
            }
            
        }
        else if (error == nil && [array count] == 0)
        {
           // NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
          //  NSLog(@"An error occurred = %@", error);
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
    
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


//相机
-(void)phone {

    //打开相机
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^{}];
        
    }else
    {

        
        Imgpicker = [[UIImagePickerController alloc] init];
        Imgpicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//相册
        
        Imgpicker.delegate = self;
        //设置选择后的图片可被编辑
        Imgpicker.allowsEditing = YES;
        
        
        
        [self presentViewController:Imgpicker animated:YES completion:nil];
        
        
    }

    
}

- (IBAction)afresh:(id)sender {
    [self phone];
    
}

- (IBAction)upload:(id)sender {
    
    
    if(UIImagePNGRepresentation(_image.image)==nil){
         [WarningBox warningBoxModeText:@"请选择图片！" andView:self.view];
        
    }
    
    else{
    [WarningBox warningBoxModeIndeterminate:@"正在签到" andView:self.view];
    
    //拿到存的学校IP和studentId
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    //    [def objectForKey:@"IP"];
    //    [def objectForKey:@"studentId"];
    
    
    //将上传对象转换为json格式字符串
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc]init];
    
    //出入参数：
  
     NSDictionary*datadic=[NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId",jing,@"longitude",wei,@"latitude",street,@"address", nil];
      //  NSLog(@"%@-------%@--------%@",jing,wei,sheng);
    
    NSString *jsonstring =[writer stringWithObject:datadic];
    
    
    NSString *url = [NSString stringWithFormat:@"http://%@/job/intf/mobile/gate.shtml?command=attup",[def objectForKey:@"IP"]];
       // NSLog(@"the url=------%@",url);
    
    NSDictionary *msg = [NSDictionary dictionaryWithObjectsAndKeys:jsonstring,@"MSG", nil];
    
   [manager POST:url parameters:msg constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
       NSURL *filepa = [NSURL fileURLWithPath:filepath];
       [formData appendPartWithFileURL:filepa name:@"currentImage" error:nil];
   
        } progress:^(NSProgress * _Nonnull uploadProgress) {
       
   } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       @try {
        NSLog(@"\n\n---------\n\n%@",responseObject);
           [WarningBox warningBoxHide:YES andView:self.view];
           if ([[responseObject objectForKey:@"result"] intValue]==0) {
               [WarningBox warningBoxModeText:@"签到成功！" andView:self.view];
               
               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   [self.navigationController popViewControllerAnimated:YES];
               });
           }else{
               [WarningBox warningBoxModeText:@"签到失败，请重试" andView:self.view];
           }
       } @catch (NSException *exception) {
          [WarningBox warningBoxModeText:@"" andView:self.view];
       }
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       [WarningBox warningBoxHide:YES andView:self.view];
       [WarningBox warningBoxModeText:@"网络连接失败！" andView:self.view];
   }];
}
    
}


#pragma mark  相机相册

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
     UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //self.image.image = image;
    NSData  *imgdata = UIImageJPEGRepresentation(image, 0.1);
 
    //图片保存的路径
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //这里将图片放在沙盒的documents下的Image文件夹中
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"];
    
    //把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    //图片名以时间戳的格式存储到目录下
    filepath=[DocumentsPath stringByAppendingString:[NSString stringWithFormat:@"/currentImage.png"]];
    
   [fileManager createFileAtPath:filepath contents:imgdata attributes:nil];
    
    //将图片显示到image上
    UIImage *img = [[UIImage alloc]initWithContentsOfFile:filepath];
    [self.image setImage:img];

   // NSLog(@"%@",NSHomeDirectory());
    
    //关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    

    
}
//取消选择图片
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}



@end
