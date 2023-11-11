Return-Path: <linux-efi+bounces-40-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F5E7E8A38
	for <lists+linux-efi@lfdr.de>; Sat, 11 Nov 2023 11:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11C91F20F6F
	for <lists+linux-efi@lfdr.de>; Sat, 11 Nov 2023 10:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D582125D8;
	Sat, 11 Nov 2023 10:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/7AFJnh"
X-Original-To: linux-efi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEC811713;
	Sat, 11 Nov 2023 10:41:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0971E9F;
	Sat, 11 Nov 2023 02:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699699285; x=1731235285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yDgF8fRMeA3utzT1N//rBGwE20ulKHntUEzKVUCPbnU=;
  b=G/7AFJnh69xdrRicGTJKuADo1fv8bkTSUiiTach0yrvgqavPR1oR6V7Y
   6v9ALgaZnVS8GA/WpHOsRlOj4/0QrasJz2ld4LFyoqU5Z2ZrhFxkjjrrL
   WNfvb19z/vu4Yt1IK57WzKDNx4vEKu4JmnXVdJkLO/1/Spw+cZqqOHs1+
   mH1qalv/5lv9jsnPfbaOKWIpkKsWsyV9Zje6GFxRVaeu5uttU0Hv9niZ5
   utNYeq4Bjav+68aUXyNQYf94Nd/nDPhFCKiYzzqrw4PDF5+nsVK7qReNz
   N11ppo/6vgTcWA/lUaRjTT2DS3GHld321k21owcJKXjF1dPOScZovh36W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="394171552"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="394171552"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 02:41:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="1095355185"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="1095355185"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 11 Nov 2023 02:41:18 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r1lQS-000ANh-2o;
	Sat, 11 Nov 2023 10:41:16 +0000
Date: Sat, 11 Nov 2023 18:41:06 +0800
From: kernel test robot <lkp@intel.com>
To: Ross Philipson <ross.philipson@oracle.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	ross.philipson@oracle.com, dpsmith@apertussolutions.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, luto@amacapital.net,
	nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v7 09/13] x86: Secure Launch SMP bringup support
Message-ID: <202311111806.sbmcWUN1-lkp@intel.com>
References: <20231110222751.219836-10-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110222751.219836-10-ross.philipson@oracle.com>

Hi Ross,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on herbert-cryptodev-2.6/master herbert-crypto-2.6/master linus/master v6.6 next-20231110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ross-Philipson/x86-boot-Place-kernel_info-at-a-fixed-offset/20231111-063453
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20231110222751.219836-10-ross.philipson%40oracle.com
patch subject: [PATCH v7 09/13] x86: Secure Launch SMP bringup support
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231111/202311111806.sbmcWUN1-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311111806.sbmcWUN1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311111806.sbmcWUN1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/smpboot.c:1097:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (slaunch_is_txt_launch())
               ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/smpboot.c:1107:6: note: uninitialized use occurs here
           if (ret)
               ^~~
   arch/x86/kernel/smpboot.c:1097:2: note: remove the 'if' if its condition is always false
           if (slaunch_is_txt_launch())
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/smpboot.c:1046:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning generated.


vim +1097 arch/x86/kernel/smpboot.c

  1036	
  1037	/*
  1038	 * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
  1039	 * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
  1040	 * Returns zero if startup was successfully sent, else error code from
  1041	 * ->wakeup_secondary_cpu.
  1042	 */
  1043	static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
  1044	{
  1045		unsigned long start_ip = real_mode_header->trampoline_start;
  1046		int ret;
  1047	
  1048	#ifdef CONFIG_X86_64
  1049		/* If 64-bit wakeup method exists, use the 64-bit mode trampoline IP */
  1050		if (apic->wakeup_secondary_cpu_64)
  1051			start_ip = real_mode_header->trampoline_start64;
  1052	#endif
  1053		idle->thread.sp = (unsigned long)task_pt_regs(idle);
  1054		initial_code = (unsigned long)start_secondary;
  1055	
  1056		if (IS_ENABLED(CONFIG_X86_32)) {
  1057			early_gdt_descr.address = (unsigned long)get_cpu_gdt_rw(cpu);
  1058			initial_stack  = idle->thread.sp;
  1059		} else if (!(smpboot_control & STARTUP_PARALLEL_MASK)) {
  1060			smpboot_control = cpu;
  1061		}
  1062	
  1063		/* Enable the espfix hack for this CPU */
  1064		init_espfix_ap(cpu);
  1065	
  1066		/* So we see what's up */
  1067		announce_cpu(cpu, apicid);
  1068	
  1069		/*
  1070		 * This grunge runs the startup process for
  1071		 * the targeted processor.
  1072		 */
  1073		if (x86_platform.legacy.warm_reset) {
  1074	
  1075			pr_debug("Setting warm reset code and vector.\n");
  1076	
  1077			smpboot_setup_warm_reset_vector(start_ip);
  1078			/*
  1079			 * Be paranoid about clearing APIC errors.
  1080			*/
  1081			if (APIC_INTEGRATED(boot_cpu_apic_version)) {
  1082				apic_write(APIC_ESR, 0);
  1083				apic_read(APIC_ESR);
  1084			}
  1085		}
  1086	
  1087		smp_mb();
  1088	
  1089		/*
  1090		 * Wake up a CPU in difference cases:
  1091		 * - Intel TXT DRTM launch uses its own method to wake the APs
  1092		 * - Use a method from the APIC driver if one defined, with wakeup
  1093		 *   straight to 64-bit mode preferred over wakeup to RM.
  1094		 * Otherwise,
  1095		 * - Use an INIT boot APIC message
  1096		 */
> 1097		if (slaunch_is_txt_launch())
  1098			slaunch_wakeup_cpu_from_txt(cpu, apicid);
  1099		else if (apic->wakeup_secondary_cpu_64)
  1100			ret = apic->wakeup_secondary_cpu_64(apicid, start_ip);
  1101		else if (apic->wakeup_secondary_cpu)
  1102			ret = apic->wakeup_secondary_cpu(apicid, start_ip);
  1103		else
  1104			ret = wakeup_secondary_cpu_via_init(apicid, start_ip);
  1105	
  1106		/* If the wakeup mechanism failed, cleanup the warm reset vector */
  1107		if (ret)
  1108			arch_cpuhp_cleanup_kick_cpu(cpu);
  1109		return ret;
  1110	}
  1111	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

