classdef MCU_Log_file < handle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Hidden)
        ADCIP
        DACIP
    end
    properties
        LogPath
        LogName
        ADC
        DAC
        SingleLog
	end
    
    methods
        function obj = MCU_Log_file()
            init(obj);
        end
        function init(obj)
            
            createChipStruct(obj)
            
            
        end
        function createChipStruct(obj)
            
            obj.SingleLog = [];
            [PLL.maxind, PLL.gaincode, PLL.target, PLL.maxvoltage, PLL.nbias,...
                PLL.pbias, PLL.pk_vcm, PLL.vsign_wide, PLL.act_wide, PLL.vcocal_wide,...
                PLL.sign_fallingedge_flag, PLL.vsign_wide_f, PLL.act_wide_f, PLL.vcocal_wide_F,...
                PLL.ntune, PLL.ptune, PLL.sweepTop, PLL.sweepBot,PLL.vsign_narrow,...
                PLL.act_narrow, PLL.vcocal_narrow,...                                                                                      %PLL
                PPF.maxind, PPF.gaincode, PPF.maxvoltage, PPF.pffbufflevel, PPF.nbias, PPF.pbias,...
                PPF.pk_vcm,...                                                                                                             %PPF
                PI.target, PI.maxvoltage, PI.selcode, PI.maxind, PI.retvsweep, PI.pbias, PI.pk_vcm,...                                     %PI
                phADC.Sumsigma_gain_error, phADC.Sumfitval, phADC.Sumstep,...
                phADC.sigma_gain_error, phADC.fitval, phADC.step,...                                                                       %Phase Align ADC
                phDAC.up, phDAC.dwn, phDAC.bcd, phDAC.numOfReadBacks, phDAC.odd, phDAC.even,...                                            %Phase Align DAC
                O3GT.VCMp, O3GT.VCMn, O3GT.VCMpNorm, O3GT.VCMnNorm, O3GT.finalCode,...                                                     %3GT
                CKP.pk_vcm_x1PI, CKP.pk_vcm_x2, CKP.pb_x1PI, CKP.pb_x2, CKP.nb_x1PI, CKP.nb_x2 CKP.Gain1, CKP.Gain2,...                   %CKP
                CKO.pk_A, CKO.tr_A, CKO.pk2Tr_A, CKO.tr_cko, CKO.x1, CKO.x2, CKO.suph_x2, CKO.supl_x2,...
                CKO.pk2Trougth, CKO.pb_cko, CKO.nb_cko, CKO.pk_cko, CKO.vpp_cko, CKO.realVpp, CKO.targetCKO, CKO.finalCode_cko,...
                CKO.cko_vamprep, CKO.cko_nbias, CKO.cko_pbias, CKO.cko_vdsat, CKO.cko_vnegsup180, CKO.cko_vpossup180,...
                CKO.cko_vnegsup090, CKO.cko_vpossup090, CKO.cko_nbiasrep, CKO.cko_trougth, CKO.cko_peak, CKO.cko_phadj000,...
                CKO.cko_nbiasintQ, CKO.cko_pbiasintQ, CKO.suph_cko, CKO.supl_cko, CKO.cko_x2pb, CKO.cko_x2nb, CKO.vtr000_mean,...
                CKO.vtr090_mean, CKO.vtr180_mean, CKO.vtr270_mean,...                                                                      %CKO
                CLKALIGN.numOfReadBacks, CLKALIGN.iup2, CLKALIGN.idwn2, CLKALIGN.ibcd2, CLKALIGN.pi_odd_i2, CLKALIGN.pi_even_i2,...
                CLKALIGN.qup2, CLKALIGN.qdwn2, CLKALIGN.qbcd2, CLKALIGN.pi_odd_q2, CLKALIGN.pi_even_q2, CLKALIGN.iup3,...
                CLKALIGN.idwn3, CLKALIGN.ibcd3, CLKALIGN.pi_odd_i3, CLKALIGN.pi_even_i3, CLKALIGN.qup3, CLKALIGN.qdwn3,...
                CLKALIGN.qbcd3, CLKALIGN.pi_odd_q3, CLKALIGN.pi_even_q3,...                                                                %PhaseAligner
                DAC_Calibration_Load.cs, DAC_Calibration_Load.cslsb, DAC_Calibration_Load.cslsb_err, DAC_Calibration_Load.swmax,...
                DAC_Calibration_Load.swmean, DAC_Calibration_Load.swmin, DAC_Calibration_Load.swmin, DAC_Calibration_Load.phDAC,...
                DAC_Calibration_Load.ph_err, DAC_Calibration_Load.csDAC,DAC_Calibration_Load.swDAC,...                                     %DAC Calibration
                ADC_Calibration_Load.sampler, ADC_Calibration_Load.osamp, ADC_Calibration_Load.psamp, ADC_Calibration_Load.pmean,...
                ADC_Calibration_Load.pdmx1, ADC_Calibration_Load.odmx1, ADC_Calibration_Load.demux1, ADC_Calibration_Load.pdmx2,...
                ADC_Calibration_Load.odmx2, ADC_Calibration_Load.demux2, ADC_Calibration_Load.psubadc, ADC_Calibration_Load.osubadc,...
                ADC_Calibration_Load.subadc...                                                                                             %ADC Calibration
                ] = deal(nan);
            
            
            % Common structures for ADC and DAC
            obj.SingleLog.ADC.PLL_Load                 = PLL;
            obj.SingleLog.ADC.PPF_Load                 = PPF;
            obj.SingleLog.ADC.I_PI_Load                = PI;
            obj.SingleLog.ADC.Q_PI_Load                = PI;
            obj.SingleLog.ADC.CLKALIGN_Load            = CLKALIGN;
            obj.SingleLog.DAC                          = obj.SingleLog.ADC;
            
            % DAC only structurre
            obj.SingleLog.DAC.I_CKP_Load             = CKP;
            obj.SingleLog.DAC.Q_CKP_Load             = CKP;
            obj.SingleLog.DAC.I_CKO_Load             = CKO;
            obj.SingleLog.DAC.Q_CKO_Load             = CKO;
            obj.SingleLog.DAC.I_Phase_Align          = phDAC;
            obj.SingleLog.DAC.Q_Phase_Align          = phDAC;
            obj.SingleLog.DAC.I_3GT                  = O3GT;
            obj.SingleLog.DAC.Q_3GT                  = O3GT;
            obj.SingleLog.DAC.I_Calibration_Load       = DAC_Calibration_Load;
            obj.SingleLog.DAC.Q_Calibration_Load       = DAC_Calibration_Load;
            %%%
            % ADC only structures
            obj.SingleLog.ADC.I_Calibration_Load       = ADC_Calibration_Load;
            obj.SingleLog.ADC.Q_Calibration_Load       = ADC_Calibration_Load;
            obj.SingleLog.ADC.I_Phase_Align            = phADC;
            obj.SingleLog.ADC.Q_Phase_Align            = phADC;
            %%%
            
            [obj.SingleLog.LogPath, obj.SingleLog.ADC.LogPath, obj.SingleLog.DAC.LogPath, obj.SingleLog.DAC.IPNo, obj.SingleLog.DAC.Version] = deal('');
            [obj.SingleLog.LogName, obj.SingleLog.ADC.LogName, obj.SingleLog.DAC.LogName, obj.SingleLog.ADC.IPNo, obj.SingleLog.ADC.Version] = deal('');
            clear PLL PPF CKP CKO PI CLKALIGN
        end
        function nanFieldnames(obj,IP,StructNames)
            
            
            M = size(obj.SingleLog.DAC,2);
            
            for IPNo = 1:M
                for StructNo = 1:numel(StructNames)
                    Fnames = fieldnames(obj.SingleLog.(IP)(IPNo).(StructNames{StructNo}));
                    for FNo = 1:numel(Fnames)
                        obj.SingleLog.(IP)(IPNo).(StructNames{StructNo}).(Fnames{FNo}) = nan;
                    end
                end
            end
            
            
            
        end
        
        
        function extractLogDir(obj,LogPath)
            
            Log_Name = dir(LogPath);
            Log_Name = {Log_Name.name}';
            Log_Name = Log_Name(~cellfun(@isempty, strfind(Log_Name,'.txt')));
            
            for LogNo = 1:numel(Log_Name)
                
                check4Duplicate(obj,LogPath,Log_Name{LogNo})
                if ~obj.SingleLog.Duplicate
                    extractLogfile(obj,LogPath,Log_Name{LogNo})
                    %getPLLData(obj)
                    %getPFFData(obj)
                    %getPI(obj)
                    getPhaseAlign(obj)
                    %getCKBUF(obj)
                    %get3gt(obj)
                    %getCalibration(obj)
                    add2DB(obj)
                end
            end
            
            
        end
        function extractLogfileOld(obj,LogPath,LogName)
            if ~isempty(obj.SingleLog.LogName)
                createChipStruct(obj)
            end
            
            [obj.SingleLog.LogPath, obj.SingleLog.ADC.LogPath, obj.SingleLog.DAC.LogPath] = deal(LogPath);
            [obj.SingleLog.LogName, obj.SingleLog.ADC.LogName, obj.SingleLog.DAC.LogName] = deal(LogName);
            check4Duplicate(obj,LogPath,LogName)
            
            fileID = fopen(fullfile(LogPath,LogName));
            if fileID == -1
                error('LogFile Not found')
            else
                C = textscan(fileID,'%s','delimiter','\n');
                fclose(fileID);
                obj.SingleLog.file = C{:};
            end
            
            expression   = 'ADC(\d*) = 1';
            ADCNoLogic    = ~cellfun(@isempty, regexp(obj.SingleLog.file,expression));
            ADCNo = strrep(obj.SingleLog.file(ADCNoLogic),'ADC','');
            ADCNo = strrep(ADCNo,'= 1','');
            if max(str2num([ADCNo{:}]))==3 % ADC0:1 ===> max = 1   ADC0:3  ===> max = 3
                [obj.SingleLog.Type, obj.SingleLog.ADC.Type, obj.SingleLog.DAC.Type] = deal('add3');
                obj.SingleLog.ADC(2:4) = obj.SingleLog.ADC;
                obj.SingleLog.DAC(2:4) = obj.SingleLog.DAC;
                obj.SingleLog.ADCIP = [0 1 2 3];
                obj.SingleLog.DACIP = [4 5 6 7];
                [obj.SingleLog.ADC.IPNo] = deal(0, 1, 2, 3);
                [obj.SingleLog.DAC.IPNo] = deal(4, 5, 6, 7);
            else
                [obj.SingleLog.Type, obj.SingleLog.ADC.Type, obj.SingleLog.DAC.Type] = deal('v200');
                obj.SingleLog.ADC(2)   = obj.SingleLog.ADC;
                obj.SingleLog.DAC(2)   = obj.SingleLog.DAC;
                obj.SingleLog.ADCIP = [0 1];
                obj.SingleLog.DACIP = [2 3];
                [obj.SingleLog.ADC.IPNo] = deal(0, 1);
                [obj.SingleLog.DAC.IPNo] = deal(2, 3);
            end
            
            [obj.SingleLog.ADC.Version] = deal(strjoin(obj.SingleLog.file(strncmp(obj.SingleLog.file,'[:Version',9))','; '));
            [obj.SingleLog.DAC.Version] = deal(strjoin(obj.SingleLog.file(strncmp(obj.SingleLog.file,'[:Version',9))','; '));
        end
        function extractLogfile(obj,LogPath,LogName)
            if ~isempty(obj.SingleLog.LogName)
                createChipStruct(obj)
            end
            
            [obj.SingleLog.LogPath, obj.SingleLog.ADC.LogPath, obj.SingleLog.DAC.LogPath] = deal(LogPath);
            [obj.SingleLog.LogName, obj.SingleLog.ADC.LogName, obj.SingleLog.DAC.LogName] = deal(LogName);
            check4Duplicate(obj,LogPath,LogName)
            
            fileID = fopen(fullfile(LogPath,LogName));
            if fileID == -1
                error('LogFile Not found')
            else
                C = textscan(fileID,'%s','delimiter','\n');
                fclose(fileID);
                obj.SingleLog.file = C{:};
            end
            
            expression       = 'chip name      = (\w+) (\w+)';
            tokens           = regexp(obj.SingleLog.file,expression,'tokens');
            tokens           = [tokens{:}]';
            if ~isempty(tokens)
            Type             = tokens{1}{1};
            else % else is quick fix
                ChipNameList = strfind(obj.SingleLog.file,'chip name');
                LineIndx     = find(~cellfun(@isempty, ChipNameList),1,'first');
                LineTMP      = obj.SingleLog.file{LineIndx}(ChipNameList{LineIndx}:end);
                expression   = 'chip name = (\w+) (\w+)';
                tokens       = regexp(LineTMP,expression,'tokens');
                Type         = tokens{1}{1};
            end
            %tokens{1}{2}
            [obj.SingleLog.Type, obj.SingleLog.ADC.Type, obj.SingleLog.DAC.Type] = deal(Type);
            
                    
            switch Type
                case {'SD8012V200';'SKY';'SD8013V100';'ADD2L';'SD8020V100';'SD8016V100';'GEMINI'}
                    obj.SingleLog.ADC(2)   = obj.SingleLog.ADC;
                    obj.SingleLog.DAC(2)   = obj.SingleLog.DAC;
                    obj.SingleLog.ADCIP = [0 1];
                    obj.SingleLog.DACIP = [2 3];
                    [obj.SingleLog.ADC.IPNo] = deal(0, 1);
                    [obj.SingleLog.DAC.IPNo] = deal(2, 3);
                case {'ADD3';'Denali'}
                    
                    obj.SingleLog.ADC(2:4) = obj.SingleLog.ADC;
                    obj.SingleLog.DAC(2:4) = obj.SingleLog.DAC;
                    obj.SingleLog.ADCIP = [0 1 2 3];
                    obj.SingleLog.DACIP = [4 5 6 7];
                    [obj.SingleLog.ADC.IPNo] = deal(0, 1, 2, 3);
                    [obj.SingleLog.DAC.IPNo] = deal(4, 5, 6, 7);
            end
            
            [obj.SingleLog.ADC.Version] = deal(strjoin(obj.SingleLog.file(strncmp(obj.SingleLog.file,'[:Version',9))','; '));
            [obj.SingleLog.DAC.Version] = deal(strjoin(obj.SingleLog.file(strncmp(obj.SingleLog.file,'[:Version',9))','; '));
        end
        function DataOut = extractLineData(~,LogLine)
            
            
            EndIndx   = strfind(LogLine,'[::]');
            TMPLine   = {LogLine{1}(1:(EndIndx{1}-1))};
            StartIndx = strfind(TMPLine,']');
            
            DataOut   = str2num(TMPLine{1}(StartIndx{1}+1:end));
            
            
        end
        function check4Duplicate(obj,LogPath,LogName)
            if ~isempty(obj.DAC) && ~isempty(obj.ADC)
                LogPathLogic      = strcmp({obj.ADC.LogPath}',LogPath);
                DuplicateLogLogic = strcmp({obj.ADC.LogName}',LogName);
                if max(DuplicateLogLogic)
                    if max(any([LogPathLogic, DuplicateLogLogic],2))
                        W1 = sprintf('\n%s is already part of the DB and extracted from the same path \n%s\n',LogName,LogPath);
                        W2 = sprintf('The log file will NOT be added to the database again\n');
                        warning(sprintf('%s%s',W1,W2)) % same logfile same path
                        obj.SingleLog.Duplicate = true;
                    else
                        W1 = sprintf('\n%s is already part of the DB and extracted from a different path \n',LogName);
                        W2 = sprintf('The log file will NOT be added to the database again\n');
                        warning(sprintf('%s%s',W1,W2))    % same logfile diff path
                        obj.SingleLog.Duplicate = true;
                    end
                else
                    obj.SingleLog.Duplicate = false;
                end
            else
                obj.SingleLog.Duplicate = false;
            end
        end
        
        function add2DB(obj)
            if isempty(obj.ADC) && isempty(obj.DAC)
                
                obj.ADC = obj.SingleLog.ADC;
                obj.DAC = obj.SingleLog.DAC;
            elseif ~obj.SingleLog.Duplicate
                
                sizeDB       = size(obj.ADC,2);
                size_SingleLog = size(obj.SingleLog.ADC,2);
                
                obj.ADC(sizeDB+1:sizeDB+size_SingleLog) = obj.SingleLog.ADC;
                obj.DAC(sizeDB+1:sizeDB+size_SingleLog) = obj.SingleLog.DAC;
                
            end
        end
        
    end
    
    
    methods %Common extractions
        function getPLLData(obj)
            
            %             spnIndx        = find(strncmp(obj.SingleLog.file,'<:spn',5));
            pllIndx        = find(strncmp(obj.SingleLog.file,'<:pll',5));
            InputIndx      = find(strncmp(obj.SingleLog.file,'[:',2));
            %             obj.SingleLog.file(spnIndx)
            %             obj.SingleLog.file(pllIndx)
            
            Fname           = fieldnames(obj.SingleLog.ADC(1).PLL_Load);
            FieldIdentifier = {'[:mxi';'[:gaincode';'[:target';'[:maxvoltage';'[:nbias';'[:pbias';...
                '[:pk_vcm';'[:vsign_wide';'[:act_wide';'[:vcocal_wide';'[:falling';...
                '[:vsign_wide_f';'[:act_wide_f';'[:vcocal_wide_F';'[:ntune';'[:ptune';'[:sweepTop';'[:sweepBot';...
                '[:vsign_narrow';'[:act_narrow';'[:vcocal_narrow'};
            
            
            
            for pllNo = 1:numel(pllIndx)
                IPNo       = sscanf(obj.SingleLog.file{pllIndx(pllNo)}, '%*s %d %*s', [1, inf]);
                ADCIPLogic = obj.SingleLog.ADCIP==IPNo;
                DACIPLogic = obj.SingleLog.DACIP==IPNo;
                if max(ADCIPLogic)
                    IP = 'ADC';
                    IPLogic = ADCIPLogic;
                elseif max(DACIPLogic)
                    IP = 'DAC';
                    IPLogic = DACIPLogic;
                end
                if pllNo<numel(pllIndx)
                    pllNoInputIndx = InputIndx(InputIndx>pllIndx(pllNo) & InputIndx<pllIndx(pllNo+1));
                else
                    pllNoInputIndx = InputIndx(InputIndx>pllIndx(pllNo));
                end
                %                 obj.SingleLog.file([pllIndx(pllNo); pllNoInputIndx])
                
                
                %                 FnameLogic      = zeros(numel(obj.SingleLog.file(pllNoInputIndx)),numel(Fname));
                
                %                 cellfun(@isempty, cellfun(@(x) strfind(obj.SingleLog.file(pllNoInputIndx),x), FieldIdentifier, 'UniformOutput', false))
                for FieldNo = 1:numel(Fname)
                    %                     FnameLogic  = ~cellfun(@isempty, strfind(obj.SingleLog.file(pllNoInputIndx),FieldIdentifier{FieldNo}));
                    FnameLogic         = strncmp(obj.SingleLog.file(pllNoInputIndx),FieldIdentifier{FieldNo},numel(FieldIdentifier{FieldNo}));
                    if max(FnameLogic)
                        
                        Data = extractLineData(obj,obj.SingleLog.file(pllNoInputIndx(FnameLogic)));
                        
                        switch Fname{FieldNo}
                            case {'target';'maxvoltage';'nbias';'pbias';'pk_vcm';'vsign_wide';'vsign_wide_f';'ntune';'ptune';'vsign_narrow'}
                                Data = Data/1e4;
                        end
                        if IPNo==obj.SingleLog.(IP)(IPLogic).IPNo
                            obj.SingleLog.(IP)(IPLogic).PLL_Load.(Fname{FieldNo}) = Data;
                        else
                        end
                    end
                end
                
                
            end
            
        end
        function getPFFData(obj)
            ppfIndx        = find(strncmp(obj.SingleLog.file,'<:ppf',5));
            InputIndx      = find(strncmp(obj.SingleLog.file,'[:',2));
            %             obj.SingleLog.file(ppfIndx)
            
            Fname           = {'maxind';'gaincode';'maxvoltage';'pffbufflevel';...
                'nbias';'pbias';'pk_vcm';};
            FieldIdentifier = {'[:mxi';'[:gaincode';'[:maxvoltage';'[:pffbufflevel';...
                '[:nbias';'[:pbias';'[:pk_vcm'};
            
            
            
            
            for ppfNo = 1:numel(ppfIndx)
                IPNo       = sscanf(obj.SingleLog.file{ppfIndx(ppfNo)}, '%*s %d %*s', [1, inf]);
                ADCIPLogic = obj.SingleLog.ADCIP==IPNo;
                DACIPLogic = obj.SingleLog.DACIP==IPNo;
                if max(ADCIPLogic)
                    IP = 'ADC';
                    IPLogic = ADCIPLogic;
                elseif max(DACIPLogic)
                    IP = 'DAC';
                    IPLogic = DACIPLogic;
                end
                if ppfNo<numel(ppfIndx)
                    ppfNoInputIndx = InputIndx(InputIndx>ppfIndx(ppfNo) & InputIndx<ppfIndx(ppfNo+1));
                else
                    ppfNoInputIndx = InputIndx(InputIndx>ppfIndx(ppfNo));
                end
                
                for FieldNo = 1:numel(Fname)
                    %                     FnameLogic  = ~cellfun(@isempty, strfind(obj.SingleLog.file(ppfNoInputIndx),FieldIdentifier{FieldNo}));
                    FnameLogic         = strncmp(obj.SingleLog.file(ppfNoInputIndx),FieldIdentifier{FieldNo},numel(FieldIdentifier{FieldNo}));
                    if max(FnameLogic)
                        
                        Data = extractLineData(obj,obj.SingleLog.file(ppfNoInputIndx(FnameLogic)));
                        switch Fname{FieldNo}
                            case {'maxvoltage';'pffbufflevel';'nbias';'pbias';'pk_vcm'}
                                Data = Data/1e4;
                        end
                        if IPNo==obj.SingleLog.(IP)(IPLogic).IPNo
                            obj.SingleLog.(IP)(IPLogic).PPF_Load.(Fname{FieldNo}) = Data;
                        end
                    end
                end
            end
            
            
        end
        function getPI(obj)
            
            piIndx        = find(strncmp(obj.SingleLog.file,'<:pi',4));
            InputIndx      = find(strncmp(obj.SingleLog.file,'[:',2));
            %             obj.SingleLog.file(piIndx)
            
            Fname           = fieldnames(obj.SingleLog.ADC(1).I_PI_Load);
            FieldIdentifier = {'[:target';'[:maxvoltage';...
                '[:%cselcode';'[:%cmaxind';'[:%cretvsweep';'[:%cpbias';'[:%cpk_vcm'};
            
            
            
            
            for piNo = 1:numel(piIndx)
                IPNo       = sscanf(obj.SingleLog.file{piIndx(piNo)}, '%*s %d %d %*s', [1, inf]);
                ADCIPLogic = obj.SingleLog.ADCIP==IPNo(1);
                DACIPLogic = obj.SingleLog.DACIP==IPNo(1);
                if max(ADCIPLogic)
                    IP = 'ADC';
                    IPLogic = ADCIPLogic;
                elseif max(DACIPLogic)
                    IP = 'DAC';
                    IPLogic = DACIPLogic;
                end
                if piNo<numel(piIndx)
                    piNoInputIndx = InputIndx(InputIndx>piIndx(piNo) & InputIndx<piIndx(piNo+1));
                else
                    piNoInputIndx = InputIndx(InputIndx>piIndx(piNo));
                end
                
                Channel = {'I';'Q'};
                for chNo = 1:numel(Channel)
                    if isChannelEnabled(obj,IPNo(2),Channel{chNo})
                        PIstructChannel = sprintf('%c_PI_Load',Channel{chNo});
                        for FieldNo = 1:numel(Fname)
                            FieldIdentifierTMP = sprintf(FieldIdentifier{FieldNo},lower(Channel{chNo}));
                            %                             FnameLogic         = ~cellfun(@isempty, strfind(obj.SingleLog.file(ckoNoInputIndx),FieldIdentifierTMP));
                            FnameLogic         = strncmp(obj.SingleLog.file(piNoInputIndx),FieldIdentifierTMP,numel(FieldIdentifierTMP));
                            if max(FnameLogic)
                                Data = extractLineData(obj,obj.SingleLog.file(piNoInputIndx(FnameLogic)));
                                switch Fname{FieldNo}
                                    case {'target';'maxvoltage';'retvsweep';'pbias';'pk_vcm'}
                                        Data = Data/1e4;
                                end
                                if IPNo(1)==obj.SingleLog.(IP)(IPLogic).IPNo
                                    obj.SingleLog.(IP)(IPLogic).(PIstructChannel).(Fname{FieldNo}) = Data;
                                end
                            end
                        end
                    end
                end
            end
        end
        function getPhaseAlign(obj)
            getPhaseAlignADC(obj)
            getPhaseAlignDAC(obj)
        end
        function getCalibration(obj)
            getADCcalibration(obj)
            getDACcalibration(obj)
        end
        
    end
    %++++++++++++++++++++++++++++++++  Data Extraction  +++++++++++++++++++++++++++++
    methods %ADC extractions
        function getPhaseAlignADC(obj)
            LogicArray                   = strncmp(obj.SingleLog.file,'<:',2);
            Indxph                       = find(strncmp(obj.SingleLog.file,'<:phjabba',9));
            InputLogic                   = strncmp(obj.SingleLog.file,'[:',2);
            InputIndxMax                 = Indxph + find(LogicArray(Indxph+1:end),1,'first');
            InputLogic(1:Indxph)         = false;
            InputLogic(InputIndxMax:end) = false;
            InputIndx                    = find(InputLogic);
            Fname                        = fieldnames(obj.SingleLog.ADC(1).I_Phase_Align);
            FId                          = cellfun(@(x) ['%c%d', x],Fname,'UniformOutput',false);
            FId                          = strrep(FId,'%c%dSum','Sum');
            
            Chn                          = {'I';'Q'};
            
            
            lineTMP = cellfun(@(x) strsplit(x,' '), obj.SingleLog.file(InputIndx),'UniformOutput',false);
            lineTMP = cellfun(@(x) x{1},lineTMP,'UniformOutput',false);
            lineTMP = strrep(lineTMP,'[:','');
            
            %             obj.SingleLog.file(InputIndx)
            
            for IPNo = obj.SingleLog.ADCIP
                for ChNo = 1:numel(Chn)
                    for FIdNo = 1:numel(FId)
                        FIdLogic = strcmp(Fname,strrep(FId{FIdNo},'%c%d',''));
                        if max(FIdLogic)
                            ADCIPLogic            = obj.SingleLog.ADCIP==IPNo;
                            PhaseStruct           = sprintf('%c_Phase_Align',Chn{ChNo});
                            FIdTMP                = sprintf(FId{FIdNo},lower(Chn{ChNo}),IPNo);
                            FIdTMPLgc             = strcmp(lineTMP,strrep(FIdTMP,'Sum','')); %FieldIdentifierTMPLgc
                            if max(FIdTMPLgc)
                                Data  = extractLineData(obj,obj.SingleLog.file(InputIndx(FIdTMPLgc)));
                                switch Fname{FIdLogic}
                                    case {'Sumsigma_gain_error';'Sumfitval';'sigma_gain_error';'fitval'}
                                        Data = Data*1e-4;
                                    case {''}
                                        
                                end
                                obj.SingleLog.ADC(ADCIPLogic).(PhaseStruct).(Fname{FIdLogic}) = Data;
                            end
                        end
                    end
                end
            end
        end
        function getADCcalibration(obj)
            
            CalIndx        = find(strncmp(obj.SingleLog.file,'<:caldo',7));
            InputIndx      = find(strncmp(obj.SingleLog.file,'[:',2));
            minADCIP  = sprintf('<:caldo %d',min(obj.SingleLog.ADCIP));
            minADCIP  = find(strncmp(obj.SingleLog.file(CalIndx),minADCIP,9),1,'first');
            CalIndx   = CalIndx(minADCIP:end);
            InputIndx = InputIndx(~InputIndx<CalIndx(1));
            %             obj.SingleLog.file(CalIndx)
            
            Fname           = fieldnames(obj.SingleLog.ADC(1).I_Calibration_Load);
            FieldIdentifier = {'[:sampler';'[:osamp';'[:psamp';'[:pmean';...
                '[:pdmx1';'[:odmx1';'[:demux1';'[:pdmx2';'[:odmx2';'[:demux2';...
                '[:psubadc';'[:osubadc';'[:subadc'};
            nanFieldnames(obj,'ADC',{'I_Calibration_Load';'Q_Calibration_Load'})
            
            
            
            
            
            
            IterationTOT     = 0;
            for CalNoTMP = 1:numel(CalIndx)
                IterationTOT = max([IterationTOT, sscanf(obj.SingleLog.file{CalIndx(CalNoTMP)}, '%*s %*d %*s %d', [1, inf])]);
            end
            %             IterationTOT = IterationTOT+1; % To account for itt 0 ===> 0:7 = 8
            
            for CalNo = 1:numel(CalIndx)
                IPNo       = sscanf(obj.SingleLog.file{CalIndx(CalNo)}, '%*s %d %*s %*d', [1, inf]);
                if ~isempty(strfind(obj.SingleLog.file{CalIndx(CalNo)},'I'))
                    ChanNme = 'I';
                elseif ~isempty(strfind(obj.SingleLog.file{CalIndx(CalNo)},'Q'))
                    ChanNme = 'Q';
                end
                ADCIPLogic     = obj.SingleLog.ADCIP==IPNo;
                IP             = 'ADC';
                IPLogic        = ADCIPLogic;
                
                if CalNo<numel(CalIndx)
                    CalNoInputIndx = InputIndx(all([InputIndx>CalIndx(CalNo), InputIndx<CalIndx(CalNo+1)],2));
                else
                    CalNoInputIndx = InputIndx(InputIndx>CalIndx(CalNo));
                end
                
                
                for FieldNo = 1:numel(Fname)
                    %                     FnameLogic  = ~cellfun(@isempty, strfind(obj.SingleLog.file(ppfNoInputIndx),FieldIdentifier{FieldNo}));
                    FnameLogic         = strncmp(obj.SingleLog.file(CalNoInputIndx),FieldIdentifier{FieldNo},numel(FieldIdentifier{FieldNo}));
                    if max(FnameLogic)
                        
                        Data = extractLineData(obj,obj.SingleLog.file(CalNoInputIndx(FnameLogic)));
                        switch Fname{FieldNo}
                            case {'osamp'}
%                                 Data = Data/(32766*1e3);
                                Data = Data/(32768*1e3);
                            case{'psamp'}
%                                 Data = Data/32766;
                                Data = Data/32768;
                            case {'odmx1'}
                                Data = Data/(8192*1e3);
                            case {'pdmx1'}
                                Data = Data/8192;
                            case {'odmx2'}
                                Data = Data/(2048*1e3);
                            case {'pdmx2'}
                                Data = Data/2048;
                            case {'osubadc'}
                                Data = Data/(512*1e3);
                            case {'psubadc'}
                                Data = Data/512;
                        end
                        if IPNo==obj.SingleLog.(IP)(IPLogic).IPNo
                            IterationNo = sscanf(obj.SingleLog.file{CalIndx(CalNo)}, '%*s %*d %*s %d', [1, inf])+1;
                            if IterationNo==1;
                                obj.SingleLog.(IP)(IPLogic).([ChanNme, '_Calibration_Load']).(Fname{FieldNo}) = Data;
                            else
                                obj.SingleLog.(IP)(IPLogic).([ChanNme, '_Calibration_Load']).(Fname{FieldNo})(IterationNo,:) = Data;
                            end
                            
                        end
                    end
                end
            end
            
            
            
            
        end
    end
    
    
    methods %DAC extractions
        function getCKBUF(obj)
            
            
            ckoIndx        = find(strncmp(obj.SingleLog.file,'<:cko',5));
            InputIndx      = find(strncmp(obj.SingleLog.file,'[:',2));
            Chn            = {'I';'Q'};
            %             obj.SingleLog.file(ckoIndx)
            
            CKPFname       = fieldnames(obj.SingleLog.DAC(1).I_CKP_Load);
            CKPFId = cellfun(@(x) ['%c',x], CKPFname,'UniformOutput',false);
            
            CKOFname       = fieldnames(obj.SingleLog.DAC(1).I_CKO_Load);
            CKOFId = cellfun(@(x) ['%c',x], CKOFname,'UniformOutput',false);
            
            
            
            
            for ckoNo = 1:numel(ckoIndx)
                IPNo       = sscanf(obj.SingleLog.file{ckoIndx(ckoNo)}, '%*s %d %d %*s', [1, inf]);
                DACIPLogic = obj.SingleLog.DACIP==IPNo(1);
                if ckoNo<numel(ckoIndx)
                    ckoNoInputIndx = InputIndx(InputIndx>ckoIndx(ckoNo) & InputIndx<ckoIndx(ckoNo+1));
                else
                    ckoNoInputIndx = InputIndx(InputIndx>ckoIndx(ckoNo));
                end
                
                lineTMP = cellfun(@(x) strsplit(x,' '), obj.SingleLog.file(ckoNoInputIndx),'UniformOutput',false);
                lineTMP = cellfun(@(x) x{1},lineTMP,'UniformOutput',false);
                lineTMP = strrep(lineTMP,'[:','');
                
                
                for ChNo = 1:numel(Chn)
                    
                    for CKPFIdNo = 1:numel(CKPFId)
                        CKPFIdTMP = sprintf(CKPFId{CKPFIdNo},lower(Chn{ChNo}));
                        lineTMPLogic = strncmp(lineTMP,CKPFIdTMP,numel(CKPFIdTMP));
                        if max(lineTMPLogic)
                            Data  = extractLineData(obj,obj.SingleLog.file(ckoNoInputIndx(lineTMPLogic)));
                            switch CKPFname{CKPFIdNo}
                                case {'pk_vcm_x1PI';'pk_vcm_x2';'pb_x1PI';'pb_x2';'nb_x1PI'}
                                    Data = Data*1e-4;
                                case {'nb_x2'}
                                    Data = Data*1e-4;
                                    Gain = sscanf(obj.SingleLog.file{ckoNoInputIndx(lineTMPLogic)+1}, '%*s %*s %*s %d %*s %d', [1, inf]);
                                    obj.SingleLog.DAC(DACIPLogic).(sprintf('%c_CKP_Load',Chn{ChNo})).Gain1 = Gain(1);
                                    obj.SingleLog.DAC(DACIPLogic).(sprintf('%c_CKP_Load',Chn{ChNo})).Gain2 = Gain(2);
                            end
                            obj.SingleLog.DAC(DACIPLogic).(sprintf('%c_CKP_Load',Chn{ChNo})).(CKPFname{CKPFIdNo}) = Data;
                        end
                    end
                    
                    for CKOFIdNo = 1:numel(CKOFId)
                        CKOFIdTMP = sprintf(CKOFId{CKOFIdNo},lower(Chn{ChNo}));
                        lineTMPLogic = strncmp(lineTMP,CKOFIdTMP,numel(CKOFIdTMP));
                        if max(lineTMPLogic)
                            Data  = extractLineData(obj,obj.SingleLog.file(ckoNoInputIndx(lineTMPLogic)));
                            switch CKOFname{CKOFIdNo}
                                case {'pk_A';'tr_A';'pk2Tr_A';'tr_cko';'x1';'x2';'suph_x2';'supl_x2';'pk2Trougth';...
                                        'pb_cko';'nb_cko';'pk_cko';'vpp_cko';'realVpp';'targetCKO';'cko_vamprep';'cko_nbias';'cko_pbias';...
                                        'cko_vdsat';'cko_vnegsup180';'cko_vpossup180';'cko_vnegsup090';'cko_vpossup090';...
                                        'cko_nbiasrep';'cko_trougth';'cko_peak';'cko_phadj000';'cko_nbiasintQ';'cko_pbiasintQ';...
                                        'suph_cko';'supl_cko';'cko_x2pb';'cko_x2nb'}
                                    Data = Data*1e-4;
                                case {'s'}
                                    
                            end
                            obj.SingleLog.DAC(DACIPLogic).(sprintf('%c_CKO_Load',Chn{ChNo})).(CKOFname{CKOFIdNo}) = Data;
                        end
                    end
                    
                end
            end
        end
        function getPhaseAlignDAC(obj)
            LogicArray                   = strncmp(obj.SingleLog.file,'<:',2);
            Indxph                       = find(strncmp(obj.SingleLog.file,'<:phjess',8));
            InputLogic                   = strncmp(obj.SingleLog.file,'[:',2);
            InputIndxMax                 = Indxph + find(LogicArray(Indxph+1:end),1,'first');
            InputLogic(1:Indxph)         = false;
            InputLogic(InputIndxMax:end) = false;
            InputIndx                    = find(InputLogic);
            Fname                        = fieldnames(obj.SingleLog.DAC(1).I_Phase_Align);
            
            FId                          = cellfun(@(x) ['%d%c', x],Fname,'UniformOutput',false);
            numOfReadBacksLGC            = strcmp(Fname,'numOfReadBacks');
            FId(numOfReadBacksLGC)       = Fname(numOfReadBacksLGC);
            
            Chn                          = {'I';'Q'};
            
            
            lineTMP = cellfun(@(x) strsplit(x,' '), obj.SingleLog.file(InputIndx),'UniformOutput',false);
            lineTMP = cellfun(@(x) x{1},lineTMP,'UniformOutput',false);
            lineTMP = strrep(lineTMP,'[:','');
            
            %             obj.SingleLog.file(InputIndx)
            
            for IPNo = obj.SingleLog.DACIP
                for ChNo = 1:numel(Chn)
                    for FIdNo = 1:numel(FId)
                        FnameLogic = strcmp(Fname,strrep(FId{FIdNo},'%d%c',''));
                        if max(FnameLogic)
                            DACIPLogic            = obj.SingleLog.DACIP==IPNo;
                            PhaseStruct             = sprintf('%c_Phase_Align',Chn{ChNo});
                            FIdTMP                = sprintf(FId{FIdNo},IPNo,lower(Chn{ChNo}));
                            FIdTMPLgc             = strcmp(lineTMP,FIdTMP); %FieldIdentifierTMPLgc
                            if max(FIdTMPLgc)
                                Data  = extractLineData(obj,obj.SingleLog.file(InputIndx(FIdTMPLgc)));
                                switch Fname{FnameLogic}
                                    case {''}
                                        
                                    case {'s'}
                                        
                                end
                                obj.SingleLog.DAC(DACIPLogic).(PhaseStruct).(Fname{FnameLogic}) = Data;
                            end
                        end
                    end
                end
            end
        end
        function get3gt(obj)
            
            LogicArray                   = strncmp(obj.SingleLog.file,'<:',2);
            Indx3gt                      = find(strncmp(obj.SingleLog.file,'<:3gt',5));
            InputLogic                   = strncmp(obj.SingleLog.file,'[:',2);
            InputIndxMax                 = Indx3gt + find(LogicArray(Indx3gt+1:end),1,'first');
            InputLogic(1:Indx3gt)        = false;
            InputLogic(InputIndxMax:end) = false;
            InputIndx                    = find(InputLogic);
            Fname                        = fieldnames(obj.SingleLog.DAC(1).I_3GT);
            FieldIdentifier              = {'VCMp%d%c';'VCMn%d%c';'VCMp%d%cNorm';'VCMn%d%cNorm';'finalCode'};
            Chn                          = {'I';'Q'};
            
            
            lineTMP = cellfun(@(x) strsplit(x,' '), obj.SingleLog.file(InputIndx),'UniformOutput',false);
            lineTMP = cellfun(@(x) x{1},lineTMP,'UniformOutput',false);
            lineTMP = strrep(lineTMP,'[:','');
            
            %             obj.SingleLog.file(InputIndx)
            
            for IPNo = obj.SingleLog.DACIP
                for ChNo = 1:numel(Chn)
                    for FIdNo = 1:numel(FieldIdentifier)
                        FnameLogic = strcmp(Fname,strrep(FieldIdentifier{FIdNo},'%d%c',''));
                        if max(FnameLogic)
                            DACIPLogic            = obj.SingleLog.DACIP==IPNo;
                            struct3GT             = sprintf('%c_3GT',Chn{ChNo});
                            FIdTMP                = sprintf(FieldIdentifier{FIdNo},IPNo,Chn{ChNo});
                            FIdTMPLgc             = strcmp(lineTMP,FIdTMP); %FieldIdentifierTMPLgc
                            if max(FIdTMPLgc)
                                Data  = extractLineData(obj,obj.SingleLog.file(InputIndx(FIdTMPLgc)));
                                switch Fname{FnameLogic}
                                    case {'VCMp';'VCMn';'VCMpNorm';'VCMnNorm'}
                                        Data = Data*1e-2;
                                    case {''}
                                        
                                end
                                obj.SingleLog.DAC(DACIPLogic).(struct3GT).(Fname{FnameLogic}) = Data;
                            end
                        end
                    end
                end
            end
        end
        function getDACcalibration(obj)
            
            CalIndx        = find(strncmp(obj.SingleLog.file,'<:caldo',7));
            InputIndx      = find(strncmp(obj.SingleLog.file,'[:',2));
            %             obj.SingleLog.file(CalIndx)
            
            Fname           = fieldnames(obj.SingleLog.DAC(1).I_Calibration_Load);
            FieldIdentifier = {'[:cs ';'[:cslsb';'[:cslsb_err';...
                '[:swmax';'[:swmean';'[:swmin';'[:phDAC';'[:ph_err';...
                '[:csDAC';'[:swDAC'};
            nanFieldnames(obj,'DAC',{'I_Calibration_Load';'Q_Calibration_Load'})
            
            
            
            
            maxDACIP = sprintf('<:caldo %d',max(obj.SingleLog.DACIP));
            maxDACIP = find(strncmp(obj.SingleLog.file(CalIndx),maxDACIP,9),1,'last');
            
            IterationTOT     = 0;
            for CalNoTMP = 1:maxDACIP
                IterationTOT = max([IterationTOT, sscanf(obj.SingleLog.file{CalIndx(CalNoTMP)}, '%*s %*d %*s %d', [1, inf])]);
            end
            %             IterationTOT = IterationTOT+1; % To account for itt 0 ===> 0:7 = 8
            
            
            for CalNo = 1:maxDACIP%numel(CalIndx)
                IPNo       = sscanf(obj.SingleLog.file{CalIndx(CalNo)}, '%*s %d %*s %*d', [1, inf]);
                if ~isempty(strfind(obj.SingleLog.file{CalIndx(CalNo)},'I'))
                    ChanNme = 'I';
                elseif ~isempty(strfind(obj.SingleLog.file{CalIndx(CalNo)},'Q'))
                    ChanNme = 'Q';
                end
                DACIPLogic     = obj.SingleLog.DACIP==IPNo;
                IP             = 'DAC';
                IPLogic        = DACIPLogic;
                if CalNo<maxDACIP
                    CalNoInputIndx = InputIndx(all([InputIndx>CalIndx(CalNo), InputIndx<CalIndx(CalNo+1)],2));
                else
                    CalNoInputIndx = InputIndx(all([InputIndx>CalIndx(CalNo), InputIndx<CalIndx(CalNo)],2));
                end
                
                for FieldNo = 1:numel(Fname)
                    %                     FnameLogic  = ~cellfun(@isempty, strfind(obj.SingleLog.file(ppfNoInputIndx),FieldIdentifier{FieldNo}));
                    FnameLogic         = strncmp(obj.SingleLog.file(CalNoInputIndx),FieldIdentifier{FieldNo},numel(FieldIdentifier{FieldNo}));
                    if max(FnameLogic)
                        
                        Data = extractLineData(obj,obj.SingleLog.file(CalNoInputIndx(FnameLogic)));
                        switch Fname{FieldNo}
                            case {'csDAC';'swDAC'}
                                Data = Data/256;
                            case{'swmax';'swmean';'swmin'}
                                Data = Data/5;
                        end
                        if IPNo==obj.SingleLog.(IP)(IPLogic).IPNo
                            IterationNo = sscanf(obj.SingleLog.file{CalIndx(CalNo)}, '%*s %*d %*s %d', [1, inf])+1;
                            if IterationNo==1;
                                obj.SingleLog.(IP)(IPLogic).([ChanNme, '_Calibration_Load']).(Fname{FieldNo}) = Data;
                            else
                                obj.SingleLog.(IP)(IPLogic).([ChanNme, '_Calibration_Load']).(Fname{FieldNo})(IterationNo,:) = Data;
                            end
                            
                        end
                    end
                end
            end
            
            
            
            
        end
        
    end
    %+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    
    %++++++++++++++++++++++++++++++++  Error Checks  +++++++++++++++++++++++++++++
    %---SingleLog
    methods
        function status = checkSingleLogPLL(obj)
            
            status = cell(numel([obj.SingleLog.ADCIP, obj.SingleLog.DACIP]),3);
            IPtype          = {'ADC';'DAC'};
            Indx      = 1;
            
            for IPtypeNo = 1:numel(IPtype)
                for StructNo = 1:size(obj.SingleLog.(IPtype{IPtypeNo}),2)
                    PLL             = obj.SingleLog.(IPtype{IPtypeNo})(StructNo).PLL_Load;
                    status{Indx,1}  = sprintf('%s%d',IPtype{IPtypeNo},obj.SingleLog.(IPtype{IPtypeNo})(StructNo).IPNo);
                    CrossPointLogic = any([PLL.pbias<=0; PLL.nbias>=0],1);
                    
                    if max(CrossPointLogic)
                        Indxb4cross = find(CrossPointLogic,1,'first')-2; 
                        if PLL.gaincode<Indxb4cross-2
                            status{Indx,2}  = 'PASS';
                            status{Indx,3}  = sprintf('(code_before_crossing) - gaincode = %d',(Indxb4cross - PLL.gaincode));
                            
                        else
                            status{Indx,2}  = 'PASS';
                            status{Indx,3}  = sprintf('(code_before_crossing) - gaincode = %d',(Indxb4cross - PLL.gaincode));
                        end
                    else
                        if PLL.gaincode<PLL.maxind-2
                            status{Indx,2}  = 'PASS';
                            status{Indx,3}  = sprintf('maxind - gaincode = %d',(PLL.maxind - PLL.gaincode));
                        else
                            status{Indx,2}  = 'Fail';
                            status{Indx,3}  = sprint('maxind - gaincode = %d',(PLL.maxind - PLL.gaincode));
                        end
                    end
                    Indx = Indx+1;
                end
            end
            status = [[{'PLL'}, {'Status'}, {'Number_of_Codes_apart'}];status];
        end
        function status = checkSingleLogPPF(obj)
            
            status = cell(numel([obj.SingleLog.ADCIP, obj.SingleLog.DACIP]),3);
            IPtype          = {'ADC';'DAC'};
            Indx      = 1;
            
            for IPtypeNo = 1:numel(IPtype)
                for StructNo = 1:size(obj.SingleLog.(IPtype{IPtypeNo}),2)
                    PPF             = obj.SingleLog.(IPtype{IPtypeNo})(StructNo).PPF_Load;
                    status{Indx,1}  = sprintf('%s%d',IPtype{IPtypeNo},obj.SingleLog.(IPtype{IPtypeNo})(StructNo).IPNo);
                    CrossPointLogic = any([PPF.pbias<=0; PPF.nbias>=0],1);
                    
                    if max(CrossPointLogic)
                        Indxb4cross = find(CrossPointLogic,1,'first')-2;
                        if PPF.gaincode<Indxb4cross-2
                            status{Indx,2}  = 'PASS';
                            status{Indx,3}  = sprintf('(code_before_crossing) - gaincode = %d',(Indxb4cross - PPF.gaincode));
                            
                        else
                            status{Indx,2}  = 'Fail';
                            status{Indx,3}  = sprintf('(code_before_crossing) - gaincode = %d',(Indxb4cross - PPF.gaincode));
                        end
                    else
                        if PPF.gaincode<PPF.maxind-2
                            status{Indx,2}  = 'PASS';
                            status{Indx,3}  = sprintf('maxind - gaincode = %d',(PPF.maxind - PPF.gaincode));
                        else
                            status{Indx,2}  = 'Fail';
                            status{Indx,3}  = sprint('maxind - gaincode = %d',(PPF.maxind - PPF.gaincode));
                        end
                    end
                    Indx = Indx+1;
                end
            end
            status = [[{'PPF'}, {'Status'}, {'Number_of_Codes_apart'}];status];
        end
        function status = checkSingleLogPI(obj)
            
            status = cell(numel([obj.SingleLog.ADCIP, obj.SingleLog.DACIP])*2,3);
            IPtype          = {'ADC';'DAC'};
            Ch              = {'I';'Q'};
            Indx      = 1;
            
            for IPtypeNo = 1:numel(IPtype)
                for StructNo = 1:size(obj.SingleLog.(IPtype{IPtypeNo}),2)
                    for ChNo = 1:numel(Ch)
                        PI             = obj.SingleLog.(IPtype{IPtypeNo})(StructNo).([Ch{ChNo},'_PI_Load']);
                        status{Indx,1}  = sprintf('%s%d%c',IPtype{IPtypeNo}, obj.SingleLog.(IPtype{IPtypeNo})(StructNo).IPNo, Ch{ChNo});
                        CrossPointLogic = PI.pbias<=0;
                        
                        if max(CrossPointLogic)
                            Indxb4cross = find(CrossPointLogic,1,'first')-2;
                            if PI.selcode<Indxb4cross-2
                                status{Indx,2}  = 'PASS';
                                status{Indx,3}  = sprintf('(code_before_crossing) - gaincode = %d',(Indxb4cross - PI.selcode));
                                
                            else
                                status{Indx,2}  = 'Fail';
                                status{Indx,3}  = sprintf('(code_before_crossing) - gaincode = %d',(Indxb4cross - PI.selcode));
                            end
                        else
                            if PI.selcode<PI.maxind-2
                                status{Indx,2}  = 'PASS';
                                status{Indx,3}  = sprintf('maxind - gaincode = %d',(PI.maxind - PI.selcode));
                            else
                                status{Indx,2}  = 'Fail';
                                status{Indx,3}  = sprint('maxind - gaincode = %d',(PI.maxind - PI.selcode));
                            end
                        end
                        Indx = Indx+1;
                    end
                end
            end
            status = [[{'PI'}, {'Status'}, {'Number_of_Codes_apart'}];status];
        end
    end
    %---DB(multiple logfiles)
    methods
        
    end
    %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    
    
    
    
    %++++++++++++++++++++++++++++++++  PLOTS  +++++++++++++++++++++++++++++
    %---SingleLog
    methods
        
        %---------------------       PLL
        function plotSingleLogPLL(obj)
            figH_PLL     = 1000:1000+numel([obj.SingleLog.ADCIP, obj.SingleLog.DACIP])*2-1;
            handleNo     = 1;
            IPtype       = {'ADC';'DAC'};
            
            for IPtypeNo = 1:numel(IPtype)
                for StructNo = 1:size(obj.SingleLog.(IPtype{IPtypeNo}),2)
                    plotSingleLogPLLCalibration(obj,IPtype{IPtypeNo},StructNo,figH_PLL(handleNo));
                    plotSingleLogrfbuffergainsweep(obj,IPtype{IPtypeNo},StructNo,figH_PLL(handleNo+1));
                    handleNo = handleNo+2;
                end
            end
        end
        function plotSingleLogPLLCalibration(obj,IPtype,StructNo,figH)
            
            %             obj.SingleLog.(IPtype)(StructNo)
            %             findobj('Type','figure')
            FigNme = sprintf('%s_%d_PLL_Calibration',IPtype,obj.SingleLog.(IPtype)(StructNo).IPNo);
            figure(figH)
            set(figH,'name',FigNme,'FileName',FigNme,'Visible','on')
            
            BandStep = 1024/(numel(obj.SingleLog.(IPtype)(StructNo).PLL_Load.vsign_wide')-1);
            x        = repmat((0:BandStep:1024)',[1 2]);
            if ~obj.SingleLog.(IPtype)(StructNo).PLL_Load.sign_fallingedge_flag
                subplot(2,2,[1 3])
            else
                subplot(2,2,1);
            end
            
            
            subplotH = plot(x,[obj.SingleLog.(IPtype)(StructNo).PLL_Load.vsign_wide',...
                obj.SingleLog.(IPtype)(StructNo).PLL_Load.act_wide']);
            subplotH = [subplotH;line(repmat(obj.SingleLog.(IPtype)(StructNo).PLL_Load.vcocal_wide,[1 2]),[0, 1])];
            
            set(subplotH(1),'Color',[0 0 1])                     %Blue
            set(subplotH(2),'Color',[0 1 0])                     %Green
            set(subplotH(3),'Color',[1 0 0],'LineStyle','--')     %Red
            
            title(sprintf('First PLL Sweep : Start = 0 : Step = %d' ,BandStep))
            ylabel('Voltage (V)');
            xlabel('Band Switch Code');
            axis([0 1024 -0.1 1.2]);
            set(gca,'YTick',-0.1:0.1:1.1)
            set(gca,'XTick',0:BandStep:1024)
            grid on;
            
            if obj.SingleLog.(IPtype)(StructNo).PLL_Load.sign_fallingedge_flag
                subplot(2,2,3)
                x(1,:) = 64;
                subplotH = plot(x,[obj.SingleLog.(IPtype)(StructNo).PLL_Load.vsign_wide_f',...
                    obj.SingleLog.(IPtype)(StructNo).PLL_Load.act_wide_f']);
                subplotH = [subplotH;line(repmat(obj.SingleLog.(IPtype)(StructNo).PLL_Load.vcocal_wide_F,[1 2]),[0, 1])];
                
                set(subplotH(1),'Color',[0 0 1])                     %Blue
                set(subplotH(2),'Color',[0 1 0])                     %Green
                set(subplotH(3),'Color',[1 0 0],'LineStyle',':')     %Red
                
                title(sprintf('Second PLL Sweep : Start = %d : Step = %d',BandStep/2,BandStep));
                ylabel('Voltage (V)');
                xlabel('Band Switch Code');
                axis([0 1024 -0.1 1.2]);
                set(gca,'YTick',-0.1:0.1:1.1)
                set(gca,'XTick',0:BandStep:1024)
                grid on;
            end
            
            x             = (obj.SingleLog.(IPtype)(StructNo).PLL_Load.sweepBot:obj.SingleLog.(IPtype)(StructNo).PLL_Load.sweepTop)';
            x             = repmat(x, [1 3]);
            vcocal_narrow = obj.SingleLog.(IPtype)(StructNo).PLL_Load.vcocal_narrow;
            YLogic             = x(:,1) == vcocal_narrow;
            Y                  = obj.SingleLog.(IPtype)(StructNo).PLL_Load.vsign_narrow(YLogic);
            subplotH = nan(4,1);
            subplot(2,2,[2 4])
            subplotH(1:3) = plot(x,[obj.SingleLog.(IPtype)(StructNo).PLL_Load.vsign_narrow',...
                                    obj.SingleLog.(IPtype)(StructNo).PLL_Load.ntune',...
                                    obj.SingleLog.(IPtype)(StructNo).PLL_Load.ptune'],'.-');
            
            
            subplotH(4) = line(repmat(obj.SingleLog.(IPtype)(StructNo).PLL_Load.vcocal_narrow,[1 2]),[Y, Y]);
            
            set(subplotH(1),'Color',[0 0 0])                                     %Black
            set(subplotH(2),'Color',[0 0 1])                                     %Blue
            set(subplotH(3),'Color',[0 1 0])                                     %Green
            set(subplotH(4),'Color',[1 0 0],'LineStyle','none','Marker','o')     %Red
            
            title(sprintf('Fine PLL Sweep : Start = %d : Stop = %d',x(end,1),x(1,1)))
            ylabel('Voltage (V)');
            xlabel('Band Switch Code');
            axis([x(1,1) x(end,1) -0.1 1.2]);
            set(gca,'YTick',-0.1:0.1:1.1)
            set(gca,'XTick',x(1,1)-1:16:x(end,1))
            legend('Detector Flag','NTUNEP','NTUNEN','Selected BS','location','SouthEast')
            grid on;
            
            set(gcf, 'PaperUnits', 'inches');
            set(gcf, 'PaperSize', [11.6929 8.2677])
            set(gcf, 'PaperPosition', [0.125 0.125 11.45 8 ]);
        end
        function plotSingleLogrfbuffergainsweep(obj,IPtype,StructNo,figH)
            
            %             obj.SingleLog.(IPtype)(StructNo).PLL_Load
            FigNme = sprintf('%s_%d_rfbuffergainsweep',IPtype,obj.SingleLog.(IPtype)(StructNo).IPNo);
            figure(figH)
            set(figH,'name',FigNme,'FileName',FigNme,'Visible','on')
            
            maxind   = obj.SingleLog.(IPtype)(StructNo).PLL_Load.maxind;
            pk_vcm   = obj.SingleLog.(IPtype)(StructNo).PLL_Load.pk_vcm;
            gaincode = obj.SingleLog.(IPtype)(StructNo).PLL_Load.gaincode;
            nbias    = obj.SingleLog.(IPtype)(StructNo).PLL_Load.nbias;
            pbias    = obj.SingleLog.(IPtype)(StructNo).PLL_Load.pbias;
            
            subplot(3,1,1)
            plot(0:(maxind),pk_vcm,[gaincode,gaincode],[min(pk_vcm),max(pk_vcm)])
            xlabel('Code');
            ylabel('peak-vcm');
            legend('meas data','Sel')
            title('PLL RF Buffer Swept voltage')
            grid
            subplot(3,1,2)
            plot(0:maxind,nbias,0:maxind,pbias)
            xlabel('Code');
            ylabel('Volts');
            title('Nbias and Pbias voltages')
            legend('NBIAS','PBIAS')
            grid
            subplot(3,1,3)
            plot(0:maxind,rfbuffer_pckvcm_to_ptop(obj,pk_vcm),[gaincode,gaincode],[min(rfbuffer_pckvcm_to_ptop(obj,pk_vcm)),max(rfbuffer_pckvcm_to_ptop(obj,pk_vcm))])
            xlabel('Code');
            ylabel('Volts (PtoP Single Ended)');
            title('Approx. PtoP Level')
            grid
            
        end
        %------------------------------------------------
        %---------------------       PFF
        function plotSingleLogPPF(obj)
            
            figH_PPF     = 1100:1100+numel([obj.SingleLog.ADCIP, obj.SingleLog.DACIP])-1;
            handleNo     = 1;
            IPtype       = {'ADC';'DAC'};
            
            for IPtypeNo = 1:numel(IPtype)
                for StructNo = 1:size(obj.SingleLog.(IPtype{IPtypeNo}),2)
                    
                    %obj.SingleLog.(IPtype{IPtypeNo})(StructNo).PPF_Load
                    FigNme  = sprintf('%s_%d_ppfbuffergainsweep',IPtype{IPtypeNo},obj.SingleLog.(IPtype{IPtypeNo})(StructNo).IPNo);
                    figure(figH_PPF(handleNo))
                    set(figH_PPF(handleNo),'name',FigNme,'FileName',FigNme,'Visible','off')
                    
                    PPF = obj.SingleLog.(IPtype{IPtypeNo})(StructNo).PPF_Load;
                    
                    subplot(3,1,1)
                    plot(0:PPF.maxind,PPF.pk_vcm,[PPF.gaincode,PPF.gaincode],[min(PPF.pk_vcm),max(PPF.pk_vcm)])
                    xlabel('Code');
                    ylabel('peak-vcm');
                    title('PFF RF Buffer Swept voltage')
                    legend('meas data','Sel')
                    legend('Location','NorthWest')
                    grid
                    subplot(3,1,2)
                    plot(0:PPF.maxind,PPF.nbias,0:PPF.maxind,PPF.pbias)
                    xlabel('Code');
                    ylabel('Volts');
                    title('Nbias and Pbias voltages')
                    legend('NBIAS','PBIAS')
                    legend('Location','NorthWest')
                    grid
                    subplot(3,1,3)
                    plot(0:PPF.maxind,pckvcm_to_ptop(obj,PPF.pk_vcm),[PPF.gaincode,PPF.gaincode],[min(pckvcm_to_ptop(obj,PPF.pk_vcm)),max(pckvcm_to_ptop(obj,PPF.pk_vcm))])
                    xlabel('Code');
                    ylabel('Volts (PtoP Single-ended)');
                    title('Approx. PtoP Level')
                    grid
                    
                    handleNo = handleNo+1;
                end
            end
            %set(figH_PLL,'Visible','on')
        end
        %------------------------------------------------
        %---------------------       CKBUF
        function plotSingleLogCKBUF(obj)
            figH_CKBUF     = 1200:1200+(numel(obj.SingleLog.DACIP)*2*4)-1; %2=> I&Q, 4=>Plot Types
            handleNo       = 1;
            Ch             = {'I';'Q'};
            
            
            for StructNo = 1:size(obj.SingleLog.DAC,2)
                for ChNo = 1:numel(Ch)
                    plotSingleLogCKP_BufferGains(obj,StructNo,Ch{ChNo},figH_CKBUF(handleNo))
                    plotSingleLogCKO_BufferGains(obj,StructNo,Ch{ChNo},figH_CKBUF(handleNo+1))
                    plotSingleLogCKO_BufferGains_realVpp(obj,StructNo,Ch{ChNo},figH_CKBUF(handleNo+2))
                    plotSingleLogCKO_Levels(obj,StructNo,Ch{ChNo},figH_CKBUF(handleNo+3))
                    %        supplies for cko not saved in logfile
                    %plotSingleLogCKO_Supplies(obj,StructNo,Ch{ChNo},figH_CKBUF(handleNo+3))
                    handleNo = handleNo+3;
                end
            end
        end
        %--CKP BufferGains
        function plotSingleLogCKP_BufferGains(obj,StructNo,Ch,figH)
            
            CKP    = obj.SingleLog.DAC(StructNo).(sprintf('%s_CKP_Load',Ch));
            FigNme = sprintf('DAC%d%c_ckp_buffergains',obj.SingleLog.DAC(StructNo).IPNo,Ch);
            figure(figH)
            set(figH,'name',FigNme,'FileName',FigNme,'Visible','off')
            
            [pk_vcm_x1PI_cor,finalCode_x1PI,...
                pk_vcm_x2_cor,finalCode_x2] = CKP_Param(obj,CKP);
            
            subplot(3,1,1)
            plot(0:15,CKP.pk_vcm_x1PI,0:15,pk_vcm_x1PI_cor,[finalCode_x1PI,finalCode_x1PI],[min(CKP.pk_vcm_x1PI),max(CKP.pk_vcm_x1PI)], ...
                0:15,CKP.pk_vcm_x2,  0:15,pk_vcm_x2_cor,  [finalCode_x2,finalCode_x2],    [min(CKP.pk_vcm_x2),max(CKP.pk_vcm_x2)] );
            xlabel('Code');
            ylabel('peak-vcm');
            title('x1 & PI Pre Buffer Swept voltage')
            legend('meas data x1PI','fit data x1PI','Sel x1PI','meas data x2','fit data x2','Sel x2')
            legend('Location','SouthEast')
            set(gca,'XTick',0:1:15)
            grid
            
            subplot(3,1,2)
            plot(0:15,CKP.nb_x1PI,0:15,CKP.pb_x1PI, ...
                0:15,CKP.nb_x2  ,0:15,CKP.pb_x2  )
            xlabel('Code');
            ylabel('Volts');
            title('Nbias and Pbias voltages')
            legend('NBIAS x1PI','PBIAS x1PI','NBIAS x2','PBIAS x2')
            legend('Location','SouthEast')
            set(gca,'XTick',0:1:15)
            grid
            
            subplot(3,1,3)
            plot(0:15,pckvcm_to_ptop(obj,CKP.pk_vcm_x1PI),[finalCode_x1PI,finalCode_x1PI],[min(pckvcm_to_ptop(obj,CKP.pk_vcm_x1PI)),max(pckvcm_to_ptop(obj,CKP.pk_vcm_x1PI))], ...
                0:15,pckvcm_to_ptop(obj,CKP.pk_vcm_x2),  [finalCode_x2,finalCode_x2],    [min(pckvcm_to_ptop(obj,CKP.pk_vcm_x2)),max(pckvcm_to_ptop(obj,CKP.pk_vcm_x2))] )
            xlabel('Code');
            ylabel('Volts (PtoP Differential)');
            title('Approx. PtoP Level')
            legend('meas data x1PI','Sel x1PI','meas data x2','Sel x2')
            legend('Location','SouthEast')
            set(gca,'XTick',0:1:15)
            grid
            
            
            set(figH, 'PaperUnits', 'inches');
            set(figH, 'PaperSize', [8.2677 11.6929]);
            set(figH, 'PaperPosition', [0.125 0.125 8 11.45 ]);
        end
        function [pk_vcm_x1PI_cor,finalCode_x1PI,...
                pk_vcm_x2_cor,finalCode_x2] = CKP_Param(obj,CKP)
            pk_vcm_x1PI_cor = correctpeakdata(obj,CKP.pk_vcm_x1PI);
            targetVx1PI     = 0.2;
            
            if (max(pk_vcm_x1PI_cor)>targetVx1PI)
                % If pk_vcm_x1PI_cor exceeds targetVx1PI use interpolation to find yi index
                yi = interp1(pk_vcm_x1PI_cor,0:15,targetVx1PI,'linear');
                finalCode_x1PI=ceil(yi);
            else
                % If pk_vcm_x1PI_cor is less than targetVx1PI use the lowest yi setting which gives highest pk_vcm
                df2 = diff(pk_vcm_x1PI_cor,2);             % Find 2nd differential of pk_vcm_x1PI_cor
                finalCode_x1PI = find(df2==min(df2))+1;    % Look for minimum point on 2nd diff, add 1 to index
            end
            targetVx2       = 0.2;
            pk_vcm_x2_cor   = correctpeakdata(obj,CKP.pk_vcm_x2);
            
            if (max(pk_vcm_x2_cor)>targetVx2)
                % If pk_vcm_x2_cor exceeds targetVx2 use interpolation to find yi index
                yi = interp1(pk_vcm_x2_cor,0:15,targetVx2,'linear');
                finalCode_x2=ceil(yi);
                
            else
                % If pk_vcm_x2_cor is less than targetVx2 use the lowest yi setting which gives highest pk_vcm
                df2 = diff(pk_vcm_x2_cor,2);             % Find 2nd differential of pk_vcm_x2_cor
                finalCode_x2 = find(df2==min(df2))+1;     % Look for minimum point on 2nd diff, add 1 to index
            end
        end
        %--CKO BufferGains
        function plotSingleLogCKO_BufferGains(obj,StructNo,Ch,figH)
            CKO    = obj.SingleLog.DAC(StructNo).(sprintf('%s_CKO_Load',Ch));
            FigNme = sprintf('DAC%d%c_cko_buffergains',obj.SingleLog.DAC(StructNo).IPNo,Ch);
            figure(figH)
            set(figH,'name',FigNme,'FileName',FigNme,'Visible','off')
            
            
            subplot(4,1,1)
            plot(0:15,CKO.pk2Trougth,0:15,CKO.pk_cko,0:15,CKO.tr_cko,[CKO.finalCode_cko,CKO.finalCode_cko],[-0.5 0.5])
            ylabel('Voltage');
            title('DAC Output Clock Buffer: Vpeak, Vtrougth and Vpeak-Vtrougth')
            legend('peak to trougth','peak','trougth')
            legend('Location','SouthEast')
            axis([0 15 -0.5 0.5]);
            set(gca,'XTick',0:1:15)
            set(gca,'YTick',-0.5:0.1:0.5)
            grid on
            
            subplot(4,1,2)
            plot(0:15,CKO.pb_cko,0:15,CKO.nb_cko,0:15,CKO.cko_x2pb,0:15,CKO.cko_x2nb)
            ylabel('Voltage');
            title('NBIAS/PBIAS')
            legend('pbias','nbias','pbias\_x2','nbias\_x2')
            legend('Location','SouthEast')
            axis([0 15 -0.6 0.6]);
            set(gca,'XTick',0:1:15)
            set(gca,'YTick',-0.6:0.2:0.6)
            grid on
            
            subplot(4,1,3)
            plot(0:15,CKO.vpp_cko,[CKO.finalCode_cko,CKO.finalCode_cko],[min(CKO.vpp_cko),max(CKO.vpp_cko)],0:15, CKO.pk2Tr_A)
            ylabel('Clock Vpp');
            title('Estimated Clock Vpp')
            legend('Vpp')
            legend('Location','SouthEast')
            axis([0 15 0 2]);
            set(gca,'XTick',0:1:15)
            set(gca,'YTick',0:0.25:2)
            grid on
            
            subplot(4,1,4)
            plot(0:15,CKO.suph_cko,0:15,CKO.supl_cko,0:15,CKO.suph_x2,0:15,CKO.supl_x2)
            xlabel('Code');
            ylabel('Voltage');
            title('SUPH/SUPL')
            legend('CKO SUPH','CKO SUPL','x2 SUPH','x2 SUPL')
            legend('Location','SouthEast')
            grid on
            axis([0 15 -1 1]);
            set(gca,'XTick',0:1:15)
            set(gca,'YTick',-1:0.25:1)
            
            set(figH, 'PaperUnits', 'inches');
            set(figH, 'PaperSize', [8.2677 11.6929])
            set(figH, 'PaperPosition', [0.125 0.125 8 11.45 ]);
        end
        function plotSingleLogCKO_BufferGains_realVpp(obj,StructNo,Ch,figH)
            CKO    = obj.SingleLog.DAC(StructNo).(sprintf('%s_CKO_Load',Ch));
            if isnan(CKO.realVpp)
                return
            end
            
            FigNme = sprintf('DAC%d%c_cko_buffergains_realVpp',obj.SingleLog.DAC(StructNo).IPNo,Ch);
            figure(figH)
            set(figH,'name',FigNme,'FileName',FigNme,'Visible','off')
            
            
            
%             plot(0:15,CKO.realVpp,0:15,CKO.pk2Trougth,[CKO.finalCode_cko,CKO.finalCode_cko],[-0.5 0.5])
            P_hdl = plot(0:15,CKO.realVpp,[0,15],[CKO.targetCKO,CKO.targetCKO],[CKO.finalCode_cko,CKO.finalCode_cko],[min(CKO.realVpp) max(CKO.realVpp)],'LineWidth',2);
            set(P_hdl(3),'YData',get(gca,'YLim'))
            ylabel('Voltage');
            title('DAC Output Clock Buffer: realVpp, targetCKO and final code CKO')
            legend('realVpp','targetCKO','final code CKO')
            legend('Location','SouthEast')
%             axis([0 15 0.4 1.4]);
%             set(gca,'XTick',0:3:15)
%             set(gca,'YTick',0.4:0.1:1.4)
            set(gca,'XMinorGrid','on')
            set(gca,'YMinorGrid','on')
            grid on
            set(figH, 'PaperUnits', 'inches');
            set(figH, 'PaperSize', [8.2677 11.6929])
            set(figH, 'PaperPosition', [0.125 0.125 11.45 11.45 ]);
        end
        %--CKO Levels
        function plotSingleLogCKO_Levels(obj,StructNo,Ch,figH)
            CKO    = obj.SingleLog.DAC(StructNo).(sprintf('%s_CKO_Load',Ch));
            FigNme = sprintf('DAC%d%c_cko_levels',obj.SingleLog.DAC(StructNo).IPNo,Ch);
            figure(figH)
            set(figH,'name',FigNme,'FileName',FigNme,'Visible','off')
            
            subplot(2,1,1)
            plot(0:15,pckvcm_to_ptop(obj,CKO.x1),0:15,pckvcm_to_ptop(obj,CKO.x2),0:15,CKO.vpp_cko);
            title('x1PI, x2 and Output Swing Levels');
            legend('x1PI','x2','CKO','location','NorthWest');
            ylabel('Vpp');
            set(gca,'XTick',0:1:15)
            grid on;
            
            subplot(2,1,2)
            plot(0:15,CKO.vpp_cko./pckvcm_to_ptop(obj,CKO.x2));
            title('Output Stage Gain');
            ylabel('Gain');
            xlabel('OutputStage Gain Code');
            set(gca,'XTick',0:1:15)
            
            grid on;
            
            set(figH, 'PaperUnits', 'inches');
            set(figH, 'PaperSize', [8.2677 11.6929])
            set(figH, 'PaperPosition', [0.125 0.125 8 11.45 ]);
        end
        %--CKO Supplies
        function plotSingleLogCKO_Supplies(obj,StructNo,Ch,figH)
            CKO    = obj.SingleLog.DAC(StructNo).(sprintf('%s_CKO_Load',Ch));
            FigNme = sprintf('DAC%d%c_cko_supplies',obj.SingleLog.DAC(StructNo).IPNo,Ch);
            figure(figH)
            set(figH,'name',FigNme,'FileName',FigNme,'Visible','off')
            
            subplot(2,1,1)
            plot(0:15,AVD09Q_cko,[0 15],[fsrfData.vAVD09Q fsrfData.vAVD09Q])
            title('AVD09Q')
            ylabel('Volts')
            grid on;
            axis([0 15 fsrfData.vAVD09Q-0.05 fsrfData.vAVD09Q+0.01])
            set(gca,'XTick',0:1:15)
            set(gca,'YTick',fsrfData.vAVD09Q-0.05:0.01:fsrfData.vAVD09Q+0.01)
            
            
            subplot(2,1,2)
            plot(0:15,AVD09NEG_cko,[0 15],[fsrfData.vAVDNEG09Q fsrfData.vAVDNEG09Q])
            title('AVD09NEGQ')
            ylabel('Volts')
            xlabel('Output Stage Gain Code')
            grid on;
            axis([0 15 fsrfData.vAVDNEG09Q-0.01 fsrfData.vAVDNEG09Q+0.05])
            set(gca,'XTick',0:1:15)
            set(gca,'YTick',fsrfData.vAVDNEG09Q-0.01:0.01:fsrfData.vAVDNEG09Q+0.05)
            
            
            
        end
        %------------------------------------------------
        %---------------------       PI
        function plotSingleLogPI(obj)
            figH_PI     = 1300:1300+numel([obj.SingleLog.ADCIP, obj.SingleLog.DACIP])*3-1;
            handleNo     = 1;
            IPtype       = {'ADC';'DAC'};
            
            for IPtypeNo = 1:numel(IPtype)
                for StructNo = 1:size(obj.SingleLog.(IPtype{IPtypeNo}),2)
                    
                    %obj.SingleLog.(IPtype{IPtypeNo})(StructNo).I_PI_Load
                    %obj.SingleLog.(IPtype{IPtypeNo})(StructNo).Q_PI_Load
                    I = obj.SingleLog.(IPtype{IPtypeNo})(StructNo).I_PI_Load;
                    Q = obj.SingleLog.(IPtype{IPtypeNo})(StructNo).Q_PI_Load;
                    
                    
                    FigNme  = sprintf('%s%d_IQ_channel_gainsweep',IPtype{IPtypeNo},obj.SingleLog.(IPtype{IPtypeNo})(StructNo).IPNo);
                    figure(figH_PI(handleNo))
                    set(figH_PI(handleNo),'name',FigNme,'FileName',FigNme,'Visible','off')
                    subplot(2,1,1)
                    plot(0:(length(I.retvsweep)-1),I.retvsweep,'-+',0:(length(Q.retvsweep)-1),Q.retvsweep,'-*',[I.selcode,I.selcode],[min(I.retvsweep),max(I.retvsweep)])
                    xlabel('Code');
                    ylabel('PtoP single Ended');
                    title(sprintf('%s Channel PI RF Buffer Swept voltage','I and Q Channel'));
                    legend('Ichan','Qchan')
                    grid
                    
                    subplot(2,1,2)
                    plot(0:(length(I.retvsweep)-1),I.pbias,'-+',0:(length(Q.retvsweep)-1),Q.pbias,'-+');
                    xlabel('Code');
                    ylabel('Volts');
                    title('Pbias voltages')
                    legend('I PBIAS','Q PBIAS')
                    grid
                    text(1,-0.4,sprintf('PI code = %d (I channel)',I.selcode));
                    text(1,-0.7,sprintf('PI code = %d (Q channel)',Q.selcode));
                    
                    
                    FigNme  = sprintf('%s%d_I_channel_gainsweep',IPtype{IPtypeNo},obj.SingleLog.(IPtype{IPtypeNo})(StructNo).IPNo);
                    figure(figH_PI(handleNo+1))
                    set(figH_PI(handleNo+1),'name',FigNme,'FileName',FigNme,'Visible','off')
                    subplot(2,1,1)
                    plot(0:(length(I.retvsweep)-1),I.retvsweep,'-+',[I.selcode,I.selcode],[min(I.retvsweep),max(I.retvsweep)])
                    xlabel('Code');
                    ylabel('PtoP single Ended');
                    title(sprintf('%s Channel PI RF Buffer Swept voltage','I Channel'));
                    legend('Ichan')
                    grid
                    
                    subplot(2,1,2)
                    plot(0:(length(I.retvsweep)-1),I.pbias,'-+');
                    xlabel('Code');
                    ylabel('Volts');
                    title('Pbias voltages')
                    legend('I PBIAS')
                    grid
                    text(1,-0.4,sprintf('PI code = %d (I channel)',I.selcode));
                    
                    
                    FigNme  = sprintf('%s%d_Q_channel_gainsweep',IPtype{IPtypeNo},obj.SingleLog.(IPtype{IPtypeNo})(StructNo).IPNo);
                    figure(figH_PI(handleNo+2))
                    set(figH_PI(handleNo+2),'name',FigNme,'FileName',FigNme,'Visible','off')
                    subplot(2,1,1)
                    plot(0:(length(Q.retvsweep)-1),Q.retvsweep,'-+',[Q.selcode,Q.selcode],[min(Q.retvsweep),max(Q.retvsweep)])
                    xlabel('Code');
                    ylabel('PtoP single Ended');
                    title(sprintf('%s Channel PI RF Buffer Swept voltage','Q Channel'));
                    legend('Qchan')
                    grid
                    
                    subplot(2,1,2)
                    plot(0:(length(Q.retvsweep)-1),Q.pbias,'-+');
                    xlabel('Code');
                    ylabel('Volts');
                    title('Pbias voltages')
                    legend('Q PBIAS')
                    grid
                    text(1,-0.4,sprintf('PI code = %d (Q channel)',Q.selcode));
                    
                    handleNo = handleNo+3;
                end
            end
            %set(figH_PLL,'Visible','on')
        end
        %---------------------       Phase Alignment
        %--ADC
        function plotSingleLogADC_Phase_Alignment(obj)
            figH_Phase         = 1400;
            
            M                    = numel(obj.SingleLog.ADC);
            Ch                   = {'I';'Q'};
            samplerPwrSum        = obj.SingleLog.ADC(1).I_Phase_Align.Sumsigma_gain_error;
            samplerfitvalSum     = obj.SingleLog.ADC(1).I_Phase_Align.Sumfitval;
            samplerstepSum       = obj.SingleLog.ADC(1).I_Phase_Align.Sumstep;
            sigma_gain_error     = deal(nan(64,M*2));
            [fitval, step]       = deal(nan(2,M*2));
            SubLeg               = cell(1,M*2);
            
            Indx = 1;
            for StructNo = 1:M
                for ChNo = 1:numel(Ch)
                    Phase = obj.SingleLog.ADC(StructNo).([Ch{ChNo},'_Phase_Align']);
                    sigma_gain_error(:,Indx)    = Phase.sigma_gain_error;
                    fitval(1,Indx)                = Phase.fitval;
                    step(1,Indx)                  = Phase.step;
                    SubLeg{Indx}                = sprintf('ADC%d%c',obj.SingleLog.DAC(StructNo).IPNo,Ch{ChNo});
                    Indx                        = Indx+1;
                end
            end
            
            figure(figH_Phase)
            FigNme = 'ADC_Phase_Align';
            set(figH_Phase,'name',FigNme,'FileName',FigNme,'Visible','off')
            
            plot(sigma_gain_error)
            
            set(gca,'XLim',[-1 65])
            set(gca,'XTick',0:10:60)
            set(gca,'XGrid','on')
            set(gca,'YLim',[0 1.05])
            title('UP Phase Detector Output for the tested channels')
            xlabel('PI CODE offset (Decimal)')
            ylabel('Logic Level')
            legend(SubLeg)
            %set(figH_PLL,'Visible','on')
        end
        %--DAC
        function plotSingleLogDAC_Phase_Alignment(obj)
            figH_Phase         = [1401, 1402];
            
            M                  = numel(obj.SingleLog.DAC);
            Ch                 = {'I';'Q'};
            [up, dwn, bcd]     = deal(nan(64,M*2));
            numOfReadBacks     = obj.SingleLog.DAC(1).Q_Phase_Align.numOfReadBacks;
            [odd, even]        = deal(nan(numOfReadBacks,M*2));
            SubLeg             = cell(1,M*2);
            
            Indx = 1;
            for StructNo = 1:M
                for ChNo = 1:numel(Ch)
                    Phase = obj.SingleLog.DAC(StructNo).([Ch{ChNo},'_Phase_Align']);
                    up(:,Indx)    = Phase.up;
                    dwn(:,Indx)   = Phase.dwn;
                    bcd(:,Indx)   = Phase.bcd;
                    odd(:,Indx)   = Phase.odd;
                    even(:,Indx)  = Phase.even;
                    SubLeg{Indx}  = sprintf('DAC%d%c',obj.SingleLog.DAC(StructNo).IPNo,Ch{ChNo});
                    Indx          = Indx+1;
                end
            end
            
            figure(figH_Phase(1))
            FigNme = 'ClockDataAligner_UPDWN';
            set(figH_Phase(1),'name',FigNme,'FileName',FigNme,'Visible','off')
            
            subplot(2,1,1)
            plot(repmat((0:63)',[1 Indx-1]),up)
            set(gca,'XLim',[0 60])
            set(gca,'XTick',0:4:60)
            set(gca,'XGrid','on')
            set(gca,'YLim',[0 1.05])
            title('UP Phase Detector Output for the tested channels')
            xlabel('PI CODE offset (Decimal)')
            ylabel('Logic Level')
            legend(SubLeg)
            
            subplot(2,1,2)
            plot(repmat((0:63)',[1 Indx-1]),dwn)
            set(gca,'XLim',[0 60])
            set(gca,'XTick',0:4:60)
            set(gca,'XGrid','on')
            set(gca,'YLim',[0 1.05])
            title('DWN Phase Detector Output for the tested channels')
            xlabel('PI CODE offset (Decimal)')
            ylabel('Logic Level')
            legend(SubLeg)
            grid on;
            
            
            
            figure(figH_Phase(2))
            FigNme = 'ClockDataAligner_Check';
            set(figH_Phase(2),'name',FigNme,'FileName',FigNme,'Visible','off')
            
            
            subplot(1,2,1)
            plot(repmat((1:20)',[1 Indx-1]),even)
            set(gca,'XLim',[1 20])
            set(gca,'XTick',2:2:20)
            set(gca,'YLim',[0 63])
            set(gca,'YTick',0:10:63)
            title(sprintf('EVEN PI code\nduring AutoAlign Control'));
            xlabel('Run Number')
            ylabel('PI CODE (Decimal)')
            legend(SubLeg)
            legend('Location','SouthEast')
            grid
            
            
            subplot(1,2,2)
            plot(repmat((1:20)',[1 Indx-1]),odd)
            set(gca,'XLim',[1 20])
            set(gca,'XTick',2:2:20)
            set(gca,'YLim',[0 63])
            set(gca,'YTick',0:10:63)
            title(sprintf('ODD PI code\nduring AutoAlign Control'));
            xlabel('Run Number')
            ylabel('PI CODE (Decimal)')
            legend(SubLeg)
            legend('Location','SouthEast')
            grid
            
            %set(figH_PLL,'Visible','on')
        end
        %---------------------       3GT
        function plotSingleLog3GT(obj)
            figH_3GT     = 1500;
            FigNme = 'LSDB3GTimingOptimisation';
            figure(figH_3GT)
            set(figH_3GT,'name',FigNme,'FileName',FigNme,'Visible','off')
            %obj.SingleLog.DAC(StructNo)
            
            M            = numel(obj.SingleLog.DAC);
            Ch           = {'I';'Q'};
            [VCMp, VCMn] = deal(nan(numel(obj.SingleLog.DAC(1).I_3GT.VCMp),M*2));
            VCMpNorm     = nan(numel(obj.SingleLog.DAC(1).I_3GT.VCMpNorm),M*2);
            VCMnNorm     = nan(numel(obj.SingleLog.DAC(1).I_3GT.VCMnNorm),M*2);
            finalCode    = obj.SingleLog.DAC(1).I_3GT.finalCode;
            SubLeg       = cell(1,M*2);
            
            Indx = 1;
            for StructNo = 1:M
                for ChNo = 1:numel(Ch)
                    O3GT = obj.SingleLog.DAC(StructNo).([Ch{ChNo},'_3GT']);
                    VCMp(:,Indx)          = O3GT.VCMp;
                    VCMn(:,Indx)          = O3GT.VCMn;
                    VCMpNorm(:,Indx)      = O3GT.VCMpNorm;
                    VCMnNorm(:,Indx)      = O3GT.VCMnNorm;
                    SubLeg{Indx}          = sprintf('DAC%d%c',obj.SingleLog.DAC(StructNo).IPNo,Ch{ChNo});
                    Indx                  = Indx+1;
                end
            end
            
            subplot(4,1,1)
            plot(0:7,VCMp);
            title('P Output Common Mode')
            ylabel('ADC Code')
            legend(SubLeg)
            legend('location','NorthEast')
            grid on;
            
            subplot(4,1,2)
            plot(0:7,VCMn);
            title('N Output Common Mode')
            ylabel('ADC Code')
            legend(SubLeg)
            legend('location','SouthEast')
            grid on;
            
            subplot(4,1,3)
            plot(0:7,VCMpNorm,finalCode,1,'ro')
            title('Normalised P Output Common Mode')
            ylabel('Normalised Code')
            legend([SubLeg, 'finalCode'])
            legend('location','SouthEast')
            xlabel('Delay Setting')
            grid on;
            
            subplot(4,1,4)
            plot(0:7,VCMnNorm,finalCode,1,'ro')
            title('Normalised N Output Common Mode')
            ylabel('Normalised Code')
            legend([SubLeg, 'finalCode'])
            legend('location','SouthEast')
            xlabel('Delay Setting')
            grid on;
            
            % Set paper size to A4 Portrait so plot is easy read rather than the
            % default window size. Then save to png
            set(figH_3GT,   'PaperUnits',    'inches');
            Pos        = get(figH_3GT,'Position');
            Pos([3 4]) = [660 520];
            set(figH_3GT,'Position',Pos)
            set(figH_3GT,   'PaperSize',     [8.2677 11.6929])
            set(figH_3GT,   'PaperPosition', [0.125 0.125 8 11.45 ]);
            
            %set(figH_3GT,'Visible','on')
        end
        %---------------------       Calibration
        %--ADC
        function plotSingleLogADC_CAL(obj)
            figH_ADC_CAL = 1600:1600+numel(obj.SingleLog.ADCIP)*2;
            Ch = {'I_Calibration_Load';'Q_Calibration_Load'};
            handleNo     = 1;
            for DACNo = 1:size(obj.SingleLog.DAC,2)
                for ChNo = 1:2
                    
                    FigNme        = sprintf('ADC_%d_%s',obj.SingleLog.ADC(DACNo).IPNo,strrep(Ch{ChNo},'_Load',''));
                    FigH          = figure(figH_ADC_CAL(handleNo));
                    FigH.Position = [376   50   1080   800];
                    set(figH_ADC_CAL(handleNo),'name',FigNme,'FileName',FigNme,'Visible','off')
                    
                    
                    subplot(4,3,1);
                    plot(obj.SingleLog.ADC(DACNo).(Ch{ChNo}).osamp);
                    title('Sampler Offset');
                    xlabel('Cal Iteration')
                    
                    subplot(4,3,2);
                    plot(obj.SingleLog.ADC(DACNo).(Ch{ChNo}).psamp);
                    title('Sampler Power');
                    xlabel('Cal Iteration')
                    
                    subplot(4,3,3);
                    plot(obj.SingleLog.ADC(DACNo).(Ch{ChNo}).sampler);
                    title('Sampler DACs');
                    xlabel('Cal Iteration')
                    
                    
                    subplot(4,3,4);
                    plot(obj.SingleLog.ADC(DACNo).(Ch{ChNo}).odmx1);
                    title('Demux1 Offset');
                    xlabel('Cal Iteration')
                    
                    
                    subplot(4,3,5);
                    plot(obj.SingleLog.ADC(DACNo).(Ch{ChNo}).pdmx1);
                    title('Demux1 Power');
                    xlabel('Cal Iteration')
                    
                    
                    subplot(4,3,6);
                    plot(obj.SingleLog.ADC(DACNo).(Ch{ChNo}).demux1);
                    title('Demux1 DACs');
                    xlabel('Cal Iteration')
                    
                    
                    subplot(4,3,7);
                    plot(obj.SingleLog.ADC(DACNo).(Ch{ChNo}).odmx2);
                    title('Demux2 Offset');
                    xlabel('Cal Iteration')
                    
                    
                    subplot(4,3,8);
                    plot(obj.SingleLog.ADC(DACNo).(Ch{ChNo}).pdmx2);
                    title('Demux2 Power');
                    xlabel('Cal Iteration')
                    
                    
                    subplot(4,3,9);
                    plot(obj.SingleLog.ADC(DACNo).(Ch{ChNo}).demux2);
                    title('Demux2 DACs');
                    xlabel('Cal Iteration')
                    
                    
                    subplot(4,3,10);
                    plot(obj.SingleLog.ADC(DACNo).(Ch{ChNo}).osubadc);
                    title('subADC Offset');
                    xlabel('Cal Iteration')
                    
                    
                    
                    subplot(4,3,11);
                    plot(obj.SingleLog.ADC(DACNo).(Ch{ChNo}).psubadc);
                    title('subADC Power');
                    xlabel('Cal Iteration')
                    
                    
                    subplot(4,3,12);
                    plot(obj.SingleLog.ADC(DACNo).(Ch{ChNo}).subadc);
                    title('subADC DACs');
                    xlabel('Cal Iteration')
                    handleNo = handleNo+1;
                end
                
            end
        end
        %--DAC
        function plotSingleLogDAC_CAL(obj)
            
            figH_DAC_CAL    = 1650:1699+numel(obj.SingleLog.DACIP)*2;
            handleNo     = 1;
            SwCalAboveSlice = 6;
            Ch              = {'I_Calibration_Load';'Q_Calibration_Load'};
            for DACNo = 1:size(obj.SingleLog.DAC,2)
                for ChNo = 1:2
                    
                    FigNme = sprintf('DAC_%d_%s',obj.SingleLog.DAC(DACNo).IPNo,strrep(Ch{ChNo},'_Load',''));
                    FigH = figure(figH_DAC_CAL(handleNo));
                    set(figH_DAC_CAL(handleNo),'name',FigNme,'FileName',FigNme,'Visible','off')
                    
                    %FigH.Position = [680   678   560   420];
                    FigH.Position = [680   520   820   520];
                    
                    subplot(2,3,1);
                    subH = plot([obj.SingleLog.DAC(DACNo).(Ch{ChNo}).cslsb_err(:,1:5), obj.SingleLog.DAC(DACNo).(Ch{ChNo}).cslsb_err(:,6:end)]);
                    set(subH(1:5),'Color',[1, 0, 0])
                    set(subH(6:end),'Color',[0, 0, 1])
                    title('Current Source Error');
                    ylabel('LSBs');
                    set(gca,'XTick', 0:2:size(obj.SingleLog.DAC(DACNo).(Ch{ChNo}).cslsb_err,1))
                    %set(gca,'YLim', [-0.5 0.5])
                    grid on;
                    
                    subplot(2,3,4);
                    plot(round(obj.SingleLog.DAC(DACNo).(Ch{ChNo}).csDAC));
                    title('Current Source Calibration DACs');
                    ylabel('Code');
                    set(gca,'XTick', 0:2:size(obj.SingleLog.DAC(DACNo).(Ch{ChNo}).csDAC,1))
                    %set(gca,'YLim', [0 255])
                    set(gca,'YTick', 0:50:255)
                    grid on;
                    
                    subplot(2,3,2);
                    plot(obj.SingleLog.DAC(DACNo).(Ch{ChNo}).ph_err);
                    title('Clock Phase Error');
                    ylabel('CALADC Code');
                    %legend('PH000','PH090','PH180','PH270','location','NorthEast')
                    set(gca,'XTick', 0:2:size(obj.SingleLog.DAC(DACNo).(Ch{ChNo}).ph_err,1))
                    %set(gca,'YLim', [-50 +50])
                    grid on;
                    
                    %                 subplot(2,3,5);
                    %                 subH = plot(obj.SingleLog.DAC(1).(Ch{ChNo}).phDAC);
                    %                 title('Clock Phase Adjustment DACs');
                    %                 ylabel('Code');
                    %                 set(gca,'XTick', 0:2:size(obj.SingleLog.DAC(1).(Ch{ChNo}).ph_err,1))
                    %                 set(gca,'YLim', [0 31])
                    %                 grid on;
                    
                    subplot(2,3,3);
                    subH = plot([obj.SingleLog.DAC(DACNo).(Ch{ChNo}).swmax(:,SwCalAboveSlice:end),...
                        obj.SingleLog.DAC(DACNo).(Ch{ChNo}).swmean(:,SwCalAboveSlice:end),...
                        obj.SingleLog.DAC(DACNo).(Ch{ChNo}).swmin(:,SwCalAboveSlice:end)]);
                    title('Switch Pulse Measurements');
                    ylabel('CALADC Code');
                    set(gca,'XTick', 0:2:size(obj.SingleLog.DAC(DACNo).(Ch{ChNo}).ph_err,1))
                    %YLim = get(gca,'YLim');
                    %set(gca,'YTick', YLim(1):20:YLim(2)+20)
                    %                 set(gca,'YLim', [mean(obj.SingleLog.DAC(1).I_Calibration_Load.swmean(1,SwCalAboveSlice:end))-100,  mean(obj.SingleLog.DAC(1).I_Calibration_Load.swmean(1,SwCalAboveSlice:end))+100])
                    grid on;
                    Size1 = size(obj.SingleLog.DAC(DACNo).I_Calibration_Load.swmax(:,SwCalAboveSlice:end),2);
                    Size2 = size(obj.SingleLog.DAC(DACNo).I_Calibration_Load.swmean(:,SwCalAboveSlice:end),2);
                    Size3 = size(obj.SingleLog.DAC(DACNo).I_Calibration_Load.swmin(:,SwCalAboveSlice:end),2);
                    set(subH(1:Size1),'Color',[0, 0, 1])                          %Max
                    set(subH(Size1+1:Size1+Size2),'Color',[0, 1, 0])              %Mean
                    set(subH(Size1+Size2+1:Size1+Size2+Size3),'Color',[1, 0, 0])  %Max
                    
                    
                    subplot(2,3,6);
                    plot(round(obj.SingleLog.DAC(DACNo).(Ch{ChNo}).swDAC(:,1:end)));%5*12:end
                    %                 plot(round(obj.SingleLog.DAC(1).(Ch{ChNo}).swDAC(:,SwCalAboveSlice:end)));
                    %                 plot(1:i+1,round(swDAC(1:i+1,:)));
                    title('Switch Calibration DACs');
                    ylabel('Code');
                    set(gca,'XTick', 0:2:size(obj.SingleLog.DAC(DACNo).(Ch{ChNo}).csDAC,1))
                    %set(gca,'YLim', [0 255])
                    %set(gca,'YTick', 0:50:255)
                    %                 axis([0, numOfLoops, 0, 255]) ;
                    grid on;
                    
                    
                    
                    handleNo     = handleNo+1;
                end
            end
            
        end
        
        
        
        
    end
    %---DB(multiple logfiles)
    methods
        function histPLL(obj)
            figure('name','PLL_Histograms')
            binranges = (1:15)';
            [bincounts, HistLeg, LegColor] = histDataPLL_download(obj,'PLL_Load','gaincode',binranges);
            
            
            
            subplot(2,1,1)
            %             subplot(1,1,1)
            h = bar(binranges,bincounts,'hist');
            for hNo = 1:numel(h)
                set(h(hNo),'FaceColor',LegColor{hNo})
                set(h(hNo),'EdgeColor',LegColor{hNo})
                set(h(hNo),'DisplayName',HistLeg{hNo})
            end
            xlabel('Code');
            ylabel('IP Count')
            title('PLL gaincode Histogram')
            YLim    = get(gca,'YLim');
            if YLim(2)<5
                YTick   = YLim(1):1:YLim(2)+1;
            else
                YTick   = YLim(1):round(YLim(2)/5):YLim(2)+round(YLim(2)/7);
            end
            YLim(2) = YTick(end);
            set(gca,'YLim',YLim);
            set(gca,'YTick',YTick);
            legend('show')
            grid('on')
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            [Top,Bot] = deal(nan(size(obj.ADC,2)*2,1));
            for i = 1:size(obj.ADC,2)
                Bot(i)                          = obj.ADC(i).PLL_Load.sweepBot;
                Top(i)                          = obj.ADC(i).PLL_Load.sweepTop;
                
                Bot(i+size(obj.ADC,2))          = obj.DAC(i).PLL_Load.sweepBot;
                Top(i+size(obj.ADC,2))          = obj.DAC(i).PLL_Load.sweepTop;
            end
            %             Bot = min(Bot);
            %             Top = max(Top);
            
            %             binranges = (Bot:1:Top)';
            binranges = (0:1024)';
            [bincounts, HistLeg, LegColor] = histDataPLL_download(obj,'PLL_Load','vcocal_narrow',binranges);
            subplot(2,1,2)
            h = bar(binranges,bincounts,'histc');
            for hNo = 1:numel(h)
                set(h(hNo),'FaceColor',LegColor{hNo})
                set(h(hNo),'EdgeColor',LegColor{hNo})
                set(h(hNo),'DisplayName',HistLeg{hNo})
            end
            xlabel('Band Switch Code');
            ylabel('IP Count')
            title('PLL Band Switch Histogram')
            %             set(gca,'XTick',Bot:64:Top);
            set(gca,'XTick',0:128:1024);
            set(gca,'TickDir','out')
            YLim    = get(gca,'YLim');
            if YLim(2)<5
                YTick   = YLim(1):1:YLim(2)+1;
            else
                YTick   = YLim(1):round(YLim(2)/5):YLim(2)+round(YLim(2)/7);
            end
            %             YTick   = YLim(1):round(YLim(2)/5):YLim(2)+round(YLim(2)/7);
            YLim(2) = YTick(end);
            set(gca,'YLim',YLim);
            set(gca,'YTick',YTick);
            grid('on')
            
        end
        function histPPF(obj)
            figure('name','PPF_Histogram')
            binranges = (1:15)';
            
            [bincounts, HistLeg, LegColor] = histDataPLL_download(obj,'PPF_Load','gaincode',binranges);
            
            subplot(1,1,1)
            h = bar(binranges,bincounts,'hist');
            for hNo = 1:numel(h)
                set(h(hNo),'FaceColor',LegColor{hNo})
                set(h(hNo),'EdgeColor',LegColor{hNo})
                set(h(hNo),'DisplayName',HistLeg{hNo})
            end
            xlabel('Code');
            ylabel('IP Count')
            title('PPF gaincode Histogram')
            YLim    = get(gca,'YLim');
            YTick   = YLim(1):round(YLim(2)/5):YLim(2)+round(YLim(2)/7);
            YLim(2) = YTick(end);
            set(gca,'YLim',YLim);
            set(gca,'YTick',YTick);
            legend('show')
            grid('on')
            
        end
        function [bincounts, HistLeg, LegColor] = histDataPLL_download(obj,StructName,Fname,binranges)
            
            %             binranges  = (1:15)';
            bincounts  = nan(size(binranges,1),4);
            M          = size(obj.ADC,2);
            rawData   = nan(M,4);
            HistLeg    = {'v200 ADC';'v200 DAC';'add3 ADC';'add3 DAC'};
            LegColor   = {[1, 0.6 0.784]; [1, 0, 0]; [0, 1, 1]; [0, 0, 1]};
            
            
            for structNo = 1:M
                if strcmp(obj.ADC(structNo).Type,'v200')
                    rawData(structNo,1) = obj.ADC(structNo).(StructName).(Fname);
                elseif strcmp(obj.ADC(structNo).Type,'add3')
                    rawData(structNo,3) = obj.ADC(structNo).(StructName).(Fname);
                end
                if strcmp(obj.DAC(structNo).Type,'v200')
                    rawData(structNo,2) = obj.DAC(structNo).(StructName).(Fname);
                elseif strcmp(obj.DAC(structNo).Type,'add3')
                    rawData(structNo,4) = obj.DAC(structNo).(StructName).(Fname);
                end
            end
            rawDataLogic = ~isnan(rawData);
            TraceLogic    = any(rawDataLogic,1);
            
            for rawDataColNo = 1:4
                if TraceLogic(rawDataColNo)
                    bincounts(:,rawDataColNo) = histc(rawData(:,rawDataColNo),binranges);
                end
            end
            
            
            bincounts = bincounts(:,TraceLogic);
            HistLeg   = HistLeg(TraceLogic);
            LegColor  = LegColor(TraceLogic);
            
            
            
        end
        
    end
    
    %---------------- Save Plots
    %---SingleLog
    methods
        function saveSingleLogPlots(obj)
            figurecount = findobj('Type','figure');
            figFolders  = {'PLL', 1000:1050; 'PPF', 1100:1150; 'CKBUF' 1200:1250;...
                           'PI' , 1300:1350; 'ADC_Phase_Alignment', 1400;...
                           'DAC_Phase_Alignment', 1401:1402; '3GT', 1500;...
                           'ADC_Calibration',     1600:1649;...
                           'DAC_Calibration',     1650:1699};
            
            for foldNum = 1:size(figFolders,1)
                figurecount = figurecount(isvalid(figurecount));
                FigLogic    = ismember([figurecount.Number],figFolders{foldNum,2});
                if any(FigLogic)
                    figPath  = fullfile(obj.SingleLog.LogPath,strrep(obj.SingleLog.LogName,'.txt',''),figFolders{foldNum,1});
                    figPath  = strrep(figPath,'.TXT','');
                    figPath  = strrep(figPath,'.log','');
                    if ~isdir(figPath)
                        mkdir(figPath)
                    end
                    
                    
                    for i = 1:numel(FigLogic)
                        if FigLogic(i)
                            print(figurecount(i),'-dpng',fullfile(figPath,get(figurecount(i),'FileName')))
                            set(figurecount(i),'Visible','on')
                            saveas(figurecount(i),fullfile(figPath,get(figurecount(i),'FileName')),'fig')
                            close(figurecount(i))
                        end
                    end
                end
            end
        end
    end
    %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    
    %++++++++++++++++++++++++++++++++  XML  +++++++++++++++++++++++++++++
    methods
        function saveSingleLogXML(obj)
            
            
            xmlPath  = fullfile(obj.SingleLog.LogPath,strrep(obj.SingleLog.LogName,'.txt',''));
            xmlPath  = strrep(xmlPath,'.TXT','');
            xmlPath  = strrep(xmlPath,'.log','');
            xmlPath  = fullfile(xmlPath,'MCU_Data.xml');
            
            
            docNode    = com.mathworks.xml.XMLUtils.createDocument(obj.SingleLog.LogName);
            TesterNode = docNode.getDocumentElement;
            TesterNode.setAttribute('Tester',obj.SingleLog.Type);
            
            ADC_IP_No = [obj.SingleLog.ADC.IPNo];
            
            StructNames      = fieldnames(obj.SingleLog.ADC);
            StructNamesLogic = ~ismember(StructNames,{'LogPath';'LogName';'IPNo';'Version';'Type'});
            StructNames      = StructNames(StructNamesLogic);
            
            
            for ADCNo = 1:numel(ADC_IP_No)
                IP_Node = docNode.createElement(sprintf('ADC%d', ADC_IP_No(ADCNo)));
                TesterNode.appendChild(IP_Node);
                for StructNo = 1:numel(StructNames)
                    
                    StructNode = docNode.createElement(['_',StructNames{StructNo}]);
                    IP_Node.appendChild(StructNode);
                    
                    Fnames = fieldnames(obj.SingleLog.ADC(ADCNo).(StructNames{StructNo}));
                    for F_No = 1:numel(Fnames)
                        
                        FieldNode = docNode.createElement(StructNames{StructNo});
                        StructNode.appendChild(FieldNode);
                        
                        DataTMP   = obj.SingleLog.ADC(ADCNo).(StructNames{StructNo}).(Fnames{F_No});
                        F_Size    = size(DataTMP);
                        F_SizeStr = sprintf('%dx',F_Size);
                        F_SizeStr = F_SizeStr(1:end-1);
                        DataTMP   = reshape(DataTMP, [1, numel(DataTMP)]);
                        DataTMP   = num2str(DataTMP,'%g ');
                        
                        FieldNode.setAttribute('Size',F_SizeStr)
                        FieldNode.setAttribute(['_', Fnames{F_No}],DataTMP)
                        
                        
                    end
                    
                end
            end
            
            
            
            
            
            DAC_IP_No = [obj.SingleLog.DAC.IPNo];
            
            StructNames      = fieldnames(obj.SingleLog.DAC);
            StructNamesLogic = ~ismember(StructNames,{'LogPath';'LogName';'IPNo';'Version';'Type'});
            StructNames      = StructNames(StructNamesLogic);
            
            for DACNo = 1:numel(DAC_IP_No)
                IP_Node = docNode.createElement(sprintf('DAC%d', DAC_IP_No(DACNo)));
                TesterNode.appendChild(IP_Node);
                for StructNo = 1:numel(StructNames)
                    
                    StructNode = docNode.createElement(['_',StructNames{StructNo}]);
                    IP_Node.appendChild(StructNode);
                    
                    Fnames = fieldnames(obj.SingleLog.DAC(DACNo).(StructNames{StructNo}));
                    for F_No = 1:numel(Fnames)
                        
                        FieldNode = docNode.createElement(StructNames{StructNo});
                        StructNode.appendChild(FieldNode);
                        
                        DataTMP   = obj.SingleLog.DAC(DACNo).(StructNames{StructNo}).(Fnames{F_No});
                        F_Size    = size(DataTMP);
                        F_SizeStr = sprintf('%dx',F_Size);
                        F_SizeStr = F_SizeStr(1:end-1);
                        DataTMP   = reshape(DataTMP, [1, numel(DataTMP)]);
                        DataTMP   = num2str(DataTMP,'%g ');
                        
                        FieldNode.setAttribute('Size',F_SizeStr)
                        FieldNode.setAttribute(Fnames{F_No},DataTMP)
                    end
                    
                end
            end
            
            xmlwrite(xmlPath,docNode);
        end
    end
    
    
    %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    
    methods %Functions taken from
        function [ result ] = isChannelEnabled(~, bitfiled, channel )
            
            result = 0;
            
            if( channel == 'I' )
                ch = 0;
            elseif ( channel == 'Q' )
                ch = 1;
            else
                return;
            end;
            if( bitand(bitfiled,bitshift(1,ch)) )
                result = 1;
            end;
        end
        function [val]=pckvcm_to_ptop(~,x)
            %This function converts a peak-vcm voltage to PtoP single ended value.
            % - standard measurement circuit, low mismatch for accurate measurements
            % -  Based on Jabba B0 simulation
            val = 3.2450.*x +    0.0964;
        end
        function [val]=rfbuffer_pckvcm_to_ptop(~,x)
            %This function converts a peak-vcm voltage to PtoP single ended value.
            %based on simulation of Jabba B0
            %
            % Note: intentionally different from pckvcm_to_ptop.m
            %
            val=(3.2572*x) + 0.1354;
        end
        function [dataout]=correctpeakdata(~,datain)
            
            dataout(1) = datain(1);
            for ii=2:length(datain)
                if(dataout(ii-1)<datain(ii))
                    dataout(ii)=datain(ii);
                else
                    dataout(ii)=dataout(ii-1)+1e-6;
                end;
            end;
        end
        
        
        %         function getCKBUF(obj)
        %
        %
        %             ckoIndx        = find(strncmp(obj.SingleLog.file,'<:cko',5));
        %             InputIndx      = find(strncmp(obj.SingleLog.file,'[:',2));
        %             %             obj.SingleLog.file(ckoIndx)
        %
        %
        %             CKOFname    = {'pk_A';'tr_A';'pk2Tr_A';'SWEEP_pk2Trougth';'SWEEP_pb_cko';'SWEEP_nb_cko';'SWEEP_pk_cko';...
        %                 'SWEEP_tr_cko';'SWEEP_realVpp';'targetCKO';'finalBiasCodeCKO';'cko_vamprep';'cko_nbias';'cko_pbias';...
        %                 'cko_vdsat';'cko_vnegsup180';'cko_vpossup180';'cko_vnegsup090';'cko_vpossup090';
        %                 'cko_suph';'cko_supl';'cko_x2pb';'cko_x2nb';'vtr000_mean';'vtr090_mean';'vtr180_mean';'vtr270_mean';...
        %                 'nb_x1PI';'nb_x2';'pb_x2';'pb_x1PI'};
        %
        %
        %             %'fromSweepCKO';'measCKO'
        %             % 'cko_nbiasrep';'cko_trougth';'cko_peak';'cko_phadj000';'cko_nbiasintQ';'cko_pbiasintQ';'cko_nbiasintI';'cko_pbiasintI';...
        %
        %
        %
        %             CKOFieldIdentifier = {'[:%cpk_A';'[:%ctr_A';'[:%cpk2Tr_A';'[:%cpk2Trougth';'[:%cpb_cko';'[:%cnb_cko';'[:%cpk_cko';...
        %                 '[:%ctr_cko';'[:%cvpp_cko';'[:%ctargetCKO';'[:%cfinalCode_cko';'[:%ccko_vamprep';'[:%ccko_nbias';'[:%ccko_pbias';...
        %                 '[:%ccko_vdsat';'[:%ccko_vnegsup180';'[:%ccko_vpossup180';'[:%ccko_vnegsup090';'[:%ccko_vpossup090';...
        %                 '[:%csuph_cko';'[:%csupl_cko';'[:%ccko_x2pb';'[:%ccko_x2nb';'[:%cvtr000_mean';'[:%cvtr090_mean';'[:%cvtr180_mean';'[:%cvtr270_mean';...
        %                 '[:%cnb_x1PI';'[:%cnb_x2';'[:%cpb_x2';'[:%cpb_x1PI'};
        %
        %
        %
        %             CKPFname    = {'SWEEP_pk_vcm_x1PI';'SWEEP_pb_x1PI';'SWEEP_nb_x1PI';'SWEEP_pk_vcm_x2';'SWEEP_pb_x2';'SWEEP_nb_x2'...
        %                 ;'x1';'x2';'suph_x2';'supl_x2'};
        %             CKPFieldIdentifier = {'%cpk_vcm_x1PI';'%cpb_x1PI';'%cnb_x1PI';'%cpk_vcm_x2';'%cpb_x2';'%cnb_x2';...
        %                 '%cx1';'%cx2';'%csuph_x2';'%csupl_x2'};
        %
        %
        %
        %             for ckoNo = 1:numel(ckoIndx)
        %                 IPNo       = sscanf(obj.SingleLog.file{ckoIndx(ckoNo)}, '%*s %d %d %*s', [1, inf]);
        %                 ADCIPLogic = obj.SingleLog.ADCIP==IPNo(1);
        %                 DACIPLogic = obj.SingleLog.DACIP==IPNo(1);
        %                 if max(ADCIPLogic)
        %                     IP = 'ADC';
        %                     IPLogic = ADCIPLogic;
        %                 elseif max(DACIPLogic)
        %                     IP = 'DAC';
        %                     IPLogic = DACIPLogic;
        %                 end
        %
        %
        %
        %                 if ckoNo<numel(ckoIndx)
        %                     ckoNoInputIndx = InputIndx(InputIndx>ckoIndx(ckoNo) & InputIndx<ckoIndx(ckoNo+1));
        %                 else
        %                     ckoNoInputIndx = InputIndx(InputIndx>ckoIndx(ckoNo));
        %                 end
        %
        %                 Channel = {'I';'Q'};
        %
        %                 for chNo = 1:numel(Channel)
        %                     if isChannelEnabled(obj,IPNo(2),Channel{chNo})
        %
        %                         CKOstructChannel = sprintf('%c_CKO_Load',Channel{chNo});
        %                         CKPstructChannel = sprintf('%c_CKP_Load',Channel{chNo});
        %                         %----  CKO
        %                         for CKOFieldNo = 1:numel(CKOFname)
        %                             FieldIdentifierTMP = sprintf(CKOFieldIdentifier{CKOFieldNo},lower(Channel{chNo}));
        %                             %                             FnameLogic         = ~cellfun(@isempty, strfind(obj.SingleLog.file(ckoNoInputIndx),FieldIdentifierTMP));
        %                             FnameLogic         = strncmp(obj.SingleLog.file(ckoNoInputIndx),FieldIdentifierTMP,numel(FieldIdentifierTMP));
        %                             if max(FnameLogic)
        %                                 Data = extractLineData(obj,obj.SingleLog.file(ckoNoInputIndx(FnameLogic)));
        %                                 switch CKOFieldIdentifier{CKOFieldNo}
        %                                     case {'[:%cpk_A';'[:%ctr_A';'[:%cpk2Tr_A';'[:%cpk2Trougth';'[:%cpb_cko';'[:%cnb_cko';...
        %                                             '[:%cpk_cko';'[:%ctr_cko';'[:%cvpp_cko';'[:%ctargetCKO';'[:%ccko_vamprep';'[:%ccko_nbias';...
        %                                             '[:%ccko_pbias';'[:%ccko_vdsat';'[:%ccko_vnegsup180';'[:%ccko_vpossup180';'[:%ccko_vnegsup090';...
        %                                             '[:%ccko_vpossup090';'[:%csuph_cko';'[:%csupl_cko';'[:%ccko_x2pb';'[:%ccko_x2nb'}
        %                                         Data = Data/1e4;
        %                                 end
        %                                 if IPNo(1)==obj.SingleLog.(IP)(IPLogic).IPNo
        %                                     obj.SingleLog.(IP)(IPLogic).(CKOstructChannel).(CKOFname{CKOFieldNo}) = Data;
        %                                 end
        %                             end
        %                         end
        %                         if IPNo(1)==obj.SingleLog.(IP)(IPLogic).IPNo
        %                             [obj.SingleLog.(IP)(IPLogic).(CKOstructChannel).fromSweepCKO,...
        %                                 obj.SingleLog.(IP)(IPLogic).(CKOstructChannel).measCKO,...
        %                                 obj.SingleLog.(IP)(IPLogic).(CKOstructChannel).cko_nbiasrep,...
        %                                 obj.SingleLog.(IP)(IPLogic).(CKOstructChannel).cko_trougth,...
        %                                 obj.SingleLog.(IP)(IPLogic).(CKOstructChannel).cko_peak,...
        %                                 obj.SingleLog.(IP)(IPLogic).(CKOstructChannel).cko_phadj000,...
        %                                 obj.SingleLog.(IP)(IPLogic).(CKOstructChannel).cko_nbiasintQ,...
        %                                 obj.SingleLog.(IP)(IPLogic).(CKOstructChannel).cko_pbiasintQ,...
        %                                 obj.SingleLog.(IP)(IPLogic).(CKOstructChannel).cko_nbiasintI,...
        %                                 obj.SingleLog.(IP)(IPLogic).(CKOstructChannel).cko_pbiasintI] = deal(0);
        %                         end
        %
        %
        %                         %----  CKP
        %                         for CKPFieldNo = 1:numel(CKPFname)
        %                             FieldIdentifierTMP = sprintf(CKPFieldIdentifier{CKPFieldNo},lower(Channel{chNo}));
        %                             %                             FnameLogic         = ~cellfun(@isempty, strfind(obj.SingleLog.file(ckoNoInputIndx),FieldIdentifierTMP));
        %                             FnameLogic         = strncmp(obj.SingleLog.file(ckoNoInputIndx),FieldIdentifierTMP,numel(FieldIdentifierTMP));
        %                             if max(FnameLogic)
        %                                 Data = extractLineData(obj,obj.SingleLog.file(ckoNoInputIndx(FnameLogic)));
        %                                 switch CKPFname{CKPFieldNo}
        %                                     case {'SWEEP_pk_vcm_x1PI';'SWEEP_pb_x1PI';'SWEEP_nb_x1PI';'SWEEP_pk_vcm_x2';'SWEEP_pb_x2';...
        %                                             'SWEEP_nb_x2';'x1';'x2';'suph_x2';'supl_x2'}
        %                                         Data = Data/1e4;
        %                                 end
        %                                 if IPNo(1)==obj.SingleLog.(IP)(IPLogic).IPNo
        %                                     obj.SingleLog.(IP)(IPLogic).(CKPstructChannel).(CKPFname{CKPFieldNo}) = Data;
        %                                 end
        %                             end
        %                         end
        %                         if IPNo(1)==obj.SingleLog.(IP)(IPLogic).IPNo
        %                             [obj.SingleLog.(IP)(IPLogic).(CKPstructChannel).targetVx1PI,...
        %                                 obj.SingleLog.(IP)(IPLogic).(CKPstructChannel).targetVx2] = deal(0.2);
        %                         end
        %                     end
        %
        %                 end
        %
        %             end
        %
        %         end
        
    end
    
    
   
    
end

