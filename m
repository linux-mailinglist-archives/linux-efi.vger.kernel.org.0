Return-Path: <linux-efi+bounces-1315-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0022E91C74F
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jun 2024 22:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5503CB25502
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jun 2024 20:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A24F7711A;
	Fri, 28 Jun 2024 20:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oKu7Gtim"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DDF76C76;
	Fri, 28 Jun 2024 20:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719606551; cv=none; b=uk2mvByGKx7yjrQ+gAjavrOoX8bBFcFd9YH/OmpjgUm1DXTVdcV1O5eR1FBpeRIX214OFgzTXZ74oEkFzUjLPSnsG9M/Y3tQXdoNYs5tb9HNlXso2//sgOtUVH9V+TH5YZjF/N/DRbbxflgvNC2kafdRCxv+PTu5taoyeLkWiv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719606551; c=relaxed/simple;
	bh=tfe5a/HvAURMpYv4FI+g4wXkv6seRMWPbq9u0BdH7fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBk3tNcce7IkOxgjnPNdNaL0yZcFGtmuHM8ui5Oa8IFKB4/YCnb2oB+FoGQKCQ44t0zOM5Gwf55UnA7jdWKfHQbEb7HjEgtp/gX57XBI8KfZcLc68WaW6TA532Tm8tlQhtqsDAUZRujv6IrdIJvINxzcjtVtDKq3qJ+yZw9dRxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oKu7Gtim; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719606550; x=1751142550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tfe5a/HvAURMpYv4FI+g4wXkv6seRMWPbq9u0BdH7fc=;
  b=oKu7Gtimj5MshfnLS0UD61Mx8tWml2jxximi77e0HUHBMyiM+RVFdmhN
   QhJSJVclU76EC7gNxUulG9dyb3YJpD8awAQf7xEEysDXPAjAwx+HHa0SI
   4rTpTfj8Lh+9CDlst1nmZjjiQOFGAF1jp2SAmCN4IMJY4sDI47r6bjYf8
   0RES8q6Xu/BLqQ4H4+TSiMFy03SpW6JwgViERIzHGs2C4iSAwBjfIEdrB
   huRI4DeOTqTkRh7rl7SFKDa8/dZzOvUKwvQM70kSjKEOHd+IkIob8s7Yw
   HG+iphslHgoJrsw9pDi6aRfWVFl3DNF9QVvQDXibYcdDbfNLQ6oBmwtgh
   A==;
X-CSE-ConnectionGUID: +GOVDWMlQdCiDTplsoWQiA==
X-CSE-MsgGUID: fCByjD0nTVubMdX8TCEgOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="42223295"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="42223295"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 13:29:08 -0700
X-CSE-ConnectionGUID: njTA7HW3ThW8tWfRxDh5eQ==
X-CSE-MsgGUID: YZ1G1OqjQjG9ACIKE/51OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="75565564"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 28 Jun 2024 13:29:03 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNIDN-000IPX-0a;
	Fri, 28 Jun 2024 20:29:01 +0000
Date: Sat, 29 Jun 2024 04:28:36 +0800
From: kernel test robot <lkp@intel.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
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
Message-ID: <202406290457.3HKFUkuV-lkp@intel.com>
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
[also build test ERROR on rafael-pm/linux-next rafael-pm/bleeding-edge linus/master v6.10-rc5 next-20240627]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mauro-Carvalho-Chehab/efi-cper-Adjust-infopfx-size-to-accept-an-extra-space/20240625-203952
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
patch link:    https://lore.kernel.org/r/b9354882f45a0c600e65df4bacee2f1080c4ba89.1719219886.git.mchehab%2Bhuawei%40kernel.org
patch subject: [PATCH v5 3/4] efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs
config: x86_64-buildonly-randconfig-003-20240628 (https://download.01.org/0day-ci/archive/20240629/202406290457.3HKFUkuV-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240629/202406290457.3HKFUkuV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406290457.3HKFUkuV-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/acpi/apei/ghes.c: In function 'ghes_handle_arm_hw_error':
>> drivers/acpi/apei/ghes.c:566:34: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
     566 |                                  FIELD_GET(CPER_ARM_ERR_TYPE_MASK, err_info->type),
         |                                  ^~~~~~~~~
   cc1: some warnings being treated as errors


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

