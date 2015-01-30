//
//  BounceView.h
//  Bounce
//
//  Created by Dmytro on 1/24/15.
//  Copyright (c) 2015 Dmytro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface BounceView : UIView

@property (nonatomic, assign) CGFloat sideToCenterDelta;
@property (nonatomic, strong) UIColor *color;

- (id)initWithFrame:(CGRect)frame;

@end
