Return-Path: <linux-efi+bounces-1300-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C3391A203
	for <lists+linux-efi@lfdr.de>; Thu, 27 Jun 2024 11:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339401C21DFB
	for <lists+linux-efi@lfdr.de>; Thu, 27 Jun 2024 09:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FCE137905;
	Thu, 27 Jun 2024 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dqwNbv0f"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB196132494;
	Thu, 27 Jun 2024 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719478810; cv=none; b=JfQC1Sc2y8/Dt1BoNvkOps5P5l3F0qIVb0vylu2IshE3+0nEv40hwIG2TR0DmJH5m4YCnEZNpTsU1RkDgQuLNYM08rHD/Ikx1LywfMwBz6yEfEF7TbJetalNXqH1sKRtoR4KwKALrL9L/wNfNtHpHCAeTCo6Zh4Zs2cCuetlbx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719478810; c=relaxed/simple;
	bh=LWz6ANUGwLRh/EaS8dYvHM6h2pGxRMZZnYwPlF/QOeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfURlqE6XSQd2iaVWgnvOhlo9Epp5vvrxrUXBQ4yVBum6voylWPrEcQjtGUrV4aBmqZQTy+VdAjKptpcIZQg0J4S0XBqg/H55JpN/J0K+Of5RcglFRqvzLj9bck1YYLVlTVKw6ERieaz5TUJwCicwWWlFbsls93J+lolmfBLrF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dqwNbv0f; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719478809; x=1751014809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LWz6ANUGwLRh/EaS8dYvHM6h2pGxRMZZnYwPlF/QOeQ=;
  b=dqwNbv0f7hIreYD25qrWQp9vxdpzn0E+j2kwaYRMjoG0up9oW5yE/0VS
   BkXP2HotXnjruPhdfrCtrFd4HBFdWen8iMvtv4Y1VRwE9JVWp38GBPGkj
   zr0MlIn2TGU20vS8K8oPn2DDq21obL3BqsNeLYU1GC5KdSBSplhTryQ/H
   FE564b4E0W6jEWrJpxnFCuE5SWb/qmENRdRsOoj7CPgna6+E+q36JFeUQ
   0HBvN4kdLD4TmUlfnDUGA6HWxX7j6hu5Vx6DdFBnNixnI5FJvZHGiVBLT
   qOosQZXn1P22+emu/3CzlNSlR1fnkPv5do8mT3G40k+d6V4RujZxDFzS0
   g==;
X-CSE-ConnectionGUID: 5A6qeiqlSval/rqMAE43fA==
X-CSE-MsgGUID: UCHojC5iTn+w79CVjZ6PRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="34129096"
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="34129096"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 02:00:08 -0700
X-CSE-ConnectionGUID: 7fmw1N6nSpi5WG9inioS4w==
X-CSE-MsgGUID: FmcNomYYReyCtM7w8VJWcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="44433321"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 27 Jun 2024 02:00:03 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMkz2-000G4q-1U;
	Thu, 27 Jun 2024 09:00:00 +0000
Date: Thu, 27 Jun 2024 16:59:32 +0800
From: kernel test robot <lkp@intel.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-media@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Shiju Jose <shiju.jose@huawei.com>, Tony Luck <tony.luck@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Len Brown <lenb@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
	linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] efi/cper: align ARM CPER type with UEFI 2.9A/2.10
 specs
Message-ID: <202406271626.72sHSPJJ-lkp@intel.com>
References: <b9354882f45a0c600e65df4bacee2f1080c4ba89.1719219886.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9354882f45a0c600e65df4bacee2f1080c4ba89.1719219886.git.mchehab+huawei@kernel.org>

Hi Mauro,

kernel test robot noticed the following build errors:

[auto build test ERROR on efi/next]
[also build test ERROR on rafael-pm/linux-next rafael-pm/bleeding-edge linus/master v6.10-rc5 next-20240626]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mauro-Carvalho-Chehab/efi-cper-Adjust-infopfx-size-to-accept-an-extra-space/20240625-203952
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
patch link:    https://lore.kernel.org/r/b9354882f45a0c600e65df4bacee2f1080c4ba89.1719219886.git.mchehab%2Bhuawei%40kernel.org
patch subject: [PATCH v5 3/4] efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs
config: i386-randconfig-004-20240627 (https://download.01.org/0day-ci/archive/20240627/202406271626.72sHSPJJ-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240627/202406271626.72sHSPJJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406271626.72sHSPJJ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/acpi/apei/ghes.c:566:6: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     566 |                                  FIELD_GET(CPER_ARM_ERR_TYPE_MASK, err_info->type),
         |                                  ^
   1 error generated.


vim +/FIELD_GET +566 drivers/acpi/apei/ghes.c

   530	
   531	static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
   532					       int sev, bool sync)
   533	{
   534		struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
   535		int flags = sync ? MF_ACTION_REQUIRED : 0;
   536		char error_type[120];
   537		bool queued = false;
   538		int sec_sev, i;
   539		char *p;
   540	
   541		log_arm_hw_error(err);
   542	
   543		sec_sev = ghes_severity(gdata->error_severity);
   544		if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
   545			return false;
   546	
   547		p = (char *)(err + 1);
   548		for (i = 0; i < err->err_info_num; i++) {
   549			struct cper_arm_err_info *err_info = (struct cper_arm_err_info *)p;
   550			bool is_cache = err_info->type & CPER_ARM_CACHE_ERROR;
   551			bool has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
   552	
   553			/*
   554			 * The field (err_info->error_info & BIT(26)) is fixed to set to
   555			 * 1 in some old firmware of HiSilicon Kunpeng920. We assume that
   556			 * firmware won't mix corrected errors in an uncorrected section,
   557			 * and don't filter out 'corrected' error here.
   558			 */
   559			if (is_cache && has_pa) {
   560				queued = ghes_do_memory_failure(err_info->physical_fault_addr, flags);
   561				p += err_info->length;
   562				continue;
   563			}
   564	
   565			cper_bits_to_str(error_type, sizeof(error_type),
 > 566					 FIELD_GET(CPER_ARM_ERR_TYPE_MASK, err_info->type),
   567					 cper_proc_error_type_strs,
   568					 ARRAY_SIZE(cper_proc_error_type_strs));
   569	
   570			pr_warn_ratelimited(FW_WARN GHES_PFX
   571					    "Unhandled processor error type 0x%02x: %s%s\n",
   572					    err_info->type, error_type,
   573					    (err_info->type & ~CPER_ARM_ERR_TYPE_MASK) ? " with reserved bit(s)" : "");
   574			p += err_info->length;
   575		}
   576	
   577		return queued;
   578	}
   579	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

