//
//  XLDBManager.m
//  XiaoliCoreDataDemo
//
//  Created by nnandzc on 15/11/10.
//  Copyright © 2015年 nnandzc. All rights reserved.
//

#import "XLDBManager.h"
#import "AppDelegate.h"
#import "z_Sandbox.h"
#import "Version.h"
#import <sqlite3.h>

static  NSString *createTB_info=@"create table if not exists t_info (c_key text primary key ,c_value text)";
static NSString *create_tusersql = @"CREATE TABLE IF NOT EXISTS T_User (userid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, username TEXT, usergender TEXT, usercreatetime date, userupdatetime date,age INTEGER,islogined INTEGER)";
static NSString * update_tusersql = @"alter table T_User  add  column useraddress TEXT";

static   NSString *modify=@"alter table T_User add column password text not null default '111111'";


@interface XLDBManager()
{
    sqlite3 *db;
}
@end

@implementation XLDBManager

HMSingletonM(XLDBManager)

#pragma mark 数据库版本管理
//-(NSString*)getDbpath{
//    return  [z_Sandbox documentPath:@"XiaoliCoreDataDemo.sqlite"];
//}


//-(BOOL)isExistDB{
//    
//    if ([z_Sandbox fileExists:[self getDbpath]]) {
//        return YES;
//    }else{
//        return NO;
//    }
//}
//
//-(instancetype)init{
//    if (self =[super init]) {
//        int dbVersion=1;
//        //1.判断本地有没有数据库文件
//        if(![self isExistDB]){
//            //2.不存在 进行数据库的创建
//            [self createDB];
//        }else{
//            
//            //若存在，检测数据库版本，则进行升级，
//            //获取数据库中的 版本表 存的版本信息
//            NSLog(@"--isExistDB---%zi",dbVersion);
//            
//            char* info=NULL;
//            [self getDBInfoValueWithKey:"db_version" value:&info];
//            
//            NSLog(@"--info--%s",info);
//            
//            if(info == NULL){
//                return self;
//            }
//            dbVersion= atoi(info);
//            free (info);
//            
//        }
//        NSLog(@"-dbVersion--%d",dbVersion);
//        
//        switch (dbVersion){
//            case 1:{
//                //            数据库表结构初始化
//                //1.创建 版本表
//                [self excutelocalSql:createTB_info];
////                [self addObject:@"Version" withBlock:^(id newObject) {
////                    Version *v = newObject;
////                    v.db_version = @1;
////                }];
//                
//                //2.创建 用户表
//                [self excutelocalSql:create_tusersql];
//                
//                //3. 保存1.0 +1.0 版本到数据库 (2.0)
//                
//                [self setDBInfoValueWithKey:[@"db_version" UTF8String] value:[@"2" UTF8String] ];
//            }
//                
//            case 2 :{
//                
//                [self excutelocalSql:update_tusersql];
//                //                保存2.0 +1.0 版本到数据库 (3.0)
//                [self setDBInfoValueWithKey:[@"db_version" UTF8String] value:[@"3" UTF8String] ];
//            }
//                
//            case 3:{
//                //增加 密码字段
//                [self excutelocalSql:modify];
//                //                保存3.0 +1.0 版本到数据库 (4.0)
//                [self setDBInfoValueWithKey:[@"db_version" UTF8String] value:[@"4" UTF8String] ];
//                
//            }
//                
//            default:
//                break;
//                
//        }
//        
//    }
//    return self;
//}
//
////创建数据库方法
//-(void)createDB{
//    
//    int reset=sqlite3_open([[self getDbpath] UTF8String], &db);
//    if (reset ==SQLITE_OK ) {
//        NSLog(@"数据库创建成功!");
//    }else{
//        
//    }
//    
//}
//
//-(BOOL)excutelocalSql:(NSString*) creteSql{
//    
//    char* err;
//    const char* sql = [creteSql UTF8String];//创建表语句
//    if (sql==NULL) {
//        return NO;
//    }
//    if (SQLITE_OK != sqlite3_open([[self getDbpath] UTF8String], &db)){
//        return NO;
//    }
//    
//    if (SQLITE_OK == sqlite3_exec(db, sql, NULL, NULL, &err)) {//执行创建表语句成功
//        sqlite3_close(db);
//        return YES;
//    }else{//创建表失败
//        return NO;
//    }
//    
//    
//    return NO;
//}
//
//
//#pragma mark  table t_info manage
//- (BOOL)setDBInfoValueWithKey:(const char*)key value:(const char*)value {
//    char* info=NULL;
//    [self getDBInfoValueWithKey:key value:&info];
//    if (info!= NULL) {
//        //存在，则更新
//        [self updateDBInfoValueWithKey:key value:value];
//    }else{
//        //不存在，插入
//        [self insertDBInfoValueWithKey:key value:value];
//        
//    }
//    free(info);
//    return YES;
//}
//
//- (void)getDBInfoValueWithKey:(const char*)key value:(char**)value{
//    //TODO
//    if (SQLITE_OK != sqlite3_open([[self getDbpath] UTF8String] , &db)){
//        printf("%s:%d query error..\n",__FUNCTION__,__LINE__);
//        return ;
//    }
//    const char* sql = "select * from t_info where c_key =?";//查询语句
//    sqlite3_stmt* stmt;
//    
//    
//    int error = sqlite3_prepare_v2(db, sql, -1, &stmt, nil);
//    if (error==SQLITE_OK) {//准备
//        sqlite3_bind_text(stmt, 1,key, -1, NULL);
//    }else{
//        printf("%s:%d query error.. %d\n",__FUNCTION__,__LINE__,error);
//        return;
//    }
//    
//    
//    if( SQLITE_ROW == sqlite3_step(stmt) ){//执行
//        char* v= (char*)sqlite3_column_text(stmt, 1);
//        *value = strdup(v);
//        
//    }
//    printf("query error.. %d .. \n",sqlite3_step(stmt));
//    
//    sqlite3_finalize(stmt);
//    sqlite3_close(db);
//}
//
//- (BOOL)insertDBInfoValueWithKey:(const char*)key value:(const char*)value{
//    int ret = 0;
//    if (SQLITE_OK != sqlite3_open([[self getDbpath] UTF8String], &db)){
//        return NO;
//    }
//    const char* sql = "insert into t_info(c_key,c_value) values(?,?);";
//    sqlite3_stmt* stmt;//
//    int result =sqlite3_prepare_v2(db, sql, -1, &stmt, nil);
//    printf("%s\n",sqlite3_errmsg(db));
//    if (result==SQLITE_OK) {//准备语句
//        sqlite3_bind_text(stmt, 1, key, -1, NULL);//绑定参数
//        sqlite3_bind_text(stmt, 2, value, -1, NULL);
//    }else{
//        return NO;
//    }
//    if (SQLITE_DONE == (ret = sqlite3_step(stmt))) {//执行查询
//        sqlite3_finalize(stmt);
//        sqlite3_close(db);
//        return YES;
//    }else{
//        return NO;
//    }
//}
//
//- (BOOL)updateDBInfoValueWithKey:(const char*)key value:(const char*)value{
//    int ret = 0;
//    if (SQLITE_OK != sqlite3_open([[self getDbpath] UTF8String], &db)){
//        return NO;
//    }
//    const char* sql = "update t_info set c_value = ? where c_key = ?;";
//    sqlite3_stmt* stmt;//
//    int result =sqlite3_prepare_v2(db, sql, -1, &stmt, nil);
//    printf("%s\n",sqlite3_errmsg(db));
//    if (result==SQLITE_OK) {//准备语句
//        sqlite3_bind_text(stmt, 1, value, -1, NULL);
//        sqlite3_bind_text(stmt, 2, key, -1, NULL);
//    }else{
//        return NO;
//    }
//    ret = sqlite3_step(stmt);
//    printf("ret:%d\n",ret);
//    if (SQLITE_DONE ==ret ) {//执行查询
//        sqlite3_finalize(stmt);
//        sqlite3_close(db);
//        return YES;
//    }else{
//        return NO;
//    }
//}


