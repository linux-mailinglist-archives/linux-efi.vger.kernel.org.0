Return-Path: <linux-efi+bounces-1615-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B7B962E34
	for <lists+linux-efi@lfdr.de>; Wed, 28 Aug 2024 19:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ACA91C21E50
	for <lists+linux-efi@lfdr.de>; Wed, 28 Aug 2024 17:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2411A3BC3;
	Wed, 28 Aug 2024 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P9Mi28WN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4B213C3D5;
	Wed, 28 Aug 2024 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724864971; cv=none; b=ewJL5zQ4LF3pXvPDH4Ai6/UVJRp3JXwfTM5Fb+anTs64UEYcfyPy5zDjDTwU7usNyVlR+0RREnFt25KjiRt7h82fPg1XP6huFMrUUBvpveXoXM9QA5IEFTLsXtnaWJBuUvWu6KOZpbggNR2uRhobCEvSCxBuKQNRbFMH4GF+AY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724864971; c=relaxed/simple;
	bh=Lt/vVZGxbPxIVeHUQrwZ9LbuJ1MJIFdjEIvRXf/Rn54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGNdAMQb7Tc8TIDef/byUNvK5F5c56wsvXSy/exb63Pf6u3PvMUf2sFj41hwxtBW9J8pD3x73lup42G4IKydpZMpO0CmN0bn4WGTiwE12uUt6Id92svLSYhQSIf2LSLt6IfNAGMIgn9JlSf5kOHk9H3oPfhTLNkmXzLm69PmDQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P9Mi28WN; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724864969; x=1756400969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lt/vVZGxbPxIVeHUQrwZ9LbuJ1MJIFdjEIvRXf/Rn54=;
  b=P9Mi28WN8R/Yz4qzhHxAUlcABxkGWrjwtpKYCAoXsqUNLeo/aSBERTjL
   pNxMBvia7CGnK0ATN6O+mptPBEsHASFfLOU1pkAwSZA/mex22P/GUMrIb
   AsLyNcxxaOWSODm+mIIrP971+Louha0/JrbS6obQ//qtguKhescA6dKlG
   QVBngLqcmESMiYPrO0eyXTAmDiIVj5ZnPFphnGYU31BjOy7pHT1QjIqJ1
   DK+L5mmPoBX/KtcMIUuypnwqLKkeepTNRG46H69lbJSA81nwCJ2qw848f
   RsL+eYT9m3+Ok7d42G17l96jbboLJDoGjGpgHosmtxL2mJVvlUqZpfRnI
   Q==;
X-CSE-ConnectionGUID: EQXEFky9QwKFN3Sqe1vzeA==
X-CSE-MsgGUID: dEMdHLFGRZq56eKIwWgD9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23572342"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="23572342"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 10:09:28 -0700
X-CSE-ConnectionGUID: suS3Usx0QSylOdqWws6zyg==
X-CSE-MsgGUID: NbAZYs2EQZqfjlEChoUyUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="100787474"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 28 Aug 2024 10:09:22 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjMAZ-000LBE-0t;
	Wed, 28 Aug 2024 17:09:19 +0000
Date: Thu, 29 Aug 2024 01:09:15 +0800
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
Message-ID: <202408290030.FEbUhHbr-lkp@intel.com>
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
[cannot apply to herbert-crypto-2.6/master next-20240828]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ross-Philipson/Documentation-x86-Secure-Launch-kernel-documentation/20240827-065225
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20240826223835.3928819-21-ross.philipson%40oracle.com
patch subject: [PATCH v10 20/20] x86/efi: EFI stub DRTM launch support for Secure Launch
config: i386-randconfig-062-20240828 (https://download.01.org/0day-ci/archive/20240829/202408290030.FEbUhHbr-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240829/202408290030.FEbUhHbr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408290030.FEbUhHbr-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/firmware/efi/libstub/x86-stub.c:945:41: sparse: sparse: non size-preserving pointer to integer cast
   drivers/firmware/efi/libstub/x86-stub.c:953:65: sparse: sparse: non size-preserving pointer to integer cast
>> drivers/firmware/efi/libstub/x86-stub.c:980:70: sparse: sparse: non size-preserving integer to pointer cast
   drivers/firmware/efi/libstub/x86-stub.c:1014:45: sparse: sparse: non size-preserving integer to pointer cast

vim +945 drivers/firmware/efi/libstub/x86-stub.c

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
   941		os_mle = txt_os_mle_data_start((void *)txt_info->txt_heap);
   942		if (!os_mle)
   943			return false;
   944	
 > 945		os_mle->boot_params_addr = (u64)boot_params;
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
 > 980			boot_params->hdr.cmdline_size = strlen((const char *)cmdline_ptr);
   981		}
   982	
   983		return updated;
   984	}
   985	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

