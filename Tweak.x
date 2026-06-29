#import <dlfcn.h>
#import <GameKit/GKLocalPlayer.h>

@interface GKLocalPlayer (PrivateGameCenterHook)
-(void)cancelAuthentication;
@end

%hook GKLocalPlayer
-(void)setAuthStartTimeStamp:(CGFloat)timestamp {
    [self cancelAuthentication];
    %orig();
}
%end

%ctor {
}
