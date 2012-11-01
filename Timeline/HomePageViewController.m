//
//  HomePageViewController.m
//  Timeline
//
//  Created by 04 developer on 12-10-24.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import "HomePageViewController.h"

@interface HomePageViewController()
@property (nonatomic) BOOL timeSelectionTableShow;
@end

@implementation HomePageViewController
@synthesize timeSelection;
@synthesize bar = _bar;
@synthesize timeMenu = _timeMenu;
@synthesize diaryTableview;
@synthesize timeSelectionTableShow;
@synthesize diaries;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /* ---------------------------------------------------------
     * Create images that are used for the main button
     * -------------------------------------------------------*/
    UIImage *image = [UIImage imageNamed:@"red_plus_up.png"];
    UIImage *selectedImage = [UIImage imageNamed:@"red_plus_down.png"];
    UIImage *toggledImage = [UIImage imageNamed:@"red_x_up.png"];
    UIImage *toggledSelectedImage = [UIImage imageNamed:@"red_x_down.png"];
    
    /* ---------------------------------------------------------
     * Create the center for the main button and origin of animations
     * -------------------------------------------------------*/
    CGPoint center = CGPointMake(30.0f, 370.0f);
    
    /* ---------------------------------------------------------
     * Setup buttons
     * Note: I am setting the frame to the size of my images
     * -------------------------------------------------------*/
    CGRect buttonFrame = CGRectMake(0, 0, 32.0f, 32.0f);
    UIButton *b1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [b1 setFrame:buttonFrame];
    [b1 setImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
    [b1 addTarget:self action:@selector(onCreateDiary) forControlEvents:UIControlEventTouchUpInside];
    UIButton *b2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [b2 setImage:[UIImage imageNamed:@"lightbulb.png"] forState:UIControlStateNormal];
    [b2 setFrame:buttonFrame];
    [b2 addTarget:self action:@selector(onShareDiary) forControlEvents:UIControlEventTouchUpInside];
    UIButton *b3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [b3 setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    [b3 setFrame:buttonFrame];
    [b3 addTarget:self action:@selector(onLoadDataFromMicroBlog) forControlEvents:UIControlEventTouchUpInside];
    NSArray *buttons = [NSArray arrayWithObjects:b1, b2, b3, nil];
    
    /* ---------------------------------------------------------
     * Init method, passing everything the bar needs to work
     * -------------------------------------------------------*/
    ExpandingButtonBar *bar = [[ExpandingButtonBar alloc] initWithImage:image selectedImage:selectedImage toggledImage:toggledImage toggledSelectedImage:toggledSelectedImage buttons:buttons center:center];
    [bar setHorizontal:YES];
    [bar setExplode:YES];
    
    /* ---------------------------------------------------------
     * Settings
     * -------------------------------------------------------*/
    [bar setDelegate:self];
    [bar setSpin:YES];
    
    /* ---------------------------------------------------------
     * Set our property and add it to the view
     * -------------------------------------------------------*/
    [self setBar:bar];
    [[self view] addSubview:[self bar]];
    
    [[self navigationController] setToolbarHidden:YES];
    [[self navigationController] setNavigationBarHidden:NO];
    
    /* ---------------------------------------------------------
     * Setting of timeTableView
     * -------------------------------------------------------*/
    self.timeSelection = [[NSArray alloc] initWithObjects:@"本年", @"本月", @"本日", @"自定义", nil];
    
    CGRect timeMenuViewFrame = CGRectMake(self.view.bounds.origin.x - 80, self.view.bounds.origin.y, 80, self.view.frame.size.height);
    self.timeMenu = [[TimeSelectionMenu alloc] initWithFrame:timeMenuViewFrame timeButtonsTitles:self.timeSelection];
    [self.view addSubview:self.timeMenu];
    self.timeSelectionTableShow = NO;
    
    [self.timeMenu setDelegate:self];
    
    /* ---------------------------------------------------------
     * Setting of diaryTableView
     * -------------------------------------------------------*/
    self.diaries = [[NSArray alloc] initWithObjects:@"1",@"2", nil];
}

- (void)viewDidUnload
{
    [self setTimeMenu:nil];
    [self setDiaryTableview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (IBAction)selectTimeAnimation:(id)sender{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0.05];
    [UIView setAnimationDuration:0.05];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    /*newly changed*/
    if(self.timeSelectionTableShow){
        CGRect mainViewFrame = CGRectMake(self.view.bounds.origin.x , self.view.bounds.origin.y, 
                                          self.view.bounds.size.width, self.view.bounds.size.height);
        self.timeSelectionTableShow = NO;
        
        self.view.frame = mainViewFrame;
    }
    else{
        self.timeSelectionTableShow = YES;
        CGRect mainViewFrame = CGRectMake(self.view.bounds.origin.x + self.timeMenu.bounds.size.width, self.view.bounds.origin.y, 
                                          self.view.bounds.size.width, self.view.bounds.size.height);
        self.view.frame = mainViewFrame;
        
    }
    
    [UIView commitAnimations];
}

- (void) onCreateDiary
{
    [self performSegueWithIdentifier:@"createDiary" sender:self]; 
}

- (void) onShareDiary
{
    [self performSegueWithIdentifier:@"longWeibo" sender:self];
}

- (void) onLoadDataFromMicroBlog
{
    [[self bar] hideButtonsAnimated:YES];
}

/* ---------------------------------------------------------
 * Delegate methods of ExpandingButtonBarDelegate
 * -------------------------------------------------------*/
- (void) expandingBarDidAppear:(ExpandingButtonBar *)bar
{
    NSLog(@"did appear");
}

- (void) expandingBarWillAppear:(ExpandingButtonBar *)bar
{
    NSLog(@"will appear");
}

- (void) expandingBarDidDisappear:(ExpandingButtonBar *)bar
{
    NSLog(@"did disappear");
}

- (void) expandingBarWillDisappear:(ExpandingButtonBar *)bar
{
    NSLog(@"will disappear");
}

/* ---------------------------------------------------------
 * Delegate methods of TimeSelectionDelegate
 * -------------------------------------------------------*/

-(void)timeSelected{
    NSLog(@"hello");
}

#pragma mark -
#pragma mark table view delegate method
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.diaries count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *diaryTableviewIdentifier = @"diaryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:diaryTableviewIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:diaryTableviewIdentifier];
    }
    cell.textLabel.text = [self.diaries objectAtIndex:indexPath.row];
    return cell;
}

@end
