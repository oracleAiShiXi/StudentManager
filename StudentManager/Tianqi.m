//
//  Tianqi.m
//  ishixi
//
//  Created by csh on 16/8/8.
//  Copyright © 2016年 csh. All rights reserved.
//

#import "Tianqi.h"
#import "Zhuye_ViewController.h"


@implementation Tianqi
{

    NSMutableString *element;
    NSMutableDictionary *dic;
    
}


//位置
-(NSString *)code:(CLLocation *)location{

    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
  //NSLog(@"cityId---%@",self.cityid);
    NSString *strURL = [[NSString alloc] initWithFormat:@"http://weatherapi.market.xiaomi.com/wtr-v2/temp/forecast?cityId=%@",[def objectForKey:@"cityId"]];
    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil  error:&error];
    //data转换dictionary
    NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    //把字典中result剥离出来
    //NSLog(@"resDict1--%@",resDict);
    NSString *str;
    if (resDict) {
        
        
        NSDictionary *result = [resDict objectForKey:@"weatherinfo"];
        //NSLog(@"--%@",result);
        self.city = [result objectForKey:@"city"];
        self.riqi = [result objectForKey:@"week"];
       // NSLog(@"city===%@",self.city);
        //NSLog(@"riqi===%@",self.riqi);
        NSString *str1 = @",";
        NSString *str2;
        str2 = [self.city stringByAppendingString:str1];
        str = [str2 stringByAppendingString:self.riqi];

    }
    return str;
}
//温度
-(NSString *)wendu:(CLLocation *)location{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *strURL1 = [[NSString alloc] initWithFormat:@"http://weatherapi.market.xiaomi.com/wtr-v2/temp/realtime?cityId=%@",[def objectForKey:@"cityId"]];
    strURL1 = [strURL1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:strURL1];
    NSURLRequest *request1 = [[NSURLRequest alloc] initWithURL:url1];
    NSError *error1;
    NSData *data1 = [NSURLConnection sendSynchronousRequest:request1 returningResponse:nil  error:&error1];
    //data转换dictionary
    NSDictionary *resDict1 = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingAllowFragments error:nil];
    //把字典中result剥离出来
    //NSLog(@"resDict3---%@",resDict1);
    NSString *s;
    if (resDict1){
        NSDictionary *dic1 = [resDict1 objectForKey:@"weatherinfo"];
        s = [dic1 objectForKey:@"temp"];
    }
    
    NSString *str22 = @"℃";
    NSString *wd = [s stringByAppendingString:str22];
    return wd;
}
//图片
-(NSString *)tianqitupian:(CLLocation *)location
{
   //NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
//    NSString *strURL = [[NSString alloc] initWithFormat:@"http://weatherapi.market.xiaomi.com/wtr-v2/temp/realtime?cityId=%@",[def objectForKey:@"cityId"]];
//    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url = [NSURL URLWithString:strURL];
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
//    NSError *error;
//    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil  error:&error];
//    //data转换dictionary
//    NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//    //把字典中result剥离出来
//    NSLog(@"resDict2--%@",resDict);
//    NSString *str;
//    if (resDict) {
//        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"0",@"晴",@"1",@"中雪",@"2",@"中雨",@"3",@"阵雨",@"4",@"多云",@"5",@"多云转晴",@"6",@"小雪",@"7",@"阴转晴",@"8",@"阴",@"9",@"小雨",@"10",@"大雨",@"11",@"大雨转晴",@"12",@"多云转阴",@"13",@"雨加雪",@"14",@"小雨转晴",@"15",@"大雪转晴",@"16",@"霾",@"17",@"中雨转晴",@"18",@"多云转晴天",@"19",@"暴雨转晴",@"20",@"中雨转阴",@"21",@"小雨转阴",@"22",@"大雨转阴",@"23",@"阵雨转阴", nil];
//        NSDictionary *result = [resDict objectForKey:@"weatherinfo"];
//        self.tianqi = [result objectForKey:@"weather"];
//        str = [dict objectForKey:self.tianqi];
//        if (str == nil) {
//            str = @" ";
//        }
//    }
//    return str;
    
  //  NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
   // NSString *astr = [def objectForKey:@"locality"];
   // NSLog(@"the city is  %@",astr);
    NSString *astr = @"哈尔滨";
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
    NSString *str1 = [astr stringByAddingPercentEscapesUsingEncoding:enc];
    NSLog(@" reStr %@",str1);
    NSString *strURL1 = [[NSString alloc] initWithFormat:@"http://php.weather.sina.com.cn/xml.php?city=%@&password=DJOYnieT8234jlsK&day=0",str1];
    NSURL *url=[NSURL URLWithString:strURL1];//创建URL
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2.0f];
    NSError *err;
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err];
    
    dic = [[NSMutableDictionary alloc]init];
    
    NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
    parser.delegate = self;
    [parser parse];
    
    NSString *str;
    //self.tianqi =  [dic objectForKey:@"figure1"];
    str = [dic objectForKey:@"figure1"];
//    if (str == nil) {
//        str = @" ";
//        }
    NSLog(@"the str = =%@",str);
    return str;
    
}


#pragma mark - XML
//第一个代理方法：
- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{
    //判断是否是meeting
    if ([elementName isEqualToString:@"Profiles"]) {
        //判断属性节点
        if ([attributeDict objectForKey:@"Weather"]) {
            //获取属性节点中的值
            NSString *addr=[attributeDict objectForKey:@"Weather"];
           // NSLog(@"the addr -- %@",addr);
        }
    }
    //判断member
    if ([elementName isEqualToString:@"status1"]) {
       // NSLog(@"status1");
    }
}

//第二个代理方法：
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    //获取文本节点中的数据，因为下面的方法要保存这里获取的数据，所以要定义一个全局变量(可修改的字符串)
    // NSMutableString *element = [[NSMutableString alloc]init];
    element = [[NSMutableString alloc]init];
    //这里要赋值为空，目的是为了清空上一次的赋值
    [element setString:@""];
    [element appendString:string];//string是获取到的文本节点的值，只要是文本节点都会获取(包括换行)，然后到下个方法中进行判断区分
}

//第三个代理方法：
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    NSString *str=[[NSString alloc] initWithString:element];
    
   
    if ([elementName isEqualToString:@"status1"]) {
        NSLog(@"status1...%@",str);
      [dic setObject:str forKey:@"status1"];
    }
   else if ([elementName isEqualToString:@"figure1"]) {
        NSLog(@"figure1...%@",str);
      [dic setObject:str forKey:@"figure1"];
    }
  else  if ([elementName isEqualToString:@"city"]) {
        NSLog(@"city...%@",str);
       [dic setObject:str forKey:@"city"];
    }
    
   NSLog(@"%@",dic);
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
  
   
}



@end
