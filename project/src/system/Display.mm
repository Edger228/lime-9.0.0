//ЗАЕБАЛА ЭТА HX_MACOS С HX_IOS

#if defined(HX_MACOS)
#import <Cocoa/Cocoa.h>
#elif defined(HX_IOS)
#import <UIKit/UIKit.h>
#endif

#include <system/Display.h>
#include <math/Rectangle.h>

namespace lime {

void Display::GetSafeAreaInsets (int displayIndex, Rectangle * rect) {

#if defined(HX_MACOS)

    if (@available(macOS 12, *)) {
        NSScreen * screen = [[NSScreen screens] objectAtIndex: displayIndex];
        NSEdgeInsets safeAreaInsets = [screen safeAreaInsets];
        rect->SetTo(safeAreaInsets.left,
                    safeAreaInsets.top,
                    safeAreaInsets.right,
                    safeAreaInsets.bottom);
        return;
    }

#elif defined(HX_IOS)

    if (@available(iOS 11, *)) {
        UIWindow * window = [[UIApplication sharedApplication] keyWindow];
        UIEdgeInsets safeAreaInsets = [window safeAreaInsets];
        rect->SetTo(safeAreaInsets.left,
                    safeAreaInsets.top,
                    safeAreaInsets.right,
                    safeAreaInsets.bottom);
        return;
    }

#endif

    rect->SetTo(0.0, 0.0, 0.0, 0.0);
}

}
