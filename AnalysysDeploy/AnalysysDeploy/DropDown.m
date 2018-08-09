//
//  DropDown.m
//  Demo
//
//  Created by analysysmac-1 on 2018/7/30.
//  Copyright © 2018年 analysysmac-1. All rights reserved.
//

#import "DropDown.h"

@implementation DropDown

@synthesize tv,tableArray,textField,showList;

-(id)initWithFrame:(CGRect)frame

{
    
    if (frame.size.height<300) {
        
        frameHeight =300;
        
    }else{
        
        frameHeight = frame.size.height;
        
    }
    
    tabheight = frameHeight-30;
    
    frame.size.height = 30.0f;
    
    self=[super initWithFrame:frame];
    
    if(self){
        
        showList = NO; //默认不显示下拉框
        
        tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, frame.size.width,300)];
        
        tv.delegate = self;
        
        tv.dataSource = self;
        
        tv.separatorColor = [UIColor lightGrayColor];
        
        tv.hidden = YES;
        
        tv.contentOffset =CGPointMake(0, 64);
        
        [self addSubview:tv];
        
        textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
        
        textField.borderStyle=UITextBorderStyleRoundedRect;//设置文本框的边框风格
        
        [textField addTarget:self action:@selector(dropdown) forControlEvents:UIControlEventAllTouchEvents];
        
        textField.font = [UIFont systemFontOfSize:16];
        
        textField.placeholder = @"请选择(长按)";
        
        //设置textfield 不弹出键盘
        
        textField.inputView=[[UIView alloc]initWithFrame:CGRectZero];
        
        textField.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
        
        [self addSubview:textField];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
        
        self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
        
        //省  市
        
        self.provinceArray = [self.pickerDic allKeys];
        
        tableArray = self.provinceArray;
        
    }
    
    return self;
    
}

//不展示列表

-(void)dontshowlist

{
    
    showList = NO;
    
    tv.hidden = YES;
    
    CGRect sf = self.frame;
    
    sf.size.height = 30;
    
    self.frame = sf;
    
    CGRect frame = tv.frame;
    
    frame.size.height = 0;
    
    tv.frame = frame;
    
}

-(void)dropdown

{
    
    //    [tv reloadData];
    
    [textField resignFirstResponder];
    
    if (showList) {//如果下拉框已显示，什么都不做
        
        [textField resignFirstResponder];
        
        return;
        
    }else {//如果下拉框尚未显示，则进行显示
        
        [textField resignFirstResponder];
        
        CGRect sf = self.frame;
        
        sf.size.height = frameHeight;
        
        //把dropdownList放到前面，防止下拉框被别的控件遮住
        
        [self.superview bringSubviewToFront:self];
        
        tv.hidden = NO;
        
        showList = YES;//显示下拉框
        
        tv.tableHeaderView.backgroundColor = [UIColor blackColor];
        
        CGRect frame = tv.frame;
        
        frame.size.height = 0;
        
        tv.frame = frame;
        
        frame.size.height = tabheight;
        
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        self.frame = sf;
        
        tv.frame = frame;
        
        [UIView commitAnimations];
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return [tableArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        
    }
    
    //cell.backgroundColor = [UIColor grayColor];
    
    cell.textLabel.text = [tableArray objectAtIndex:[indexPath row]];
    
    cell.textAlignment = UITextAlignmentCenter;
    
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 35;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    textField.text = [tableArray objectAtIndex:[indexPath row]];
    
    showList = NO;
    
    tv.hidden = YES;
    
    CGRect sf = self.frame;
    
    sf.size.height = 30;
    
    self.frame = sf;
    
    CGRect frame = tv.frame;
    
    frame.size.height = 0;
    
    tv.frame = frame;
    
    NSString *string = [NSString stringWithFormat:@"%ld",(long)[indexPath row]];
    
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:string,@"textOne",nil];
    
    //创建通知
    
    NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dict];
    
    //通过通知中心发送通知
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation

{
    
    // Return YES for supported orientations
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
