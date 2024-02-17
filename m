Return-Path: <linux-efi+bounces-577-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3B1858DAD
	for <lists+linux-efi@lfdr.de>; Sat, 17 Feb 2024 08:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC9E1C21020
	for <lists+linux-efi@lfdr.de>; Sat, 17 Feb 2024 07:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08D91CD0B;
	Sat, 17 Feb 2024 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="REo/RTBu"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8320E1D553;
	Sat, 17 Feb 2024 07:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708155151; cv=none; b=g6TfllgdtKm2+Ri6/xuYx8cL2duM3/uxQVCSsxIMVwzmJkRgQh23nwoGNNosgD1o235iEhRnV/qaWPqmS0bC0/VPmpm4qPh8NSCBRFKFaPejjTLLNxabJaQNlrNlIGxmrB8U5NrlHlReryZ4LMrzJAWq2qyKKuGuwSvXP4IZlvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708155151; c=relaxed/simple;
	bh=ccjuSqOZPclsskdcJMYR2Q3/YUCIG6fCIeDpqvIsxfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dp6HhaM4hSFh/ngBt70MLqMO0UB7oCoVPAOn8PWtNbCUuw/eTJshvvOg6p+ftDFbuX0zNDYivXS1FOsy6yNlcinU3NEFAQzy5VAC5qFnCiB87Rz1tVDGB55FsCOwrcOTZ97ZkQ12M3V2HHzDw1sWUCwq/V9A4gGg4kAgZL1X3NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=REo/RTBu; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708155150; x=1739691150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ccjuSqOZPclsskdcJMYR2Q3/YUCIG6fCIeDpqvIsxfk=;
  b=REo/RTBuEGbVtXwGOb7X+qBJRmwHfW5pQaELEGkcAzXcyprypdGk3a12
   m8/PbyBtrW7Tv10B9HA4OUWmOASZ/BRQ89Pr1wqSW7b/ElYHuYj0VXMeG
   CQj+TfqsHF9bAgvKzvLeUji99p1z/3kOtlo2VYSaZ7PgvaUJXDe/x0OLA
   vz6h8yxeMWRQs323kLYdim2DEIZj8F85AnN6Yw2VLbbPIiM04aFPXw8XZ
   Z5JLGcOPQKJE6zNnE7Ux4dR3MHLDGHJSonHtM70rDJ2WaU2NbYXM1k6Vm
   nUdQGmK14ysc4QbtAJiBU+ZlTgAHf2xPeZpsME+6PYtBdQD2HmHaROR1w
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2433567"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2433567"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 23:32:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="8656739"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 16 Feb 2024 23:32:23 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbFBN-0001vY-01;
	Sat, 17 Feb 2024 07:32:21 +0000
Date: Sat, 17 Feb 2024 15:31:26 +0800
From: kernel test robot <lkp@intel.com>
To: Ross Philipson <ross.philipson@oracle.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ross.philipson@oracle.com,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
	nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
	davem@davemloft.net, kanth.ghatraju@oracle.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v8 15/15] x86: EFI stub DRTM launch support for Secure
 Launch
Message-ID: <202402171503.kLhNHtkM-lkp@intel.com>
References: <20240214221847.2066632-16-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214221847.2066632-16-ross.philipson@oracle.com>

Hi Ross,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus herbert-cryptodev-2.6/master herbert-crypto-2.6/master linus/master v6.8-rc4 next-20240216]
[cannot apply to tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ross-Philipson/x86-boot-Place-kernel_info-at-a-fixed-offset/20240215-064712
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20240214221847.2066632-16-ross.philipson%40oracle.com
patch subject: [PATCH v8 15/15] x86: EFI stub DRTM launch support for Secure Launch
config: i386-randconfig-052-20240215 (https://download.01.org/0day-ci/archive/20240217/202402171503.kLhNHtkM-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240217/202402171503.kLhNHtkM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402171503.kLhNHtkM-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/firmware/efi/libstub/x86-stub.c:862:18: error: invalid input size for constraint 'a'
     862 |                       : : "a" (dlinfo->dl_handler), "D" (&dlinfo->bl_context));
         |                                ^
   1 error generated.


vim +/a +862 drivers/firmware/efi/libstub/x86-stub.c

   813	
   814	static void efi_secure_launch(struct boot_params *boot_params)
   815	{
   816		struct slr_entry_uefi_config *uefi_config;
   817		struct slr_uefi_cfg_entry *uefi_entry;
   818		struct slr_entry_dl_info *dlinfo;
   819		efi_guid_t guid = SLR_TABLE_GUID;
   820		struct slr_table *slrt;
   821		u64 memmap_hi;
   822		void *table;
   823		u8 buf[64] = {0};
   824	
   825		table = get_efi_config_table(guid);
   826	
   827		/*
   828		 * The presence of this table indicated a Secure Launch
   829		 * is being requested.
   830		 */
   831		if (!table)
   832			return;
   833	
   834		slrt = (struct slr_table *)table;
   835	
   836		if (slrt->magic != SLR_TABLE_MAGIC)
   837			return;
   838	
   839		/* Add config information to measure the UEFI memory map */
   840		uefi_config = (struct slr_entry_uefi_config *)buf;
   841		uefi_config->hdr.tag = SLR_ENTRY_UEFI_CONFIG;
   842		uefi_config->hdr.size = sizeof(*uefi_config) + sizeof(*uefi_entry);
   843		uefi_config->revision = SLR_UEFI_CONFIG_REVISION;
   844		uefi_config->nr_entries = 1;
   845		uefi_entry = (struct slr_uefi_cfg_entry *)(buf + sizeof(*uefi_config));
   846		uefi_entry->pcr = 18;
   847		uefi_entry->cfg = boot_params->efi_info.efi_memmap;
   848		memmap_hi = boot_params->efi_info.efi_memmap_hi;
   849		uefi_entry->cfg |= memmap_hi << 32;
   850		uefi_entry->size = boot_params->efi_info.efi_memmap_size;
   851		memcpy(&uefi_entry->evt_info[0], "Measured UEFI memory map",
   852			strlen("Measured UEFI memory map"));
   853	
   854		if (slr_add_entry(slrt, (struct slr_entry_hdr *)uefi_config))
   855			return;
   856	
   857		/* Jump through DL stub to initiate Secure Launch */
   858		dlinfo = (struct slr_entry_dl_info *)
   859			slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_DL_INFO);
   860	
   861		asm volatile ("jmp *%%rax"
 > 862			      : : "a" (dlinfo->dl_handler), "D" (&dlinfo->bl_context));
   863	}
   864	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

