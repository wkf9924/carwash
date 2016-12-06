//
//  MySecret.m
//  Lessen_网络安全-加密
//
//  Created by zhilian on 16/4/18.
//  Copyright © 2016年 RCP. All rights reserved.
//

#import "SecretHelper.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation SecretHelper
//base64解密
+ (id)base64DecoderWithString:(NSString *)sourceString{
    if (!sourceString) {
        return nil;
    }
    //解密
    NSData *resultData = [[NSData alloc]initWithBase64EncodedString:sourceString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return resultData;
}
//base64加密
+ (NSString *)base64EncoderWithData:(NSData *)sourceData{
    //返回string
    if (!sourceData) { //如果需要加密的数据为nil, 不进行加密,直接返回
        return nil;
    }
    NSString *resultStr = [sourceData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return resultStr;
    
    //返回Data
    /*
    if (!sourceData) {
        NSData *resultData = [sourceData base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    return resultData;
    */
}



//MD5对string类型数据加密
+ (NSString *)md5String:(NSString *)sourceString{
    //第一步:由于MD5加密都是通过C级别的函数来计算, 所以需要将加密的字符串转换类型为C语言字符串
    const char *CStr = sourceString.UTF8String;
    
    //第二步:创建一个C语言的字符数组用来接收加密结束之后的字符
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    //第三步:计算MD5值(加密)
    //参数1:需要加密的字符串
    //参数2:需要加密的字符串的长度
    //参数3:加密完成之后的字符串存储的地方
    CC_MD5(CStr, (CC_LONG)strlen(CStr), result);
    
    //第四步:将加密完成的字符拼接起来(16进制);
    //声明一个可变字符串类型,用来拼接转换好的字符
    NSMutableString *resultStr = [[NSMutableString alloc ]init];
    //遍历result数组,取出所有字符串来拼接
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [resultStr appendFormat:@"%02X",result[i]];
    }
    //打印最终需要的字符
    NSLog(@"resultStr == %@",resultStr);
    return resultStr;
}
//MD5对Data类型数据的加密
+ (NSString *)md5Data:(NSData *)sourceDate{
    //第一步:需要MD5变量并且初始化
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    
    //第二步:开始MD5加密
    //参数1:对MD5变量取地址(要为该变量指向的内存空间存储计算好的数据)
    //参数2:需要计算的数据源
    //参数3:数据源的长度
    CC_MD5_Update(&md5, sourceDate.bytes, (CC_LONG)sourceDate.length);
    
    //第三步:声明一个无符号的字符数组, 用来存放转换好的数据
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    //第四步:将数据放入result
    CC_MD5_Final(result, &md5);
    
    //第五步:将result中的字符串拼接为OC语言中的字符串, 一遍我们使用.
    NSMutableString *resultString = [[NSMutableString alloc]init];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [resultString appendFormat:@"%02X",result[i]];
    }
    //打印最终需要的字符
    NSLog(@"resultString==%@",resultString);
    
    return resultString;
}

@end
