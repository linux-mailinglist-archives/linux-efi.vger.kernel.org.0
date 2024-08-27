Return-Path: <linux-efi+bounces-1611-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 827AA961858
	for <lists+linux-efi@lfdr.de>; Tue, 27 Aug 2024 22:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53A31C22F8B
	for <lists+linux-efi@lfdr.de>; Tue, 27 Aug 2024 20:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D251D363B;
	Tue, 27 Aug 2024 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K6uo0UIs"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D70C2EAE6;
	Tue, 27 Aug 2024 20:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724789431; cv=none; b=ljkepx3nDNfieoRVPuqFZV56UjULtIQ4cPiTWBRHZGS1cnt8cc9VkGyGw3kArDRNGtrcRAglZv0MEJBtSazULf4beNlZOwlxD85fHeO/F+q92ijsH1ggXnGePRmJypfpBAKKsztGxT+F7RFa0wqcmEtyuUHubcEC5l4MWt43UnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724789431; c=relaxed/simple;
	bh=f3sZbsLPe/J4HvOjV7og6WTUbkDT102FyoUUj5gFOAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGxjgYvGerkSbftfjRk/0BhwVlZRctkibUs/4EIqCE4JP7A/IPhpJUM8TyUn+TYrNjcd3wTZIuZG7ozmRRIGaYivugzBId4n3TWompul7fRiMIIoc78Nf4my54h2lrfDYeHa4+HWfkAPirnd4MVyR0e3Wnv0W/Xdkj7JUE0KSkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K6uo0UIs; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724789429; x=1756325429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f3sZbsLPe/J4HvOjV7og6WTUbkDT102FyoUUj5gFOAY=;
  b=K6uo0UIsduSXRIkKDv1hxmbSPxh/AEMqwuE/vbma4/3yDV4lSnnJdThD
   6RUwduLAF8MD9LULN9WnmG+1aosi5EujA6FA6ICzf+rapNfnoGldWOsG9
   b4k6fcvM682y22M4xgaLxjVOVX7/539CKpJyU/sd8BeLwhzffnQINzl0K
   udxtHN+RgsnWbkAYdL+ulvhz9//sA6Q7U6t+iLELnKPPWSscwmZ4Xs7El
   HvwuZRO2UgSjRB/2Yhhcbp52msldD1ro5Bsn67vyROBvQn0sun4ZMQ9N7
   CYepjmUA3fHJ94yxEhrhFF55odGMgTLhamPQLAMcCWy7SL4T1+2tehQZI
   g==;
X-CSE-ConnectionGUID: 1PsDLGKISmSsnaThQFYmIQ==
X-CSE-MsgGUID: wH3PcPlLQoiuJDpaQ57WkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="27084995"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="27084995"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 13:10:21 -0700
X-CSE-ConnectionGUID: MkWdwHFPSaORUXRLLgx3tA==
X-CSE-MsgGUID: pScGyMYhQB+U1HU6Fp8Wxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="100500178"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 27 Aug 2024 13:10:14 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sj2W3-000K2k-0N;
	Tue, 27 Aug 2024 20:10:11 +0000
Date: Wed, 28 Aug 2024 04:09:17 +0800
From: kernel test robot <lkp@intel.com>
To: Ross Philipson <ross.philipson@oracle.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, ross.philipson@oracle.com,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
	nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
	davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com
Subject: Re: [PATCH v10 20/20] x86/efi: EFI stub DRTM launch support for
 Secure Launch
Message-ID: <202408280656.66ZxoOOL-lkp@intel.com>
References: <20240826223835.3928819-21-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826223835.3928819-21-ross.philipson@oracle.com>

