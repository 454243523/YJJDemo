//
//  BaseNetManager.m
//  BaseProject
//
//  Created by jiyingxin on 15/10/21.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"

static AFHTTPSessionManager *manager = nil;

@implementation BaseNetManager

+ (AFHTTPSessionManager *)sharedAFManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    });
    return manager;
}

+ (id)GET:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))complete{
    //打印网络请求， DDLog  与  NSLog 功能一样
    NSLog(@"Request Path: %@", [self percentPathWithPath:path params:params]);
    path = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    if (![BaseNetManager isWifi]) {
        complete(nil,nil);
        return nil;
    }
    //    if (params) {
    //        path = [BaseNetManager percentPathWithPath:path params:params];
    //        params = nil;
    //    }
   return [[self sharedAFManager] GET:path parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"data = %@",responseObject);
        complete(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleError:error];
         complete(nil, error);
    }];
}

+ (id)POST:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))complete{
    //修改User-Agent
//    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
//    NSString * agent = [NSString stringWithFormat:@"Vvvdj/2.0 ios%@",phoneVersion];
//    [[self sharedAFManager].requestSerializer setValue:agent forHTTPHeaderField:@"User-Agent"];
    NSLog(@"Request Path: %@, params %@", path, params);
    if (![BaseNetManager isWifi]) {
        return nil;
    }
    
    return [[self sharedAFManager] POST:path parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"Request Path: %@, params %@ ,data %@", path, params,responseObject);
        NSDictionary *dic = [responseObject mj_JSONObject];

        complete(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleError:error];
        complete(nil, error);
    }];
}

+(void)POSTData:(NSString *)path parameters:(NSDictionary *)parame completionHandler:(void (^)(id, NSError *))complete
{
    NSLog(@"request:%@%@",path,parame);
    NSData *bodyData = [parame mj_JSONData];
    NSMutableURLRequest *requestM1=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
    requestM1.HTTPBody=bodyData;
    requestM1.HTTPMethod=@"POST";
    //    NSData *responseData2=[NSURLConnection sendSynchronousRequest:requestM1 returningResponse:nil error:&error1];
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:requestM1 completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"datatask: %@",[responseObject mj_JSONObject]);
        if (error) {
            complete(nil,error);
        }else{
            complete(responseObject,nil);
        }
    }];
    [task resume];
}
//多图
+(void)POST:(NSString *)path parameters:(NSDictionary *)parame flile:(NSDictionary *)flile completionHandler:(void (^)(id, NSError *))complete
{
    [manager POST:path parameters:parame constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //
        //        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //        formatter.dateFormat = @"yyyyMMddHHmmss";
        //        NSString *str = [formatter stringFromDate:[NSDate date]];
        //        //上传的参数(上传图片，以文件流的格式)
        
        //        [formData appendPartWithFormData:data name:@"images_ids"];
        if (flile) {
            NSArray *keyarr = [flile allKeys];

            //默认传图片
            for (NSString *key in keyarr) {
                if ([flile[key] isKindOfClass:[NSArray class]]) {
                    NSArray *varr = flile[key];
                    for (UIImage *image in varr) {
                        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.3) name:key fileName:@"xxxx.png" mimeType:@"image/png"];
                    }

                }

            }
        }
        
//        [formData appendPartWithFormData:UIImageJPEGRepresentation([UIImage imageNamed:@"logo"], 0.5) name:@"images_ids.jpg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"photo = %@ %@",parame,responseObject);
        complete(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"photo err = %@",error);
        complete(nil,error);
    }];
}

+(BOOL)isWifi{
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager1 = [AFNetworkReachabilityManager sharedManager];
    if (!manager1.isReachableViaWiFi) {
        
    }
    return YES;
}


+ (NSString *)percentPathWithPath:(NSString *)path params:(NSDictionary *)params{
    NSMutableString *percentPath =[NSMutableString stringWithString:path];
    NSArray *keys = params.allKeys;
    NSInteger count = keys.count;
    for (int i = 0; i < count; i++) {
        if (i == 0) {
            [percentPath appendFormat:@"?%@=%@", keys[i], params[keys[i]]];
        }else{
            [percentPath appendFormat:@"&%@=%@", keys[i], params[keys[i]]];
        }
    }
    return [percentPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (void)handleError:(NSError *)error{
    NSLog(@"error :%@",error);
  
}

@end
