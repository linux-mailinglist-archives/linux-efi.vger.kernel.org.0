Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FD0675DA5
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jan 2023 20:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjATTIY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Jan 2023 14:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjATTIY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Jan 2023 14:08:24 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5736615CBA;
        Fri, 20 Jan 2023 11:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674241703; x=1705777703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=plhBA7zYsdfA8/VMp6kDno7kNTvD0ddVPcas7fv1kFA=;
  b=GH5wjsF/V9dHSC5rkclHtRmOocHPOisT9PKQsp1T4CUE685l1WjRET3p
   EFnCcKwJBVE99NPqlPfhnVNA7qC9f22e/NnOK0/gwrwP4PTu+/Bkz1Wzy
   R8jF3oe8YRR/KVs0yFBBRWAD9QR7HBC7bSHlOxh+vciAqXTAR4xjsSyyH
   r2L51LNfVFHTmsGf03gBy1uDiOa44AMfeZQIHdKQvxADfErb55OR/OL6h
   UGxh6Bq6ccpYMivvLZQjOCpUMkkSg7cOVl5NA4PMHBWhN2FHK3gEnT7ft
   DqwEFskN8Gf1rF8uW7PNqXfJBA3GL8iqY4wWd7S6vSot5t/D4l/xP9EPg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="309236494"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="309236494"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 11:08:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="662634473"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="662634473"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jan 2023 11:08:18 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIwkL-0002q0-2W;
        Fri, 20 Jan 2023 19:08:17 +0000
Date:   Sat, 21 Jan 2023 03:08:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johan Hovold <johan+linaro@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH] efi: drop obsolete efivars sysfs documentation
Message-ID: <202301210220.vTMfcXDx-lkp@intel.com>
References: <20230120081933.29142-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120081933.29142-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Johan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on lwn/docs-next]
[also build test WARNING on efi/next linus/master v6.2-rc4 next-20230120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johan-Hovold/efi-drop-obsolete-efivars-sysfs-documentation/20230120-162042
base:   git://git.lwn.net/linux.git docs-next
patch link:    https://lore.kernel.org/r/20230120081933.29142-1-johan%2Blinaro%40kernel.org
patch subject: [PATCH] efi: drop obsolete efivars sysfs documentation
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/3505864d91e63836528ebf71480cfc1d36213912
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Johan-Hovold/efi-drop-obsolete-efivars-sysfs-documentation/20230120-162042
        git checkout 3505864d91e63836528ebf71480cfc1d36213912
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Warning: Documentation/ABI/testing/sysfs-firmware-gsmi references a file that doesn't exist: Documentation/ABI/*/sysfs-firmware-efi-vars
>> Warning: Documentation/filesystems/efivarfs.rst references a file that doesn't exist: Documentation/ABI/stable/sysfs-firmware-efi-vars

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
