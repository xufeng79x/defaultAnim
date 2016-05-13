//
//  ViewController.m
//  TestCoreAnim
//
//  Created by apple on 16/5/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CALayer *mySampleLayer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 测试简单动画
    //[self testSampleAnimation];
    
    //UIView的动画机制
    //[self testUIViewAnimation];
    
    //[self changeLayerAction];
    
    // 呈现图层控制
    [self testPresentLayer];
}

#pragma 呈现图层
- (void) testPresentLayer
{
    //create a red layer
    mySampleLayer = [CALayer layer];
    mySampleLayer.frame = CGRectMake(0, 0, 100, 100);
    mySampleLayer.position = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    mySampleLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:mySampleLayer];
}

-(void)testPresentLayerTouch:(NSSet<UITouch *> *)touches
{
    //get the touch point
    CGPoint point = [[touches anyObject] locationInView:self.view];
    //check if we've tapped the moving layer
    if ([mySampleLayer.presentationLayer hitTest:point]) {
        //randomize the layer background color
        CGFloat red = arc4random() / (CGFloat)INT_MAX;
        CGFloat green = arc4random() / (CGFloat)INT_MAX;
        CGFloat blue = arc4random() / (CGFloat)INT_MAX;
        mySampleLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
        
    } else {
        
        //otherwise (slowly) move the layer to new position
        [CATransaction begin];
        [CATransaction setAnimationDuration:4.0];
        mySampleLayer.position = point;
        [CATransaction commit];
    }
}

#pragma 改变图层行为
-(void) changeLayerAction
{
    //create sublayer
    mySampleLayer = [CALayer layer];
    mySampleLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    mySampleLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    //add a custom action
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    mySampleLayer.actions = @{@"backgroundColor": transition};
    
    //add it to our view
    [self.view.layer addSublayer:mySampleLayer];
}

-(void) changeLayerActionTouch
{
    mySampleLayer.backgroundColor = [UIColor blackColor].CGColor;
}

#pragma UIView的动画机制
-(void) testUIViewAnimation
{
    UIView *myView = [[UIView alloc]init];
    NSLog(@"outer: %@", [myView actionForLayer:myView.layer forKey:@"backgroundColor"]);
    
    [UIView animateWithDuration:2.0 animations:^{
        NSLog(@"inner: %@", [myView actionForLayer:myView.layer forKey:@"backgroundColor"]);
    }];
}

#pragma 测试简单动画
-(void)testSampleAnimation
{
    
    mySampleLayer = [CALayer layer];
    mySampleLayer.backgroundColor = [UIColor blackColor].CGColor;
    mySampleLayer.frame = CGRectMake(50, 50, 150, 150);
    [self.view.layer addSublayer:mySampleLayer];
}
- (void)testSampleAnimationTouch
{
    // 动画开始
    [CATransaction begin];
    
    // 动画将持续2秒
    [CATransaction setAnimationDuration:2.0];
    
    // 事务完成块
    [CATransaction setCompletionBlock:^{
        CGAffineTransform transform = mySampleLayer.affineTransform;
        transform = CGAffineTransformRotate(transform, M_PI_2);
        mySampleLayer.affineTransform = transform;
    }];
    
    // 动画效果代码
    mySampleLayer.backgroundColor = [UIColor redColor].CGColor;
    
    // 动画提交
    [CATransaction commit];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //[self testSampleAnimationTouch];
    
    // 改变图层行为
    //[self changeLayerActionTouch];
    
    // 呈现图层
    [self testPresentLayerTouch:touches];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
