//
//  Xiugai.m
//  爱实习
//
//  Created by 张文宇 on 16/7/29.
//  Copyright © 2016年 张文宇. All rights reserved.
//

#import "Xiugai.h"
#import "Xiugaidanwei.h"
#import "Dizhixiugai.h"
#import "Xiugaimima.h"
#import "SBJson.h"
#import "AFHTTPSessionManager.h"
#import "WarningBox.h"
#import "Zhuye_ViewController.h"
#import "Color+Hex.h"

@interface Xiugai ()<UITextFieldDelegate>
{
    float width,height;
    UIButton *leftBtn;
    UIButton *leftBtn1;
    UIBarButtonItem *leftItem;
    UIBarButtonItem *leftItem1;
    UIButton *rightBtn;
    UIButton *rightBtn1;
    UIBarButtonItem *rightItem;
    UIBarButtonItem *rightItem1;
    NSString *isInPost;
    NSString *path;
    NSMutableDictionary *dataDic;
    int k;
    
    NSString *linshiPath;
    
    NSMutableDictionary *linshiDic;
    
    int mm;
    
    int n;

}
@end

@implementation Xiugai

- (void)viewDidLoad {
    [super viewDidLoad];
    
    k=0;
    
    isInPost = [[NSString alloc] init];
    
    width = [UIScreen mainScreen].bounds.size.width;
    
    height = [UIScreen mainScreen].bounds.size.height;
    
    self.navigationItem.title = @"修改";
    //设置导航栏的文字大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"5fc1ff"];    
    //按钮大小
    int MaxWidth=40,MinWidth=20,MaxHeigth=20;
    
    //设置导航栏左侧按钮
    leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, MinWidth, MaxHeigth)];
    leftBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, MaxWidth, MaxHeigth)];
    [leftBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    
    [leftBtn1 setTitle:@"取消" forState:UIControlStateNormal];

    [leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn1 addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    leftItem =[[UIBarButtonItem alloc]initWithCustomView: leftBtn];
    leftItem1 =[[UIBarButtonItem alloc]initWithCustomView: leftBtn1];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //设置导航栏右侧按钮
    rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(width-MaxWidth, 0, MaxWidth, MaxHeigth)];
    
    rightBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(width-MaxWidth, 0, MaxWidth, MaxHeigth)];
    
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    
    [rightBtn1 setTitle:@"保存" forState:UIControlStateNormal];
    
    [rightBtn setTintColor:[UIColor whiteColor]];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    
    [rightBtn1 setTintColor:[UIColor whiteColor]];
    rightBtn1.titleLabel.font = [UIFont systemFontOfSize:18];
    
    [rightBtn addTarget:self action:@selector(bianjiorbaocun:) forControlEvents:UIControlEventTouchUpInside];
    
    [rightBtn1 addTarget:self action:@selector(bianjiorbaocun:) forControlEvents:UIControlEventTouchUpInside];
    rightItem =[[UIBarButtonItem alloc]initWithCustomView: rightBtn];
    rightItem1 =[[UIBarButtonItem alloc]initWithCustomView: rightBtn1];
    
    self.navigationItem.rightBarButtonItem = rightItem1;
 
    //设置边框
    [self.biankuangview.layer setCornerRadius:10];
    [self.biankuangview.layer setBorderWidth:1];
    [self.biankuangview.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    

    
    _yuexintextfield.delegate = self;
    _dianhuatextfield.delegate = self;
    
    n=0;
    [WarningBox warningBoxModeIndeterminate:@"加载中..." andView:self.view];
    [self shuju];
    [WarningBox warningBoxHide:YES andView:self.view];

}

-(void)viewWillAppear:(BOOL)animated{
    
//    if (n==1) {
//        
//        [self linshishuju];
//    } else {
        [self shuju];
    //}

}

