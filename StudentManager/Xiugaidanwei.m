//
//  Xiugaidanwei.m
//  爱实习
//
//  Created by 张文宇 on 16/7/29.
//  Copyright © 2016年 张文宇. All rights reserved.
//

#import "Xiugaidanwei.h"
#import "WarningBox.h"
#import "AFHTTPSessionManager.h"
#import "SBJson.h"
#import "Color+Hex.h"

@interface Xiugaidanwei ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    NSMutableDictionary *linshiDic1;
    
    NSString *linshiPath1;

    NSString *path2;
    
    NSMutableArray *dataArr;
    
    NSString *companyProvinceId;
    
    NSString *companyCityId;
    
    UITableView *shengTableView;
    
    UITableView *shiTableView;
    
    NSMutableArray *sheng;
    
    NSMutableArray *shi;
    
    NSMutableArray *pId;
    
    NSMutableArray *cId;
    
    float MaxX,MaxY,MaxY1,MaxW,MaxH;
    
    int mm;
    
    int n,kk;
    
}
@end

@implementation Xiugaidanwei

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mm=0;
    
    n=0;
    
    kk=0;
    
    self.navigationItem.title = @"单位信息修改";
    
    //设置导航栏的文字大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
     self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"5fc1ff"];
    //按钮大小
    int MaxWidth = 20,MaxHeigth = 20;
    
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
    
    [self.shenlabel.layer setCornerRadius:10];
    [self.shenlabel.layer setBorderWidth:1];
    [self.shenlabel.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [self.shilabel.layer setCornerRadius:10];
    [self.shilabel.layer setBorderWidth:1];
    [self.shilabel.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [WarningBox warningBoxModeIndeterminate:@"加载中..." andView:self.view];
    
    
    // 文件路径
    linshiPath1 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/linshi.plist"];
    
    // 读取数据
    linshiDic1 = [NSMutableDictionary dictionaryWithContentsOfFile:linshiPath1];
    
    
    path2 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/province.plist"];
    
    dataArr = [NSMutableArray arrayWithContentsOfFile:path2];
    
    //NSLog(@"dataDic===%@",dataDic);
    
    if (linshiDic1[@"companyName"]==nil) {
        self.danweiTextField.text = @"";
    } else {
        self.danweiTextField.text = [NSString stringWithFormat:@"%@",linshiDic1[@"companyName"]];
    }
    if (linshiDic1[@"department"]==nil) {
        self.bumenTxetField.text = @"";
    } else {
        self.bumenTxetField.text = [NSString stringWithFormat:@"%@",linshiDic1[@"department"]];
    }
    if (linshiDic1[@"post"]==nil) {
        self.zhiweiTextField.text = @"";
    } else {
        self.zhiweiTextField.text = [NSString stringWithFormat:@"%@",linshiDic1[@"post"]];
    }
    if (linshiDic1[@"companyPhone"]==nil) {
        self.danweidianhuaTextField.text = @"";
    } else {
        self.danweidianhuaTextField.text = [NSString stringWithFormat:@"%@",linshiDic1[@"companyPhone"]];
    }
    if (linshiDic1[@"companyAddress"]==nil) {
        self.danweidizhiTextFiled.text = @"";
    } else {
        self.danweidizhiTextFiled.text = [NSString stringWithFormat:@"%@",linshiDic1[@"companyAddress"]];
    }
    if (linshiDic1[@"companyProvinceId"]==nil) {
        self.shenlabel.text = @"";
    } else {
        
        for (int i=0; i<[dataArr count]; i++) {
            
            NSDictionary *aa = [NSDictionary dictionaryWithDictionary:dataArr[i]];
            
            if ([aa[@"provinceId"] isEqual:linshiDic1[@"companyProvinceId"]]) {
                
                self.shenlabel.text = [NSString stringWithFormat:@"%@",aa[@"provinceName"]];
                
                companyProvinceId = [NSString stringWithFormat:@"%@",aa[@"provinceId"]];
                
                //展示市名称
                if (linshiDic1[@"companyCityId"]==nil) {
                    self.shilabel.text = @"";
                } else {
                    
                    NSArray *arr = [NSArray arrayWithArray:aa[@"citys"]];
                    
                    for (int k=0; k<[arr count]; k++) {
                        
                        NSDictionary *bb = [NSDictionary dictionaryWithDictionary:arr[k]];
                        
                        if ([bb[@"cityId"] isEqual:linshiDic1[@"companyCityId"]]) {
                            
                            self.shilabel.text = [NSString stringWithFormat:@"%@",bb[@"cityName"]];
                            
                            companyCityId = [NSString stringWithFormat:@"%@",bb[@"cityId"]];
                            
                        }
                    }
                    
                }
            }
        }
    }
    
    
    MaxX = 35;
    
    //适配4s
    if ([[UIScreen mainScreen] bounds].size.height==480) {
        MaxY = CGRectGetMaxY(self.shenlabel.frame)-205;
        MaxY1 =CGRectGetMaxY(self.shilabel.frame)-205;
        
        MaxH = 200;
        NSLog(@"4s");
    } else {
        
        MaxY = CGRectGetMaxY(self.shenlabel.frame)+45;
        
        MaxY1 =CGRectGetMaxY(self.shilabel.frame)+45;
        
        MaxH = 150;
    }
    
    MaxW = [[UIScreen mainScreen] bounds].size.width-70;
    
    shengTableView = [[UITableView alloc] initWithFrame:CGRectMake(MaxX , MaxY, MaxW, MaxH)];
    shengTableView.backgroundColor = [UIColor colorWithRed:99/255.0 green:194/255.0 blue:252/255.0 alpha:1];
    
    shengTableView.delegate = self;
    shengTableView.dataSource = self;
    
    
    shiTableView = [[UITableView alloc] initWithFrame:CGRectMake(MaxX , MaxY1, MaxW, MaxH)];
    shiTableView.backgroundColor = [UIColor colorWithRed:99/255.0 green:194/255.0 blue:252/255.0 alpha:1];
    
    shiTableView.delegate = self;
    shiTableView.dataSource = self;
    
    _danweiTextField.delegate = self;
    _bumenTxetField.delegate = self;
    _zhiweiTextField.delegate = self;
    _danweidianhuaTextField.delegate = self;
    _danweidizhiTextFiled.delegate = self;
    
    [WarningBox warningBoxHide:YES andView:self.view];
}



//返回上一页
- (void)back:(id)sender{
    
    if ([_danweiTextField.text isEqual:@""] || [_bumenTxetField.text isEqual:@""] || [_zhiweiTextField.text isEqual:@""] || [_danweidianhuaTextField.text isEqual:@""] || [_danweidianhuaTextField.text isEqual:@""]) {
        
        [WarningBox warningBoxTopModeText:@"信息不能为空，请补全！" andView:self.view];
    } else {

    [WarningBox warningBoxModeIndeterminate:@"加载中..." andView:self.view];

        [WarningBox warningBoxModeIndeterminate:@"加载中..." andView:self.view];
        
        [linshiDic1 setValue:_danweiTextField.text forKey:@"companyName"];
        [linshiDic1 setValue:_bumenTxetField.text forKey:@"department"];
        [linshiDic1 setValue:_zhiweiTextField.text forKey:@"post"];
        [linshiDic1 setValue:_danweidianhuaTextField.text forKey:@"companyPhone"];
        [linshiDic1 setValue:_danweidizhiTextFiled.text forKey:@"companyAddress"];
        [linshiDic1 setValue:companyProvinceId forKey:@"companyProvinceId"];
        [linshiDic1 setValue:companyCityId forKey:@"companyCityId"];
        [linshiDic1 writeToFile:linshiPath1 atomically:YES];
    
    [WarningBox warningBoxHide:YES andView:self.view];
    
    [self.navigationController popViewControllerAnimated:YES];
    }
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

- (IBAction)shenBtn:(id)sender {
    
    //适配4s
    if ([[UIScreen mainScreen] bounds].size.height==480) {
        
        _biankuangview.hidden = YES;
    }
    if (n==0){
        [shiTableView removeFromSuperview];
        sheng = [[NSMutableArray alloc] init];
        pId = [[NSMutableArray alloc] init];
        
        for (int i=0; i<[dataArr count]; i++) {
            
            NSString *pp = [NSString stringWithString:dataArr[i][@"provinceName"]];
            
            NSString *ID = [NSString stringWithString:dataArr[i][@"provinceId"]];
            
            [sheng addObject:pp];
            [pId addObject:ID];
            
        }
        [shengTableView reloadData];
        
        [self.view addSubview:shengTableView];
        
        n = 1;
    }else{
        [shengTableView removeFromSuperview];
        
        n = 0;
    }
    
    
}

- (IBAction)shiBtn:(id)sender {
    //适配4s
    if ([[UIScreen mainScreen] bounds].size.height==480) {
        
        _biankuangview.hidden = YES;
    }
    
    if (kk==0) {

    shi = [[NSMutableArray alloc] init];
    cId = [[NSMutableArray alloc] init];
    NSArray *carr;
    
    for (int i=0; i<dataArr.count; i++) {
        if ([dataArr[i][@"provinceId"] isEqual:companyProvinceId]) {
            NSDictionary *pdic = [NSDictionary dictionaryWithDictionary:dataArr[i]];
            carr = [NSArray arrayWithArray:pdic[@"citys"]];
            NSLog(@"%@",carr);
        }
    }
    
    for (int k=0; k<[carr count]; k++) {
        
        NSString *cc = [NSString stringWithFormat:@"%@",carr[k][@"cityName"]];
        
        NSString *cid = [NSString stringWithFormat:@"%@",carr[k][@"cityId"]];
        [shi addObject:cc];
        [cId addObject:cid];
    }
    [shiTableView reloadData];
    
    [self.view addSubview:shiTableView];
        kk=1;
    }else{
        
        [shiTableView removeFromSuperview];
        kk=0;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==shengTableView) {
        return sheng.count;
    }
    
        return shi.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *aa=@"celled";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:aa];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aa];
    }
    
    NSArray *arr=[cell.contentView subviews];
    
    for (UIView *vv in arr) {
        [vv removeFromSuperview];
    }

    UILabel *ll = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MaxW, 44)];
    
    ll.backgroundColor =[UIColor colorWithRed:99/255.0 green:194/255.0 blue:252/255.0 alpha:1];
    ll.font = [UIFont systemFontOfSize:14];
    ll.textColor = [UIColor whiteColor];
    ll.textAlignment = NSTextAlignmentCenter;
    
    if (tableView==shengTableView) {
        ll.text = sheng[indexPath.row];
    }else{
        
        ll.text = shi[indexPath.row];
    }
    
    [cell.contentView addSubview:ll];
    return cell;
    
}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

