//
//  ControlBrick.h
//  BrickBreaker
//
//  Created by iD Student on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BricksViewController.h"

@interface ControlBrick : NSObject{
    float ix, iy, ivx, ivy;
    int ihealth;
}

-(void)intersect:(UIImageView *) brick:(float) x:(float) y:(float) vx:(float) vy:(float) bounce:(UIImageView *) bubble:(int) bubbleWidth:(int) health;



-(float)x;
-(float)y;
-(float)vx;
-(float)vy;
-(int)health;

@end
