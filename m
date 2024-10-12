Return-Path: <linux-efi+bounces-1947-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F61499B642
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 19:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B760282FC5
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 17:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE05E77111;
	Sat, 12 Oct 2024 17:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g6n1W9Zs"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8058F77104;
	Sat, 12 Oct 2024 17:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728753977; cv=none; b=VI77z+hwCT0c8BAssNggSSBB9Ss3mJlVH1zfO8NX6dtJNRf9dmEzf6bEcJUNCOxzV+eSlygdFcjn7H5EdtLKvQVIHyuw747M/E7eMjOlEUxnSs+NQMbPZg9l641CB/NR17bAV0O3ei61861Jb0BdUHDLJYSW7ZxegSyDcT/YPBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728753977; c=relaxed/simple;
	bh=cY5C0A6vGeLZiz/fGsKc3Ax9Oq6EZhWa7uNfKHkZL/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+lCYl1IoIFwA5q+NFjYk2KuBVfJEo1WJFV+I2AKTcs04VPG0Um6AmIx4FGJVWZrKqhxwQwTB/Oh/obAwHBhnYp8GQfoapsgIVu+TgjExDNHytbqK/BKRH1Eid5aAMFQ3QY7bKsFJSmGqRMQsKiTyuaNz7gLzAupt7tAaIR8iVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g6n1W9Zs; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728753974; x=1760289974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cY5C0A6vGeLZiz/fGsKc3Ax9Oq6EZhWa7uNfKHkZL/4=;
  b=g6n1W9ZsB5cNKwR21OWDMve0/U+hgcU2oEZKaIHnMOUvHMUVEX8WSpMb
   6TuVgNOQu4LU+Z8nmmsRqNW68+IJV2FAw04TFQO807zs5l3oJQh7REFoG
   Z3THYXPM7H+nd9Rt5yIZ5C39XnVZCIXtULa910hPX9DVT7CPFNcZmbBoq
   Vut7gwiB/5JdAuFcWi9JtIud3huYsKR8IgYRYIXdLcSwiSE5TadVrx1Oh
   qehMqX49XtLri+crYNvU31oaicBEEgUy79V3sXbLORYkFZBXbW3peOKgK
   /PYtBUC3IHd8ULBEUUuCfwNqGBtU5SQwZtdPgrUlBIneawxsg2GlXTOci
   A==;
X-CSE-ConnectionGUID: SYhnRBW7Sv21Kat7yIqvDQ==
X-CSE-MsgGUID: WcRLhyk4TMWfJ/CYzb84cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39524852"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39524852"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2024 10:26:14 -0700
X-CSE-ConnectionGUID: EJxMRPEsQV6ZCEOoUUMb1g==
X-CSE-MsgGUID: JCztLeU2S5i0VgjvqX191w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="76831539"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 12 Oct 2024 10:26:11 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szfsW-000DY7-2G;
	Sat, 12 Oct 2024 17:26:08 +0000
Date: Sun, 13 Oct 2024 01:26:04 +0800
From: kernel test robot <lkp@intel.com>
To: KobaK <kobak@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	James Morse <james.morse@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
	linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH V7] acpi/prmt: find block with specific type
Message-ID: <202410130117.PZ2JPuxo-lkp@intel.com>
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
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241013/202410130117.PZ2JPuxo-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241013/202410130117.PZ2JPuxo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410130117.PZ2JPuxo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/prmt.c:88:60: warning: format specifies type 'void *' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
      88 |         pr_warn("Failed to find VA for GUID: %pUL, PA: %p", guid, pa);
         |                                                        ~~         ^~
         |                                                        %llu
   include/linux/printk.h:543:37: note: expanded from macro 'pr_warn'
     543 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |                                    ~~~     ^~~~~~~~~~~
   include/linux/printk.h:490:60: note: expanded from macro 'printk'
     490 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ~~~    ^~~~~~~~~~~
   include/linux/printk.h:462:19: note: expanded from macro 'printk_index_wrap'
     462 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ~~~~    ^~~~~~~~~~~
>> drivers/acpi/prmt.c:156:29: warning: passing 1-byte aligned argument to 4-byte aligned parameter 1 of 'efi_pa_va_lookup' may result in an unaligned pointer access [-Walign-mismatch]
     156 |                         (void *)efi_pa_va_lookup(&th->guid, handler_info->handler_address);
         |                                                  ^
   drivers/acpi/prmt.c:159:21: warning: passing 1-byte aligned argument to 4-byte aligned parameter 1 of 'efi_pa_va_lookup' may result in an unaligned pointer access [-Walign-mismatch]
     159 |                         efi_pa_va_lookup(&th->guid, handler_info->static_data_buffer_address);
         |                                          ^
   drivers/acpi/prmt.c:162:21: warning: passing 1-byte aligned argument to 4-byte aligned parameter 1 of 'efi_pa_va_lookup' may result in an unaligned pointer access [-Walign-mismatch]
     162 |                         efi_pa_va_lookup(&th->guid, handler_info->acpi_param_buffer_address);
         |                                          ^
   4 warnings generated.


