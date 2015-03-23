//
//  ViewController.m
//  pr0gramm
//
//  Created by wolfposd on 22.03.15.
//  Copyright (c) 2015 pr0gramm. All rights reserved.
//

#import "ViewController.h"

#import "REST.h"
#import "Item.h"
#import "ImageCollectionViewCell.h"

#import "MWPhotoBrowser.h"
#import "SDWebImageManager.h"


@interface ViewController ()<MWPhotoBrowserDelegate>
@property (nonatomic,strong) NSArray* items;
@property (nonatomic,strong) NSArray* photos;
@property (nonatomic,strong) MWPhotoBrowser* browser;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.items = @[];
    self.photos = @[];
    
    [self refreshItemsFromPr0:YES];
}


-(void) refreshItemsFromPr0:(BOOL) isInitialPush
{
    [REST getItems:^(NSArray* items){
        self.items = items;
        
        NSMutableArray* photos = [NSMutableArray new];
        
        for(Item* item in items)
        {
            NSString* urlString =[REST_PROTHUMB stringByAppendingString:item.thumb];
            [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:urlString]]];
        }
        self.photos = photos;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(isInitialPush)
            {
                [self setupPhotoBrowserGallery];
            }
            else
            {
                [self.browser reloadData];
                [self.browser setCurrentPhotoIndex:0];
            }
        });
    }];
}


-(void) setupPhotoBrowserGallery
{
    NSLog(@"%@", @"PUSHING NOW");
    MWPhotoBrowser* browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    browser.displayActionButton = YES;
    browser.displayNavArrows = YES;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = NO;
    browser.alwaysShowControls = NO;
    browser.enableGrid = YES;
    browser.startOnGrid = YES;
    browser.hideDoneButton = YES;
    
    [browser setCurrentPhotoIndex:0];
    
    self.browser = browser;
   
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    [self presentViewController:nc animated:NO completion:^{
        
        UIBarButtonItem* reload = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                target:self action:@selector(refreshImages:)];
        
        [browser.navigationItem setRightBarButtonItems:@[reload]];
    }];
    
    
}


-(void) refreshImages:(id) caller
{
    NSLog(@"%@", @"refreshing images");
    [self refreshItemsFromPr0:NO];
}


#pragma mark - MWPhotoBrowserDelegate

-(NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    NSLog(@"%@ %lu", @"count called", self.photos.count);
    return self.photos.count;
}

-(id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    Item* i = self.items[index];
    
    if([i.image containsString:@"webm"])
    {
        return [self photoBrowser:photoBrowser thumbPhotoAtIndex:index];
    }
    else
    {
        NSString* url = [REST_PROIMG stringByAppendingString:i.image];
        [self preDownloadImage:index+1];
        
        return [MWPhoto photoWithURL:[NSURL URLWithString:url]];
    }
}


-(void) preDownloadImage:(NSUInteger) index
{
    NSLog(@"%@", @"predownloading next image");
    if (index< self.items.count)
    {
        NSURL* urlOfNextImage = [NSURL URLWithString:[REST_PROIMG stringByAppendingString: [ (Item*)self.items[index] image] ]];
        SDWebImageManager* manager = [SDWebImageManager sharedManager];
        
        [manager downloadImageWithURL:urlOfNextImage options:0 progress:^(NSInteger recsm, NSInteger exS){
            // do nothing
        } completed:^(UIImage* img, NSError* error, SDImageCacheType type, BOOL fin, NSURL* imgurl){
            // do nothing
        }];
    }
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index
{
    return self.photos[index];
}

-(void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index
{
    NSLog(@"%lu", (unsigned long)index);
}



@end
