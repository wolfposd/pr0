//
//  Item.h
//  pr0gramm
//
//  Created by wolfposd on 22.03.15.
//  Copyright (c) 2015 pr0gramm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject


@property (nonatomic) NSUInteger itemid;
@property (nonatomic) short promoted;
@property (nonatomic) NSInteger up;
@property (nonatomic) NSInteger down;
@property (nonatomic) NSUInteger created;
@property (nonatomic, strong) NSString* image;
@property (nonatomic, strong) NSString* thumb;
@property (nonatomic, strong) NSString* fullsize;
@property (nonatomic, strong) NSString* source;
@property (nonatomic) short flags;
@property (nonatomic, strong) NSString* user;
@property (nonatomic) short mark;

//"id": 703857,
//"promoted": 0,
//"up": 1,
//"down": 0,
//"created": 1427036129,
//"image": "2015/03/22/4ad8022442f845a3.jpg",
//"thumb": "2015/03/22/4ad8022442f845a3.jpg",
//"fullsize": "2015/03/22/4ad8022442f845a3.jpg",
//"source": "",
//"flags": 1,
//"user": "Inspektor",
//"mark": 0



+(Item*) itemFromDictionary:(NSDictionary*) dict;

@end