vim +88 drivers/acpi/prmt.c

    74	
    75	static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa)
    76	{
    77		efi_memory_desc_t *md;
    78		u64 pa_offset = pa & ~PAGE_MASK;
    79		u64 page = pa & PAGE_MASK;
    80	
    81		for_each_efi_memory_desc(md) {
    82			if ((md->attribute & EFI_MEMORY_RUNTIME) &&
    83			    (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)) {
    84				return pa_offset + md->virt_addr + page - md->phys_addr;
    85			}
    86		}
    87	
  > 88		pr_warn("Failed to find VA for GUID: %pUL, PA: %p", guid, pa);
    89	
    90		return 0;
    91	}
    92	
    93	#define get_first_handler(a) ((struct acpi_prmt_handler_info *) ((char *) (a) + a->handler_info_offset))
    94	#define get_next_handler(a) ((struct acpi_prmt_handler_info *) (sizeof(struct acpi_prmt_handler_info) + (char *) a))
    95	
    96	static int __init
    97	acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
    98	{
    99		struct acpi_prmt_module_info *module_info;
   100		struct acpi_prmt_handler_info *handler_info;
   101		struct prm_handler_info *th;
   102		struct prm_module_info *tm;
   103		u64 *mmio_count;
   104		u64 cur_handler = 0;
   105		u32 module_info_size = 0;
   106		u64 mmio_range_size = 0;
   107		void *temp_mmio;
   108	
   109		module_info = (struct acpi_prmt_module_info *) header;
   110		module_info_size = struct_size(tm, handlers, module_info->handler_info_count);
   111		tm = kmalloc(module_info_size, GFP_KERNEL);
   112		if (!tm)
   113			goto parse_prmt_out1;
   114	
   115		guid_copy(&tm->guid, (guid_t *) module_info->module_guid);
   116		tm->major_rev = module_info->major_rev;
   117		tm->minor_rev = module_info->minor_rev;
   118		tm->handler_count = module_info->handler_info_count;
   119		tm->updatable = true;
   120	
   121		if (module_info->mmio_list_pointer) {
   122			/*
   123			 * Each module is associated with a list of addr
   124			 * ranges that it can use during the service
   125			 */
   126			mmio_count = (u64 *) memremap(module_info->mmio_list_pointer, 8, MEMREMAP_WB);
   127			if (!mmio_count)
   128				goto parse_prmt_out2;
   129	
   130			mmio_range_size = struct_size(tm->mmio_info, addr_ranges, *mmio_count);
   131			tm->mmio_info = kmalloc(mmio_range_size, GFP_KERNEL);
   132			if (!tm->mmio_info)
   133				goto parse_prmt_out3;
   134	
   135			temp_mmio = memremap(module_info->mmio_list_pointer, mmio_range_size, MEMREMAP_WB);
   136			if (!temp_mmio)
   137				goto parse_prmt_out4;
   138			memmove(tm->mmio_info, temp_mmio, mmio_range_size);
   139		} else {
   140			tm->mmio_info = kmalloc(sizeof(*tm->mmio_info), GFP_KERNEL);
   141			if (!tm->mmio_info)
   142				goto parse_prmt_out2;
   143	
   144			tm->mmio_info->mmio_count = 0;
   145		}
   146	
   147		INIT_LIST_HEAD(&tm->module_list);
   148		list_add(&tm->module_list, &prm_module_list);
   149	
   150		handler_info = get_first_handler(module_info);
   151		do {
   152			th = &tm->handlers[cur_handler];
   153	
   154			guid_copy(&th->guid, (guid_t *)handler_info->handler_guid);
   155			th->handler_addr =
 > 156				(void *)efi_pa_va_lookup(&th->guid, handler_info->handler_address);
   157	
   158			th->static_data_buffer_addr =
   159				efi_pa_va_lookup(&th->guid, handler_info->static_data_buffer_address);
   160	
   161			th->acpi_param_buffer_addr =
   162				efi_pa_va_lookup(&th->guid, handler_info->acpi_param_buffer_address);
   163	
   164		} while (++cur_handler < tm->handler_count && (handler_info = get_next_handler(handler_info)));
   165	
   166		return 0;
   167	
   168	parse_prmt_out4:
   169		kfree(tm->mmio_info);
   170	parse_prmt_out3:
   171		memunmap(mmio_count);
   172	parse_prmt_out2:
   173		kfree(tm);
   174	parse_prmt_out1:
   175		return -ENOMEM;
   176	}
   177	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

