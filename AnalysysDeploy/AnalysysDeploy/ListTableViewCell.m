//
//  ListTableViewCell.m
//  AnalysysDeploy
//
//  Created by SoDo on 2018/8/6.
//  Copyright © 2018年 analysysmac-1. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = UIColor.redColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
