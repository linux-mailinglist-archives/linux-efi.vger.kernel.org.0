Return-Path: <linux-efi+bounces-2428-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7319F94A4
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2024 15:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A66547A4E77
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2024 14:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBB0217708;
	Fri, 20 Dec 2024 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kHjpvjMp"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3276216386;
	Fri, 20 Dec 2024 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734705576; cv=none; b=iUG+GezTgit3iZt2FM7mW2fWiPmdoPUWceIKau2+qyvdGbUMbuzzNhL/KR+TiyZ6PtYVAH97ZXN88R92ovT6jTqtS4YXWvP/jYiNldL/VgKROBuwekGtvHpZuyd3z6+wJr4NF2ym5MbhM7ZDcfD4y6zmYvVHjp9Pz2qDlemD8Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734705576; c=relaxed/simple;
	bh=O/B7welsNf5NAzRZBWqzDR74o5grtHs+2dErpFnf2b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqLT1Aky2gY5ZeL29YUJ1TRjqpY7juhEDG4zuHuPIZIdUNQZvCiiBui20CxvI5B4e142kySZj6J7wtYKAXZGpV0qrRxWDg9MfpUPJZyhXvWg2aGgK2+r5k9rHsYJ1Fe4fJ6IsytcK7fOwt1PJ8OM2ri+c9aFWxswQXYtV1faA5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kHjpvjMp; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734705574; x=1766241574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O/B7welsNf5NAzRZBWqzDR74o5grtHs+2dErpFnf2b8=;
  b=kHjpvjMp/8Wd11CfGL/moiAtuMovsridiRmQY9LH0fI3geiXmKScSSp3
   77C4WtMgD0DIlMi6pR2WuC0Rk3QV1tzHY+HKKNFVBf2A5lDROSPA4YEY7
   /CmeNP3Y22n1mOhsc+2c1jvsOebW0+Bb88t5QlxL1ajaKoCAgbSm+4FWN
   veyre4WjtGukiUYMMJmmSmYdqRYGhggziLILi3G90FwiF23hGqZt973GC
   ZIRHEeY978VdMiCZGDvUF/KVAKRhXEMX9882ZrbUCEr8gtBQCLB7OE1rK
   0MoW3OWp0Jjo/ZCn6R2+cNE6ffzLTyLBN8EEJ+KiG+TzlUjzGzXQ8tuPk
   g==;
X-CSE-ConnectionGUID: ecPhjVJESc+is9Z98wBHsQ==
X-CSE-MsgGUID: F5jMvWq5R2aGeyXcI6vKww==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="45943194"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="45943194"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 06:39:34 -0800
X-CSE-ConnectionGUID: bgJFzxvHRZuagp7ltJRZUQ==
X-CSE-MsgGUID: PJcB5B4VQ3eDg6v610qBdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="98917993"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 20 Dec 2024 06:39:32 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOeA6-0001FH-0O;
	Fri, 20 Dec 2024 14:39:30 +0000
Date: Fri, 20 Dec 2024 22:38:51 +0800
From: kernel test robot <lkp@intel.com>
To: Zhou Ding <zhouding@cmss.chinamobile.com>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Zhou Ding <zhouding@cmss.chinamobile.com>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi: Fix missing `efi_handover_entry` prototype
Message-ID: <202412202207.3eUih2hS-lkp@intel.com>
References: <20241212161517.443855-1-zhouding@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212161517.443855-1-zhouding@cmss.chinamobile.com>

Hi Zhou,

kernel test robot noticed the following build errors:

[auto build test ERROR on efi/next]
[also build test ERROR on linus/master v6.13-rc3 next-20241220]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhou-Ding/efi-Fix-missing-efi_handover_entry-prototype/20241213-175109
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
patch link:    https://lore.kernel.org/r/20241212161517.443855-1-zhouding%40cmss.chinamobile.com
patch subject: [PATCH] efi: Fix missing `efi_handover_entry` prototype
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20241220/202412202207.3eUih2hS-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241220/202412202207.3eUih2hS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412202207.3eUih2hS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld: Unexpected GOT/PLT entries detected!
>> ld: Unexpected run-time procedure linkages detected!
>> ld: Unexpected run-time relocations (.rela) detected!
   ld: arch/x86/boot/compressed/efi_mixed.o: in function `efi64_stub_entry':
>> (.text+0x2d1): undefined reference to `efi_handover_entry'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

