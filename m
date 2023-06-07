Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACF572736C
	for <lists+linux-efi@lfdr.de>; Thu,  8 Jun 2023 01:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbjFGXyr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 19:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjFGXyi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 19:54:38 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEBB212E;
        Wed,  7 Jun 2023 16:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686182077; x=1717718077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hbLrss7Fx86V/BsVZBJ2ItyCsnjeR/pNGcf//FjE1+s=;
  b=XdAW6sGJnddEZaskTolp58kpAWGz20G7VLwhIOCg4jIKcqMS45iLMTYq
   bhhAUz/HKQqrgvg+P3/Cffm6uJoKYHaZEgZD/dJe4ODSdxDxujbcx7idr
   YeWc0AL0i7MLtUh7wBIsD1o+h3Q2rZ/jj6nQs289mp57eDoIk7YswT+hJ
   p/aSu6kji9XDMFKpuNNSYBSU/zHbpHLceWkcXeFLgziUzpqIgUO/f1N+D
   7AI5s3J+v1XoGPD41I4r+kTcZjSgu84BG6tjApFjP0TrGRYHn8eP3Shpj
   Xmsf7s/zgiUzMV+Qw2p8E8lDkLPXjDFoXPBGK81ItwHNu0mBf1KEAzK7c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="337503220"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="337503220"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 16:54:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="774826414"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="774826414"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jun 2023 16:54:34 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q72z3-000713-1z;
        Wed, 07 Jun 2023 23:54:33 +0000
Date:   Thu, 8 Jun 2023 07:54:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v3 3/5] arm64: libstub: Move KASLR handling functions to
 efi-stub-helper.c
Message-ID: <202306080741.ArdxyO6n-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on efi/next]
[also build test ERROR on linus/master v6.4-rc5 next-20230607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandre-Ghiti/riscv-Introduce-virtual-kernel-mapping-KASLR/20230606-203849
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
patch link:    https://lore.kernel.org/r/20230606123242.20804-4-alexghiti%40rivosinc.com
patch subject: [PATCH v3 3/5] arm64: libstub: Move KASLR handling functions to efi-stub-helper.c
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230608/202306080741.ArdxyO6n-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306080741.ArdxyO6n-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: drivers/firmware/efi/libstub/efi-stub-helper.stub.o: in function `__efistub_efi_kaslr_relocate_kernel':
>> __efistub_efi-stub-helper.c:(.init.text+0xfec): undefined reference to `__efistub__end'
>> aarch64-linux-ld: __efistub_efi-stub-helper.c:(.init.text+0xff0): undefined reference to `__efistub__end'
   aarch64-linux-ld: __efistub_efi-stub-helper.c:(.init.text+0x1058): undefined reference to `__efistub_caches_clean_inval_pou'
   aarch64-linux-ld: arch/arm64/boot/vmlinuz.efi.elf: hidden symbol `__efistub__end' isn't defined
   aarch64-linux-ld: final link failed: bad value

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
