//
//  InfoRevertViewController.h
//  StudentManager
//
//  Created by newmac on 16/8/9.
//  Copyright © 2016年 newmac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoRevertViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mytable1;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
- (IBAction)change:(id)sender;

@end
