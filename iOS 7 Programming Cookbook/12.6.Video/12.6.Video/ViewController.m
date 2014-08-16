//
//  ViewController.m
//  12.6.Video
//
//  Created by artwalk on 8/17/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()

@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;
@property (nonatomic, strong) UIButton *playButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self startPlayingVideo:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startPlayingVideo:(id)sender {
    NSBundle *mainBundle = [NSBundle mainBundle];
    
    NSURL *url = [mainBundle URLForResource:@"sample" withExtension:@"m4v"];
    
    
    if (self.moviePlayer != nil) {
        [self stopPlayingVideo:nil];
    }
    
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    
    if (self.moviePlayer != nil) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoHasFinishedPlaying:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
        
        self.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
       
        [self.moviePlayer.view setFrame:self.view.frame];
        [self.view addSubview:self.moviePlayer.view];
        
        [self.moviePlayer setFullscreen:YES animated:NO];
        
        [self.moviePlayer play];
    }
}

- (void)stopPlayingVideo:(id)sender {
    if (self.moviePlayer != nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
        
        [self.moviePlayer stop];
        [self.moviePlayer.view removeFromSuperview];
    }
}

- (void)videoHasFinishedPlaying:(NSNotification *)notification {
    NSNumber *reason = notification.userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    
    if (reason != nil) {
        MPMovieFinishReason reasonAsInteger = [reason integerValue];

        switch (reasonAsInteger) {
            case MPMovieFinishReasonPlaybackEnded:
                break;
            case MPMovieFinishReasonPlaybackError:
                break;
            case MPMovieFinishReasonUserExited:
                break;
            default:
                break;
        }
        [self stopPlayingVideo:nil];
    }
}

@end
