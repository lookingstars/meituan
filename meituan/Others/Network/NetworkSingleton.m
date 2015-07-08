//
//  NetworkSingleton.m
//  meituan
//
//  Created by jinzelu on 15/6/17.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "NetworkSingleton.h"

@implementation NetworkSingleton

+(NetworkSingleton *)sharedManager{
    static NetworkSingleton *sharedNetworkSingleton = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        sharedNetworkSingleton = [[self alloc] init];
    });
    return sharedNetworkSingleton;
}
-(AFHTTPRequestOperationManager *)baseHtppRequest{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:TIMEOUT];
    //header 设置
    //    [manager.requestSerializer setValue:K_PASS_IP forHTTPHeaderField:@"Host"];
    //    [manager.requestSerializer setValue:@"max-age=0" forHTTPHeaderField:@"Cache-Control"];
    //    [manager.requestSerializer setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    //    [manager.requestSerializer setValue:@"zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3" forHTTPHeaderField:@"Accept-Language"];
    //    [manager.requestSerializer setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    //    [manager.requestSerializer setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    //    [manager.requestSerializer setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:35.0) Gecko/20100101 Firefox/35.0" forHTTPHeaderField:@"User-Agent"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", @"application/json", nil];
    return manager;
}

#pragma mark - 团购模块接口

#pragma mark - 抢购
-(void)getRushBuyResult:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        failureBlock(errorStr);
    }];
}


#pragma mark - 热门排队
-(void)getHotQueueResult:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        failureBlock(errorStr);
    }];
}

#pragma mark - 推荐
-(void)getRecommendResult:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        failureBlock(errorStr);
    }];
}

#pragma mark - 折扣
-(void)getDiscountResult:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        failureBlock(errorStr);
    }];
}


#pragma mark - 折扣详情
-(void)getOCDiscountResult:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        failureBlock(errorStr);
    }];
}


#pragma mark - 店铺详情
-(void)getShopResult:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        failureBlock(errorStr);
    }];
}




#pragma mark - 上门


#pragma mark - 上门服务
-(void)getHomeServiceResult:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        failureBlock(errorStr);
    }];
}



#pragma mark - 上门服务广告
-(void)getServiceAdvResult:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        failureBlock(errorStr);
    }];
}










@end
