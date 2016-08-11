//
//  Tianqi.h
//  ishixi
//
//  Created by csh on 16/8/8.
//  Copyright © 2016年 csh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <CoreLocation/CoreLocation.h>

@interface Tianqi : NSObject

-(NSString *)code:(CLLocation *)location;

-(NSString *)wendu:(CLLocation *)location;

-(NSString *)tianqitupian:(CLLocation *)location;

@property(nonatomic,strong)NSString *city;

@property(nonatomic,strong)NSString *riqi;

@property(nonatomic,strong)NSString *tianqi;


@end
