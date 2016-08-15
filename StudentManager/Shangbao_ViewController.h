//
//  Shangbao_ViewController.h
//  ishixi
//
//  Created by csh on 16/8/5.
//  Copyright © 2016年 csh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Shangbao_ViewController : UIViewController

//@property(strong,nonatomic)UIButton *b1;
//@property(strong,nonatomic)UIButton *b2;
//@property(strong,nonatomic)UITextField *biaoti;
//@property(strong,nonatomic)UITextView *neirong;
//@property(strong,nonatomic)UIButton *tijiao;
@property(nonatomic,retain)NSString *studentId;
@property(nonatomic,retain)NSString *ip;
@property(nonatomic,retain)NSString *result;


@property (weak, nonatomic) IBOutlet UIButton *shixi;
@property (weak, nonatomic) IBOutlet UIButton *jiuye;
- (IBAction)shixiBtn:(id)sender;
- (IBAction)jiuyeBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *biaoti;
@property (weak, nonatomic) IBOutlet UITextView *neirong;
@property (weak, nonatomic) IBOutlet UIButton *tijiaoBtn;
- (IBAction)tj:(id)sender;

@end
