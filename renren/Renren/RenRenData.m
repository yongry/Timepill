//
//  RenRenData.m
//  RenrenSDKDemo
//
//  Created by 01 developer on 12-10-30.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import "RenRenData.h"

@implementation RenRenData
@synthesize renren;
@synthesize uid4flag;

-(id)init{
    if([super init])
    {
        self.renren=[Renren sharedRenren];
        userInfo=[[NSMutableDictionary alloc] init];
        friends=[[NSMutableArray alloc] init];
        status=[[NSMutableArray alloc] init];
        
        isFirstGetFriends=YES;
        page4friends=1;
        isFirstGetStatus=YES;
        page4status=1;
        uid4flag=nil;
    }
    return self;
}

-(void)ToLogin{
    if (![self.renren isSessionValid]) {
		NSArray *permissions = [NSArray arrayWithObjects:@"status_update",@"photo_upload",@"publish_feed",@"create_album",@"operate_like",@"read_user_status",nil];
		[self.renren authorizationWithPermisson:permissions andDelegate:self];
	} 
}

-(void)ToLogout{
    [self.renren logout:self];
}

-(void)getUserInfo{
    //设置请求参数
	ROUserInfoRequestParam *requestParam = [[[ROUserInfoRequestParam alloc] init] autorelease];
	requestParam.fields = [NSString stringWithFormat:@"uid,name,sex,birthday,headurl"];
	//发送请求
	[self.renren getUsersInfo:requestParam andDelegate:self];
}

-(void)getFriends
{
    ROGetFriendsInfoRequestParam *requestParam = [[[ROGetFriendsInfoRequestParam alloc] init] autorelease];
	requestParam.page = @"1";
	requestParam.count = @"500";
    requestParam.fields = @"name,id,headurl";
	
	[self.renren getFriendsInfo:requestParam andDelegate:self];
}

-(void)getuserStatus:(NSString *) uid
{
    ROUserStatusRequestParam *requestParam = [[[ROUserStatusRequestParam alloc] init] autorelease];
	requestParam.page = @"1";
	requestParam.count = @"1000";
    if(uid!=nil)
    {
        requestParam.uid = uid;
        self.uid4flag=uid;
    }
	
	[self.renren getUserStatus:requestParam andDelegate:self];
}
-(void)getLatestStatus:(NSString *)uid
{
    ROUserStatusRequestParam *requestParam = [[[ROUserStatusRequestParam alloc] init] autorelease];
	requestParam.page = @"1";
	requestParam.count = @"25";
    if(uid!=nil)
    {
        requestParam.uid = uid;
        self.uid4flag=uid;
    }
	[self.renren getUserStatus:requestParam andDelegate:self];
}

#pragma mark - RenrenDelegate methods
/**
 * 接口请求成功，第三方开发者实现这个方法
 */
- (void)renren:(Renren *)renren requestDidReturnResponse:(ROResponse*)response
{
    if([response.param.method isEqual:@"users.getInfo"])
    {
        NSArray *usersInfo = (NSArray *)(response.rootObject);
	
        for (ROUserResponseItem *item in usersInfo) {
            [usersInfo setValue:item.userId forKey:@"userId"];
            [usersInfo setValue:item.name forKey:@"name"];
            [usersInfo setValue:item.headUrl forKey:@"headUrl"];
            NSLog(@"UserID:%@\n Name:%@\n Sex:%@\n Birthday:%@\n HeadURL:%@\n",item.userId,item.name,item.sex,item.brithday,item.headUrl);
        }
        //发送一个通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"renren_user_info" object:usersInfo];
    }
    else if([response.param.method isEqual:@"friends.getFriends"])
    {
        //第一次清空数组
        if(isFirstGetFriends ==YES)
        {
            [friends removeAllObjects];
            isFirstGetFriends=NO;
        }
        
        NSArray *friendsInfo = (NSArray *)(response.rootObject);
        int count=[friendsInfo count];
        NSLog(@"本次数组大小为%d",count);
        for (ROFriendResponseItem *item in friendsInfo) {
            NSDictionary *dictionary = [item responseDictionary];
            [friends addObject:dictionary];
        }
        
        //如果没读完，继续读
        if(count==500)
        {
            page4friends++;
            ROGetFriendsInfoRequestParam *requestParam = [[[ROGetFriendsInfoRequestParam alloc] init] autorelease];
            requestParam.page = [NSString stringWithFormat:@"%d",page4friends];
            requestParam.count = @"500";
            requestParam.fields = @"name,id,headurl";
            
            [self.renren getFriendsInfo:requestParam andDelegate:self];
        }
        else {
            page4friends=1;
            isFirstGetFriends=YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"renren_friends" object:friends];

        }
    }
    else if([response.param.method isEqual:@"status.gets"])
    {
        if(isFirstGetStatus==YES)
        {
            [status removeAllObjects];
            isFirstGetStatus=NO;
        }
        NSArray *friendsInfo = (NSArray *)(response.rootObject);
        int count=[friendsInfo count];
        NSLog(@"本次数组大小为%d",count);
        for (ROResponseItem *item in friendsInfo) {
            NSDictionary *dictionary = [item responseDictionary];
            [status addObject:dictionary];
        }
        if(count==1000)
        {
            page4status++;
            ROUserStatusRequestParam *requestParam = [[[ROUserStatusRequestParam alloc] init] autorelease];
            requestParam.page = [NSString stringWithFormat:@"%d",page4status];
            requestParam.count = @"1000";
            if(self.uid4flag!=nil)
                requestParam.uid = self.uid4flag;
            [self.renren getUserStatus:requestParam andDelegate:self];
        }
        else {
            page4status=1;
            isFirstGetStatus=YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"renren_status" object:status];
        }
    }
}

/**
 * 接口请求失败，第三方开发者实现这个方法
 */
- (void)renren:(Renren *)renren requestFailWithError:(ROError*)error
{
	NSString *title = [NSString stringWithFormat:@"Error code:%d", [error code]];
	NSString *description = [NSString stringWithFormat:@"%@", [error.userInfo objectForKey:@"error_msg"]];
	UIAlertView *alertView =[[[UIAlertView alloc] initWithTitle:title message:description delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] autorelease];
	[alertView show];
}

-(void)renrenDidLogin:(Renren *)renren{
    NSLog(@"登陆成功");
}

- (void)renren:(Renren *)renren loginFailWithError:(ROError*)error{
	NSString *title = [NSString stringWithFormat:@"Error code:%d", [error code]];
	NSString *description = [NSString stringWithFormat:@"%@", [error localizedDescription]];
	UIAlertView *alertView =[[[UIAlertView alloc] initWithTitle:title message:description delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] autorelease];
	[alertView show];
}
@end
