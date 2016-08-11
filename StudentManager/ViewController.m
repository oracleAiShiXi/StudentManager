//
//  ViewController.m
//  ishixi
//
//  Created by csh on 16/7/28.
//  Copyright © 2016年 csh. All rights reserved.
//

#import "ViewController.h"
#import "Denglu_ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SBJson.h"
#import "AFHTTPSessionManager.h"
#import "Color+Hex.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSMutableArray *arr;
    NSMutableArray *arr_ip;
    NSMutableArray *arr_s;
    int flog;
    UIView *jiemian;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_chooseschool.png"]];
    
    imageView.frame = self.view.bounds;
    
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:imageView];
    
    self.l1 = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-100, self.view.frame.size.height/3-100, 200, 50)];
    self.l1.text = @"请选择学校";
    self.l1.font = [UIFont systemFontOfSize:38];
    self.l1.backgroundColor = [UIColor clearColor];
    self.l1.adjustsFontSizeToFitWidth = YES;
    self.l1.textColor = [UIColor whiteColor];
    [self.view addSubview:self.l1];
    
    self.l2 = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-80, self.view.frame.size.height/3-50, 160, 30)];
    self.l2.font = [UIFont systemFontOfSize:20];
    self.l2.text = @"Choose Your School";
    self.l2.backgroundColor = [UIColor clearColor];
    self.l2.adjustsFontSizeToFitWidth = YES;
    self.l2.textColor = [UIColor whiteColor];
    [self.view addSubview:self.l2];

    self.navigationController.navigationBar.hidden = YES;
    
    self.xuexiao = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-140, self.view.frame.size.height/3, 280, self.view.frame.size.height/10-10)];
    self.xuexiao.backgroundColor = [UIColor clearColor];
    self.xuexiao.textColor = [UIColor whiteColor];
    self.xuexiao.borderStyle = UITextBorderStyleRoundedRect;
    if (self.view.frame.size.width == 414) {
        self.xuexiao.layer.cornerRadius = 30.0;
        

    }else if(self.view.frame.size.width == 375){
        self.xuexiao.layer.cornerRadius = 28.0;
    }else{
        self.xuexiao.layer.cornerRadius = 25.0;
    }
    //self.xuexiao.layer.cornerRadius = 30.0;
    self.xuexiao.placeholder = @"选择你的学校";
    self.xuexiao.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.xuexiao.layer.borderWidth = 2.0;
    self.xuexiao.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.xuexiao.enabled = NO;
    self.xuexiao.delegate = self;
    [self.view addSubview:self.xuexiao];
    
    self.xuanxuexiao = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2+100, self.view.frame.size.height/3+15, 25, 25)];
    self.xuanxuexiao.backgroundColor = [UIColor clearColor];
    [self.xuanxuexiao setImage:[UIImage imageNamed:@"arrowdown.png"] forState:UIControlStateNormal];
    [self.xuanxuexiao addTarget:self action:@selector(xuexiao:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.xuanxuexiao];
    
    self.queding = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2-140, self.view.frame.size.height/3+80, 280, self.view.frame.size.height/10-10)];
    self.queding.backgroundColor = [UIColor clearColor];
    self.queding.borderStyle = UITextBorderStyleRoundedRect;
    //self.queding.layer.cornerRadius = 30.0;
    if (self.view.frame.size.width == 414) {
        self.queding.layer.cornerRadius = 30.0;
        
        
    }else if(self.view.frame.size.width == 375){
        self.queding.layer.cornerRadius = 28.0;
    }else{
        self.queding.layer.cornerRadius = 25.0;
    }
    self.queding.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.queding.layer.borderWidth = 2.0;
    self.queding.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.queding.enabled = NO;
    self.queding.delegate = self;
    [self.view addSubview:self.queding];
    
    self.queren = [[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width)/2-140, self.view.frame.size.height/3+80, 280, self.view.frame.size.height/10-10)];
    self.queren.backgroundColor = [UIColor clearColor];
    [self.queren setTitle:@"确定" forState:UIControlStateNormal];
    [self.queren setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.queren addTarget:self action:@selector(queding:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.queren];

    

    
    self.xuexiaomingcheng = [[UITableView alloc]initWithFrame:CGRectMake((self.view.frame.size.width)/2-150, (self.view.frame.size.height/3)+(self.view.frame.size.height/10-10), 300, 300)];
    self.xuexiaomingcheng.backgroundColor = [UIColor colorWithHexString:@"63d5ff"];
    self.xuexiaomingcheng.delegate = self;
    self.xuexiaomingcheng.dataSource = self;
    [self.view addSubview:self.xuexiaomingcheng];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    
    NSString *url=[NSString stringWithFormat:@"http://203.171.234.171:8080/jobservice/intf/mobile/school.shtml?command=schoollist"];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @try {
            //NSLog(@"%@",responseObject);
            NSDictionary *array = [responseObject objectForKey:@"schoolDTOs"];
            
            arr = [[NSMutableArray alloc]init];
            arr_ip = [[NSMutableArray alloc]init];
            arr_s = [[NSMutableArray alloc]init];
            
            for (NSDictionary *aa in array) {
                
                [arr addObject:[aa objectForKey:@"name"]];
                [arr_ip addObject:[aa objectForKey:@"ip"]];
                [arr_s addObject:[aa objectForKey:@"serial"]];
            }
            [self.xuexiaomingcheng reloadData];
            
        } @catch (NSException *exception) {
            
            //NSLog(@"网络");
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //NSLog(@"- -%@",error);
    }];
    flog = 0;
    self.xuexiaomingcheng.hidden = YES;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableVie
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr.count;
}

//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

        return 40;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *aa=@"Cell";
    
    UITableViewCell *cell=[self.xuexiaomingcheng dequeueReusableCellWithIdentifier:aa];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aa];
    }
    
    UIView *duzui;
    
    NSArray *ss=[cell.contentView subviews];
    
    for (UIView *vv in ss) {
        [vv removeFromSuperview];
    }
    cell.backgroundColor = [UIColor colorWithHexString:@"63d5ff"];
    duzui=[[UIView alloc] initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.view.frame), 1)];
    duzui.backgroundColor = [UIColor whiteColor];
    UILabel *ll=[[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-20, 40)];
    ll.textColor = [UIColor whiteColor];
    ll.text=arr[indexPath.row];
    
    [cell.contentView addSubview:ll];
    [cell.contentView addSubview:duzui];
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.xuexiaomingcheng.hidden = YES;
    if (tableView.isEditing) {
        
        return;
    }
    if (tableView == self.xuexiaomingcheng){
        self.str = arr[indexPath.row];
        self.ip = arr_ip[indexPath.row];
        self.serial = arr_s[indexPath.row];
        self.xuexiao.text = self.str;
      
    }
}



#pragma mark - button

- (void)xuexiao:(id)sender {
    if (flog == 0) {
        self.xuexiaomingcheng.hidden = NO;
        flog = 1;
    }
    else{
        self.xuexiaomingcheng.hidden = YES;
        flog = 0;
    }
}

- (void)queding:(id)sender {
    if (self.xuexiao.text == nil || [self.xuexiao.text isEqualToString:@""]) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请选择学校！" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }else{
        Denglu_ViewController *dlvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"denglu"];
        
        dlvc.name = self.xuexiao.text;
        
        dlvc.ip = self.ip;
        
        dlvc.serial = self.serial;
    
        [self.navigationController pushViewController:dlvc animated:YES];
    }
    
    
}
@end
