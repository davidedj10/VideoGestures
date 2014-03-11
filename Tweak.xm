#define KVerticalSlideMargin 20
#define KHorizontalSlideMargin 10

#include "ClassMethods.h"

id contentPlayer;
float volumeScroller = 0.0;
float timeScroller = 0.0;
float volumeScrollerRatio = 0.05;
float timeScrollerRatio = 3.0;
int scrolling_direction = 0;
NSDictionary *_preferences;

%hook MPAVController

-(id)videoView{

contentPlayer = %orig;

if([[_preferences objectForKey:@"enabled"] boolValue]){

UIPanGestureRecognizer *panSlider = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(Slide:)];

    [panSlider setMinimumNumberOfTouches:1];
    [contentPlayer addGestureRecognizer:panSlider];
    [contentPlayer setUserInteractionEnabled:YES];

    [panSlider release];

volumeScroller = [self volume];

}

return contentPlayer;

}

%new
-(void)Slide:(UIPanGestureRecognizer *)recognizer {

//Set scrolling way
if([recognizer state] == UIGestureRecognizerStateBegan){
    scrolling_direction = 0;
    NSLog(@"Scrolling direction is on : %i", scrolling_direction);
}

if([recognizer state] == UIGestureRecognizerStateEnded){
    NSLog(@"Scrolling direction was on : %i reinitializing to 0 ...", scrolling_direction);
    scrolling_direction = 0;
}

CGPoint ret = [recognizer translationInView:recognizer.view];
if (ret.y<-KVerticalSlideMargin || ret.y>KVerticalSlideMargin) {
     if(scrolling_direction == 0){
          scrolling_direction = 1;
    }
int slider_1 = (ret.y>0)?-1:1;
[recognizer setTranslation:CGPointMake(0, 0) inView:contentPlayer];
volumeScroller = (volumeScroller + slider_1*volumeScrollerRatio);
if(volumeScroller<0){
    volumeScroller = 0.0;
}else{
    if(volumeScroller > 1.0){
        volumeScroller = 1.0;
    }
}
if(scrolling_direction == 1){
    [self setVolume:volumeScroller];
    NSLog(@"Volume is at: %f", [self volume]);
}
    }

if (ret.x<-KHorizontalSlideMargin || ret.x>KHorizontalSlideMargin) {
    int slider_2 = (ret.x>0)?-1:1;
    if(scrolling_direction == 0){
        scrolling_direction = 2;
    }

if(![[_preferences objectForKey:@"naturalscrolling"] boolValue]){
  if(slider_2 > 0.0){
        slider_2 = -slider_2;
    }else{
        slider_2 = fabsf(slider_2);
    }
}

timeScroller = ([self currentTime] + slider_2*timeScrollerRatio);

//quite tricky but at least we know we still need to proceed in one diretion :)
if(scrolling_direction == 2){
    //timeScroller*=-1;
    NSLog(@"Time was scrolled to: %f", [self currentTime]);
    [self setCurrentTime:timeScroller];

    }
}

}

%end

void reloadPreferences(){

 _preferences = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.davidedj10.videogesturesprefs.plist"];

volumeScrollerRatio = [[_preferences objectForKey:@"volumescrollingratio"] floatValue];
timeScrollerRatio = [[_preferences objectForKey:@"videoscrollingratio"] floatValue];

if(volumeScrollerRatio == 0.00){
    volumeScrollerRatio = 0.05;
}

if(timeScrollerRatio == 0.00){
    timeScrollerRatio = 3;
}

}

static inline void prefs(CFNotificationCenterRef center,
                                    void *observer,
                                    CFStringRef name,
                                    const void *object,
                                    CFDictionaryRef userInfo) {
    reloadPreferences();
    NSLog(@"VideoGestures preferences updated...");
}


%ctor{

NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

NSLog(@"VideoGestures initialized...");

CFNotificationCenterRef center = CFNotificationCenterGetDarwinNotifyCenter();
CFNotificationCenterAddObserver(center, NULL, &prefs, (CFStringRef)@"com.davidedj10.videogestures/prefs", NULL, 0);

reloadPreferences();

[pool drain];

}
