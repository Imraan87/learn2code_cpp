
#pragma once

struct pll_t
{
    int index;
    float freq;

    char maxind;
    char gaincode;
    float target;
    float maxvoltage;
    float nbias[6];
	float pbias[6];
	float pk_vcm[6];
	float vsign_wide[9];
	char act_wide[9];
	int vcocal_wide;
	bool sign_fallingedge_flag;
	float vsign_wide_f;
	float act_wide_f;
	float vcocal_wide_F;
	float ntune[288];
	float ptune[288];
	int sweepTop;
	int sweepBot;
	float vsign_narrow[288];
	char act_narrow[288];
	int vcocal_narrow;
};

struct ppf_t
{
	char maxind;
	char gaincode;
	float maxvoltage;
	float pffbufflevel;
	float nbias[14];
	float pbias[14];
	float pk_vcm[14];
};


struct pi_t
{
	float target;
	float maxvoltage;
	char selcode;
	char maxind;
	float retvsweep[12];
	float pbias[12];
	float pk_vcm[12];
};

struct phase_align_ADC_t
{
	float Sumsigma_gain_error;
	float Sumfitval;
	char sigma_gain_error;
	char fitval;
};

struct phase_align_DAC_t
{
	char up[64];
	char dwn[64];
	int bcd[64];
	char numOfReadBacks;
	char odd[20];
	char even[20];
};


struct adc_t
{
	char ip_no;
	pll_t pll;
	ppf_t ppf;
	pi_t pi[2];
	phase_align_ADC_t phase_align[2];
};

struct dac_t
{
	char ip_no;
	pll_t pll;
	ppf_t ppf;
	pi_t pi[2];
	phase_align_ADC_t phase_align[2];
};





