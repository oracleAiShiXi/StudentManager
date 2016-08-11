//
//  Xiugai.h
//  爱实习
//
//  Created by 张文宇 on 16/7/29.
//  Copyright © 2016年 张文宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Xiugai : UIViewController
@property (weak, nonatomic) IBOutlet UIView *biankuangview;
@property (weak, nonatomic) IBOutlet UITextField *yuexintextfield;
@property (weak, nonatomic) IBOutlet UITextField *dianhuatextfield;
- (IBAction)xiuggaidanweiBtn:(id)sender;
- (IBAction)xiugaidizhiBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *danweiBtn;
@property (weak, nonatomic) IBOutlet UIButton *dizhiBtn;
@property (weak, nonatomic) IBOutlet UIButton *mimaBtn;
@property (weak, nonatomic) IBOutlet UILabel *danweilabel;
@property (weak, nonatomic) IBOutlet UILabel *dizhilabel;
@property (weak, nonatomic) IBOutlet UIButton *yesBtn;
@property (weak, nonatomic) IBOutlet UIButton *noBtn;

- (IBAction)YESorNO:(id)sender;

- (IBAction)xiugaimimaBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *danweiimv;
@property (weak, nonatomic) IBOutlet UIImageView *dizhiimv;
@property (weak, nonatomic) IBOutlet UIImageView *mimaimv;

@end
