//
//  ViewController.m
//  12.1Audio
//
//  Created by artwalk on 8/16/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()  <AVAudioPlayerDelegate>
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSError *audioSessionError = nil;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if ([audioSession setCategory:AVAudioSessionCategoryAmbient error:&audioSessionError]) {
        NSLog(@"Successfully set the seession");
    } else {
        ;
    }
    
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(dispatchQueue, ^{
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSString *filePath = [mainBundle pathForResource:@"MySong" ofType:@"mp3"];
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        
        NSError *error = nil;
        
        self.audioPlayer = [[AVAudioPlayer alloc] initWithData:fileData error:&error];
        
        if (self.audioPlayer != nil) {
            self.audioPlayer.delegate = self;
            if ([self.audioPlayer prepareToPlay] && [self.audioPlayer play]) {
                NSLog(@"Playing");
            } else {
                NSLog(@"Failed to play");
            }
            
        } else {
            NSLog(@"Failed to instantiate AVAudioPlayer");
        }
        
    });
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AVAudioPlayer

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if ([player isEqual:self.audioPlayer]) {
        self.audioPlayer = nil;
    }
}

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player {
//    [player pause];
    NSLog(@"Audio Session is interrupted. The player will be paused here");
}

- (void) audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags {
    if (flags == AVAudioSessionInterruptionOptionShouldResume && player != nil) {
        [player play];
    }
}

@end
