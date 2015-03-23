//
//  Item.m
//  pr0gramm
//
//  Created by wolfposd on 22.03.15.
//  Copyright (c) 2015 pr0gramm. All rights reserved.
//

#import "Item.h"

@implementation Item

+(Item*) itemFromDictionary:(NSDictionary*) dict
{
    Item* item = [Item new];
    
    item.itemid = [dict[@"id"] unsignedIntegerValue];
    item.promoted = [dict[@"promoted"] shortValue];
    item.up = [dict[@"up"] shortValue];
    item.down = [dict[@"down"] shortValue];
    item.created = [dict[@"created"] unsignedIntegerValue];
    item.image = dict[@"image"];
    item.thumb = dict[@"thumb"];
    item.fullsize = dict[@"fullsize"];
    item.source = dict[@"source"];
    item.flags = [dict[@"flags"] shortValue];
    item.user = dict[@"user"];
    item.mark = [dict[@"mark"] shortValue];
    
    return item;
}



- (NSString *)description
{
    NSString* type = [self.image containsString:@"webm"] ? @"webm": @"img";
    return [NSString stringWithFormat:@"[Item %lu from:%@ type:%@]",  (unsigned long)self.itemid, self.user, type ];
}



@end
