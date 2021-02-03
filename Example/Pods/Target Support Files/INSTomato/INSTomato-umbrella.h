#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "INSDateHelper.h"
#import "INSPieChartDataModel.h"
#import "INSStatisticsHistoryModel.h"
#import "INSStatisticsTodayModel.h"
#import "INSTaskModel.h"
#import "INSTaskTableManager.h"
#import "INSTomatoModel.h"
#import "INSTomatoTableManager.h"
#import "INSPersistenceConstants.h"
#import "INSPersistenceFilePathHelper.h"
#import "INSTaskTablePersistence.h"
#import "INSTomatoTablePersistence.h"
#import "INSAlertDateViewController.h"
#import "INSAlertOptionsViewController.h"
#import "INSBackgroundImageManager.h"
#import "INSBaseViewController.h"
#import "INSColorHelper.h"
#import "INSColorPickerViewController.h"
#import "INSColorView.h"
#import "INSLogoConfiguration.h"
#import "INSLogoView.h"
#import "INSMusicHelper.h"
#import "INSMusicViewController.h"
#import "INSNotificationConstants.h"
#import "INSRestMinutesViewController.h"
#import "INSRestOptionsViewController.h"
#import "INSTaskConfigurationDefaultCell.h"
#import "INSTaskConfigurationNavigationStyleBasedViewController.h"
#import "INSTaskConfigurationPresentStyleBasedViewController.h"
#import "INSTaskConfigurationSwitchCell.h"
#import "INSTaskConfigurationViewController.h"
#import "INSTaskListCell.h"
#import "INSTaskListCellViewModel.h"
#import "INSTaskListViewController.h"
#import "INSTaskNameViewController.h"
#import "INSTaskPageViewController.h"
#import "INSTomatoClockView.h"
#import "INSTomatoConfiguration.h"
#import "INSTomatoMinutesViewController.h"
#import "INSTomatoTimer.h"
#import "INSTomatoViewController.h"
#import "UIImage+INS_ContentWithColor.h"
#import "UIImageEffects.h"

FOUNDATION_EXPORT double INSTomatoVersionNumber;
FOUNDATION_EXPORT const unsigned char INSTomatoVersionString[];

