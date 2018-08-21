//
//  ViewController.m
//  AnalysysDeploy
//
//  Created by analysysmac-1 on 2018/7/30.
//  Copyright © 2018年 analysysmac-1. All rights reserved.
//

#import "ViewController.h"
#import "DemoView.h"
#import <AnalysysAgent/AnalysysAgent.h>
#import "UIView+Addition.h"
#import "ListView.h"
#import "Model.h"
#import "SDAutoLayout.h"

#define isPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

@interface ViewController ()<DemoViewProtocol>

//  承载视图
@property (nonatomic, strong) DemoView *deployView;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, assign) BOOL keyboardIsShown;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"modelfile"];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveSDKNotification:) name:@"uploadingMsgNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveSDKNotification:) name:@"uploadMsgSuccessNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveSDKNotification:) name:@"uploadMsgFailedsNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveSDKNotification:) name:@"reUploadMsgNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveSDKNotification:) name:@"NoNetWorkNotification" object:nil];
    //注册键盘出现与隐藏通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
//    self.view.backgroundColor = [UIColor greenColor];
    
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    CGFloat topViewHeight = navigationBar.height + statusBarFrame.size.height;
    CGFloat margin = 5;
    
    //  初始化底层视图
    self.deployView = [[DemoView alloc] init];
    self.deployView.delegate = self;
    self.deployView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.deployView];
    [self loadLocalDataupdateUI];
    
    if (isPhoneX) {
        //注册横竖屏通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRotate:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
        if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortrait
            || [[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortraitUpsideDown) {
            //竖屏
            self.deployView.sd_layout
            .leftSpaceToView(self.view, margin)
            .topSpaceToView(self.view, topViewHeight + margin + 44)
            .rightSpaceToView(self.view, margin)
            .bottomSpaceToView(self.view, margin + 34);
        } else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) {
            //左横屏
            self.deployView.sd_layout
            .leftSpaceToView(self.view, margin + 44)
            .topSpaceToView(self.view, topViewHeight + margin)
            .rightSpaceToView(self.view, margin)
            .bottomSpaceToView(self.view, margin + 34);
        } else {
            //右横屏
            self.deployView.sd_layout
            .leftSpaceToView(self.view, margin)
            .topSpaceToView(self.view, topViewHeight + margin)
            .rightSpaceToView(self.view, margin + 44)
            .bottomSpaceToView(self.view, margin + 34);
        }
    } else {
        self.deployView.sd_layout
        .leftSpaceToView(self.view, margin)
        .topSpaceToView(self.view, topViewHeight + margin)
        .rightSpaceToView(self.view, margin)
        .bottomSpaceToView(self.view, margin);
    }
    
    [self.deployView setupAutoContentSizeWithBottomView:self.view bottomMargin:350];
    [self.deployView setupAutoContentSizeWithRightView:self.view rightMargin:-84];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


