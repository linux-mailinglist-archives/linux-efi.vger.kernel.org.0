Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19346BF1E5
	for <lists+linux-efi@lfdr.de>; Fri, 17 Mar 2023 20:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjCQTuX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Mar 2023 15:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCQTuW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Mar 2023 15:50:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA281244B6
        for <linux-efi@vger.kernel.org>; Fri, 17 Mar 2023 12:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679082620; x=1710618620;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zABSeeyeT25T6hQEqEWV96Sflk0MTHkgreGhnKwSQbM=;
  b=DJ27AZpLAYkYCDF01fdhMIPHH3FYxYEAgXU2euch5OUk+wZft9XmY4Si
   D+qcDMWE0kdRJ5qR+P/AjEA4DeF5N/AeE+vymOrV+Ccm3JG4nSJ52Ltpi
   NfdNu94aWQy2w1tMpUozY81/fjpu/HeXl2lAAtPaMtHLHbZFwePEXjFcj
   tAsUvPSfrQu7ZtqvBMv4ceqADmdI7NYHnx56VYA5IQ7OcCBovtb9d6efD
   SAaHLg82DSv7ZOtHR038EHnvIe/i5JIcoyI3MtlTDOeRy4fKcMdKleIWY
   EqYbwu6uB1MJBmHqEHzLzXQJkDCe6LCshmWmX3ho8XjCpGMPwcZ4TZ5Su
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="403218461"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="403218461"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 12:50:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="769476300"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="769476300"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Mar 2023 12:50:18 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdG5h-0009YM-2F;
        Fri, 17 Mar 2023 19:50:17 +0000
Date:   Sat, 18 Mar 2023 03:49:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-efi@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [efi:urgent 12/12]
 drivers/firmware/efi/libstub/efi-stub-helper.c:513:6: warning: variable 'dp'
 is used uninitialized whenever 'if' condition is false
Message-ID: <202303180324.XvQkFoRV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
head:   86237b46f2b202331c07e4c6c2633ce3d3ba7f13
commit: 86237b46f2b202331c07e4c6c2633ce3d3ba7f13 [12/12] efi: libstub: Look for initrd LoadFile2 protocol on image handle
config: riscv-randconfig-r042-20230313 (https://download.01.org/0day-ci/archive/20230318/202303180324.XvQkFoRV-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?id=86237b46f2b202331c07e4c6c2633ce3d3ba7f13
        git remote add efi https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
        git fetch --no-tags efi urgent
        git checkout 86237b46f2b202331c07e4c6c2633ce3d3ba7f13
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/firmware/efi/libstub/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303180324.XvQkFoRV-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/firmware/efi/libstub/efi-stub-helper.c:513:6: warning: variable 'dp' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (status != EFI_SUCCESS) {
               ^~~~~~~~~~~~~~~~~~~~~
   drivers/firmware/efi/libstub/efi-stub-helper.c:528:42: note: uninitialized use occurs here
           status = efi_call_proto(lf2, load_file, dp, false, &initrd->size, NULL);
                                                   ^~
   drivers/firmware/efi/libstub/efistub.h:59:38: note: expanded from macro 'efi_call_proto'
           efi_fn_call(__inst, func, __inst, ##__VA_ARGS__);       \
                                               ^~~~~~~~~~~
   drivers/firmware/efi/libstub/efistub.h:53:51: note: expanded from macro 'efi_fn_call'
   #define efi_fn_call(inst, func, ...)    (inst)->func(__VA_ARGS__)
                                                        ^~~~~~~~~~~
   drivers/firmware/efi/libstub/efi-stub-helper.c:513:2: note: remove the 'if' if its condition is always true
           if (status != EFI_SUCCESS) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/firmware/efi/libstub/efi-stub-helper.c:505:32: note: initialize the variable 'dp' to silence this warning
           efi_device_path_protocol_t *dp;
                                         ^
                                          = NULL
   1 warning generated.


vim +513 drivers/firmware/efi/libstub/efi-stub-helper.c

   483	
   484	/**
   485	 * efi_load_initrd_lf2() - load the initrd from the Linux initrd device path
   486	 * @image_handle: EFI handle of the loaded image
   487	 * @initrd:	  pointer of struct to store the address where the initrd was
   488	 *                loaded and the size of the loaded initrd
   489	 * @max:	  upper limit for the initrd memory allocation
   490	 *
   491	 * Return:
   492	 * * %EFI_SUCCESS if the initrd was loaded successfully, in which
   493	 *   case @load_addr and @load_size are assigned accordingly
   494	 * * %EFI_NOT_FOUND if no LoadFile2 protocol exists on the initrd device path
   495	 * * %EFI_OUT_OF_RESOURCES if memory allocation failed
   496	 * * %EFI_LOAD_ERROR in all other cases
   497	 */
   498	static
   499	efi_status_t efi_load_initrd_lf2(efi_handle_t image_handle,
   500					 struct linux_efi_initrd *initrd,
   501					 unsigned long max)
   502	{
   503		efi_guid_t lf2_proto_guid = EFI_LOAD_FILE2_PROTOCOL_GUID;
   504		efi_guid_t initrd_lf2_proto_guid = LINUX_EFI_INITRD_LF2_PROTOCOL_GUID;
   505		efi_device_path_protocol_t *dp;
   506		efi_load_file2_protocol_t *lf2;
   507		efi_handle_t handle;
   508		efi_status_t status;
   509	
   510		/* first look for a initrd loading protocol specific to this image */
   511		status = efi_bs_call(handle_protocol, image_handle, &initrd_lf2_proto_guid,
   512				     (void **)&lf2);
 > 513		if (status != EFI_SUCCESS) {
   514			/* look for the global singleton initrd loading protocol */
   515			dp = (efi_device_path_protocol_t *)&initrd_dev_path;
   516			status = efi_bs_call(locate_device_path, &lf2_proto_guid, &dp,
   517					     &handle);
   518			if (status != EFI_SUCCESS)
   519				return status;
   520	
   521			status = efi_bs_call(handle_protocol, handle, &lf2_proto_guid,
   522					     (void **)&lf2);
   523			if (status != EFI_SUCCESS)
   524				return status;
   525		}
   526	
   527		initrd->size = 0;
   528		status = efi_call_proto(lf2, load_file, dp, false, &initrd->size, NULL);
   529		if (status != EFI_BUFFER_TOO_SMALL)
   530			return EFI_LOAD_ERROR;
   531	
   532		status = efi_allocate_pages(initrd->size, &initrd->base, max);
   533		if (status != EFI_SUCCESS)
   534			return status;
   535	
   536		status = efi_call_proto(lf2, load_file, dp, false, &initrd->size,
   537					(void *)initrd->base);
   538		if (status != EFI_SUCCESS) {
   539			efi_free(initrd->size, initrd->base);
   540			return EFI_LOAD_ERROR;
   541		}
   542		return EFI_SUCCESS;
   543	}
   544	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
