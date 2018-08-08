//
//  AnalysysAgent.h
//  AnalysysAgent
//
//  Created by analysys on 2018/2/3.
//  Copyright © 2018年 analysys. All rights reserved.
//

/** 当前版本 4.0.5 */


#import <Foundation/Foundation.h>


/*
 Debug模式，上线时使用 AnalysysDebugOff
 - AnalysysDebugOff: 关闭Debug模式
 - AnalysysDebugOnly: 打开Debug模式，但该模式下发送的数据仅用于调试，不进行数据导入
 - AnalysysDebugButTrack: 打开Debug模式，并入库计算
*/
typedef NS_ENUM(NSInteger, AnalysysDebugMode) {
    AnalysysDebugOff,
    AnalysysDebugOnly,
    AnalysysDebugButTrack
};


/**
 推送类型
 
 - AnalysysPushJiGuang: 极光推送
 - AnalysysPushGeTui: 个推推送
 - AnalysysPushBaiDu: 百度推送
 - AnalysysPushXiaoMi: 小米推送
 */
typedef NS_ENUM(NSInteger, AnalysysPushProvider) {
    AnalysysPushJiGuang = 0,
    AnalysysPushGeTui,
    AnalysysPushBaiDu,
    AnalysysPushXiaoMi
};




@interface AnalysysAgent : NSObject


#pragma mark *** 基本配置 ***

/**
 初始化SDK
 
 - 包含可视化相关配置
 - 根据baseURL统一设置数据及可视化地址
 - baseURL只需要填写域名或ip部分，数据上传及可视化数据配置下发地址默认使用https协议，可视化前端使用wss协议。如：arkpaastest.analysys.cn

 @param appKey AppKey
 @param channel 渠道，默认为“App Store”
 @param baseURL 基础域名
 @return AnalysysAgent实例
 */
+ (AnalysysAgent *)startWithAppKey:(NSString *)appKey
                            channel:(NSString *)channel
                            baseURL:(NSString *)baseURL;


/**
 初始化SDK
 
 - 当autoProfile 为true，则追踪新用户首次属性
 - 默认autoProfile为YES

 @param appKey AppKey
 @param channel 渠道，默认为“App Store”
 @param baseURL 基础域名
 @param autoProfile 是否追踪新用户的首次属性
 @return AnalysysAgent实例
 */
+ (AnalysysAgent *)startWithAppKey:(NSString *)appKey
                           channel:(NSString *)channel
                           baseURL:(NSString *)baseURL
                       autoProfile:(BOOL)autoProfile;


/**
 设置自定义数据上传地址
 
 - uploadURL 格式：http://host:port 或 https://host:port 如：https://arkpaastest.analysys.cn:8089
 
 @param uploadURL 数据上传地址
 */
+ (void)setUploadURL:(NSString *)uploadURL;


/**
 设置自定义可视化地址
 
 - visitorDebugURL 格式：ws://host:port 或 wss://host:port 如：ws://arkpaastest.analysys.cn:9091

 @param visitorDebugURL 可视化地址
 */
+ (void)setVisitorDebugURL:(NSString *)visitorDebugURL;


/**
 设置自定义可视化埋点配置下发地址
 
 - configURL 格式：http://host:port 或 https://host:port 如：https://arkpaastest.analysys.cn:8089

 @param configURL 事件配置地址
 */
+ (void)setVisitorConfigURL:(NSString *)configURL;


/**
 当前SDK版本信息

 @return 版本号
 */
+ (NSString *)SDKVersion;


/**
 当前使用的debug模式

 @return debug模式
 */
+ (AnalysysDebugMode)debugMode;

+ (void)setDebugMode:(AnalysysDebugMode)debugMode;


/**
 数据上传时间间隔，单位：秒.
 仅AnalysysDebugOff模式或非WiFi环境下生效

 @param flushInterval 时间间隔(>=1)
 */
+ (void)setIntervalTime:(NSInteger)flushInterval;


/**
 数据累积"size"条数后触发上传.
 仅AnalysysDebugOff模式或非WiFi环境下生效
 
 @param size 数据条数(>=1)
 */
+ (void)setMaxEventSize:(NSInteger)size;


/**
 设置本地最多缓存数据条数.
 默认10000条，超过此数据默认清理最早的100条数据。

 @param size 最多缓存条数
 */
+ (void)setMaxCacheSize:(NSInteger)size;

+ (NSInteger)maxCacheSize;


/**
 上传数据
 
 - 若无数据则不触发上传
 - 若存在策略延迟，不会触发上传
 */
+ (void)flush;


#pragma mark *** 通用属性 ***

