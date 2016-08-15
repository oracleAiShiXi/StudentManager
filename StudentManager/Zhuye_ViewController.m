//
//  Zhuye_ViewController.m
//  ishixi
//
//  Created by csh on 16/7/29.
//  Copyright © 2016年 csh. All rights reserved.
//

#import "Zhuye_ViewController.h"
#import "Sos_ViewController.h"
#import "Gonggao_ViewController.h"
#import "Shangbao_ViewController.h"
#import "SetViewController.h"
#import "SignInViewController.h"
#import "InfoRevertViewController.h"
#import "Tianqi.h"
#import <CoreLocation/CoreLocation.h>
#import "Color+Hex.h"
#import "SBJson.h"
#import "AFNetworking.h"
#import "WarningBox.h"
#import "Gerenxinxi.h"
@interface Zhuye_ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation Zhuye_ViewController
{
    UIView *gx1;
    UIView *gx2;
    UIView *gx3;

    UIButton *button;
    UIImageView *imageview;
    NSMutableArray *array;
    int flog;
    NSMutableArray *Values;

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
   
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-2.png"]];
    
    
    imageView.frame = self.view.bounds;
    
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:imageView];
        
    self.view1.backgroundColor = [UIColor whiteColor];
    
    self.view1.layer.cornerRadius = 5.0;
    
    self.view1.alpha = 0.7;
    
    [self.view addSubview:self.view1];
    if (self.view.frame.size.width == 414){
        self.sos = [[UIButton alloc] initWithFrame:CGRectMake(240, 10, 60, 30)];
        self.tianqi = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 60, 60)];
        self.dingwei = [[UIImageView alloc]initWithFrame:CGRectMake(200, 150, 12, 18)];
        self.wendu = [[UILabel alloc] initWithFrame:CGRectMake(220, 90, 70, 50)];
        self.xingqi = [[UILabel alloc]initWithFrame:CGRectMake(220, 150, 70, 20)];
        self.wendu.font = [UIFont systemFontOfSize:40];
        self.xingqi.font = [UIFont systemFontOfSize:15];


        
    }else if (self.view.frame.size.width == 375){
        self.sos = [[UIButton alloc] initWithFrame:CGRectMake(230, 10, 45, 20)];
        self.tianqi = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 60, 60)];
        self.dingwei = [[UIImageView alloc]initWithFrame:CGRectMake(200, 150, 12, 18)];
        self.wendu = [[UILabel alloc] initWithFrame:CGRectMake(220, 90, 70, 50)];
        self.xingqi = [[UILabel alloc]initWithFrame:CGRectMake(220, 150, 70, 20)];
        self.wendu.font = [UIFont systemFontOfSize:40];
        self.xingqi.font = [UIFont systemFontOfSize:15];
        
    }else if (self.view.frame.size.width == 320 && self.view.frame.size.height == 568){
        
        self.sos = [[UIButton alloc] initWithFrame:CGRectMake(170, 10, 40, 20)];
        self.tianqi = [[UIImageView alloc] initWithFrame:CGRectMake(70, 100, 50, 50)];
        self.dingwei = [[UIImageView alloc]initWithFrame:CGRectMake(150, 160, 12, 18)];
        self.wendu = [[UILabel alloc] initWithFrame:CGRectMake(180, 100, 50, 30)];
        self.xingqi = [[UILabel alloc]initWithFrame:CGRectMake(180, 160, 50, 10)];
        self.wendu.font = [UIFont systemFontOfSize:30];
        self.xingqi.font = [UIFont systemFontOfSize:10];

    }else if (self.view.frame.size.width == 320 && self.view.frame.size.height == 480){
        
        self.sos = [[UIButton alloc] initWithFrame:CGRectMake(180, 10, 35, 18)];

    }
    self.wendu.adjustsFontSizeToFitWidth = YES;
    self.xingqi.adjustsFontSizeToFitWidth = YES;
    self.tianqi.backgroundColor = [UIColor clearColor];
    self.dingwei.backgroundColor = [UIColor clearColor];
    self.wendu.backgroundColor = [UIColor clearColor];
    self.wendu.textColor = [UIColor whiteColor];
    self.xingqi.backgroundColor = [UIColor clearColor];
    self.xingqi.textColor = [UIColor whiteColor];
    [self.view addSubview:self.tianqi];
    [self.view addSubview:self.dingwei];
    [self.view addSubview:self.wendu];
    [self.view addSubview:self.xingqi];
    [self.sos setImage:[UIImage imageNamed:@"anniu_03.png"] forState:UIControlStateNormal];
    [self.sos setImage:[UIImage imageNamed:@"anniu_03.png"] forState:UIControlStateHighlighted];
    [self.sos addTarget:self action:@selector(sos:) forControlEvents:UIControlEventTouchUpInside];
    [self.view1 addSubview:self.sos];
    
    
    
    //图标
    [self.dingwei setImage:[UIImage imageNamed:@"dingwei_03.png"]];
    
    [self initializeLocationService];

    gx1 = [[UIView alloc] initWithFrame:CGRectMake(60, self.view1.frame.size.height*1.6, self.view1.frame.size.width-50, 1)];
    gx1.backgroundColor = [UIColor blackColor];
    
    gx2 = [[UIView alloc] initWithFrame:CGRectMake(60, self.view1.frame.size.height*2.5, self.view1.frame.size.width-50, 1)];
    gx2.backgroundColor = [UIColor blackColor];
    
    
    gx3 = [[UIView alloc] initWithFrame:CGRectMake(self.view1.frame.size.width/1.5, 130, 1, 270)];
    gx3.backgroundColor = [UIColor blackColor];
    
    

    self.geju.backgroundColor = [UIColor clearColor];
    self.arr = [[NSMutableArray alloc] initWithCapacity:6];
    self.arr1 = [[NSMutableArray alloc] initWithCapacity:6];

    for (int i =1; i<7; i++) {
        [self.arr addObject:[UIImage imageNamed:[[NSString alloc] initWithFormat:@"anniu_%d.png",i ]]];
    }
    for (int j = 1; j<7; j++) {
        [self.arr1 addObject:[UIImage imageNamed:[[NSString alloc]initWithFormat:@"bianse-anniu_%d.png",j]]];
    }
    
    array = [[NSMutableArray alloc] initWithObjects:@"一键签到",@"公告",@"信息上报",@"个人信息",@"信息回复",@"设置",nil];
    
    flog =0;
    //NSLog(@"studentID--%@",self.studentId);
    //NSLog(@"ip-----%@",self.ip);
    [self.geju reloadData];
    
    
    
    //天气
    //创建并初始化locationManager属性
    self.locationManager = [[CLLocationManager alloc] init];
    //定位服务委托对象为self
    self.locationManager.delegate = self;
    //设置精确属性，精度越高耗电越大
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    //设置distanceFilter属性，距离过滤器
    self.locationManager.distanceFilter = 1000.0f;
    //授权
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    
    //NSLog(@"%@",self.locationinfo);
        // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    

    
   [self.navigationController setNavigationBarHidden:YES animated:YES];
    //NSLog(@"result1---%@",self.result1);
    //NSLog(@"result2---%@",self.result2);
    [super viewWillAppear:animated];
    //开始定位
    [self.locationManager startUpdatingLocation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
        
    [super viewWillDisappear:animated];
    //结束定位
    [self.locationManager stopUpdatingLocation];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - collectinview


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * CellIdentifier = @"GradientCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    UILabel *ll;
    
    if (self.view.frame.size.width == 414) {
        imageview = [[UIImageView alloc]initWithFrame:CGRectMake((cell.frame.size.width)/2-25, (cell.frame.size.height)/2-30, 50, 50)];
        ll = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-(cell.frame.size.height)/2+20,cell.frame.size.width , (cell.frame.size.height)/2-20)];
        ll.font = [UIFont systemFontOfSize:16];
        
    }else if (self.view.frame.size.width == 375){
        
        imageview = [[UIImageView alloc]initWithFrame:CGRectMake((cell.frame.size.width)/2-25, (cell.frame.size.height)/2-30, 50, 50)];
        ll = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-(cell.frame.size.height)/2+20,cell.frame.size.width , (cell.frame.size.height)/2-20)];
        ll.font = [UIFont systemFontOfSize:16];
        
    }else if (self.view.frame.size.width == 320 && self.view.frame.size.height == 568){
        imageview = [[UIImageView alloc]initWithFrame:CGRectMake((cell.frame.size.width)/2-15, 20, 30, 30)];
        ll = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-(cell.frame.size.height)/2+20,cell.frame.size.width , (cell.frame.size.height)/2-20)];
        ll.font = [UIFont systemFontOfSize:11];
        
    }else if (self.view.frame.size.width == 320 && self.view.frame.size.height == 480){
        imageview = [[UIImageView alloc]initWithFrame:CGRectMake((cell.frame.size.width)/2-10, 5, 25, 25)];
        ll = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-(cell.frame.size.height)/2+20,cell.frame.size.width , (cell.frame.size.height)/2-40)];
        ll.font = [UIFont systemFontOfSize:9];
        
    }


    

    

    if (flog == 0) {
        
   imageview.image = [self.arr objectAtIndex:indexPath.row];
    ll.text = [array objectAtIndex:indexPath.row];
    ll.textAlignment = NSTextAlignmentCenter;
    ll.textColor =[UIColor colorWithHexString:@"483D8B"];
    cell.backgroundColor = [UIColor clearColor];
    }
    [cell.contentView addSubview:imageview];
    [cell.contentView addSubview:ll];
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.geju.frame.size.width-30)/2, (self.geju.frame.size.height-50)/3);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    UILabel *ll;
    if (self.view.frame.size.width == 414) {
        imageview = [[UIImageView alloc]initWithFrame:CGRectMake((cell.frame.size.width)/2-25, (cell.frame.size.height)/2-30, 50, 50)];
        ll = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-(cell.frame.size.height)/2+20,cell.frame.size.width , (cell.frame.size.height)/2-20)];
        ll.font = [UIFont systemFontOfSize:16];
        
    }else if (self.view.frame.size.width == 375){
        
        imageview = [[UIImageView alloc]initWithFrame:CGRectMake((cell.frame.size.width)/2-25, (cell.frame.size.height)/2-30, 50, 50)];
        ll = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-(cell.frame.size.height)/2+20,cell.frame.size.width , (cell.frame.size.height)/2-20)];
        ll.font = [UIFont systemFontOfSize:16];
        
    }else if (self.view.frame.size.width == 320 && self.view.frame.size.height == 568){
        imageview = [[UIImageView alloc]initWithFrame:CGRectMake((cell.frame.size.width)/2-15, 20, 30, 30)];
        ll = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-(cell.frame.size.height)/2+20,cell.frame.size.width , (cell.frame.size.height)/2-20)];
        ll.font = [UIFont systemFontOfSize:11];
        
    }else if (self.view.frame.size.width == 320 && self.view.frame.size.height == 480){
        imageview = [[UIImageView alloc]initWithFrame:CGRectMake((cell.frame.size.width)/2-10, 5, 25, 25)];
        ll = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-(cell.frame.size.height)/2+20,cell.frame.size.width , (cell.frame.size.height)/2-40)];
        ll.font = [UIFont systemFontOfSize:9];
        
    }
    imageview.image = [self.arr1 objectAtIndex:indexPath.row];
    [cell.contentView addSubview:imageview];
    
    
    ll.text = [array objectAtIndex:indexPath.row];
    ll.textAlignment = NSTextAlignmentCenter;
    ll.textColor =[UIColor whiteColor];
    [cell.contentView addSubview:ll];
    [cell.contentView addSubview:button];
    cell.backgroundColor = [UIColor darkGrayColor];
    flog =1;
    if (indexPath.row ==0) {
       // NSLog(@"跳到签到界面");
        [WarningBox warningBoxModeIndeterminate:@"加载中..." andView:self.view];

        SignInViewController  *sign = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"sign"];
        
        [self.navigationController pushViewController:sign animated:YES];
        [WarningBox warningBoxHide:YES andView:self.view];

        
    }else if (indexPath.row == 1) {
       // NSLog(@"跳到公告界面");
        [WarningBox warningBoxModeIndeterminate:@"加载中..." andView:self.view];

        Gonggao_ViewController *ggvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"gonggao"];
        //[self presentViewController:ggvc animated:YES completion:nil];
