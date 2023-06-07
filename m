Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1487253E7
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jun 2023 08:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjFGGLu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 02:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbjFGGLr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 02:11:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B9419BF;
        Tue,  6 Jun 2023 23:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686118306; x=1717654306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ToiD6lApZwUXrNQbqPwEcvsm0OD6OfqG72fOvkaWaf4=;
  b=j9YVthnLXNHcg1G821xlMvIUSePi1AWufzT7R3LUnbUkgyA+rvpGC8Y8
   8KYJe15hAcR6OBt2U/FgjoYtS+O0YqVKNi3Pur9cLisXatmXuHUcAUu+1
   iQ0RGNWwvqaKmLi49wnYHfBGBCetcL5CEzkgnumdfSRoE2Qtu7xYKetOV
   fUNLQBxxprKO2YRwaRbAPapqBVjs4norzP56VFSFfJRAIbV/Sd2xqchZO
   UvFHwyQ03rGSiE0Wdg5gAw3ts0JsvZlhypLW9ch88Xn5qRnjbwsHZZS0g
   giJm12mbwJqfduyWkJRQ0eW09qdEwPgaxKp7N0j24qJsdINZQUCq7EiqM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="356907020"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="356907020"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 23:11:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="659811894"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="659811894"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Jun 2023 23:11:42 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6mOT-0006E3-1l;
        Wed, 07 Jun 2023 06:11:41 +0000
Date:   Wed, 7 Jun 2023 14:11:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v3 3/5] arm64: libstub: Move KASLR handling functions to
 efi-stub-helper.c
Message-ID: <202306071357.IBYToqAc-lkp@intel.com>
References: <20230606123242.20804-4-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606123242.20804-4-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Alexandre,

kernel test robot noticed the following build warnings:

[auto build test WARNING on efi/next]
[also build test WARNING on linus/master v6.4-rc5 next-20230606]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandre-Ghiti/riscv-Introduce-virtual-kernel-mapping-KASLR/20230606-203849
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
patch link:    https://lore.kernel.org/r/20230606123242.20804-4-alexghiti%40rivosinc.com
patch subject: [PATCH v3 3/5] arm64: libstub: Move KASLR handling functions to efi-stub-helper.c
config: i386-randconfig-i063-20230607 (https://download.01.org/0day-ci/archive/20230607/202306071357.IBYToqAc-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add efi https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
        git fetch efi next
        git checkout efi/next
        b4 shazam https://lore.kernel.org/r/20230606123242.20804-4-alexghiti@rivosinc.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/firmware/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306071357.IBYToqAc-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/firmware/efi/libstub/x86-stub.c:19:
>> drivers/firmware/efi/libstub/efistub.h:1145:59: warning: non-void function does not return a value [-Wreturn-type]
   static inline unsigned long efi_get_kimg_min_align(void) {}
                                                             ^
   1 warning generated.
--
   In file included from drivers/firmware/efi/libstub/efi-stub-helper.c:17:
>> drivers/firmware/efi/libstub/efistub.h:1145:59: warning: non-void function does not return a value [-Wreturn-type]
   static inline unsigned long efi_get_kimg_min_align(void) {}
                                                             ^
   drivers/firmware/efi/libstub/efi-stub-helper.c:867:2: warning: call to undeclared function 'caches_clean_inval_pou'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           caches_clean_inval_pou(*image_addr, *image_addr + kernel_codesize);
           ^
   2 warnings generated.


vim +1145 drivers/firmware/efi/libstub/efistub.h

  1143	
  1144	#ifndef efi_get_kimg_min_align
> 1145	static inline unsigned long efi_get_kimg_min_align(void) {}
  1146	#define efi_get_kimg_min_align efi_get_kimg_min_align
  1147	#endif
  1148	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
