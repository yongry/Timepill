//
//  TimeSelectionMenu.m
//  Timeline
//
//  Created by 04 developer on 12-10-31.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import "TimeSelectionMenu.h"

@implementation TimeSelectionMenu
@synthesize timeButtons = _timeButtons;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame timeButtonsTitles:(NSArray *)timeButtonsTitles
{
    self = [super init];
    if (self) {
        [self setFrame:frame];
        self.backgroundColor = [UIColor blackColor];
        CGRect buttonFrame = CGRectMake(10, 10, self.frame.size.width - 20, 30);
        _timeButtons = [[NSMutableArray alloc] init];
        UIButton *timeButton;
        for(int i = 0; i < [timeButtonsTitles count]; i++){
            timeButton = [[UIButton alloc] initWithFrame:buttonFrame];
            [timeButton setBackgroundColor:[UIColor greenColor]];
            [timeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [timeButton setTitle:[timeButtonsTitles objectAtIndex:i] forState:UIControlStateNormal];
            [timeButton addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
            buttonFrame.origin.y += 50;
            [self addSubview:timeButton];
            [_timeButtons addObject:timeButton];
        }
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

//why can't we do an action?????????????????
-(void)test{
    NSLog(@"it's a button");
}
@end

