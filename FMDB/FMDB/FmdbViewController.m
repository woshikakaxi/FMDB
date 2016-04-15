//
//  FmdbViewController.m
//  FMDB
//
//  Created by 杨超 on 16/3/21.
//  Copyright © 2016年 王晓东. All rights reserved.
//

#import "FmdbViewController.h"
#import "MangerFmdb.h"
#import "UserModel.h"

@interface FmdbViewController ()
@property (nonatomic,strong) UIButton *searchBtn;
@end

@implementation FmdbViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MangerFmdb *fmdb = [[MangerFmdb alloc]init];
    [fmdb creatTableName:nil];
    
    for (int i = 500; i <  600; i++) {
        UserModel *model = [[UserModel alloc]init];
        model.page = [NSString stringWithFormat:@"%d",i-100];
        model.dictornary = @{@"001":@"晓东",
                             @"002":@"肖伟",
                             @"003":@"文斌",
                             };
        model.Userid = [NSString stringWithFormat:@"%d",i+100];
        [fmdb insertSqlData:model];
        
    }
    NSMutableArray *dataSource = [[NSMutableArray alloc]init];
    dataSource =  [[fmdb checkMysqlData:nil]copy];
    NSLog(@"查看当前datasource的数量%d",dataSource.count);
//    fmdb insertSqlData:
    
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
