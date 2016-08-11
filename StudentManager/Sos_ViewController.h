//
//  Sos_ViewController.h
//  ishixi
//
//  Created by csh on 16/8/9.
//  Copyright © 2016年 csh. All rights reserved.
//

#import "ViewController.h"

@interface Sos_ViewController : UIViewController

@property(strong,nonatomic)UITextField *myTF;
@property(strong,nonatomic)UITextView *myTV;
@property(strong,nonatomic)UIButton *myBt;

@property(nonatomic,retain)NSString *studentId;
@property(nonatomic,retain)NSString *ip;
@property(nonatomic,retain)NSString *longitude;
@property(nonatomic,retain)NSString *latitude;
@property(nonatomic,retain)NSString *locationinfo;
@property(nonatomic,retain)NSString *result;


@end
