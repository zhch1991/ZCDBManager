//
//  XLDBManager.h
//  XiaoliCoreDataDemo
//
//  Created by nnandzc on 15/11/10.
//  Copyright © 2015年 nnandzc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCSingleton-ARC.h"

@interface XLDBManager : NSObject

HMSingletonH(XLDBManager)


/**
 *  添加
 *
 *  @param ClassStr 类名字符串（定位哪个表）
 *  @param setValue 新数据赋值块
 */
-(void)addObject:(NSString *)ClassStr withBlock: (void (^)(id newObject)) setValue;

/**
 *  删除
 *
 *  @param ClassStr  类名字符串（定位哪个表）
 *  @param predicate 谓词搜索条件
 */
-(void)removeObject:(NSString *)ClassStr by:(NSPredicate *)predicate;

/**
 *  查询
 *
 *  @param ClassStr  类名字符串（定位哪个表）
 *  @param predicate 谓词搜索条件
 *
 *  @return 搜索结果数组（注意是数组）
 */
-(id)searchClassList:(NSString *)ClassStr by:(NSPredicate *)predicate;

/**
 *  获取数据库路径
 *
 *  @return 数据库路径
 */
-(NSString*)getDbpath;

@end
