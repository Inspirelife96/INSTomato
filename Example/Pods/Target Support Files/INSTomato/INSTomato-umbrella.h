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

#import "INSBookmarkModel.h"
#import "INSBookmarkTableManager.h"
#import "INSDateHelper.h"
#import "INSNetworkOperation.h"
#import "INSPieChartDataModel.h"
#import "INSStatisticsHistoryModel.h"
#import "INSStatisticsTodayModel.h"
#import "INSTaskModel.h"
#import "INSTaskTableManager.h"
#import "INSStatisticsModel.h"
#import "INSStatisticsTableManager.h"
#import "INSBookmarkTablePersistence.h"
#import "INSPersistenceConstants.h"
#import "INSPersistenceFilePathHelper.h"
#import "INSTaskTablePersistence.h"
#import "INSStatisticsTablePersistence.h"
#import "INSBaseViewController.h"
#import "INSCopyScreenManager.h"
#import "INSBookmarkView.h"
#import "INSBookmarkViewController.h"
#import "INSBackgroundImageManager.h"
#import "INSColorHelper.h"
#import "INSColorPickerViewController.h"
#import "INSColorView.h"
#import "INSAppView.h"
#import "INSMusicHelper.h"
#import "INSNotificationConstants.h"
#import "INSTaskConfigurationNavigationStyleBasedViewController.h"
#import "INSTaskConfigurationPresentStyleBasedViewController.h"
#import "INSTaskConfigurationSwitchCell.h"
#import "INSTaskConfigurationViewController.h"
#import "INSTaskListCell.h"
#import "INSTomatoBundle.h"
#import "INSTomatoMinutesViewController.h"
#import "INSStatisticsHistoryBarChartGroupView.h"
#import "INSStatisticsHistoryBarChartView.h"
#import "INSStatisticsHistoryBestTomatoGroupView.h"
#import "INSStatisticsHistoryDataGroupView.h"
#import "INSStatisticsHistoryDataView.h"
#import "INSStatisticsHistoryPieChartView.h"
#import "INSStatisticsTodayDataView.h"
#import "INSStatisticsHistoryViewController.h"
#import "INSStatisticsTodayViewController.h"
#import "INSBarChartDataValueFormatter.h"
#import "INSPieChartDataViewModel.h"
#import "INSStatisticsHistoryViewModel.h"
#import "INSStatisticsTodayViewModel.h"
#import "INSAlertDateViewController.h"
#import "INSAlertOptionsViewController.h"
#import "INSMusicViewController.h"
#import "INSRestMinutesViewController.h"
#import "INSRestOptionsViewController.h"
#import "INSTaskConfigurationDefaultCell.h"
#import "INSTaskListCellViewModel.h"
#import "INSTaskListViewController.h"
#import "INSTaskNameViewController.h"
#import "INSTaskPageViewController.h"
#import "INSTomatoClockView.h"
#import "INSTomatoConfiguration.h"
#import "INSTomatoTimer.h"
#import "INSTomatoViewController.h"
#import "UIImage+INS_ContentWithColor.h"
#import "UIImageEffects.h"

FOUNDATION_EXPORT double INSTomatoVersionNumber;
FOUNDATION_EXPORT const unsigned char INSTomatoVersionString[];

