//
//  QYOperationFile.m
//  二手房-02
//
//  Created by qingyun on 15/10/18.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "QYOperationFile.h"

@implementation QYOperationFile
//沙盒路径
+ (NSString *)getPath
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    return path;
}
//创建文件夹
+ (NSString *)CreatDirectory:(NSString *)directoryName
{
    NSString *direPath = [[self getPath] stringByAppendingPathComponent:directoryName];
    if ([[NSFileManager defaultManager] createDirectoryAtPath:direPath withIntermediateDirectories:YES attributes:nil error:nil]) {
        return direPath;
    }
    return nil;
}
+ (BOOL)saveArrFile:(NSString *)fileName directory:(NSString *)directory fileObjc:(NSMutableArray *)file
{
    NSString *path = [[self CreatDirectory:directory] stringByAppendingPathComponent:fileName];
    NSLog(@"+++++++++%@",path);
    if (![file writeToFile:path atomically:YES]) {
        NSLog(@"==========失败");
        return NO;
    }
    return YES;
}
+ (NSString *)getFilePath:(NSString *)fileName directory:(NSString *)directory
{
    NSString *path = [[self CreatDirectory:directory] stringByAppendingPathComponent:fileName];
    return path;
}
+ (BOOL)saveFile:(NSString *)fileName directory:(NSString *)directory fileObjc:(NSData *)file
{
    NSString *path = [[self CreatDirectory:directory] stringByAppendingPathComponent:fileName];
    return [file writeToFile:path atomically:YES];
}
+ (NSData *)getFile:(NSString *)fileName directory:(NSString *)directory
{
    //文件路径
    NSString *path = [[self CreatDirectory:directory] stringByAppendingPathComponent:fileName];
    return [[NSData alloc] initWithContentsOfFile:path];
}
@end
