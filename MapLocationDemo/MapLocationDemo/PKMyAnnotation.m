//
//  PKMyAnnotation.m
//  MapLocationDemo
//
//  Created by 周经伟 on 14-8-13.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKMyAnnotation.h"

@implementation PKMyAnnotation
/**
 *气泡标题
 */
-(NSString *) title{
    return NSLocalizedString(@"我在这里", @"oh.I am here");
}

/**
 *副标题
 */
-(NSString *)subtitle{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:1];
    
    if(self.street)
    {
        [array addObject:self.street];
    }
    if(self.city)
    {
        [array addObject:self.city];
    }
    if(self.state)
    {
        [array addObject:self.state];
    }
    if(self.zip)
    {
        [array addObject:self.zip];
    }
    if(self.country)
    {
        [array addObject:self.country];
    }
    NSString *result = [array componentsJoinedByString:@","];
    return result;
}

/**
 *编码
 */
-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.street forKey:@"street"];
    [aCoder encodeObject:self.city forKey:@"city"];
    [aCoder encodeObject:self.state forKey:@"state"];
    [aCoder encodeObject:self.zip forKey:@"zip"];
    [aCoder encodeObject:self.country forKey:@"country"];
}

/**
 *解码
 */
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.street = [aDecoder decodeObjectForKey:@"street"];
        self.city = [aDecoder decodeObjectForKey:@"city"];
        self.state = [aDecoder decodeObjectForKey:@"state"];
        self.zip = [aDecoder decodeObjectForKey:@"zip"];
        self.country = [aDecoder decodeObjectForKey:@"country"];
    }
    return self;
}

@end
