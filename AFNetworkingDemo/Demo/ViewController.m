//
//  ViewController.m
//  Demo
//
//  Created by analysysmac-1 on 2018/7/30.
//  Copyright © 2018年 analysysmac-1. All rights reserved.
//

#import "ViewController.h"
#import "DropDownButton.h"
#import "DropDownList.h"
#import "DemoView.h"
#import <AnalysysAgent/AnalysysAgent.h>

@interface ViewController ()

@property (nonatomic, strong) DropDownButton *button1, *button2, *button3;
@property (nonatomic, strong) DropDownList *imageListView1, *imageListView2, *imageListView3;
@property (nonatomic, strong) DemoView *demoView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.demoView = [[DemoView alloc] initWithFrame:CGRectMake(10, self.navigationController.navigationBar.frame.size.height + 20, self.view.frame.size.width - 20, self.view.frame.size.height - 64)];
    [self.view addSubview:self.demoView];
    [self.demoView.saveButton addTarget:self action:@selector(saveButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.demoView.sendDataButton addTarget:self action:@selector(sendDataButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //第二行
    self.button1 = [[DropDownButton alloc] initWithFrame:CGRectMake(self.demoView.uploadLabel.frame.size.width + 5, self.demoView.uploadLabel.frame.origin.y, 80, 30) Title:@"http://" List:@[@"http://", @"https://"]];
    if ([[defaults valueForKey:@"button1"] length] > 0) {
        self.button1 = [[DropDownButton alloc] initWithFrame:CGRectMake(self.demoView.uploadLabel.frame.size.width + 5, self.demoView.uploadLabel.frame.origin.y, 80, 30) Title:[defaults valueForKey:@"button1"] List:@[@"http://", @"https://"]];
    }
    [self.button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.demoView addSubview:self.button1];
    
    self.imageListView1 = [[DropDownList alloc] initWithFrame:CGRectMake(self.demoView.frame.size.width - 32, self.button1.frame.origin.y, 32, 30)];
//    self.imageListView1.backgroundColor = [UIColor redColor];
    self.imageListView1.textField = self.demoView.noText1;
    [self.demoView addSubview:self.imageListView1];
    
    //第三行
    self.button2 = [[DropDownButton alloc] initWithFrame:CGRectMake(self.demoView.socketLabel.frame.size.width + 5, self.demoView.socketLabel.frame.origin.y, 80, 30) Title:@"ws://" List:@[@"ws://", @"wss://"]];
    if ([[defaults valueForKey:@"button2"] length] > 0) {
        self.button2 = [[DropDownButton alloc] initWithFrame:CGRectMake(self.demoView.socketLabel.frame.size.width + 5, self.demoView.socketLabel.frame.origin.y, 80, 30) Title:[defaults valueForKey:@"button2"] List:@[@"ws://", @"wss://"]];
    }
    [self.button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.demoView addSubview:self.button2];
    
    self.imageListView2 = [[DropDownList alloc] initWithFrame:CGRectMake(self.demoView.frame.size.width - 32, self.button2.frame.origin.y, 32, 30)];
    self.imageListView2.textField = self.demoView.noText2;
    [self.demoView addSubview:self.imageListView2];
    
    //第四行
    self.button3 = [[DropDownButton alloc] initWithFrame:CGRectMake(self.demoView.configLabel.frame.size.width + 5, self.demoView.configLabel.frame.origin.y, 80, 30) Title:@"http://" List:@[@"http://", @"https://"]];
    if ([[defaults valueForKey:@"button3"] length] > 0) {
        self.button3 = [[DropDownButton alloc] initWithFrame:CGRectMake(self.demoView.configLabel.frame.size.width + 5, self.demoView.configLabel.frame.origin.y, 80, 30) Title:[defaults valueForKey:@"button3"] List:@[@"http://", @"https://"]];
    }
    [self.button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.demoView addSubview:self.button3];

    self.imageListView3 = [[DropDownList alloc] initWithFrame:CGRectMake(self.demoView.frame.size.width - 32, self.button3.frame.origin.y, 32, 30)];
    self.imageListView3.textField = self.demoView.noText3;
    [self.demoView addSubview:self.imageListView3];
    
    //数据存储
    self.demoView.appKeyText.text = [defaults valueForKey:@"appKeyText"];
    self.demoView.uploadText.text = [defaults valueForKey:@"uploadText"];
    self.demoView.noText1.text = [defaults valueForKey:@"noText1"];
    self.demoView.socketText.text = [defaults valueForKey:@"socketText"];
    self.demoView.noText2.text = [defaults valueForKey:@"noText2"];
    self.demoView.configText.text = [defaults valueForKey:@"configText"];
    self.demoView.noText3.text = [defaults valueForKey:@"noText3"];
    self.demoView.uploadAddressText.text = [defaults valueForKey:@"uploadAddressText"];
    self.demoView.socketAddressText.text = [defaults valueForKey:@"socketAddressText"];
    self.demoView.configAddressText.text = [defaults valueForKey:@"configAddressText"];
    
    
    
    UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)];
    //点击几次后触发事件响应，默认为：1
    click.numberOfTapsRequired = 3;
    //需要几个手指点击时触发事件，默认：1
    click.numberOfTouchesRequired = 1;
    [self.demoView addGestureRecognizer:click];
}

