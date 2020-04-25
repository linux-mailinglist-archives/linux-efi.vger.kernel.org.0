Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343961B82A1
	for <lists+linux-efi@lfdr.de>; Sat, 25 Apr 2020 02:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgDYACu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 20:02:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:37522 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgDYACu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 20:02:50 -0400
IronPort-SDR: obKqkgEDvFKwOZHUZVvy6H3duEUevCwW4ZjT2jMvYiO/bdYE0l7lPJKQtlNOZVvnL3e/gN3aPF
 /n5gdaZn5Y8w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 17:02:49 -0700
IronPort-SDR: 2Ilw0I+TR7+BoyFvtiZyssctbD1ytrzUgq8oRtu4jToi65jFGkjYeHGRtBKNsNIKvzSz1R9Obr
 4CBsWbTbCByQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,313,1583222400"; 
   d="scan'208";a="260010379"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 24 Apr 2020 17:02:48 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jS8HO-000IZn-Nm; Sat, 25 Apr 2020 08:02:46 +0800
Date:   Sat, 25 Apr 2020 08:02:38 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-efi@vger.kernel.org
Subject: [efi:next 2/33] drivers/firmware/efi/libstub/efistub.h:680:44:
 sparse: sparse: incorrect type in argument 2 (different type sizes)
Message-ID: <202004250859.zJ89lvJs%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
head:   4eb8320bd1aaa7e69d039f2c251735e3ef0b9a38
commit: cf6b83664895a5c7e97710df282e220bd047f0f5 [2/33] efi/libstub: Make initrd file loader configurable
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-191-gc51a0382-dirty
        git checkout cf6b83664895a5c7e97710df282e220bd047f0f5
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/firmware/efi/libstub/x86-stub.c:225:37: sparse: sparse: invalid initializer
>> drivers/firmware/efi/libstub/efistub.h:680:44: sparse: sparse: incorrect type in argument 2 (different type sizes) @@    expected unsigned short const [usertype] *optstr @@    got ype] *optstr @@
>> drivers/firmware/efi/libstub/efistub.h:680:44: sparse:    expected unsigned short const [usertype] *optstr
>> drivers/firmware/efi/libstub/efistub.h:680:44: sparse:    got char *

vim +680 drivers/firmware/efi/libstub/efistub.h

   670	
   671	static inline efi_status_t efi_load_initrd(efi_loaded_image_t *image,
   672						   unsigned long *load_addr,
   673						   unsigned long *load_size,
   674						   unsigned long soft_limit,
   675						   unsigned long hard_limit)
   676	{
   677		if (!IS_ENABLED(CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER))
   678			return EFI_SUCCESS;
   679	
 > 680		return handle_cmdline_files(image, L"initrd=", sizeof(L"initrd=") - 2,
   681					    soft_limit, hard_limit, load_addr, load_size);
   682	}
   683	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
