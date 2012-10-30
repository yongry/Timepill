//
//  HomePageViewController.m
//  Timeline
//
//  Created by 04 developer on 12-10-24.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import "HomePageViewController.h"

@interface HomePageViewController()
@end

@implementation HomePageViewController
@synthesize tableview;
@synthesize bar = _bar;

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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.bar touchesBegan:touches withEvent:event];
 }
 
 -(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
     [self.bar touchesMoved:touches withEvent:event];
 }

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.bar touchesEnded:touches withEvent:event];
}
 

@end