/**
 注册通用属性
 此属性中值将在所有触发事件都会携带

 约束信息：
 - 属性名称：以字母或`$`开头,可包含大小写字母、数字、`_`、`$`,最大长度125字符,不支持乱码和中文
 - 属性值：类型必须为以下类型：NSString/NSNumber/NSArray/NSDictionary/NSDate
 - 当用户自定义的Properties，superProperties和SDK自动采集的设备Properties具有相同key时，优先级如下：
     Properties > superProperties > devProperties
 - 当此接口多次调用时，具有相同key的value将被覆盖，不同key的value将会merge，例如：
    第一次设置为：{@"key1":@"1",@"key2":@"2"}
    第二次设置为：{@"key1":@"abc",@"key3":@"efd"}
    则merge后结果为：{@"key1":@"abc",@"key2":@"2",@"key3":@"efd"}
 - SDK将此结果保存，每次数据上传都会携带上传。
 
 @param superProperties 传入需要merge到通用属性的字典信息
 */
+ (void)registerSuperProperties:(NSDictionary *)superProperties;


/**
 单独添加某个通用属性
 
 - value类型必须为以下类型：NSString/NSNumber/NSArray/NSDate。
 
 @param superPropertyName key值
 @param superPropertyValue value对象
 */
+ (void)registerSuperProperty:(NSString *)superPropertyName value:(id)superPropertyValue;


/**
 删除通用属性中某个属性值

 @param superPropertyName 属性key
 */
+ (void)unRegisterSuperProperty:(NSString *)superPropertyName;


/**
 清除所有通用属性
 */
+ (void)clearSuperProperties;


/**
 当前已设置的通用属性

 @return 通用属性副本
 */
+ (NSDictionary *)getSuperProperties;


/**
 根据key获取某个通用属性

 @param superPropertyName key值
 @return key对应的通用属性值
 */
+ (id)getSuperProperty:(NSString *)superPropertyName;


#pragma mark *** 页面自动采集 ***

/**
 设置是否允许页面自动跟踪
 
 - SDK默认自动追踪页面切换功能，可通过该接口设置是否允许页面自动跟踪

 @param isAuto 开关值,默认为YES打开,设置NO为关闭
 */
+ (void)setAutomaticCollection:(BOOL)isAuto;


/**
 当前SDK是否允许页面自动跟踪

 @return 开关状态
 */
+ (BOOL)isViewAutoTrack;


/**
 忽略部分页面自动采集
 
 - 仅在已设置为autoTrack模式下生效

 @param controllers UIViewController类名字符串数组
 */
+ (void)setIgnoredAutomaticCollectionControllers:(NSArray<NSString *> *)controllers;


#pragma mark *** 事件跟踪 ***

/**
 添加事件
 
 @param event 事件标识，必须以字母或'$'开头，只能包含：大小写字母、数字、下划线和'$'，最大长度是99字符
 */
+ (void)track:(NSString *)event;


/**
 添加事件及附加属性

 @param event 事件标识，必须以字母或'$'开头，只能包含：大小写字母、数字、下划线和'$'，最大长度是99字符
 @param properties 自定义参数，允许添加以下类型：NSString/NSNumber/NSArray/NSSet/NSDate/NSURL；且key为字符串，以字母或'$'开头，只能包含：大小写字母、数字、下划线和'$'，最大长度是125字符
 */
+ (void)track:(NSString *)event properties:(NSDictionary *)properties;


/**
 页面跟踪
 默认SDK跟踪所有页面，无需设置。
 
 @param pageName 页面标识，最大长度是255字符
 */
+ (void)pageView:(NSString *)pageName;


/**
 页面跟踪及附加属性

 @param pageName 页面标识，最大长度是255字符
 @param properties 自定义参数，允许添加以下类型：NSString/NSNumber/NSArray/NSSet/NSDate/NSURL；且key为字符串，以字母或'$'开头，只能包含：大小写字母、数字、下划线和'$'，最大长度是125字符
 */
+ (void)pageView:(NSString *)pageName properties:(NSDictionary *)properties;


#pragma mark *** 身份关联 ***

/**
 身份关联，长度大于0且小于255字符

 @param aliasId 新distinctID替换原有originalId
 @param originalId 原始id。该变量将会映射到aliasId，即：后续id是aliasId
        如果变量为空，则使用本地distinctId(来源于identify:)
 */
+ (void)alias:(NSString *)aliasId originalId:(NSString *)originalId;


/**
 设置distinctId，长度大于0且小于255字符

 @param distinctId 标识
 */
+ (void)identify:(NSString *)distinctId;


/**
 清除本地设置的distinctID、aliasID、superProperties
 */
+ (void)reset;


#pragma mark *** profile设置 ***

/**
 profile字典若无特殊说明，具有以下约束：

 - 字典key为字符串，以字母或'$'开头，只能包含：大小写字母、数字、下划线和'$'，最大长度是125字符
 - 允许添加value类型为非自定义对象类型，通常为 NSString/NSNumber/NSArray/NSDate
 - 属性字典中最多允许100个键值对
 */

/**
 直接设置用户的一个或者几个Profiles
 
 - 如果某个Profile之前已经存在了，则这次会被覆盖掉；不存在，则会创建
 
 @param property 用户信息
 */
+ (void)profileSet:(NSDictionary *)property;


