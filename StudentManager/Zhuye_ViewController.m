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
#import "UIImageView+WebCache.h"
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
    
   UILabel *ll;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    

    [self initializeLocationService];
    
    
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
   
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-2.png"]];
    imageView.frame = self.view.bounds;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
    
    self.view1.backgroundColor = [UIColor whiteColor];
    self.view1.layer.cornerRadius = 5.0;
    self.view1.alpha = 0.7;
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
    [self.geju reloadData];
    
    [_xingq setImage:[UIImage imageNamed:@"dingwei_03.png"] forState:UIControlStateNormal];
    _xingq.titleLabel.font=[UIFont systemFontOfSize:15];
    _xingq.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_xingq setImageEdgeInsets:UIEdgeInsetsMake(1, 0, 0, 0)];
    [_xingq setTitleEdgeInsets:UIEdgeInsetsMake(1, 5, 0, 0)];
    

           // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
   [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:animated];
    NSUserDefaults *kk = [NSUserDefaults standardUserDefaults];
    if ([[kk objectForKey:@"kkey"]intValue]==1) {
      [WarningBox warningBoxModeIndeterminate:@"正在获取天气" andView:self.view];
      [kk setObject:@"0" forKey:@"kkey"];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
        
    [super viewWillDisappear:animated];
 
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


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * CellIdentifier = @"GradientCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

   
    
    
    //UILabel *ll;
    if (self.view.frame.size.width == 414) {
        imageview = [[UIImageView alloc]initWithFrame:CGRectMake((cell.frame.size.width)/2-25, (cell.frame.size.height)/2-30, 50, 50)];
        ll = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-(cell.frame.size.height)/2+20,cell.frame.size.width , (cell.frame.size.height)/2-20)];
        ll.font = [UIFont systemFontOfSize:16];
        
    }
    else if (self.view.frame.size.width == 375){
        
        imageview = [[UIImageView alloc]initWithFrame:CGRectMake((cell.frame.size.width)/2-25, (cell.frame.size.height)/2-30, 50, 50)];
        ll = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-(cell.frame.size.height)/2+20,cell.frame.size.width , (cell.frame.size.height)/2-20)];
        ll.font = [UIFont systemFontOfSize:16];
        
    }
    else if (self.view.frame.size.width == 320 && self.view.frame.size.height == 568){
        imageview = [[UIImageView alloc]initWithFrame:CGRectMake((cell.frame.size.width)/2-15, 20, 30, 30)];
        ll = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-(cell.frame.size.height)/2+20,cell.frame.size.width , (cell.frame.size.height)/2-20)];
        ll.font = [UIFont systemFontOfSize:11];
        
    }
    else if (self.view.frame.size.width == 320 && self.view.frame.size.height == 480){
        imageview = [[UIImageView alloc]initWithFrame:CGRectMake((cell.frame.size.width)/2-10, 5, 25, 25)];
        ll = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-(cell.frame.size.height)/2+20,cell.frame.size.width , (cell.frame.size.height)/2-40)];
        ll.font = [UIFont systemFontOfSize:9];
        
    }



    
    
   
    //if (flog == 0) {
        
    imageview.image = [self.arr objectAtIndex:indexPath.row];
    ll.text = [array objectAtIndex:indexPath.row];
    ll.textAlignment = NSTextAlignmentCenter;
    ll.textColor =[UIColor colorWithHexString:@"483D8B"];
    cell.backgroundColor = [UIColor clearColor];
    //}
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    [cell.contentView addSubview:imageview];
    [cell.contentView addSubview:ll];

    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((self.geju.frame.size.width-30)/2, (self.geju.frame.size.height-50)/3);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0){
       // NSLog(@"跳到签到界面");
        [WarningBox warningBoxModeIndeterminate:@"加载中..." andView:self.view];

        SignInViewController  *sign = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"sign"];
        
        [self.navigationController pushViewController:sign animated:YES];
        [WarningBox warningBoxHide:YES andView:self.view];

        
    }
    else if (indexPath.row == 1) {
       // NSLog(@"跳到公告界面");
        [WarningBox warningBoxModeIndeterminate:@"加载中..." andView:self.view];

        Gonggao_ViewController *ggvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"gonggao"];
        [self.navigationController pushViewController:ggvc animated:YES];
        [WarningBox warningBoxHide:YES andView:self.view];


        
    }
    else if(indexPath.row == 2){
       // NSLog(@"跳到信息上报界面");
        [WarningBox warningBoxModeIndeterminate:@"加载中..." andView:self.view];
        Shangbao_ViewController *sbvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"shangbao"];
        [self.navigationController pushViewController:sbvc animated:YES];
        [WarningBox warningBoxHide:YES andView:self.view];


    }
    else if (indexPath.row == 3){
        
        //跳转到个人信息界面
        Gerenxinxi *gr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"grxx"];
        [self.navigationController pushViewController:gr animated:YES];
 

    }
    else if (indexPath.row == 4){
        //NSLog(@"跳到信息回复界面");

        [WarningBox warningBoxModeIndeterminate:@"加载中..." andView:self.view];
       InfoRevertViewController  *info = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"revert"];
     
        [self.navigationController pushViewController:info animated:YES];
        
        [WarningBox warningBoxHide:YES andView:self.view];

        
    }
    else{
       // NSLog(@"跳到设置界面");
        [WarningBox warningBoxModeIndeterminate:@"加载中..." andView:self.view];
        SetViewController  *set = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"set"];
        
        [self.navigationController pushViewController:set animated:YES];
        [WarningBox warningBoxHide:YES andView:self.view];

        
    }
    

    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}





