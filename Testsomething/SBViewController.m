//
//  SBViewController.m
//  Testsomething
//
//  Created by hu jinkang on 12-12-21.
//  Copyright (c) 2012年 hujinkang. All rights reserved.
//

#import "SBViewController.h"
#import "ASIHTTPRequest.h"
#import "SB2ViewController.h"
@interface SBViewController ()

@end

@implementation SBViewController
-(void)click{
    SB2ViewController *sb2=[[SB2ViewController alloc] init];
    [self.navigationController pushViewController:sb2 animated:YES];
    [sb2 release];
//    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
//    [request setCompletionBlock:^{
//        NSLog(@"%@",[request responseString]);
//    }];
//    [request setFailedBlock:^{
//        NSLog(@"%@",[request error]);
//    }];
//    [request startAsynchronous];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)loadView{
    [super loadView];
    NSLog(@"loadview");
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(50, 100, 100, 50)];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

	// Do any additional setup after loading the view.
}

-(void)viewDidUnload{
    [super viewDidUnload];
    NSLog(@"viewDidUnload");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"didReceiveMemoryWarning-viewdidunload");

    // Dispose of any resources that can be recreated.
}

@end
