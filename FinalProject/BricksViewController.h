//
//  ViewController.h
//  BrickBreaker
//
//  Created by iD Student on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ControlBrick.h"

@interface BricksViewController : UIViewController{
    
    UIView *paddle;
    int score;
    int winScore;
    int hitBrick6;
    int hitBrick5;
    int hitBrick4;
    int lives;
    bool hitPaddle;
    int bubbleWidth;
    AVAudioPlayer *theAudio;
}

@property (strong) NSTimer *timer;
@property (assign) CGPoint position;

@property float x, y, vx, vy, bounce, gravity, initialx, initialy;
@property (weak, nonatomic) IBOutlet UIImageView *bubble;
@property (weak, nonatomic) IBOutlet UIImageView *brick1;
@property (weak, nonatomic) IBOutlet UIImageView *brick2;
@property (weak, nonatomic) IBOutlet UIImageView *brick3;
@property (weak, nonatomic) IBOutlet UIImageView *brick4;
@property (weak, nonatomic) IBOutlet UIImageView *brick5;
@property (weak, nonatomic) IBOutlet UIImageView *brick6;
@property (weak, nonatomic) IBOutlet UIButton *paddleButtonOutlet;

@property (weak, nonatomic) IBOutlet UIButton *soundOutlet;

@property (weak, nonatomic) IBOutlet UITextView *textBox;
@property (weak, nonatomic) IBOutlet UITextView *scoreBox;
@property (weak, nonatomic) IBOutlet UIButton *restartBox;
@property (weak, nonatomic) IBOutlet UITextView *lifeBox;
- (IBAction)restart:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)play:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *playOutlet;
@property (weak, nonatomic) IBOutlet UIButton *pauseOutlet;
- (IBAction)paddleButton:(id)sender;
- (IBAction)silence:(id)sender;
- (IBAction)sound:(id)sender;

@end
