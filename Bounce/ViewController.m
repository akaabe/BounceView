//
//  ViewController.m
//  Bounce
//
//  Created by Dmytro on 1/24/15.
//  Copyright (c) 2015 Dmytro. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) CGFloat animationDuration;
@property (nonatomic, assign) CGPoint startPositionOfSide;
@property (nonatomic, assign) CGPoint startPositionOfCenter;
@property (nonatomic, assign) CGPoint endPositionOfSide;
@property (nonatomic, assign) CGPoint endPositionOfCenter;
@property (nonatomic, strong) CADisplayLink *caDisplayLink;
@property (nonatomic, assign) NSUInteger animationCount;
@property (nonatomic, strong) UIView *sideHelperView;
@property (nonatomic, strong) UIView *centerHelperView;
@property (nonatomic, strong) BounceView *bounceView;

#define kAnimationDuration 0.5

@end

@implementation ViewController

@synthesize animationDuration, animationCount, sideHelperView, centerHelperView, startPositionOfSide, startPositionOfCenter,endPositionOfSide, endPositionOfCenter;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.caDisplayLink = nil;
    self.animationCount = 0;
    self.animationDuration = kAnimationDuration;
    [self toggleButtonInit];
    [self sideViewInit];
    [self centerViewInit];
    [self bounceViewInit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)toggleButton:(UIButton*)sender
{
    CGPoint newPositionSide;
    CGPoint newPositionCenter;
    if (self.sideHelperView.frame.origin.y == self.startPositionOfSide.y)
    {
        newPositionSide = self.endPositionOfSide;
    }
    else
    {
        newPositionSide = self.startPositionOfSide;
    }
    
    if (self.centerHelperView.frame.origin.y == self.startPositionOfCenter.y)
    {
        newPositionCenter = self.endPositionOfCenter;
    }
    else
    {
        newPositionCenter = self.startPositionOfCenter;
    }
        
    [self animationWillStart];
    [UIView animateWithDuration:animationDuration delay:0.0f usingSpringWithDamping:0.75f initialSpringVelocity:0.8f options:UIViewAnimationOptionBeginFromCurrentState animations:^
    {
        CGRect frame = self.sideHelperView.frame;
        frame.origin = newPositionSide;
        self.sideHelperView.frame = frame;
    }
    completion:^(BOOL completed)
    {
        [self animationDidComplete];
    }];
    
    [self animationWillStart];
    [UIView animateWithDuration:animationDuration delay:0.0f usingSpringWithDamping:0.9f initialSpringVelocity:0.9f
         options:UIViewAnimationOptionBeginFromCurrentState animations:^
    {
        CGRect frame = self.centerHelperView.frame;
        frame.origin = newPositionCenter;
        self.centerHelperView.frame = frame;
    }
    completion:^(BOOL completed)
    {
        [self animationDidComplete];
    }];
}

- (void)animationDidComplete
{
    --self.animationCount;
    if (self.animationCount == 0)
    {
        [self.caDisplayLink invalidate];
        self.caDisplayLink = nil;
    }
}

- (void)animationWillStart
{
    if (self.caDisplayLink == nil)
    {
        self.caDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
        [self.caDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
    ++self.animationCount;
}

- (void)tick:(CADisplayLink*)sender
{
    CALayer *sideLayer = [self.sideHelperView.layer presentationLayer];
    CALayer *centerLayer = [self.centerHelperView.layer presentationLayer];
    self.bounceView.sideToCenterDelta = CGRectGetMinY(sideLayer.frame) - CGRectGetMinY(centerLayer.frame);
    CGRect sideFrame = sideLayer.frame;
    sideFrame.size = self.bounceView.frame.size;
    self.bounceView.frame = sideFrame;
    [self.bounceView setNeedsDisplay];
}

- (void)toggleButtonInit
{
    UIButton *toggleButton = [[UIButton alloc] initWithFrame:(CGRect){self.view.frame.size.width / 2.0f - 50.0f, 100.0f, 100.0f, 20.0f}];
    toggleButton.backgroundColor = [UIColor redColor];
    [toggleButton addTarget:self action:@selector(toggleButton:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:toggleButton];
}

- (void)sideViewInit
{
    self.startPositionOfSide = CGPointMake(0.0f, self.view.frame.size.height - 10.0f);
    self.endPositionOfSide = CGPointMake(0.0f, self.view.frame.size.height - self.view.frame.size.height / 2.0f);
    self.sideHelperView = [[UIView alloc] initWithFrame:(CGRect){self.startPositionOfSide.x, self.startPositionOfSide.y, 10.0f, 10.0f}];
    self.sideHelperView.backgroundColor = [UIColor greenColor];
    self.sideHelperView.hidden = YES;
    [self.view addSubview:self.sideHelperView];
}

- (void)centerViewInit
{
    self.startPositionOfCenter = CGPointMake(self.view.frame.size.width / 2.0f - 5.0f, self.view.frame.size.height - 10.0f);
    self.endPositionOfCenter = CGPointMake(self.view.frame.size.width / 2.0f - 5.0f, self.view.frame.size.height - self.view.frame.size.height / 2.0f);
    self.centerHelperView = [[UIView alloc] initWithFrame:(CGRect){self.startPositionOfCenter.x, self.startPositionOfCenter.y, 10.0f, 10.0f}];
    self.centerHelperView.backgroundColor = [UIColor blueColor];
    self.centerHelperView.hidden = YES;
    [self.view addSubview:self.centerHelperView];
}

- (void)bounceViewInit
{
    self.bounceView = [[BounceView alloc] initWithFrame:(CGRect){0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height}];
    [self.view addSubview:self.bounceView];
}

@end
