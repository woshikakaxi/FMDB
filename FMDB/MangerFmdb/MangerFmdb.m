//
//  MangerFmdb.m
//  FMDB
//
//  Created by 杨超 on 16/3/21.
//  Copyright © 2016年 王晓东. All rights reserved.
//

#import "MangerFmdb.h"
#import "UserModel.h"
#import <FMDB/FMDatabase.h>
#ifdef DEBUG // 处于开发阶段
#define DebugLog(...) NSLog(__VA_ARGS__)
#define kScreen_Bounds [UIScreen mainScreen].bounds
#else // 处于发布阶段
#define DebugLog(...)
#endif
@implementation MangerFmdb{
    FMDatabase *fmdb;
}

-(id)init{
    if (self = [super init]) {
       /*创建数据库存储路径*/
        NSString * path = [NSHomeDirectory() stringByAppendingString:@"Documents/myApp.db"];
        fmdb = [[FMDatabase alloc]initWithPath:path];
        
        [fmdb open];
        
        if ([fmdb open]) {
             NSLog(@"数据库打开成功");
        }else{
             NSLog(@"数据库打开失败");
        }
        
    }
    return self;
}

-(BOOL)creatTableName:(NSString *)tableName{
    //数据库表的字段请自行添加
    
   NSString *sql =[NSString stringWithFormat:@"%@",@"create table if not exists UserInfo(ID integer primary key autoincrement,Userid                                                                  varchar(256),page varchar(512) ,dic blob)"];
    if ([fmdb executeUpdate:sql]) {
        return YES;
    }else{
        return false;
    }
}

//数据修改方法插入数据
-(void)insertSqlData:(id)data{
    UserModel *model = [[UserModel alloc]init];
    model = data;
    NSString *sql = @"insert into UserInfo(Userid,page,dic) values (?,?,?)";
   
    NSData *sqlData = [NSJSONSerialization dataWithJSONObject:model.dictornary options: NSJSONWritingPrettyPrinted error:nil];
   
    if ([fmdb executeUpdate:sql,model.Userid,model.page,sqlData]) {
        DebugLog(@"当前插入数据成功");
    }else{
        DebugLog(@"数据插入失败失败原因%@",fmdb.lastErrorMessage);
    }

}

-(NSArray *)checkMysqlData:(NSString *)tabel{
    NSString *sql = [NSString stringWithFormat:@"select * from UserInfo"];
    FMResultSet *result = [fmdb executeQuery:sql];
    //查询的是数据库的这张表的所有信息
    NSMutableArray * UserArray = [[NSMutableArray alloc]init];
    while ([result next]) {
        DebugLog(@"查看每条数据%@",result);
    //
        UserModel *model = [[UserModel alloc]init];
        model.Userid  = [result stringForColumn:@"Userid"];
        model.page = [result stringForColumn:@"page"];
        model.dictornary = [NSJSONSerialization JSONObjectWithData:[result dataForColumn:@"dic"] options: NSJSONReadingMutableContainers error:nil];
        [UserArray addObject:model];
        
    }
    
    return UserArray;
    

}
//判断是否插入过改用户的数据如果插入
-(void)searchUserid:(NSString *)userid{
    NSString *sql = @"select * from UserInfo where Userid = ?";
    NSString *UserID = userid;
    FMResultSet *result = [fmdb executeQuery:sql,UserID];
    while ([result next]) {
        if ([[result stringForColumn:@"Userid"]isEqualToString:userid]) {
            [self returnIsValidUserid:@"1"];
        }else{
            [self returnIsValidUserid:@"0"];
        }
        
    }
  
}
-(BOOL)returnIsValidUserid:(NSString *)value{
    if ([value isEqualToString:@"1"]) {
        return YES;
    }else{
        return NO;
    }
    
}
    
    
    
-(void)closeFmdb{
    if (fmdb) {
        [fmdb close];
        fmdb = nil;
    }
}
@end
