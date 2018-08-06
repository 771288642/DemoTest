//
//  DropDownButton.h
//  Demo
//
//  Created by analysysmac-1 on 2018/7/30.
//  Copyright © 2018年 analysysmac-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDownButton : UIButton

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray *list;

- (void)startPackUpAnimation;
- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title List:(NSArray *)list;

@end
