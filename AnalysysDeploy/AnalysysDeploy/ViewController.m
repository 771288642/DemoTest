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

#define isPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

@interface ViewController ()<DemoViewProtocol>

//  承载视图
@property (nonatomic, strong) DemoView *demoView;
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
    if (isPhoneX) {
        self.demoView = [[DemoView alloc] initWithFrame:CGRectMake(margin + 44, topViewHeight + margin, self.view.width - margin*4 - 44, self.view.height - topViewHeight - margin*2 - 34)];
    } else {
        self.demoView = [[DemoView alloc] initWithFrame:CGRectMake(margin, topViewHeight + margin, self.view.width - margin*2, self.view.height - topViewHeight - margin*2)];
    }
    
    self.demoView.delegate = self;
    self.demoView.contentSize = CGSizeMake(self.demoView.width, self.demoView.height + 350);
//    self.demoView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.demoView];
    [self loadLocalDataupdateUI];
    
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
        [self.demoView.uploadBtn setTitle:self.demoView.uploadBtn.titleLabel.text ?: @"http://" forState:UIControlStateNormal];
        [self.demoView.socketBtn setTitle:self.demoView.socketBtn.titleLabel.text ?: @"ws://" forState:UIControlStateNormal];
        [self.demoView.configBtn setTitle:self.demoView.configBtn.titleLabel.text ?: @"http://" forState:UIControlStateNormal];
        
        //  修改SDK地址信息
        [AnalysysAgent setUploadURL:self.demoView.showUpAddressTV.text];
        [AnalysysAgent setVisitorDebugURL:self.demoView.showSocketAddressTV.text];
        [AnalysysAgent setVisitorConfigURL:self.demoView.showConfigAddressTV.text];
    } else {
        //  使用默认配置信息
        self.demoView.appKeyText.text = @"paastest";

        [self.demoView.uploadBtn setTitle:@"https://" forState:UIControlStateNormal] ;
        self.demoView.uploadAddressTF.text = @"arkpaastest.analysys.cn";
        self.demoView.uploadPortTF.text = @"4089";

        [self.demoView.socketBtn setTitle:@"wss://" forState:UIControlStateNormal];
        self.demoView.socketAddressTF.text = @"arkpaastest.analysys.cn";
        self.demoView.socketPortTF.text = @"4091";

        [self.demoView.configBtn setTitle:@"https://" forState:UIControlStateNormal];
        self.demoView.configAddressTF.text = @"arkpaastest.analysys.cn";
        self.demoView.configPortTF.text = @"4089";
        [self file];
    }
    [self updateShowView];
}


#pragma mark *** 按钮事件 ***

/** 保存App Key信息 */
- (void)saveAppKeyButtonAction {
    [self.view endEditing:YES];
    
    if (self.demoView.appKeyText.text.length == 0) {
        [self showAlert:@"app key设置异常"];
        return;
    }
    
    Model *model = [[Model alloc] init];
    model.appKey = self.demoView.appKeyText.text;
    [self filing];
    self.demoView.appKeyText.text = model.appKey;
    [self file];
    
    [self showAlert:@"成功保存App Key ！"];
}

/** 保存upload信息 */
- (void)saveUploadButtonAction {
    [self.view endEditing:YES];
    
    if (self.demoView.uploadAddressTF.text.length == 0 ||
        self.demoView.uploadPortTF.text.length == 0) {
        [self showAlert:@"upload设置异常"];
        return;
    }
    
    Model *model = [[Model alloc] init];
    model.uploadProtocol = self.demoView.uploadBtn.titleLabel.text;
    model.uploadAddress = self.demoView.uploadAddressTF.text;
    model.uploadPort = self.demoView.uploadPortTF.text;
    [self filing];
    [self.demoView.uploadBtn setTitle:model.uploadProtocol forState:UIControlStateNormal];
    self.demoView.uploadAddressTF.text = model.uploadAddress;
    self.demoView.uploadPortTF.text = model.uploadPort;
    [self file];
    [self updateShowView];
    
    [AnalysysAgent setUploadURL:self.demoView.showUpAddressTV.text];
    [self showAlert:@"成功保存upload ！"];
    
}

/** 保存socket信息 */
- (void)saveSocketButtonAction {
    [self.view endEditing:YES];
    
    if (self.demoView.socketAddressTF.text.length == 0 ||
        self.demoView.socketPortTF.text.length == 0) {
        [self showAlert:@"socket设置异常"];
        return;
    }
    
    Model *model = [[Model alloc] init];
    model.socketProtocol = self.demoView.socketBtn.titleLabel.text;
    model.socketAddress = self.demoView.socketAddressTF.text;
    model.socketPort = self.demoView.socketPortTF.text;
    [self filing];
    [self.demoView.socketBtn setTitle:model.socketProtocol forState:UIControlStateNormal];
    self.demoView.socketAddressTF.text = model.socketAddress;
    self.demoView.socketPortTF.text = model.socketPort;
    [self file];
    [self updateShowView];
    
    [AnalysysAgent setVisitorDebugURL:self.demoView.showSocketAddressTV.text];
    [self showAlert:@"成功保存socket ！"];
}

