Return-Path: <linux-efi+bounces-61-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383187F1BB8
	for <lists+linux-efi@lfdr.de>; Mon, 20 Nov 2023 18:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFBA1281B10
	for <lists+linux-efi@lfdr.de>; Mon, 20 Nov 2023 17:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB0023766;
	Mon, 20 Nov 2023 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qp77GZ34"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EEB92;
	Mon, 20 Nov 2023 09:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700502995; x=1732038995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oTcjYvCra6XqK62EPzxDzMTRB4UknSaQbXzLbHq6eZ8=;
  b=Qp77GZ34TssNgNTKAA2gKfWmL96Z7PW0WyyvWCR70Jia7Hm//SjWkU4J
   cHM/1YGVsNkHKRWUA/URk9EH1G1FucUgbyt0CoOVYjTva6tyuS8Jeby1Z
   YiItp32jjPVH1pwCKdCvOuayj5UVI7/JYx0sF53q8ZLht9OWrgRRboKYj
   2SxBgrT0JhN9hpgtwrVL8QVRSssr47YFt6ShM/+vFMJEcjXDXqO2ue/eh
   aa2aoSfWno2uIuvQ3eZR6ybY4x+vo28dIoh1d82YR/mxUKY3aZY7NXRjv
   +2zFeR7RMR+84ySR5b1jKnP1wgAaUCrgf2Y0XOy94GmcfN56PEbqVRkUC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="4865095"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="4865095"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 09:56:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="939855507"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="939855507"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 20 Nov 2023 09:56:28 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r58VW-0006ky-1O;
	Mon, 20 Nov 2023 17:56:26 +0000
Date: Tue, 21 Nov 2023 01:56:10 +0800
From: kernel test robot <lkp@intel.com>
To: Raag Jadav <raag.jadav@intel.com>, mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com, rafael@kernel.org,
	lenb@kernel.org, robert.moore@intel.com, ardb@kernel.org,
	will@kernel.org, mark.rutland@arm.com
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: Re: [PATCH v1 3/6] ACPI: bus: update acpi_dev_hid_uid_match() to
 support multiple types
Message-ID: <202311210130.XgHcppYD-lkp@intel.com>
References: <20231120120837.3002-4-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120120837.3002-4-raag.jadav@intel.com>

Hi Raag,

kernel test robot noticed the following build errors:

[auto build test ERROR on 5bd262f4820f2d5645d8ff1f251ef8e96715ef84]

