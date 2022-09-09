Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58935B2D94
	for <lists+linux-efi@lfdr.de>; Fri,  9 Sep 2022 06:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiIIEk4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Sep 2022 00:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiIIEkz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 9 Sep 2022 00:40:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810C28E9B3;
        Thu,  8 Sep 2022 21:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662698454; x=1694234454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z7Rs8lhlcJ9YDKjRHMhTc3a79d2eq/2qbz9DECfRlhs=;
  b=JtN2Z344uWTv4e1O3PF9gsE6NuNvgPiZ9tSt3cpmAkeHTi9sE7HB/e3i
   T0RXKzsCEeM0Sj2r5nb3Lhk++MHKaB8rH9JVEqmZSdBWv2s+FHlrSzws8
   3GdDQ9SszP+OCw/dZh+NV1TC4jL66l/l0ZIlaZxBv9Qx4TBLV/zvqU6x4
   K0VvPUz/wyeQdUk0DjBJHAMExGnVRtMSLYkdH0WTu+4vETLLNyENsVYBB
   QhH6AQaNrsUZlveveIgKjRxQmsrj5VnD4f01V+BJNyvxQyp+K5iO9xaH/
   6RsNLDF20cAoErqd3tB67qz7TE1xkkSjoIcS4+fd7yIZnGO4UjJ7C0Df0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="280421610"
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="280421610"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 21:40:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="704277458"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Sep 2022 21:40:47 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWVos-0000jJ-3D;
        Fri, 09 Sep 2022 04:40:47 +0000
Date:   Fri, 9 Sep 2022 12:40:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devel@acpica.org
Cc:     kbuild-all@lists.01.org, Len Brown <lenb@kernel.org>,
        Elie Morisse <syniurge@gmail.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
        Khalil Blaiech <kblaiech@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Robert Moore <robert.moore@intel.com>,
        Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [PATCH v2 6/8] perf: qcom_l2_pmu: Refactor _UID handling to use
 acpi_dev_uid_to_integer()
Message-ID: <202209091254.rIFedxQL-lkp@intel.com>
References: <20220908132910.62122-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908132910.62122-7-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Andy,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on wsa/i2c/for-next broonie-spi/for-next efi/next linus/master v6.0-rc4 next-20220908]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/ACPI-unify-_UID-handling-as-integer/20220908-213543
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220909/202209091254.rIFedxQL-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9441434beecbf7fcd74ca58adbb06cc53c874179
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/ACPI-unify-_UID-handling-as-integer/20220908-213543
        git checkout 9441434beecbf7fcd74ca58adbb06cc53c874179
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/perf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/acpi.h:15,
                    from drivers/perf/qcom_l2_pmu.c:4:
   drivers/perf/qcom_l2_pmu.c: In function 'l2_cache_pmu_probe_cluster':
>> drivers/perf/qcom_l2_pmu.c:882:17: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
     882 |                 "Registered L2 cache PMU cluster %ld\n", fw_cluster_id);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
     150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                          ^~~~~~~
   drivers/perf/qcom_l2_pmu.c:881:9: note: in expansion of macro 'dev_info'
     881 |         dev_info(&pdev->dev,
         |         ^~~~~~~~
   drivers/perf/qcom_l2_pmu.c:882:52: note: format string is defined here
     882 |                 "Registered L2 cache PMU cluster %ld\n", fw_cluster_id);
         |                                                  ~~^
         |                                                    |
         |                                                    long int
         |                                                  %lld


vim +882 drivers/perf/qcom_l2_pmu.c

