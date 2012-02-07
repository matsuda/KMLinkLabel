//
//  KMLinkLabel.m
//  KMLinkLabel
//
//  Created by matsuda on 12/02/07.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "KMLinkLabel.h"

NSString * const KMLinkLabelClickedNotification = @"KMLinkLabelClickedNotification";

@implementation KMLinkLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGSize size = [self.text sizeWithFont:self.font forWidth:CGRectGetWidth(self.bounds) lineBreakMode:self.lineBreakMode];

    float textLeft;
    float textRight;
    switch (self.textAlignment) {
        case UITextAlignmentLeft: {
            textLeft = CGRectGetMinX(self.bounds);
            textRight = textRight + size.width;
            break;
        }
        case UITextAlignmentRight: {
            textRight = CGRectGetMaxX(self.bounds);
            textLeft = textRight - size.width;
            break;
        }
        default: {
            float c = CGRectGetWidth(self.bounds) / 2.0;
            textLeft = c - size.width / 2.0;
            textRight = c + size.width / 2.0;
            break;
        }
    }

    CGContextRef context = UIGraphicsGetCurrentContext();
    const CGFloat* colors = CGColorGetComponents(self.textColor.CGColor);
    CGContextSetRGBStrokeColor(context, colors[0], colors[1], colors[2], 1.0); // RGBA
    CGContextSetLineWidth(context, 1.0f);
    CGContextMoveToPoint(context, textLeft, CGRectGetMaxY(self.bounds) - 1);
    CGContextAddLineToPoint(context, textRight, CGRectGetMaxY(self.bounds) - 1);
    CGContextStrokePath(context);

    [super drawRect:rect];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSNotification *notification = [NSNotification notificationWithName:KMLinkLabelClickedNotification object:self];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

@end
