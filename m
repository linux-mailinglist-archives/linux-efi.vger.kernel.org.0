Return-Path: <linux-efi+bounces-4130-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7175BAFA0F7
	for <lists+linux-efi@lfdr.de>; Sat,  5 Jul 2025 18:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1776D1BC00F6
	for <lists+linux-efi@lfdr.de>; Sat,  5 Jul 2025 16:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B3E204592;
	Sat,  5 Jul 2025 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j77gGkpt"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C4D140E34;
	Sat,  5 Jul 2025 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751734345; cv=none; b=QOqVwrnmFxKxs+qidMNdgXtRpeZAwYcVGCt2/YCxJzA4oqtqUOVVJAWOZC5wXwLviZ+treIMKgNfusdCwCaXUpUp4I57ghH08WnQaBin4k+2GRcvgwG2rl0P4DZM7yg1y1swvwTXOoKEaszTdOEGbkaFX7O5pyoofS7eqiNAGaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751734345; c=relaxed/simple;
	bh=e2wiSNs48ZBe2YT9oRIVY+jqqRRhnGkNdUsYu5WN1Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKTipWn2x4NOLeicQ36VSCNzIRtf5/9yEfFXIzQ1uKZ8kulnlQvxBb0/tIaK/rvLTP8kXV09M4kTun3rjpbasNRJlIiiRPoc87J5VMwVfDlpO4nVMQziVrTjiUdic1PDcBqobQI4j+0GRYsTLbTm151/8m4FwcmeVcEtu6gSkNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j77gGkpt; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751734343; x=1783270343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e2wiSNs48ZBe2YT9oRIVY+jqqRRhnGkNdUsYu5WN1Lw=;
  b=j77gGkptM3y8sdnvDS0es3aKICkNVYo3NlVXVO7pqLvf8BrHrCLTlERG
   drNTLgLcu17/XvGT2P0DbagAJlk92l9BPMl7+vxzJW6fPDKymryW/yOl/
   jpWiHIVYg7L7b5sI2KW0qRehh41cBIxkynqxrOajCIXCaYk6NCB0MOfk3
   8p03oCOHspouZ4JPjdzzyH766tv1A1D3Ux1uyX2zXFea0JcWQDMt5Yua7
   GrbzrGIrLXGRoRzyjPTik05s3JjMwnHUvrig2Hj1C3qYpbTXSpmgTG9JN
   D51jUJNcqTjk/bHhcf+7zjJvO2K/II8tSxcGwms0BDH4kksmfh/hWreNb
   w==;
X-CSE-ConnectionGUID: gQsISBb4RKumtKX9kVEbbQ==
X-CSE-MsgGUID: QiVMXGRRSOqV/ToHyl+cgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11485"; a="53238636"
X-IronPort-AV: E=Sophos;i="6.16,290,1744095600"; 
   d="scan'208";a="53238636"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2025 09:52:21 -0700
X-CSE-ConnectionGUID: z2oItUR9ROmbiFGY0UomQA==
X-CSE-MsgGUID: cOW1/8VqTWG0kX5QC4KFoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,290,1744095600"; 
   d="scan'208";a="154263751"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 05 Jul 2025 09:52:20 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uY67c-0004ch-1x;
	Sat, 05 Jul 2025 16:52:16 +0000
Date: Sun, 6 Jul 2025 00:51:34 +0800
From: kernel test robot <lkp@intel.com>
To: yangge1116@126.com, ardb@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jarkko@kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org, jgg@ziepe.ca,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, liuzixing@hygon.cn,
	Ge Yang <yangge1116@126.com>
Subject: Re: [PATCH V2] efi/tpm: Fix the issue where the CC platforms event
 log header can't be correctly identified
Message-ID: <202507060016.n5ikMP6Q-lkp@intel.com>
References: <1751710616-24464-1-git-send-email-yangge1116@126.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1751710616-24464-1-git-send-email-yangge1116@126.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on efi/next]
[also build test ERROR on char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.16-rc4 next-20250704]
[cannot apply to intel-tdx/guest-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/yangge1116-126-com/efi-tpm-Fix-the-issue-where-the-CC-platforms-event-log-header-can-t-be-correctly-identified/20250705-182032
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
patch link:    https://lore.kernel.org/r/1751710616-24464-1-git-send-email-yangge1116%40126.com
patch subject: [PATCH V2] efi/tpm: Fix the issue where the CC platforms event log header can't be correctly identified
config: arc-randconfig-002-20250705 (https://download.01.org/0day-ci/archive/20250706/202507060016.n5ikMP6Q-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250706/202507060016.n5ikMP6Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507060016.n5ikMP6Q-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/char/tpm/eventlog/tpm2.c: In function 'calc_tpm2_event_size':
>> drivers/char/tpm/eventlog/tpm2.c:40:25: error: implicit declaration of function 'cc_platform_has' [-Werror=implicit-function-declaration]
      40 |                         cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT));
         |                         ^~~~~~~~~~~~~~~
>> drivers/char/tpm/eventlog/tpm2.c:40:41: error: 'CC_ATTR_GUEST_STATE_ENCRYPT' undeclared (first use in this function)
      40 |                         cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT));
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/char/tpm/eventlog/tpm2.c:40:41: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/char/tpm/eventlog/tpm2.c:41:1: warning: control reaches end of non-void function [-Wreturn-type]
      41 | }
         | ^
   cc1: some warnings being treated as errors


vim +/cc_platform_has +40 drivers/char/tpm/eventlog/tpm2.c

    24	
    25	/*
    26	 * calc_tpm2_event_size() - calculate the event size, where event
    27	 * is an entry in the TPM 2.0 event log. The event is of type Crypto
    28	 * Agile Log Entry Format as defined in TCG EFI Protocol Specification
    29	 * Family "2.0".
    30	
    31	 * @event: event whose size is to be calculated.
    32	 * @event_header: the first event in the event log.
    33	 *
    34	 * Returns size of the event. If it is an invalid event, returns 0.
    35	 */
    36	static size_t calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
    37					   struct tcg_pcr_event *event_header)
    38	{
    39		return __calc_tpm2_event_size(event, event_header, false,
  > 40				cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT));
  > 41	}
    42	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

