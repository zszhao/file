//
//  ViewController.m
//  二手房-02
//
//  Created by qingyun on 15/10/15.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "Header.h"
#import "QYModel.h"
#import "QYTableViewCell.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPRequestOperation.h"
#import "AFURLSessionManager.h"
#import "AFHTTPSessionManager.h"
#import "AFNetworkReachabilityManager.h"
#import "QYOperationFile.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSDictionary *tempDic;
@property (nonatomic,strong) NSMutableDictionary *taskDic;
@end

@implementation ViewController

- (void)viewDidLoad {
    _taskDic = [NSMutableDictionary dictionary];
    _dataArr = [NSMutableArray array];
    NSData *data = [NSData dataWithContentsOfFile:[QYOperationFile getFilePath:@"housedata" directory:FilePage]];
    if (data) {
        [self DataForMode:data];
    }
    [self post];
    [super viewDidLoad];
    [self tableView];
}
- (void)DataForMode:(NSData *)responseObjc
{

    //将数据通过系统的JSON解析，解析为字典
    _tempDic = [NSJSONSerialization JSONObjectWithData:responseObjc options:NSJSONReadingAllowFragments error:nil];
    //通过key值取到对应数据的value
    NSDictionary *dic1 = _tempDic[@"RESPONSE_BODY"][@"list"];
    //遍历字典，将数据装到字典
    for (NSDictionary *dic in dic1) {
        //将字典赋给模型model
        QYModel *model = [[QYModel alloc] initWithDictionary:dic];
        //将模型赋给数组
        [_dataArr addObject:model];
    }
}
- (void)post
{
    NSString *urlSTR = @"{\"commandcode\":108,\"REQUEST_BODY\":{\"city\":\"昆明\",\"desc\":\"0\" ,\"p\":1}}";
    //创建manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //修改AFNetwork接受的源代码格式
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //响应序列化
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置参数（前为key，后为value）
    NSDictionary *parameter = @{@"HEAD_INFO":urlSTR};
    //请求数据，并将数据解析
    [manager POST:baseURL parameters:parameter success:^(AFHTTPRequestOperation * operation, id responseObjc) {
        //请求到的数据为NSData
        NSLog(@"++++++++++%@",operation.response.URL.absoluteString);
        NSLog(@"----------%@",responseObjc);
        NSLog(@"----------%@",[[NSString alloc] initWithData:responseObjc encoding:NSUTF8StringEncoding]);
        if ([QYOperationFile saveFile:@"housedata" directory:FilePage fileObjc:responseObjc]) {
        }
        [self DataForMode:responseObjc];
        
        //刷新UI
        UITableView *tableView = (UITableView *)[self.view viewWithTag:10];
        [tableView reloadData];
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"==========%@",error);
        
    }];
}
- (void)tableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 140;
    tableView.tag = 10;
    [self.view addSubview:tableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"QYTableViewCell" owner:self options:nil].lastObject;
    }
    QYModel *model = _dataArr[indexPath.row];
    cell.temprownumber.text = [NSString stringWithFormat:@"%d",model.temprownumber];
    cell.housetype.text = model.housetype;
    cell.price.text = [NSString stringWithFormat:@"%d/月",model.price];
    cell.community.text = model.community;
    cell.simpleadd.text = model.simpleadd;
    cell.iconurl.image = [UIImage imageNamed:@"3.jpg"];
    //判断图片的名字字符串是否为空
    if (model.iconurl.length > 0) {
        NSString *imageName = [[[[model.iconurl componentsSeparatedByString:@"/"] lastObject] componentsSeparatedByString:@"."] firstObject];
        NSData *imageData = [QYOperationFile getFile:imageName directory:IMAGEPAGE];
        if (imageData) {
            cell.iconurl.image = [UIImage imageWithData:imageData];
        }else{
            NSString *task = _taskDic[indexPath];
            if (!task) {
                //拼接字符串，获得整体图片路径
                NSString *url = [NSString stringWithFormat:@"%@%@",baseImage,model.iconurl];
                //将路径和path值传到方法中
                [self addImageUrl:url forIndexPath:indexPath];
                [_taskDic setObject:@"1" forKey:indexPath];
             }
        }
        }
    return cell;
}
- (void)addImageUrl:(NSString *)url forIndexPath:(NSIndexPath *)path
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        if (data) {
            NSString *fileName = [[[[url componentsSeparatedByString:@"/"] lastObject] componentsSeparatedByString:@"."] firstObject];
            if (![QYOperationFile saveFile:fileName directory:IMAGEPAGE fileObjc:data]) {
                NSLog(@"++++++++++保存失败");
            }
            [_taskDic removeObjectForKey:path];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            UITableView *tableView = (UITableView *)[self.view viewWithTag:10];
            QYTableViewCell *cell = (QYTableViewCell *)[tableView cellForRowAtIndexPath:path];
            cell.iconurl.image = [UIImage imageWithData:data];
            
        });
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
