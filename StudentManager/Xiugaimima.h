//
//  Xiugaimima.h
//  爱实习
//
//  Created by 张文宇 on 16/7/29.
//  Copyright © 2016年 张文宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Xiugaimima : UIViewController
@property (weak, nonatomic) IBOutlet UIView *biankuangview;



@property (weak, nonatomic) IBOutlet UITextField *xinmimaTextField;

@property (weak, nonatomic) IBOutlet UITextField *querenmimaTextField;

@property (weak, nonatomic) IBOutlet UIButton *querenBtn;

- (IBAction)queren:(id)sender;


@end
