Return-Path: <linux-efi+bounces-1966-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D38399DC0F
	for <lists+linux-efi@lfdr.de>; Tue, 15 Oct 2024 04:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7561C21396
	for <lists+linux-efi@lfdr.de>; Tue, 15 Oct 2024 02:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F022B15D5CE;
	Tue, 15 Oct 2024 02:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQ/jHVOe"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D899C157A48;
	Tue, 15 Oct 2024 02:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728958164; cv=none; b=OKPCmFZCygu9BVruR/63N2k4tMoCpENjZo/ejSZtwfHz+ddnEu+/gztEhPXhqpTp72I8oTj2I1JXkahFnqspltiKQ0C2DC6JbUuLfvtarvTT65xX2iwzTeHI+317+b7aXgSxh5Ow+oswxb8e7TO0ElcHfvUhIBUJzHWAHvdu5Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728958164; c=relaxed/simple;
	bh=eelF8zGqLWZFjVs9eguEQIP+LbwNiNk9jba4UB/lBy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRb6g1uou4bYHDD/q9tm/q/YcruGzFn8F0X/X1DaAgVlv9KvywlV4oPkd6SDtSYk40lvYk/EwqaYxDjkAno9lo0zG54TvfB8LTgNE8JXgECjqb4l+34edddTjZCTKKRRq6U7aU01adsG76crstmgCuh9CV9C+7oxijZTe8KNttM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BQ/jHVOe; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728958163; x=1760494163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eelF8zGqLWZFjVs9eguEQIP+LbwNiNk9jba4UB/lBy0=;
  b=BQ/jHVOeQCDmoVlbxWUcH/3lr1jSIbNOKqvomdiAbKuGZmvlBIIVrmxW
   7HKafao7u9aV5t6AnK8EcHL5fJnfkhx52wc8ZH1Rw1RFjpdvbylZVL/81
   huB5G9kK0IyrMn61L31LpOP542zwT5/2NTaJyxNhotBz6b/fFWSTpUGRO
   rHeTF0PLKQ0A1v75q07aJpGBIvA8EGMEQN8MklUiKmKFxi7fC4sZrWoyN
   C5TJQvHnuG97Z7rU1HrvV/T3uDZemPDezdg+gWCh+Xl/NUfdPMGs5QZJa
   y/NPKwAqEFdkkFUJCzWlbcsL9cViwYNO1+FmRXhlDsZqueC3RaFWHEqw+
   A==;
X-CSE-ConnectionGUID: 9a/q6ppuQ2y7kBJYkMhlxA==
X-CSE-MsgGUID: VoySqyAPTKe1nakItAG2QA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45802468"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="45802468"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 19:09:23 -0700
X-CSE-ConnectionGUID: +tILyiGGQge9eLLsrp7MJQ==
X-CSE-MsgGUID: robl3MznQHO0WeoVAkLB8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="82516580"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 14 Oct 2024 19:09:21 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0Wzu-000HTY-04;
	Tue, 15 Oct 2024 02:09:18 +0000
Date: Tue, 15 Oct 2024 10:08:23 +0800
From: kernel test robot <lkp@intel.com>
To: Jonathan Marek <jonathan@marek.ca>, linux-efi@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] efi/libstub: consider CONFIG_CMDLINE for initrd= and
 dtb= options
Message-ID: <202410150919.kDUQQNyF-lkp@intel.com>
References: <20241011224812.25763-3-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011224812.25763-3-jonathan@marek.ca>

Hi Jonathan,

kernel test robot noticed the following build errors:

