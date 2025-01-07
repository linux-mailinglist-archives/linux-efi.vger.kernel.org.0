Return-Path: <linux-efi+bounces-2514-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0FCA03404
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2025 01:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0FD81884E48
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2025 00:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEB8208AD;
	Tue,  7 Jan 2025 00:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IuW+c3HE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAFE1BC5C
	for <linux-efi@vger.kernel.org>; Tue,  7 Jan 2025 00:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736209707; cv=none; b=vAME8Ull6HMO+Nzp9EtIvrsu95htqO3W5a5H+XBMtDOo4KdNtL8k7heA02p/0Kna1bCNBo6yX+TMsawiIppyDiCoQbwG3Xo8Mles70N+N2FDkvHVR09TNS0vIyyfa6rLrFSZeWpg/dkS0CFwEtoEOY4Y5pB/uhLao+5ACee5ZUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736209707; c=relaxed/simple;
	bh=qmqefdqoS9kwe511JLOTEW2dug3ocg9HCh2QFR15pM4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i0Ce4+zEJ8R0iYgAQ0x1CL9aOb9/4bJ7CNv7bEqdaBbpdBdHrwdkmA3WsS/84wjaHAeCJqn4uGxko4wrNqfr9EHoL5vxlh/F/EKuyPjF1pe4T1WJUJ9z0GfQFUsJTZv5CMmveZe23cE3PBUgeRFXJCiZu+WFn/ycpRrqcV821hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IuW+c3HE; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736209706; x=1767745706;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qmqefdqoS9kwe511JLOTEW2dug3ocg9HCh2QFR15pM4=;
  b=IuW+c3HESrL5CKuyD5qzDGDQ1vow+T2wiyqrDIkfYqO8SYaEhw/Q26t/
   tUtRUDWgmly9owVODawNvPy7I9Fd+2GSF45/wX9lVUIFMUcVgPT4TvbIn
   iBMFugXDSXL296N7QFLSJjN0pyHg8Qp5CmZwdA2gMlHkFvINi8BzjdLAq
   dRyv/+Vp3EF95CKfpG4ma6G69KfxZj0560/pIbZaG4Nl3cOLOnYcqcfc7
   N3V2zkK9AnU4EPayXpmY+H5G0LBslXAIZZrb+osQ0wFTn+O72xA9EPGOZ
   XA2E2+idj4XA4HDIogsgcbJT+m9mAmAtbaiGBwpvCcLvE0D2BiCokctV7
   A==;
X-CSE-ConnectionGUID: KcX8D+yASWGc5Go4NUzXPg==
X-CSE-MsgGUID: ZxZDxvstQvSUR9k8WMXTTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="40048343"
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="40048343"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 16:28:25 -0800
X-CSE-ConnectionGUID: XQuArpEMRd6t2heSFEBwbQ==
X-CSE-MsgGUID: WSjhEsjYQE2HIuvCyrGM5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="103120057"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 06 Jan 2025 16:28:21 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tUxSF-000E3L-1W;
	Tue, 07 Jan 2025 00:28:19 +0000
Date: Tue, 7 Jan 2025 08:27:21 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-efi@vger.kernel.org
Subject: [efi:next 6/9] drivers/firmware/efi/libstub/gop.c:283:7: warning:
 variable 'depth' is used uninitialized whenever switch case is taken
Message-ID: <202501070836.Xd7wJiOd-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
head:   159ec6de007d8a2791bdba850ec4dbe83272561c
commit: 5169cdfff5af8a40f4152d19d7fd70320567f2e6 [6/9] efi/libstub: Refactor and clean up GOP resolution picker code
config: riscv-randconfig-001-20250107 (https://download.01.org/0day-ci/archive/20250107/202501070836.Xd7wJiOd-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250107/202501070836.Xd7wJiOd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501070836.Xd7wJiOd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/firmware/efi/libstub/gop.c:283:7: warning: variable 'depth' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
           case PIXEL_BLT_ONLY:
                ^~~~~~~~~~~~~~
   drivers/firmware/efi/libstub/efistub.h:522:28: note: expanded from macro 'PIXEL_BLT_ONLY'
   #define PIXEL_BLT_ONLY                                  3
                                                           ^
   drivers/firmware/efi/libstub/gop.c:297:13: note: uninitialized use occurs here
                       dstr, depth);
                             ^~~~~
   drivers/firmware/efi/libstub/gop.c:276:7: warning: variable 'depth' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
           case PIXEL_BGR_RESERVED_8BIT_PER_COLOR:
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/firmware/efi/libstub/efistub.h:520:44: note: expanded from macro 'PIXEL_BGR_RESERVED_8BIT_PER_COLOR'
   #define PIXEL_BGR_RESERVED_8BIT_PER_COLOR               1
                                                           ^
   drivers/firmware/efi/libstub/gop.c:297:13: note: uninitialized use occurs here
                       dstr, depth);
                             ^~~~~
   drivers/firmware/efi/libstub/gop.c:273:7: warning: variable 'depth' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
           case PIXEL_RGB_RESERVED_8BIT_PER_COLOR:
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/firmware/efi/libstub/efistub.h:519:44: note: expanded from macro 'PIXEL_RGB_RESERVED_8BIT_PER_COLOR'
   #define PIXEL_RGB_RESERVED_8BIT_PER_COLOR               0
                                                           ^
   drivers/firmware/efi/libstub/gop.c:297:13: note: uninitialized use occurs here
                       dstr, depth);
                             ^~~~~
