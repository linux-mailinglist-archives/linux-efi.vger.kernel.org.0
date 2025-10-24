Return-Path: <linux-efi+bounces-5118-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A73AC0411D
	for <lists+linux-efi@lfdr.de>; Fri, 24 Oct 2025 04:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4993A4F31
	for <lists+linux-efi@lfdr.de>; Fri, 24 Oct 2025 02:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12201C860C;
	Fri, 24 Oct 2025 02:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WI0/Hv9L"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFB61547C9;
	Fri, 24 Oct 2025 02:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761271293; cv=none; b=ZD3t7MY71z2z6Y8Si2F9GVorpy0hokTWFXbaHoknoDvyYJ4XFYR80JeowyLZ8a9PJHC0hfDLHBiaSWB3ob2udMpwgzsTmWUb8wBmnn4Dbcs6Cwl+nfmVDjzYEv859zlN2aPoi3HqqmPuWlbTYodyWg94OTmab62fwiiXAIQ5/Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761271293; c=relaxed/simple;
	bh=5pwkoiBgdK2A6PK3Fa1FU55/2aVLhOmwvVBgWWXu0Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ln/RG3bFs+SHkX7dtTdIrHFJqPQ7luK5xbVE2HlFXsOF7m0SfTmGoanE118PZhKhYxcYku9nTXksBiz/3VlvrLRLLv2T4eP831AYRjDirVpLw0blQnlBiDQrYbQRKm8gmvtlRNSu5ytAh8rj0TCzkJ/kKXaFcdlypzUP/mPRRbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WI0/Hv9L; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761271292; x=1792807292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5pwkoiBgdK2A6PK3Fa1FU55/2aVLhOmwvVBgWWXu0Ec=;
  b=WI0/Hv9LJqhNmnU6Rmp5FigC4LA8dvBeGj3vLlvnmjqyBkdQtG1vxAGr
   9jUJG95kxbPdszmmEs1peKCh0ZqHo5sf7bHqR4uf1TsyA8XU7c3vWmJ1H
   g2SzX6tFknX09HMeFqGUNwyhoIzFzVcMpc/CpGeFqMw732ka5les8/4WL
   gdSHsA04dRR4dDqPvr2+PBOEmsgDaPETLHCICP7ggIABRq1rvo/M+vcyY
   +04tvrMkDAVqxwdk3jBzQXwKYtzxz/19fd4w3HdHdc9lPATtGJXo0dH8I
   j5QIFSfJ7J8yWtmADkC4KM/E9X6UbOuhu9eUb0aJxTWhSJGIP88NTlkfM
   g==;
X-CSE-ConnectionGUID: BoMrr/a/RaudTwu4CBjCRw==
X-CSE-MsgGUID: YmDb5KjTQ3mSFwdCAW5HFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74056497"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="74056497"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 19:01:31 -0700
X-CSE-ConnectionGUID: zmw9kKYaQUyvy5/SdWeQwA==
X-CSE-MsgGUID: IZTmjtlYQNu3Pkpb2yJCJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="189439272"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 23 Oct 2025 19:01:29 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vC77O-000E5J-2l;
	Fri, 24 Oct 2025 02:01:26 +0000
Date: Fri, 24 Oct 2025 10:00:52 +0800
From: kernel test robot <lkp@intel.com>
To: Qiang Ma <maqianga@uniontech.com>, ardb@kernel.org,
	linux@armlinux.org.uk
Cc: oe-kbuild-all@lists.linux.dev, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: Re: [PATCH 2/2] efi/arm*: Remove the useless failure return message
 print
Message-ID: <202510240949.NKb4ca96-lkp@intel.com>
References: <20251023082129.75612-2-maqianga@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023082129.75612-2-maqianga@uniontech.com>

Hi Qiang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on efi/next]
[also build test WARNING on linus/master v6.18-rc2 next-20251023]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qiang-Ma/efi-arm-Remove-the-useless-failure-return-message-print/20251023-162558
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
patch link:    https://lore.kernel.org/r/20251023082129.75612-2-maqianga%40uniontech.com
patch subject: [PATCH 2/2] efi/arm*: Remove the useless failure return message print
config: arm64-randconfig-001-20251024 (https://download.01.org/0day-ci/archive/20251024/202510240949.NKb4ca96-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251024/202510240949.NKb4ca96-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510240949.NKb4ca96-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/firmware/efi/arm-runtime.c: In function 'efi_virtmap_init':
>> drivers/firmware/efi/arm-runtime.c:62:7: warning: unused variable 'ret' [-Wunused-variable]
      int ret;
          ^~~
>> drivers/firmware/efi/arm-runtime.c:61:15: warning: unused variable 'phys' [-Wunused-variable]
      phys_addr_t phys = md->phys_addr;
                  ^~~~


vim +/ret +62 drivers/firmware/efi/arm-runtime.c

9d80448ac92b720 Ard Biesheuvel 2016-08-16  51  
e5bc22a42e4d46c Ard Biesheuvel 2015-11-30  52  static bool __init efi_virtmap_init(void)
e5bc22a42e4d46c Ard Biesheuvel 2015-11-30  53  {
e5bc22a42e4d46c Ard Biesheuvel 2015-11-30  54  	efi_memory_desc_t *md;
e5bc22a42e4d46c Ard Biesheuvel 2015-11-30  55  
f7d924894265794 Ard Biesheuvel 2015-11-30  56  	efi_mm.pgd = pgd_alloc(&efi_mm);
d1eb98143c56f24 Ard Biesheuvel 2017-03-01  57  	mm_init_cpumask(&efi_mm);
e5bc22a42e4d46c Ard Biesheuvel 2015-11-30  58  	init_new_context(NULL, &efi_mm);
e5bc22a42e4d46c Ard Biesheuvel 2015-11-30  59  
78ce248faa3c46e Matt Fleming   2016-04-25  60  	for_each_efi_memory_desc(md) {
f7d924894265794 Ard Biesheuvel 2015-11-30 @61  		phys_addr_t phys = md->phys_addr;
f7d924894265794 Ard Biesheuvel 2015-11-30 @62  		int ret;
e5bc22a42e4d46c Ard Biesheuvel 2015-11-30  63  
e5bc22a42e4d46c Ard Biesheuvel 2015-11-30  64  		if (!(md->attribute & EFI_MEMORY_RUNTIME))
e5bc22a42e4d46c Ard Biesheuvel 2015-11-30  65  			continue;
37926f96302d8b6 Ard Biesheuvel 2022-10-20  66  		if (md->virt_addr == U64_MAX)
e5bc22a42e4d46c Ard Biesheuvel 2015-11-30  67  			return false;
e5bc22a42e4d46c Ard Biesheuvel 2015-11-30  68  
73fefd7f81521c6 Qiang Ma       2025-10-23  69  		efi_create_mapping(&efi_mm, md);
789957ef72f976c Ard Biesheuvel 2016-04-25  70  	}
789957ef72f976c Ard Biesheuvel 2016-04-25  71  
789957ef72f976c Ard Biesheuvel 2016-04-25  72  	if (efi_memattr_apply_permissions(&efi_mm, efi_set_mapping_permissions))
789957ef72f976c Ard Biesheuvel 2016-04-25  73  		return false;
789957ef72f976c Ard Biesheuvel 2016-04-25  74  
789957ef72f976c Ard Biesheuvel 2016-04-25  75  	return true;
e5bc22a42e4d46c Ard Biesheuvel 2015-11-30  76  }
e5bc22a42e4d46c Ard Biesheuvel 2015-11-30  77  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

