Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42359339D26
	for <lists+linux-efi@lfdr.de>; Sat, 13 Mar 2021 10:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhCMJIL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 13 Mar 2021 04:08:11 -0500
Received: from mga18.intel.com ([134.134.136.126]:14356 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230309AbhCMJH6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 13 Mar 2021 04:07:58 -0500
IronPort-SDR: JcA2KcERSoZFeekYupNVVAx3bVKTNiwgwmnaeDEGkVL8fF1+Y7qgU3bUY+WzK17A9pS3qzRatD
 89d6dZihnMXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="176517331"
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="gz'50?scan'50,208,50";a="176517331"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2021 01:07:57 -0800
IronPort-SDR: p51l/1YheMauACde5crRqgFEmV0NUI7kmEVeBm2cr11gyPJmCQJKJ9DwiIW+6bXApDPXsKSfvA
 c5k3Yl9da1RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="gz'50?scan'50,208,50";a="604225568"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 13 Mar 2021 01:07:56 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lL0FX-0001wZ-Eg; Sat, 13 Mar 2021 09:07:55 +0000
Date:   Sat, 13 Mar 2021 17:07:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-efi@vger.kernel.org
Subject: [efi:next 2/4] arch/ia64/kernel/efi.c:61:10: sparse: sparse: cast
 truncates bits from constant value (43ea58dc becomes dc)
Message-ID: <202103131710.OOOm8zym-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
head:   e233b65935c946ba420ba1b5a42f9b5625861da8
commit: 17bdef976555d001276f0dc188201399e03b0e90 [2/4] efi: use 32-bit alignment for efi_guid_t literals
config: ia64-randconfig-s032-20210312 (attached as .config)
compiler: ia64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-262-g5e674421-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?id=17bdef976555d001276f0dc188201399e03b0e90
        git remote add efi https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
        git fetch --no-tags efi next
        git checkout 17bdef976555d001276f0dc188201399e03b0e90
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   arch/ia64/kernel/efi.c:623:50: sparse: sparse: cast removes address space '__iomem' of expression
   arch/ia64/kernel/efi.c:635:50: sparse: sparse: cast removes address space '__iomem' of expression
   arch/ia64/kernel/efi.c:648:50: sparse: sparse: cast removes address space '__iomem' of expression
   arch/ia64/kernel/efi.c:969:21: sparse: sparse: symbol 'find_memmap_space' was not declared. Should it be static?
>> arch/ia64/kernel/efi.c:61:10: sparse: sparse: cast truncates bits from constant value (43ea58dc becomes dc)
>> arch/ia64/kernel/efi.c:61:10: sparse: sparse: cast truncates bits from constant value (43ea58 becomes 58)
>> arch/ia64/kernel/efi.c:61:10: sparse: sparse: cast truncates bits from constant value (43ea becomes ea)
>> arch/ia64/kernel/efi.c:61:10: sparse: sparse: cast truncates bits from constant value (cf28 becomes 28)
>> arch/ia64/kernel/efi.c:61:10: sparse: sparse: cast truncates bits from constant value (4b06 becomes 6)
>> arch/ia64/kernel/efi.c:62:10: sparse: sparse: cast truncates bits from constant value (f951938d becomes 8d)
>> arch/ia64/kernel/efi.c:62:10: sparse: sparse: cast truncates bits from constant value (f95193 becomes 93)
>> arch/ia64/kernel/efi.c:62:10: sparse: sparse: cast truncates bits from constant value (f951 becomes 51)
>> arch/ia64/kernel/efi.c:62:10: sparse: sparse: cast truncates bits from constant value (620b becomes b)
>> arch/ia64/kernel/efi.c:62:10: sparse: sparse: cast truncates bits from constant value (42ef becomes ef)
>> arch/ia64/kernel/efi.c:63:10: sparse: sparse: cast truncates bits from constant value (eb9d2d2f becomes 2f)
>> arch/ia64/kernel/efi.c:63:10: sparse: sparse: cast truncates bits from constant value (eb9d2d becomes 2d)
>> arch/ia64/kernel/efi.c:63:10: sparse: sparse: cast truncates bits from constant value (eb9d becomes 9d)
>> arch/ia64/kernel/efi.c:63:10: sparse: sparse: cast truncates bits from constant value (2d88 becomes 88)
>> arch/ia64/kernel/efi.c:63:10: sparse: sparse: cast truncates bits from constant value (11d3 becomes d3)
>> arch/ia64/kernel/efi.c:64:10: sparse: sparse: cast truncates bits from constant value (6cb0a200 becomes 0)
>> arch/ia64/kernel/efi.c:64:10: sparse: sparse: cast truncates bits from constant value (6cb0a2 becomes a2)
>> arch/ia64/kernel/efi.c:64:10: sparse: sparse: cast truncates bits from constant value (6cb0 becomes b0)
>> arch/ia64/kernel/efi.c:64:10: sparse: sparse: cast truncates bits from constant value (893a becomes 3a)
>> arch/ia64/kernel/efi.c:64:10: sparse: sparse: cast truncates bits from constant value (11da becomes da)
>> arch/ia64/kernel/efi.c:65:10: sparse: sparse: cast truncates bits from constant value (eb9d2d32 becomes 32)
   arch/ia64/kernel/efi.c:65:10: sparse: sparse: cast truncates bits from constant value (eb9d2d becomes 2d)
   arch/ia64/kernel/efi.c:65:10: sparse: sparse: cast truncates bits from constant value (eb9d becomes 9d)
   arch/ia64/kernel/efi.c:65:10: sparse: sparse: cast truncates bits from constant value (2d88 becomes 88)
   arch/ia64/kernel/efi.c:65:10: sparse: sparse: cast truncates bits from constant value (11d3 becomes d3)
>> arch/ia64/kernel/efi.c:924:27: sparse: sparse: cast truncates bits from constant value (8be4df61 becomes 61)
>> arch/ia64/kernel/efi.c:924:27: sparse: sparse: cast truncates bits from constant value (8be4df becomes df)
>> arch/ia64/kernel/efi.c:924:27: sparse: sparse: cast truncates bits from constant value (8be4 becomes e4)
>> arch/ia64/kernel/efi.c:924:27: sparse: sparse: cast truncates bits from constant value (93ca becomes ca)
>> arch/ia64/kernel/efi.c:924:27: sparse: sparse: cast truncates bits from constant value (11d2 becomes d2)
--
   arch/ia64/kernel/mca_drv.c:768:12: sparse: sparse: symbol 'mca_external_handler_init' was not declared. Should it be static?
   arch/ia64/kernel/mca_drv.c:782:13: sparse: sparse: symbol 'mca_external_handler_exit' was not declared. Should it be static?
>> arch/ia64/kernel/mca_drv.c:261:44: sparse: sparse: cast truncates bits from constant value (e429faf1 becomes f1)
>> arch/ia64/kernel/mca_drv.c:261:44: sparse: sparse: cast truncates bits from constant value (e429fa becomes fa)
>> arch/ia64/kernel/mca_drv.c:261:44: sparse: sparse: cast truncates bits from constant value (e429 becomes 29)
>> arch/ia64/kernel/mca_drv.c:261:44: sparse: sparse: cast truncates bits from constant value (3cb7 becomes b7)
>> arch/ia64/kernel/mca_drv.c:261:44: sparse: sparse: cast truncates bits from constant value (11d4 becomes d4)
>> arch/ia64/kernel/mca_drv.c:264:33: sparse: sparse: cast truncates bits from constant value (e429faf2 becomes f2)
   arch/ia64/kernel/mca_drv.c:264:33: sparse: sparse: cast truncates bits from constant value (e429fa becomes fa)
   arch/ia64/kernel/mca_drv.c:264:33: sparse: sparse: cast truncates bits from constant value (e429 becomes 29)
   arch/ia64/kernel/mca_drv.c:264:33: sparse: sparse: cast truncates bits from constant value (3cb7 becomes b7)
   arch/ia64/kernel/mca_drv.c:264:33: sparse: sparse: cast truncates bits from constant value (11d4 becomes d4)
>> arch/ia64/kernel/mca_drv.c:268:33: sparse: sparse: cast truncates bits from constant value (e429faf3 becomes f3)
   arch/ia64/kernel/mca_drv.c:268:33: sparse: sparse: cast truncates bits from constant value (e429fa becomes fa)
   arch/ia64/kernel/mca_drv.c:268:33: sparse: sparse: cast truncates bits from constant value (e429 becomes 29)
   arch/ia64/kernel/mca_drv.c:268:33: sparse: sparse: cast truncates bits from constant value (3cb7 becomes b7)
   arch/ia64/kernel/mca_drv.c:268:33: sparse: sparse: cast truncates bits from constant value (11d4 becomes d4)
>> arch/ia64/kernel/mca_drv.c:272:33: sparse: sparse: cast truncates bits from constant value (e429faf4 becomes f4)
   arch/ia64/kernel/mca_drv.c:272:33: sparse: sparse: cast truncates bits from constant value (e429fa becomes fa)
   arch/ia64/kernel/mca_drv.c:272:33: sparse: sparse: cast truncates bits from constant value (e429 becomes 29)
   arch/ia64/kernel/mca_drv.c:272:33: sparse: sparse: cast truncates bits from constant value (3cb7 becomes b7)
   arch/ia64/kernel/mca_drv.c:272:33: sparse: sparse: cast truncates bits from constant value (11d4 becomes d4)
>> arch/ia64/kernel/mca_drv.c:276:33: sparse: sparse: cast truncates bits from constant value (e429faf5 becomes f5)
   arch/ia64/kernel/mca_drv.c:276:33: sparse: sparse: cast truncates bits from constant value (e429fa becomes fa)
   arch/ia64/kernel/mca_drv.c:276:33: sparse: sparse: cast truncates bits from constant value (e429 becomes 29)
   arch/ia64/kernel/mca_drv.c:276:33: sparse: sparse: cast truncates bits from constant value (3cb7 becomes b7)
   arch/ia64/kernel/mca_drv.c:276:33: sparse: sparse: cast truncates bits from constant value (11d4 becomes d4)
>> arch/ia64/kernel/mca_drv.c:280:33: sparse: sparse: cast truncates bits from constant value (e429faf6 becomes f6)
   arch/ia64/kernel/mca_drv.c:280:33: sparse: sparse: cast truncates bits from constant value (e429fa becomes fa)
   arch/ia64/kernel/mca_drv.c:280:33: sparse: sparse: cast truncates bits from constant value (e429 becomes 29)
   arch/ia64/kernel/mca_drv.c:280:33: sparse: sparse: cast truncates bits from constant value (3cb7 becomes b7)
   arch/ia64/kernel/mca_drv.c:280:33: sparse: sparse: cast truncates bits from constant value (11d4 becomes d4)
>> arch/ia64/kernel/mca_drv.c:284:33: sparse: sparse: cast truncates bits from constant value (e429faf7 becomes f7)
   arch/ia64/kernel/mca_drv.c:284:33: sparse: sparse: cast truncates bits from constant value (e429fa becomes fa)
   arch/ia64/kernel/mca_drv.c:284:33: sparse: sparse: cast truncates bits from constant value (e429 becomes 29)
   arch/ia64/kernel/mca_drv.c:284:33: sparse: sparse: cast truncates bits from constant value (3cb7 becomes b7)
   arch/ia64/kernel/mca_drv.c:284:33: sparse: sparse: cast truncates bits from constant value (11d4 becomes d4)
>> arch/ia64/kernel/mca_drv.c:288:33: sparse: sparse: cast truncates bits from constant value (e429faf8 becomes f8)
   arch/ia64/kernel/mca_drv.c:288:33: sparse: sparse: cast truncates bits from constant value (e429fa becomes fa)
   arch/ia64/kernel/mca_drv.c:288:33: sparse: sparse: cast truncates bits from constant value (e429 becomes 29)
   arch/ia64/kernel/mca_drv.c:288:33: sparse: sparse: cast truncates bits from constant value (3cb7 becomes b7)
   arch/ia64/kernel/mca_drv.c:288:33: sparse: sparse: cast truncates bits from constant value (11d4 becomes d4)
>> arch/ia64/kernel/mca_drv.c:292:33: sparse: sparse: cast truncates bits from constant value (e429faf9 becomes f9)
   arch/ia64/kernel/mca_drv.c:292:33: sparse: sparse: cast truncates bits from constant value (e429fa becomes fa)
   arch/ia64/kernel/mca_drv.c:292:33: sparse: sparse: cast truncates bits from constant value (e429 becomes 29)
   arch/ia64/kernel/mca_drv.c:292:33: sparse: sparse: cast truncates bits from constant value (3cb7 becomes b7)
   arch/ia64/kernel/mca_drv.c:292:33: sparse: sparse: cast truncates bits from constant value (11d4 becomes d4)

vim +61 arch/ia64/kernel/efi.c

5828efb95bc43a Ard Biesheuvel 2019-06-25  59  
06c0bd93434c5b Ard Biesheuvel 2020-01-22  60  static const efi_config_table_type_t arch_tables[] __initconst = {
4e9a0f73f030e1 Ard Biesheuvel 2020-03-26 @61  	{ESI_TABLE_GUID,				&esi_phys,		"ESI"		},
4e9a0f73f030e1 Ard Biesheuvel 2020-03-26 @62  	{HCDP_TABLE_GUID,				&hcdp_phys,		"HCDP"		},
4e9a0f73f030e1 Ard Biesheuvel 2020-03-26 @63  	{MPS_TABLE_GUID,				&mps_phys,		"MPS"		},
4e9a0f73f030e1 Ard Biesheuvel 2020-03-26 @64  	{PROCESSOR_ABSTRACTION_LAYER_OVERWRITE_GUID,	&palo_phys,		"PALO"		},
4e9a0f73f030e1 Ard Biesheuvel 2020-03-26 @65  	{SAL_SYSTEM_TABLE_GUID,				&sal_systab_phys,	"SALsystab"	},
4e9a0f73f030e1 Ard Biesheuvel 2020-03-26  66  	{},
272686bf46a34f Leif Lindholm  2013-09-05  67  };
272686bf46a34f Leif Lindholm  2013-09-05  68  

:::::: The code at line 61 was first introduced by commit
:::::: 4e9a0f73f030e19a9259b69a7079021048e1f904 efi: Clean up config table description arrays

:::::: TO: Ard Biesheuvel <ardb@kernel.org>
:::::: CC: Ard Biesheuvel <ardb@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--7JfCtLOvnd9MIVvH
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
f3TUPBs8o+X/H3IKc6xdYgEA

--7JfCtLOvnd9MIVvH--
