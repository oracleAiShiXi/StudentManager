//
//  Dizhixiugai.h
//  爱实习
//
//  Created by 张文宇 on 16/7/29.
//  Copyright © 2016年 张文宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Dizhixiugai : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *shenlabel;
@property (weak, nonatomic) IBOutlet UILabel *shilabel;
@property (weak, nonatomic) IBOutlet UIView *biankuangview;
@property (weak, nonatomic) IBOutlet UITextField *jinjilianxirenTextField;
@property (weak, nonatomic) IBOutlet UITextField *lianxidianhuaTextField;
@property (weak, nonatomic) IBOutlet UITextField *zhusudizhiTextField;
- (IBAction)shenBtn:(id)sender;
- (IBAction)shiBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *shengBtn;
@property (weak, nonatomic) IBOutlet UIButton *shiBtn;

@end
