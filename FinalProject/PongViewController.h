//
//  PongViewController.h
//  FinalProject
//
//  Created by iD Student on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PongViewController : UIViewController{
    UIView *paddle;
    UIView *paddle2;
    //int winScore;
    int score;
    int lives;
    int bubbleWidth;
    bool hitPaddle;
    AVAudioPlayer *theAudio;
    BOOL myturn;
    float difference;
    int i;
}


@property float x, y, vx, vy, bounce, gravity, initialx, initialy;
@property float px, py, pvx;

@property (strong) NSTimer *timer;
@property (assign) CGPoint position;

@property (nonatomic, retain) NSMutableArray *highscores;
@property (weak, nonatomic) IBOutlet UIImageView *bubble;
@property (weak, nonatomic) IBOutlet UIButton *paddleButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *restartBox;
@property (weak, nonatomic) IBOutlet UITextView *lifeBox;
@property (weak, nonatomic) IBOutlet UITextView *scoreBox;
@property (weak, nonatomic) IBOutlet UITextView *textBox;
@property (weak, nonatomic) IBOutlet UIButton *playOutlet;
@property (weak, nonatomic) IBOutlet UIButton *pauseOutlet;
@property (weak, nonatomic) IBOutlet UIButton *soundOutlet;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIButton *highscoreButton;


- (IBAction)saveHighscore:(id)sender;
- (IBAction)paddleButton:(id)sender;
- (IBAction)play:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)sound:(id)sender;
- (IBAction)silence:(id)sender;
- (IBAction)restart:(id)sender;

@end
