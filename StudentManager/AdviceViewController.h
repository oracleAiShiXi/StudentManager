//
//  AdviceViewController.h
//  StudentManager
//
//  Created by newmac on 16/7/29.
//  Copyright © 2016年 newmac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdviceViewController : UIViewController<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (weak, nonatomic) IBOutlet UIButton *refer;
- (IBAction)submit:(id)sender;

@end
