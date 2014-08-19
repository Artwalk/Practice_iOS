//
//  ViewController.m
//  15.8.Editing Videos
//
//  Created by artwalk on 8/19/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController () <UINavigationControllerDelegate, UIVideoEditorControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) NSURL *videoURLToEdit;
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;

@end

@implementation ViewController

- (void)videoEditorController:(UIVideoEditorController *)editor didSaveEditedVideoToPath:(NSString *)editedVideoPath {
    NSLog(@"%@", editedVideoPath);
    
    [editor dismissViewControllerAnimated:YES completion:nil];
}

- (void)videoEditorController:(UIVideoEditorController *)editor didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
    
    [editor dismissViewControllerAnimated:YES completion:nil];
}

- (void)videoEditorControllerDidCancel:(UIVideoEditorController *)editor {
    NSLog(@"The video editor was cancelled");
    
    [editor dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)cameraSupportsMedia:(NSString *)mediaType sourceType:(UIImagePickerControllerSourceType)sourceType {
    __block BOOL result = NO;
    
    if ([mediaType length] == 0) {
        return NO;
    }
    
    NSArray *availabelMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    
    [availabelMediaTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *type = (NSString *)obj;
        if ([type isEqualToString:mediaType]) {
            result = YES;
            *stop = YES;
        }
    }];
    
    return result;
}

- (BOOL)canUserPickVideosFromPhotoLibrary {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) isPhotoLibraryAvailable {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.assetsLibrary = [[ALAssetsLibrary alloc] init];
    
    if ([self isPhotoLibraryAvailable] && [self canUserPickVideosFromPhotoLibrary]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = @[(__bridge NSString *)kUTTypeMovie];
        imagePicker.delegate = self;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@".");
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        self.videoURLToEdit = [info objectForKey:UIImagePickerControllerMediaURL];
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        if (self.videoURLToEdit != nil) {
            NSString *videoPath = [self.videoURLToEdit path];
            
            if ([UIVideoEditorController canEditVideoAtPath:videoPath]) {
                UIVideoEditorController *videoEditor = [[UIVideoEditorController alloc] init];
                
                videoEditor.delegate = self;
                videoEditor.videoPath = videoPath;
                
                [self presentViewController:videoEditor animated:YES completion:nil];
            }
        }
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    self.videoURLToEdit = nil;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