//        ggvc.studentId = self.studentId;
//        ggvc.ip = self.ip;
        
        [self.navigationController pushViewController:ggvc animated:YES];
        [WarningBox warningBoxHide:YES andView:self.view];


        
    }
    else if(indexPath.row == 2){
       // NSLog(@"跳到信息上报界面");
        [WarningBox warningBoxModeIndeterminate:@"加载中..." andView:self.view];
        Shangbao_ViewController *sbvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"shangbao"];
//        sbvc.ip = self.ip;
//        sbvc.studentId = self.studentId;
        [self.navigationController pushViewController:sbvc animated:YES];
        [WarningBox warningBoxHide:YES andView:self.view];


    }
    else if (indexPath.row == 3){
        
        
        
        //拿到学校IP和studentID
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        //    [def objectForKey:@"IP"];
        //    [def objectForKey:@"studentId"];
        
        //请求学生信息
        [WarningBox warningBoxModeIndeterminate:@"加载中..." andView:self.view];
        
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
            
            //跳转到个人信息界面
            Gerenxinxi *gr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"grxx"];
            [self.navigationController pushViewController:gr animated:YES];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
            [WarningBox warningBoxHide:YES andView:self.view];
            
            [WarningBox warningBoxModeText:@"网络异常，请重试！" andView:self.view];
            
            NSLog(@"%@",error);
            
        }];
        
        //NSLog(@"跳到个人信息界面");

    }
    else if (indexPath.row == 4){
        //NSLog(@"跳到信息回复界面");

        [WarningBox warningBoxModeIndeterminate:@"加载中..." andView:self.view];
       InfoRevertViewController  *info = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"revert"];
     
        [self.navigationController pushViewController:info animated:YES];
        
        [WarningBox warningBoxHide:YES andView:self.view];

        
    }else{
       // NSLog(@"跳到设置界面");
        [WarningBox warningBoxModeIndeterminate:@"加载中..." andView:self.view];
        SetViewController  *set = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"set"];
        
        [self.navigationController pushViewController:set animated:YES];
        [WarningBox warningBoxHide:YES andView:self.view];

        
    }
    

    
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//取消选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    UILabel *ll;
    if (self.view.frame.size.width == 414) {
        imageview = [[UIImageView alloc]initWithFrame:CGRectMake((cell.frame.size.width)/2-25, (cell.frame.size.height)/2-30, 50, 50)];
        ll = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-(cell.frame.size.height)/2+20,cell.frame.size.width , (cell.frame.size.height)/2-20)];
        ll.font = [UIFont systemFontOfSize:16];
        
    }else if (self.view.frame.size.width == 375){
        
        imageview = [[UIImageView alloc]initWithFrame:CGRectMake((cell.frame.size.width)/2-25, (cell.frame.size.height)/2-30, 50, 50)];
        ll = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-(cell.frame.size.height)/2+20,cell.frame.size.width , (cell.frame.size.height)/2-20)];
        ll.font = [UIFont systemFontOfSize:16];
        
    }else if (self.view.frame.size.width == 320 && self.view.frame.size.height == 568){
        imageview = [[UIImageView alloc]initWithFrame:CGRectMake((cell.frame.size.width)/2-15, 20, 30, 30)];
        ll = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-(cell.frame.size.height)/2+20,cell.frame.size.width , (cell.frame.size.height)/2-20)];
        ll.font = [UIFont systemFontOfSize:11];
        
    }else if (self.view.frame.size.width == 320 && self.view.frame.size.height == 480){
        imageview = [[UIImageView alloc]initWithFrame:CGRectMake((cell.frame.size.width)/2-10, 5, 25, 25)];
        ll = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-(cell.frame.size.height)/2+20,cell.frame.size.width , (cell.frame.size.height)/2-40)];
        ll.font = [UIFont systemFontOfSize:9];
        
    }
    imageview.image = [self.arr objectAtIndex:indexPath.row];
    ll.text = [array objectAtIndex:indexPath.row];
    ll.textAlignment = NSTextAlignmentCenter;
    
    ll.textColor =[UIColor colorWithHexString:@"483D8B"];
    [cell.contentView addSubview:imageview];
    [cell.contentView addSubview:ll];
    [cell setBackgroundColor:[UIColor clearColor]];
}



