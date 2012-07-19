//
//  ViewController.m
//  BrickBreaker
//
//  Created by iD Student on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BricksViewController.h"
#import "ControlBrick.h"

@interface BricksViewController ()

@end

@implementation BricksViewController
@synthesize playOutlet;
@synthesize pauseOutlet;
@synthesize bubble;
@synthesize brick1;
@synthesize brick2;
@synthesize brick3;
@synthesize brick4;
@synthesize brick5;
@synthesize brick6;
@synthesize paddleButtonOutlet;
@synthesize soundOutlet;
@synthesize textBox;
@synthesize scoreBox;
@synthesize restartBox;
@synthesize lifeBox;
@synthesize x, y, vx, vy, bounce, gravity, initialx, initialy;
@synthesize position, timer;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    initialx = (arc4random() % 300) + 20;
    initialy = (arc4random() % 240) + 150;
    x = initialx;
    y = initialy;
    vx = 6.0;
    vy = 5.0;
    bounce = -1.0;
    winScore = 10;
    
    hitBrick6 = 3;
    hitBrick5 = 2;
    hitBrick4 = 2;
    
    //gravity = 1.0;
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
    
    [self.view addSubview:paddle];
    [self.view addSubview:paddleButtonOutlet];
    
    self.lifeBox.text = [NSString stringWithFormat:@"Lives: %i", lives];
    
    restartBox.hidden = true;
    playOutlet.hidden = true;
    soundOutlet.hidden = true;
    hitPaddle = false;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bricksaudio" ofType:@"mp3"];
    theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    
    [theAudio play];
}

- (void)viewDidUnload
{
    [self setBubble:nil];
    [self setTextBox:nil];
    [self setScoreBox:nil];
    [self setLifeBox:nil];
    [self setBrick1:nil];
    [self setBrick2:nil];
    [self setBrick3:nil];
    [self setBrick4:nil];
    [self setBrick5:nil];
    [self setRestartBox:nil];
    [self setPlayOutlet:nil];
    [self setPauseOutlet:nil];
    [self setBrick6:nil];
    [self setPaddleButtonOutlet:nil];
    [self setSoundOutlet:nil];
    [super viewDidUnload];
    [theAudio stop];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
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
    self.scoreBox.text = [NSString stringWithFormat:@"Score :     %i", score];
    
    if(score == winScore){
        self.textBox.text = [NSString stringWithFormat:@"You won the game!!"];
        self.restartBox.hidden = false;
        self.bubble.alpha = 0;
        [timer invalidate];
    }
}
-(void)animate{
    bubble.center = CGPointMake(x, y);
	
	/*velocity*/
	x += vx;
	y += vy;
	
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
	if(y > 800)
	{
        x = initialx;
        y = initialy;
        
        if(hitPaddle){
            lives--;
            self.lifeBox.text = [NSString stringWithFormat:@"Lives: %i", lives];
            if(lives == 0){
                self.textBox.text = [NSString stringWithFormat:@"GAME OVER!!"];
                [timer invalidate];
                restartBox.hidden = false;
            }
        }
	}
	else if(y < 5)
	{
		y = 5;
		vy *= bounce;
	}
    
    
    if(CGRectIntersectsRect(bubble.frame, paddle.frame)){
        y = paddle.center.y - (paddle.frame.size.height + bubbleWidth)/2 - 1;
        vy *= bounce;
        hitPaddle = true;
    }
    
    //3 lives: 122, 56, 29
    //2 lives: 166, 77, 39--> 0.65, 0.30, 0.15
    //1 live: 216, 100, 51--> 0.85, 0.39, 0.2
    ControlBrick *bricks = [[ControlBrick alloc]init];
    if(CGRectIntersectsRect(bubble.frame, brick1.frame)){
        
        [bricks intersect:brick1 :x:y:vx:vy:bounce:bubble:bubbleWidth:1];
        x = [bricks x];
        y = [bricks y];
        vx = [bricks vx];
        vy = [bricks vy];
        [self setBrick1:nil];
        [self addScore];
    }
    if(CGRectIntersectsRect(bubble.frame, brick2.frame)){
        [bricks intersect:brick2 :x:y:vx:vy:bounce:bubble:bubbleWidth:1];
        x = [bricks x];
        y = [bricks y];
        vx = [bricks vx];
        vy = [bricks vy];
        [self setBrick2:nil];
        [self addScore];
    }
    if(CGRectIntersectsRect(bubble.frame, brick3.frame)){
        [bricks intersect:brick3 :x:y:vx:vy:bounce:bubble:bubbleWidth:1];
        x = [bricks x];
        y = [bricks y];
        vx = [bricks vx];
        vy = [bricks vy];
        [self setBrick3:nil];
        [self addScore];
    }
    if(CGRectIntersectsRect(bubble.frame, brick4.frame)){
        [bricks intersect:brick4 :x:y:vx:vy:bounce:bubble:bubbleWidth:hitBrick4];
        x = [bricks x];
        y = [bricks y];
        vx = [bricks vx];
        vy = [bricks vy];
        hitBrick4 = [bricks health];
        if(hitBrick4==0){
            [self setBrick4:nil];
        }
        [self addScore];
    }
    if(CGRectIntersectsRect(bubble.frame, brick5.frame)){
        [bricks intersect:brick5 :x:y:vx:vy:bounce:bubble:bubbleWidth:hitBrick5];
        x = [bricks x];
        y = [bricks y];
        vx = [bricks vx];
        vy = [bricks vy];
        hitBrick5 = [bricks health];
        if(hitBrick5==0){
            [self setBrick5:nil];
        }
        [self addScore];
    }
    if(CGRectIntersectsRect(bubble.frame, brick6.frame)){
        [bricks intersect:brick6:x:y:vx:vy:bounce:bubble:bubbleWidth:hitBrick6];
        x = [bricks x];
        y = [bricks y];
        vx = [bricks vx];
        vy = [bricks vy];
        hitBrick6 = [bricks health];
        if(hitBrick6==0){
            [self setBrick6:nil];
        }
        [self addScore];
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