/** 保存config信息 */
- (void)saveConfigButtonAction {
    [self.view endEditing:YES];
    
    if (self.demoView.configAddressTF.text.length == 0 ||
        self.demoView.configPortTF.text.length == 0) {
        [self showAlert:@"config设置异常"];
        return;
    }
    
    Model *model = [[Model alloc] init];
    model.configProtocol = self.demoView.configBtn.titleLabel.text;
    model.configAddress = self.demoView.configAddressTF.text;
    model.configPort = self.demoView.configPortTF.text;
    [self filing];
    [self.demoView.configBtn setTitle:model.configProtocol forState:UIControlStateNormal];
    self.demoView.configAddressTF.text = model.configAddress;
    self.demoView.configPortTF.text = model.configPort;
    [self file];
    [self updateShowView];
    
    [AnalysysAgent setVisitorConfigURL:self.demoView.showConfigAddressTV.text];
    [self showAlert:@"成功保存config ！"];
    
}

/** 保存配置信息 */
- (void)saveButtonAction {

    //  检查数据合法性
    if (self.demoView.appKeyText.text.length == 0) {
        [self showAlert:@"app key设置异常"];
        return;
    }
    if (self.demoView.uploadAddressTF.text.length == 0 ||
        self.demoView.uploadPortTF.text.length == 0) {
        [self showAlert:@"upload设置异常"];
        return;
    }
    if (self.demoView.socketAddressTF.text.length == 0 ||
        self.demoView.socketPortTF.text.length == 0) {
        [self showAlert:@"socket设置异常"];
        return;
    }
    if (self.demoView.configAddressTF.text.length == 0 ||
        self.demoView.configPortTF.text.length == 0) {
        [self showAlert:@"config设置异常"];
        return;
    }
    //  保存本地数据
    [self file];
    [self updateShowView];
    //  修改SDK地址信息
    [AnalysysAgent setUploadURL:self.demoView.showUpAddressTV.text];
    [AnalysysAgent setVisitorDebugURL:self.demoView.showSocketAddressTV.text];
    [AnalysysAgent setVisitorConfigURL:self.demoView.showConfigAddressTV.text];
    
    [self showAlert:@"全部保存成功！"];
    [self.view endEditing:YES];
}

/** 刷新页面展示地址视图 */
- (void)updateShowView {
    //  赋值 展示控件
    self.demoView.showUpAddressTV.text = [NSString stringWithFormat:@"%@%@:%@",self.demoView.uploadBtn.titleLabel.text ?: @"",self.demoView.uploadAddressTF.text,self.demoView.uploadPortTF.text];
    
    self.demoView.showSocketAddressTV.text = [NSString stringWithFormat:@"%@%@:%@",self.demoView.socketBtn.titleLabel.text ?: @"",self.demoView.socketAddressTF.text,self.demoView.socketPortTF.text];
    
    self.demoView.showConfigAddressTV.text = [NSString stringWithFormat:@"%@%@:%@",self.demoView.configBtn.titleLabel.text ?: @"",self.demoView.configAddressTF.text,self.demoView.configPortTF.text];
    self.demoView.dataText.text = @"";
}

/**  发送数据 */
- (void)sendDataButtonAction {
    [self.view endEditing:YES];
    
    self.demoView.dataText.text = @"";
    
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
        self.demoView.dataText.text = [NSString stringWithFormat:@"%@",notification.object];
    });
}

#pragma mark - 触摸屏幕时触发

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - 归档

- (void)file {
    Model *model = [[Model alloc] init];
    model.appKey = self.demoView.appKeyText.text;
    
    model.uploadProtocol = self.demoView.uploadBtn.titleLabel.text;
    model.uploadAddress = self.demoView.uploadAddressTF.text;
    model.uploadPort = self.demoView.uploadPortTF.text;
    
    model.socketProtocol = self.demoView.socketBtn.titleLabel.text;
    model.socketAddress = self.demoView.socketAddressTF.text;
    model.socketPort = self.demoView.socketPortTF.text;
    
    model.configProtocol = self.demoView.configBtn.titleLabel.text;
    model.configAddress = self.demoView.configAddressTF.text;
    model.configPort = self.demoView.configPortTF.text;
    
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
    self.demoView.appKeyText.text = model.appKey;
    
    [self.demoView.uploadBtn setTitle:model.uploadProtocol forState:UIControlStateNormal];
    self.demoView.uploadAddressTF.text = model.uploadAddress;
    self.demoView.uploadPortTF.text = model.uploadPort;
    
    [self.demoView.socketBtn setTitle:model.socketProtocol forState:UIControlStateNormal];
    self.demoView.socketAddressTF.text = model.socketAddress;
    self.demoView.socketPortTF.text = model.socketPort;
    
    [self.demoView.configBtn setTitle:model.configProtocol forState:UIControlStateNormal];
    self.demoView.configAddressTF.text = model.configAddress;
    self.demoView.configPortTF.text = model.configPort;
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
    
    CGRect viewFrame = self.demoView.frame;
    viewFrame.size.height -= keyboardSize.height;
    self.demoView.frame = viewFrame;
    CGRect textFieldRect = [self.demoView.currentText frame];
    [self.demoView scrollRectToVisible:textFieldRect animated:YES];
    self.keyboardIsShown = YES;
}

//键盘隐藏还原view
- (void)keyboardDidHide:(NSNotification *)notif {
    NSDictionary *info = notif.userInfo;
    NSValue *aValue = [info objectForKeyedSubscript:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;

    CGRect viewFrame = self.demoView.frame;
    viewFrame.size.height += keyboardSize.height;
    self.demoView.frame = viewFrame;
    if (!self.keyboardIsShown) {
        return;
    }
    self.keyboardIsShown = NO;
}

@end
