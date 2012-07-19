//
//  ViewController.m
//  FinalProject
//
//  Created by iD Student on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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

- (IBAction)selectOption:(id)sender {
    option = [sender tag];
    switch (option) {
        case 1:
            [self performSegueWithIdentifier: @"brick" sender: self];
            break;
        case 2:
            [self performSegueWithIdentifier: @"pong" sender: self];
            break;
        case 3:
            [self performSegueWithIdentifier: @"highscores" sender: self];
            break;
    }
}
@end