url:    https://github.com/intel-lab-lkp/linux/commits/Raag-Jadav/compiler-h-Introduce-helpers-for-identifying-array-and-pointer-types/20231120-201140
base:   5bd262f4820f2d5645d8ff1f251ef8e96715ef84
patch link:    https://lore.kernel.org/r/20231120120837.3002-4-raag.jadav%40intel.com
patch subject: [PATCH v1 3/6] ACPI: bus: update acpi_dev_hid_uid_match() to support multiple types
config: openrisc-allmodconfig (https://download.01.org/0day-ci/archive/20231121/202311210130.XgHcppYD-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311210130.XgHcppYD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311210130.XgHcppYD-lkp@intel.com/

All errors (new ones prefixed by >>):

   sound/soc/codecs/rt5645.c: In function 'rt5645_i2c_probe':
>> sound/soc/codecs/rt5645.c:3933:87: error: macro "acpi_dev_hid_uid_match" passed 3 arguments, but takes just 2
    3933 |                 if (acpi_dev_hid_uid_match(ACPI_COMPANION(&i2c->dev), "10EC3270", NULL))
         |                                                                                       ^
   In file included from include/linux/i2c.h:13,
                    from sound/soc/codecs/rt5645.c:14:
   include/linux/acpi.h:761: note: macro "acpi_dev_hid_uid_match" defined here
     761 | #define acpi_dev_hid_uid_match(adev, uid2)      (adev && false)
         | 
>> sound/soc/codecs/rt5645.c:3933:21: error: 'acpi_dev_hid_uid_match' undeclared (first use in this function)
    3933 |                 if (acpi_dev_hid_uid_match(ACPI_COMPANION(&i2c->dev), "10EC3270", NULL))
         |                     ^~~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/rt5645.c:3933:21: note: each undeclared identifier is reported only once for each function it appears in


vim +/acpi_dev_hid_uid_match +3933 sound/soc/codecs/rt5645.c

48edaa4b4fb6e7 Oder Chiou           2015-06-12  3885  
35b88858050025 Stephen Kitt         2022-04-05  3886  static int rt5645_i2c_probe(struct i2c_client *i2c)
1319b2f6a56523 Oder Chiou           2014-04-28  3887  {
452801cabc0a0f Hans de Goede        2021-03-07  3888  	struct rt5645_platform_data *pdata = NULL;
78f5605c0329f8 Hans de Goede        2018-01-02  3889  	const struct dmi_system_id *dmi_data;
1319b2f6a56523 Oder Chiou           2014-04-28  3890  	struct rt5645_priv *rt5645;
9fc114c5d7af6c Koro Chen            2015-07-17  3891  	int ret, i;
1319b2f6a56523 Oder Chiou           2014-04-28  3892  	unsigned int val;
49abc6cd587348 Bard Liao            2015-11-10  3893  	struct regmap *regmap;
1319b2f6a56523 Oder Chiou           2014-04-28  3894  
1319b2f6a56523 Oder Chiou           2014-04-28  3895  	rt5645 = devm_kzalloc(&i2c->dev, sizeof(struct rt5645_priv),
1319b2f6a56523 Oder Chiou           2014-04-28  3896  				GFP_KERNEL);
1319b2f6a56523 Oder Chiou           2014-04-28  3897  	if (rt5645 == NULL)
1319b2f6a56523 Oder Chiou           2014-04-28  3898  		return -ENOMEM;
1319b2f6a56523 Oder Chiou           2014-04-28  3899  
f3fa1bbd836a7d Oder Chiou           2014-09-19  3900  	rt5645->i2c = i2c;
1319b2f6a56523 Oder Chiou           2014-04-28  3901  	i2c_set_clientdata(i2c, rt5645);
1319b2f6a56523 Oder Chiou           2014-04-28  3902  
78f5605c0329f8 Hans de Goede        2018-01-02  3903  	dmi_data = dmi_first_match(dmi_platform_data);
78f5605c0329f8 Hans de Goede        2018-01-02  3904  	if (dmi_data) {
78f5605c0329f8 Hans de Goede        2018-01-02  3905  		dev_info(&i2c->dev, "Detected %s platform\n", dmi_data->ident);
78f5605c0329f8 Hans de Goede        2018-01-02  3906  		pdata = dmi_data->driver_data;
78f5605c0329f8 Hans de Goede        2018-01-02  3907  	}
78f5605c0329f8 Hans de Goede        2018-01-02  3908  
48edaa4b4fb6e7 Oder Chiou           2015-06-12  3909  	if (pdata)
1319b2f6a56523 Oder Chiou           2014-04-28  3910  		rt5645->pdata = *pdata;
9761c0f65d3a4c Bard Liao            2015-11-30  3911  	else if (rt5645_check_dp(&i2c->dev))
48edaa4b4fb6e7 Oder Chiou           2015-06-12  3912  		rt5645_parse_dt(rt5645, &i2c->dev);
5954c4a1455c3b Pierre-Louis Bossart 2018-01-11  3913  	else
5954c4a1455c3b Pierre-Louis Bossart 2018-01-11  3914  		rt5645->pdata = jd_mode3_platform_data;
0b0cefc8fd105f Oder Chiou           2015-06-10  3915  
4999b0214b05a0 Takashi Iwai         2017-06-29  3916  	if (quirk != -1) {
4999b0214b05a0 Takashi Iwai         2017-06-29  3917  		rt5645->pdata.in2_diff = QUIRK_IN2_DIFF(quirk);
4999b0214b05a0 Takashi Iwai         2017-06-29  3918  		rt5645->pdata.level_trigger_irq = QUIRK_LEVEL_IRQ(quirk);
4999b0214b05a0 Takashi Iwai         2017-06-29  3919  		rt5645->pdata.inv_jd1_1 = QUIRK_INV_JD1_1(quirk);
28c988492cf656 Chris Chiu           2021-01-11  3920  		rt5645->pdata.inv_hp_pol = QUIRK_INV_HP_POL(quirk);
4999b0214b05a0 Takashi Iwai         2017-06-29  3921  		rt5645->pdata.jd_mode = QUIRK_JD_MODE(quirk);
4999b0214b05a0 Takashi Iwai         2017-06-29  3922  		rt5645->pdata.dmic1_data_pin = QUIRK_DMIC1_DATA_PIN(quirk);
4999b0214b05a0 Takashi Iwai         2017-06-29  3923  		rt5645->pdata.dmic2_data_pin = QUIRK_DMIC2_DATA_PIN(quirk);
4999b0214b05a0 Takashi Iwai         2017-06-29  3924  	}
0b0cefc8fd105f Oder Chiou           2015-06-10  3925  
3f004d2dc118e5 Hans de Goede        2021-03-07  3926  	if (has_acpi_companion(&i2c->dev)) {
3f004d2dc118e5 Hans de Goede        2021-03-07  3927  		if (cht_rt5645_gpios) {
21f603482a6bdc Chris Chiu           2021-01-11  3928  			if (devm_acpi_dev_add_driver_gpios(&i2c->dev, cht_rt5645_gpios))
21f603482a6bdc Chris Chiu           2021-01-11  3929  				dev_dbg(&i2c->dev, "Failed to add driver gpios\n");
3f004d2dc118e5 Hans de Goede        2021-03-07  3930  		}
3f004d2dc118e5 Hans de Goede        2021-03-07  3931  
3f004d2dc118e5 Hans de Goede        2021-03-07  3932  		/* The ALC3270 package has the headset-mic pin not-connected */
3f004d2dc118e5 Hans de Goede        2021-03-07 @3933  		if (acpi_dev_hid_uid_match(ACPI_COMPANION(&i2c->dev), "10EC3270", NULL))
3f004d2dc118e5 Hans de Goede        2021-03-07  3934  			rt5645->pdata.no_headset_mic = true;
3f004d2dc118e5 Hans de Goede        2021-03-07  3935  	}
21f603482a6bdc Chris Chiu           2021-01-11  3936  
25c8888ad65f81 Axel Lin             2015-06-12  3937  	rt5645->gpiod_hp_det = devm_gpiod_get_optional(&i2c->dev, "hp-detect",
25c8888ad65f81 Axel Lin             2015-06-12  3938  						       GPIOD_IN);
0b0cefc8fd105f Oder Chiou           2015-06-10  3939  
0b0cefc8fd105f Oder Chiou           2015-06-10  3940  	if (IS_ERR(rt5645->gpiod_hp_det)) {
cec55827dde1e8 Pierre-Louis Bossart 2017-02-01  3941  		dev_info(&i2c->dev, "failed to initialize gpiod\n");
cec55827dde1e8 Pierre-Louis Bossart 2017-02-01  3942  		ret = PTR_ERR(rt5645->gpiod_hp_det);
cec55827dde1e8 Pierre-Louis Bossart 2017-02-01  3943  		/*
cec55827dde1e8 Pierre-Louis Bossart 2017-02-01  3944  		 * Continue if optional gpiod is missing, bail for all other
cec55827dde1e8 Pierre-Louis Bossart 2017-02-01  3945  		 * errors, including -EPROBE_DEFER
cec55827dde1e8 Pierre-Louis Bossart 2017-02-01  3946  		 */
cec55827dde1e8 Pierre-Louis Bossart 2017-02-01  3947  		if (ret != -ENOENT)
cec55827dde1e8 Pierre-Louis Bossart 2017-02-01  3948  			return ret;
78c34fd42e3b0e Fang, Yang A         2015-04-24  3949  	}
1319b2f6a56523 Oder Chiou           2014-04-28  3950  
9fc114c5d7af6c Koro Chen            2015-07-17  3951  	for (i = 0; i < ARRAY_SIZE(rt5645->supplies); i++)
9fc114c5d7af6c Koro Chen            2015-07-17  3952  		rt5645->supplies[i].supply = rt5645_supply_names[i];
9fc114c5d7af6c Koro Chen            2015-07-17  3953  
9fc114c5d7af6c Koro Chen            2015-07-17  3954  	ret = devm_regulator_bulk_get(&i2c->dev,
9fc114c5d7af6c Koro Chen            2015-07-17  3955  				      ARRAY_SIZE(rt5645->supplies),
9fc114c5d7af6c Koro Chen            2015-07-17  3956  				      rt5645->supplies);
9fc114c5d7af6c Koro Chen            2015-07-17  3957  	if (ret) {
9fc114c5d7af6c Koro Chen            2015-07-17  3958  		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
9fc114c5d7af6c Koro Chen            2015-07-17  3959  		return ret;
9fc114c5d7af6c Koro Chen            2015-07-17  3960  	}
9fc114c5d7af6c Koro Chen            2015-07-17  3961  
9fc114c5d7af6c Koro Chen            2015-07-17  3962  	ret = regulator_bulk_enable(ARRAY_SIZE(rt5645->supplies),
9fc114c5d7af6c Koro Chen            2015-07-17  3963  				    rt5645->supplies);
9fc114c5d7af6c Koro Chen            2015-07-17  3964  	if (ret) {
9fc114c5d7af6c Koro Chen            2015-07-17  3965  		dev_err(&i2c->dev, "Failed to enable supplies: %d\n", ret);
9fc114c5d7af6c Koro Chen            2015-07-17  3966  		return ret;
9fc114c5d7af6c Koro Chen            2015-07-17  3967  	}
9fc114c5d7af6c Koro Chen            2015-07-17  3968  
49abc6cd587348 Bard Liao            2015-11-10  3969  	regmap = devm_regmap_init_i2c(i2c, &temp_regmap);
49abc6cd587348 Bard Liao            2015-11-10  3970  	if (IS_ERR(regmap)) {
49abc6cd587348 Bard Liao            2015-11-10  3971  		ret = PTR_ERR(regmap);
49abc6cd587348 Bard Liao            2015-11-10  3972  		dev_err(&i2c->dev, "Failed to allocate temp register map: %d\n",
49abc6cd587348 Bard Liao            2015-11-10  3973  			ret);
7883c193d7ae1c Zheyu Ma             2022-05-10  3974  		goto err_enable;
49abc6cd587348 Bard Liao            2015-11-10  3975  	}
0c279a590fde66 Akshu Agrawal        2017-11-09  3976  
0c279a590fde66 Akshu Agrawal        2017-11-09  3977  	/*
0c279a590fde66 Akshu Agrawal        2017-11-09  3978  	 * Read after 400msec, as it is the interval required between
0c279a590fde66 Akshu Agrawal        2017-11-09  3979  	 * read and power On.
0c279a590fde66 Akshu Agrawal        2017-11-09  3980  	 */
0c279a590fde66 Akshu Agrawal        2017-11-09  3981  	msleep(TIME_TO_POWER_MS);
bf62eec5cdecbe Shuming Fan          2023-07-05  3982  	ret = regmap_read(regmap, RT5645_VENDOR_ID2, &val);
bf62eec5cdecbe Shuming Fan          2023-07-05  3983  	if (ret < 0) {
bf62eec5cdecbe Shuming Fan          2023-07-05  3984  		dev_err(&i2c->dev, "Failed to read: 0x%02X\n, ret = %d", RT5645_VENDOR_ID2, ret);
bf62eec5cdecbe Shuming Fan          2023-07-05  3985  		goto err_enable;
bf62eec5cdecbe Shuming Fan          2023-07-05  3986  	}
5c4ca99df718f6 Bard Liao            2015-01-21  3987  
5c4ca99df718f6 Bard Liao            2015-01-21  3988  	switch (val) {
5c4ca99df718f6 Bard Liao            2015-01-21  3989  	case RT5645_DEVICE_ID:
49abc6cd587348 Bard Liao            2015-11-10  3990  		rt5645->regmap = devm_regmap_init_i2c(i2c, &rt5645_regmap);
5c4ca99df718f6 Bard Liao            2015-01-21  3991  		rt5645->codec_type = CODEC_TYPE_RT5645;
5c4ca99df718f6 Bard Liao            2015-01-21  3992  		break;
5c4ca99df718f6 Bard Liao            2015-01-21  3993  	case RT5650_DEVICE_ID:
49abc6cd587348 Bard Liao            2015-11-10  3994  		rt5645->regmap = devm_regmap_init_i2c(i2c, &rt5650_regmap);
5c4ca99df718f6 Bard Liao            2015-01-21  3995  		rt5645->codec_type = CODEC_TYPE_RT5650;
5c4ca99df718f6 Bard Liao            2015-01-21  3996  		break;
5c4ca99df718f6 Bard Liao            2015-01-21  3997  	default:
1319b2f6a56523 Oder Chiou           2014-04-28  3998  		dev_err(&i2c->dev,
8f68e80f5f4349 Jarkko Nikula        2015-06-25  3999  			"Device with ID register %#x is not rt5645 or rt5650\n",
5c4ca99df718f6 Bard Liao            2015-01-21  4000  			val);
9fc114c5d7af6c Koro Chen            2015-07-17  4001  		ret = -ENODEV;
9fc114c5d7af6c Koro Chen            2015-07-17  4002  		goto err_enable;
d12d6c4ef252dd John Lin             2015-05-12  4003  	}
d12d6c4ef252dd John Lin             2015-05-12  4004  
49abc6cd587348 Bard Liao            2015-11-10  4005  	if (IS_ERR(rt5645->regmap)) {
49abc6cd587348 Bard Liao            2015-11-10  4006  		ret = PTR_ERR(rt5645->regmap);
49abc6cd587348 Bard Liao            2015-11-10  4007  		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
49abc6cd587348 Bard Liao            2015-11-10  4008  			ret);
7883c193d7ae1c Zheyu Ma             2022-05-10  4009  		goto err_enable;
49abc6cd587348 Bard Liao            2015-11-10  4010  	}
49abc6cd587348 Bard Liao            2015-11-10  4011  
1319b2f6a56523 Oder Chiou           2014-04-28  4012  	regmap_write(rt5645->regmap, RT5645_RESET, 0);
1319b2f6a56523 Oder Chiou           2014-04-28  4013  
50f510a33c7c90 Bard Liao            2017-10-30  4014  	regmap_read(regmap, RT5645_VENDOR_ID, &val);
50f510a33c7c90 Bard Liao            2017-10-30  4015  	rt5645->v_id = val & 0xff;
50f510a33c7c90 Bard Liao            2017-10-30  4016  
56986b07d17b4a Bard Liao            2017-11-22  4017  	regmap_write(rt5645->regmap, RT5645_AD_DA_MIXER, 0x8080);
56986b07d17b4a Bard Liao            2017-11-22  4018  
aa98697c7dbd8d Shuming Fan          2023-08-18  4019  	ret = regmap_multi_reg_write(rt5645->regmap, init_list,
1319b2f6a56523 Oder Chiou           2014-04-28  4020  				    ARRAY_SIZE(init_list));
1319b2f6a56523 Oder Chiou           2014-04-28  4021  	if (ret != 0)
1319b2f6a56523 Oder Chiou           2014-04-28  4022  		dev_warn(&i2c->dev, "Failed to apply regmap patch: %d\n", ret);
1319b2f6a56523 Oder Chiou           2014-04-28  4023  
5c4ca99df718f6 Bard Liao            2015-01-21  4024  	if (rt5645->codec_type == CODEC_TYPE_RT5650) {
aa98697c7dbd8d Shuming Fan          2023-08-18  4025  		ret = regmap_multi_reg_write(rt5645->regmap, rt5650_init_list,
5c4ca99df718f6 Bard Liao            2015-01-21  4026  				    ARRAY_SIZE(rt5650_init_list));
5c4ca99df718f6 Bard Liao            2015-01-21  4027  		if (ret != 0)
5c4ca99df718f6 Bard Liao            2015-01-21  4028  			dev_warn(&i2c->dev, "Apply rt5650 patch failed: %d\n",
5c4ca99df718f6 Bard Liao            2015-01-21  4029  					   ret);
5c4ca99df718f6 Bard Liao            2015-01-21  4030  	}
5c4ca99df718f6 Bard Liao            2015-01-21  4031  
105e56f1ec335a Bard Liao            2017-06-27  4032  	regmap_update_bits(rt5645->regmap, RT5645_CLSD_OUT_CTRL, 0xc0, 0xc0);
105e56f1ec335a Bard Liao            2017-06-27  4033  
1319b2f6a56523 Oder Chiou           2014-04-28  4034  	if (rt5645->pdata.in2_diff)
1319b2f6a56523 Oder Chiou           2014-04-28  4035  		regmap_update_bits(rt5645->regmap, RT5645_IN2_CTRL,
1319b2f6a56523 Oder Chiou           2014-04-28  4036  					RT5645_IN_DF2, RT5645_IN_DF2);
1319b2f6a56523 Oder Chiou           2014-04-28  4037  
ac4fc3eeb79e06 Bard Liao            2015-05-05  4038  	if (rt5645->pdata.dmic1_data_pin || rt5645->pdata.dmic2_data_pin) {
1319b2f6a56523 Oder Chiou           2014-04-28  4039  		regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
1319b2f6a56523 Oder Chiou           2014-04-28  4040  			RT5645_GP2_PIN_MASK, RT5645_GP2_PIN_DMIC1_SCL);
ac4fc3eeb79e06 Bard Liao            2015-05-05  4041  	}
1319b2f6a56523 Oder Chiou           2014-04-28  4042  	switch (rt5645->pdata.dmic1_data_pin) {
1319b2f6a56523 Oder Chiou           2014-04-28  4043  	case RT5645_DMIC_DATA_IN2N:
1319b2f6a56523 Oder Chiou           2014-04-28  4044  		regmap_update_bits(rt5645->regmap, RT5645_DMIC_CTRL1,
1319b2f6a56523 Oder Chiou           2014-04-28  4045  			RT5645_DMIC_1_DP_MASK, RT5645_DMIC_1_DP_IN2N);
1319b2f6a56523 Oder Chiou           2014-04-28  4046  		break;
1319b2f6a56523 Oder Chiou           2014-04-28  4047  
1319b2f6a56523 Oder Chiou           2014-04-28  4048  	case RT5645_DMIC_DATA_GPIO5:
a094935e4ebdf5 Bard Liao            2015-08-03  4049  		regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
a094935e4ebdf5 Bard Liao            2015-08-03  4050  			RT5645_I2S2_DAC_PIN_MASK, RT5645_I2S2_DAC_PIN_GPIO);
1319b2f6a56523 Oder Chiou           2014-04-28  4051  		regmap_update_bits(rt5645->regmap, RT5645_DMIC_CTRL1,
1319b2f6a56523 Oder Chiou           2014-04-28  4052  			RT5645_DMIC_1_DP_MASK, RT5645_DMIC_1_DP_GPIO5);
1319b2f6a56523 Oder Chiou           2014-04-28  4053  		regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
1319b2f6a56523 Oder Chiou           2014-04-28  4054  			RT5645_GP5_PIN_MASK, RT5645_GP5_PIN_DMIC1_SDA);
1319b2f6a56523 Oder Chiou           2014-04-28  4055  		break;
1319b2f6a56523 Oder Chiou           2014-04-28  4056  
1319b2f6a56523 Oder Chiou           2014-04-28  4057  	case RT5645_DMIC_DATA_GPIO11:
1319b2f6a56523 Oder Chiou           2014-04-28  4058  		regmap_update_bits(rt5645->regmap, RT5645_DMIC_CTRL1,
1319b2f6a56523 Oder Chiou           2014-04-28  4059  			RT5645_DMIC_1_DP_MASK, RT5645_DMIC_1_DP_GPIO11);
1319b2f6a56523 Oder Chiou           2014-04-28  4060  		regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
1319b2f6a56523 Oder Chiou           2014-04-28  4061  			RT5645_GP11_PIN_MASK,
1319b2f6a56523 Oder Chiou           2014-04-28  4062  			RT5645_GP11_PIN_DMIC1_SDA);
1319b2f6a56523 Oder Chiou           2014-04-28  4063  		break;
1319b2f6a56523 Oder Chiou           2014-04-28  4064  
1319b2f6a56523 Oder Chiou           2014-04-28  4065  	default:
1319b2f6a56523 Oder Chiou           2014-04-28  4066  		break;
1319b2f6a56523 Oder Chiou           2014-04-28  4067  	}
1319b2f6a56523 Oder Chiou           2014-04-28  4068  
1319b2f6a56523 Oder Chiou           2014-04-28  4069  	switch (rt5645->pdata.dmic2_data_pin) {
1319b2f6a56523 Oder Chiou           2014-04-28  4070  	case RT5645_DMIC_DATA_IN2P:
1319b2f6a56523 Oder Chiou           2014-04-28  4071  		regmap_update_bits(rt5645->regmap, RT5645_DMIC_CTRL1,
1319b2f6a56523 Oder Chiou           2014-04-28  4072  			RT5645_DMIC_2_DP_MASK, RT5645_DMIC_2_DP_IN2P);
1319b2f6a56523 Oder Chiou           2014-04-28  4073  		break;
1319b2f6a56523 Oder Chiou           2014-04-28  4074  
1319b2f6a56523 Oder Chiou           2014-04-28  4075  	case RT5645_DMIC_DATA_GPIO6:
1319b2f6a56523 Oder Chiou           2014-04-28  4076  		regmap_update_bits(rt5645->regmap, RT5645_DMIC_CTRL1,
1319b2f6a56523 Oder Chiou           2014-04-28  4077  			RT5645_DMIC_2_DP_MASK, RT5645_DMIC_2_DP_GPIO6);
1319b2f6a56523 Oder Chiou           2014-04-28  4078  		regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
1319b2f6a56523 Oder Chiou           2014-04-28  4079  			RT5645_GP6_PIN_MASK, RT5645_GP6_PIN_DMIC2_SDA);
1319b2f6a56523 Oder Chiou           2014-04-28  4080  		break;
1319b2f6a56523 Oder Chiou           2014-04-28  4081  
1319b2f6a56523 Oder Chiou           2014-04-28  4082  	case RT5645_DMIC_DATA_GPIO10:
1319b2f6a56523 Oder Chiou           2014-04-28  4083  		regmap_update_bits(rt5645->regmap, RT5645_DMIC_CTRL1,
1319b2f6a56523 Oder Chiou           2014-04-28  4084  			RT5645_DMIC_2_DP_MASK, RT5645_DMIC_2_DP_GPIO10);
1319b2f6a56523 Oder Chiou           2014-04-28  4085  		regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
1319b2f6a56523 Oder Chiou           2014-04-28  4086  			RT5645_GP10_PIN_MASK,
1319b2f6a56523 Oder Chiou           2014-04-28  4087  			RT5645_GP10_PIN_DMIC2_SDA);
1319b2f6a56523 Oder Chiou           2014-04-28  4088  		break;
1319b2f6a56523 Oder Chiou           2014-04-28  4089  
1319b2f6a56523 Oder Chiou           2014-04-28  4090  	case RT5645_DMIC_DATA_GPIO12:
1319b2f6a56523 Oder Chiou           2014-04-28  4091  		regmap_update_bits(rt5645->regmap, RT5645_DMIC_CTRL1,
53f9b3baa937e0 Axel Lin             2015-04-21  4092  			RT5645_DMIC_2_DP_MASK, RT5645_DMIC_2_DP_GPIO12);
1319b2f6a56523 Oder Chiou           2014-04-28  4093  		regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
1319b2f6a56523 Oder Chiou           2014-04-28  4094  			RT5645_GP12_PIN_MASK,
1319b2f6a56523 Oder Chiou           2014-04-28  4095  			RT5645_GP12_PIN_DMIC2_SDA);
1319b2f6a56523 Oder Chiou           2014-04-28  4096  		break;
1319b2f6a56523 Oder Chiou           2014-04-28  4097  
1319b2f6a56523 Oder Chiou           2014-04-28  4098  	default:
1319b2f6a56523 Oder Chiou           2014-04-28  4099  		break;
1319b2f6a56523 Oder Chiou           2014-04-28  4100  	}
1319b2f6a56523 Oder Chiou           2014-04-28  4101  
ac4fc3eeb79e06 Bard Liao            2015-05-05  4102  	if (rt5645->pdata.jd_mode) {
bb656add19764c Bard Liao            2014-11-05  4103  		regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL3,
ac4fc3eeb79e06 Bard Liao            2015-05-05  4104  				   RT5645_IRQ_CLK_GATE_CTRL,
ac4fc3eeb79e06 Bard Liao            2015-05-05  4105  				   RT5645_IRQ_CLK_GATE_CTRL);
bb656add19764c Bard Liao            2014-11-05  4106  		regmap_update_bits(rt5645->regmap, RT5645_MICBIAS,
bb656add19764c Bard Liao            2014-11-05  4107  				   RT5645_IRQ_CLK_INT, RT5645_IRQ_CLK_INT);
2d4e2d02051663 Bard Liao            2014-11-18  4108  		regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
2d4e2d02051663 Bard Liao            2014-11-18  4109  				   RT5645_IRQ_JD_1_1_EN, RT5645_IRQ_JD_1_1_EN);
2d4e2d02051663 Bard Liao            2014-11-18  4110  		regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL3,
2d4e2d02051663 Bard Liao            2014-11-18  4111  				   RT5645_JD_PSV_MODE, RT5645_JD_PSV_MODE);
2d4e2d02051663 Bard Liao            2014-11-18  4112  		regmap_update_bits(rt5645->regmap, RT5645_HPO_MIXER,
2d4e2d02051663 Bard Liao            2014-11-18  4113  				   RT5645_IRQ_PSV_MODE, RT5645_IRQ_PSV_MODE);
2d4e2d02051663 Bard Liao            2014-11-18  4114  		regmap_update_bits(rt5645->regmap, RT5645_MICBIAS,
2d4e2d02051663 Bard Liao            2014-11-18  4115  				   RT5645_MIC2_OVCD_EN, RT5645_MIC2_OVCD_EN);
2d4e2d02051663 Bard Liao            2014-11-18  4116  		regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
2d4e2d02051663 Bard Liao            2014-11-18  4117  				   RT5645_GP1_PIN_IRQ, RT5645_GP1_PIN_IRQ);
2d4e2d02051663 Bard Liao            2014-11-18  4118  		switch (rt5645->pdata.jd_mode) {
2d4e2d02051663 Bard Liao            2014-11-18  4119  		case 1:
2d4e2d02051663 Bard Liao            2014-11-18  4120  			regmap_update_bits(rt5645->regmap, RT5645_A_JD_CTRL1,
2d4e2d02051663 Bard Liao            2014-11-18  4121  					   RT5645_JD1_MODE_MASK,
2d4e2d02051663 Bard Liao            2014-11-18  4122  					   RT5645_JD1_MODE_0);
2d4e2d02051663 Bard Liao            2014-11-18  4123  			break;
2d4e2d02051663 Bard Liao            2014-11-18  4124  		case 2:
2d4e2d02051663 Bard Liao            2014-11-18  4125  			regmap_update_bits(rt5645->regmap, RT5645_A_JD_CTRL1,
2d4e2d02051663 Bard Liao            2014-11-18  4126  					   RT5645_JD1_MODE_MASK,
2d4e2d02051663 Bard Liao            2014-11-18  4127  					   RT5645_JD1_MODE_1);
2d4e2d02051663 Bard Liao            2014-11-18  4128  			break;
2d4e2d02051663 Bard Liao            2014-11-18  4129  		case 3:
e7cfd867fd9842 Jacob Rasmussen      2019-11-11  4130  		case 4:
2d4e2d02051663 Bard Liao            2014-11-18  4131  			regmap_update_bits(rt5645->regmap, RT5645_A_JD_CTRL1,
2d4e2d02051663 Bard Liao            2014-11-18  4132  					   RT5645_JD1_MODE_MASK,
2d4e2d02051663 Bard Liao            2014-11-18  4133  					   RT5645_JD1_MODE_2);
2d4e2d02051663 Bard Liao            2014-11-18  4134  			break;
2d4e2d02051663 Bard Liao            2014-11-18  4135  		default:
2d4e2d02051663 Bard Liao            2014-11-18  4136  			break;
2d4e2d02051663 Bard Liao            2014-11-18  4137  		}
aea086dda2d5df Bard Liao            2017-06-28  4138  		if (rt5645->pdata.inv_jd1_1) {
aea086dda2d5df Bard Liao            2017-06-28  4139  			regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
aea086dda2d5df Bard Liao            2017-06-28  4140  				RT5645_JD_1_1_MASK, RT5645_JD_1_1_INV);
aea086dda2d5df Bard Liao            2017-06-28  4141  		}
2d4e2d02051663 Bard Liao            2014-11-18  4142  	}
2d4e2d02051663 Bard Liao            2014-11-18  4143  
02c5c03283c521 Bard Liao            2016-12-27  4144  	regmap_update_bits(rt5645->regmap, RT5645_ADDA_CLK1,
02c5c03283c521 Bard Liao            2016-12-27  4145  		RT5645_I2S_PD1_MASK, RT5645_I2S_PD1_2);
02c5c03283c521 Bard Liao            2016-12-27  4146  
895750228c9d33 Bard Liao            2017-06-28  4147  	if (rt5645->pdata.level_trigger_irq) {
7ff6319e7da5c0 Bard Liao            2015-12-30  4148  		regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
7ff6319e7da5c0 Bard Liao            2015-12-30  4149  			RT5645_JD_1_1_MASK, RT5645_JD_1_1_INV);
381437dd0bd590 Bard Liao            2016-05-05  4150  	}
7211ec6392c865 Kees Cook            2017-10-25  4151  	timer_setup(&rt5645->btn_check_timer, rt5645_btn_check_callback, 0);
7ff6319e7da5c0 Bard Liao            2015-12-30  4152  
7ea3470a727738 Nicolas Boichat      2015-06-05  4153  	INIT_DELAYED_WORK(&rt5645->jack_detect_work, rt5645_jack_detect_work);
7099ee85e6af56 Oder Chiou           2015-11-05  4154  	INIT_DELAYED_WORK(&rt5645->rcclock_work, rt5645_rcclock_work);
7ea3470a727738 Nicolas Boichat      2015-06-05  4155  
f3fa1bbd836a7d Oder Chiou           2014-09-19  4156  	if (rt5645->i2c->irq) {
f3fa1bbd836a7d Oder Chiou           2014-09-19  4157  		ret = request_threaded_irq(rt5645->i2c->irq, NULL, rt5645_irq,
f3fa1bbd836a7d Oder Chiou           2014-09-19  4158  			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
f3fa1bbd836a7d Oder Chiou           2014-09-19  4159  			| IRQF_ONESHOT, "rt5645", rt5645);
5168c5476a0723 Koro Chen            2015-07-17  4160  		if (ret) {
f3fa1bbd836a7d Oder Chiou           2014-09-19  4161  			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
9fc114c5d7af6c Koro Chen            2015-07-17  4162  			goto err_enable;
5168c5476a0723 Koro Chen            2015-07-17  4163  		}
f3fa1bbd836a7d Oder Chiou           2014-09-19  4164  	}
f3fa1bbd836a7d Oder Chiou           2014-09-19  4165  
79223bf1909191 Kuninori Morimoto    2018-01-29  4166  	ret = devm_snd_soc_register_component(&i2c->dev, &soc_component_dev_rt5645,
1319b2f6a56523 Oder Chiou           2014-04-28  4167  				     rt5645_dai, ARRAY_SIZE(rt5645_dai));
5168c5476a0723 Koro Chen            2015-07-17  4168  	if (ret)
5168c5476a0723 Koro Chen            2015-07-17  4169  		goto err_irq;
5168c5476a0723 Koro Chen            2015-07-17  4170  
5168c5476a0723 Koro Chen            2015-07-17  4171  	return 0;
5168c5476a0723 Koro Chen            2015-07-17  4172  
5168c5476a0723 Koro Chen            2015-07-17  4173  err_irq:
5168c5476a0723 Koro Chen            2015-07-17  4174  	if (rt5645->i2c->irq)
5168c5476a0723 Koro Chen            2015-07-17  4175  		free_irq(rt5645->i2c->irq, rt5645);
9fc114c5d7af6c Koro Chen            2015-07-17  4176  err_enable:
9fc114c5d7af6c Koro Chen            2015-07-17  4177  	regulator_bulk_disable(ARRAY_SIZE(rt5645->supplies), rt5645->supplies);
5168c5476a0723 Koro Chen            2015-07-17  4178  	return ret;
1319b2f6a56523 Oder Chiou           2014-04-28  4179  }
1319b2f6a56523 Oder Chiou           2014-04-28  4180  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

