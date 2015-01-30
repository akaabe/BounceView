//
//  BounceView.m
//  Bounce
//
//  Created by Dmytro on 1/24/15.
//  Copyright (c) 2015 Dmytro. All rights reserved.
//

#import "BounceView.h"

@implementation BounceView

@synthesize sideToCenterDelta, color;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self setBackgroundColor:[UIColor clearColor]];
        self.color = [UIColor redColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    UIColor *colorll = [UIColor redColor];
    CGFloat yOffset = 20.0f;
    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.0f, yOffset)];
    [path addQuadCurveToPoint:CGPointMake(width, yOffset) controlPoint:CGPointMake(width / 2.0f, yOffset + self.sideToCenterDelta)];
    [path addLineToPoint:CGPointMake(width, height)];
    [path addLineToPoint:CGPointMake(0.0f, height)];
    [path closePath];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path.CGPath);
    [colorll set];
    CGContextFillPath(context);
}

@end