- (void)clickAction {
//    self.demoView.socketLabel.frame.size.height = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - 保存设置

- (void)saveButtonAction {
    [self.demoView.appKeyText resignFirstResponder];
    [self.demoView.uploadText resignFirstResponder];
    [self.demoView.noText1 resignFirstResponder];
    [self.demoView.socketText resignFirstResponder];
    [self.demoView.noText2 resignFirstResponder];
    [self.demoView.configText resignFirstResponder];
    [self.demoView.noText3 resignFirstResponder];

    if ([self.demoView.appKeyText.text isEqualToString: @""]) {
        [self showAlert:@"app key设置异常"];
        return;
    }
    if ([self.demoView.uploadText.text isEqualToString: @""] || [self.demoView.noText1.text isEqualToString: @""]) {
        [self showAlert:@"upload设置异常"];
        return;
    }
    if ([self.demoView.socketText.text isEqualToString: @""] || [self.demoView.noText2.text isEqualToString: @""]) {
        [self showAlert:@"socket设置异常"];
        return;
    }
    if ([self.demoView.configText.text isEqualToString: @""] || [self.demoView.noText3.text isEqualToString: @""]) {
        [self showAlert:@"config设置异常"];
        return;
    }
    [self showAlert:@"保存成功！"];
    
    self.demoView.uploadAddressText.text = [NSString stringWithFormat:@"%@%@%@%@",self.button1.titleLabel.text,self.demoView.uploadText.text,self.demoView.colonLabel1.text,self.demoView.noText1.text];
    self.demoView.socketAddressText.text = [NSString stringWithFormat:@"%@%@%@%@",self.button2.titleLabel.text,self.demoView.socketText.text,self.demoView.colonLabel2.text,self.demoView.noText2.text];
    self.demoView.configAddressText.text = [NSString stringWithFormat:@"%@%@%@%@",self.button3.titleLabel.text,self.demoView.configText.text,self.demoView.colonLabel3.text,self.demoView.noText3.text];
    self.demoView.dataText.text = @"";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:self.demoView.appKeyText.text forKey:@"appKeyText"];
    [defaults setValue:self.button1.titleLabel.text forKey:@"button1"];
    [defaults setValue:self.demoView.uploadText.text forKey:@"uploadText"];
    [defaults setValue:self.demoView.noText1.text forKey:@"noText1"];
    [defaults setValue:self.button2.titleLabel.text forKey:@"button2"];
    [defaults setValue:self.demoView.socketText.text forKey:@"socketText"];
    [defaults setValue:self.demoView.noText2.text forKey:@"noText2"];
    [defaults setValue:self.button3.titleLabel.text forKey:@"button3"];
    [defaults setValue:self.demoView.configText.text forKey:@"configText"];
    [defaults setValue:self.demoView.noText3.text forKey:@"noText3"];
    [defaults setValue:self.demoView.uploadAddressText.text forKey:@"uploadAddressText"];
    [defaults setValue:self.demoView.socketAddressText.text forKey:@"socketAddressText"];
    [defaults setValue:self.demoView.configAddressText.text forKey:@"configAddressText"];

    
    [AnalysysAgent setUploadURL:self.demoView.uploadAddressText.text];
    [AnalysysAgent setVisitorDebugURL:self.demoView.socketAddressText.text];
    [AnalysysAgent setVisitorConfigURL:self.demoView.configAddressText.text];
}

#pragma mark - 发送数据

- (void)sendDataButtonAction {
    [self.demoView.appKeyText resignFirstResponder];
    [self.demoView.uploadText resignFirstResponder];
    [self.demoView.noText1 resignFirstResponder];
    [self.demoView.socketText resignFirstResponder];
    [self.demoView.noText2 resignFirstResponder];
    [self.demoView.configText resignFirstResponder];
    [self.demoView.noText3 resignFirstResponder];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getChatlistFromNotification:) name:@"uploadingMsgNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getChatlistFromNotification:) name:@"uploadMsgSuccessNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getChatlistFromNotification:) name:@"uploadMsgFailedsNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getChatlistFromNotification:) name:@"reUploadMsgNotification" object:nil];

    [AnalysysAgent track:@"trackAction"];
}

#pragma mark - 弹窗提示

- (void)showAlert:(NSString *)_message {
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:_message delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"done", nil];
    [promptAlert show];
}

#pragma mark - 接收通知

- (void)getChatlistFromNotification:(NSNotification *)notification {
    NSLog(@"收到数据接收通知:%@   :%@", notification.name, notification.object);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.demoView.dataText.text = [NSString stringWithFormat:@"%@",notification.object];
    });
}

#pragma mark - 触摸屏幕时触发

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.button1.tag = 2;
    [self.button1 startPackUpAnimation];
    self.button2.tag = 2;
    [self.button2 startPackUpAnimation];
    self.button3.tag = 2;
    [self.button3 startPackUpAnimation];
    self.imageListView1.tag = 1;
    [self.imageListView1 dropdown];
    self.imageListView2.tag = 1;
    [self.imageListView2 dropdown];
    self.imageListView3.tag = 1;
    [self.imageListView3 dropdown];
    [self.demoView.appKeyText resignFirstResponder];
    [self.demoView.uploadText resignFirstResponder];
    [self.demoView.noText1 resignFirstResponder];
    [self.demoView.socketText resignFirstResponder];
    [self.demoView.noText2 resignFirstResponder];
    [self.demoView.configText resignFirstResponder];
    [self.demoView.noText3 resignFirstResponder];
}

@end
