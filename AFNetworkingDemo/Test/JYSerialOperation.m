//
//  JYSerialOperation.m
//  Test
//
//  Created by analysysmac-1 on 2018/7/30.
//  Copyright © 2018年 analysysmac-1. All rights reserved.
//

#import "JYSerialOperation.h"

@implementation JYSerialOperation

- (void)main {
    @autoreleasepool {
        if (self.isCancelled) {
            return;
        }
        NSURL *url = [NSURL URLWithString:@"https://p1.bpimg.com/524586/475bc82ff016054ds.jpg"];
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
        if (!imageData) {
            imageData = nil;
        }
        
        if (self.isCancelled) {
            return;
        }
        [self performSelectorOnMainThread:@selector(completionAction:) withObject:imageData waitUntilDone:NO];
    }
}

- (void)completionAction:(NSData *)imageData {
    if (self.comBlock) {
        self.comBlock(imageData);
    }
}

@end
