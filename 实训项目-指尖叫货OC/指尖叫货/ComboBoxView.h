#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class ComboBoxView;

@protocol ComboBoxViewDelegate <NSObject>

@optional
- (void)expandedComboBoxView:(ComboBoxView *)comboBoxView;
- (void)collapseComboBoxView:(ComboBoxView *)comboBoxView;

@required
- (void)selectedItemAtIndex:(NSInteger)selectedIndex fromComboBoxView:(ComboBoxView *)comboBoxView;

@end

@interface ComboBoxView : UIView

@property (nonatomic, assign) id<ComboBoxViewDelegate> delegate;
@property(nonatomic,strong)NSString *comboxTitle;

- (void)setShouldShowComboBoxBorder:(BOOL)showComboBoxBorder;     // Default Visible.

- (void)setComboBoxBorderColor:(UIColor *)color;

- (void)setTitleColor:(UIColor *)color;

- (void)setTitleFont:(UIFont *)font;

- (void)setPromptMessage:(NSString *)message;

- (void)setShouldShowDropIndicator:(BOOL)showDropIndicator;     // Default Visible.

- (void)setDropIndicatorImage:(UIImage *)dropIndicatorImage;

- (void)updateWithAvailableComboBoxItems:(NSArray *)comboItems;

- (void)updateWithSelectedIndex:(NSInteger)selectedIndex;

- (void)updateForViewFrameChanged;

- (void)collapseComboBoxView;

- (void)setMaxComboBoxHeight:(CGFloat)maxHeight;

@end
