//
//  AppDelegate.m
//  meituan
//
//  Created by jinzelu on 15/6/12.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "InfoViewController.h"
#import "MineViewController.h"
#import "MoreViewController.h"
#import "JZOnSiteViewController.h"
#import "JZMerchantViewController.h"

#import <CoreLocation/CoreLocation.h>
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "NetworkSingleton.h"
#import "MobClick.h"


@interface AppDelegate ()<CLLocationManagerDelegate>
{
    //定位
    CLLocationManager *_locationManager;//用于获取位置
    CLLocation *_checkLocation;//用于保存位置信息
    
//    double _latitude;//经度
//    double _longitude;//维度
}

@end

@implementation AppDelegate


//设置定位
-(void)setupLocationManager{
    _latitude = LATITUDE_DEFAULT;
    _longitude = LONGITUDE_DEFAULT;
    _locationManager = [[CLLocationManager alloc] init];
    
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"开始定位");
        _locationManager.delegate = self;
        // distanceFilter是距离过滤器，为了减少对定位装置的轮询次数，位置的改变不会每次都去通知委托，而是在移动了足够的距离时才通知委托程序
        // 它的单位是米，这里设置为至少移动1000再通知委托处理更新;
        _locationManager.distanceFilter = 200.0;
        // kCLLocationAccuracyBest:设备使用电池供电时候最高的精度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        
        //ios8+以上要授权，并且在plist文件中添加NSLocationWhenInUseUsageDescription，NSLocationAlwaysUsageDescription，值可以为空
        if (IOS_VERSION >=8.0) {//ios8+，不加这个则不会弹框
            [_locationManager requestWhenInUseAuthorization];//使用中授权
            [_locationManager requestAlwaysAuthorization];
        }
        [_locationManager startUpdatingLocation];
    }else{
        NSLog(@"定位失败，请确定是否开启定位功能");
        //        _locationManager.delegate = self;
        //        // distanceFilter是距离过滤器，为了减少对定位装置的轮询次数，位置的改变不会每次都去通知委托，而是在移动了足够的距离时才通知委托程序
        //        // 它的单位是米，这里设置为至少移动1000再通知委托处理更新;
        //        _locationManager.distanceFilter = 200.0;
        //        // kCLLocationAccuracyBest:设备使用电池供电时候最高的精度
        //        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //        [_locationManager startUpdatingLocation];
    }
}


//获取启动广告图片，采用后台推送时执行请求
-(void)getLoadingImage{
    //分辨率
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    NSLog(@"%.0f    %.0f",screen_width*scale_screen,screen_height*scale_screen);
    int scaleW = (int)screen_width*scale_screen;
    int scaleH = (int)screen_height*scale_screen;
    
    NSString *urlStr = [NSString stringWithFormat:@"http://api.meituan.com/config/v1/loading/check.json?app_name=group&app_version=5.7&ci=1&city_id=1&client=iphone&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-15-15-51824&platform=iphone&resolution=%d%@%d&userid=10086&utm_campaign=AgroupBgroupD100Fa20141120nanning__m1__leftflow___ab_pindaochangsha__a__leftflow___ab_gxtest__gd__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_i550poi_ktv__d__j___ab_chunceshishuju__a__a___ab_gxh_82__nostrategy__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi0202__b__a___ab_pindaoquxincelue0630__b__b1___ab_i550poi_xxyl__b__leftflow___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_pindaoshenyang__a__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__a__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGhomepage&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7",scaleW,@"%2A",scaleH];
    
    [[NetworkSingleton sharedManager] getAdvLoadingImage:nil url:urlStr successBlock:^(id responseBody){
        NSLog(@"获取启动广告图片成功");
        NSMutableArray *dataArray = [responseBody objectForKey:@"data"];
        NSLog(@"dataArray:%@",dataArray);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (dataArray.count>0) {
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[dataArray[0] objectForKey:@"imageUrl"]]];
                UIImage *image = [UIImage imageWithData:data];
                
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
                
                NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"loading.png"]];   // 保存文件的名称
                //    BOOL result = [UIImagePNGRepresentation() writeToFile: filePath    atomically:YES]; // 保存成功会返回YES
                NSLog(@"paths:%@    %@",paths,filePath);
                [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
                
            }
        });
        
    } failureBlock:^(NSString *error){
        NSLog(@"获取启动广告图片失败：%@",error);
    }];
}

