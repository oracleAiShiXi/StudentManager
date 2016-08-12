//
//  Qiandaoye.m
//  爱实习
//
//  Created by 张文宇 on 16/7/28.
//  Copyright © 2016年 张文宇. All rights reserved.
//

#import "Qiandaoye.h"
#import "ViewController.h"

@interface Qiandaoye ()<UIScrollViewDelegate>
{
    
    float width,height;
    NSMutableArray *arr;
    UIImage *image1,*image2,*image3,*image4,*image5;
    UIPageControl *pageControl;
    int k;
    UIButton *btnBegin;

}

@end

@implementation Qiandaoye

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;

    width=[[UIScreen mainScreen] bounds].size.width;
    
    height=[[UIScreen mainScreen] bounds].size.height;
    
    UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height) ];
    
    
    scrollView.contentSize=CGSizeMake(width*5, height);
    
    scrollView.pagingEnabled=YES;
    
    //隐藏滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    
    
    
    [self.view addSubview:scrollView];
    
    scrollView.delegate=self;
    
    image1=[UIImage imageNamed:@"usehelp01.png"];
    image2=[UIImage imageNamed:@"usehelp02.png"];
    image3=[UIImage imageNamed:@"usehelp03.png"];
    image4=[UIImage imageNamed:@"usehelp04.png"];
    image5=[UIImage imageNamed:@"usehelp05.png"];
    
    arr=[NSMutableArray arrayWithObjects:image1,image2,image3,image4,image5, nil];
    for (int i=0; i<5; i++) {
        
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(width*i, 0, width, height)];
        
        imageView.image=arr[i];
        
        [scrollView addSubview:imageView];
        
    }
    
    pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(0, height-20, width, 20)];
    
    pageControl.enabled=NO;
    
    pageControl.numberOfPages=5;
    
    pageControl.currentPage=0;
    //设置点的颜色
    pageControl.currentPageIndicatorTintColor=[UIColor whiteColor];
    [self.view addSubview:pageControl];
    //开始使用按钮
    btnBegin=[[UIButton alloc] initWithFrame:CGRectMake(width*4+(width/2-width/6), height-80, width/3, width/8)];
    [btnBegin setTitle:@"开始使用" forState:UIControlStateNormal];
    [btnBegin setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [btnBegin.layer setCornerRadius:15];
    [btnBegin.layer setBorderWidth:1];
    [btnBegin.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [btnBegin addTarget:self action:@selector(Turn) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btnBegin];
    
    // Do any additional setup after loading the view, typically from a nib.
}
//停止滑动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    k=(int)scrollView.contentOffset.x/width;
    pageControl.currentPage=k;
}
//跳转
-(void)Turn{
    
    ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"viewc"];
        
    [self.navigationController pushViewController:vc animated:YES];
    
    //[self presentViewController:vc animated:NO completion:nil];
    NSLog(@"跳转");
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)prefersStatusBarHidden {
    return YES;
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