-(void)dealloc {
    //  移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

#pragma mark *** UI ***

/**
 读取本地数据更新UI
 */
- (void)loadLocalDataupdateUI {
    //  本地是否存有数据
    [self filing];
    NSData *data = [[NSData alloc] initWithContentsOfFile:self.path];
    if (data.bytes > 0) {
        [self.deployView.uploadBtn setTitle:self.deployView.uploadBtn.titleLabel.text ?: @"http://" forState:UIControlStateNormal];
        [self.deployView.socketBtn setTitle:self.deployView.socketBtn.titleLabel.text ?: @"ws://" forState:UIControlStateNormal];
        [self.deployView.configBtn setTitle:self.deployView.configBtn.titleLabel.text ?: @"http://" forState:UIControlStateNormal];
        
        //  修改SDK地址信息
        [AnalysysAgent setUploadURL:self.deployView.showUpAddressTV.text];
        [AnalysysAgent setVisitorDebugURL:self.deployView.showSocketAddressTV.text];
        [AnalysysAgent setVisitorConfigURL:self.deployView.showConfigAddressTV.text];
    } else {
        //  使用默认配置信息
        self.deployView.appKeyText.text = @"paastest";

        [self.deployView.uploadBtn setTitle:@"https://" forState:UIControlStateNormal] ;
        self.deployView.uploadAddressTF.text = @"arkpaastest.analysys.cn";
        self.deployView.uploadPortTF.text = @"4089";

        [self.deployView.socketBtn setTitle:@"wss://" forState:UIControlStateNormal];
        self.deployView.socketAddressTF.text = @"arkpaastest.analysys.cn";
        self.deployView.socketPortTF.text = @"4091";

        [self.deployView.configBtn setTitle:@"https://" forState:UIControlStateNormal];
        self.deployView.configAddressTF.text = @"arkpaastest.analysys.cn";
        self.deployView.configPortTF.text = @"4089";
        [self file];
    }
    [self updateShowView];
}


#pragma mark *** 按钮事件 ***

/** 保存App Key信息 */
- (void)saveAppKeyButtonAction {
    [self.view endEditing:YES];
    
    if (self.deployView.appKeyText.text.length == 0) {
        [self showAlert:@"app key设置异常"];
        return;
    }
    
    Model *model = [[Model alloc] init];
    model.appKey = self.deployView.appKeyText.text;
    [self filing];
    self.deployView.appKeyText.text = model.appKey;
    [self file];
    
    [self showAlert:@"成功保存App Key ！"];
}

/** 保存upload信息 */
- (void)saveUploadButtonAction {
    [self.view endEditing:YES];
    
    if (self.deployView.uploadAddressTF.text.length == 0 ||
        self.deployView.uploadPortTF.text.length == 0) {
        [self showAlert:@"upload设置异常"];
        return;
    }
    
    Model *model = [[Model alloc] init];
    model.uploadProtocol = self.deployView.uploadBtn.titleLabel.text;
    model.uploadAddress = self.deployView.uploadAddressTF.text;
    model.uploadPort = self.deployView.uploadPortTF.text;
    [self filing];
    [self.deployView.uploadBtn setTitle:model.uploadProtocol forState:UIControlStateNormal];
    self.deployView.uploadAddressTF.text = model.uploadAddress;
    self.deployView.uploadPortTF.text = model.uploadPort;
    [self file];
    [self updateShowView];
    
    [AnalysysAgent setUploadURL:self.deployView.showUpAddressTV.text];
    [self showAlert:@"成功保存upload ！"];
    
}

/** 保存socket信息 */
- (void)saveSocketButtonAction {
    [self.view endEditing:YES];
    
    if (self.deployView.socketAddressTF.text.length == 0 ||
        self.deployView.socketPortTF.text.length == 0) {
        [self showAlert:@"socket设置异常"];
        return;
    }
    
    Model *model = [[Model alloc] init];
    model.socketProtocol = self.deployView.socketBtn.titleLabel.text;
    model.socketAddress = self.deployView.socketAddressTF.text;
    model.socketPort = self.deployView.socketPortTF.text;
    [self filing];
    [self.deployView.socketBtn setTitle:model.socketProtocol forState:UIControlStateNormal];
    self.deployView.socketAddressTF.text = model.socketAddress;
    self.deployView.socketPortTF.text = model.socketPort;
    [self file];
    [self updateShowView];
    
    [AnalysysAgent setVisitorDebugURL:self.deployView.showSocketAddressTV.text];
    [self showAlert:@"成功保存socket ！"];
}

/** 保存config信息 */
- (void)saveConfigButtonAction {
    [self.view endEditing:YES];
    
    if (self.deployView.configAddressTF.text.length == 0 ||
        self.deployView.configPortTF.text.length == 0) {
        [self showAlert:@"config设置异常"];
        return;
    }
    
    Model *model = [[Model alloc] init];
    model.configProtocol = self.deployView.configBtn.titleLabel.text;
    model.configAddress = self.deployView.configAddressTF.text;
    model.configPort = self.deployView.configPortTF.text;
    [self filing];
    [self.deployView.configBtn setTitle:model.configProtocol forState:UIControlStateNormal];
    self.deployView.configAddressTF.text = model.configAddress;
    self.deployView.configPortTF.text = model.configPort;
    [self file];
    [self updateShowView];
    
    [AnalysysAgent setVisitorConfigURL:self.deployView.showConfigAddressTV.text];
    [self showAlert:@"成功保存config ！"];
    
}

/** 保存配置信息 */
- (void)saveButtonAction {

    //  检查数据合法性
    if (self.deployView.appKeyText.text.length == 0) {
        [self showAlert:@"app key设置异常"];
        return;
    }
    if (self.deployView.uploadAddressTF.text.length == 0 ||
        self.deployView.uploadPortTF.text.length == 0) {
        [self showAlert:@"upload设置异常"];
        return;
    }
    if (self.deployView.socketAddressTF.text.length == 0 ||
        self.deployView.socketPortTF.text.length == 0) {
        [self showAlert:@"socket设置异常"];
        return;
    }
    if (self.deployView.configAddressTF.text.length == 0 ||
        self.deployView.configPortTF.text.length == 0) {
        [self showAlert:@"config设置异常"];
        return;
    }
    //  保存本地数据
    [self file];
    [self updateShowView];
    //  修改SDK地址信息
    [AnalysysAgent setUploadURL:self.deployView.showUpAddressTV.text];
    [AnalysysAgent setVisitorDebugURL:self.deployView.showSocketAddressTV.text];
    [AnalysysAgent setVisitorConfigURL:self.deployView.showConfigAddressTV.text];
    
    [self showAlert:@"全部保存成功！"];
    [self.view endEditing:YES];
}

/** 刷新页面展示地址视图 */
- (void)updateShowView {
    //  赋值 展示控件
    self.deployView.showUpAddressTV.text = [NSString stringWithFormat:@"%@%@:%@",self.deployView.uploadBtn.titleLabel.text ?: @"",self.deployView.uploadAddressTF.text,self.deployView.uploadPortTF.text];
    
    self.deployView.showSocketAddressTV.text = [NSString stringWithFormat:@"%@%@:%@",self.deployView.socketBtn.titleLabel.text ?: @"",self.deployView.socketAddressTF.text,self.deployView.socketPortTF.text];
    
    self.deployView.showConfigAddressTV.text = [NSString stringWithFormat:@"%@%@:%@",self.deployView.configBtn.titleLabel.text ?: @"",self.deployView.configAddressTF.text,self.deployView.configPortTF.text];
    self.deployView.dataText.text = @"";
}

/**  发送数据 */
- (void)sendDataButtonAction {
    [self.view endEditing:YES];
    
    self.deployView.dataText.text = @"";
    
    NSString *trackEvent = [NSString stringWithFormat:@"track_%ld", arc4random() % 100];
    [AnalysysAgent track:trackEvent properties:@{@"name":@"部署人员", @"city":@"北京"}];
}

#pragma mark *** DemoViewProtocol ***

- (void)saveAppKeyBtnAction:(UIButton *)btn {
    [self saveAppKeyButtonAction];
}

- (void)saveUploadBtnAction:(UIButton *)btn {
    [self saveUploadButtonAction];
}

- (void)saveSocketBtnAction:(UIButton *)btn {
    [self saveSocketButtonAction];
}

- (void)saveConfigBtnAction:(UIButton *)btn {
    [self saveConfigButtonAction];
}

- (void)saveBtnAction:(UIButton *)btn {
    [self saveButtonAction];
}

- (void)sendBtnAction:(UIButton *)btn {
    [self sendDataButtonAction];
}

#pragma mark - 弹窗提示

- (void)showAlert:(NSString *)_message {
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >= 9.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示:" message:_message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:OKAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:_message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [promptAlert show];
    }
}

