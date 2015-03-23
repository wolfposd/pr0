//
//  REST.m
//  pr0gramm
//
//  Created by wolfposd on 22.03.15.
//  Copyright (c) 2015 pr0gramm. All rights reserved.
//

#import "REST.h"




@implementation REST




+(UIImage*) getImageForItem:(Item*) item
{
    NSURL* url = [NSURL URLWithString:[REST_PROIMG stringByAppendingString:item.image]];
    UIImage* image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    return image;
    
}

+(UIImage*) getThumbImageForItem:(Item*) item
{
    NSURL* url = [NSURL URLWithString:[REST_PROTHUMB stringByAppendingString:item.thumb]];
    NSLog(@"%@", url);
    UIImage* image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    return image;
    
}


+(void) getItems:(void(^)(NSArray* items)) resultblock
{
    
    [self rest_GET:@"items/get" resultdata:^(NSData* result){
        
        NSMutableArray* items = [NSMutableArray new];
        
        if(result)
        {
            NSError* error = nil;
            NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:result options:kNilOptions error:&error];
                        
            if(dict)
            {                
                for(NSDictionary* itemdict in dict[@"items"])
                {
                    Item* item = [Item itemFromDictionary:itemdict];
                    [items addObject:item];
                }
            }
        }
        
        resultblock(items);
        
    }];
    
}



+(void) rest_GET:(NSString*) command resultdata:(void (^)(NSData* data)) resultdata
{
    [self rest:@"GET" with:command resultdata:resultdata];
}

+(void) rest_POST:(NSString*) command resultdata:(void (^)(NSData* data)) resultdata
{
    [self rest:@"POST" with:command resultdata:resultdata];
}

+(void) rest:(NSString* ) httpmethod with:(NSString*) command resultdata:(void (^)(NSData* data)) resultdata
{
    NSURL* url = [NSURL URLWithString:[REST_PROAPI stringByAppendingString:command]];
    
    NSLog(@"%@", url);
    
    NSMutableURLRequest *urlrequest=[[NSMutableURLRequest alloc]init];
    
    [urlrequest setURL:url];
    [urlrequest setHTTPMethod:httpmethod];
    
    
    [NSURLConnection sendAsynchronousRequest:urlrequest queue:[NSOperationQueue new]
                           completionHandler:^(NSURLResponse* response, NSData* data, NSError* connectionError)
     {
         if(data)
         {
             resultdata(data);
         }
     }];
    
}




@end
