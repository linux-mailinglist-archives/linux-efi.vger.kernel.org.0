Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4896B135D
	for <lists+linux-efi@lfdr.de>; Wed,  8 Mar 2023 21:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjCHUvH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Mar 2023 15:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjCHUvF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Mar 2023 15:51:05 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0EC898D2;
        Wed,  8 Mar 2023 12:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678308664; x=1709844664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dawFCN46X6uTJdbZMi5dw9X68cMnBDF1sYbDOL4D3x4=;
  b=NSKa5Ya3AyO2stxmoTXLJgUKseT7wl7lRDC+5CqGIXigcbplEZGYtrSO
   ZYKI99809uee6AbhBDhsCGwLVk0NwyeXqtmWu/C1SMDDYfiyXyd+6ecKc
   iB0wiM4tbO9fONcNEuIVm235SaPMAzeSY5eBUC+tQJ0HZ33y+wdxAvrHT
   30YQn89wXufPWV3YKzlmnubKJup1lRD41+9wGXaIL81Mc2dn7QD3FuSkE
   XYHzoEqyJHUblIawSFIAF4TH6h8tC9+h7q0qDvguJ8qS29jfE91W/gnUb
   vXata/rZNUsagfRH3lCg5sdeE9/Pb828gK0ohIeKx5p4Are0YEGoT4fk5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="320103101"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="320103101"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 12:51:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="670468950"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="670468950"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Mar 2023 12:50:58 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pa0kT-0002Oc-1p;
        Wed, 08 Mar 2023 20:50:57 +0000
Date:   Thu, 9 Mar 2023 04:50:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Youling Tang <tangyouling@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Xuerui Wang <kernel@xen0n.name>,
        linux-efi@vger.kernel.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH] efistub: LoongArch: Reimplement kernel_entry_address()
Message-ID: <202303090430.e6BB0Txr-lkp@intel.com>
References: <1678186653-27659-1-git-send-email-tangyouling@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1678186653-27659-1-git-send-email-tangyouling@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Youling,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on efi/next]
[also build test WARNING on linus/master v6.3-rc1 next-20230308]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Youling-Tang/efistub-LoongArch-Reimplement-kernel_entry_address/20230307-190013
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
patch link:    https://lore.kernel.org/r/1678186653-27659-1-git-send-email-tangyouling%40loongson.cn
patch subject: [PATCH] efistub: LoongArch: Reimplement kernel_entry_address()
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20230309/202303090430.e6BB0Txr-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1f509b49ceeeeb3c59483c685592f8d87b70f169
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Youling-Tang/efistub-LoongArch-Reimplement-kernel_entry_address/20230307-190013
        git checkout 1f509b49ceeeeb3c59483c685592f8d87b70f169
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/firmware/efi/libstub/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303090430.e6BB0Txr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/firmware/efi/libstub/loongarch.c: In function 'get_kernel_offset':
   drivers/firmware/efi/libstub/loongarch.c:46:45: error: 'PHYS_LINK_KADDR' undeclared (first use in this function)
      46 |         return EFI_KIMG_PREFERRED_ADDRESS - PHYS_LINK_KADDR;
         |                                             ^~~~~~~~~~~~~~~
   drivers/firmware/efi/libstub/loongarch.c:46:45: note: each undeclared identifier is reported only once for each function it appears in
   drivers/firmware/efi/libstub/loongarch.c: At top level:
>> drivers/firmware/efi/libstub/loongarch.c:49:15: warning: no previous prototype for 'kernel_entry_address' [-Wmissing-prototypes]
      49 | unsigned long kernel_entry_address(void)
         |               ^~~~~~~~~~~~~~~~~~~~
   drivers/firmware/efi/libstub/loongarch.c: In function 'get_kernel_offset':
   drivers/firmware/efi/libstub/loongarch.c:47:1: error: control reaches end of non-void function [-Werror=return-type]
      47 | }
         | ^
   cc1: some warnings being treated as errors


vim +/kernel_entry_address +49 drivers/firmware/efi/libstub/loongarch.c

    48	
  > 49	unsigned long kernel_entry_address(void)
    50	{
    51		return *(unsigned long *)(EFI_KIMG_PREFERRED_ADDRESS + 8) +
    52			get_kernel_offset();
    53	}
    54	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
