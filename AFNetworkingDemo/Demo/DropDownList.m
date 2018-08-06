//
//  DropDownList.m
//  Demo
//
//  Created by analysysmac-1 on 2018/7/31.
//  Copyright © 2018年 analysysmac-1. All rights reserved.
//

#import "DropDownList.h"

@implementation DropDownList

@synthesize textField, list, listView, lineColor, listBgColor, borderStyle;

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        list = [NSArray array];
        list = @[@"8089",@"4089",@"4091",@"9091"];
        borderStyle = UITextBorderStyleRoundedRect;
        showList = NO;//默认不显示下拉框
        oldFrame = frame;//未下拉时控件初始大小
        //当下拉框显示时，计算出控件的大小。
        newFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height*5);
        [self drawView];//调用方法，绘制控件
    }
    return self;
}

- (void)drawView {
    
    button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, oldFrame.size.width, oldFrame.size.height)];
    [button setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    [self addSubview:button];
    [button addTarget:self action:@selector(dropdown) forControlEvents:UIControlEventTouchUpInside];
    //下拉列表
    listView = [[UITableView alloc] initWithFrame:CGRectMake(-30, oldFrame.size.height+lineWidth, oldFrame.size.width-lineWidth*2+30, oldFrame.size.height*4-lineWidth*2)];
    listView.dataSource = self;
    listView.delegate = self;
    listView.backgroundColor = listBgColor;
    listView.separatorColor = lineColor;
    listView.hidden = !showList;//一开始listView是隐藏的，此后根据showList的值显示或隐藏
    [self addSubview:listView];
    
}

- (void)dropdown{
    self.tag++;
    self.tag%2 ? [self setShowList:YES] : [self setShowList:NO];
    [self.superview bringSubviewToFront:self];
}

#pragma marklistViewdataSource method and delegate method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    
    return list.count;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellid = @"listviewid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    //文本标签
    cell.textLabel.text = (NSString *)[list objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:11];
    cell.textLabel.textColor = UIColor.blackColor;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return oldFrame.size.height;
    
}

//当选择下拉列表中的一行时，设置文本框中的值，隐藏下拉列表
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    textField.text = (NSString *)[list objectAtIndex:indexPath.row];
    [self setShowList:NO];
    
}

- (BOOL)showList {//setShowList:No为隐藏，setShowList:Yes为显示
    return showList;
}

- (void)setShowList:(BOOL)b {
    showList = b;
    if (showList) {
        self.frame = newFrame;
    }else {
        self.frame = oldFrame;
    }
    listView.hidden = !b;
}

//-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
//{
//    if ([self isEqual:listView]) {
//        CGRect bounds = self.bounds;
//        //扩大原热区直径至26，可以暴露个接口，用来设置需要扩大的半径。
//        CGFloat widthDelta = MAX(26, 0);
//        CGFloat heightDelta = MAX(26, 0);
//        bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
//        return CGRectContainsPoint(bounds, point);
//    }
//    return YES;
//}
//
//
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
// [super hitTest:point withEvent:event];
//    if ([self isEqual:listView]) {
//        CGRect rectBig = CGRectInset(self.bounds, -30, -(27.0/2));
//
//        if (CGRectContainsPoint(rectBig, point)) {
//            return self;
//        }else{
//            return nil;
//        }
//
//        return self;
//    }
//    return self;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