#pragma mark 数据库操作
-(void)addObject:(NSString *)ClassStr withBlock: (void (^)(id newObject)) setValue
{
    AppDelegate *appdelegate=  [UIApplication sharedApplication].delegate;
    id object = [NSEntityDescription insertNewObjectForEntityForName:ClassStr inManagedObjectContext:appdelegate.managedObjectContext];
    setValue(object);
    
    [appdelegate saveContext];
}

-(void)removeObject:(NSString *)ClassStr by:(NSPredicate *)predicate
{
    AppDelegate *appdelegate=  [UIApplication sharedApplication].delegate;
    
    NSArray *array=  [self searchClassList:ClassStr by:predicate];
    if(array.count == 0)
    {
        NSLog(@"表%@中已经没有数据了", ClassStr);
        return;
    }
    
    for(id obj in array)
    {
        [appdelegate.managedObjectContext deleteObject:obj];
    }
    [appdelegate saveContext];
}

-(id)searchClassList:(NSString *)ClassStr by:(NSPredicate *)predicate
{
    AppDelegate *appdelegate=  [UIApplication sharedApplication].delegate;
    NSFetchRequest * fetchreq =   [NSFetchRequest new];
    fetchreq.entity =  [NSEntityDescription entityForName:ClassStr inManagedObjectContext:appdelegate.managedObjectContext];
    NSArray *array=  [appdelegate.managedObjectContext executeFetchRequest:fetchreq error:nil];
    return [array filteredArrayUsingPredicate:predicate];
    return nil;
}

@end
