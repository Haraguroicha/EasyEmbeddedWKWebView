//
//  EEWKWebViewController.m
//  Easy Embedded WebKit WebView
//
//  Created by 腹黒い茶 on 28/1/2016.
//  Copyright (c) 2016 Haraguroicha. All rights reserved.
//

#import <EasyEmbeddedWKWebView/EEWKWebViewController.h>
#import <EasyEmbeddedWKWebView/EEWKWebView.h>

@interface EEWKWebViewController ()

@end

@implementation EEWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView = [[EEWKWebView alloc] initWithFrame:self.view.frame];
    [self setWebViewAutoresize];
}

- (void)setConfiguration:(WKWebViewConfiguration *)configuration {
    // clean up with replace old instance
    if (self.webView != nil) {
        self.webView = nil;
    }
    self.webView = [[EEWKWebView alloc] initWithFrame:self.view.frame
                                        configuration:configuration];
    [self setWebViewAutoresize];
}

- (void)setWebViewAutoresize {
    UIViewAutoresizing resizeMask = (UIViewAutoresizing)(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
    [self.webView setAutoresizingMask:resizeMask];
    self.view = self.webView;
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
