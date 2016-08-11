//
//  Gonggao_ViewController.h
//  ishixi
//
//  Created by csh on 16/8/3.
//  Copyright © 2016年 csh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Gonggao_ViewController : UIViewController

@property(strong,nonatomic)UITableView *myTable;
@property(nonatomic,retain)NSString *studentId;
@property(nonatomic,retain)NSString *noticeId;
@property(nonatomic,retain)NSString *ip;
@property (strong, nonatomic) NSArray *arrayExampleList;

@end