-(void)initAdvView{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"loading.png"]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isExit = [fileManager fileExistsAtPath:filePath isDirectory:&isDir];
    if (isExit) {
        NSLog(@"存在");
        _advImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
//        [_advImage setImage:[UIImage imageNamed:@"loading.png"]];
        [_advImage setImage:[UIImage imageWithContentsOfFile:filePath]];
        [self.window addSubview:_advImage];
        [self performSelector:@selector(removeAdvImage) withObject:nil afterDelay:3];
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //加载启动广告并保存到本地沙盒，因为保存的图片较大，每次运行都要保存，所以注掉了
            [self getLoadingImage];
        });
    }else{
        NSLog(@"不存在");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self getLoadingImage];
        });
    }
}

-(void)removeAdvImage{
    [UIView animateWithDuration:0.3f animations:^{
        _advImage.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
        _advImage.alpha = 0.f;
    } completion:^(BOOL finished) {
        [_advImage removeFromSuperview];
    }];
}

-(void)initRootVC{

//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.hidden = NO;
    //1.
    HomeViewController *VC1 = [[HomeViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:VC1];
    
    //    InfoViewController *VC2 = [[InfoViewController alloc] init];
    JZOnSiteViewController *VC2 = [[JZOnSiteViewController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:VC2];
    JZMerchantViewController *VC3 = [[JZMerchantViewController alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:VC3];
    MineViewController *VC4 = [[MineViewController alloc] init];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:VC4];
    MoreViewController *VC5 = [[MoreViewController alloc] init];
    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:VC5];
    VC1.title = @"团购";
    VC2.title = @"上门";
    VC3.title = @"商家";
    VC4.title = @"我的";
    VC5.title = @"更多";
    //2.
    NSArray *viewCtrs = @[nav1,nav2,nav3,nav4,nav5];
    //3.
//    UITabBarController *tabbarCtr = [[UITabBarController alloc] init];rootTabbarCtr
    self.rootTabbarCtr  = [[UITabBarController alloc] init];
    //4.
    [self.rootTabbarCtr setViewControllers:viewCtrs animated:YES];
    //5.
    self.window.rootViewController = self.rootTabbarCtr;
    
    //6.
    UITabBar *tabbar = self.rootTabbarCtr.tabBar;
    UITabBarItem *item1 = [tabbar.items objectAtIndex:0];
    UITabBarItem *item2 = [tabbar.items objectAtIndex:1];
    UITabBarItem *item3 = [tabbar.items objectAtIndex:2];
    UITabBarItem *item4 = [tabbar.items objectAtIndex:3];
    UITabBarItem *item5 = [tabbar.items objectAtIndex:4];
    
    item1.selectedImage = [[UIImage imageNamed:@"icon_tabbar_homepage_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.image = [[UIImage imageNamed:@"icon_tabbar_homepage"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.selectedImage = [[UIImage imageNamed:@"icon_tabbar_onsite_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.image = [[UIImage imageNamed:@"icon_tabbar_onsite"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    item2.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    item3.selectedImage = [[UIImage imageNamed:@"icon_tabbar_merchant_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.image = [[UIImage imageNamed:@"icon_tabbar_merchant_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    item3.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    item4.selectedImage = [[UIImage imageNamed:@"icon_tabbar_mine_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item4.image = [[UIImage imageNamed:@"icon_tabbar_mine"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    item4.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    item5.selectedImage = [[UIImage imageNamed:@"icon_tabbar_misc_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item5.image = [[UIImage imageNamed:@"icon_tabbar_misc"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    item5.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    //改变UITabBarItem字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGB(54, 185,175),UITextAttributeTextColor, nil] forState:UIControlStateSelected];
    
    //友盟统计
    [MobClick startWithAppkey:UMAPPKEY reportPolicy:BATCH   channelId:@"GitHub"];
    
    
    //友盟初始化
    [UMSocialData setAppKey:UMAPPKEY];
    [UMSocialWechatHandler setWXAppId:@"wx3b1ec5fee404cc3d" appSecret:@"e97199313f931035a765ee433e335dbb" url:@"http://www.fityun.cn/"];
    
    //友盟初始化，对未安装QQ，微信的平台进行隐藏
    //    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToWechatSession,UMShareToWechatTimeline]];
    
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.window makeKeyAndVisible];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setupLocationManager];
    [self initRootVC];
    
    
    [self initAdvView];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - CLLocationManagerDelegate
//舍弃了
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    NSLog(@"didUpdateToLocation----");
    _checkLocation = newLocation;
}

//ios 6.0sdk以上
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    NSLog(@"didUpdateToLocation+++");
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *cl = [locations lastObject];
    _latitude = cl.coordinate.latitude;
    _longitude = cl.coordinate.longitude;
    NSLog(@"纬度--%f",_latitude);
    NSLog(@"经度--%f",_longitude);
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"定位失败");
}


//友盟微信分享
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [UMSocialSnsService handleOpenURL:url];
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [UMSocialSnsService handleOpenURL:url];
}

//禁止横屏
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}


@end
