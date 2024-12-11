Return-Path: <linux-efi+bounces-2370-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA569EDB07
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2024 00:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8A2188988C
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2024 23:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF031F238D;
	Wed, 11 Dec 2024 23:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IT+nonDH"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D32195;
	Wed, 11 Dec 2024 23:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733958815; cv=none; b=eC+UPWPhsqrUGxCUP9uJz7Qyx8KbcanoNA5g9vIjwaAKAKPeTJ4Uv2GjuFlEPG/PTdCZysBBIddh+GMGOP0dZ8g8MoJym/LK/7cCCLAznFrCyoRpwNJNVKbkWdv6u6HbRrfX9PBQ9ZTqB2MU/BTyQ0M12wIb1R/gv9pYrjrDRqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733958815; c=relaxed/simple;
	bh=Fs0YvPZYFfeum0uMpaC2y/EnUl1y1ZIuYN+2dIo5QeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfdHvzB9pnXk/IkCrwcZ7ubHq3nBkp+zwB+mTucdsMfOyPK0PyrGujMN6ojeBwtKDtpSpU+nEitSQylOrLWTZ19V+Bl9e0Zs9RLgmDlJ/pwXghc2VXv03bb3Kl7pHoLAIaNyJQTeR7++QRmFh9g0Cp3Bkp4IawBMOneSWb+sAUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IT+nonDH; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733958814; x=1765494814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fs0YvPZYFfeum0uMpaC2y/EnUl1y1ZIuYN+2dIo5QeY=;
  b=IT+nonDHXkE/IjwH3/1hVLjyzOcgCe0B+FN41NTwIpw+/dd0Sey4eMlb
   bscur/qI80NXQs8c4rbXbSfXYF5KRyxistCFCJJKEgvLA4Pv445CfNmPt
   jWsKIUav2xNMUkFDsoqAtlwF/kaXKH2WZuz3BUtKtSNHvG9axa7blpgab
   TTCTATDjTFctYzHgGAfbdlrxPNJuif7sqAzn4refAAMkH+AegI25HkmtZ
   dldGIfAL9/HeqlHONtRYyVTnoRiLW6KtNQ9UGDJ1OPPSTpbahq1XD253C
   v058k51pvmjLqnaO7f6I96ops3RyrRJbhDLW8jnBB0bFHFot9aWHIeeq5
   Q==;
X-CSE-ConnectionGUID: dDBtzksxSFuig1a5cZUnDw==
X-CSE-MsgGUID: 17Ts8s5fSYiYdEYbqhfSkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="38046231"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="38046231"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 15:13:33 -0800
X-CSE-ConnectionGUID: GR6vQ/SaRQiFUeoopuAIzQ==
X-CSE-MsgGUID: nwFvvL8HQwSfClzTThLOiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="100950648"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 11 Dec 2024 15:13:28 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLVtV-0007C9-0z;
	Wed, 11 Dec 2024 23:13:25 +0000
Date: Thu, 12 Dec 2024 07:12:27 +0800
From: kernel test robot <lkp@intel.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	linux-efi@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	stable@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
	Brian Nguyen <nguyenbrian@microsoft.com>,
	Jacob Pan <panj@microsoft.com>, Allen Pais <apais@microsoft.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jonathan Marek <jonathan@marek.ca>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jeremy Linton <jeremy.linton@arm.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	KONDO =?utf-8?B?S0FaVU1BKOi/keiXpOOAgOWSjOecnyk=?= <kazuma-kondo@nec.com>,
	Kees Cook <kees@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
	Yuntao Wang <ytcoode@gmail.com>,
	Aditya Garg <gargaditya08@live.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi: make the min and max mmap slack slots configurable
Message-ID: <202412120620.ZY2X03AR-lkp@intel.com>
References: <20241209162449.48390-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209162449.48390-1-hamzamahfooz@linux.microsoft.com>

Hi Hamza,

kernel test robot noticed the following build warnings:

