//
//  Denglu_ViewController.h
//  ishixi
//
//  Created by csh on 16/7/28.
//  Copyright © 2016年 csh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Denglu_ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *schoolname;
@property (weak, nonatomic) IBOutlet UILabel *Eschoolname;

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
