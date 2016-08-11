//
//  Denglu_ViewController.h
//  ishixi
//
//  Created by csh on 16/7/28.
//  Copyright © 2016年 csh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Denglu_ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *xuexiaomingzi;
@property (weak, nonatomic) IBOutlet UILabel *yingwen;

@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *ip;
@property(nonatomic,retain)NSString *serial;


@property (strong, nonatomic) UITextField *zhanghao;
@property(strong,nonatomic)UITextField *zhanghao1;
@property (strong, nonatomic) UITextField *mima;
@property(strong,nonatomic)UITextField *mima1;
@property (strong, nonatomic) UITextField *denglu;
@property(strong,nonatomic)UITextField *denglu1;
@property(strong,nonatomic)UIButton *lijidenglu;
@property(strong,nonatomic)UIButton *fanhui1;
@property(strong,nonatomic)UIButton *checkbox1;
@property(strong,nonatomic)UILabel *jizhu;




//- (IBAction)lijidenglu:(id)sender;

@property (nonatomic,assign) BOOL isChecked;

@end
