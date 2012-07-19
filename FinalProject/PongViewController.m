//
//  PongViewController.m
//  FinalProject
//
//  Created by iD Student on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PongViewController.h"

@interface PongViewController ()

@end

@implementation PongViewController
@synthesize nameField;
@synthesize highscoreButton;
@synthesize bubble;
@synthesize paddleButtonOutlet;
@synthesize restartBox;
@synthesize lifeBox;
@synthesize scoreBox;
@synthesize textBox;
@synthesize playOutlet;
@synthesize pauseOutlet;
@synthesize soundOutlet;
@synthesize x, y, vx, vy, bounce, gravity, initialx, initialy;
@synthesize px, py, pvx;
@synthesize position;
@synthesize timer;
@synthesize highscores;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    initialx = (arc4random() % 300) + 20;
    initialy = (arc4random() % 240) + 150;
    x = initialx;
    y = initialy;
    vx = 5.0;
    vy = 5.0;
    bounce = -1.0;
    //winScore = 10;
    
    pvx = 0.65*vx;
    py = 80;
    px = 160;
    
    
    position = CGPointMake(initialx, initialy);
    
    score = 0;
    lives = 3;
    bubbleWidth = 10;
    
    bubble.frame = CGRectMake(initialx,initialy,bubbleWidth,bubbleWidth);
    [self.view addSubview:bubble];
    
    float paddleWidth = 25.0;
    float paddleHeight = paddleWidth*M_PI;
    
    CGRect paddleRect = CGRectMake(110, 422, paddleHeight, paddleWidth);
    paddle = [[UIView alloc] initWithFrame:paddleRect];
    paddle.backgroundColor = [UIColor greenColor];
    
    
    CGRect paddleRect2 = CGRectMake(160, 80, paddleHeight, paddleWidth);
    paddle2 = [[UIView alloc] initWithFrame:paddleRect2];
    paddle2.backgroundColor = [UIColor blueColor];
    paddle2.userInteractionEnabled = false;
    
    [self.view addSubview:paddle];
    [self.view addSubview:paddle2];
    [self.view addSubview:paddleButtonOutlet];
    
    restartBox.hidden = true;
    playOutlet.hidden = true;
    soundOutlet.hidden = true;
    hitPaddle = false;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"pongaudio" ofType:@"mp3"];
    theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    
    [theAudio play];

}

