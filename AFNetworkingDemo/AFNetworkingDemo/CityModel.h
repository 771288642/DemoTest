//
//  CityModel.h
//  AFNetworkingDemo
//
//  Created by analysysmac-1 on 2018/7/25.
//  Copyright © 2018年 analysysmac-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CityModel : NSObject
@property (nonatomic, copy) UIImage *photo;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *condition;
@property (nonatomic, copy) NSString *high_temperature;
@property (nonatomic, copy) NSString *low_temperature;

@end
