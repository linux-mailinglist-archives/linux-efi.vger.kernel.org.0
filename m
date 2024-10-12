Return-Path: <linux-efi+bounces-1948-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C59299B682
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 19:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E761F224D2
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 17:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4AD84E04;
	Sat, 12 Oct 2024 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jiq+xQzM"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7FC17579;
	Sat, 12 Oct 2024 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728755898; cv=none; b=qD9j/9NEM+TVYqH1TkZQ51VmoUAs2QC4OMqo8qRIlvaNDQjf/AKofEX20MSVHFdtOOqzFoeS6sdNgd5f4V5vtnRVaNUxZy3wNXpJRsuZSM8TZ9xFiqLvFLSPO5MmsZjNA1hmyWM5Ai+92HmSphzYk/rdIWn3lg6sfB/eg5os4Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728755898; c=relaxed/simple;
	bh=15gCM9S2JouQKwZ6bpeCSvqPmDnvWYI4O9Av/Wz4i4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JagKfyjjTx2QsuFSVCGiYYN7hBPN5pq2VAaHuJ9iZ+hXJ3xHaiF0ctFev7dmaJECIFsQOV7c9vTOyGUbs0WcbjsWmdsbkwssPdK9VyZuSRMHowtJsVuWB/zwRqiG4VWOlj3dxVPXXUH6jz3vey/nRZ/BYgEkfFHYeY30IhzGeew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jiq+xQzM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728755897; x=1760291897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=15gCM9S2JouQKwZ6bpeCSvqPmDnvWYI4O9Av/Wz4i4s=;
  b=Jiq+xQzMtiDCl0Kph5ThzPOg46/IzVvwPMP3xSgTZ8MVJIc2XPS2WMc5
   QYd8Y+hqsrqmCvrY0yeBmsrd0KTXC9DD2P4Ld7bofDVLlHSeC8a2h+CBv
   A1/K922BjDcVMcDKxkwPvcR/LsLMtU8wOLk+pFN1zmtHHpFlm7w3mG2iP
   Y7Tyij4e1umKOahFODMdCk1EU+6rugSqdSGagLSczLGRpe79ifoyVUDWE
   vYUzh9fuL4GXg9g56pn6VFalDnXeAX7Wnbi7f7djQtuxKR5piquPzExnL
   jcsT6JD4TH4/Z+sl8tnhe2jGODLI+SGuBRjHM9TkOe2NWqnxganMpwhpA
   g==;
X-CSE-ConnectionGUID: rJX6ILBRThCEBHVNZaBYRQ==
X-CSE-MsgGUID: bP8hyf3aQ+mOoHf090FPCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39526010"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39526010"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2024 10:58:16 -0700
X-CSE-ConnectionGUID: KHTYUdtQR+WsaJkMVhiykQ==
X-CSE-MsgGUID: QzJgkvyCTS+Jtt+3cRG+vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="78011615"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 12 Oct 2024 10:58:12 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szgNV-000DaH-2X;
	Sat, 12 Oct 2024 17:58:09 +0000
Date: Sun, 13 Oct 2024 01:57:13 +0800
From: kernel test robot <lkp@intel.com>
To: KobaK <kobak@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	James Morse <james.morse@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
	linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH V7] acpi/prmt: find block with specific type
Message-ID: <202410130153.COiJzh3R-lkp@intel.com>
References: <20241009064517.2678456-1-kobak@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009064517.2678456-1-kobak@nvidia.com>

Hi KobaK,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.12-rc2 next-20241011]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/KobaK/acpi-prmt-find-block-with-specific-type/20241009-144658
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20241009064517.2678456-1-kobak%40nvidia.com
patch subject: [PATCH V7] acpi/prmt: find block with specific type
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241013/202410130153.COiJzh3R-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241013/202410130153.COiJzh3R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410130153.COiJzh3R-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:31,
                    from drivers/acpi/prmt.c:17:
   drivers/acpi/prmt.c: In function 'efi_pa_va_lookup':
>> include/linux/kern_levels.h:5:25: warning: format '%p' expects argument of type 'void *', but argument 3 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:462:25: note: in definition of macro 'printk_index_wrap'
     462 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:543:9: note: in expansion of macro 'printk'
     543 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:12:25: note: in expansion of macro 'KERN_SOH'
      12 | #define KERN_WARNING    KERN_SOH "4"    /* warning conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:543:16: note: in expansion of macro 'KERN_WARNING'
     543 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~~~~
   drivers/acpi/prmt.c:88:9: note: in expansion of macro 'pr_warn'
      88 |         pr_warn("Failed to find VA for GUID: %pUL, PA: %p", guid, pa);
         |         ^~~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

