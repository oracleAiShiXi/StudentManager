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
 

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-2.png"]];
    
    imageView.frame = self.view.bounds;
    
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:imageView];
    
    self.wendu.adjustsFontSizeToFitWidth = YES;
    self.xingqi.adjustsFontSizeToFitWidth = YES;
    
    self.view1.backgroundColor = [UIColor whiteColor];
    
    self.view1.layer.cornerRadius = 5.0;
    
    self.view1.alpha = 0.7;
    
    [self.view addSubview:self.view1];
    //图标
    [self.dingwei setImage:[UIImage imageNamed:@"dingwei_03.png"]];
    
    

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
    NSLog(@"ip-----%@",self.ip);
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
    NSLog(@"%@",self.locationinfo);
        // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = YES;
    NSLog(@"result1---%@",self.result1);
    NSLog(@"result2---%@",self.result2);
    [super viewWillAppear:animated];
    //开始定位
    [self.locationManager startUpdatingLocation];
    
    
    //加载省市
    [self shengshi];
    
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    
       self.navigationController.navigationBar.hidden = YES;
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

    imageview = [[UIImageView alloc]initWithFrame:CGRectMake((cell.frame.size.width)/2-20, (cell.frame.size.height)/2-30, 40, 40)];

    UILabel *ll = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-(cell.frame.size.height)/2+20,cell.frame.size.width , (cell.frame.size.height)/2-20)];

    if (flog == 0) {
        
   imageview.image = [self.arr objectAtIndex:indexPath.row];
    ll.text = [array objectAtIndex:indexPath.row];
    ll.textAlignment = UITextAlignmentCenter;
    ll.font = [UIFont systemFontOfSize:16];
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
    
     imageview = [[UIImageView alloc]initWithFrame:CGRectMake((cell.frame.size.width)/2-20, (cell.frame.size.height)/2-30, 40, 40)];
    imageview.image = [self.arr1 objectAtIndex:indexPath.row];
    [cell.contentView addSubview:imageview];
    
    
    UILabel *ll = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-(cell.frame.size.height)/2+20,cell.frame.size.width , (cell.frame.size.height)/2-20)];
    ll.text = [array objectAtIndex:indexPath.row];
    ll.textAlignment = UITextAlignmentCenter;
    ll.font = [UIFont systemFontOfSize:16];
    ll.textColor =[UIColor whiteColor];
    [cell.contentView addSubview:ll];
    [cell.contentView addSubview:button];
    cell.backgroundColor = [UIColor darkGrayColor];
    flog =1;
    if (indexPath.row ==0) {
       // NSLog(@"跳到签到界面");
        SignInViewController  *sign = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"sign"];
        
        [self.navigationController pushViewController:sign animated:YES];
        
    }else if (indexPath.row == 1) {
       // NSLog(@"跳到公告界面");
        Gonggao_ViewController *ggvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"gonggao"];
        //[self presentViewController:ggvc animated:YES completion:nil];
//        ggvc.studentId = self.studentId;
//        ggvc.ip = self.ip;
        [self.navigationController pushViewController:ggvc animated:YES];

        
    }
    else if(indexPath.row == 2){
       // NSLog(@"跳到信息上报界面");
        Shangbao_ViewController *sbvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"shangbao"];
//        sbvc.ip = self.ip;
//        sbvc.studentId = self.studentId;
        [self.navigationController pushViewController:sbvc animated:YES];

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
            NSLog(@"NSHomeDirectory()=====%@",NSHomeDirectory());
            
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

       InfoRevertViewController  *info = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"revert"];
     
        [self.navigationController pushViewController:info animated:YES];
        
        
        
    }else{
       // NSLog(@"跳到设置界面");
        
        SetViewController  *set = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"set"];
        
        [self.navigationController pushViewController:set animated:YES];
        
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
    imageview = [[UIImageView alloc]initWithFrame:CGRectMake((cell.frame.size.width)/2-20, (cell.frame.size.height)/2-30, 40, 40)];
    imageview.image = [self.arr objectAtIndex:indexPath.row];
    UILabel *ll = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-(cell.frame.size.height)/2+20,cell.frame.size.width , (cell.frame.size.height)/2-20)];
    ll.text = [array objectAtIndex:indexPath.row];
    ll.textAlignment = UITextAlignmentCenter;
    ll.font = [UIFont systemFontOfSize:16];
    ll.textColor =[UIColor colorWithHexString:@"483D8B"];
    [cell.contentView addSubview:imageview];
    [cell.contentView addSubview:ll];
    [cell setBackgroundColor:[UIColor clearColor]];
}



#pragma mark - button
- (IBAction)sos:(id)sender {
    
    //NSLog(@"跳转帮助界面");
    Sos_ViewController *svc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"sos"];
     svc.ip = self.ip;
    svc.latitude = self.latitude;
    svc.longitude = self.longitude;
//    svc.studentId = self.studentId;
    svc.locationinfo = self.locationinfo;
    [self.navigationController pushViewController:svc animated:YES];}

#pragma mark - tianqi
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *currlocation = [locations lastObject];
        //NSLog(@"latitude--%3.5f",currlocation.coordinate.latitude);
        //NSLog(@"longitude--%3.5f",currlocation.coordinate.longitude);
        //NSLog(@"altitude--%3.5f",currlocation.altitude);
    NSLog(@"定位成功！");
    self.latitude = [[NSString alloc] initWithFormat:@"%f",currlocation.coordinate.latitude];
    self.latitude = [[NSString alloc] initWithFormat:@"%f",currlocation.coordinate.longitude];
    
   
    
    
    
    Tianqi *tianqi = [[Tianqi alloc]init];
    self.xingqi.text = [tianqi code:currlocation];
    NSString *s = [tianqi tianqitupian:currlocation];
    [self.tianqi setImage:[UIImage imageNamed:s]];
    self.wendu.text = [tianqi wendu:currlocation];

}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks,NSError *error){
        if (placemarks.count > 0) {
            CLPlacemark *placemark = placemarks[0];
            
            NSLog(@"具体位置%@",placemark.name);
            NSDictionary *addressDictionary = placemark.addressDictionary;
            
            NSString *address = [addressDictionary objectForKey:(NSString *)kABPersonAddressStreetKey];
            address = address == nil ?@"":address;
            NSString *state = [addressDictionary objectForKey:(NSString *)kABPersonAddressStateKey];
            state = state == nil ?@"":state;
            NSString *city = [addressDictionary objectForKey:(NSString *)kABPersonAddressCityKey];
            city = city == nil ?@"":city;
            self.locationinfo = [NSString stringWithFormat:@"%@ \n%@ \n%@",state,address,city];
            NSLog(@"%@\n%@\n%@",state,address,city);
        }
    }];

}

@end
