//
//  HomePageViewController.h
//  Timeline
//
//  Created by 04 developer on 12-10-24.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpandingButtonBar.h"

@interface HomePageViewController : UIViewController
<ExpandingButtonBarDelegate>
{
    ExpandingButtonBar *_bar;
}

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) ExpandingButtonBar *bar;

-(void) onCreateDiary;
-(void) onShareDiary;
-(void) onLoadDataFromMicroBlog;
@end
