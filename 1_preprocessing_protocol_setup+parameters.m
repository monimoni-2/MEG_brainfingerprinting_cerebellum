%% == Initiate Brainstorm and protocol setup =============================
% clc; clear;

cd './brainstorm3'

% Start Brainstorm w/o GUI
if ~brainstorm('status')
    brainstorm nogui % If brainstorm ain't running, run it with no GUI
end

% Create protocol; if it already exists, load it
faProtocol.name = 'fa_fingerprint'; % for HCs, hcProtocol.name = "hc_fingerprint"
 if exist('./brainstorm_db/fa_fingerprint', 'file') == 7
    faProtocol.index = bst_get('Protocol', faProtocol.name);
    bst_set('iProtocol', faProtocol.index);
 else
    gui_brainstorm('CreateProtocol', faProtocol.name, 0, 0);
 end

%% == Parameters =========================================================
% MEG datasets storage
mydirMEG = './data/FA_subjects'; % for HCs, './data/HC_subjects'

% Dir to save progress report
mydirBST = './output/reports';

% Dir of database
mydirDB = './data';

% Frequencies to filter with the notch (European power line 50Hz and harmonics)
freqs_notch = [50, 100, 150];

% Filters
filt.highpass = 0.1; % 0.3 max, try both 0.1 or 0.3. Here I choose to use 0.1
filt.lowpass = 0.; % 0: no filter

filter_low.deltaLow = 1.;
filter_high.deltaHigh = 4.;
filter_low.thetaLow = 4.;
filter_high.thetaHigh = 8.;
filter_low.alphaLow = 8.;
filter_high.alphaHigh = 13.;
filter_low.betaLow = 13.;
filter_high.betaHigh = 30.;
filter_low.gammaLow = 30.;
filter_high.gammaHigh = 50.;
filter_low.hgammaLow = 50.;
filter_high.hgammaHigh = 150.;

% Window length and overlap for PSD Welch method
win_length = 2; % sec
win_overlap = 50; % percentage
