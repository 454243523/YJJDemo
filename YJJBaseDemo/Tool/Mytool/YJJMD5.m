//
//  YJJMD5.m
//  QFDJ
//
//  Created by TingLi on 16/6/17.
//  Copyright © 2016年 com.hangyang. All rights reserved.
//

#import "YJJMD5.h"
#import <CommonCrypto/CommonDigest.h>
@implementation YJJMD5
+ (NSString *)md5HexDigestString:(NSString*)string
{
    const char *original_str = [string UTF8String];
    unsigned char result[32];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02x", result[i]];
    return [hash lowercaseString];
}
+ (NSString *)md5HexDigestString16:(NSString*)string
{
    const char *original_str = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 8; i++)
        [hash appendFormat:@"%02x", result[i]];
    return [hash lowercaseString];
}
+ (NSString *)dicHexDigestString:(NSString*)string
{
    NSMutableArray *arr = [NSMutableArray array];
    NSString *dic = @"ntmso80TOLdAtOrH4MsaIBnZwKoxOQS9n7mlcqXSTrv17PtLVFGHgly5aBdyBgP69ZilUed2ND8GbuCCpzGicI0oQj5XfxQs6R2EhpURM1JTULuw6wZxe83DAJb0VYfrCEXKvqWjqp95YkvuhW1HfJ7KEeNiND3bMP2kg4SzR4jA3akmIyzFcYWVFh";
    for (int i = 0; i+5 <= string.length; i=i+5) {
        NSString *str = [string substringWithRange:NSMakeRange(i, 5)];
        [arr addObject:str];
    }
    [arr removeObjectAtIndex:0];
    
    NSString *result = @"";
    for (NSString *substr in arr) {
        char friststr = [substr characterAtIndex:0];
        NSInteger a = [[substr substringWithRange:NSMakeRange(2, 3)] integerValue];
        char path = [dic characterAtIndex:(a - 100)/3-1];
        result = [result stringByAppendingString:[NSString stringWithFormat:@"%c",((int)friststr * 2) - (int)path]];
//        NSLog(@"%c",((int)friststr * 2) - (int)path);
    }
   
    return result;
}
@end
