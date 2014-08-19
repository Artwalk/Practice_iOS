//
//  ViewController.m
//  15.7.Assets Library
//
//  Created by artwalk on 8/19/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)assetsLibrary:(id)sender {
    ALAssetsLibrary *al = [[ALAssetsLibrary alloc] init];
    
    dispatch_queue_t dQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(dQueue, ^{
        [al enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            __block BOOL foundThePhoto = NO;
            __block BOOL foundTheVideo = NO;
            
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                
                if (foundThePhoto || foundTheVideo) {
                    *stop = YES;
                }
                
                NSString *assetType = [result valueForProperty:ALAssetPropertyType];
                
                if ([assetType isEqualToString:ALAssetTypePhoto]) {
                    NSLog(@"photo");
                    
                    foundThePhoto = YES;
                    *stop = NO;
                    ALAssetRepresentation *aRepresentation = [result defaultRepresentation];
                    
                    CGFloat imgScale = [aRepresentation scale];
                    UIImageOrientation imgOrientation = (UIImageOrientation)[aRepresentation orientation];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        CGImageRef imgRef = [aRepresentation fullResolutionImage];
                        
                        UIImage *img = [[UIImage alloc ] initWithCGImage:imgRef scale:imgScale orientation:imgOrientation];
                        if (img != nil) {
                            self.imageView.image = img;
                        }
                        
                    });
                    
                    
                } else if ([assetType isEqualToString:ALAssetTypeVideo]) {
                    NSLog(@"video");
                    foundTheVideo = YES;
                    *stop = YES;
                    ALAssetRepresentation *aRepresentation = [result defaultRepresentation];
                    
                    const NSUInteger bufSize = 1024;
                    uint8_t buffer[bufSize];
                    NSUInteger bytesRead = 0;
                    long long curOffset = 0;
                    NSError *readingErr = nil;
                    
                    NSString *videoPath = [[self documentFolderPath] stringByAppendingPathComponent:@"Temp.MOV"];
                    
                    NSFileManager *fManager = [[NSFileManager alloc] init];
                    
                    if ([fManager fileExistsAtPath:videoPath] == NO) {
                        [fManager createFileAtPath:videoPath contents:nil attributes:nil];
                    }
                    
                    NSFileHandle *fHandle = [NSFileHandle fileHandleForWritingAtPath:videoPath];
                    
                    do {
                        bytesRead = [aRepresentation getBytes:(uint8_t *)&buffer fromOffset:curOffset length:bufSize error:&readingErr];
                        
                        if (bytesRead == 0) {
                            break;
                        }
                        
                        curOffset += bytesRead;
                        
                        NSData *readData = [[NSData alloc] initWithBytes:(const void *)buffer length:bytesRead];
                        
                        [fHandle writeData:readData];
                    } while (bytesRead > 0);
              
                    
                } else if ([assetType isEqualToString:ALAssetTypeUnknown]) {
                    NSLog(@"unknown");
                }
                /*
                NSDictionary *assetURLs = [result valueForProperty:ALAssetPropertyURLs];
                
                NSUInteger assetCounter = 0;
                for (NSString *k in assetURLs) {
                    assetCounter ++;
                    NSLog(@"%lu = %@", assetCounter, [assetURLs valueForKey:k]);
                }
                
                ALAssetRepresentation *aRepresentation = [result defaultRepresentation];
                NSLog(@"%lld", [aRepresentation size]);
                */
            }];
            
        } failureBlock:^(NSError *error) {
            NSLog(@"%@", error);
        }];
    });
    
}

- (NSString *)documentFolderPath {
    NSFileManager *fManager = [[NSFileManager alloc] init];
    NSURL *url = [fManager URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    
    return url.path;
}

@end