#pragma mark - button
- (void)sos:(id)sender {
    
    //NSLog(@"跳转帮助界面");
    Sos_ViewController *svc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"sos"];
     svc.ip = self.ip;
    svc.latitude = self.latitude;
    svc.longitude = self.longitude;
//    svc.studentId = self.studentId;
    svc.locationinfo = [NSString stringWithFormat:@"%@",self.placemark ];
    [self.navigationController pushViewController:svc animated:YES];}

#pragma mark - tianqi
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
//{
//    CLLocation *currlocation = [locations lastObject];
//        //NSLog(@"latitude--%3.5f",currlocation.coordinate.latitude);
//        //NSLog(@"longitude--%3.5f",currlocation.coordinate.longitude);
//        //NSLog(@"altitude--%3.5f",currlocation.altitude);
//    NSLog(@"定位成功！");
//    self.latitude = [[NSString alloc] initWithFormat:@"%f",currlocation.coordinate.latitude];
//    self.latitude = [[NSString alloc] initWithFormat:@"%f",currlocation.coordinate.longitude];
//    
//    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
//    [geocoder reverseGeocodeLocation:currlocation completionHandler:^(NSArray *placemarks,NSError *error){
//        NSString *ss1;
//        NSLog(@"%@",placemarks);
//        for (CLPlacemark *place in placemarks) {
//            NSString *s1 = [NSString stringWithFormat:@"%@",place.subLocality];
//            ss1 = [s1 substringToIndex:s1.length-1];
//            NSLog(@"Quss1---%@",ss1);
//        }
//        if (placemarks.count > 0) {
//            CLPlacemark *placemark = placemarks[0];
//            
//            NSLog(@"具体位置%@",placemark.name);
//            NSDictionary *addressDictionary = placemark.addressDictionary;
//            
//            NSString *state = [addressDictionary objectForKey:(NSString *)kABPersonAddressStateKey];
//            state = state == nil ?@"":state;
//            NSString *city = [addressDictionary objectForKey:(NSString *)kABPersonAddressCityKey];
//            city = city == nil ?@"":city;
//            
//            self.locationinfo = [NSString stringWithFormat:@"%@",state];
//            NSString *ss3 = [self.locationinfo substringToIndex:self.locationinfo.length-1];
//            self.cityName = [NSString stringWithFormat:@"%@",city];
//            NSString *ss2 = [self.cityName substringToIndex:self.cityName.length-1];
//            NSLog(@"ss3----%@",ss3);
//            NSLog(@"CityNamess2---%@",ss2);
//            NSString *str = [NSString stringWithFormat:@"%@-%@-%@",ss1,ss2,ss3];
//            NSLog(@"str--%@",str);
//            
//            NSString *path = [[NSBundle mainBundle] pathForResource:@"code" ofType:@"plist"];
//            NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
//            NSLog(@"dic---%@",dic);
//            self.SSS = [dic objectForKey:[NSString stringWithFormat:@"%@",str]];
//            NSLog(@"SSS---%@",self.SSS);
//            //拿到城市ID
//            [[NSUserDefaults standardUserDefaults]setObject:self.SSS forKey:@"cityId"];
//            
//
//            Tianqi *tianqi = [[Tianqi alloc]init];
//            self.xingqi.text = [tianqi code:currlocation];
//            NSString *s = [tianqi tianqitupian:currlocation];
//            [self.tianqi setImage:[UIImage imageNamed:s]];
//            self.wendu.text = [tianqi wendu:currlocation];
//        }
//    }];
//
//    
//    
//    
//    
//
//}