Hi Ross,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus herbert-cryptodev-2.6/master efi/next linus/master v6.11-rc5]
[cannot apply to herbert-crypto-2.6/master next-20240827]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ross-Philipson/Documentation-x86-Secure-Launch-kernel-documentation/20240827-065225
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20240826223835.3928819-21-ross.philipson%40oracle.com
patch subject: [PATCH v10 20/20] x86/efi: EFI stub DRTM launch support for Secure Launch
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240828/202408280656.66ZxoOOL-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240828/202408280656.66ZxoOOL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408280656.66ZxoOOL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/firmware/efi/libstub/x86-stub.c: In function 'efi_secure_launch_update_boot_params':
>> drivers/firmware/efi/libstub/x86-stub.c:941:40: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     941 |         os_mle = txt_os_mle_data_start((void *)txt_info->txt_heap);
         |                                        ^
   drivers/firmware/efi/libstub/x86-stub.c:945:36: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     945 |         os_mle->boot_params_addr = (u64)boot_params;
         |                                    ^
   drivers/firmware/efi/libstub/x86-stub.c:953:60: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     953 |                         policy->policy_entries[i].entity = (u64)boot_params;
         |                                                            ^
   drivers/firmware/efi/libstub/x86-stub.c:980:56: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     980 |                 boot_params->hdr.cmdline_size = strlen((const char *)cmdline_ptr);
         |                                                        ^
   drivers/firmware/efi/libstub/x86-stub.c: In function 'efi_secure_launch':
   drivers/firmware/efi/libstub/x86-stub.c:1014:28: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    1014 |         handler_callback = (dl_handler_func)dlinfo->dl_handler;
         |                            ^


vim +941 drivers/firmware/efi/libstub/x86-stub.c

   927	
   928	static bool efi_secure_launch_update_boot_params(struct slr_table *slrt,
   929							 struct boot_params *boot_params)
   930	{
   931		struct slr_entry_intel_info *txt_info;
   932		struct slr_entry_policy *policy;
   933		struct txt_os_mle_data *os_mle;
   934		bool updated = false;
   935		int i;
   936	
   937		txt_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_INTEL_INFO);
   938		if (!txt_info)
   939			return false;
   940	
 > 941		os_mle = txt_os_mle_data_start((void *)txt_info->txt_heap);
   942		if (!os_mle)
   943			return false;
   944	
   945		os_mle->boot_params_addr = (u64)boot_params;
   946	
   947		policy = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_ENTRY_POLICY);
   948		if (!policy)
   949			return false;
   950	
   951		for (i = 0; i < policy->nr_entries; i++) {
   952			if (policy->policy_entries[i].entity_type == SLR_ET_BOOT_PARAMS) {
   953				policy->policy_entries[i].entity = (u64)boot_params;
   954				updated = true;
   955				break;
   956			}
   957		}
   958	
   959		/*
   960		 * If this is a PE entry into EFI stub the mocked up boot params will
   961		 * be missing some of the setup header data needed for the second stage
   962		 * of the Secure Launch boot.
   963		 */
   964		if (image) {
   965			struct setup_header *hdr = (struct setup_header *)((u8 *)image->image_base +
   966						    offsetof(struct boot_params, hdr));
   967			u64 cmdline_ptr;
   968	
   969			boot_params->hdr.setup_sects = hdr->setup_sects;
   970			boot_params->hdr.syssize = hdr->syssize;
   971			boot_params->hdr.version = hdr->version;
   972			boot_params->hdr.loadflags = hdr->loadflags;
   973			boot_params->hdr.kernel_alignment = hdr->kernel_alignment;
   974			boot_params->hdr.min_alignment = hdr->min_alignment;
   975			boot_params->hdr.xloadflags = hdr->xloadflags;
   976			boot_params->hdr.init_size = hdr->init_size;
   977			boot_params->hdr.kernel_info_offset = hdr->kernel_info_offset;
   978			efi_set_u64_form(boot_params->hdr.cmd_line_ptr, boot_params->ext_cmd_line_ptr,
   979					 &cmdline_ptr);
   980			boot_params->hdr.cmdline_size = strlen((const char *)cmdline_ptr);
   981		}
   982	
   983		return updated;
   984	}
   985	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

