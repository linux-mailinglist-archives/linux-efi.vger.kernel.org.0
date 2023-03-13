Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EDE6B77B0
	for <lists+linux-efi@lfdr.de>; Mon, 13 Mar 2023 13:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjCMMkV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Mar 2023 08:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCMMkV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Mar 2023 08:40:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA804DBE1
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 05:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678711217; x=1710247217;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=puFa5dq3lcVgImAnhH85Jm3uMgga/l39T7Btcgbs7Zo=;
  b=gi7FpLcMY6beSLenncbu3UeOEb0DIDBtJYGAcI0x+BhODip8pf6awfYr
   2tQ4hEdNgo4bGUhNUqM4OGzk383AH1i1tLsehJslaMveeyQdj8cdTs4Xd
   IZVPuqt9bibtKFxABVkIA0yJrVXi8zZtgFf5m3YXvLDalRUqh0yZmws+v
   iwgojfQVApZGFi9Zaq3nH8B0ARPRyQ3rrDN/ztothwNcDk414IWEwBHcW
   AD7seTecFlvmLdknitefIZI+wms7X8BT5zUswjLvp3yI4FSICgIKE+qpk
   bb2a/VhpHanTBjCI4YjnuZUfSlFDTr2tQpse9rqhRaG0huhrfs03TLr4V
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="338684269"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="338684269"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 05:40:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="924487635"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="924487635"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 13 Mar 2023 05:40:15 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pbhTL-0005fA-0x;
        Mon, 13 Mar 2023 12:40:15 +0000
Date:   Mon, 13 Mar 2023 20:39:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-efi@vger.kernel.org
Subject: [efi:urgent 5/5] ld.lld: error: undefined hidden symbol:
 __efistub__start
Message-ID: <202303132020.S9CriCjt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
head:   21f136ebfb9ef430ed614c3f10325876a12695d2
commit: 21f136ebfb9ef430ed614c3f10325876a12695d2 [5/5] efi: libstub: Use relocated version of kernel's struct screen_info
config: riscv-randconfig-r042-20230313 (https://download.01.org/0day-ci/archive/20230313/202303132020.S9CriCjt-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?id=21f136ebfb9ef430ed614c3f10325876a12695d2
        git remote add efi https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
        git fetch --no-tags efi urgent
        git checkout 21f136ebfb9ef430ed614c3f10325876a12695d2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303132020.S9CriCjt-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined hidden symbol: __efistub__start
   >>> referenced by __efistub_riscv-stub.c
   >>>               riscv-stub.stub.o:(__efistub_stext_offset) in archive drivers/firmware/efi/libstub/lib.a
   >>> referenced by __efistub_riscv-stub.c
   >>>               riscv-stub.stub.o:(__efistub_handle_kernel_image) in archive drivers/firmware/efi/libstub/lib.a
--
>> ld.lld: error: undefined hidden symbol: __efistub__start_kernel
   >>> referenced by __efistub_riscv-stub.c
   >>>               riscv-stub.stub.o:(__efistub_stext_offset) in archive drivers/firmware/efi/libstub/lib.a
--
>> ld.lld: error: undefined hidden symbol: __efistub__end
   >>> referenced by __efistub_riscv-stub.c
   >>>               riscv-stub.stub.o:(__efistub_handle_kernel_image) in archive drivers/firmware/efi/libstub/lib.a
--
>> ld.lld: error: undefined hidden symbol: __efistub__edata
   >>> referenced by __efistub_riscv-stub.c
   >>>               riscv-stub.stub.o:(__efistub_handle_kernel_image) in archive drivers/firmware/efi/libstub/lib.a
--
>> ld.lld: error: undefined hidden symbol: __efistub_screen_info
   >>> referenced by __efistub_efi-stub-entry.c
   >>>               efi-stub-entry.stub.o:(__efistub_efi_pe_entry) in archive drivers/firmware/efi/libstub/lib.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
