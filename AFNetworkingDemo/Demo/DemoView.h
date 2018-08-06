//
//  DemoView.h
//  Demo
//
//  Created by analysysmac-1 on 2018/8/1.
//  Copyright © 2018年 analysysmac-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoView : UIView

@property (nonatomic, strong) UILabel *appKeyLabel;
@property (nonatomic, strong) UITextField *appKeyText;
@property (nonatomic, strong) UIView *underLine1;
@property (nonatomic, strong) UILabel *uploadLabel, *socketLabel, *configLabel;
@property (nonatomic, strong) UITextField *uploadText, *socketText, *configText;
@property (nonatomic, strong) UILabel *uploadAddressLabel, *socketAddressLabel, *configAddressLabel;
@property (nonatomic, strong) UILabel *colonLabel1, *colonLabel2, *colonLabel3;
@property (nonatomic, strong) UITextField *noText1, *noText2, *noText3;
@property (nonatomic, strong) UIButton *saveButton, *sendDataButton;
@property (nonatomic, strong) UITextView *dataText;
@property (nonatomic, strong) UITextView *uploadAddressText, *socketAddressText, *configAddressText;

@end
