Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A665B64DC
	for <lists+linux-efi@lfdr.de>; Tue, 13 Sep 2022 03:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiIMBAz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Sep 2022 21:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiIMBAw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 12 Sep 2022 21:00:52 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2542C51A20;
        Mon, 12 Sep 2022 18:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663030849; x=1694566849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ezLCKwkUBdNCoq39097eIEjcGDCqTdmZcynP14rPVWY=;
  b=dEAsdcvPNpQnWlRIacB/K+Ish63Hwzc3uOPqw54D5l+2Hpq2w8a6uRU3
   mIt1DW7bC4Sgrn32G4BMTPRzJX8nDHxR+EszpK0cllfbGUkU4RNf1tMqO
   oyoTas/j/9HT1Raj786tHjOG9b5IQG1GO8c6UR+2acY6G/Q7XG4SDFENH
   MUm/WZT843ua1pMq2pjBaNgOTahL57FMZ0ERB5Dt7xionALlzeIHj77cQ
   W06+Uk7tjtpOAT0d5DIXmMBJ04unf20N8k509cYn3kwTjA5U7YS1A21gi
   LwXW1Lbi29X0fSuEgcBMgDQtrPiGWpwtj4DpRUhVJILhT+0/YH5xp2Jce
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="299345081"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="299345081"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 18:00:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="684652243"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 12 Sep 2022 18:00:38 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXuI1-00032x-2a;
        Tue, 13 Sep 2022 01:00:37 +0000
Date:   Tue, 13 Sep 2022 09:00:06 +0800
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
Subject: Re: [PATCH v2 7/8] spi: pxa2xx: Refactor _UID handling to use
 acpi_dev_uid_to_integer()
Message-ID: <202209130810.dgrshDMB-lkp@intel.com>
References: <20220908132910.62122-8-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908132910.62122-8-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Andy,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on wsa/i2c/for-next broonie-spi/for-next efi/next linus/master v6.0-rc5 next-20220912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/ACPI-unify-_UID-handling-as-integer/20220908-213543
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: x86_64-buildonly-randconfig-r006-20220912 (https://download.01.org/0day-ci/archive/20220913/202209130810.dgrshDMB-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/ea7999676bc9f75bb4165358cda640b340fe34d0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/ACPI-unify-_UID-handling-as-integer/20220908-213543
        git checkout ea7999676bc9f75bb4165358cda640b340fe34d0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/spi/spi-pxa2xx.c: In function 'pxa2xx_spi_init_pdata':
>> drivers/spi/spi-pxa2xx.c:1457:24: warning: unused variable 'dev' [-Wunused-variable]
    1457 |         struct device *dev = &pdev->dev;
         |                        ^~~


vim +/dev +1457 drivers/spi/spi-pxa2xx.c

  1452	
  1453	static struct pxa2xx_spi_controller *
  1454	pxa2xx_spi_init_pdata(struct platform_device *pdev)
  1455	{
  1456		struct pxa2xx_spi_controller *pdata;
> 1457		struct device *dev = &pdev->dev;
  1458		struct ssp_device *ssp;
  1459		struct resource *res;
  1460		struct device *parent = pdev->dev.parent;
  1461		struct pci_dev *pcidev = dev_is_pci(parent) ? to_pci_dev(parent) : NULL;
  1462		const struct pci_device_id *pcidev_id = NULL;
  1463		enum pxa_ssp_type type;
  1464		const void *match;
  1465		int status;
  1466		u64 uid;
  1467	
  1468		if (pcidev)
  1469			pcidev_id = pci_match_id(pxa2xx_spi_pci_compound_match, pcidev);
  1470	
  1471		match = device_get_match_data(&pdev->dev);
  1472		if (match)
  1473			type = (enum pxa_ssp_type)match;
  1474		else if (pcidev_id)
  1475			type = (enum pxa_ssp_type)pcidev_id->driver_data;
  1476		else
  1477			return ERR_PTR(-EINVAL);
  1478	
  1479		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
  1480		if (!pdata)
  1481			return ERR_PTR(-ENOMEM);
  1482	
  1483		ssp = &pdata->ssp;
  1484	
  1485		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  1486		ssp->mmio_base = devm_ioremap_resource(&pdev->dev, res);
  1487		if (IS_ERR(ssp->mmio_base))
  1488			return ERR_CAST(ssp->mmio_base);
  1489	
  1490		ssp->phys_base = res->start;
  1491	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
