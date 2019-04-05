restoredefaultpath
clear all
clc
%%addpath('S:\4Imraan\TEST_team\MatlabGUI_Scripts_AND_STANDALONE_APP')

a = MCU_Log_file;

% 
% LogPath = 'S:\4Imraan\Tester Log File\asicLogFiles\2015_02_16_MCU\';
% LogName = 'ADC_LOW_DAC_HIG_FULL_X_0_Y_3_wafid_6_lotid_1664065_201516212025_.txt';
LogPath = 'C:\Users\iibrah\Desktop\Tester_logs';
LogName = 'FULL_X_4_Y_0_wafid_21_lotid_0CC38_d2018_11_28_t09_14_17.txt';


extractLogfile(a,LogPath,LogName)
getPLLData(a)
getPFFData(a)
getCKBUF(a)
getPI(a)
% PLLstatus = checkSingleLogPLL(a)
% PPFstatus = checkSingleLogPPF(a)
% PIstatus  = checkSingleLogPI(a)
getPhaseAlign(a)
getCalibration(a)
get3gt(a)
% plotSingleLogADC_Phase_Alignment(a);
plotSingleLogPLL(a);
plotSingleLogPPF(a);
plotSingleLogCKBUF(a);
plotSingleLogPI(a);
plotSingleLogDAC_Phase_Alignment(a);
plotSingleLog3GT(a);
plotSingleLogADC_CAL(a)
plotSingleLogDAC_CAL(a)
saveSingleLogPlots(a)
Untitled2
add2DB(a)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
extractLogDir(a,'S:\4Imraan\Tester Log File\asicLogFiles\2015_02_16_MCU')
extractLogDir(a,'S:\4Imraan\Tester Log File\asicLogFiles\2015_02_16_MCU_10X')
extractLogDir(a,'S:\4Imraan\Tester Log File\asicLogFiles\2015_02_13_MCUMAX')
extractLogDir(a,'S:\4Imraan\Tester Log File\asicLogFiles\2015_02_13_MCUMIN')
extractLogDir(a,'S:\4Imraan\Tester Log File\asicLogFiles\2015_02_13_MCUNOM')
extractLogDir(a,'S:\4Imraan\Tester Log File\asicLogFiles\OldFiles')
extractLogDir(a,'S:\4Imraan\Tester Log File\asicLogFiles\OldFiles\ADD3_MCU_Logs')
extractLogDir(a,'S:\4Imraan\Tester Log File\asicLogFiles\OldFiles\add3Terterm')
extractLogDir(a,'FULL_X_1_Y_3_wafid_6_lotid_1664065_2015121193357_')
extractLogDir(a,'S:\4Imraan\Tester Log File\asicLogFiles\OldFiles\MCUlogs')
% extractLogDir(a,'S:\4Imraan\Tester Log File\asicLogFiles\OldFiles\sd8012v200Tester')
extractLogDir(a,'S:\4Imraan\Tester Log File\asicLogFiles\2015_02_11_SUJI')
histPLL(a)
histPPF(a)

unique({a.ADC.LogName}')
numel(unique({a.ADC.LogName}'))








% 
% spnIndx      = find(strncmp(a.SingleLog.file,'<:spn',5));
% pllIndx      = find(strncmp(a.SingleLog.file,'<:pll',5));
% 
% a.SingleLog.file(spnIndx)
% a.SingleLog.file(pllIndx)






