#pragma mark - 接收通知

- (void)receiveSDKNotification:(NSNotification *)notification {
    NSLog(@"收到数据接收通知:%@   :%@", notification.name, notification.object);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.deployView.dataText.text = [NSString stringWithFormat:@"%@",notification.object];
    });
}

#pragma mark - 触摸屏幕时触发

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - 归档

- (void)file {
    Model *model = [[Model alloc] init];
    model.appKey = self.deployView.appKeyText.text;
    
    model.uploadProtocol = self.deployView.uploadBtn.titleLabel.text;
    model.uploadAddress = self.deployView.uploadAddressTF.text;
    model.uploadPort = self.deployView.uploadPortTF.text;
    
    model.socketProtocol = self.deployView.socketBtn.titleLabel.text;
    model.socketAddress = self.deployView.socketAddressTF.text;
    model.socketPort = self.deployView.socketPortTF.text;
    
    model.configProtocol = self.deployView.configBtn.titleLabel.text;
    model.configAddress = self.deployView.configAddressTF.text;
    model.configPort = self.deployView.configPortTF.text;
    
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:model forKey:@"model"];
    [archiver finishEncoding];
    [data writeToFile:self.path atomically:YES];
}

#pragma mark - 接档

- (void)filing {
    NSData *data = [[NSData alloc] initWithContentsOfFile:self.path];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    Model *model = [unarchiver decodeObjectForKey:@"model"];
    [unarchiver finishDecoding];
    self.deployView.appKeyText.text = model.appKey;
    
    [self.deployView.uploadBtn setTitle:model.uploadProtocol forState:UIControlStateNormal];
    self.deployView.uploadAddressTF.text = model.uploadAddress;
    self.deployView.uploadPortTF.text = model.uploadPort;
    
    [self.deployView.socketBtn setTitle:model.socketProtocol forState:UIControlStateNormal];
    self.deployView.socketAddressTF.text = model.socketAddress;
    self.deployView.socketPortTF.text = model.socketPort;
    
    [self.deployView.configBtn setTitle:model.configProtocol forState:UIControlStateNormal];
    self.deployView.configAddressTF.text = model.configAddress;
    self.deployView.configPortTF.text = model.configPort;
}

