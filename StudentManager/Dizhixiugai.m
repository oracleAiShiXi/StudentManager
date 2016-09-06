//
//  Dizhixiugai.m
//  爱实习
//
//  Created by 张文宇 on 16/7/29.
//  Copyright © 2016年 张文宇. All rights reserved.
//

#import "Dizhixiugai.h"
#import "WarningBox.h"
#import "Color+Hex.h"
@interface Dizhixiugai ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSMutableDictionary *linshiDic1;
    
    NSString *linshiPath1;
    
    NSString *path2;
    
    NSMutableArray *dataArr;
    
    NSString *lodgingProvinceId;
    
    NSString *lodgingCityId;
    
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

@implementation Dizhixiugai

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mm=0;
    
    n=0;
    
    kk=0;
    
    self.navigationItem.title = @"住宿地址修改";
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
    
    [self.shenlabel.layer setCornerRadius:10];
    [self.shenlabel.layer setBorderWidth:1];
    [self.shenlabel.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [self.shilabel.layer setCornerRadius:10];
    [self.shilabel.layer setBorderWidth:1];
    [self.shilabel.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    // 文件路径
    linshiPath1 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/userinfo.plist"];
    
    // 读取数据
    linshiDic1 = [NSMutableDictionary dictionaryWithContentsOfFile:linshiPath1];
    
    // 省市文件路径
    path2 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/province.plist"];
    //读取省市文件
    dataArr = [NSMutableArray arrayWithContentsOfFile:path2];

    
    if (linshiDic1[@"expName"]==nil) {
        self.jinjilianxirenTextField.text = @"";
    } else {
        self.jinjilianxirenTextField.text = [NSString stringWithFormat:@"%@",linshiDic1[@"expName"]];
    }
    if (linshiDic1[@"expPhone"]==nil) {
        self.lianxidianhuaTextField.text = @"";
    } else {
        self.lianxidianhuaTextField.text = [NSString stringWithFormat:@"%@",linshiDic1[@"expPhone"]];
    }
    if (linshiDic1[@"lodgingAddress"]==nil) {
        self.zhusudizhiTextField.text = @"";
    } else {
        self.zhusudizhiTextField.text = [NSString stringWithFormat:@"%@",linshiDic1[@"lodgingAddress"]];
    }
    
    
    if (linshiDic1[@"lodgingProvinceId"]==nil) {
        self.shenlabel.text = @"";
    } else {

        for (int i=0; i<[dataArr count]; i++) {
            
            NSDictionary *pp = [NSDictionary dictionaryWithDictionary:dataArr[i]];
            
            if ([pp[@"provinceId"] isEqual:linshiDic1[@"lodgingProvinceId"]]) {
                
                self.shenlabel.text = [NSString stringWithFormat:@"%@",pp[@"provinceName"]];
                lodgingProvinceId = [NSString stringWithFormat:@"%@",pp[@"provinceId"]];
                
                //展示市名称
                if (linshiDic1[@"lodgingCityId"]==nil) {
                    self.shilabel.text = @"";
                } else {
                    
                    NSArray *arr = [NSArray arrayWithArray:pp[@"citys"]];
                    
                    for (int k=0; k<[arr count]; k++) {
                        
                        NSDictionary *bb = [NSDictionary dictionaryWithDictionary:arr[k]];
                        
                        if ([bb[@"cityId"] isEqual:linshiDic1[@"lodgingCityId"]]) {
                            
                            self.shilabel.text = [NSString stringWithFormat:@"%@",bb[@"cityName"]];
                            
                            lodgingCityId = [NSString stringWithFormat:@"%@",bb[@"cityId"]];
                        }
                    }
                    
                }
            }
        }
    }

    
    
    MaxX = 35;
    
    MaxY = CGRectGetMaxY(self.shenlabel.frame)+45;
    
    MaxY1 =CGRectGetMaxY(self.shilabel.frame)+45;
    
    MaxW = [[UIScreen mainScreen] bounds].size.width-70;
    
    MaxH = 150;
    
    shengTableView = [[UITableView alloc] initWithFrame:CGRectMake(MaxX , MaxY, MaxW, MaxH)];
    shengTableView.backgroundColor = [UIColor colorWithRed:99/255.0 green:194/255.0 blue:252/255.0 alpha:1];
    
    shengTableView.delegate = self;
    shengTableView.dataSource = self;
    
    
    shiTableView = [[UITableView alloc] initWithFrame:CGRectMake(MaxX , MaxY1, MaxW, MaxH)];
    shiTableView.backgroundColor = [UIColor colorWithRed:99/255.0 green:194/255.0 blue:252/255.0 alpha:1];
    
    shiTableView.delegate = self;
    shiTableView.dataSource = self;
    
    _jinjilianxirenTextField.delegate = self;
    _lianxidianhuaTextField.delegate = self;
    _zhusudizhiTextField.delegate = self;
    
    
   }
- (void)back:(id)sender{
    
    if ([_jinjilianxirenTextField.text isEqual:@""] || [_lianxidianhuaTextField.text isEqual:@""] || [_zhusudizhiTextField.text isEqual:@""]) {
        
        [WarningBox warningBoxTopModeText:@"信息不能为空，请补全！" andView:self.view];
    } else {

    [WarningBox warningBoxModeIndeterminate:@"加载中..." andView:self.view];
    
    [linshiDic1 setValue:lodgingProvinceId forKey:@"lodgingProvinceId"];
    
    [linshiDic1 setValue:lodgingCityId forKey:@"lodgingCityId"];
    
    [linshiDic1 setValue:_jinjilianxirenTextField.text forKey:@"expName"];
    
    [linshiDic1 setValue:_lianxidianhuaTextField.text forKey:@"expPhone"];
    
    [linshiDic1 setValue:_zhusudizhiTextField.text forKey:@"lodgingAddress"];
    
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
    
    [shiTableView removeFromSuperview];
    
    if (n==0) {
        sheng = [[NSMutableArray alloc] init];
        pId = [[NSMutableArray alloc] init];
        
        for (int i=0; i<[dataArr count]; i++) {
            
            NSString *pp = [NSString stringWithString:dataArr[i][@"provinceName"]];
            
            NSString *ID = [NSString stringWithString:dataArr[i][@"provinceId"]];
            
            [sheng addObject:pp];
            [pId addObject:ID];
            
        }
        self.biankuangview.hidden = YES;
        
        [shengTableView reloadData];
        
        [self.view addSubview:shengTableView];
        
        n=1;

    }else{
        
        [shengTableView removeFromSuperview];
        
        self.biankuangview.hidden = NO;
        
        n=0;
    }
    
}

- (IBAction)shiBtn:(id)sender {
    
    
    if (kk==0) {
        shi = [[NSMutableArray alloc] init];
        cId = [[NSMutableArray alloc] init];
        NSArray *carr;
        
        for (int i=0; i<dataArr.count; i++) {
            if ([dataArr[i][@"provinceId"] isEqual:lodgingProvinceId]) {
                NSDictionary *pdic = [NSDictionary dictionaryWithDictionary:dataArr[i]];
                carr = [NSArray arrayWithArray:pdic[@"citys"]];
               // NSLog(@"%@",carr);
            }
        }
        
        for (int k=0; k<[carr count]; k++) {
            
            NSString *cc = [NSString stringWithFormat:@"%@",carr[k][@"cityName"]];
            
            NSString *cid = [NSString stringWithFormat:@"%@",carr[k][@"cityId"]];
            [shi addObject:cc];
            [cId addObject:cid];
            
        }
        
       // NSLog(@"%@",shi);
        self.biankuangview.hidden = YES;
        [shiTableView reloadData];
        [self.view addSubview:shiTableView];
        
        kk=1;

    }else{
        
        [shiTableView removeFromSuperview];
        
        self.biankuangview.hidden = NO;
        
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
        //取消选中
        [shengTableView deselectRowAtIndexPath:indexPath animated:YES];
        
        [self.shenlabel setText:[sheng objectAtIndex:indexPath.row]];
        
        lodgingProvinceId = [NSString stringWithFormat:@"%@",pId[indexPath.row]];
        
        [shengTableView removeFromSuperview];
        
        //self.shilabel.text = [NSString stringWithFormat:@"%@",shi[0]];
        
        self.biankuangview.hidden = NO;
        
        n=0;
    }else{
        
        //取消选中
        [shiTableView deselectRowAtIndexPath:indexPath animated:YES];
        
        [self.shilabel setText:[shi objectAtIndex:indexPath.row]];
        
        lodgingCityId = [NSString stringWithFormat:@"%@",cId[indexPath.row]];
        
        [shiTableView removeFromSuperview];
        
        self.biankuangview.hidden = NO;
        kk=0;
        
    }
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_jinjilianxirenTextField resignFirstResponder];
    [_lianxidianhuaTextField resignFirstResponder];
    [_zhusudizhiTextField resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == _lianxidianhuaTextField) {
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