[auto build test WARNING on efi/next]
[also build test WARNING on linus/master v6.13-rc2 next-20241211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hamza-Mahfooz/efi-make-the-min-and-max-mmap-slack-slots-configurable/20241210-002724
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
patch link:    https://lore.kernel.org/r/20241209162449.48390-1-hamzamahfooz%40linux.microsoft.com
patch subject: [PATCH] efi: make the min and max mmap slack slots configurable
config: x86_64-buildonly-randconfig-002-20241210 (https://download.01.org/0day-ci/archive/20241212/202412120620.ZY2X03AR-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241212/202412120620.ZY2X03AR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412120620.ZY2X03AR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/firmware/efi/libstub/mem.c:23: warning: Function parameter or struct member 'n' not described in 'efi_get_memory_map'


vim +23 drivers/firmware/efi/libstub/mem.c

f57db62c67c1c9d Ard Biesheuvel      2020-02-10   7  
1d9b17683547348 Heinrich Schuchardt 2020-02-18   8  /**
1d9b17683547348 Heinrich Schuchardt 2020-02-18   9   * efi_get_memory_map() - get memory map
eab3126571ed1e3 Ard Biesheuvel      2022-06-03  10   * @map:		pointer to memory map pointer to which to assign the
eab3126571ed1e3 Ard Biesheuvel      2022-06-03  11   *			newly allocated memory map
171539f5a90e3fd Ard Biesheuvel      2022-09-15  12   * @install_cfg_tbl:	whether or not to install the boot memory map as a
171539f5a90e3fd Ard Biesheuvel      2022-09-15  13   *			configuration table
1d9b17683547348 Heinrich Schuchardt 2020-02-18  14   *
1d9b17683547348 Heinrich Schuchardt 2020-02-18  15   * Retrieve the UEFI memory map. The allocated memory leaves room for
8e602989bc52479 Hamza Mahfooz       2024-12-09  16   * up to CONFIG_EFI_MAX_NR_MMAP_SLACK_SLOTS additional memory map entries.
1d9b17683547348 Heinrich Schuchardt 2020-02-18  17   *
1d9b17683547348 Heinrich Schuchardt 2020-02-18  18   * Return:	status code
1d9b17683547348 Heinrich Schuchardt 2020-02-18  19   */
171539f5a90e3fd Ard Biesheuvel      2022-09-15  20  efi_status_t efi_get_memory_map(struct efi_boot_memmap **map,
8e602989bc52479 Hamza Mahfooz       2024-12-09  21  				bool install_cfg_tbl,
8e602989bc52479 Hamza Mahfooz       2024-12-09  22  				unsigned int *n)
f57db62c67c1c9d Ard Biesheuvel      2020-02-10 @23  {
171539f5a90e3fd Ard Biesheuvel      2022-09-15  24  	int memtype = install_cfg_tbl ? EFI_ACPI_RECLAIM_MEMORY
171539f5a90e3fd Ard Biesheuvel      2022-09-15  25  				      : EFI_LOADER_DATA;
171539f5a90e3fd Ard Biesheuvel      2022-09-15  26  	efi_guid_t tbl_guid = LINUX_EFI_BOOT_MEMMAP_GUID;
8e602989bc52479 Hamza Mahfooz       2024-12-09  27  	unsigned int nr = CONFIG_EFI_MIN_NR_MMAP_SLACK_SLOTS;
eab3126571ed1e3 Ard Biesheuvel      2022-06-03  28  	struct efi_boot_memmap *m, tmp;
f57db62c67c1c9d Ard Biesheuvel      2020-02-10  29  	efi_status_t status;
eab3126571ed1e3 Ard Biesheuvel      2022-06-03  30  	unsigned long size;
f57db62c67c1c9d Ard Biesheuvel      2020-02-10  31  
8e602989bc52479 Hamza Mahfooz       2024-12-09  32  	BUILD_BUG_ON(!is_power_of_2(CONFIG_EFI_MIN_NR_MMAP_SLACK_SLOTS) ||
8e602989bc52479 Hamza Mahfooz       2024-12-09  33  		     !is_power_of_2(CONFIG_EFI_MAX_NR_MMAP_SLACK_SLOTS) ||
8e602989bc52479 Hamza Mahfooz       2024-12-09  34  		     CONFIG_EFI_MIN_NR_MMAP_SLACK_SLOTS >=
8e602989bc52479 Hamza Mahfooz       2024-12-09  35  		     CONFIG_EFI_MAX_NR_MMAP_SLACK_SLOTS);
8e602989bc52479 Hamza Mahfooz       2024-12-09  36  
eab3126571ed1e3 Ard Biesheuvel      2022-06-03  37  	tmp.map_size = 0;
eab3126571ed1e3 Ard Biesheuvel      2022-06-03  38  	status = efi_bs_call(get_memory_map, &tmp.map_size, NULL, &tmp.map_key,
eab3126571ed1e3 Ard Biesheuvel      2022-06-03  39  			     &tmp.desc_size, &tmp.desc_ver);
eab3126571ed1e3 Ard Biesheuvel      2022-06-03  40  	if (status != EFI_BUFFER_TOO_SMALL)
eab3126571ed1e3 Ard Biesheuvel      2022-06-03  41  		return EFI_LOAD_ERROR;
eab3126571ed1e3 Ard Biesheuvel      2022-06-03  42  
8e602989bc52479 Hamza Mahfooz       2024-12-09  43  	do {
8e602989bc52479 Hamza Mahfooz       2024-12-09  44  		size = tmp.map_size + tmp.desc_size * nr;
171539f5a90e3fd Ard Biesheuvel      2022-09-15  45  		status = efi_bs_call(allocate_pool, memtype, sizeof(*m) + size,
eab3126571ed1e3 Ard Biesheuvel      2022-06-03  46  				     (void **)&m);
8e602989bc52479 Hamza Mahfooz       2024-12-09  47  		nr <<= 1;
8e602989bc52479 Hamza Mahfooz       2024-12-09  48  	} while (status == EFI_BUFFER_TOO_SMALL &&
8e602989bc52479 Hamza Mahfooz       2024-12-09  49  		 nr <= CONFIG_EFI_MAX_NR_MMAP_SLACK_SLOTS);
8e602989bc52479 Hamza Mahfooz       2024-12-09  50  
f57db62c67c1c9d Ard Biesheuvel      2020-02-10  51  	if (status != EFI_SUCCESS)
eab3126571ed1e3 Ard Biesheuvel      2022-06-03  52  		return status;
f57db62c67c1c9d Ard Biesheuvel      2020-02-10  53  
8e602989bc52479 Hamza Mahfooz       2024-12-09  54  	if (n)
8e602989bc52479 Hamza Mahfooz       2024-12-09  55  		*n = nr;
8e602989bc52479 Hamza Mahfooz       2024-12-09  56  
171539f5a90e3fd Ard Biesheuvel      2022-09-15  57  	if (install_cfg_tbl) {
171539f5a90e3fd Ard Biesheuvel      2022-09-15  58  		/*
171539f5a90e3fd Ard Biesheuvel      2022-09-15  59  		 * Installing a configuration table might allocate memory, and
171539f5a90e3fd Ard Biesheuvel      2022-09-15  60  		 * this may modify the memory map. This means we should install
171539f5a90e3fd Ard Biesheuvel      2022-09-15  61  		 * the configuration table first, and re-install or delete it
171539f5a90e3fd Ard Biesheuvel      2022-09-15  62  		 * as needed.
171539f5a90e3fd Ard Biesheuvel      2022-09-15  63  		 */
171539f5a90e3fd Ard Biesheuvel      2022-09-15  64  		status = efi_bs_call(install_configuration_table, &tbl_guid, m);
171539f5a90e3fd Ard Biesheuvel      2022-09-15  65  		if (status != EFI_SUCCESS)
171539f5a90e3fd Ard Biesheuvel      2022-09-15  66  			goto free_map;
171539f5a90e3fd Ard Biesheuvel      2022-09-15  67  	}
171539f5a90e3fd Ard Biesheuvel      2022-09-15  68  
eab3126571ed1e3 Ard Biesheuvel      2022-06-03  69  	m->buff_size = m->map_size = size;
eab3126571ed1e3 Ard Biesheuvel      2022-06-03  70  	status = efi_bs_call(get_memory_map, &m->map_size, m->map, &m->map_key,
eab3126571ed1e3 Ard Biesheuvel      2022-06-03  71  			     &m->desc_size, &m->desc_ver);
eab3126571ed1e3 Ard Biesheuvel      2022-06-03  72  	if (status != EFI_SUCCESS)
171539f5a90e3fd Ard Biesheuvel      2022-09-15  73  		goto uninstall_table;
f57db62c67c1c9d Ard Biesheuvel      2020-02-10  74  
eab3126571ed1e3 Ard Biesheuvel      2022-06-03  75  	*map = m;
eab3126571ed1e3 Ard Biesheuvel      2022-06-03  76  	return EFI_SUCCESS;
f57db62c67c1c9d Ard Biesheuvel      2020-02-10  77  
171539f5a90e3fd Ard Biesheuvel      2022-09-15  78  uninstall_table:
171539f5a90e3fd Ard Biesheuvel      2022-09-15  79  	if (install_cfg_tbl)
171539f5a90e3fd Ard Biesheuvel      2022-09-15  80  		efi_bs_call(install_configuration_table, &tbl_guid, NULL);
eab3126571ed1e3 Ard Biesheuvel      2022-06-03  81  free_map:
eab3126571ed1e3 Ard Biesheuvel      2022-06-03  82  	efi_bs_call(free_pool, m);
f57db62c67c1c9d Ard Biesheuvel      2020-02-10  83  	return status;
f57db62c67c1c9d Ard Biesheuvel      2020-02-10  84  }
f57db62c67c1c9d Ard Biesheuvel      2020-02-10  85  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

