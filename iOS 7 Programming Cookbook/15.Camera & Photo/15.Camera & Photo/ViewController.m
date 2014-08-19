//
//  ViewController.m
//  15.Camera & Photo
//
//  Created by artwalk on 8/19/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (BOOL)cameraSupportsMedia:(NSString *)mediaType sourceType:(UIImagePickerControllerSourceType)sourceType {
    __block BOOL result = NO;
    
    if ([mediaType length] == 0) {
        return NO;
    }
    
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    
    [availableMediaTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:mediaType]) {
            result = YES;
            *stop = YES;
        }
    }];
    
    return result;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   

}
- (IBAction)pickPhoto:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        if ([self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary]) {
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        }
        
        if ([self cameraSupportsMedia:(__bridge NSString*)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary]) {
            [mediaTypes addObject:(__bridge NSString *)kUTTypeMovie];
        }
        
        controller.mediaTypes = mediaTypes;
        controller.delegate = self;
        
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (IBAction)takeVideo:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && [self cameraSupportsMedia:(__bridge NSString*)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypeCamera] ) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        controller.mediaTypes = @[(__bridge NSString*)kUTTypeMovie];
        
        controller.allowsEditing = YES;
        controller.delegate = self;
        
        controller.videoQuality = UIImagePickerControllerQualityTypeHigh;
        controller.videoMaximumDuration = 10.0f;
        
        [self presentViewController:controller animated:YES completion:nil];
    }
 
}

- (IBAction)takePhoto:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && [self cameraSupportsMedia:(__bridge NSString*)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera] ) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        NSString *requiredMediaType = (__bridge NSString*)kUTTypeImage;
        
        controller.mediaTypes = [[NSArray alloc] initWithObjects:requiredMediaType, nil];
        
        controller.allowsEditing = YES;
        controller.delegate = self;
        
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"%@", info);
    
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeMovie]) {
        NSURL *urlOfVideo = info[UIImagePickerControllerMediaURL];
        
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
        if (urlOfVideo != nil) {
            [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:urlOfVideo completionBlock:^(NSURL *assetURL, NSError *error) {
                if (error == nil) {
                    NSLog(@"OK");
                } else {
                    NSLog(@"%@", error);
                }
            }];
        }
        
    } else if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        NSDictionary *metadata = info[UIImagePickerControllerMediaMetadata];
        UIImage *theImage = nil;
        if ([picker allowsEditing]) {
            theImage = info[UIImagePickerControllerEditedImage];
        } else {
            theImage = info[UIImagePickerControllerOriginalImage];
        }
        
        
        UIImageWriteToSavedPhotosAlbum(theImage, self, @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:), NULL);
        
        self.imageView.image = theImage;
        NSLog(@"%@\n %@", metadata, theImage);
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageWasSavedSuccessfully:(UIImage *) image
    didFinishSavingWithError: (NSError *) error
                           contextInfo: (void *) contextInfo {
    if (error == nil) {
        NSLog(@"saved");
    } else {
        NSLog(@"%@", error);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

@end
