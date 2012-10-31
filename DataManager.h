//
//  DataManager.h
//  sinaweibo_ios_sdk_demo
//
//  Created by 01 developer on 12-10-28.
//  Copyright (c) 2012年 SINA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SinaWeiboData.h"
#import "RenRenData.h"
#import "DataClient.h"

@interface DataManager : NSObject
{
    SinaWeiboData *sinaWeiboData;
    RenRenData *renrenData;
}

@property(retain,nonatomic)  SinaWeiboData *sinaWeiboData;
@property(retain,nonatomic)  RenRenData *renrenData;
@end
