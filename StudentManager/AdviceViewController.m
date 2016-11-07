//
//  AdviceViewController.m
//  StudentManager
//
//  Created by newmac on 16/7/29.
//  Copyright © 2016年 newmac. All rights reserved.
//

#import "AdviceViewController.h"
#import "AFHTTPSessionManager.h"
#import "SBJson.h"
#import "WarningBox.h"
@interface AdviceViewController ()
{
    UILabel *place;
}
@end

@implementation AdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    
    
    
    
    _textview.delegate = self;
    place = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 150, 20)];
    place.text = @"请输入您的建议...";
    place.textColor = [UIColor colorWithRed:213.0/255 green:213.0/255 blue:218.0/255 alpha:1.0];
    place.font =[UIFont systemFontOfSize:14];
    place.backgroundColor = [UIColor clearColor];
    [_textview addSubview:place];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.hidden = NO;
    self.title  =@"用户建议";
    UIButton  *backbtn = [[UIButton alloc]initWithFrame:CGRectMake(15,10, 20, 20)];
    [backbtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backbutton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftben = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    self.navigationItem.leftBarButtonItem =leftben;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.textview.layer setCornerRadius:10];
    [self.refer.layer setCornerRadius:10];
    [self.refer setBackgroundColor:[UIColor whiteColor]];
    
    
    
    
    
    UIToolbar *tool = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,30)];//创建一个toolbar
    UIBarButtonItem *bb1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *wan = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(wancheng)];
    NSArray *arrr = [NSArray arrayWithObjects:bb1,wan, nil];
    
    [tool setItems:arrr];
    //[self.textview setInputAccessoryView:tool];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backbutton:(UIButton*)btn{
    
    
     [self.navigationController popViewControllerAnimated:YES];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.textview resignFirstResponder];
}


-(void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length==0) {
         place.text = @"请输入您的建议...";
    }
    else {
        place.text = @" ";
    }
}


-(void)wancheng{
    [self.textview resignFirstResponder];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submit:(id)sender {
    
    
    if([_textview.text isEqualToString:@""])
    {
   [WarningBox warningBoxModeText:@"请输入您的建议" andView:self.view];
    }else{
    
    //拿到存的学校IP和studentId
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];

   
  [WarningBox warningBoxModeIndeterminate:@"提交中..." andView:self.view];
    
    
    //将上传对象转换为json格式字符串
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc]init];
    
    //出入参数：
    //studentid需要传过来
    NSDictionary*datadic=[NSDictionary dictionaryWithObjectsAndKeys:_textview.text,@"advicecontent",[def objectForKey:@"studentId"],@"studentId", nil];
    
    
    NSString *jsonstring =[writer stringWithObject:datadic];
    
    
    NSString *url = [NSString stringWithFormat:@"http://%@/job/intf/mobile/gate.shtml?command=userback",[def objectForKey:@"IP"]];
   
    
   NSDictionary *msg = [NSDictionary dictionaryWithObjectsAndKeys:jsonstring,@"MSG", nil];
    
    [manager POST:url parameters:msg progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @try {
           // NSLog(@"用户意见%@",responseObject);
            if ([[responseObject objectForKey:@"result"]intValue]==0){
            [WarningBox warningBoxHide:YES andView:self.view];
            
            [WarningBox warningBoxModeText:@"上传成功！" andView:self.view];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
            }
            else{
            [WarningBox warningBoxModeText:@"上传失败，请重试" andView:self.view];
            }
          
        } @catch (NSException *exception) {
           [WarningBox warningBoxModeText:@"" andView:self.view];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络连接失败！" andView:self.view];
    }];
    
    }
 
    
    
}
@end
