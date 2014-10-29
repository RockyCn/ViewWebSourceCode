//
//  ViewController.m
//  Sour
//
//  Created by rocky on 10/29/14.
//  Copyright (c) 2014 rocky. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *webLink;
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftButton;

@property (nonatomic)UIAlertView *alertView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    NSString *currentUrl = @"baidu.com";
    [self loadRequestFromString:currentUrl];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadRequestFromString:(NSString*)urlString
{
    if (![urlString hasPrefix:@"http://"])
    {
        urlString = [[NSString alloc] initWithFormat:@"http://%@", urlString];
    }

    self.webLink.text = urlString;
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
}

- (IBAction)showBaseView:(id)sender
{
    if (self.baseView.isHidden)
    {
        [self.leftButton setTitle:@"Hide"];
        [self.baseView setHidden:NO];
    }
    else
    {
        [self.leftButton setTitle:@"Show"];
        [self.baseView setHidden:YES];
    }
    
}

- (IBAction)loadNewLink:(id)sender
{
    [self.view endEditing:YES];
    [self.baseView setHidden:YES];
    
    NSString *newLink = self.webLink.text;

    
    [self loadRequestFromString:newLink];
    
}

- (IBAction)copySource:(id)sender
{
    
    NSString *source = [self.webView stringByEvaluatingJavaScriptFromString:
                        @"document.getElementsByTagName('html')[0].outerHTML"];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    pasteboard.string = source;
    
    self.alertView = [[UIAlertView alloc] initWithTitle:@""
                                                message:@"Copied to clipboard."
                                               delegate:nil
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
    [self.alertView show];
    
    [self performSelector:@selector(hideAlertView)
               withObject:nil
               afterDelay:2];
}

- (void)hideAlertView
{
    [self.alertView dismissWithClickedButtonIndex:0
                                         animated:YES];
}
@end
