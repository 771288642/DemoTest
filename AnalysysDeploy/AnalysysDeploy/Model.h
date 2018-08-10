//
//  Model.h
//  AnalysysDeploy
//
//  Created by analysysmac-1 on 2018/8/9.
//  Copyright © 2018年 analysysmac-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject<NSCoding>

@property (nonatomic, strong) NSString *appKey;
@property (nonatomic, strong) NSString *uploadProtocol, *socketProtocol, *configProtocol;
@property (nonatomic, strong) NSString *uploadAddress, *socketAddress, *configAddress;
@property (nonatomic, strong) NSString *uploadPort, *socketPort, *configPort;

@end
