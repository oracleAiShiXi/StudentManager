//
//  Xiangqing_ViewController.h
//  ishixi
//
//  Created by csh on 16/8/5.
//  Copyright © 2016年 csh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Xiangqing_ViewController : UIViewController<UITextViewDelegate>


@property(nonatomic,retain)NSString *studentId;
@property(nonatomic,retain)NSString *noticeId;

@property(nonatomic,retain)NSString *ip;
@property (weak, nonatomic) IBOutlet UILabel *tongzhiLabel;
@property (weak, nonatomic) IBOutlet UITextView *neirongTextview;
@property (weak, nonatomic) IBOutlet UILabel *shijianLabel;
@property (weak, nonatomic) IBOutlet UIView *biankuangview;

@end
