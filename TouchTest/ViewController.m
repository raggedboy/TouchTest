//
//  ViewController.m
//  TouchTest
//
//  Created by 浩杰 on 15/12/17.
//  Copyright © 2015年 Handsome Pan. All rights reserved.
//

#import "ViewController.h"
#import "HSImageView.h"

@interface ViewController ()
{
    UIImageView *_imageView;
    int _currentIndex;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
    self.navigationController.navigationBarHidden = NO;
    CGSize _size= [UIScreen mainScreen].bounds.size;
    
    _imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 100, _size.width, _size.height - 200)];
    _imageView.userInteractionEnabled = YES;
    _imageView.contentMode = UIViewContentModeScaleToFill;
    _imageView.image = [UIImage imageNamed:@"3.png"];
    [self.view addSubview:_imageView];
    [self showPhotoName];
    
    //[self initLayout];
    
    [self addGesture];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)showPhotoName
{
    NSString *photoName = [NSString stringWithFormat:@"%i.png",_currentIndex];
    [self setTitle:photoName];
}

- (void) addGesture
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tapGesture];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressImage:)];
    longPressGesture.minimumPressDuration = 0.5;
    [self.view addGestureRecognizer:longPressGesture];
    
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateImage:)];
    [self.view addGestureRecognizer:rotationGesture];
    
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchImage:)];
    [self.view addGestureRecognizer:pinchGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panImage:)];
    [_imageView addGestureRecognizer:panGesture];
    
    UISwipeGestureRecognizer *swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightImage:)];
    [self.view addGestureRecognizer:swipeRightGesture];
    
    UISwipeGestureRecognizer *swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftImage:)];
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeftGesture];
    
    [panGesture requireGestureRecognizerToFail:swipeLeftGesture];
    [panGesture requireGestureRecognizerToFail:swipeRightGesture];
    [longPressGesture requireGestureRecognizerToFail:panGesture];
}

- (void)swipeRightImage:(UISwipeGestureRecognizer *)gesture
{
    _currentIndex = (_currentIndex +3)%4;
    NSLog(@"%i",_currentIndex);
    NSString *imageName = [NSString stringWithFormat:@"%i.png",_currentIndex];
    NSLog(@"%@",imageName);
    _imageView.image = [UIImage imageNamed:imageName];
}

- (void)swipeLeftImage:(UISwipeGestureRecognizer *)gesture
{
    _currentIndex = (_currentIndex+5)%4;
    NSString *imageName = [NSString stringWithFormat:@"%i.png",_currentIndex];
    _imageView.image = [UIImage imageNamed:imageName];
}

- (void)panImage:(UIPanGestureRecognizer *)gesture
{
    NSLog(@"panGesture act");
    CGPoint translation = [gesture translationInView:self.view];
    if (gesture.state == UIGestureRecognizerStateChanged) {
        _imageView.transform = CGAffineTransformMakeTranslation(translation.x, translation.y);
    }
    else if(gesture.state == UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:5 animations:^{_imageView.transform = CGAffineTransformIdentity;}];
    }
}

- (void)rotateImage:(UIRotationGestureRecognizer *)gesture
{
    NSLog(@"rorate gesture act");
    if (gesture.state == UIGestureRecognizerStateChanged) {
        _imageView.transform = CGAffineTransformMakeRotation(gesture.rotation);
    }
    else if(gesture.state == UIGestureRecognizerStateEnded)
    {
        _imageView.transform = CGAffineTransformIdentity;
    }
}

- (void)pinchImage:(UIPinchGestureRecognizer *)gesture
{
    NSLog(@"pinch gesture act");
    if(gesture.state == UIGestureRecognizerStateChanged)
    {
        _imageView.transform = CGAffineTransformMakeScale(gesture.scale, gesture.scale);
    }
    else if(gesture.state == UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:0.5 animations:^{_imageView.transform = CGAffineTransformIdentity;}];
    }
}



- (void)longPressImage:(UILongPressGestureRecognizer *)gesture
{
    NSLog(@"longPressAct");
    if (gesture.state == UIGestureRecognizerStateBegan) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"hah you long press" message:@"do it" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"biu", nil];
        [alertView show];
    }
}

- (void) tapImage
{
    NSLog(@"befor aciton %i",self.navigationController.navigationBarHidden);
    BOOL hidden = !self.navigationController.navigationBarHidden;
    self.navigationController.navigationBarHidden=hidden;
    NSLog(@"tapImage response:%i",hidden);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint current = [touch locationInView:self.view];
    CGPoint previous = [touch previousLocationInView:self.view];
    CGPoint offset = CGPointMake(current.x - previous.x, current.y - previous.y);

   // if(CGRectContainsPoint(_imageView.frame, previous))
        _imageView.center = CGPointMake(_imageView.center.x + offset.x, _imageView.center.y + offset.y);
    NSLog(@"outside touch act");
}
*/ 

@end
