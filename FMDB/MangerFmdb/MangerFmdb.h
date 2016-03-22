//
//  MangerFmdb.h
//  FMDB
//
//  Created by 杨超 on 16/3/21.
//  Copyright © 2016年 王晓东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MangerFmdb : NSObject

-(BOOL)creatTableName:(NSString *)tableName;
-(NSArray *)checkMysqlData:(NSString *)tabel;
-(void)searchUserid:(NSString *)userid;
-(void)insertSqlData:(id)data;
@end
