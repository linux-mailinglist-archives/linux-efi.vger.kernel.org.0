Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7401C6B2E06
	for <lists+linux-efi@lfdr.de>; Thu,  9 Mar 2023 20:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjCIT6r (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Mar 2023 14:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjCIT6q (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Mar 2023 14:58:46 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FB8F6B72;
        Thu,  9 Mar 2023 11:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678391922; x=1709927922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JXAhm1Bty8aLiuxBuZjUESD2QyeRCdf7zzvthkJPxc8=;
  b=WGpFTUt49h9S5B2ScCLDvP6IHRC0EO7/uoTfE6iJqr0nAm4z+gDmdwBA
   Pb5dJpeauw+UY+9Rmp0beyclSQJxTEJP9ejWEG4uP+q/LnegmAopG3Xmc
   xjMWnBi69Mxlhr6JS8pr+S4EUEIRx8dulbr/xGU4HB22VaQqpCUSrDrPb
   BBcc6ugc1ccaIaMMtA7nVwjvQUbw2fX59xtgI6jBq87Z/QcOFsKNBtfAJ
   CR0KCxVJoZuCa3xz/u9OQcbSkxRLb95cjN7/xrwkuJEux40CjU6cyqZJR
   AsHHmtpAyfu/VYRmfCbcASGg1eY0Cys3wbHanqyF/O4sthTX9phYzI/G3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="316950381"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="316950381"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 11:58:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="670851192"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="670851192"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 09 Mar 2023 11:58:39 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1paMPO-0003Bd-0m;
        Thu, 09 Mar 2023 19:58:38 +0000
Date:   Fri, 10 Mar 2023 03:58:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-efi@vger.kernel.org,
        loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH] efi/libstub: Call setup_graphics() before
 handle_kernel_image()
Message-ID: <202303100324.OOW0550T-lkp@intel.com>
References: <20230309060012.4189412-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309060012.4189412-1-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Huacai,

I love your patch! Perhaps something to improve:

[auto build test WARNING on efi/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huacai-Chen/efi-libstub-Call-setup_graphics-before-handle_kernel_image/20230309-140124
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
patch link:    https://lore.kernel.org/r/20230309060012.4189412-1-chenhuacai%40loongson.cn
patch subject: [PATCH] efi/libstub: Call setup_graphics() before handle_kernel_image()
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20230310/202303100324.OOW0550T-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/dcee55720c64cc096ee2f52200a6e72c9b968ce1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Huacai-Chen/efi-libstub-Call-setup_graphics-before-handle_kernel_image/20230309-140124
        git checkout dcee55720c64cc096ee2f52200a6e72c9b968ce1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/firmware/efi/libstub/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303100324.OOW0550T-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/firmware/efi/libstub/efi-stub-entry.c:8:21: warning: no previous prototype for 'setup_graphics' [-Wmissing-prototypes]
       8 | struct screen_info *setup_graphics(void)
         |                     ^~~~~~~~~~~~~~


vim +/setup_graphics +8 drivers/firmware/efi/libstub/efi-stub-entry.c

     7	
   > 8	struct screen_info *setup_graphics(void)
     9	{
    10		unsigned long size;
    11		efi_status_t status;
    12		efi_guid_t gop_proto = EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
    13		void **gop_handle = NULL;
    14		struct screen_info *si = NULL;
    15	
    16		size = 0;
    17		status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
    18				     &gop_proto, NULL, &size, gop_handle);
    19		if (status == EFI_BUFFER_TOO_SMALL) {
    20			si = alloc_screen_info();
    21			if (!si)
    22				return NULL;
    23			status = efi_setup_gop(si, &gop_proto, size);
    24			if (status != EFI_SUCCESS) {
    25				free_screen_info(si);
    26				return NULL;
    27			}
    28		}
    29		return si;
    30	}
    31	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
