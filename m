Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BC269C627
	for <lists+linux-efi@lfdr.de>; Mon, 20 Feb 2023 08:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjBTHzP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Feb 2023 02:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjBTHzO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 Feb 2023 02:55:14 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C6DEB55;
        Sun, 19 Feb 2023 23:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676879712; x=1708415712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FZW5/j3uO31V1iPBqTannk1XJ56QpM62jjUtPnyt2z4=;
  b=DCrmhTVrjyjIyYIoSja/OGmAfk8Ufe5vC4ATuA58xeyycrKpdQZw/UTC
   zeEOR6ZLK4ssGfelDYRbEkU9CXU+0Cxzy3rwSH0RoLVGP4Rt30c+Y7wAZ
   nfxBIOSqpUP0RBsFMHD0Kspzzj+RdKVtRyVQVAjXgrScIe/hd95f1CXrD
   buCVVmJy5whcb1avQ28Lmp2e1IPvNQvqsvNL/IijvKquAAZXmU/JqCt6c
   D4TcFJpp+/w7p4aNYCCpupE4aQ5Ewh6t+iAaM4ND2MHt8p4JnTlniGwio
   bFXQF3He9bwNW2qSHrZJKEhaAfYbsBzjYrQDQmG4vVDPtNtM+IF9wRlZS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="330059142"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="330059142"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 23:55:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="814045929"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="814045929"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2023 23:55:07 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pU10s-000Dlh-2n;
        Mon, 20 Feb 2023 07:55:06 +0000
Date:   Mon, 20 Feb 2023 15:54:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-efi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/4] efi: Add tee-based EFI variable driver
Message-ID: <202302201535.Ns6H0Dok-lkp@intel.com>
References: <20230220051723.1257-5-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220051723.1257-5-masahisa.kojima@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Masahisa,

I love your patch! Perhaps something to improve:

[auto build test WARNING on efi/next]
[cannot apply to linus/master v6.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masahisa-Kojima/efi-expose-efivar-generic-ops-register-function/20230220-132235
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
patch link:    https://lore.kernel.org/r/20230220051723.1257-5-masahisa.kojima%40linaro.org
patch subject: [PATCH v2 4/4] efi: Add tee-based EFI variable driver
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20230220/202302201535.Ns6H0Dok-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8ce55b3818062f45af62bc5eeb52f97585d0ffd1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Masahisa-Kojima/efi-expose-efivar-generic-ops-register-function/20230220-132235
        git checkout 8ce55b3818062f45af62bc5eeb52f97585d0ffd1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/firmware/efi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302201535.Ns6H0Dok-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/firmware/efi/stmm/tee_stmm_efi.c: In function 'tee_mm_communicate':
>> drivers/firmware/efi/stmm/tee_stmm_efi.c:60:13: warning: variable 'rc' set but not used [-Wunused-but-set-variable]
      60 |         int rc;
         |             ^~


vim +/rc +60 drivers/firmware/efi/stmm/tee_stmm_efi.c

    44	
    45	/**
    46	 * tee_mm_communicate() - Pass a buffer to StandaloneMM running in TEE
    47	 *
    48	 * @comm_buf:		locally allocated communication buffer
    49	 * @dsize:		buffer size
    50	 * Return:		status code
    51	 */
    52	static efi_status_t tee_mm_communicate(void *comm_buf, size_t dsize)
    53	{
    54		size_t buf_size;
    55		efi_status_t ret;
    56		struct efi_mm_communicate_header *mm_hdr;
    57		struct tee_ioctl_invoke_arg arg;
    58		struct tee_param param[4];
    59		struct tee_shm *shm = NULL;
  > 60		int rc;
    61	
    62		if (!comm_buf)
    63			return EFI_INVALID_PARAMETER;
    64	
    65		mm_hdr = (struct efi_mm_communicate_header *)comm_buf;
    66		buf_size = mm_hdr->message_len + sizeof(efi_guid_t) + sizeof(size_t);
    67	
    68		if (dsize != buf_size)
    69			return EFI_INVALID_PARAMETER;
    70	
    71		shm = tee_shm_register_kernel_buf(pvt_data.ctx, comm_buf, buf_size);
    72		if (IS_ERR(shm)) {
    73			dev_err(pvt_data.dev, "Unable to register shared memory\n");
    74			return EFI_UNSUPPORTED;
    75		}
    76	
    77		memset(&arg, 0, sizeof(arg));
    78		arg.func = PTA_STMM_CMD_COMMUNICATE;
    79		arg.session = pvt_data.session;
    80		arg.num_params = 4;
    81	
    82		memset(param, 0, sizeof(param));
    83		param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT;
    84		param[0].u.memref.size = buf_size;
    85		param[0].u.memref.shm = shm;
    86		param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
    87		param[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
    88		param[3].attr = TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
    89	
    90		rc = tee_client_invoke_func(pvt_data.ctx, &arg, param);
    91		tee_shm_free(shm);
    92	
    93		if (arg.ret != 0)
    94			return EFI_DEVICE_ERROR;
    95	
    96		switch (param[1].u.value.a) {
    97		case ARM_SVC_SPM_RET_SUCCESS:
    98			ret = EFI_SUCCESS;
    99			break;
   100	
   101		case ARM_SVC_SPM_RET_INVALID_PARAMS:
   102			ret = EFI_INVALID_PARAMETER;
   103			break;
   104	
   105		case ARM_SVC_SPM_RET_DENIED:
   106			ret = EFI_ACCESS_DENIED;
   107			break;
   108	
   109		case ARM_SVC_SPM_RET_NO_MEMORY:
   110			ret = EFI_OUT_OF_RESOURCES;
   111			break;
   112	
   113		default:
   114			ret = EFI_ACCESS_DENIED;
   115		}
   116	
   117		return ret;
   118	}
   119	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
