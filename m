Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0052D8E3E
	for <lists+linux-efi@lfdr.de>; Sun, 13 Dec 2020 16:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbgLMPWU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 13 Dec 2020 10:22:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:40809 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730430AbgLMPWT (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 13 Dec 2020 10:22:19 -0500
IronPort-SDR: 4XfQ8zvxVNe9srBwLCpDNFt9babL/hM1YJsguMiRJi0M0xpAarmSpTa6tgWOeXzoGCn6nc7KeQ
 BFK6TENYvp5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9833"; a="161662697"
X-IronPort-AV: E=Sophos;i="5.78,416,1599548400"; 
   d="gz'50?scan'50,208,50";a="161662697"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2020 07:21:37 -0800
IronPort-SDR: Mfscj9+Rxf/x/xdIvrJgrQ+j9UopGJhUmbkWmuqTKa3YuhP5/FqJzf+AF/mSUTZ6fhPj7VSQmL
 ZefsPK2DcoKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,416,1599548400"; 
   d="gz'50?scan'50,208,50";a="366700847"
Received: from lkp-server02.sh.intel.com (HELO a947d92d0467) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 13 Dec 2020 07:21:35 -0800
Received: from kbuild by a947d92d0467 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1koTBm-00000e-Rl; Sun, 13 Dec 2020 15:21:34 +0000
Date:   Sun, 13 Dec 2020 23:20:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-efi@vger.kernel.org
Subject: [efi:next 13/14] arch/x86/kernel/reboot.c:613: undefined reference
 to `efi_capsule_pending'
Message-ID: <202012132331.wTG6eJKZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
head:   f4cc0ea28451d8adfb5f1ee35635e07650907c6e
commit: 168f1c4079fcddd8c989ce103fcc79d170b7b43c [13/14] efi: ia64: disable the capsule loader
config: x86_64-randconfig-a006-20201213 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?id=168f1c4079fcddd8c989ce103fcc79d170b7b43c
        git remote add efi https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
        git fetch --no-tags efi next
        git checkout 168f1c4079fcddd8c989ce103fcc79d170b7b43c
        # save the attached .config to linux build tree
        make W=1 ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: warning: orphan section `.data..decrypted' from `arch/x86/kernel/cpu/vmware.o' being placed in section `.data..decrypted'
   ld: warning: orphan section `.data..decrypted' from `arch/x86/kernel/kvm.o' being placed in section `.data..decrypted'
   ld: arch/x86/kernel/reboot.o: in function `native_machine_emergency_restart':
>> arch/x86/kernel/reboot.c:613: undefined reference to `efi_capsule_pending'

vim +613 arch/x86/kernel/reboot.c

7432d149fda8ce9 Ingo Molnar         2008-03-06  573  
660e34cebf0a11d Matthew Garrett     2011-04-04  574  /*
5be44a6fb1edb57 Ingo Molnar         2014-04-04  575   * To the best of our knowledge Windows compatible x86 hardware expects
5be44a6fb1edb57 Ingo Molnar         2014-04-04  576   * the following on reboot:
660e34cebf0a11d Matthew Garrett     2011-04-04  577   *
660e34cebf0a11d Matthew Garrett     2011-04-04  578   * 1) If the FADT has the ACPI reboot register flag set, try it
660e34cebf0a11d Matthew Garrett     2011-04-04  579   * 2) If still alive, write to the keyboard controller
660e34cebf0a11d Matthew Garrett     2011-04-04  580   * 3) If still alive, write to the ACPI reboot register again
660e34cebf0a11d Matthew Garrett     2011-04-04  581   * 4) If still alive, write to the keyboard controller again
a4f1987e4c5489a Li, Aubrey          2014-03-02  582   * 5) If still alive, call the EFI runtime service to reboot
5be44a6fb1edb57 Ingo Molnar         2014-04-04  583   * 6) If no EFI runtime service, call the BIOS to do a reboot
660e34cebf0a11d Matthew Garrett     2011-04-04  584   *
5be44a6fb1edb57 Ingo Molnar         2014-04-04  585   * We default to following the same pattern. We also have
5be44a6fb1edb57 Ingo Molnar         2014-04-04  586   * two other reboot methods: 'triple fault' and 'PCI', which
5be44a6fb1edb57 Ingo Molnar         2014-04-04  587   * can be triggered via the reboot= kernel boot option or
5be44a6fb1edb57 Ingo Molnar         2014-04-04  588   * via quirks.
5be44a6fb1edb57 Ingo Molnar         2014-04-04  589   *
5be44a6fb1edb57 Ingo Molnar         2014-04-04  590   * This means that this function can never return, it can misbehave
5be44a6fb1edb57 Ingo Molnar         2014-04-04  591   * by not rebooting properly and hanging.
660e34cebf0a11d Matthew Garrett     2011-04-04  592   */
416e2d63794d4e5 Jody Belka          2008-02-12  593  static void native_machine_emergency_restart(void)
4d022e35fd7e07c Miguel Boton        2008-01-30  594  {
4d022e35fd7e07c Miguel Boton        2008-01-30  595  	int i;
660e34cebf0a11d Matthew Garrett     2011-04-04  596  	int attempt = 0;
660e34cebf0a11d Matthew Garrett     2011-04-04  597  	int orig_reboot_type = reboot_type;
edf2b1394611fef Robin Holt          2013-07-08  598  	unsigned short mode;
4d022e35fd7e07c Miguel Boton        2008-01-30  599  
d176720d34c72f7 Eduardo Habkost     2008-11-17  600  	if (reboot_emergency)
d176720d34c72f7 Eduardo Habkost     2008-11-17  601  		emergency_vmx_disable_all();
d176720d34c72f7 Eduardo Habkost     2008-11-17  602  
840c2baf2d4cdf3 Joseph Cihula       2009-06-30  603  	tboot_shutdown(TB_SHUTDOWN_REBOOT);
840c2baf2d4cdf3 Joseph Cihula       2009-06-30  604  
4d022e35fd7e07c Miguel Boton        2008-01-30  605  	/* Tell the BIOS if we want cold or warm reboot */
edf2b1394611fef Robin Holt          2013-07-08  606  	mode = reboot_mode == REBOOT_WARM ? 0x1234 : 0;
edf2b1394611fef Robin Holt          2013-07-08  607  	*((unsigned short *)__va(0x472)) = mode;
4d022e35fd7e07c Miguel Boton        2008-01-30  608  
87615a34d561ef5 Matt Fleming        2016-04-25  609  	/*
87615a34d561ef5 Matt Fleming        2016-04-25  610  	 * If an EFI capsule has been registered with the firmware then
87615a34d561ef5 Matt Fleming        2016-04-25  611  	 * override the reboot= parameter.
87615a34d561ef5 Matt Fleming        2016-04-25  612  	 */
87615a34d561ef5 Matt Fleming        2016-04-25 @613  	if (efi_capsule_pending(NULL)) {
87615a34d561ef5 Matt Fleming        2016-04-25  614  		pr_info("EFI capsule is pending, forcing EFI reboot.\n");
87615a34d561ef5 Matt Fleming        2016-04-25  615  		reboot_type = BOOT_EFI;
87615a34d561ef5 Matt Fleming        2016-04-25  616  	}
87615a34d561ef5 Matt Fleming        2016-04-25  617  
4d022e35fd7e07c Miguel Boton        2008-01-30  618  	for (;;) {
4d022e35fd7e07c Miguel Boton        2008-01-30  619  		/* Could also try the reset bit in the Hammer NB */
4d022e35fd7e07c Miguel Boton        2008-01-30  620  		switch (reboot_type) {
5be44a6fb1edb57 Ingo Molnar         2014-04-04  621  		case BOOT_ACPI:
5be44a6fb1edb57 Ingo Molnar         2014-04-04  622  			acpi_reboot();
5be44a6fb1edb57 Ingo Molnar         2014-04-04  623  			reboot_type = BOOT_KBD;
5be44a6fb1edb57 Ingo Molnar         2014-04-04  624  			break;
5be44a6fb1edb57 Ingo Molnar         2014-04-04  625  
4d022e35fd7e07c Miguel Boton        2008-01-30  626  		case BOOT_KBD:
144d102b926f887 Michael D Labriola  2012-02-01  627  			mach_reboot_fixups(); /* For board specific fixups */
7432d149fda8ce9 Ingo Molnar         2008-03-06  628  
4d022e35fd7e07c Miguel Boton        2008-01-30  629  			for (i = 0; i < 10; i++) {
4d022e35fd7e07c Miguel Boton        2008-01-30  630  				kb_wait();
4d022e35fd7e07c Miguel Boton        2008-01-30  631  				udelay(50);
144d102b926f887 Michael D Labriola  2012-02-01  632  				outb(0xfe, 0x64); /* Pulse reset low */
4d022e35fd7e07c Miguel Boton        2008-01-30  633  				udelay(50);
4d022e35fd7e07c Miguel Boton        2008-01-30  634  			}
660e34cebf0a11d Matthew Garrett     2011-04-04  635  			if (attempt == 0 && orig_reboot_type == BOOT_ACPI) {
660e34cebf0a11d Matthew Garrett     2011-04-04  636  				attempt = 1;
660e34cebf0a11d Matthew Garrett     2011-04-04  637  				reboot_type = BOOT_ACPI;
660e34cebf0a11d Matthew Garrett     2011-04-04  638  			} else {
a4f1987e4c5489a Li, Aubrey          2014-03-02  639  				reboot_type = BOOT_EFI;
660e34cebf0a11d Matthew Garrett     2011-04-04  640  			}
660e34cebf0a11d Matthew Garrett     2011-04-04  641  			break;
4d022e35fd7e07c Miguel Boton        2008-01-30  642  
4d022e35fd7e07c Miguel Boton        2008-01-30  643  		case BOOT_EFI:
8562c99cdd30217 Matt Fleming        2014-06-13  644  			efi_reboot(reboot_mode, NULL);
5be44a6fb1edb57 Ingo Molnar         2014-04-04  645  			reboot_type = BOOT_BIOS;
5be44a6fb1edb57 Ingo Molnar         2014-04-04  646  			break;
5be44a6fb1edb57 Ingo Molnar         2014-04-04  647  
5be44a6fb1edb57 Ingo Molnar         2014-04-04  648  		case BOOT_BIOS:
5be44a6fb1edb57 Ingo Molnar         2014-04-04  649  			machine_real_restart(MRR_BIOS);
5be44a6fb1edb57 Ingo Molnar         2014-04-04  650  
5be44a6fb1edb57 Ingo Molnar         2014-04-04  651  			/* We're probably dead after this, but... */
5be44a6fb1edb57 Ingo Molnar         2014-04-04  652  			reboot_type = BOOT_CF9_SAFE;
14d7ca5c5758536 H. Peter Anvin      2008-11-11  653  			break;
4d022e35fd7e07c Miguel Boton        2008-01-30  654  
5be44a6fb1edb57 Ingo Molnar         2014-04-04  655  		case BOOT_CF9_FORCE:
14d7ca5c5758536 H. Peter Anvin      2008-11-11  656  			port_cf9_safe = true;
df561f6688fef77 Gustavo A. R. Silva 2020-08-23  657  			fallthrough;
4d022e35fd7e07c Miguel Boton        2008-01-30  658  
5be44a6fb1edb57 Ingo Molnar         2014-04-04  659  		case BOOT_CF9_SAFE:
14d7ca5c5758536 H. Peter Anvin      2008-11-11  660  			if (port_cf9_safe) {
5be44a6fb1edb57 Ingo Molnar         2014-04-04  661  				u8 reboot_code = reboot_mode == REBOOT_WARM ?  0x06 : 0x0E;
16c21ae5ca636cf Li Fei              2013-08-21  662  				u8 cf9 = inb(0xcf9) & ~reboot_code;
14d7ca5c5758536 H. Peter Anvin      2008-11-11  663  				outb(cf9|2, 0xcf9); /* Request hard reset */
14d7ca5c5758536 H. Peter Anvin      2008-11-11  664  				udelay(50);
16c21ae5ca636cf Li Fei              2013-08-21  665  				/* Actually do the reset */
16c21ae5ca636cf Li Fei              2013-08-21  666  				outb(cf9|reboot_code, 0xcf9);
14d7ca5c5758536 H. Peter Anvin      2008-11-11  667  				udelay(50);
14d7ca5c5758536 H. Peter Anvin      2008-11-11  668  			}
5be44a6fb1edb57 Ingo Molnar         2014-04-04  669  			reboot_type = BOOT_TRIPLE;
5be44a6fb1edb57 Ingo Molnar         2014-04-04  670  			break;
5be44a6fb1edb57 Ingo Molnar         2014-04-04  671  
5be44a6fb1edb57 Ingo Molnar         2014-04-04  672  		case BOOT_TRIPLE:
e802a51ede91350 Thomas Gleixner     2017-08-28  673  			idt_invalidate(NULL);
5be44a6fb1edb57 Ingo Molnar         2014-04-04  674  			__asm__ __volatile__("int3");
5be44a6fb1edb57 Ingo Molnar         2014-04-04  675  
5be44a6fb1edb57 Ingo Molnar         2014-04-04  676  			/* We're probably dead after this, but... */
5be44a6fb1edb57 Ingo Molnar         2014-04-04  677  			reboot_type = BOOT_KBD;
4d022e35fd7e07c Miguel Boton        2008-01-30  678  			break;
4d022e35fd7e07c Miguel Boton        2008-01-30  679  		}
4d022e35fd7e07c Miguel Boton        2008-01-30  680  	}
4d022e35fd7e07c Miguel Boton        2008-01-30  681  }
4d022e35fd7e07c Miguel Boton        2008-01-30  682  

:::::: The code at line 613 was first introduced by commit
:::::: 87615a34d561ef59bd0cffc73256a21220dfdffd x86/efi: Force EFI reboot to process pending capsules

:::::: TO: Matt Fleming <matt@codeblueprint.co.uk>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--CE+1k2dSO48ffgeK
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
/R/2QZy3rbsBAA==

--CE+1k2dSO48ffgeK--