- (void)viewDidUnload
{
    [self setBubble:nil];
    [self setPaddleButtonOutlet:nil];
    [self setRestartBox:nil];
    [self setLifeBox:nil];
    [self setScoreBox:nil];
    [self setTextBox:nil];
    [self setPlayOutlet:nil];
    [self setPauseOutlet:nil];
    [self setSoundOutlet:nil];
    [self setNameField:nil];
    [self setHighscoreButton:nil];
    [super viewDidUnload];
    highscores = nil;
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    if(touch.view != self.view){
        [touch view].center = currentPoint;
    }
    if(paddle.center.y < 433 || paddle.center.y > 435){
        float xHold = paddle.center.x;
        paddle.center = CGPointMake(xHold, 434);
    }
}
-(void)addScore{
    score++;
    self.scoreBox.text = [NSString stringWithFormat:@"Score :   %i", score];
    
    /*if(score == winScore){
        self.textBox.text = [NSString stringWithFormat:@"You won the game!!"];
        self.restartBox.hidden = false;
        self.bubble.alpha = 0;
        [timer invalidate];
    }*/
}
-(void)animate{
    
    bubble.center = CGPointMake(x, y);
    paddle2.center = CGPointMake(px, py);
	
	/*velocity*/
	x += vx;
	y += vy;
	
    if(pvx != 0.65*abs(vx)){
        pvx = 0.65*abs(vx);
    }
    
    if(myturn){
        if(bubble.center.x > paddle2.center.x+pvx/2){
            px += pvx;
        }else if(bubble.center.x < paddle2.center.x-pvx/2){
            px -= pvx;
        }
    }else {
        if(160-pvx/2 > paddle2.center.x){
            px += pvx;
        }else if(paddle2.center.x > 160+pvx/2){
            px -= pvx;
        }
    }
	/*gravity*/ 
	//vy += gravity;
	
	/*bounce*/
    
	if(x > (320-bubbleWidth/2))
	{
		x = 320-bubbleWidth/2;
		vx *= bounce;
	}
	else if(x < bubbleWidth/2)
	{
		x = bubbleWidth/2;
		vx *= bounce;
	}
	if(y > 500)
	{
        x = initialx;
        y = initialy;
        
        if(hitPaddle){
            lives--;
            self.lifeBox.text = [NSString stringWithFormat:@"Lives: %i", lives];
            vx *= 0.5;
            vy *= 0.5;
            if(lives == 0){
                self.textBox.text = [NSString stringWithFormat:@"GAME OVER!!"];
                highscoreButton.hidden = false;
                [timer invalidate];
                restartBox.hidden = false;
                paddle2.hidden = true;
            }
        }
	}
	else if(y < 55)
	{
        x = (arc4random() % 310) + 5;
        y = (arc4random() % 160) + 160;
        vy *=1+2/vx;
        vx +=2;
        pvx +=2;
        
		[self addScore];
	}
    
    
    if(CGRectIntersectsRect(bubble.frame, paddle.frame)){
        y = paddle.center.y - (paddle.frame.size.height + bubbleWidth)/2 - 1;
        vy *= bounce;
        hitPaddle = true;
        myturn = true;
        difference =  abs(paddle.center.x-bubble.center.x);
        vy *= 1.2;
        //if((1.2-(difference/(paddle.frame.size.width/2)))<=1){
        //    vy = (1.2-(difference/(paddle.frame.size.width/2)))*vx;
        //}else {
        //    vx = vy;
        //}
        vx = (1+((difference/(paddle.frame.size.width/2))))*vy;
        vx = abs(vx);
        if(paddle.center.x>bubble.center.x){
            vx *= -1;
        }
        //vx *= difference/paddle.frame.size.width;
    }
    if(CGRectIntersectsRect(bubble.frame, paddle2.frame)){
        y = paddle2.center.y + (paddle2.frame.size.height + bubbleWidth)/2 + 1;
        vy *= bounce;
        myturn = false;
    }
    
 
}

- (IBAction)restart:(id)sender {
    [self performSegueWithIdentifier: @"restart" sender: self];
}

- (IBAction)pause:(id)sender {
    [timer invalidate];
    playOutlet.hidden = false;
    pauseOutlet.hidden = true;
    restartBox.hidden = false;
    self.textBox.text = [NSString stringWithFormat:@"PAUSED"];
    [theAudio pause];
}

- (IBAction)play:(id)sender {
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(animate) userInfo:nil repeats:YES];
    playOutlet.hidden = true;
    pauseOutlet.hidden = false;
    restartBox.hidden = true;
    self.textBox.text = [NSString stringWithFormat:@""];
    [theAudio play];
}
- (IBAction)saveHighscore:(id)sender {
    if(!restartBox.hidden){
        restartBox.hidden = true;
        self.textBox.text = [NSString stringWithFormat:@"YOUR SCORE:  %i", score];
        nameField.hidden = false;
    }else {
        /*NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:[NSString stringWithFormat:@"%@:     %i", nameField.text, score] forKey:@"pong"];
        [defaults synchronize];
        [nameField resignFirstResponder];*/
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Highscores" ofType:@"plist"];
        self.highscores = [[NSMutableArray arrayWithContentsOfFile:plistPath] copy];
        for (i = 0; i==9; i++) {
            if([[[self.highscores objectAtIndex:i] valueForKey:@"highscore"] intValue]<score){
                NSError *error;
                [[NSFileManager defaultManager] removeItemAtPath:[[self.highscores objectAtIndex:9] error:error];
            }
        }
    }
}

- (IBAction)paddleButton:(id)sender {
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(animate) userInfo:nil repeats:YES];
    
    paddleButtonOutlet.hidden = true;
}
- (IBAction)silence:(id)sender {
    [theAudio stop];
    soundOutlet.hidden = false;
}

- (IBAction)sound:(id)sender {
    [theAudio play];
    soundOutlet.hidden = true;
}
@end
