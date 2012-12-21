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

}

-(void)progressArray:(NSMutableArray *)array Obj:(id)obj{

    NSNumber *number=(NSNumber *)obj;
    NSLog(@"objcet=%@ ",number);
    number=[NSNumber numberWithInt:[number intValue]+10];
    NSLog(@"number=%@ ",number);
    int index=[array indexOfObject:obj];
    [array setObject:number atIndexedSubscript:index];
    sleep(3);
    NSLog(@"finish %d",index);
}
-(void)gcdCount1{
    NSLog(@"gcd_group_async");
    __block NSDate* tmpStartData = [[NSDate date] retain];
    NSMutableArray *gcdtestArray=[NSMutableArray arrayWithObjects:@(1),@(2),@(3),@(4),@(5),@(6), nil];
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group=dispatch_group_create();
    for (id obj in gcdtestArray) {
        dispatch_group_async(group, queue, ^{
            //gcd not crash!!
            [self progressArray:gcdtestArray Obj:obj];
        });
    }
    dispatch_group_notify(group, queue, ^{
//        NSLog(@"%@",gcdtestArray);
        double deltaTime = [[NSDate date] timeIntervalSinceDate:tmpStartData];
        NSLog(@">>>>>>>>>>cost time in block = %f", deltaTime);
    });
    dispatch_release(group);
    double deltaTime = [[NSDate date] timeIntervalSinceDate:tmpStartData];
    NSLog(@">>>>>>>>>>cost time = %f", deltaTime);
}
-(void)gcdCount2{
    NSLog(@"gcd_apply_sync");
    __block NSDate* tmpStartData = [[NSDate date] retain];
    NSMutableArray *gcdtestArray=[NSMutableArray arrayWithObjects:@(1),@(2),@(3),@(4),@(5),@(6), nil];
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply([gcdtestArray count], queue, ^(size_t index) {
        [self progressArray:gcdtestArray Obj:[gcdtestArray objectAtIndex:index]];
    });
//    NSLog(@"%@",gcdtestArray);
    
    double deltaTime = [[NSDate date] timeIntervalSinceDate:tmpStartData];
    NSLog(@">>>>>>>>>>cost time = %f", deltaTime);
}
-(void)gcdCount3{
    NSLog(@"gcd_apply_async");
    __block NSDate* tmpStartData = [[NSDate date] retain];
    NSMutableArray *gcdtestArray=[NSMutableArray arrayWithObjects:@(1),@(2),@(3),@(4),@(5),@(6), nil];
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        dispatch_apply([gcdtestArray count], queue, ^(size_t index) {
            [self progressArray:gcdtestArray Obj:[gcdtestArray objectAtIndex:index]];
        });
//        NSLog(@"%@",gcdtestArray);
        double deltaTime = [[NSDate date] timeIntervalSinceDate:tmpStartData];
        NSLog(@">>>>>>>>>>cost time = %f", deltaTime);
    });
    
    
  
}
-(void)normalLoop{
    __block NSDate* tmpStartData = [[NSDate date] retain];
    NSMutableArray *gcdtestArray=[[NSMutableArray alloc] initWithArray:@[@(1),@(2),@(3),@(4),@(5),@(6)]];
      //normal loop crash!!!!!!!!!!!!!!!!!!! compare with gcd
    //    for (id obj in gcdtestArray) {
//        [self progressArray:gcdtestArray Obj:obj];
//    }
    //no crash
    for (int i=0; i<[gcdtestArray count]; i++) {
        [self progressArray:gcdtestArray Obj:[gcdtestArray objectAtIndex:i]];
    }
    double deltaTime = [[NSDate date] timeIntervalSinceDate:tmpStartData];
    [gcdtestArray release];
    NSLog(@">>>>>>>>>>cost time = %f", deltaTime);

    
    
    
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
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(20, 10, 150, 50)];
    [button addTarget:self action:@selector(gcdCount1) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"gcd_group_async" forState:UIControlStateNormal];
    [self.view addSubview:button];
    button=nil;
    button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(20, 70, 150, 50)];
    [button addTarget:self action:@selector(gcdCount2) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"gcd_apply_sync" forState:UIControlStateNormal];
    [self.view addSubview:button];
    button=nil;
    button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(20, 130, 150, 50)];
    [button addTarget:self action:@selector(gcdCount3) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"gcd_apply_async" forState:UIControlStateNormal];
    [self.view addSubview:button];
    button=nil;
    button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(20, 190, 150, 50)];
    [button addTarget:self action:@selector(normalLoop) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"loop" forState:UIControlStateNormal];
    [self.view addSubview:button];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(click)];

   
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
