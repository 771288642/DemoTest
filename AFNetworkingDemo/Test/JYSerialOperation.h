//
//  JYSerialOperation.h
//  Test
//
//  Created by analysysmac-1 on 2018/7/30.
//  Copyright © 2018年 analysysmac-1. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^JYCompletionBlock)(NSData *imageData);

@interface JYSerialOperation : NSOperation

@property (nonatomic, copy) JYCompletionBlock comBlock;

@end
