//
//  SetViewController.h
//  StudentManager
//
//  Created by newmac on 16/7/29.
//  Copyright © 2016年 newmac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UILabel *edition;
- (IBAction)advice:(id)sender;
- (IBAction)help:(id)sender;
- (IBAction)kqtime:(id)sender;

- (IBAction)exit:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *quit;




@end
