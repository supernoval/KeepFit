//
//  CircleProgressView.m
//  CircularProgressControl
//
//  Created by Carlos Eduardo Arantes Ferreira on 22/11/14.
//  Copyright (c) 2014 Mobistart. All rights reserved.
//




#import "CircleProgressView.h"
#import "CircleShapeLayer.h"
@interface CircleProgressView()
{
    NSTimer *_animateTimer;
    
    CircleProgressViewAnimateState _animateState;
    
    
}
@property (nonatomic, strong) CircleShapeLayer *progressLayer;
@property (strong, nonatomic) UILabel *stepsLabel;
@property (nonatomic,strong) UILabel *stepTitleLabel;
@property (nonatomic,strong) UILabel *walkingDisLabel;


@end

@implementation CircleProgressView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)awakeFromNib {
    [self setupViews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.progressLayer.frame = self.bounds;
    self.progressLayer.progressColor = kCircleProgressViewColor;
    
//    [self.progressLabel sizeToFit];
//    self.progressLabel.center = CGPointMake(self.center.x - self.frame.origin.x, self.center.y- self.frame.origin.y);
    
   // [self.stepsLabel sizeToFit];
    _animateSteps = 0.0;
    _animateDistance = 0.0;
    _stepsLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 );
    _stepTitleLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - kLabelHeight *2);
    _walkingDisLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 + kLabelHeight*2 );
    _animateState = CircleProgressViewAnimateNone;
    
  
    
}

-(void)animateLabelProgress
{
   
   
    
    [self.progressLayer startAnimation];
    
    _animateTimer = [NSTimer scheduledTimerWithTimeInterval:kTimerschduleInterval target:self selector:@selector(updateStepsAndDistance) userInfo:nil repeats:YES];
    
     _animateState = CircleProgressViewAnimateStart;
}

-(void)updateStepsAndDistance
{
//    if (_animateState == CircleProgressViewAnimateStart)
    
    if (_animateSteps < self.currentSteps) {
        
    
        
        CGFloat averageSteps = self.currentSteps* kTimerschduleInterval;
        
        CGFloat averageDis =  self.currentDistance * kTimerschduleInterval;
        
        _animateSteps += averageSteps;
        
        _animateDistance +=averageDis;
        
     
        
        _stepsLabel.attributedText = [self getstepslabelString:_animateSteps];
        
        _walkingDisLabel.attributedText = [self getdistanceString:_animateDistance];
        
        
    
        
        //NSLog(@"animateStep:%.2f",_animateSteps);
        
    }
    

}
- (void)updateConstraints {
    [super updateConstraints];
}

-(UILabel*)stepsLabel
{
    if (!_stepsLabel) {
        
        _stepsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height/2 - kLabelHeight/2, self.frame.size.width, kLabelHeight)];
        _stepsLabel.numberOfLines = 1;
        _stepsLabel.textAlignment = NSTextAlignmentCenter;
        _stepsLabel.font = [UIFont fontWithName:kHelveticaNeue size:45];
        _stepsLabel.textColor = kTextColor;
        //_stepsLabel.backgroundColor = [UIColor yellowColor];
        
        [self addSubview:_stepsLabel];
        
        
    }
    
    return _stepsLabel;
    
}
-(UILabel*)stepTitleLabel
{
    if (!_stepTitleLabel) {
        
        _stepTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.origin.x, self.frame.size.height/4, self.bounds.size.width, kLabelHeight)];
        _stepTitleLabel.numberOfLines = 1;
        _stepTitleLabel.textAlignment = NSTextAlignmentCenter;
        _stepTitleLabel.text = @"步数";
        _stepTitleLabel.font = [UIFont fontWithName:kTextFontName_Helvetica size:15];
        _stepTitleLabel.textColor = kTextColor;
        
        [self addSubview:_stepTitleLabel];
        
    }
    
    return _stepTitleLabel;
    
}

-(UILabel*)walkingDisLabel
{
    if (!_walkingDisLabel) {
        
    _walkingDisLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height/2 - kLabelHeight/2, self.frame.size.width, kLabelHeight)];
        _walkingDisLabel.numberOfLines = 0;
        _walkingDisLabel.textAlignment = NSTextAlignmentCenter;
        _walkingDisLabel.font = [UIFont fontWithName:kHelveticaNeue size:15];
        _walkingDisLabel.textColor = kTextColor;
      
        [self addSubview:_walkingDisLabel];
        
        
    }
    
    return _walkingDisLabel;
    
}
- (double)percent {
    return self.progressLayer.percent;
}

- (CGFloat)currentDistance {
    return self.progressLayer.currentDistance;
}

-(void)setCurrentDistance:(CGFloat)currentDistance
{
    self.progressLayer.currentDistance = currentDistance;
    
    _stepsLabel.attributedText = [self getstepslabelString:currentDistance];

    
    
}


-(void)setExpectedDistance:(CGFloat)expectedDistance{
    
    _expectedDistance = expectedDistance;
    
    self.progressLayer.expectedDistance = expectedDistance;
    
   
   
    
}


#pragma mark - Private Methods

- (void)setupViews {
    
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = false;
    
    //add Progress layer
    self.progressLayer = [[CircleShapeLayer alloc] init];
    self.progressLayer.frame = self.bounds;
    self.progressLayer.backgroundColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:self.progressLayer];
    [self stepsLabel];
    [self stepTitleLabel];
    [self  walkingDisLabel];
  
    
    
    
}

- (void)setTintColor:(UIColor *)tintColor {
    self.progressLayer.progressColor = tintColor;

}

-(NSAttributedString*)getstepslabelString:(CGFloat)steps
{
    
    NSString *stepsStr = [NSString stringWithFormat:@"%.0f",steps];
    
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",stepsStr]];
    
    
    [muStr addAttributes:@{NSFontAttributeName:[UIFont fontWithName:kTextFontName_Helvetica size:20],NSStrokeColorAttributeName:kTextColor} range:NSMakeRange(0,stepsStr.length)];
    
    return muStr;
}

-(NSMutableAttributedString*)getdistanceString:(CGFloat)distance
{
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"步行%.2f千米",distance]];
    
    
    return muStr;
    
    
}

- (NSAttributedString *)gettextlabelString:(CGFloat)currentdistance steps:(CGFloat)steps {
    
    NSMutableParagraphStyle *muparagraph = [[NSMutableParagraphStyle alloc]init];
    [muparagraph setLineSpacing:10];
    [muparagraph setAlignment:NSTextAlignmentCenter];
    
    
    NSString *stepsStr = [NSString stringWithFormat:@"%.0f",steps];
    NSString *disStr = [NSString stringWithFormat:@"步行%.0f千米",currentdistance];
    
    
  
    _distancetext = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"步数\n%@\n%@",stepsStr,disStr]];
        
        
    [_distancetext addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:15],NSStrokeColorAttributeName:[UIColor darkGrayColor]} range:NSMakeRange(0,2)];
        
    
    [_distancetext addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:15],NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(stepsStr.length +1, disStr.length +3)];
    
    [_distancetext addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30],NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(2, stepsStr.length +2 )];
  //  NSLog(@"distanceLenth:%ld",(long)disStr.length);
    
    

    
 
    
    return _distancetext;
}


@end
