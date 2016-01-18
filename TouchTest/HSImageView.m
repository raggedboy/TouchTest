//
//  HSImageView.m
//  TouchTest
//
//  Created by 浩杰 on 15/12/17.
//  Copyright © 2015年 Handsome Pan. All rights reserved.
//

#import "HSImageView.h"

@implementation HSImageView

- (instancetype) initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if(self){
        UIImage *img = [UIImage imageNamed:@"HandSomeImage.png"];
       [self setBackgroundColor:[UIColor colorWithPatternImage:img]];
    }
         return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"hahahahaha");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint current = [touch locationInView:self];
    CGPoint previous = [touch previousLocationInView:self];
    CGPoint offset = CGPointMake(current.x - previous.x, current.y - previous.y);
    self.center = CGPointMake(self.center.x + offset.x, self.center.y + offset.y);
    NSLog(@"touch act");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
