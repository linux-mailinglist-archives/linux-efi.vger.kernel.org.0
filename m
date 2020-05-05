Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8501C5ECB
	for <lists+linux-efi@lfdr.de>; Tue,  5 May 2020 19:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgEER3x (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 5 May 2020 13:29:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:32198 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729199AbgEER3x (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 5 May 2020 13:29:53 -0400
IronPort-SDR: UfNtvkx0+ZDbAXgyeWgJngehQpG0ihayTi5jKQhmzfKKQXHIe4SMX0qQiQB4sGY48wzrSvvpzH
 AZcFzEJxZ7/A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 10:29:53 -0700
IronPort-SDR: Joq+Ga7yrJXIQhwK7vzXmzkreqAlxZjnjzLziJ+pcysRnaDmldzvGpqa71dn5r7QWsYaBxhkgO
 OdKPERvpjItw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,356,1583222400"; 
   d="scan'208";a="338731655"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 05 May 2020 10:29:51 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jW1OB-000CU8-7N; Wed, 06 May 2020 01:29:51 +0800
Date:   Wed, 6 May 2020 01:29:43 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-efi@vger.kernel.org
Subject: [efi:next 14/14]
 drivers/firmware/efi/libstub/efi-stub-helper.c:35:43: sparse: sparse:
 incorrect type in argument 1 (different type sizes)
Message-ID: <202005060139.iJDyIT5u%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
head:   0b8d9fc9953fde4ea3eb3191d986ca2d01eb783c
commit: 0b8d9fc9953fde4ea3eb3191d986ca2d01eb783c [14/14] efi/libstub: Make efi_printk() input argument const char*
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-191-gc51a0382-dirty
        git checkout 0b8d9fc9953fde4ea3eb3191d986ca2d01eb783c
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/firmware/efi/libstub/efi-stub-helper.c:35:43: sparse: sparse: incorrect type in argument 1 (different type sizes) @@    expected unsigned short [usertype] * @@    got ype] * @@
>> drivers/firmware/efi/libstub/efi-stub-helper.c:35:43: sparse:    expected unsigned short [usertype] *
   drivers/firmware/efi/libstub/efi-stub-helper.c:35:43: sparse:    got char *
   drivers/firmware/efi/libstub/efi-stub-helper.c:385:44: sparse: sparse: incorrect type in argument 2 (different type sizes) @@    expected unsigned short const [usertype] *optstr @@    got ype] *optstr @@
   drivers/firmware/efi/libstub/efi-stub-helper.c:385:44: sparse:    expected unsigned short const [usertype] *optstr
   drivers/firmware/efi/libstub/efi-stub-helper.c:385:44: sparse:    got char *

vim +35 drivers/firmware/efi/libstub/efi-stub-helper.c

    28	
    29	void efi_printk(const char *str)
    30	{
    31		while (*str) {
    32			efi_char16_t ch[] = { *str++, L'\0' };
    33	
    34			if (ch[0] == L'\n')
  > 35				efi_char16_printk(L"\r\n");
    36			else
    37				efi_char16_printk(ch);
    38		}
    39	}
    40	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