/**
 设置用户的单个Profile的内容
 
 - 如果这个Profile之前已经存在了，则这次会被覆盖掉；不存在，则会创建
 
 @param propertyName Profile的名称
 @param propertyValue Profile的内容
 */
+ (void)profileSet:(NSString *)propertyName propertyValue:(id)propertyValue;


/**
 首次设置用户的一个或者几个Profiles
 
 - 与set接口不同的是，如果该用户的某个Profile之前已经存在了，会被忽略；不存在，则会创建
 
 @param property Profile的内容
 */
+ (void)profileSetOnce:(NSDictionary *)property;


/**
 首次设置用户的单个Profile的内容
 
 - 与set类接口不同的是，如果这个Profile之前已经存在了，则这次会被忽略；不存在，则会创建
 
 @param propertyName Profile名称
 @param propertyValue Profile内容
 */
+ (void)profileSetOnce:(NSString *)propertyName propertyValue:(id)propertyValue;


/**
 删除某个Profile key对应的全部内容
 
 - 如果这个Profile之前不存在，则直接忽略

 @param propertyName Profile名称
 */
+ (void)profileUnset:(NSString *)propertyName;


/**
 给一个数值类型的Profile增加一个数值
 
 - 只能对NSNumber类型的Profile调用这个接口，否则会被忽略
 - 如果这个Profile之前不存在，则初始值当做0来处理

 @param propertyName 待增加数值的Profile的名称
 @param propertyValue 要增加的数值
 */
+ (void)profileIncrement:(NSString *)propertyName propertyValue:(NSNumber *)propertyValue;


/**
 给多个数值类型的Profile增加数值
 
 - profileDict中，key是NSString类型，value是NSNumber类型

 @param property 多个profile
 */
+ (void)profileIncrement:(NSDictionary *)property;


/**
 向prifile中追加属性

 - 如果某个Profile之前已经存在了，则这次会被覆盖掉；不存在，则会创建
 
 @param property 属性字典
 */
+ (void)profileAppend:(NSDictionary *)property;


/**
 根据(k,v)向prifile中追加属性

 @param propertyName profile名称
 @param propertyValue profile值
 */
+ (void)profileAppend:(NSString *)propertyName value:(id)propertyValue;


/**
 向一个NSSet类型的value添加一些值
 
 - 这个NSSet的元素必须是NSString类型，否则，会忽略
 - 如果要append的Profile之前不存在，会初始化一个空的NSSet

 @param propertyName propertyName
 @param propertyValue propertyValue
 */
+ (void)profileAppend:(NSString *)propertyName propertyValue:(NSSet *)propertyValue;


/**
 删除当前profile所有记录
 */
+ (void)profileDelete;


#pragma mark *** 活动推送效果 ***

/**
 设置推送平台及第三方推送标识

 @param provider 推送提供方标识，目前只 AnalysysPushProvider 枚举中的类型
 @param pushID 第三方推送标识。如：极光的registrationID，个推的clientId，百度的channelid，小米的xmRegId
 */
+ (void)setPushProvider:(AnalysysPushProvider)provider pushID:(NSString *)pushID;


/**
 追踪活动推广
 
 - 将推送回调的userInfo字典回传（如：极光推送），或jsonStr（如：个推的payloadMsg字符串）
 - iOS10之后的接口：(UNNotificationResponse)response.notification.request.content.userInfo和(UNNotification)notification.request.content.userInfo

 若为点击活动通知：共包含以下四种行为：
 - 跳转应用指定页面：若使用UITabBarController、UINavigationController及其子类作为window.rootViewController的应用，则调用pushViewController:方法到相应页面；若使用UIViewController及其子类时，则调用presentViewController:方式模态推出，需用户在推出页面中添加取消按钮，并调用dismissViewControllerAnimated:方法返回页面。
 - 打开链接：>=iOS 9.0应用内浏览链接；否则使用浏览器打开链接；
 - 打开应用：仅调起应用；
 - 自定义行为：将自定义参数返回开发者
 
 @param userInfo 推送携带的参数信息
 @param isClick YES：用户点击通知  NO：接收到消息通知
 */
+ (void)trackCampaign:(id)userInfo isClick:(BOOL)isClick;


/**
 追踪活动推广，可回调用户自定义信息
 
 参考 trackCampaign:isClick: 方法
 
 @param userInfo 推送携带的参数信息
 @param isClick YES：用户点击通知  NO：接收到消息通知
 @param userCallback 将解析后的用户下发活动信息回调用户
 */
+ (void)trackCampaign:(id)userInfo isClick:(BOOL)isClick userCallback:(void(^)(id campaignInfo))userCallback;


#pragma mark *** Hybrid 页面 ***

/**
 对UIWebView和WKWebView进行统计

 @param request 请求对象
 @param webView UIWebView/WKWebView对象
 @return 统计是否完成
 */
+ (BOOL)trackHybridRequest:(NSURLRequest *)request webView:(id)webView;




@end



