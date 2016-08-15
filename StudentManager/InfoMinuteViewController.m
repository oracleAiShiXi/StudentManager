//
//  InfoMinuteViewController.m
//  StudentManager
//
//  Created by newmac on 16/8/9.
//  Copyright © 2016年 newmac. All rights reserved.
//

#import "InfoMinuteViewController.h"
#import "AFHTTPSessionManager.h"
#import "SBJson.h"
#import "WarningBox.h"
@interface InfoMinuteViewController ()

@end

@implementation InfoMinuteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self daohang];
    
    _problem.delegate = self;
    _reppro.delegate = self;
    [_problem.layer setCornerRadius:5.0];
    [_reppro.layer setCornerRadius:5.0];
    
    _problem.editable = NO;
    _reppro.editable = NO;
    //设置textfield文本在顶部显示
//    _problem.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
//    _reppro.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
  
    
    
    //拿到存的学校IP和studentId
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    //    [def objectForKey:@"IP"];
    //    [def objectForKey:@"studentId"];
    
    [WarningBox warningBoxModeIndeterminate:@"正在加载中" andView:self.view];
    //将上传对象转换为json格式字符串
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc]init];
    
    //出入参数：
    //studentid需要传过来
    NSDictionary*datadic=[NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"xiangxi"],@"stuAdvisoryId", nil];
    
    NSString *jsonstring =[writer stringWithObject:datadic];
    
    NSString *url = [NSString stringWithFormat:@"http://%@/job/intf/mobile/gate.shtml?command=stuadvisorydetail",[def objectForKey:@"IP"]];
    
    NSDictionary *msg = [NSDictionary dictionaryWithObjectsAndKeys:jsonstring,@"MSG", nil];
    
    [manager POST:url parameters:msg progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @try {
           
            
             [WarningBox warningBoxHide:YES andView:self.view];
            
            if ([[responseObject objectForKey:@"advisoryTitle"] isEqual:[NSNull null]]) {
                _tit.text =@" ";
                
            }else {
                _tit.text = [responseObject objectForKey:@"advisoryTitle"];
            }
            
            if ([[responseObject objectForKey:@"advisoryType"] isEqual:[NSNull null]]) {
            }else{
                
                if ([[responseObject objectForKey:@"advisoryType"] intValue]==1) {
                    _type.text = @"就业";
                }else {
                    _type.text = @"实习";
                }
            }
        
            _time.text = [responseObject objectForKey:@"advisoryTime"];
        
            
            if ([[responseObject objectForKey:@"advisoryContent"] isEqual:[NSNull null]]) {
                _problem.text =@" ";
                
            }else {
                _problem.text = [responseObject objectForKey:@"advisoryContent"];
                
            }
            
            
            if ([[responseObject objectForKey:@"state"] intValue]==1) {
                               _hftime.text = [responseObject objectForKey:@"reportTime"];
                _huif.text=  [responseObject objectForKey:@"menName"];
                _reppro.text = [responseObject objectForKey:@"reportContent"];
            }else {
                _reppro.text =@" ";
                
            }
            
            
            
            
            
            
            
            
        } @catch (NSException *exception) {
           [WarningBox warningBoxModeText:@"" andView:self.view];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络连接失败！" andView:self.view];
    }];
    
    

    // Do any additional setup after loading the view.
}

-(void)daohang{
    //设置导航条属性
    self.navigationController.navigationBar.barTintColor =[UIColor colorWithRed:95/255.0 green:193/255.0 blue:255/255.0 alpha:1];
    self.title  =@"回复详情";
    UIButton  *backbtn = [[UIButton alloc]initWithFrame:CGRectMake(15,10, 20, 20)];
    [backbtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backbutton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftben = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    self.navigationItem.leftBarButtonItem =leftben;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}

-(void)backbutton:(UIButton*)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
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
