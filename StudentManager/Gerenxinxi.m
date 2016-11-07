//
//  Gerenxinxi.m
//  爱实习
//
//  Created by 张文宇 on 16/7/28.
//  Copyright © 2016年 张文宇. All rights reserved.
//

#import "Gerenxinxi.h"
#import "ViewController.h"
#import "Xiugai.h"
#import "SBJson.h"
#import "Color+Hex.h"
#import "AFHTTPSessionManager.h"
#import "MBProgressHUD.h"
#import "WarningBox.h"


@interface Gerenxinxi ()<UITextFieldDelegate>
{
    
    float width,height;
    
    NSMutableArray *Values;

}

@end

@implementation Gerenxinxi

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    width = [UIScreen mainScreen].bounds.size.width;
    
    height = [UIScreen mainScreen].bounds.size.height;
    
    self.navigationItem.title = @"个人信息";
    //设置导航栏的文字大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"5fc1ff"];
    
    //按钮大小
    int MaxWidth=40,MinWidth=20,MaxHeigth=20;
    
    //设置导航栏左侧按钮
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, MinWidth, MaxHeigth)];
    [leftBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc]initWithCustomView: leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //设置导航栏右侧按钮
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(width-MaxWidth, 0, MaxWidth, MaxHeigth)];
    [rightBtn setTitle:@"修改" forState:UIControlStateNormal];
    [rightBtn setTintColor:[UIColor whiteColor]];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [rightBtn addTarget:self action:@selector(Tiaoxiugai:) forControlEvents:UIControlEventTouchUpInside];
    //rightBtn.hidden = YES;
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc]initWithCustomView: rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //设置边框
    [self.yuexinview.layer setCornerRadius:10];
    [self.yuexinview.layer setBorderWidth:1];
    [self.yuexinview.layer setBorderColor:[[UIColor whiteColor] CGColor]];

    [self.danweiview.layer setCornerRadius:10];
    [self.danweiview.layer setBorderWidth:1];
    [self.danweiview.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [self.dizhiview.layer setCornerRadius:10];
    [self.dizhiview.layer setBorderWidth:1];
    [self.dizhiview.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [self.dianhuaview.layer setCornerRadius:10];
    [self.dianhuaview.layer setBorderWidth:1];
    [self.dianhuaview.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [self.zaigangview.layer setCornerRadius:10];
    [self.zaigangview.layer setBorderWidth:1];
    [self.zaigangview.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    rightBtn.hidden = NO;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = NO;
    
    [WarningBox warningBoxModeIndeterminate:@"加载中..." andView:self.view];
    [self gerenxixin];
    
    [WarningBox warningBoxHide:YES andView:self.view];
    
}

//返回上一页
- (void)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
//跳到修改
-(void)Tiaoxiugai:(id)sender{
    
    Xiugai *xg = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"xiugai"];
    
    [self.navigationController pushViewController:xg animated:YES];
    
   // NSLog(@"修改");
    
}
//加载个人信息
-(void)gerenxixin{
    
    NSUserDefaults  *def = [NSUserDefaults standardUserDefaults];
    
    //请求学生信息
    //将上传对象转换为json类型
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    
    //上传参数
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId", nil];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSString *jsonstring = [writer stringWithObject:dic];
    
    NSDictionary *MSG = [NSDictionary dictionaryWithObjectsAndKeys:jsonstring,@"MSG", nil];
    NSString *url = [NSString stringWithFormat:@"http://%@/job/intf/mobile/gate.shtml?command=stuinformation",[def objectForKey:@"IP"]];
    
    [manager POST:url parameters:MSG progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
         //NSLog(@"studentinfo ------%@",responseObject);
        //把返回数据存入可变字典
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:responseObject];
        NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
        
        //将字典里的空指针转化为空字符串
        Values = [[NSMutableArray alloc] init];
        NSString *aa = [[NSString alloc] init];
        for (aa in [dic allValues]) {
            if ([aa isEqual:[NSNull null]]) {
                aa=@"";
            }
            [Values addObject:aa];
        }
        
        // NSLog(@"%@",Values);
        
        NSMutableArray *Keys = [[NSMutableArray alloc] init];
        for (NSString *bb in [dic allKeys]) {
            [Keys addObject:bb];
        }
        
        //  NSLog(@"%@",Keys);
        
        for (int i=0; i<[dic count]; i++) {
            
            [dataDic setValue:Values[i] forKey:Keys[i]];
        }
        
       // NSLog(@"data------%@",dataDic);
        
        //把数据存入plist文件
        NSString *path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/userInfo.plist"];
        /// NSLog(@"NSHomeDirectory()=====%@",NSHomeDirectory());
        
        [dataDic writeToFile:path atomically:YES];
       
        
        {
            
            //把数据存入plist文件
           // NSString *path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/userInfo.plist"];
          //  NSLog(@"%@",path);
            
           // NSDictionary *dataDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
           // [dataDic writeToFile:path atomically:YES];
            
            if (dataDic[@"money"]==nil) {
                self.yuexinlable.text = @"";
            } else {
                self.yuexinlable.text = [NSString stringWithFormat:@"%@",dataDic[@"money"]];
            }
            
            if (dataDic[@"companyName"]==nil) {
                self.danweilable.text = @"";
            } else {
                self.danweilable.text = [NSString stringWithFormat:@"%@",dataDic[@"companyName"]];
            }
            
            if (dataDic[@"lodgingAddress"]==nil) {
                self.dizhilable.text = @"";
            } else {
                self.dizhilable.text = [NSString stringWithFormat:@"%@",dataDic[@"lodgingAddress"]];
            }
            
            if (dataDic[@"studentPhone"]==nil) {
                self.dianhualabel.text = @"";
            } else {
                self.dianhualabel.text = [NSString stringWithFormat:@"%@",dataDic[@"studentPhone"]];
            }
            
            if (dataDic[@"isInPost"]==nil) {
                self.zaigangleabel.text = @"";
            } else if([dataDic[@"isInPost"] intValue]==0){
                self.zaigangleabel.text = @"否";
            } else {
                self.zaigangleabel.text = @"是";
            }
            
            
        }
        
        
        
        
        [WarningBox warningBoxHide:YES andView:self.view];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        [WarningBox warningBoxHide:YES andView:self.view];
        
        [WarningBox warningBoxModeText:@"网络异常，请重试！" andView:self.view];
        
       // NSLog(@"%@",error);
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
