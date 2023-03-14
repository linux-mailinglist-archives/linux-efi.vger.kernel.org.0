Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BCF6B8E49
	for <lists+linux-efi@lfdr.de>; Tue, 14 Mar 2023 10:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjCNJNy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Mar 2023 05:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCNJNk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Mar 2023 05:13:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8212023A44
        for <linux-efi@vger.kernel.org>; Tue, 14 Mar 2023 02:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678785209; x=1710321209;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ciXbgsaRr61TaAIIsRhkfym9I6WMSAl/Qj+boDyJv3U=;
  b=VC0Qwo9BDRhncq1OluCFfpk6/n8BYRGcZ1R/HkYhACuzWF+5ENJ12Cwr
   wGMWFPQkysjFNjNpXn3V0eS3OUwllGfpgjbgaT3Uk6LbvMDQAFDbHm7BV
   w6ZowGOHuE7u/7lv7nMvpjlI4Sb1w6UKNQWA094q7LR9+ik9XVclCRubZ
   pY9UgzsFBvZIwe40PX8O27PbI8SJq1CfpLRSVFcCJx42ZQfA55mRhpU+b
   l2KM1S4RKlRLgkYbcLxlNPdja15X61oxa5zykLzaQAiBRylSe4AjLDB1G
   t0Kj9+6qE3kbWK4YjTUkCRGy99xtaxEdJRot8oeUfZGfDmrMgvPHCJVax
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="337397882"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="337397882"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 02:13:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="789281025"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="789281025"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 14 Mar 2023 02:13:28 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pc0il-0006lC-1r;
        Tue, 14 Mar 2023 09:13:27 +0000
Date:   Tue, 14 Mar 2023 17:13:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-efi@vger.kernel.org
Subject: [efi:urgent 5/5] efi-stub-entry.c:undefined reference to
 `screen_info'
Message-ID: <202303141714.igJMOcoJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
head:   7949368e93e48a15ac5976405def16f8c84c837b
commit: 7949368e93e48a15ac5976405def16f8c84c837b [5/5] efi: libstub: Use relocated version of kernel's struct screen_info
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20230314/202303141714.igJMOcoJ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?id=7949368e93e48a15ac5976405def16f8c84c837b
        git remote add efi https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
        git fetch --no-tags efi urgent
        git checkout 7949368e93e48a15ac5976405def16f8c84c837b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303141714.igJMOcoJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/firmware/efi/libstub/efi-stub-entry.stub.o: in function `efi_pe_entry':
>> efi-stub-entry.c:(.text+0x194): undefined reference to `screen_info'
   arm-linux-gnueabi-ld: arch/arm/boot/compressed/vmlinux: hidden symbol `screen_info' isn't defined
   arm-linux-gnueabi-ld: final link failed: bad value

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
