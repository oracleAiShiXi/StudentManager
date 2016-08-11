//
//  HelpViewController.h
//  StudentManager
//
//  Created by newmac on 16/7/29.
//  Copyright © 2016年 newmac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpViewController : UIViewController<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIPageControl *page;

@end
