
#pragma once

struct pll_t
{
    int index;
    float freq;

    unsigned char maxind;
    unsigned char gaincode;
    float target;
    float maxvoltage;
    float nbias[6];
	float pbias[6];
	float pk_vcm[6];
	float vsign_wide[9];
	unsigned char act_wide[9];
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
	unsigned char act_narrow[288];
	int vcocal_narrow;
};
