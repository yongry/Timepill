//
//  RenRenData.h
//  RenrenSDKDemo
//
//  Created by 01 developer on 12-10-30.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Renren.h"
@interface RenRenData : NSObject <RenrenDelegate>
{
    Renren *renren;
    NSMutableDictionary *userInfo;
    NSMutableArray *friends;
    NSMutableArray *status;
    
    //flag
    Boolean isFirstGetFriends;
    int page4friends;
    Boolean isFirstGetStatus;
    int page4status;
    NSString *uid4flag;
}
@property (retain,nonatomic)Renren *renren;
@property (retain,nonatomic)NSString *uid4flag;

-(void)ToLogin;  //登陆
-(void)ToLogout;  //登出
-(void)getUserInfo;  //获取用户个人信息
-(void)getFriends;  //获取所有好友
-(void)getuserStatus:(NSString *) uid; //获取用户状态，传入nil为获取用户个人
-(void)getLatestStatus:(NSString *)uid; //获取用户最新状态，返回25条

@end
