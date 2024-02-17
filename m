Return-Path: <linux-efi+bounces-579-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA89858DCC
	for <lists+linux-efi@lfdr.de>; Sat, 17 Feb 2024 08:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6271C28179D
	for <lists+linux-efi@lfdr.de>; Sat, 17 Feb 2024 07:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941011CD1D;
	Sat, 17 Feb 2024 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IllW6X7i"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011FC149E08;
	Sat, 17 Feb 2024 07:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708156480; cv=none; b=evatu/ZQQR84rZPRocXU4KeCToj51wkPvAzsQ0PrtsHmkj+vGxaUXEQ4+C388NCy7ebuVABE5b+hYg+s2LfVan54skf6Nxema8pn5GX+TnAvH9/suW2flgqfgBeAjh68tu930pKG66aQFh4v6AwNLix6vbQnquAYUsmiJF8H2iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708156480; c=relaxed/simple;
	bh=Wzz5SmshZSlav/lHAXs6G/IAqLV2Qmvclb48zyontW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIzXojK10PJCbl/+KPK+WqoDfpLyh8qUgAp26ZJeMwm4LZculqfeb3Rt3a10f/r71wXEy04wZGU1QkDr7EcR8r2CFjLPSg0N7FrRGO7WjkAiyMUdhDVjp8wavB7wW8YhfhcDZOiFsdL5GjIvTIi/NYvIvZSXmzGCcbiy1/YL3RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IllW6X7i; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708156478; x=1739692478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wzz5SmshZSlav/lHAXs6G/IAqLV2Qmvclb48zyontW8=;
  b=IllW6X7iLeBFH5S6OpUMqyxwnke4UKEQ1VRkqddR/BknrkbIXL1h498f
   EI3BsV86elT0W5LCwBoUSJIeK/AYIBijoH/S33HS1YxR+VT7gREkblYJM
   ofeJv2GjP5eIlGNxWwKUKR5xF3X8jBdTjgwHJjgu5Y84y8aOGx6/T9ItE
   yPUjaSTMa5MVRxZgl3uQnvknE7OZREyrK3psi4BOXaHFGHdtTKNSuK9/Q
   mP5WuUbhXLqjpdiZXpaTQ7J7K5SR4Z5FI7GrhiK/RlSRvoBvc0NLknXXo
   dxN1xoL5bhAAMipjmjkoKoWaNiBHW4psFeIrcrBfeABaXOCoN2gwDZ+WD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="6066336"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="6066336"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 23:54:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="4017642"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 16 Feb 2024 23:54:31 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbFWn-0001w0-02;
	Sat, 17 Feb 2024 07:54:29 +0000
Date: Sat, 17 Feb 2024 15:53:29 +0800
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
Subject: Re: [PATCH v8 14/15] x86: Secure Launch late initcall platform module
Message-ID: <202402171536.dNnLrhB1-lkp@intel.com>
References: <20240214221847.2066632-15-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214221847.2066632-15-ross.philipson@oracle.com>

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
patch link:    https://lore.kernel.org/r/20240214221847.2066632-15-ross.philipson%40oracle.com
patch subject: [PATCH v8 14/15] x86: Secure Launch late initcall platform module
config: x86_64-randconfig-r061-20240216 (https://download.01.org/0day-ci/archive/20240217/202402171536.dNnLrhB1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240217/202402171536.dNnLrhB1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402171536.dNnLrhB1-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/kernel/slmodule.c: In function 'slaunch_pcr_extend':
>> arch/x86/kernel/slmodule.c:471:14: error: implicit declaration of function 'tpm_preferred_locality' [-Werror=implicit-function-declaration]
     471 |         if (!tpm_preferred_locality(tpm, 2))
         |              ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/tpm_preferred_locality +471 arch/x86/kernel/slmodule.c

   461	
   462	static void slaunch_pcr_extend(void __iomem *txt)
   463	{
   464		struct tpm_chip *tpm;
   465	
   466		tpm = tpm_default_chip();
   467		if (!tpm)
   468			slaunch_txt_reset(txt, "Could not get default TPM chip\n",
   469					  SL_ERROR_TPM_INIT);
   470	
 > 471		if (!tpm_preferred_locality(tpm, 2))
   472			slaunch_txt_reset(txt, "Could not set TPM chip locality 2\n",
   473					  SL_ERROR_TPM_INIT);
   474	
   475		if (evtlog20)
   476			slaunch_tpm20_extend(tpm, txt);
   477		else
   478			slaunch_tpm12_extend(tpm, txt);
   479	
   480		tpm_preferred_locality(tpm, 0);
   481	}
   482	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

