//
//  HelpViewController.m
//  StudentManager
//
//  Created by newmac on 16/7/29.
//  Copyright © 2016年 newmac. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()
{
    float width,heigh;
    UIImageView *scrollimg;
    
}
@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   self.navigationController.navigationBar.hidden = YES;
  
    
    
    
    [self scrollv];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//隐藏状态栏方法 在info.plist文件中加入View controller-based status bar appearance 属性设置为yes 
- (BOOL)prefersStatusBarHidden {
    return YES;
}

//返回按钮方法
-(void)backbutton:(UIButton*)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    //NSLog(@"2123");
    
}

#pragma mark 图片轮播
-(void)scrollv{
    
    
    width = [UIScreen mainScreen].bounds.size.width;
    heigh = [UIScreen mainScreen].bounds.size.height;
    
    _scrollview.delegate =self;
    _scrollview.contentSize = CGSizeMake(width*5, 0);
   // _scrollview.frame = CGRectMake(0, 0, width, heigh);
    _scrollview.pagingEnabled = YES;
    _scrollview.showsVerticalScrollIndicator = NO;
    
    
    _page.numberOfPages = 5;
    _page.currentPageIndicatorTintColor = [UIColor blueColor];
    _page.pageIndicatorTintColor = [UIColor grayColor];
    _page.currentPage = 0;
    
    
    
    UIButton  *backbtn = [[UIButton alloc]initWithFrame:CGRectMake(width*4, 0, width, heigh)];
    [backbtn addTarget:self action:@selector(backbutton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_scrollview addSubview:backbtn];
    
    [backbtn bringSubviewToFront:_scrollview];
    
    
    for (int i=0; i<5; i++) {
        scrollimg = [[UIImageView alloc]initWithFrame:CGRectMake(i*width, 0, width, heigh)];
        NSString *imgname = [NSString stringWithFormat:@"usehelp0%d",i+1];
        scrollimg.image =[UIImage imageNamed:imgname];
        [_scrollview addSubview: scrollimg];
    }
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int  dex = (int)(scrollView.contentOffset.x/width);
    _page.currentPage = dex;

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
