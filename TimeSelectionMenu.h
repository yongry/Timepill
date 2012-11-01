//
//  TimeSelectionMenu.h
//  Timeline
//
//  Created by 04 developer on 12-10-31.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimeSelectionMenuDelegate;

@interface TimeSelectionMenu : UIView{
    NSObject <TimeSelectionMenuDelegate> *_delegate;
    NSMutableArray *_timeButtons;
}
@property (nonatomic, strong) NSMutableArray *timeButtons;
@property (nonatomic, strong) NSObject <TimeSelectionMenuDelegate> *delegate;

-(id)initWithFrame:(CGRect)frame timeButtonsTitles:(NSArray *)timeButtonsTitles;

-(void)test;

@end

@protocol TimeSelectionMenuDelegate <NSObject>

-(void) timeSelected;

@end
