//
//  SinaWeiboData.m
//  sinaweibo_ios_sdk_demo
//
//  Created by 01 developer on 12-10-18.
//  Copyright (c) 2012年 SINA. All rights reserved.
//

#import "SinaWeiboData.h"
#import "SNAppDelegate.h"
@implementation SinaWeiboData

@synthesize sinaweibo;

-(id)init{
    self=[super init];
    if(self)
    {
        userInfo=[[NSMutableDictionary alloc] init];
        user_statuses=[[NSMutableArray alloc] init];
        friends_statuses=[[NSMutableArray alloc] init];
        friends=[[NSMutableArray alloc] init];
        isLast=NO;
        next_count=1;
        page=1;
        isLoadingLatest1= NO;
        isLoadingLatest2= NO;
        isFirstLoadingFriends= YES;
        
        [self initSinaWeibo];
    }
    return self;
}
-(void)initSinaWeibo
{
    //实例化SinaWeibo对象，指定它的delegate
    sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:self];
    //把登陆参数取出
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    } 
}
- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}

- (void)storeAuthData
{    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)ToLogin
{
    [userInfo release], userInfo = nil;
    [user_statuses release], user_statuses = nil;
    
    [sinaweibo logIn];  
}
-(void)ToLogout
{
    [sinaweibo logOut];  
}

-(void)getUserInfo
{
    [sinaweibo requestWithURL:@"users/show.json"
                           params:[NSMutableDictionary dictionaryWithObject:sinaweibo.userID forKey:@"uid"]
                       httpMethod:@"GET"
                        delegate:self];
    
}
-(void)getUser_Statuses
{
    //设置参数
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithObject:sinaweibo.userID forKey:@"uid"];
    //设置100条
    [params setValue:@"100" forKey:@"count"];
    [params setValue:@"1" forKey:@"feature"];
    [sinaweibo requestWithURL:@"statuses/user_timeline.json"
                       params:params
                   httpMethod:@"GET"
                     delegate:self];
}
-(void)getLatestUser_Statuses
{
    //标记为正在读取最新微博
    isLoadingLatest1 =YES; 
    
    //设置参数
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithObject:sinaweibo.userID forKey:@"uid"];
    //读取上一次更新后最新的id
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *last4Me=[userDefaults stringForKey:@"LastId4Me"];
    //设置100条
    [params setValue:@"100" forKey:@"count"];
    [params setValue:@"1" forKey:@"feature"];
    [params setValue:last4Me forKey:@"since_id"];
    [sinaweibo requestWithURL:@"statuses/user_timeline.json"
                       params:params
                   httpMethod:@"GET"
                     delegate:self];
}
-(void)getFriends_Statuses:(NSString *) uid
{
    //设置参数
    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
    //[params setValue:@"Miclinda" forKey:@"screen_name"];  
    [params setObject:uid forKey:@"uid"];
    //设置100条
    [params setValue:@"100" forKey:@"count"];
    [params setValue:@"1" forKey:@"feature"];
    [sinaweibo requestWithURL:@"statuses/user_timeline.json"
                       params:params
                   httpMethod:@"GET"
                     delegate:self];
}
-(void)getLatestFriends_Statuses:(NSString *) uid
{
    isLoadingLatest2=YES;
    //设置参数
    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
    //读取上一次更新后最新的id
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dir=[userDefaults objectForKey:@"LastId4Friends"];
    NSString *lastId4Friends=[dir objectForKey:uid];
    //[params setValue:@"Miclinda" forKey:@"screen_name"];                            //dictionaryWithObject:[NSString stringWithFormat:@"",uid] forKey:@"uid"];
    [params setValue:uid forKey:@"uid"];
    //设置100条
    [params setValue:@"100" forKey:@"count"];
    [params setValue:@"1" forKey:@"feature"];
    if(lastId4Friends!=nil)
        [params setValue:lastId4Friends forKey:@"since_id"];
    [sinaweibo requestWithURL:@"statuses/user_timeline.json"
                       params:params
                   httpMethod:@"GET"
                     delegate:self];
}
-(void)getFriends
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
    [params setValue:sinaweibo.userID forKey:@"uid"];
    [params setValue:@"200" forKey:@"count"];
    [sinaweibo requestWithURL:@"friendships/friends.json" params:params httpMethod:@"GET" delegate:self];
}
-(void)postStatus:(NSString *)text
{
    //发布状态
    [sinaweibo requestWithURL:@"statuses/update.json"
                       params:[NSMutableDictionary dictionaryWithObjectsAndKeys:text, @"status", nil]
                   httpMethod:@"POST"
                     delegate:self];
}
-(void)postImageStatus:(NSString *)text andImage:(UIImage *)image
{
    //发布图片状态    
    [sinaweibo requestWithURL:@"statuses/upload.json"
                       params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               text, @"status",
                               image, @"pic", nil]
                   httpMethod:@"POST"
                     delegate:self];
}
#pragma mark - SinaWeibo Delegate   
//登陆的委托函数

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    
    [self storeAuthData];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    [self removeAuthData];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [self removeAuthData];

}

