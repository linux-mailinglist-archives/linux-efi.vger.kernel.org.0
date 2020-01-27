Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32FD214AC9E
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jan 2020 00:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgA0Xa6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 27 Jan 2020 18:30:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:55696 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgA0Xa6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 27 Jan 2020 18:30:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 15:30:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,371,1574150400"; 
   d="scan'208";a="308922734"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Jan 2020 15:30:55 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iwDqJ-0007LT-6q; Tue, 28 Jan 2020 07:30:55 +0800
Date:   Tue, 28 Jan 2020 07:29:52 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Qian Cai <cai@lca.pw>
Cc:     kbuild-all@lists.01.org, ardb@kernel.org, mingo@redhat.com,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH -next] x86/efi_64: fix a user-memory-access in runtime
Message-ID: <202001280700.tCtD1cvl%lkp@intel.com>
References: <20200118063022.21743-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118063022.21743-1-cai@lca.pw>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Qian,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20200117]
[cannot apply to efi/next v5.5]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Qian-Cai/x86-efi_64-fix-a-user-memory-access-in-runtime/20200118-171142
base:    de970dffa7d19eae1d703c3534825308ef8d5dec
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-153-g47b6dfef-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> arch/x86/platform/efi/efi_64.c:1045:48: sparse: sparse: incorrect type in argument 2 (different address spaces)
>> arch/x86/platform/efi/efi_64.c:1045:48: sparse:    expected void const [noderef] <asn:1> *from
>> arch/x86/platform/efi/efi_64.c:1045:48: sparse:    got union efi_runtime_services_t [usertype] *[usertype] runtime

vim +1045 arch/x86/platform/efi/efi_64.c

  1020	
  1021	efi_status_t __init efi_set_virtual_address_map(unsigned long memory_map_size,
  1022							unsigned long descriptor_size,
  1023							u32 descriptor_version,
  1024							efi_memory_desc_t *virtual_map)
  1025	{
  1026		efi_runtime_services_t runtime;
  1027		efi_status_t status;
  1028		unsigned long flags;
  1029		pgd_t *save_pgd = NULL;
  1030	
  1031		if (efi_is_mixed())
  1032			return efi_thunk_set_virtual_address_map(memory_map_size,
  1033								 descriptor_size,
  1034								 descriptor_version,
  1035								 virtual_map);
  1036	
  1037		if (efi_enabled(EFI_OLD_MEMMAP)) {
  1038			save_pgd = efi_old_memmap_phys_prolog();
  1039			if (!save_pgd)
  1040				return EFI_ABORTED;
  1041		} else {
  1042			efi_switch_mm(&efi_mm);
  1043		}
  1044	
> 1045		if (copy_from_user(&runtime, efi.systab->runtime, sizeof(runtime)))

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
