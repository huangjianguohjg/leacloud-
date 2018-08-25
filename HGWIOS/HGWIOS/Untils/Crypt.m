//
//  Crypt.m
//  haoyunhl
//
//  Created by lianghy on 16/1/30.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import "Crypt.h"
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"
@implementation Crypt

/*字符串加密
 *参数
 *plainText : 加密明文
 *key        : 密钥 64位
 */
- (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key
{
    NSString *ciphertext = nil;
    NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[dataLength*10];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String], kCCKeySizeDES,
                                          nil,
                                          [textData bytes], dataLength,
                                          buffer, dataLength*10,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        
        ciphertext = [[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
    }
    return ciphertext;
}

 -(NSString *) parseByte2HexString:(Byte *) bytes
 {
         NSMutableString *hexStr = [[NSMutableString alloc]init];
         int i = 0;
         if(bytes)
           {
                while (bytes[i] != '\0')
                         {
                                 NSString *hexByte = [NSString stringWithFormat:@"%x",bytes[i] & 0xff];///1制数
                                if([hexByte length]==1)
                                         [hexStr appendFormat:@"0%@", hexByte];
                                else
                                        [hexStr appendFormat:@"%@", hexByte];
                             
                               i++;
                            }
                }
        NSLog(@"bytes 的16进制数为:%@",hexStr);
        return hexStr;
    }

-(NSString *) parseByteArray2HexString:(Byte[]) bytes
{
    NSMutableString *hexStr = [[NSMutableString alloc]init];
    int i = 0;
    if(bytes)
    {
        while (bytes[i] != '\0')
        {
            NSString *hexByte = [NSString stringWithFormat:@"%x",bytes[i] & 0xff];///16进制数
            if([hexByte length]==1)
                [hexStr appendFormat:@"0%@", hexByte];
            else
                [hexStr appendFormat:@"%@", hexByte];
            
            i++;
        }
    }
    NSLog(@"bytes 的16进制数为:%@",hexStr);
    return hexStr;
}

@end
