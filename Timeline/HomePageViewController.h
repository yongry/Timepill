//
//  HomePageViewController.h
//  Timeline
//
//  Created by 04 developer on 12-10-24.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpandingButtonBar.h"
#import "TimeSelectionMenu.h"

@interface HomePageViewController : UIViewController
<ExpandingButtonBarDelegate, TimeSelectionMenuDelegate, UITableViewDelegate, UITableViewDataSource>
{
    ExpandingButtonBar *_bar;
    TimeSelectionMenu *_timeMenu;
}

@property (strong, nonatomic) ExpandingButtonBar *bar;
@property (strong, nonatomic) TimeSelectionMenu *timeMenu;
@property (strong, nonatomic) NSArray *timeSelection;
@property (strong, nonatomic) IBOutlet UITableView *diaryTableview;
@property (strong, nonatomic) NSArray *diaries;

- (IBAction)selectTimeAnimation:(id)sender;


-(void) onCreateDiary;
-(void) onShareDiary;
-(void) onLoadDataFromMicroBlog;
@end