[auto build test ERROR on efi/next]
[also build test ERROR on linus/master v6.12-rc3 next-20241014]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Marek/efi-libstub-remove-uneccessary-cmdline_size-init-check/20241012-065337
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
patch link:    https://lore.kernel.org/r/20241011224812.25763-3-jonathan%40marek.ca
patch subject: [PATCH 3/3] efi/libstub: consider CONFIG_CMDLINE for initrd= and dtb= options
config: i386-defconfig (https://download.01.org/0day-ci/archive/20241015/202410150919.kDUQQNyF-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241015/202410150919.kDUQQNyF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410150919.kDUQQNyF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/firmware/efi/libstub/file.c:218:17: error: expected ';' after expression
     218 |                         cmdline = L"" CONFIG_CMDLINE;
         |                                      ^
         |                                      ;
>> drivers/firmware/efi/libstub/file.c:218:18: error: use of undeclared identifier 'CONFIG_CMDLINE'
     218 |                         cmdline = L"" CONFIG_CMDLINE;
         |                                       ^
>> drivers/firmware/efi/libstub/file.c:219:33: error: expected ')'
     219 |                         cmdline_len = ARRAY_SIZE(L"" CONFIG_CMDLINE) - 1;
         |                                                      ^
   drivers/firmware/efi/libstub/file.c:219:18: note: to match this '('
     219 |                         cmdline_len = ARRAY_SIZE(L"" CONFIG_CMDLINE) - 1;
         |                                       ^
   include/linux/array_size.h:11:32: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                ^
>> drivers/firmware/efi/libstub/file.c:219:33: error: expected ')'
     219 |                         cmdline_len = ARRAY_SIZE(L"" CONFIG_CMDLINE) - 1;
         |                                                      ^
   drivers/firmware/efi/libstub/file.c:219:18: note: to match this '('
     219 |                         cmdline_len = ARRAY_SIZE(L"" CONFIG_CMDLINE) - 1;
         |                                       ^
   include/linux/array_size.h:11:47: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                               ^
>> drivers/firmware/efi/libstub/file.c:219:33: error: expected ')'
     219 |                         cmdline_len = ARRAY_SIZE(L"" CONFIG_CMDLINE) - 1;
         |                                                      ^
   drivers/firmware/efi/libstub/file.c:219:18: note: to match this '('
     219 |                         cmdline_len = ARRAY_SIZE(L"" CONFIG_CMDLINE) - 1;
         |                                       ^
   include/linux/array_size.h:11:59: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^
   include/linux/compiler.h:243:58: note: expanded from macro '__must_be_array'
     243 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                                               ^
>> drivers/firmware/efi/libstub/file.c:219:33: error: expected ')'
     219 |                         cmdline_len = ARRAY_SIZE(L"" CONFIG_CMDLINE) - 1;
         |                                                      ^
   drivers/firmware/efi/libstub/file.c:219:18: note: to match this '('
     219 |                         cmdline_len = ARRAY_SIZE(L"" CONFIG_CMDLINE) - 1;
         |                                       ^
   include/linux/array_size.h:11:59: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^
   include/linux/compiler.h:243:64: note: expanded from macro '__must_be_array'
     243 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                                                     ^
   6 errors generated.


vim +218 drivers/firmware/efi/libstub/file.c

   177	
   178	/*
   179	 * Check the cmdline for a LILO-style file= arguments.
   180	 *
   181	 * We only support loading a file from the same filesystem as
   182	 * the kernel image.
   183	 */
   184	efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
   185					  const efi_char16_t *optstr,
   186					  int optstr_size,
   187					  unsigned long soft_limit,
   188					  unsigned long hard_limit,
   189					  unsigned long *load_addr,
   190					  unsigned long *load_size)
   191	{
   192		const efi_char16_t *cmdline = efi_table_attr(image, load_options);
   193		u32 cmdline_len = efi_table_attr(image, load_options_size);
   194		unsigned long efi_chunk_size = ULONG_MAX;
   195		efi_file_protocol_t *volume = NULL;
   196		efi_file_protocol_t *file;
   197		unsigned long alloc_addr;
   198		unsigned long alloc_size;
   199		efi_status_t status;
   200		int offset;
   201	
   202		if (!load_addr || !load_size)
   203			return EFI_INVALID_PARAMETER;
   204	
   205		efi_apply_loadoptions_quirk((const void **)&cmdline, &cmdline_len);
   206		cmdline_len /= sizeof(*cmdline);
   207	
   208		if (IS_ENABLED(CONFIG_X86) && !efi_nochunk)
   209			efi_chunk_size = EFI_READ_CHUNK_SIZE;
   210	
   211		if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
   212		    IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
   213		    cmdline_len == 0) {
   214			if (!IS_ENABLED(CONFIG_CMDLINE_FORCE) && cmdline_len > 0) {
   215				/* both CONFIG_CMDLINE and load_options should be used */
   216				efi_warn("ignoring %ls from CONFIG_CMDLINE\n", optstr);
   217			} else {
 > 218				cmdline = L"" CONFIG_CMDLINE;
 > 219				cmdline_len = ARRAY_SIZE(L"" CONFIG_CMDLINE) - 1;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

