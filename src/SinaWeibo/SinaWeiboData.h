//
//  SinaWeiboData.h
//  sinaweibo_ios_sdk_demo
//
//  Created by 01 developer on 12-10-18.
//  Copyright (c) 2012年 SINA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"

#import <UIKit/UIKit.h>
#import "SinaWeiboData.h"
#define kAppKey             @"1213792051"
#define kAppSecret          @"4fc6b43b7a6b7dd69aecf26204f7ff96"
#define kAppRedirectURI     @"http://www.weibo.com"

#ifndef kAppKey
#error
#endif

#ifndef kAppSecret
#error
#endif

#ifndef kAppRedirectURI
#error
#endif

@interface SinaWeiboData : NSObject<SinaWeiboDelegate,SinaWeiboRequestDelegate>
{
    SinaWeibo *sinaweibo;  //
    
    NSMutableDictionary *userInfo;  //用户个人信息
    NSMutableArray *user_statuses;  //用户个人状态
    NSMutableArray *friends_statuses;  //某个好友的状态
    NSMutableArray *friends;  //所有关注者
   
    //flag变量
    Boolean isLast; //读取好友时的标记，是否为最后一页
    NSInteger next_count;  //读取好友时的标记，0-30-60...
    int page;  //读取状态时的标记，即一页
    Boolean isLoadingLatest1; //判断是在读取全部微博还是最新微博(for me)
    Boolean isLoadingLatest2; //判断是在读取全部微博还是最新微博(for friends)
    Boolean isFirstLoadingFriends;  //判断是不是第一次拉好友
}

@property (readonly, nonatomic) SinaWeibo *sinaweibo;

-(void)ToLogin;
-(void)ToLogout;

-(void)getUserInfo;   // 获取 个人信息
-(void)getUser_Statuses;  // 获取 用户个人的 所有原创微博
-(void)getLatestUser_Statuses; // 获取 用户个人的 最新原创微博
-(void)getFriends_Statuses:(NSString *) uid;  //获取 某个好友的 所有原创微博
-(void)getLatestFriends_Statuses:(NSString *) uid;  // 获取 某个好友的 最新原创微博
-(void)getFriends;  // 获取 所有的关注者
-(void)postStatus:(NSString *)text;  // 发布一条微博（不带图片）
-(void)postImageStatus:(NSString *)text andImage:(UIImage *)image; // 发布一条微博（带图片）

@end
