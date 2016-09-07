//
//  Xiugaimima.m
//  爱实习
//
//  Created by 张文宇 on 16/7/29.
//  Copyright © 2016年 张文宇. All rights reserved.
//

#import "Xiugaimima.h"
#import "AFNetworking.h"
#import "WarningBox.h"
#import "SBJson.h"
#import "Color+Hex.h"
#import "Denglu_ViewController.h"

@interface Xiugaimima ()<UITextFieldDelegate>

@end

@implementation Xiugaimima

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"修改密码";
    //按钮大小
    int MaxWidth = 20,MaxHeigth = 20;
    
     self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"5fc1ff"];
    
    //设置导航栏左侧按钮
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, MaxWidth, MaxHeigth)];
    [leftBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc]initWithCustomView: leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //设置边框
    [self.biankuangview.layer setCornerRadius:10];
    [self.biankuangview.layer setBorderWidth:1];
    [self.biankuangview.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [self.querenBtn.layer setCornerRadius:10];
    [self.querenBtn.layer setBorderWidth:1];
    [self.querenBtn.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
   
    self.xinmimaTextField.delegate = self;
    self.querenmimaTextField.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)queren:(id)sender {
    
    [_querenmimaTextField resignFirstResponder];
    
    if ([_xinmimaTextField.text isEqual:@""] || [_querenmimaTextField isEqual:@""]) {
        
        [WarningBox warningBoxTopModeText:@"请将密码填写完全！" andView:self.view];
        
    }else if(![_xinmimaTextField.text isEqual:_querenmimaTextField.text]){
        
        [WarningBox warningBoxTopModeText:@"两次输入不同，请重新输入！" andView:self.view];
        
        _xinmimaTextField.text = @"";
        
        _querenmimaTextField.text = @"";
        
        [_xinmimaTextField becomeFirstResponder];
        
    } else {
       
    [WarningBox warningBoxModeIndeterminate:@"修改中..." andView:self.view];
    
        
        
        //拿到学校IP和studentID
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        //    [def objectForKey:@"IP"];
        //    [def objectForKey:@"studentId"];
        
    //将上传对象转换为json类型
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    
    //上传参数
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId",_xinmimaTextField.text,@"password", nil];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSString *jsonstring = [writer stringWithObject:dic];
    
    NSDictionary *MSG = [NSDictionary dictionaryWithObjectsAndKeys:jsonstring,@"MSG", nil];
    NSString *url = [NSString stringWithFormat:@"http://%@/job/intf/mobile/gate.shtml?command=stupasswordmod",[def objectForKey:@"IP"]];
    
    [manager POST:url parameters:MSG progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
       // NSLog(@"%@",responseObject);
        
        [WarningBox warningBoxHide:YES andView:self.view];
        
        [WarningBox warningBoxModeText:@"修改成功！" andView:self.view];
        Denglu_ViewController *dlvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"denglu"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController pushViewController:dlvc animated:YES];        });

       
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [WarningBox warningBoxHide:YES andView:self.view];
        
        [WarningBox warningBoxModeText:@"网络异常，请重试！" andView:self.view];
        
      //  NSLog(@"%@",error);
        
    }];
        
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _xinmimaTextField) {
        [_querenmimaTextField becomeFirstResponder];
        
    }
    if (textField == _querenmimaTextField) {
        
        if ([_xinmimaTextField.text isEqual:_querenmimaTextField.text]) {
            [_querenmimaTextField resignFirstResponder];
            
            [_querenmimaTextField resignFirstResponder];
            
            [self queren:nil];
            
        } else {
            [WarningBox warningBoxTopModeText:@"两次输入不同，请重新输入！" andView:self.view];
            _xinmimaTextField.text = @"";
            
            _querenmimaTextField.text = @"";
            
            [_xinmimaTextField becomeFirstResponder];
            
        }
    }
    
    return YES;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_xinmimaTextField resignFirstResponder];
    [_querenmimaTextField resignFirstResponder];
}
@end
