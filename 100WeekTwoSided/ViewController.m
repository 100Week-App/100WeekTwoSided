//
//  ViewController.m
//  100WeekTwoSided
//
//  Created by Mitesh Maheta on 07/04/15.
//  Copyright (c) 2015 tipsy. All rights reserved.
//

#import "ViewController.h"
#import "GlobalMethods.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController (){
    MPMoviePlayerController *videoObject;
    GlobalModel *superModel;
    IBOutlet UIImageView *imgReference;
    float videoProgressTime;
    
    NSTimer *timerVideoProgress;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    superModel = [[GlobalModel alloc]init];
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"mainView" owner:self options:Nil];
    self.view = [nib objectAtIndex:0];
    
    [GlobalMethods addConstarintsToView:self.view superView:self.view top:0 bottom:0 left:0 right:0];
    
    videoObject = [[MPMoviePlayerController alloc]init];
    [videoObject.view setFrame:CGRectMake(0, 0, superModel.deviceWidth, superModel.deviceHeight/2)];
    videoObject.scalingMode = MPMovieScalingModeFill;
    videoObject.view.backgroundColor = [UIColor clearColor];
    videoObject.controlStyle = MPMovieControlStyleNone;
    
    [self.view addSubview:videoObject.view];
    
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"tech" ofType:@"mp4"];
    NSURL *videoURL = [NSURL fileURLWithPath:videoPath];
    [videoObject setContentURL:videoURL];
    [videoObject prepareToPlay];
    [videoObject play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self // the object listening / "observing" to the notification
                                             selector:@selector(myMovieFinishedCallback:) // method to call when the notification was pushed
                                                 name:MPMoviePlayerPlaybackDidFinishNotification // notification the observer should listen to
                                               object:videoObject];
    
    timerVideoProgress = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                     target:self
                                   selector:@selector(updatePlaybackTime:)
                                   userInfo:nil
                                    repeats:YES];
    
    // Do any additional setup after loading the view, typically from a nib.
    
}
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    videoObject.view.frame = CGRectMake(0, 0, size.width, size.height/2);
    
}
-(void)updatePlaybackTime:(id)sender{
    
    videoProgressTime++;
    if (videoProgressTime == 3) {
        
        UIImage * toImage = [UIImage imageNamed:@"tech.png"];
        [UIView transitionWithView:imgReference
                          duration:1.5f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            imgReference.image = toImage;
                        } completion:nil];
        
    }else if (videoProgressTime == 6){
        
        UIImage * toImage = [UIImage imageNamed:@"jewellery.png"];
        [UIView transitionWithView:imgReference
                          duration:1.5f
                           options:UIViewAnimationOptionTransitionCurlUp
                        animations:^{
                            imgReference.image = toImage;
                        } completion:nil];
    }else if (videoProgressTime == 12){
        
        UIImage * toImage = [UIImage imageNamed:@"mobile.png"];
        [UIView transitionWithView:imgReference
                          duration:1.5f
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        animations:^{
                            imgReference.image = toImage;
                        } completion:nil];
    }else if (videoProgressTime == 18){
        
        UIImage * toImage = [UIImage imageNamed:@"Movies.png"];
        [UIView transitionWithView:imgReference
                          duration:1.5f
                           options:UIViewAnimationOptionTransitionCurlUp
                        animations:^{
                            imgReference.image = toImage;
                        } completion:nil];
    }
    
    
}
-(void)myMovieFinishedCallback:(id)sender{
    [timerVideoProgress invalidate];
    timerVideoProgress = Nil;
    NSLog(@"Video Finished");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
