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
#import "INSPieChartDataModel.h"
#import "INSStatisticsHistoryModel.h"
#import "INSStatisticsModel.h"
#import "INSStatisticsTableManager.h"
#import "INSStatisticsTodayModel.h"
#import "INSTaskModel.h"
#import "INSTaskTableConfiguration.h"
#import "INSTaskTableManager.h"
#import "INSTomatoConfiguration.h"
#import "INSTomatoConfigurationTableManager.h"
#import "INSBookmarkTablePersistence.h"
#import "INSPersistenceConstants.h"
#import "INSPersistenceFilePathHelper.h"
#import "INSStatisticsTablePersistence.h"
#import "INSTaskTablePersistence.h"
#import "INSTomatoConfigurationTablePersistence.h"
#import "INSBaseViewController.h"
#import "INSTaskConfigurationNavigationStyleBasedViewController.h"
#import "INSTaskConfigurationPresentStyleBasedViewController.h"
#import "INSBookmarkView.h"
#import "INSBookmarkViewController.h"
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
#import "INSColorPickerViewController.h"
#import "INSMusicViewController.h"
#import "INSRestMinutesViewController.h"
#import "INSRestOptionsViewController.h"
#import "INSTaskConfigurationViewController.h"
#import "INSTaskListViewController.h"
#import "INSTaskNameViewController.h"
#import "INSTomatoMinutesViewController.h"
#import "INSAppView.h"
#import "INSColorView.h"
#import "INSTaskConfigurationDefaultCell.h"
#import "INSTaskConfigurationSwitchCell.h"
#import "INSTaskListCell.h"
#import "INSLogoConfiguration.h"
#import "INSTaskListCellViewModel.h"
#import "INSTaskPageViewController.h"
#import "INSTomato.h"
#import "INSTomatoClockView.h"
#import "INSTomatoTimer.h"
#import "INSTomatoViewController.h"

FOUNDATION_EXPORT double INSTomatoVersionNumber;
FOUNDATION_EXPORT const unsigned char INSTomatoVersionString[];

