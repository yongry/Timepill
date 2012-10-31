//
//  DataManager.m
//  sinaweibo_ios_sdk_demo
//
//  Created by 01 developer on 12-10-28.
//  Copyright (c) 2012年 SINA. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager
@synthesize sinaWeiboData,renrenData;

static DataManager *sharedDataManager = nil;

-(id)init{
    if([super init])
    {
        sinaWeiboData=[[SinaWeiboData alloc] init];
        renrenData=[[RenRenData alloc] init];
        //设置监听的通知
        //监听新浪微博的数据
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WeiboshowOutput:) name:@"weibo_userInfo" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WeiboshowOutput:) name:@"weibo_user_statuses" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WeiboshowOutput:) name:@"weibo_user_lateststatuses" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WeiboshowOutput:) name:@"weibo_friends_statuses" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WeiboshowOutput:) name:@"weibo_friends_lateststatuses" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WeiboshowOutput:) name:@"weibo_friends" object:nil];
        //监听人人的数据
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RenRenshowOutput:) name:@"renren_user_info" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RenRenshowOutput:) name:@"renren_friends" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RenRenshowOutput:) name:@"renren_status" object:nil];
    }
    return self;
}
//sington
+ (DataManager *)sharedDataManager {
    if (!sharedDataManager) {
        sharedDataManager = [[DataManager alloc] init];
    }
    return sharedDataManager;
}
//新浪微博数据的处理
-(void) WeiboshowOutput:(NSNotification *)note
{
    if(note.name==@"weibo_userInfo")
    {
        NSMutableArray *temp=[[NSMutableArray alloc] init];
        temp=note.object;
        for(NSDictionary *dic in temp)
            [[DataClient shareClient]addItem:dic withType:1];
        NSLog(@"汇总数组的大小为 %d",[temp count]);
        for(int i=0;i<[temp count];i++)  //循环读取数据
        {
            NSLog(@"%@   %d",[[temp objectAtIndex:i] objectForKey:@"text"],i);
        }
    }
    if(note.name==@"weibo_user_statuses")
    {
        NSMutableArray *temp=[[NSMutableArray alloc] init];
        temp=note.object;
        for(NSDictionary *dic in temp)
            [[DataClient shareClient]addItem:dic withType:2];
        NSLog(@"汇总数组的大小为 %d",[temp count]);
        for(int i=0;i<[temp count];i++)  //循环读取数据
        {
            NSLog(@"%@   %d",[[temp objectAtIndex:i] objectForKey:@"text"],i);
        }
    }

    else if(note.name==@"weibo_user_lateststatuses")
    {
        NSMutableArray *temp=[[NSMutableArray alloc] init];
        temp=note.object;
        for(NSDictionary *dic in temp)
            [[DataClient shareClient]addItem:dic withType:2];
        NSLog(@"汇总数组的大小为 %d",[temp count]);
        for(int i=0;i<[temp count];i++)  //循环读取数据
        {
            NSLog(@"%@   %d",[[temp objectAtIndex:i] objectForKey:@"text"],i);
        }
    }
    else if(note.name==@"weibo_friends_statuses")
    {
        NSMutableArray *temp=[[NSMutableArray alloc] init];
        temp=note.object;
        for(NSDictionary *dic in temp)
            [[DataClient shareClient]addItem:dic withType:3];
        NSLog(@"汇总数组的大小为 %d",[temp count]);
        for(int i=0;i<[temp count];i++)
        {
            NSLog(@"%@   %d",[[temp objectAtIndex:i] objectForKey:@"text"],i);
        }
    }
    else if(note.name==@"weibo_friends_lateststatuses")
    {
        NSMutableArray *temp=[[NSMutableArray alloc] init];
        temp=note.object;
        for(NSDictionary *dic in temp)
            [[DataClient shareClient]addItem:dic withType:3];
        NSLog(@"汇总数组的大小为 %d",[temp count]);
        for(int i=0;i<[temp count];i++)
        {
            NSLog(@"%@   %d",[[temp objectAtIndex:i] objectForKey:@"text"],i);
        }

        
    }
    else if(note.name==@"weibo_friends")
    {
        NSMutableArray *temp=[[NSMutableArray alloc] init];
        temp=note.object;
        for(NSDictionary *dic in temp)
            [[DataClient shareClient]addItem:dic withType:4];
        NSLog(@"%d",[temp count]);
        for(int i=0;i<[temp count];i++)
        {
        }
    }
    else {

    }
    
}
//人人数据的处理
-(void) RenRenshowOutput:(NSNotification *)note
{
   /* if(note.name==@"renren_user_info")
    {
        NSMutableArray *temp=[[NSMutableArray alloc] init];
        temp=note.object;
        for(NSDictionary *dic in temp)
            [[DataClient shareClient]addItem:dic withType:1];
        NSLog(@"汇总数组的大小为 %d",[temp count]);
        for(int i=0;i<[temp count];i++)  //循环读取数据
        {
            NSLog(@"%@   %d",[[temp objectAtIndex:i] objectForKey:@"text"],i);
        }
    }
    else if(note.name==@"user_lateststatuses")
    {
        NSMutableArray *temp=[[NSMutableArray alloc] init];
        temp=note.object;
        for(NSDictionary *dic in temp)
            [[DataClient shareClient]addItem:dic withType:2];
        NSLog(@"汇总数组的大小为 %d",[temp count]);
        for(int i=0;i<[temp count];i++)  //循环读取数据
        {
            NSLog(@"%@   %d",[[temp objectAtIndex:i] objectForKey:@"text"],i);
        }
    }
    else if(note.name==@"friends_statuses")
    {
        NSMutableArray *temp=[[NSMutableArray alloc] init];
        temp=note.object;
        for(NSDictionary *dic in temp)
            [[DataClient shareClient]addItem:dic withType:3];
        NSLog(@"汇总数组的大小为 %d",[temp count]);
        for(int i=0;i<[temp count];i++)
        {
            NSLog(@"%@   %d",[[temp objectAtIndex:i] objectForKey:@"text"],i);
        }
    }*/

}
@end
