Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139A6590FD5
	for <lists+linux-efi@lfdr.de>; Fri, 12 Aug 2022 12:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbiHLK6r (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 Aug 2022 06:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiHLK6r (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 12 Aug 2022 06:58:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB12ACA10;
        Fri, 12 Aug 2022 03:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660301925; x=1691837925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pf+Ur3Mk1CkKkMyfVrI4PlDfV4MGfMJmTcIeuz/L5cE=;
  b=IypEzPVtvSY1FFJB8d9rFbOYOQVnPLhR498Ac99GEecBxOK74W+1mZZO
   4THeVQdf9KoyRj8qcU8m09YI9E3xA5BoLrkIdVHyxk2EaFkYNeNuLg4hE
   MRUcKJMhRRV53resMsm5cxgYk2AwSlar1tO/mYR9eaUz/rucB+wxvAzaS
   HJObVkbLsWZSXGR41jUc/umJIRqTV/PWBmNZtzajoP18yvPH8wEl80R+p
   syz8kAVMouDsxQrHfLLwr1wuWFC/R9undS8Ak33xRo9EpjP2cXsBCb6JE
   QfNKzQZfU54pegLpVJAxWwn8EqcTJgA47VrxMsklc/enRe0DNQVyv26yF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="292367141"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="292367141"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 03:58:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="748159622"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 12 Aug 2022 03:58:40 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMSND-0000S7-1V;
        Fri, 12 Aug 2022 10:58:39 +0000
Date:   Fri, 12 Aug 2022 18:58:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jia He <justin.he@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Cc:     kbuild-all@lists.01.org, linux-media@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, devel@acpica.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, toshi.kani@hpe.com, Jia He <justin.he@arm.com>,
        stable@kernel.org
Subject: Re: [PATCH 2/2] EDAC/ghes: Modularize ghes_edac driver to remove the
 dependency on ghes
Message-ID: <202208121802.AQBiO8LK-lkp@intel.com>
References: <20220811091713.10427-3-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811091713.10427-3-justin.he@arm.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Jia,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on ras/edac-for-next efi/next linus/master v5.19 next-20220812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jia-He/Modularize-ghes_edac-driver/20220811-171953
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220812/202208121802.AQBiO8LK-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/9cf68330d4fa626e09c8cbc3be9910751e94508c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jia-He/Modularize-ghes_edac-driver/20220811-171953
        git checkout 9cf68330d4fa626e09c8cbc3be9910751e94508c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/acpi/apei/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/acpi/apei/ghes.c:97:1: sparse: sparse: symbol 'ghes_report_chain' was not declared. Should it be static?
   drivers/acpi/apei/ghes.c:733:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/acpi/apei/ghes.c:733:25: sparse:    struct ghes_estatus_cache [noderef] __rcu *
   drivers/acpi/apei/ghes.c:733:25: sparse:    struct ghes_estatus_cache *
   drivers/acpi/apei/ghes.c:813:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/acpi/apei/ghes.c:813:25: sparse:    struct ghes_estatus_cache [noderef] __rcu *
   drivers/acpi/apei/ghes.c:813:25: sparse:    struct ghes_estatus_cache *

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
