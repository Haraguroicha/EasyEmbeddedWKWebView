//
//  EEWKWebView.h
//  Easy Embedded WebKit WebView
//
//  Created by 腹黒い茶 on 28/1/2016.
//  Copyright (c) 2016 Haraguroicha. All rights reserved.
//

@import UIKit;
@import WebKit;

@class EEWKWebView;

@interface WKWebView (EEWK_extends)

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;

- (void)_setCustomUserAgent:(NSString *)_customUserAgent;

@end

@interface EEWKWebView : WKWebView

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;

- (void)addJavascriptInterfaces:(NSObject *)interface WithName:(NSString *)name;

@end
