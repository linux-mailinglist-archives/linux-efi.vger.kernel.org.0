Return-Path: <linux-efi+bounces-4139-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91871AFA561
	for <lists+linux-efi@lfdr.de>; Sun,  6 Jul 2025 15:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF55D3B1650
	for <lists+linux-efi@lfdr.de>; Sun,  6 Jul 2025 13:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8854625C71B;
	Sun,  6 Jul 2025 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MiYTUYoF"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB07025C6F5;
	Sun,  6 Jul 2025 13:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751808295; cv=none; b=Bl37zzfMnExnf7awEzx15q6L7y4XbqoX6P2m163RJlqzfNS6zq8I58HSLtHy3jQq3veajG+UHHxuluqbBCK0hF0pXCWLD66tT1AwyQi9D1AwS7/tSY4JxXT42Sg7zAp28ZT5SaJEAdSOGEG6L6IZ8a5hBbmGJYJBILBDVBTIX7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751808295; c=relaxed/simple;
	bh=MDngCFoCTSnVbqNfTg5aaI5DnhuGTd8SytOekmkV6Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+aONAlWHkIVLo/fsr0yrDmkFqnNWAKoSI6woCN0Wr0d8E4PdRPqVPM+R8vvmlOPDsobrq+8pf7+OCA0sKKIl5ybXDvW8SkTnqHd8oLsnN05H8P2AKWy9j9rFiwMhj8vs5uHhSCGwTtYinHIETIYctk+f4xxcEVgLCpdThXQbzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MiYTUYoF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751808294; x=1783344294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MDngCFoCTSnVbqNfTg5aaI5DnhuGTd8SytOekmkV6Cs=;
  b=MiYTUYoFtsRJnY893yxZ5gq5jcVyN7LI9RzZawdadf6lyq1HFU0gwd4I
   JOq6DXA30eRTqP9kLuvEfldpM+QuxJIsC1RcHOoZQDwjxt0IC8UBMKWka
   pFkJFtyAPV6Uql5d/e8eqw7nOUYw0B5+5hPsaoUGyxvD4a7SgDjot9bLb
   hcZ+/F4YpYevg5hEtsFczQfFcGWVtc4KsCweawLxAr5AVBp5619XkSVaO
   UjyufwjmRWzQJoeO11Hoc2CgaNQ7P5/+8L21uaxoe9oy7UzVQ1n31waPn
   Tt87FN678HlbTvxobTL/szmMGkYB5lw2zYmmmsjf2l0EMlRdgO9m2FIF3
   A==;
X-CSE-ConnectionGUID: sgus7cX0QO2jz0mKN2RisQ==
X-CSE-MsgGUID: cUB0wNlyRumkw6Jpqkv8cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="54140955"
X-IronPort-AV: E=Sophos;i="6.16,291,1744095600"; 
   d="scan'208";a="54140955"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2025 06:24:53 -0700
X-CSE-ConnectionGUID: Xw4K0rOhRh680MdnnNbYPg==
X-CSE-MsgGUID: YxEJnjw6QFq1Ro5vTH9LLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,292,1744095600"; 
   d="scan'208";a="154738214"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 06 Jul 2025 06:24:49 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uYPMN-00054J-1F;
	Sun, 06 Jul 2025 13:24:47 +0000
Date: Sun, 6 Jul 2025 21:24:31 +0800
From: kernel test robot <lkp@intel.com>
To: Khalid Ali <khaliidcaliy@gmail.com>, ardb@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	gargaditya08@live.com, jonathan@marek.ca, kees@kernel.org,
	linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
	lukas@wunner.de, linux-kernel@vger.kernel.org,
	Khalid Ali <khaliidcaliy@gmail.com>
Subject: Re: [PATCH v2 2/2] efi/libstub: Print uefi status code on error
 messages
Message-ID: <202507062122.z20qLlyi-lkp@intel.com>
References: <20250706100147.1447-1-khaliidcaliy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250706100147.1447-1-khaliidcaliy@gmail.com>

Hi Khalid,

kernel test robot noticed the following build warnings:

[auto build test WARNING on efi/next]
[also build test WARNING on linus/master v6.16-rc4 next-20250704]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Khalid-Ali/efi-libstub-Print-uefi-status-code-on-error-messages/20250706-180349
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
patch link:    https://lore.kernel.org/r/20250706100147.1447-1-khaliidcaliy%40gmail.com
patch subject: [PATCH v2 2/2] efi/libstub: Print uefi status code on error messages
config: loongarch-randconfig-001-20250706 (https://download.01.org/0day-ci/archive/20250706/202507062122.z20qLlyi-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250706/202507062122.z20qLlyi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507062122.z20qLlyi-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/firmware/efi/libstub/efi-stub.c:117:70: warning: variable 'status' is uninitialized when used here [-Wuninitialized]
     117 |                 efi_err("getting command line via LOADED_IMAGE_PROTOCOL: 0x%lx\n", status);
         |                                                                                    ^~~~~~
   drivers/firmware/efi/libstub/efistub.h:75:39: note: expanded from macro 'efi_err'
      75 |         efi_printk(KERN_ERR "ERROR: " fmt, ##__VA_ARGS__)
         |                                              ^~~~~~~~~~~
   drivers/firmware/efi/libstub/efi-stub.c:108:21: note: initialize the variable 'status' to silence this warning
     108 |         efi_status_t status;
         |                            ^
         |                             = 0
   1 warning generated.


vim +/status +117 drivers/firmware/efi/libstub/efi-stub.c

   104	
   105	efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
   106	{
   107		char *cmdline __free(efi_pool) = NULL;
   108		efi_status_t status;
   109	
   110		/*
   111		 * Get the command line from EFI, using the LOADED_IMAGE
   112		 * protocol. We are going to copy the command line into the
   113		 * device tree, so this can be allocated anywhere.
   114		 */
   115		cmdline = efi_convert_cmdline(image);
   116		if (!cmdline) {
 > 117			efi_err("getting command line via LOADED_IMAGE_PROTOCOL: 0x%lx\n", status);
   118			return EFI_OUT_OF_RESOURCES;
   119		}
   120	
   121		if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
   122			status = efi_parse_options(cmdline);
   123			if (status != EFI_SUCCESS) {
   124				efi_err("Failed to parse EFI load options: 0x%lx\n", status);
   125				return status;
   126			}
   127		}
   128	
   129		if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
   130		    IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
   131		    cmdline[0] == 0) {
   132			status = efi_parse_options(CONFIG_CMDLINE);
   133			if (status != EFI_SUCCESS) {
   134				efi_err("Failed to parse built-in command line: 0x%lx\n", status);
   135				return status;
   136			}
   137		}
   138	
   139		*cmdline_ptr = no_free_ptr(cmdline);
   140		return EFI_SUCCESS;
   141	}
   142	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