>> drivers/firmware/efi/libstub/gop.c:286:2: warning: variable 'depth' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
           default:
           ^~~~~~~
   drivers/firmware/efi/libstub/gop.c:297:13: note: uninitialized use occurs here
                       dstr, depth);
                             ^~~~~
   drivers/firmware/efi/libstub/gop.c:268:10: note: initialize the variable 'depth' to silence this warning
           u8 depth;
                   ^
                    = '\0'
   4 warnings generated.


vim +/depth +283 drivers/firmware/efi/libstub/gop.c

45d97a749e9fec Arvind Sankar  2020-03-28  260  
5169cdfff5af8a Ard Biesheuvel 2024-12-20  261  static bool match_list(const efi_graphics_output_mode_info_t *info, u32 mode, void *ctx)
14c574f35cfbc9 Arvind Sankar  2020-05-18  262  {
5169cdfff5af8a Ard Biesheuvel 2024-12-20  263  	efi_pixel_bitmask_t pi = info->pixel_information;
5169cdfff5af8a Ard Biesheuvel 2024-12-20  264  	u32 cur_mode = (unsigned long)ctx;
5169cdfff5af8a Ard Biesheuvel 2024-12-20  265  	int pf = info->pixel_format;
14c574f35cfbc9 Arvind Sankar  2020-05-18  266  	const char *dstr;
14c574f35cfbc9 Arvind Sankar  2020-05-18  267  	bool valid;
5169cdfff5af8a Ard Biesheuvel 2024-12-20  268  	u8 depth;
14c574f35cfbc9 Arvind Sankar  2020-05-18  269  
14c574f35cfbc9 Arvind Sankar  2020-05-18  270  	valid = !(pf == PIXEL_BLT_ONLY || pf >= PIXEL_FORMAT_MAX);
5169cdfff5af8a Ard Biesheuvel 2024-12-20  271  
14c574f35cfbc9 Arvind Sankar  2020-05-18  272  	switch (pf) {
14c574f35cfbc9 Arvind Sankar  2020-05-18  273  	case PIXEL_RGB_RESERVED_8BIT_PER_COLOR:
14c574f35cfbc9 Arvind Sankar  2020-05-18  274  		dstr = "rgb";
14c574f35cfbc9 Arvind Sankar  2020-05-18  275  		break;
14c574f35cfbc9 Arvind Sankar  2020-05-18  276  	case PIXEL_BGR_RESERVED_8BIT_PER_COLOR:
14c574f35cfbc9 Arvind Sankar  2020-05-18  277  		dstr = "bgr";
14c574f35cfbc9 Arvind Sankar  2020-05-18  278  		break;
14c574f35cfbc9 Arvind Sankar  2020-05-18  279  	case PIXEL_BIT_MASK:
14c574f35cfbc9 Arvind Sankar  2020-05-18  280  		dstr = "";
5169cdfff5af8a Ard Biesheuvel 2024-12-20  281  		depth = pixel_bpp(pf, pi);
14c574f35cfbc9 Arvind Sankar  2020-05-18  282  		break;
14c574f35cfbc9 Arvind Sankar  2020-05-18 @283  	case PIXEL_BLT_ONLY:
14c574f35cfbc9 Arvind Sankar  2020-05-18  284  		dstr = "blt";
14c574f35cfbc9 Arvind Sankar  2020-05-18  285  		break;
14c574f35cfbc9 Arvind Sankar  2020-05-18 @286  	default:
14c574f35cfbc9 Arvind Sankar  2020-05-18  287  		dstr = "xxx";
14c574f35cfbc9 Arvind Sankar  2020-05-18  288  		break;
14c574f35cfbc9 Arvind Sankar  2020-05-18  289  	}
14c574f35cfbc9 Arvind Sankar  2020-05-18  290  
14c574f35cfbc9 Arvind Sankar  2020-05-18  291  	efi_printk("Mode %3u %c%c: Resolution %ux%u-%s%.0hhu\n",
5169cdfff5af8a Ard Biesheuvel 2024-12-20  292  		    mode,
5169cdfff5af8a Ard Biesheuvel 2024-12-20  293  		    (mode == cur_mode) ? '*' : ' ',
14c574f35cfbc9 Arvind Sankar  2020-05-18  294  		    !valid ? '-' : ' ',
5169cdfff5af8a Ard Biesheuvel 2024-12-20  295  		    info->horizontal_resolution,
5169cdfff5af8a Ard Biesheuvel 2024-12-20  296  		    info->vertical_resolution,
5169cdfff5af8a Ard Biesheuvel 2024-12-20  297  		    dstr, depth);
5169cdfff5af8a Ard Biesheuvel 2024-12-20  298  
5169cdfff5af8a Ard Biesheuvel 2024-12-20  299  	return false;
14c574f35cfbc9 Arvind Sankar  2020-05-18  300  }
14c574f35cfbc9 Arvind Sankar  2020-05-18  301  

:::::: The code at line 283 was first introduced by commit
:::::: 14c574f35cfbc9272fc67b41f074c847db139652 efi/gop: Add an option to list out the available GOP modes

:::::: TO: Arvind Sankar <nivedita@alum.mit.edu>
:::::: CC: Ard Biesheuvel <ardb@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