//#pragma mark - button
//- (void)sos:(id)sender {
//    
//    //NSLog(@"跳转帮助界面");
//    Sos_ViewController *svc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"sos"];
//     svc.ip = self.ip;
//    svc.latitude = self.wei;
//    svc.longitude = self.jing;
////    svc.studentId = self.studentId;
//    svc.locationinfo = [NSString stringWithFormat:@"%@",self.placemark ];
//   // NSLog(@"详细地理位置:%@",svc.locationinfo);
//    [self.navigationController pushViewController:svc animated:YES];
//}

#pragma mark - tianqi

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
    
        self.jing = [NSString stringWithFormat:@"%lf", newLocation.coordinate.longitude];
    //将纬度现实到label上
        self.wei = [NSString stringWithFormat:@"%lf", newLocation.coordinate.latitude];
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array1, NSError *error){
        if (array1.count > 0){
            
            self.placemark = [array1 objectAtIndex:0];
            //NSLog(@"1-1-1-1%@",self.placemark);
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
                [[NSUserDefaults standardUserDefaults]setObject:shi1 forKey:@"locality"];
                //区
                qu=[NSString stringWithFormat:@"%@",self.placemark.subLocality];
                qu1 = [qu substringToIndex:qu.length-1];
            }
            NSString*strrrrrr=[NSString stringWithFormat:@"%@-%@-%@",qu1,shi1,sheng1];
           // NSLog(@"\n\n\n\n\n\n\n%@-%@-%@",qu1,shi1,sheng1 );

            NSString *path = [[NSBundle mainBundle] pathForResource:@"code" ofType:@"plist"];
                        NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
            
                        self.SSS = [dic objectForKey:[NSString stringWithFormat:@"%@",strrrrrr]];
            
                      //  NSLog(@"SSS--12345-%@",self.SSS);
                        //拿到城市ID
                        [[NSUserDefaults standardUserDefaults]setObject:self.SSS forKey:@"cityId"];
            NSString *str;
            if (self.SSS == nil) {
                str = [NSString stringWithFormat:@"%@-%@-%@",shi1,shi1,sheng1];
                NSString *str1 = [dic objectForKey:[NSString stringWithFormat:@"%@",str]];
               // NSLog(@"str1--1---%@",str1);
                
                [[NSUserDefaults standardUserDefaults]setObject:str1 forKey:@"cityId"];
            }
            [WarningBox warningBoxHide:YES andView:self.view];
                        Tianqi *tianqi = [[Tianqi alloc]init];
            [_xingq setTitle:[tianqi code:newLocation] forState:UIControlStateNormal];
                       // self.xingqi.text = [tianqi code:newLocation];
                        NSString *s = [tianqi tianqitupian:newLocation];
            
            NSString *strs = [NSString stringWithFormat:@"http://php.weather.sina.com.cn/images/yb3/180_180/%@_0.png",s];
           // NSLog(@"the strs url = %@",strs);
            //[self.tianqi setImage:[UIImage imageNamed:s]];
             [self.tianqi sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",strs]] placeholderImage:[UIImage imageNamed:@"daiti.png"]];
            
            _wendu.text = [tianqi wendu:newLocation];
           
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

- (IBAction)SOS:(id)sender {
    //NSLog(@"跳转帮助界面");
    Sos_ViewController *svc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"sos"];
    svc.ip = self.ip;
    svc.latitude = self.wei;
    svc.longitude = self.jing;
    //    svc.studentId = self.studentId;
    svc.locationinfo = [NSString stringWithFormat:@"%@",self.placemark ];
    // NSLog(@"详细地理位置:%@",svc.locationinfo);
    [self.navigationController pushViewController:svc animated:YES];
    
}
@end
