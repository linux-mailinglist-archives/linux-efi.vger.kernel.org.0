Return-Path: <linux-efi+bounces-2165-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3D59D0220
	for <lists+linux-efi@lfdr.de>; Sun, 17 Nov 2024 06:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D485F284E81
	for <lists+linux-efi@lfdr.de>; Sun, 17 Nov 2024 05:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B78219E0;
	Sun, 17 Nov 2024 05:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPBgQeoV"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38E214286
	for <linux-efi@vger.kernel.org>; Sun, 17 Nov 2024 05:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731821882; cv=none; b=MB2lD+y/ZYs7kPRMQIKRleZPcL5QxNoKHwCB9CdlXW1xFwbOaQAH9hzo00RmgdYzUfrZYY8YKz8wi1Fy9uv4VjFo93H0+t7TXdx5bJAV4/ZHCdO+0ipQh0RuBcvmUxYo1nemIjSjaeUqfLJjIxcD3WtT2wTJDhdpJxtZCy6dNLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731821882; c=relaxed/simple;
	bh=1rU+rrNHSxWz+VIIrutIfxWwgu/pCSkSxyykc4ugoTg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qQQfjaPg+8oJnB2mBWle5nXDWJlhoaZ0+Cfpvwkk9JfV05thRVWIV4Ppn90R5Szy0KDfRu1NXaVbdXIYF40PvBkKfg9KybFCxjPkR4HdZYzTjyx6vhAjhd4kFqJJ32zQioaMaG2yIWdJ2juFdjM2w37c8wK5K7R1pkgOFc2B7Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPBgQeoV; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731821880; x=1763357880;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1rU+rrNHSxWz+VIIrutIfxWwgu/pCSkSxyykc4ugoTg=;
  b=hPBgQeoVAhCHVk8Hczsu0qg55oySB4D3a/UcYkZhs9BvDpXWcbnBWezU
   WVk0G6Q08OoJikrtQMmszqWMAMU8nFyIxN65tWnZ/C5cE2Ugr0omWMR3z
   arj/RNzVrQlcQmQGORBVyD2bzlBWFb/gf90JHhzMl9lw5dKHCO9aez6q1
   cJBb7filUncin8kkwrksWx35Yl6HW9BTz62DhVPTJHNrKX74H9r9+WNY5
   NTFpOCiVXSV7KpV5I69BLo5jw7GDQNfDu/92BCLzzWjhW2HX0/82gTqGZ
   X1273/bYmlN8MiDZR4l5zSqxedgw3OttJDT7V84Y+4GS5V8aHWULEl7U+
   w==;
X-CSE-ConnectionGUID: rQUN/AQ+SZaGWTh5hU5fHQ==
X-CSE-MsgGUID: T5VZFdk/RwKxjux1IXz+Dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="32035552"
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="32035552"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 21:38:00 -0800
X-CSE-ConnectionGUID: cff0JyC/SN6p+b7UXxc50Q==
X-CSE-MsgGUID: v7r7N5hNSyaHIcCkq/JePA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="88817834"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 16 Nov 2024 21:37:59 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCXyu-0001ZT-0q;
	Sun, 17 Nov 2024 05:37:56 +0000
Date: Sun, 17 Nov 2024 13:37:33 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-efi@vger.kernel.org
Subject: [efi:next 14/16] drivers/firmware/efi/libstub/file.c:221:3: error:
 expected expression
Message-ID: <202411171307.NTJaEkIS-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
head:   8e060452c658e09ce7bcdeaa19dc080d74176a56
commit: 257f826a691aa9eff8767f0ca5b82a3368b3d02a [14/16] efi/libstub: Fix command line fallback handling when loading files
config: arm-defconfig (https://download.01.org/0day-ci/archive/20241117/202411171307.NTJaEkIS-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411171307.NTJaEkIS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411171307.NTJaEkIS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/firmware/efi/libstub/file.c:221:3: error: expected expression
                   static const efi_char16_t builtin_cmdline[] = L"" CONFIG_CMDLINE;
                   ^
>> drivers/firmware/efi/libstub/file.c:223:17: error: use of undeclared identifier 'builtin_cmdline'
                   cmdline     = builtin_cmdline;
                                 ^
   drivers/firmware/efi/libstub/file.c:224:28: error: use of undeclared identifier 'builtin_cmdline'
                   cmdline_len = ARRAY_SIZE(builtin_cmdline) - 1;
                                            ^
   drivers/firmware/efi/libstub/file.c:224:28: error: use of undeclared identifier 'builtin_cmdline'
   drivers/firmware/efi/libstub/file.c:224:28: error: use of undeclared identifier 'builtin_cmdline'
   5 errors generated.


vim +221 drivers/firmware/efi/libstub/file.c

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
   192		const bool ignore_load_options = false;
   193		const efi_char16_t *cmdline = efi_table_attr(image, load_options);
   194		u32 cmdline_len = efi_table_attr(image, load_options_size);
   195		unsigned long efi_chunk_size = ULONG_MAX;
   196		efi_file_protocol_t *volume = NULL;
   197		efi_file_protocol_t *file;
   198		unsigned long alloc_addr;
   199		unsigned long alloc_size;
   200		efi_status_t status;
   201		bool twopass;
   202		int offset;
   203	
   204		if (!load_addr || !load_size)
   205			return EFI_INVALID_PARAMETER;
   206	
   207		efi_apply_loadoptions_quirk((const void **)&cmdline, &cmdline_len);
   208		cmdline_len /= sizeof(*cmdline);
   209	
   210		if (IS_ENABLED(CONFIG_X86) && !efi_nochunk)
   211			efi_chunk_size = EFI_READ_CHUNK_SIZE;
   212	
   213		alloc_addr = alloc_size = 0;
   214	
   215		if (!ignore_load_options && cmdline_len > 0) {
   216			twopass = IS_ENABLED(CONFIG_CMDLINE_BOOL) ||
   217				  IS_ENABLED(CONFIG_CMDLINE_EXTEND);
   218		} else {
   219	do_builtin:
   220	#ifdef CONFIG_CMDLINE
 > 221			static const efi_char16_t builtin_cmdline[] = L"" CONFIG_CMDLINE;
   222	
 > 223			cmdline	    = builtin_cmdline;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