//-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
//{
//    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
//    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks,NSError *error){
//        if (placemarks.count > 0) {
//            CLPlacemark *placemark = placemarks[0];
//            
//            NSLog(@"具体位置%@",placemark.name);
//            NSDictionary *addressDictionary = placemark.addressDictionary;
//            
//            NSString *state = [addressDictionary objectForKey:(NSString *)kABPersonAddressStateKey];
//            state = state == nil ?@"":state;
//            NSString *city = [addressDictionary objectForKey:(NSString *)kABPersonAddressCityKey];
//            city = city == nil ?@"":city;
//            NSString *s1 = [addressDictionary objectForKey:(NSString *)kABPersonAddressZIPKey];
//            s1 = s1 == nil ?@"":s1;
//            self.locationinfo = [NSString stringWithFormat:@"%@-%@-%@",state,city,s1];
//            self.cityName = [NSString stringWithFormat:@"%@",city];
//            
//            NSLog(@"CityName---%@",self.cityName);
////            NSString *path = [[NSBundle mainBundle] pathForResource:@"code" ofType:@"plist"];
////            NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
//            //NSLog(@"%@\n%@\n%@",state,address,city);
//        }
//    }];
//
//}
- (void)initializeLocationService {
    
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
}
int nicaicai=0;
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    //将经度显示到label上

        NSString *jing = [NSString stringWithFormat:@"%lf", newLocation.coordinate.longitude];
    //将纬度现实到label上
        NSString *wei = [NSString stringWithFormat:@"%lf", newLocation.coordinate.latitude];
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array1, NSError *error){
        if (array1.count > 0){
            
            self.placemark = [array1 objectAtIndex:0];
            NSLog(@"1-1-1-1%@",self.placemark);
                NSString *sheng=[NSString stringWithFormat:@"%@",[self.placemark.addressDictionary objectForKey:@"State"]];
            NSString *sheng1 = [sheng substringToIndex:sheng.length-1];
            
            
            //获取城市
            NSString *city = self.placemark.locality;
            NSString * shi ;NSString * qu;NSString *shi1;NSString *qu1;
            if (city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = self.placemark.administrativeArea;
                
                //市
                
                shi=[NSString stringWithFormat:@"%@",self.placemark.locality];
                shi1 = [shi substringToIndex:shi.length-1];
                //区
                qu=[NSString stringWithFormat:@"%@",self.placemark.subLocality];
                qu1 = [qu substringToIndex:qu.length-1];
            }
            NSString*strrrrrr=[NSString stringWithFormat:@"%@-%@-%@",qu1,shi1,sheng1];
            NSLog(@"\n\n\n\n\n\n\n%@-%@-%@",qu1,shi1,sheng1 );

            NSString *path = [[NSBundle mainBundle] pathForResource:@"code" ofType:@"plist"];
                        NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
            
                        self.SSS = [dic objectForKey:[NSString stringWithFormat:@"%@",strrrrrr]];
            
                        NSLog(@"SSS--12345-%@",self.SSS);
                        //拿到城市ID
                        [[NSUserDefaults standardUserDefaults]setObject:self.SSS forKey:@"cityId"];
            NSString *str;
            if (self.SSS == nil) {
                str = [NSString stringWithFormat:@"%@-%@-%@",shi1,shi1,sheng1];
                NSString *str1 = [dic objectForKey:[NSString stringWithFormat:@"%@",str]];
                NSLog(@"str1--1---%@",str1);
                
                [[NSUserDefaults standardUserDefaults]setObject:str1 forKey:@"cityId"];
            }
            
                        Tianqi *tianqi = [[Tianqi alloc]init];
                        self.xingqi.text = [tianqi code:newLocation];
                        NSString *s = [tianqi tianqitupian:newLocation];
                        [self.tianqi setImage:[UIImage imageNamed:s]];
                        self.wendu.text = [tianqi wendu:newLocation];
        }
        else if (error == nil && [array1 count] == 0)
        {
            //NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            //NSLog(@"An error occurred = %@", error);
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
    
}

@end
