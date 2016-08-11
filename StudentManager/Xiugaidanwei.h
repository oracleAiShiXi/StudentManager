//
//  Xiugaidanwei.h
//  爱实习
//
//  Created by 张文宇 on 16/7/29.
//  Copyright © 2016年 张文宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Xiugaidanwei : UIViewController
@property (weak, nonatomic) IBOutlet UIView *biankuangview;
@property (weak, nonatomic) IBOutlet UILabel *shenlabel;
@property (weak, nonatomic) IBOutlet UILabel *shilabel;
- (IBAction)shenBtn:(id)sender;
- (IBAction)shiBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *danweiTextField;
@property (weak, nonatomic) IBOutlet UITextField *bumenTxetField;
@property (weak, nonatomic) IBOutlet UITextField *zhiweiTextField;
@property (weak, nonatomic) IBOutlet UITextField *danweidianhuaTextField;
@property (weak, nonatomic) IBOutlet UITextField *danweidizhiTextFiled;

@end