#pragma mark - SinaWeiboRequest Delegate 
//失败调用此方法
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
        [userInfo release], userInfo = nil;
    }
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
    {
        if([[request.params objectForKey:@"uid"] isEqual:[self sinaweibo].userID]) //如果该请求是“获取用户状态”
            [user_statuses release], user_statuses = nil;
        else  //如果该请求是“获取好友状态”
            [friends_statuses release], friends_statuses = nil;
    }
    else if([request.url hasSuffix:@"friendships/friends.json"])
    {
        [friends release], friends = nil;
    }
}
//成功调用此方法
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    if ([request.url hasSuffix:@"users/show.json"])
    {

        userInfo=result;
        //数据加载完毕，发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"userInfo" object:userInfo];
    }
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
    {
         if([[request.params objectForKey:@"uid"] isEqual:[self sinaweibo].userID]) //如果该请求是“获取用户状态”
         {
             NSArray *statuses=[[result objectForKey:@"statuses"] retain];
             NSString *total_number=[result objectForKey:@"total_number"];
             NSLog(@"total_number is %@",total_number);
             int count=[[result objectForKey:@"statuses"] count];
             NSLog(@"这一次返回的数组大小 %d",count);
             //初始化数组
             //problem:调用init()的时候不是应该初始化过了么！？为什么没有效果！？
             if(page==1)
             {
                 user_statuses=[[NSMutableArray alloc] init];
                 //把第一条微博的id保存
                 NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                 if([[result objectForKey:@"statuses"] count]!=0)
                 {
                     [userDefaults setValue:[[[result objectForKey:@"statuses"] objectAtIndex:0] objectForKey:@"idstr"] forKey:@"LastId4Me"];
                 }
             }
             
             [user_statuses addObjectsFromArray:statuses];
             if(page<=[total_number intValue]/100 && isLoadingLatest1==NO)
             {

                 page++;
                 //设置参数
                 NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
                 //设置100条
                 [params setValue:sinaweibo.userID forKey:@"uid"];
                 [params setValue:@"100" forKey:@"count"];
                 [params setValue:@"1" forKey:@"feature"];
                 [params setValue:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
                 [sinaweibo requestWithURL:@"statuses/user_timeline.json"
                                    params:params
                                httpMethod:@"GET"
                                  delegate:self];  
             }
             else {  //数据加载完毕，发送通知
                 if(isLoadingLatest1==YES)  //如果是拉取最新微博
                 {
                     isLoadingLatest1=NO;
                     page=1;
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"user_lateststatuses" object:user_statuses];
                 }
                 else{  //否则就是拉取全部微博
                     isLoadingLatest1=NO;
                     page=1;
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"user_statuses" object:user_statuses];
                 }
             }
         }
        else   //否则就是获取好友的状态
        {
            NSArray *statuses=[[result objectForKey:@"statuses"] retain];
            NSString *total_number=[result objectForKey:@"total_number"];
            NSLog(@"total_number is %@",total_number);
            int count=[[result objectForKey:@"statuses"] count];
            NSLog(@"这一次返回的数组大小 %d",count);
            //初始化数组
            //problem:调用init()的时候不是应该初始化过了么！？为什么没有效果！？
            if(page==1)
            {
                friends_statuses=[[NSMutableArray alloc] init];
                //把第一条微博的id保存
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                if([[result objectForKey:@"statuses"] count]!=0)
                {
                    NSMutableDictionary *dir=[[NSMutableDictionary alloc] init];
                    NSString *friendsID=[request.params objectForKey:@"uid"];
                    NSString *friendsLastStatusID=[[[result objectForKey:@"statuses"] objectAtIndex:0] objectForKey:@"idstr"];
                    //把此映射放到dir里面
                    [dir setValue:friendsLastStatusID forKey:friendsID];
                    [userDefaults setValue:dir forKey:@"LastId4Friends"];
                }
            }
            
            [friends_statuses addObjectsFromArray:statuses];
            if(page<[total_number intValue]/100 && isLoadingLatest2==NO)
            {
                NSLog(@"pass");
                page++;
                //设置参数
                NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
                //设置100条
                [params setValue:[request.params objectForKey:@"uid"] forKey:@"uid"];
                [params setValue:@"100" forKey:@"count"];
                [params setValue:@"1" forKey:@"feature"];
                [params setValue:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
                [sinaweibo requestWithURL:@"statuses/user_timeline.json"
                                   params:params
                               httpMethod:@"GET"
                                 delegate:self];  
            }
            else {  //数据加载完毕，发送通知
                if(isLoadingLatest2==YES)
                {
                    isLoadingLatest2=NO;
                    page=1;
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"friends_lateststatuses" object:friends_statuses];
                }
                else{
                    isLoadingLatest2=NO;
                    page=1;
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"friends_statuses" object:friends_statuses];
                }
            }

        }
    }
    else if ([request.url hasSuffix:@"friendships/friends.json"])
    {
        NSDictionary *dir=result;
        NSString *total_number=[dir objectForKey:@"total_number"];
        //NSLog(@"total number is %@",total_number);
        //如果是重新拉取好友，就把数组清空
        if(isFirstLoadingFriends == YES)
            [friends removeAllObjects];
        //problem!?
        //在获取next_cursor后把该值传到下一个request时，无故报错
        //所以手动设置next_cursor，30一页起跳
        //如果设置50一页，只返回49个数据！？
        
        NSArray *temp=[dir objectForKey:@"users"];
        int count=[temp count];
        NSLog(@"count is %d",count);
        [friends addObjectsFromArray:temp];
        //如果不是最后一轮，就会继续发起request，读取下一页的好友
        if(count!=0)
        {
            isFirstLoadingFriends=NO;
            //手动递增next_cursor
            next_count=next_count+count;
            //SinaWeibo *sinaweibo = [self sinaweibo];
            NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
            [params setValue:sinaweibo.userID forKey:@"uid"];
            [params setValue:@"200" forKey:@"count"];
            [params setValue:[NSString stringWithFormat:@"%d",next_count] forKey:@"cursor"];
            [sinaweibo requestWithURL:@"friendships/friends.json" params:params httpMethod:@"GET" delegate:self];
        }
        else {
            isFirstLoadingFriends=YES;
            next_count=1;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"friends" object:friends];
        }
    }
}
@end
