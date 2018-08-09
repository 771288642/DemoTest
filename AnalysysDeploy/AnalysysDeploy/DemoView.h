//
//  DemoView.h
//  AnalysysDeploy
//
//  Created by analysysmac-1 on 2018/8/1.
//  Copyright © 2018年 analysysmac-1. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 协议 */
@protocol DemoViewProtocol<NSObject>

@required

- (void)saveAppKeyBtnAction:(UIButton *)btn;
- (void)saveUploadBtnAction:(UIButton *)btn;
- (void)saveBtnAction:(UIButton *)btn;
- (void)sendBtnAction:(UIButton *)btn;

@end


@interface DemoView : UIScrollView

@property(nonatomic, assign) id <DemoViewProtocol>delegate;

@property (nonatomic, strong) UITextField *appKeyText;
@property (nonatomic, strong) UIButton *saveAppKeyButton;
@property (nonatomic, strong) UIButton *uploadBtn, *socketBtn, *configBtn;
@property (nonatomic, strong) UITextField *uploadAddressTF, *socketAddressTF, *configAddressTF;
@property (nonatomic, strong) UITextField *uploadPortTF, *socketPortTF, *configPortTF;
@property (nonatomic, strong) UIButton *saveUploadButton;
@property (nonatomic, strong) UIButton *saveButton, *sendDataButton;
@property (nonatomic, strong) UITextView *showUpAddressTV, *showSocketAddressTV, *showConfigAddressTV;
@property (nonatomic, strong) UITextView *dataText;


@end
