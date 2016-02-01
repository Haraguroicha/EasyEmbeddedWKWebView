//
//  EEWKDataFunction.h
//  Easy Embedded WebKit WebView
//
//  Created by 腹黒い茶 on 28/1/2016.
//  Copyright (c) 2016 Haraguroicha. All rights reserved.
//

@import Foundation;

@class EEWKWebView;

@interface EEWKDataFunction : NSObject

@property (nonatomic, retain) NSString *funcID;
@property (nonatomic, retain) EEWKWebView *webView;
@property (nonatomic, assign) BOOL removeAfterExecute;
@property (nonatomic, strong) void(^callbackAfterExecuteAction)(void);

- (id)initWithWebView:(EEWKWebView *)_webView;

- (NSString *)execute;
- (NSString *)executeWithParam:(NSString *)param;
- (NSString *)executeWithParams:(NSArray *)params;

@end
