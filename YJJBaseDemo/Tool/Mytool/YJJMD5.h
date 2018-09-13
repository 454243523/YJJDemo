//
//  YJJMD5.h
//  QFDJ
//
//  Created by TingLi on 16/6/17.
//  Copyright © 2016年 com.hangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJJMD5 : NSObject
+ (NSString *)md5HexDigestString:(NSString*)string;
+ (NSString *)md5HexDigestString16:(NSString*)string;
+ (NSString *)dicHexDigestString:(NSString*)string;
@end