21bdbb7102edea Neil Leeder     2017-02-07  838  
21bdbb7102edea Neil Leeder     2017-02-07  839  static int l2_cache_pmu_probe_cluster(struct device *dev, void *data)
21bdbb7102edea Neil Leeder     2017-02-07  840  {
21bdbb7102edea Neil Leeder     2017-02-07  841  	struct platform_device *pdev = to_platform_device(dev->parent);
21bdbb7102edea Neil Leeder     2017-02-07  842  	struct platform_device *sdev = to_platform_device(dev);
21bdbb7102edea Neil Leeder     2017-02-07  843  	struct l2cache_pmu *l2cache_pmu = data;
21bdbb7102edea Neil Leeder     2017-02-07  844  	struct cluster_pmu *cluster;
9441434beecbf7 Andy Shevchenko 2022-09-08  845  	u64 fw_cluster_id;
21bdbb7102edea Neil Leeder     2017-02-07  846  	int err;
21bdbb7102edea Neil Leeder     2017-02-07  847  	int irq;
21bdbb7102edea Neil Leeder     2017-02-07  848  
9441434beecbf7 Andy Shevchenko 2022-09-08  849  	err = acpi_dev_uid_to_integer(ACPI_COMPANION(dev), &fw_cluster_id);
9441434beecbf7 Andy Shevchenko 2022-09-08  850  	if (err) {
21bdbb7102edea Neil Leeder     2017-02-07  851  		dev_err(&pdev->dev, "unable to read ACPI uid\n");
9441434beecbf7 Andy Shevchenko 2022-09-08  852  		return err;
21bdbb7102edea Neil Leeder     2017-02-07  853  	}
21bdbb7102edea Neil Leeder     2017-02-07  854  
21bdbb7102edea Neil Leeder     2017-02-07  855  	cluster = devm_kzalloc(&pdev->dev, sizeof(*cluster), GFP_KERNEL);
21bdbb7102edea Neil Leeder     2017-02-07  856  	if (!cluster)
21bdbb7102edea Neil Leeder     2017-02-07  857  		return -ENOMEM;
21bdbb7102edea Neil Leeder     2017-02-07  858  
21bdbb7102edea Neil Leeder     2017-02-07  859  	INIT_LIST_HEAD(&cluster->next);
21bdbb7102edea Neil Leeder     2017-02-07  860  	list_add(&cluster->next, &l2cache_pmu->clusters);
21bdbb7102edea Neil Leeder     2017-02-07  861  	cluster->cluster_id = fw_cluster_id;
21bdbb7102edea Neil Leeder     2017-02-07  862  
21bdbb7102edea Neil Leeder     2017-02-07  863  	irq = platform_get_irq(sdev, 0);
228f855fb57ae2 Stephen Boyd    2019-07-30  864  	if (irq < 0)
21bdbb7102edea Neil Leeder     2017-02-07  865  		return irq;
21bdbb7102edea Neil Leeder     2017-02-07  866  	cluster->irq = irq;
21bdbb7102edea Neil Leeder     2017-02-07  867  
21bdbb7102edea Neil Leeder     2017-02-07  868  	cluster->l2cache_pmu = l2cache_pmu;
21bdbb7102edea Neil Leeder     2017-02-07  869  	cluster->on_cpu = -1;
21bdbb7102edea Neil Leeder     2017-02-07  870  
21bdbb7102edea Neil Leeder     2017-02-07  871  	err = devm_request_irq(&pdev->dev, irq, l2_cache_handle_irq,
0d0f144a8f5f98 Tian Tao        2021-06-02  872  			       IRQF_NOBALANCING | IRQF_NO_THREAD |
0d0f144a8f5f98 Tian Tao        2021-06-02  873  			       IRQF_NO_AUTOEN,
21bdbb7102edea Neil Leeder     2017-02-07  874  			       "l2-cache-pmu", cluster);
21bdbb7102edea Neil Leeder     2017-02-07  875  	if (err) {
21bdbb7102edea Neil Leeder     2017-02-07  876  		dev_err(&pdev->dev,
21bdbb7102edea Neil Leeder     2017-02-07  877  			"Unable to request IRQ%d for L2 PMU counters\n", irq);
21bdbb7102edea Neil Leeder     2017-02-07  878  		return err;
21bdbb7102edea Neil Leeder     2017-02-07  879  	}
21bdbb7102edea Neil Leeder     2017-02-07  880  
21bdbb7102edea Neil Leeder     2017-02-07  881  	dev_info(&pdev->dev,
21bdbb7102edea Neil Leeder     2017-02-07 @882  		"Registered L2 cache PMU cluster %ld\n", fw_cluster_id);
21bdbb7102edea Neil Leeder     2017-02-07  883  
21bdbb7102edea Neil Leeder     2017-02-07  884  	spin_lock_init(&cluster->pmu_lock);
21bdbb7102edea Neil Leeder     2017-02-07  885  
21bdbb7102edea Neil Leeder     2017-02-07  886  	l2cache_pmu->num_pmus++;
21bdbb7102edea Neil Leeder     2017-02-07  887  
21bdbb7102edea Neil Leeder     2017-02-07  888  	return 0;
21bdbb7102edea Neil Leeder     2017-02-07  889  }
21bdbb7102edea Neil Leeder     2017-02-07  890  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
