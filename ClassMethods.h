@interface MPAVController

+(id)sharedInstance;
-(void)setVolume:(float)arg1;
-(float)volume;
-(double)currentTime;
-(void)setCurrentTime:(double)arg1;
-(void)play;
-(BOOL)isPlaying;
-(void)pause;
 
 @end