-(void)shuju{
    // 文件路径
    path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/userInfo.plist"];
    
    // 读取数据
    dataDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
   // NSLog(@"userinfo-------%@",dataDic);
    
    if (dataDic[@"money"]==nil) {
        self.yuexintextfield.text = @"";
    } else {
        self.yuexintextfield.text = [NSString stringWithFormat:@"%@",dataDic[@"money"]];
    }
    
    if (dataDic[@"companyName"]==nil) {
        self.danweilabel.text = @"";
    } else {
        self.danweilabel.text = [NSString stringWithFormat:@"%@",dataDic[@"companyName"]];
    }
    
    if (dataDic[@"lodgingAddress"]==nil) {
        self.dizhilabel.text = @"";
    } else {
        self.dizhilabel.text = [NSString stringWithFormat:@"%@",dataDic[@"lodgingAddress"]];
    }
    
    if (dataDic[@"studentPhone"]==nil) {
        self.dianhuatextfield.text = @"";
    } else {
        self.dianhuatextfield.text = [NSString stringWithFormat:@"%@",dataDic[@"studentPhone"]];
    }
    
    if ([dataDic[@"isInPost"] intValue]==0) {
        [self.noBtn setImage:[UIImage imageNamed:@"xuanzhong@2x.png"] forState:UIControlStateNormal];                    //上 左  下  右
        //[self.noBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self.yesBtn setImage:[UIImage imageNamed:@"checkbox@2x.png"] forState:UIControlStateNormal];
        //[self.yesBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
        [self.noBtn setImage:[UIImage imageNamed:@"xuanzhong@2x.png"] forState:UIControlStateDisabled];
        [self.yesBtn setImage:[UIImage imageNamed:@"checkbox@2x.png"] forState:UIControlStateDisabled];
        isInPost = [NSString stringWithFormat:@"0"];
        
    } else {
        
        [self.yesBtn setImage:[UIImage imageNamed:@"xuanzhong@2x.png"] forState:UIControlStateNormal];
        [self.noBtn setImage:[UIImage imageNamed:@"checkbox@2x.png"] forState:UIControlStateNormal];
        [self.yesBtn setImage:[UIImage imageNamed:@"xuanzhong@2x.png"] forState:UIControlStateDisabled];
        [self.noBtn setImage:[UIImage imageNamed:@"checkbox@2x.png"] forState:UIControlStateDisabled];
        isInPost = [NSString stringWithFormat:@"1"];
    }
    

}


- (void)linshishuju{
    
    NSString *linshiPath1 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/linshi.plist"];
    
   
    
    
    NSMutableDictionary *linshiDic1 = [NSMutableDictionary dictionaryWithContentsOfFile:linshiPath1];
    
    
    if (linshiDic1[@"money"]==nil) {
        self.yuexintextfield.text = @"";
    } else {
        self.yuexintextfield.text = [NSString stringWithFormat:@"%@",linshiDic1[@"money"]];
    }
    
    if (linshiDic1[@"companyName"]==nil) {
        self.danweilabel.text = @"";
    } else {
        self.danweilabel.text = [NSString stringWithFormat:@"%@",linshiDic1[@"companyName"]];
    }
    
    if (linshiDic1[@"lodgingAddress"]==nil) {
        self.dizhilabel.text = @"";
    } else {
        self.dizhilabel.text = [NSString stringWithFormat:@"%@",linshiDic1[@"lodgingAddress"]];
    }
    
    if (linshiDic1[@"studentPhone"]==nil) {
        self.dianhuatextfield.text = @"";
    } else {
        self.dianhuatextfield.text = [NSString stringWithFormat:@"%@",linshiDic1[@"studentPhone"]];
    }
    
    if ([linshiDic1[@"isInPost"] intValue]==0) {
        [self.noBtn setImage:[UIImage imageNamed:@"xuanzhong.png"] forState:UIControlStateNormal];
        [self.yesBtn setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
        [self.noBtn setImage:[UIImage imageNamed:@"xuanzhong.png"] forState:UIControlStateDisabled];
        [self.yesBtn setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateDisabled];
        isInPost = [NSString stringWithFormat:@"0"];
        
    } else {
        
        [self.yesBtn setImage:[UIImage imageNamed:@"xuanzhong.png"] forState:UIControlStateNormal];
        [self.noBtn setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
        [self.yesBtn setImage:[UIImage imageNamed:@"xuanzhong.png"] forState:UIControlStateDisabled];
        [self.noBtn setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateDisabled];
        isInPost = [NSString stringWithFormat:@"1"];
    }
    
}


- (void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)bianjiorbaocun:(id)sender{

//        linshiPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/linshi.plist"];
//
//        NSMutableDictionary *lDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
//        
//        [lDic writeToFile:linshiPath atomically:YES];

    [self save];
   
    // n=1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)xiuggaidanweiBtn:(id)sender {
    if ([isInPost intValue]==0) {
        
        [WarningBox warningBoxTopModeText:@"不在岗时，不能编辑企业信息！" andView:self.view];
        
    }else{
        Xiugaidanwei *xd = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"xgdw"];

        [self.navigationController pushViewController:xd animated:YES];
    }

}

- (IBAction)xiugaidizhiBtn:(id)sender {
    
    Dizhixiugai *dz = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"xgdz"];

    
    [self.navigationController pushViewController:dz animated:YES];

}

