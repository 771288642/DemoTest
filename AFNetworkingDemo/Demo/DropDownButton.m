//
//  DropDownButton.m
//  Demo
//
//  Created by analysysmac-1 on 2018/7/30.
//  Copyright © 2018年 analysysmac-1. All rights reserved.
//

#import "DropDownButton.h"

static NSString *CellIdentifier = @"DropDownCell";

@interface DropDownButton () <UITableViewDataSource, UITableViewDelegate> {
    UITableView *listView;
}

@end

@implementation DropDownButton

- (void)setupDefaultTable {
    listView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 0) style:UITableViewStylePlain];
    listView.separatorColor = UIColor.lightGrayColor;
    listView.dataSource = self;
    listView.delegate = self;
}

- (void)startDropDownAnimation {
    CGRect frame = listView.frame;
    frame.size.height = self.frame.size.height * self.list.count;
    [UIView animateWithDuration:0.3 animations:^{
        self->listView.frame = frame;
    }completion:^(BOOL finished){
        
    }];
}

- (void)startPackUpAnimation {
    CGRect frame = listView.frame;
    frame.size.height = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self->listView.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)clickedToDropDown {
    self.tag++;
    self.tag%2 ? [self startDropDownAnimation] : [self startPackUpAnimation];
    [self.superview bringSubviewToFront:listView];
}

#pragma mark - delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = (NSString *)[self.list objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = UIColor.blackColor;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self setTitle:self.list[indexPath.row] forState:UIControlStateNormal];
    [self clickedToDropDown];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.frame.size.height;
}

#pragma mark - init

- (void)setup {
    [self setTitle:self.title forState:UIControlStateNormal];
    [self setupDefaultTable];
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self addTarget:self action:@selector(clickedToDropDown) forControlEvents:UIControlEventTouchUpInside];
}

- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title List:(NSArray *)list {
    self = [super initWithFrame:frame];
    if (self) {
        self.title = [NSString stringWithString:title];
        self.list = [NSArray arrayWithArray:list];
        [self setup];
    }
    return self;
}

- (void)didMoveToSuperview {
    [self.superview addSubview:listView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
