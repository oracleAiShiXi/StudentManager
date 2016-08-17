//
//  Denglu_ViewController.h
//  ishixi
//
//  Created by csh on 16/7/28.
//  Copyright © 2016年 csh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Denglu_ViewController : UIViewController
//@property (strong, nonatomic) UILabel *xuexiaomingzi;
//@property (strong, nonatomic) UILabel *yingwen;
//
//@property(nonatomic,retain)NSString *name;
//@property(nonatomic,retain)NSString *ip;
//@property(nonatomic,retain)NSString *serial;
//
//
//@property (strong, nonatomic) UITextField *zhanghao;
//@property(strong,nonatomic)UITextField *zhanghao1;
//@property (strong, nonatomic) UITextField *mima;
//@property(strong,nonatomic)UITextField *mima1;
//@property (strong, nonatomic) UITextField *denglu;
//@property(strong,nonatomic)UITextField *denglu1;
//@property(strong,nonatomic)UIButton *lijidenglu;
//@property(strong,nonatomic)UIButton *fanhui1;
//@property(strong,nonatomic)UIButton *checkbox1;
//@property(strong,nonatomic)UILabel *jizhu;
@property (weak, nonatomic) IBOutlet UILabel *schoolname;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *checkbox1;
@property (weak, nonatomic) IBOutlet UIButton *queding;
@property (weak, nonatomic) IBOutlet UIButton *genghuan;

- (IBAction)change:(id)sender;

- (IBAction)sure:(id)sender;

- (IBAction)rember:(id)sender;




//- (IBAction)lijidenglu:(id)sender;

@property (nonatomic,assign) BOOL isChecked;

@end
