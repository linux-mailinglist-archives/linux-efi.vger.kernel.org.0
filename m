Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6520812E976
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2020 18:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgABRhs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jan 2020 12:37:48 -0500
Received: from mga03.intel.com ([134.134.136.65]:13802 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727706AbgABRhs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 2 Jan 2020 12:37:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2020 09:37:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,387,1571727600"; 
   d="gz'50?scan'50,208,50";a="209847624"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 02 Jan 2020 09:37:34 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1in4Pd-0003rb-Gs; Fri, 03 Jan 2020 01:37:33 +0800
Date:   Fri, 3 Jan 2020 01:36:58 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     kbuild-all@lists.01.org, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [efi:next 16/20] arch/arm64/include/asm/efi.h:96:32: warning:
 'pci_handle' is used uninitialized in this function
Message-ID: <202001030136.1NX5hgyy%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bwgljxxcuxvsgpwe"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--bwgljxxcuxvsgpwe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
head:   d6e40eca3ddb5408148b8875e18dd54384aaa796
commit: 4e3a2778404ecb47665318addc8092f5b749efb4 [16/20] efi: Allow disabling PCI busmastering on bridges during boot
config: arm64-alldefconfig (attached as .config)
compiler: aarch64-linux-gcc (GCC) 7.5.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 4e3a2778404ecb47665318addc8092f5b749efb4
        # save the attached .config to linux build tree
        GCC_VERSION=7.5.0 make.cross ARCH=arm64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/firmware/efi/libstub/pci.c:12:0:
   drivers/firmware/efi/libstub/pci.c: In function 'efi_pci_disable_bridge_busmaster':
>> arch/arm64/include/asm/efi.h:96:32: warning: 'pci_handle' is used uninitialized in this function [-Wuninitialized]
    #define efi_bs_call(func, ...) efi_system_table()->boottime->func(__VA_ARGS__)
                                   ^~~~~~~~~~~~~~~~
--
   In file included from drivers/firmware//efi/libstub/pci.c:12:0:
   drivers/firmware//efi/libstub/pci.c: In function 'efi_pci_disable_bridge_busmaster':
>> arch/arm64/include/asm/efi.h:96:32: warning: 'pci_handle' is used uninitialized in this function [-Wuninitialized]
    #define efi_bs_call(func, ...) efi_system_table()->boottime->func(__VA_ARGS__)
                                   ^~~~~~~~~~~~~~~~

vim +/pci_handle +96 arch/arm64/include/asm/efi.h

a13b00778e89c4 Ard Biesheuvel 2014-07-02  95  
966291f6344d7e Ard Biesheuvel 2019-12-24 @96  #define efi_bs_call(func, ...)	efi_system_table()->boottime->func(__VA_ARGS__)
966291f6344d7e Ard Biesheuvel 2019-12-24  97  #define efi_rt_call(func, ...)	efi_system_table()->runtime->func(__VA_ARGS__)
f958efe9759683 Ard Biesheuvel 2019-12-24  98  #define efi_is_native()		(true)
a13b00778e89c4 Ard Biesheuvel 2014-07-02  99  

:::::: The code at line 96 was first introduced by commit
:::::: 966291f6344d7eb6fc3204381a426bafa20a3d18 efi/libstub: Rename efi_call_early/_runtime macros to be more intuitive

:::::: TO: Ard Biesheuvel <ardb@kernel.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--bwgljxxcuxvsgpwe
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--bwgljxxcuxvsgpwe--
