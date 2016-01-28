//
//  EEWKWebView.m
//  Easy Embedded WebKit WebView
//
//  Created by 腹黒い茶 on 28/1/2016.
//  Copyright (c) 2016 Haraguroicha. All rights reserved.
//

#import "EEWKWebView.h"
#import "EEWKWebViewProxyDelegate.h"

@interface WKWebView ()

- (id)webView:(id)view identifierForInitialRequest:(id)initialRequest fromDataSource:(id)dataSource;
- (void)webView:(id)view resource:(id)resource didFinishLoadingFromDataSource:(id)dataSource;
- (void)webView:(id)view resource:(id)resource didFailLoadingWithError:(id)error fromDataSource:(id)dataSource;

@end

@implementation EEWKWebView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration {
    self = [super initWithFrame:frame configuration:configuration];
    if (self) {
    }
    return self;
}

- (id)init {
	self = [super init];
    if (self) {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self){
	}
	return self;
}

- (void)addJavascriptInterfaces:(NSObject *)interface WithName:(NSString *)name {
    id<WKNavigationDelegate> delegate = self.navigationDelegate;
    NSLog(@"%@, %d", [delegate class], [delegate isKindOfClass:[EEWKWebViewProxyDelegate class]]);
    if (delegate != nil && [delegate isKindOfClass:[EEWKWebViewProxyDelegate class]]) {
        EEWKWebViewProxyDelegate *proxyDelegate = (EEWKWebViewProxyDelegate *)delegate;
        [proxyDelegate addJavascriptInterfaces:interface WithName:name];
    }
}

@end
