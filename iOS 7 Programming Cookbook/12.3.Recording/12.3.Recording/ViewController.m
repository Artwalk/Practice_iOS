//
//  ViewController.m
//  12.3.Recording
//
//  Created by artwalk on 8/16/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController () <AVAudioPlayerDelegate, AVAudioRecorderDelegate>

@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    [session setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionDuckOthers error:nil];
    
    [session requestRecordPermission:^(BOOL granted) {
        if (granted) {
            [self startRecordingAudio];
        } else {
            NSLog(@"User denied");
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) startRecordingAudio {
    NSError *error = nil;
    
    NSURL *audioRecordingURL = [self audioRecordingPath];
    
    self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:audioRecordingURL settings:[self audioRecordingSetting] error:&error];
    if (self.audioRecorder != nil) {
        self.audioRecorder.delegate = self;
        
        if ([self.audioRecorder prepareToRecord] && [self.audioRecorder record]) {
            NSLog(@"Recording...");
            
            [self performSelector:@selector(stopRecordingOnAudioRecorder:) withObject:self.audioRecorder afterDelay:5.0f];
        } else {
            NSLog(@"Failed to record");
            self.audioRecorder = nil;
        }
    } else {
        NSLog(@"Failed to create an instance of the audio recorder.");
    }
    
}

- (void)stopRecordingOnAudioRecorder:(AVAudioRecorder *)recorder {
    [recorder stop];
}

- (NSURL *)audioRecordingPath {
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    NSURL *documentsFolderUrl = [fileManager URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    
    return [documentsFolderUrl URLByAppendingPathComponent:@"Recording.m4a"];
}

- (NSDictionary *)audioRecordingSetting {
    return @{AVFormatIDKey: @(kAudioFormatAppleLossless), AVSampleRateKey:@(44100.0f), AVNumberOfChannelsKey:@1, AVEncoderAudioQualityKey:@(AVAudioQualityLow),};
}

#pragma mark - AVAudioRecorder

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    if (flag) {
        NSLog(@"stop");
        
        NSError *playbackError = nil;
        NSError *readingError = nil;
        
        NSData *fileData = [NSData dataWithContentsOfURL:[self audioRecordingPath] options:NSDataReadingMapped error:&readingError];
        
        self.audioPlayer = [[AVAudioPlayer alloc] initWithData:fileData error:&playbackError];
        
        if (self.audioPlayer != nil) {
            self.audioPlayer.delegate = self;
            
            if ([self.audioPlayer prepareToPlay] && [self.audioPlayer play]) {
                NSLog(@"playing");
            } else {
                NSLog(@"play error");
            }
            
        } else {
            NSLog(@"create error");
        }
    
    } else {
        NSLog(@"Stopping the audio recording failed");
    }

    self.audioRecorder = nil;
}

- (void)audioRecorderBeginInterruption:(AVAudioRecorder *)recorder {
    NSLog(@"recording interrupted");
}

- (void)audioRecorderEndInterruption:(AVAudioRecorder *)recorder withOptions:(NSUInteger)flags {
    if (flags == AVAudioSessionInterruptionOptionShouldResume) {
        [recorder record];
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if (flag) {
        NSLog(@"play OK");
    } else {
        ;
    }
    
    if ([player isEqual:self.audioPlayer]) {
        self.audioPlayer = nil;
    } else {
        ;
    }
}

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player {
    
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags {
    if (flags == AVAudioSessionInterruptionOptionShouldResume) {
        [player play];
    }
}

@end
