//
//  EEWKWebViewProxyDelegate.m
//  Easy Embedded WebKit WebView
//
//  Created by 腹黒い茶 on 28/1/2016.
//  Copyright (c) 2016 Haraguroicha. All rights reserved.
//

#import "EEWKWebViewProxyDelegate.h"
#import <objc/runtime.h>

@interface EEWKWebViewProxyDelegate()

@property (nonatomic, readwrite) NSUInteger totalResources;

@end

@implementation EEWKWebViewProxyDelegate

@synthesize javascriptInterfaces;
@synthesize INJECT_JS;
@synthesize webView;

- (instancetype)initWithWebView:(id)_webView {
    self = [super init];
    if (self) {
        self.webView = _webView;
        self.totalResources = 0;
        NSString *injectFile = [[NSBundle bundleWithIdentifier:EEWK_FR_PB_ID] pathForResource:EEWK_JS_INJECT_FILENAME
                                                                                       ofType:@"js"];
        NSError *error = nil;
        NSString *injectTemplate = [[NSString alloc] initWithContentsOfFile:injectFile
                                                                   encoding:NSUTF8StringEncoding
                                                                      error:&error];
        self.INJECT_JS = [injectTemplate stringByReplacingOccurrencesOfString:EEWK_JS_INJECT_FUNCTIONTEMPLATE
                                                                   withString:EEWK_JS_INJECT_FUNCTIONNAME
                                                                      options:0
                                                                        range:NSMakeRange(0, [injectTemplate length])];
    }
    return self;
}

- (void)addJavascriptInterfaces:(NSObject *)interface WithName:(NSString *)name{
	if (!self.javascriptInterfaces) {
		self.javascriptInterfaces = [[NSMutableDictionary alloc] init];
	}
	
	[self.javascriptInterfaces setValue:interface forKey:name];
}

- (void)webView:(WKWebView *)_webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(WKWebView *)_webView didFinishNavigation:(WKNavigation *)navigation {
	if (!self.javascriptInterfaces) {
		self.javascriptInterfaces = [[NSMutableDictionary alloc] init];
	}
	
	NSMutableString *injection = [[NSMutableString alloc] init];
	NSMutableString *initialize = [[NSMutableString alloc] init];
    
	//inject the javascript interface
	for(id key in self.javascriptInterfaces) {
		NSObject *interface = [self.javascriptInterfaces objectForKey:key];
        [initialize appendFormat:@"if (%@.initialize != undefined) { %@.initialize(); }", key, key];
        [injection appendFormat:@"%@.inject(\"%@\", [", EEWK_JS_INJECT_FUNCTIONNAME, key];
		unsigned int mc = 0;
		Class cls = object_getClass(interface);
		Method *mlist = class_copyMethodList(cls, &mc);
		for (int i = 0; i < mc; i++){
			[injection appendFormat:@"\"%@\"", [NSString stringWithUTF8String:sel_getName(method_getName(mlist[i]))]];
			if (i != mc - 1){
				[injection appendString:@", "];
			}
		}
        mlist = nil;
        cls = nil;
		[injection appendString:@"]);"];
    }
	// inject the basic functions first
	[_webView evaluateJavaScript:self.INJECT_JS completionHandler:nil];
	// inject the function interface
	[_webView evaluateJavaScript:injection completionHandler:nil];
    // initialize injected code
    [_webView evaluateJavaScript:initialize completionHandler:nil];
    self.totalResources++;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(WKWebView *)_webView didCommitNavigation:(WKNavigation *)navigation {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webView:(WKWebView *)_webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)_webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler {
    if (challenge.previousFailureCount == 0) {
        NSURLCredentialPersistence persistence = NSURLCredentialPersistenceForSession;
        NSURLCredential *credential = [NSURLCredential credentialWithUser:[_webView username]
                                                                 password:[_webView password]
                                                              persistence:persistence];
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        //NSLog(@"%@ > %@:%@", [_webView URL], [_webView username], [_webView password]);
    } else {
        NSLog(@"%s: challenge.error = %@", __FUNCTION__, challenge.error);
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    }
}

@end
