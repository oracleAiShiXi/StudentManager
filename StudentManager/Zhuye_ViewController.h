//
//  Zhuye_ViewController.h
//  ishixi
//
//  Created by csh on 16/7/29.
//  Copyright © 2016年 csh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface Zhuye_ViewController : UIViewController<CLLocationManagerDelegate>
@property(nonatomic,strong)CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UIView *view1;

@property (strong, nonatomic) UIImageView *dingwei;
@property (weak, nonatomic) IBOutlet UIButton *qiuzhu;


@property (weak, nonatomic) IBOutlet UIImageView *tianqi;
@property (weak, nonatomic) IBOutlet UILabel *wendu;
@property (weak, nonatomic) IBOutlet UIButton *xingq;

@property (strong, nonatomic) UILabel *xingqi;
- (IBAction)SOS:(id)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *geju;
@property(strong,nonatomic) NSMutableArray *arr;
@property(strong,nonatomic) NSMutableArray *arr1;
@property(nonatomic,retain)NSString *studentId;
@property(nonatomic,retain)NSString *ip;

@property(nonatomic,retain)NSString *longitude;
@property(nonatomic,retain)NSString *latitude;
@property(nonatomic,retain)CLPlacemark *placemark;
@property(nonatomic,retain)NSString *cityName;
@property(nonatomic,retain)NSString *jing;
@property(nonatomic,retain)NSString *wei;
@property(nonatomic,retain)NSString *SSS;
@property(nonatomic,retain)NSString *result1;
@property(nonatomic,retain)NSString *result2;



@end
