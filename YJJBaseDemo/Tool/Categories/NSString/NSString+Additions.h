//
//  NSString+Additions.h
//  Ting
//
//  Created by Aufree on 10/1/15.
//  Copyright © 2015 The EST Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)
+ (BOOL)isStringEmpty:(NSString *)string;
+ (NSNumber *)covertToNumber:(NSString *)numberString;
+ (NSString *)timestampString;
+ (NSString *)stringWithMD5OfFile:(NSString *) path;
- (NSString *)md5Hash;
+ (NSString *)randomStringWithLength:(int)len;
+ (NSString *)timeIntervalToMMSSFormat:(NSTimeInterval)interval;
//时间戳转正常格式
+ (NSString *)timeWithStr:(NSString *)time;
//获取当前时间
+(NSString*)getCurrentTime;
@end
