//
//  Tianqi.m
//  ishixi
//
//  Created by csh on 16/8/8.
//  Copyright © 2016年 csh. All rights reserved.
//

#import "Tianqi.h"


@implementation Tianqi
{
//    NSDictionary *result1;
//    NSDictionary *result2;
}



-(NSString *)code:(CLLocation *)location
{
    NSString *longitude=[[NSString alloc] initWithFormat:@"%f",location.coordinate.longitude];
    NSString *latitide=[[NSString alloc]initWithFormat:@"%f",location.coordinate.latitude];
    NSString *strURL1 = [[NSString alloc] initWithFormat:@"https://api.thinkpage.cn/v3/weather/daily.json?key=pujj2nlp6ofarj7x&location=%@:%@&language=zh-Hans&unit=c&start=0&days=5",latitide,longitude];
    strURL1 = [strURL1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:strURL1];
    NSURLRequest *request1 = [[NSURLRequest alloc] initWithURL:url1];
    NSError *error1;
    NSData *data1 = [NSURLConnection sendSynchronousRequest:request1 returningResponse:nil  error:&error1];
    //data转换dictionary
    NSDictionary *resDict1 = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingAllowFragments error:nil];
    //把字典中result剥离出来
    NSArray *dic = [[NSArray alloc]init];
    NSArray *arr = [[NSArray alloc]init];
    NSDictionary *dic1 = [[NSDictionary alloc]init];
    NSDictionary *dic2 = [[NSDictionary alloc]init];
    NSString *ss;
    NSString *str;
    if (resDict1) {
        dic = [resDict1 objectForKey:@"results"];
        dic1 = [dic objectAtIndex:0];
        arr = [dic1 objectForKey:@"daily"];
        NSDictionary *dic3 = [arr objectAtIndex:0];
        NSString *s = [dic3 objectForKey:@"date"];
        dic2 = [dic1 objectForKey:@"location"];
        ss = [dic2 objectForKey:@"name"];
        str = [ss stringByAppendingString:s];
    }
    
//    NSString *strURL = [[NSString alloc] initWithFormat:@"http://weatherapi.market.xiaomi.com/wtr-v2/temp/forecast?cityId=%@",ss];
//    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url = [NSURL URLWithString:strURL];
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
//    NSError *error;
//    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil  error:&error];
//    //data转换dictionary
//    NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//    //把字典中result剥离出来
//    NSLog(@"---%@",resDict);
//    NSString *str;
//    if (resDict) {
//        
//        
//        result1 = [resDict objectForKey:@"weatherinfo"];
//        NSLog(@"--%@",result1);
//        self.city = [result1 objectForKey:@"city"];
//        self.riqi = [result1 objectForKey:@"week"];
//        NSLog(@"city===%@",self.city);
//        NSLog(@"riqi===%@",self.riqi);
//        NSString *str1 = @"，";
//        NSString *str2;
//        str2 = [self.city stringByAppendingString:str1];
//        str = [str2 stringByAppendingString:self.riqi];
//
//    }
    return str;
}


-(NSString *)tianqitupian:(CLLocation *)location
{
    NSString *longitude=[[NSString alloc] initWithFormat:@"%f",location.coordinate.longitude];
    NSString *latitide=[[NSString alloc]initWithFormat:@"%f",location.coordinate.latitude];
    NSString *strURL = [[NSString alloc] initWithFormat:@"https://api.thinkpage.cn/v3/weather/daily.json?key=pujj2nlp6ofarj7x&location=%@:%@&language=zh-Hans&unit=c&start=0&days=5",latitide,longitude];
    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil  error:&error];
    //data转换dictionary
    NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    //把字典中result剥离出来
    NSString *str;
    if (resDict) {
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"0",@"晴",@"1",@"中雪",@"2",@"中雨",@"3",@"雷阵雨",@"4",@"多云",@"5",@"多云转晴",@"6",@"小雪",@"7",@"阴转晴",@"8",@"阴",@"9",@"小雨",@"10",@"大雨",@"11",@"大雨转晴",@"12",@"多云转阴",@"13",@"雨加雪",@"14",@"小雨转晴",@"15",@"大学转晴",@"16",@"霾",@"17",@"中雨转晴",@"18",@"多云转晴天",@"19",@"暴雨转晴",@"20",@"中雨转阴",@"21",@"小雨转阴",@"22",@"大雨转阴",@"23",@"雷阵雨转阴", nil];
        NSArray *arr = [resDict objectForKey:@"results"];
        NSDictionary *dic = [arr objectAtIndex:0];
        NSArray *arr1 = [dic objectForKey:@"daily"];
        NSDictionary *dic1 = [arr1 objectAtIndex:0];
        self.tianqi = [dic1 objectForKey:@"text_day"];
        str = [dict objectForKey:self.tianqi];
        if (str == nil) {
            str = @" ";
        }
    }
    return str;
}
-(NSString *)wendu:(CLLocation *)location
{
    NSString *longitude=[[NSString alloc] initWithFormat:@"%f",location.coordinate.longitude];
    NSString *latitide=[[NSString alloc]initWithFormat:@"%f",location.coordinate.latitude];
    NSString *strURL1 = [[NSString alloc] initWithFormat:@"https://api.thinkpage.cn/v3/weather/now.json?key=pujj2nlp6ofarj7x&location=%@:%@&language=zh-Hans&unit=c",latitide,longitude];
    strURL1 = [strURL1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:strURL1];
    NSURLRequest *request1 = [[NSURLRequest alloc] initWithURL:url1];
    NSError *error1;
    NSData *data1 = [NSURLConnection sendSynchronousRequest:request1 returningResponse:nil  error:&error1];
    //data转换dictionary
    NSDictionary *resDict1 = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingAllowFragments error:nil];
    //把字典中result剥离出来
    //NSLog(@"resDict1---%@",resDict1);
    NSString *s;
    if (resDict1){
        NSArray *arr = [resDict1 objectForKey:@"results"];
        NSDictionary *dic = [arr objectAtIndex:0];
        NSDictionary *dic1 = [dic objectForKey:@"now"];
        s = [dic1 objectForKey:@"temperature"];
    }
    
    NSString *str22 = @"℃";
    NSString *wd = [s stringByAppendingString:str22];
    return wd;
}

@end
