//
//  ControlBrick.m
//  BrickBreaker
//
//  Created by iD Student on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ControlBrick.h"
#import "BricksViewController.h"




@implementation ControlBrick

-(void)intersect:(UIImageView *) brick:(float) x:(float) y:(float) vx:(float) vy:(float) bounce:(UIImageView *) bubble:(int) bubbleWidth:(int) health{
    ihealth = health;
    ihealth--;      
    if(bubble.center.x >= (brick.center.x + brick.frame.size.width/2)) {
        ix = brick.center.x + (brick.frame.size.width + bubbleWidth)/2 + 1;
        ivx = vx*bounce;
        iy = y;
        ivy = vy;
    }else if(bubble.center.x <= (brick.center.x - brick.frame.size.width/2)){
        ix = brick.center.x - (brick.frame.size.width + bubbleWidth)/2 - 1;
        ivx = vx*bounce;
        iy = y;
        ivy = vy;
    }else if(bubble.center.y >= (brick.center.y + brick.frame.size.height/2)) {
        iy = brick.center.y + (brick.frame.size.height + bubbleWidth)/2 + 1;
        ivy = vy*bounce;
        ix = x;
        ivx = vx;
    }else if(bubble.center.y <= (brick.center.y - brick.frame.size.height/2)){
        iy = brick.center.y - (brick.frame.size.height + bubbleWidth)/2 - 1;
        ivy = vy*bounce;
        ix = x;
        ivx = vx;
    }
    switch (ihealth) {
        case 2:
            brick.backgroundColor = [UIColor colorWithRed:0.65 green:0.30 blue:0.15 alpha:1];
            break;
        case 1:
            brick.backgroundColor = [UIColor colorWithRed:0.85 green:0.39 blue:0.2 alpha:1];
            break;
        case 0:
            brick.alpha = 0;
            break;
    }
}
-(float)x{
    return ix;
}
-(float)y{
    return iy;
}
-(float)vx{
    return ivx;
}
-(float)vy{
    return ivy;
}
-(int)health{
    return ihealth;
}

@end
