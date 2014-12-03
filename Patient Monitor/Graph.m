//
//  Graph.m
//  Patient Monitor
//
//  Created by Ron Lasser on 9/13/14.
//  Modified by Ryan Dougherty 11/22/14.
//  Copyright (c) 2014 org.rl. All rights reserved.
//

#import "Graph.h"


@interface Graph()

@property (nonatomic, assign) CGFloat scaleX;
@property (nonatomic, assign) CGFloat scaleY;

@property (nonatomic, assign) NSInteger plotStep;


@end

@implementation Graph

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self myInitialization];
    }
    return self;
}

- (NSMutableArray *) graphXData
{
    if (!_graphXData){
        _graphXData = [[NSMutableArray alloc] init];
    }
    
    return _graphXData;
}

- (NSMutableArray *) graphYData
{
    if (!_graphYData){
        _graphYData = [[NSMutableArray alloc] init];
    }
    
    return _graphYData;
}


- (void)myInitialization
{
    self.backgroundColor = [UIColor blackColor];
    self.scaleX = self.bounds.size.width/50.0;
    self.scaleY = self.bounds.size.height/50.0;
    self.plotStep = 0;
    
    [self setGraphColor:[UIColor blackColor] WithShapeColor:[UIColor whiteColor]];
}
- (void)setGraphColor:(UIColor*)myColor WithShapeColor:(UIColor*)shapeColor{
    self.backgroundColor = myColor;
    [shapeColor setFill];
    self.dataColor = shapeColor;
}

- (void)resize{
    self.scaleX = self.bounds.size.width/50.0;
    self.scaleY = self.bounds.size.height/50.0;
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self myInitialization];
    }
    
    return self;
}

- (void) drawAxisX
{
    CGPoint start = CGPointMake(0, -0.5);
    CGPoint end = CGPointMake(43, -0.5);
    
     UIBezierPath *axisX = [[UIBezierPath alloc] init];
    [[UIColor whiteColor] setStroke];
    axisX.lineWidth = 3.0;
    [axisX moveToPoint: [self scalePoint: start]];
    [axisX addLineToPoint:[self scalePoint: end]];
    [axisX stroke];
    
}

- (void) drawAxisY
{
   
    CGPoint start = CGPointMake(0, -14);
    CGPoint end = CGPointMake(0, 34);
    
    UIBezierPath *axisY = [[UIBezierPath alloc] init];
    [[UIColor whiteColor] setStroke];
    axisY.lineWidth = 3.0;
    [axisY moveToPoint: [self scalePoint: start]];
    [axisY addLineToPoint:[self scalePoint: end]];
    [axisY stroke];
    
}

// TODO: Get rid of giant cross back line
- (void) AnimatedPlacePoint
{
    NSArray *ax = [self.graphXData copy];
    NSArray *ay = [self.graphYData copy];

    
    NSInteger numberOfPoints = 30;

    [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(goTime:) userInfo:nil repeats:YES];
    
    [self.dataColor setFill];
    [self.dataColor setStroke];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path setLineWidth:3.0f];
    [path moveToPoint:[self scalePoint:CGPointMake([ax[(self.plotStep)%35] floatValue], [ay[(self.plotStep)%35] floatValue])]];
    
    int pointsBeforeEnd = numberOfPoints-self.plotStep%35;
    
    for (NSInteger i = 0; i < numberOfPoints; ++i) {
        CGPoint pa = CGPointMake([ax[(self.plotStep+i)%35] floatValue], [ay[(self.plotStep+i)%35] floatValue]);
        CGPoint ra = [self scalePoint:pa];
        [path addLineToPoint:ra];
    }
    [path stroke];
}

- (void) goTime: (NSTimer *) timer
{
    //NSLog(@"%s", __FUNCTION__);

    self.plotStep = (self.plotStep + 1)%35;
    //NSLog(@"Timer");
    [timer invalidate];
    [self setNeedsDisplay];
}

- (CGPoint) scalePoint: (CGPoint) data
{
    CGFloat offsetX = 15;
    CGFloat offsetY = 15;
    CGFloat dataX = data.x;
    CGFloat dataY = data.y;
    CGFloat yheight = self.bounds.size.height;
    CGFloat scaleX = dataX*self.scaleX;
    CGFloat scaleY = dataY*self.scaleY;
    CGFloat scaleOffY = offsetY*self.scaleY;
    CGFloat plotY = yheight - scaleY - scaleOffY;
    CGFloat plotX = scaleX + offsetX;
    
    return CGPointMake(plotX, plotY);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self drawAxisX];
    [self drawAxisY];
    [self AnimatedPlacePoint];
}

-(void) printArray
{
    NSLog(@"Printing");
    for (NSInteger i = 0; i < [self.graphXData count]; ++i) {
        NSLog(@"%3.2f", [[self.graphXData objectAtIndex:i] floatValue]);
    }
}

@end
