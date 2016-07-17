//
//  CPFMeFooterView.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/16.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFMeFooterView.h"
#import "CPFSquare.h"
#import "CPFSquareButton.h"
#import <UIButton+WebCache.h>
#import <UIButton+WebCache.h>

@implementation CPFMeFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self loadData];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
}

- (void)loadData {
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"square";
    params[@"c"] = @"topic";
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *squares = [CPFSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        [self creatSquareButtonFrom:squares];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)creatSquareButtonFrom:(NSArray *)squares {
    
    int maxCols = 4;
    CGFloat buttonW = CPFScreenW / maxCols;
    CGFloat buttonH = buttonW;
    for (int i = 0; i < squares.count; i++) {
        
        CPFSquareButton *button = [CPFSquareButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.square = squares[i];
        
        [self addSubview:button];
        
        int row = i / maxCols;
        int col = i % maxCols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
        self.height = CGRectGetMaxY(button.frame) + 200;
    }
    // 重绘
    [self setNeedsDisplay];
}

- (void)buttonClick:(CPFSquareButton *)button {
    CPFLogFunc;
}

@end