//tableView点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==shengTableView) {
        //适配4s
        if ([[UIScreen mainScreen] bounds].size.height==480) {
            
            _biankuangview.hidden = NO;
        }
        //取消选中
        [shengTableView deselectRowAtIndexPath:indexPath animated:YES];
        
        [self.shenlabel setText:[sheng objectAtIndex:indexPath.row]];
        
        companyProvinceId = [NSString stringWithFormat:@"%@",pId[indexPath.row]];
        
        [shengTableView removeFromSuperview];
        n=0;
        
    }else{
        //适配4s
        if ([[UIScreen mainScreen] bounds].size.height==480) {
            
            _biankuangview.hidden = NO;
        }

        //取消选中
        [shiTableView deselectRowAtIndexPath:indexPath animated:YES];
        
        [self.shilabel setText:[shi objectAtIndex:indexPath.row]];
        
        companyCityId = [NSString stringWithFormat:@"%@",cId[indexPath.row]];
        
        [shiTableView removeFromSuperview];
        
        kk=0;
        
    }
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_danweiTextField resignFirstResponder];
    [_danweidianhuaTextField resignFirstResponder];
    [_danweidizhiTextFiled resignFirstResponder];
    [_bumenTxetField resignFirstResponder];
    [_zhiweiTextField resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == _danweidianhuaTextField) {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
        if ([toBeString length] > 11) { //如果输入框内容大于20则弹出警告
            textField.text = [toBeString substringToIndex:11];
            
            [WarningBox warningBoxTopModeText:@"号码数位已超，请不要再输了！" andView:self.view];
            return NO;
        }
    }
    return YES;
    
}


@end
