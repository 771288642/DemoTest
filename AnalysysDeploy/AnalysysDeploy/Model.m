//
//  Model.m
//  AnalysysDeploy
//
//  Created by analysysmac-1 on 2018/8/9.
//  Copyright © 2018年 analysysmac-1. All rights reserved.
//

#import "Model.h"

@implementation Model

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.appKey forKey:@"appKey"];
    [aCoder encodeObject:self.uploadProtocol forKey:@"uploadProtocol"];
    [aCoder encodeObject:self.uploadAddress forKey:@"uploadAddress"];
    [aCoder encodeObject:self.uploadPort forKey:@"uploadPort"];
    [aCoder encodeObject:self.socketProtocol forKey:@"socketProtocol"];
    [aCoder encodeObject:self.socketAddress forKey:@"socketAddress"];
    [aCoder encodeObject:self.socketPort forKey:@"socketPort"];
    [aCoder encodeObject:self.configProtocol forKey:@"configProtocol"];
    [aCoder encodeObject:self.configAddress forKey:@"configAddress"];
    [aCoder encodeObject:self.configPort forKey:@"configPort"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.appKey = [aDecoder decodeObjectForKey:@"appKey"];
        self.uploadProtocol = [aDecoder decodeObjectForKey:@"uploadProtocol"];
        self.uploadAddress = [aDecoder decodeObjectForKey:@"uploadAddress"];
        self.uploadPort = [aDecoder decodeObjectForKey:@"uploadPort"];
        self.socketProtocol = [aDecoder decodeObjectForKey:@"socketProtocol"];
        self.socketAddress = [aDecoder decodeObjectForKey:@"socketAddress"];
        self.socketPort = [aDecoder decodeObjectForKey:@"socketPort"];
        self.configProtocol = [aDecoder decodeObjectForKey:@"configProtocol"];
        self.configAddress = [aDecoder decodeObjectForKey:@"configAddress"];
        self.configPort = [aDecoder decodeObjectForKey:@"configPort"];
    }
    return self;
}

@end