- (IBAction)xiugaimimaBtn:(id)sender {
    
    Xiugaimima *xm = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"xgmm"];

    
    [self.navigationController pushViewController:xm animated:YES];

}

- (IBAction)YESorNO:(id)sender {
    
    //判断是否在岗
    if (self.yesBtn==sender) {
        [self.yesBtn setImage:[UIImage imageNamed:@"xuanzhong.png"] forState:UIControlStateNormal];
        [self.yesBtn setImage:[UIImage imageNamed:@"xuanzhong.png"] forState:UIControlStateDisabled];
        [self.noBtn setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
        [self.noBtn setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateDisabled];
        isInPost = [NSString stringWithFormat:@"1"];
    
    } else {
        
        [self.noBtn setImage:[UIImage imageNamed:@"xuanzhong.png"] forState:UIControlStateNormal];
        [self.yesBtn setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
        [self.noBtn setImage:[UIImage imageNamed:@"xuanzhong.png"] forState:UIControlStateDisabled];
        [self.yesBtn setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateDisabled];
        isInPost = [NSString stringWithFormat:@"0"];
    }
    
}
//保存数据
-(void)save{
    //保存修改信息
     linshiPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/userinfo.plist"];
    
    linshiDic = [NSMutableDictionary dictionaryWithContentsOfFile:linshiPath];
    
   // NSLog(@"JSON---%@",linshiDic);
    
    
    [linshiDic setObject:[NSString stringWithFormat:@"%@", isInPost ] forKey:@"isInPost"];
    [linshiDic setObject:[NSString stringWithFormat:@"%@", self.yuexintextfield.text ] forKey:@"money"];
    [linshiDic setObject:[NSString stringWithFormat:@"%@", self.dianhuatextfield.text ] forKey:@"studentPhone"];
    [linshiDic writeToFile:linshiPath atomically:YES];
    
    [linshiDic writeToFile:path atomically:YES];
    
    [WarningBox warningBoxModeIndeterminate:@"保存中..." andView:self.view];
    
    //拿到学校IP和studentID
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    //    [def objectForKey:@"IP"];
    //    [def objectForKey:@"studentId"];

    [linshiDic setValue:[def objectForKey:@"studentId"] forKey:@"studentId"];

    //将上传对象转换为json类型
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    
    //上传参数
        
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSString *jsonstring = [writer stringWithObject:linshiDic];
    
 
    
    NSDictionary *MSG = [NSDictionary dictionaryWithObjectsAndKeys:jsonstring,@"MSG", nil];
    NSString *url = [NSString stringWithFormat:@"http://%@/job/intf/mobile/gate.shtml?command=stuinfomod",[def objectForKey:@"IP"]];
    
    [manager POST:url parameters:MSG progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [WarningBox warningBoxHide:YES andView:self.view];
        
        [WarningBox warningBoxModeText:@"信息保存成功！" andView:self.view];
        
        Zhuye_ViewController *zhuye = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"zhuye"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController pushViewController:zhuye animated:YES];
        });
        
      
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [WarningBox warningBoxHide:YES andView:self.view];
        
        [WarningBox warningBoxModeText:@"网络异常，请重试！" andView:self.view];
        
        NSLog(@"%@",error);
        
    }];
   

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_yuexintextfield resignFirstResponder];
    [_dianhuatextfield resignFirstResponder];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == _dianhuatextfield) {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
        if ([toBeString length] > 11) { //如果输入框内容大于20则弹出警告
            textField.text = [toBeString substringToIndex:11];
            
           
            return NO;
        }
    }
    return YES;
}

@end
