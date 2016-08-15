//
//  InfoMinuteViewController.h
//  StudentManager
//
//  Created by newmac on 16/8/9.
//  Copyright © 2016年 newmac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoMinuteViewController : UIViewController<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *tit;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *huif;
@property (weak, nonatomic) IBOutlet UILabel *hftime;
@property (weak, nonatomic) IBOutlet UITextView *problem;

@property (weak, nonatomic) IBOutlet UITextView *reppro;





@end
