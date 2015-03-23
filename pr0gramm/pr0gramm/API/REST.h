//
//  REST.h
//  pr0gramm
//
//  Created by wolfposd on 22.03.15.
//  Copyright (c) 2015 pr0gramm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>
#import "Item.h"



#define REST_PROAPI @"http://pr0gramm.com/api/"
#define REST_PROIMG @"http://img.pr0gramm.com/"
#define REST_PROTHUMB @"http://thumb.pr0gramm.com/"


@interface REST : NSObject



/**
 *  calls api to get list of items
 *
 *  @param resultblock returns array of Item.h or empty array
 */
+(void) getItems:(void(^)(NSArray* items)) resultblock;



/**
 *  Downloads the image for the given item
 *
 *  @param item
 *
 *  @return UIImage or nil
 */
+(UIImage*) getImageForItem:(Item*) item;

/**
 *  Downloads the thumb-image for the given item
 *
 *  @param item
 *
 *  @return UIImage or nil
 */
+(UIImage*) getThumbImageForItem:(Item*) item;


@end