#pragma mark - 接收键盘通知

//键盘弹出不遮挡text
- (void)keyboardDidShow:(NSNotification *)notif {
    if (self.keyboardIsShown) {
        return;
    }
    NSDictionary *info = notif.userInfo;
    NSValue *aValue = [info objectForKeyedSubscript:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    
    CGRect viewFrame = self.deployView.frame;
    viewFrame.size.height -= keyboardSize.height;
    self.deployView.frame = viewFrame;
    CGRect textFieldRect = [self.deployView.currentText frame];
    [self.deployView scrollRectToVisible:textFieldRect animated:YES];
    self.keyboardIsShown = YES;
}

//键盘隐藏还原view
- (void)keyboardDidHide:(NSNotification *)notif {
    NSDictionary *info = notif.userInfo;
    NSValue *aValue = [info objectForKeyedSubscript:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;

    CGRect viewFrame = self.deployView.frame;
    viewFrame.size.height += keyboardSize.height;
    self.deployView.frame = viewFrame;
    if (!self.keyboardIsShown) {
        return;
    }
    self.keyboardIsShown = NO;
}

#pragma mark - 接收横竖屏通知

- (void)changeRotate:(NSNotification*)noti {
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    CGFloat topViewHeight = navigationBar.height + statusBarFrame.size.height;
    CGFloat margin = 5;
    if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortrait
        || [[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortraitUpsideDown) {
        //竖屏
        self.deployView.sd_layout
        .leftSpaceToView(self.view, margin)
        .topSpaceToView(self.view, topViewHeight + margin + 44)
        .rightSpaceToView(self.view, margin)
        .bottomSpaceToView(self.view, margin + 34);
    } else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) {
        //左横屏
        self.deployView.sd_layout
        .leftSpaceToView(self.view, margin + 44)
        .topSpaceToView(self.view, topViewHeight + margin)
        .rightSpaceToView(self.view, margin)
        .bottomSpaceToView(self.view, margin + 34);
    } else {
        //右横屏
        self.deployView.sd_layout
        .leftSpaceToView(self.view, margin)
        .topSpaceToView(self.view, topViewHeight + margin)
        .rightSpaceToView(self.view, margin + 44)
        .bottomSpaceToView(self.view, margin + 34);
    }
}

@end
