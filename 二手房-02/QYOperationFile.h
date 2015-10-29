//
//  QYOperationFile.h
//  二手房-02
//
//  Created by qingyun on 15/10/18.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYOperationFile : NSObject
+ (BOOL)saveArrFile:(NSString *)fileName directory:(NSString *)directory fileObjc:(NSMutableArray *)file;
+ (NSString *)getFilePath:(NSString *)fileName directory:(NSString *)directory;
/*保存文件
 *fileName 保存的文件名
 *directory 文件夹名称
 *file 存储文件对象
 */
+ (BOOL)saveFile:(NSString *)fileName directory:(NSString *)directory fileObjc:(NSData *)file;
+ (NSData *)getFile:(NSString *)fileName directory:(NSString *)directory;

@end
