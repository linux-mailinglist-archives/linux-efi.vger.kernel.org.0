Return-Path: <linux-efi+bounces-2164-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAB19D020D
	for <lists+linux-efi@lfdr.de>; Sun, 17 Nov 2024 06:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6C61B23284
	for <lists+linux-efi@lfdr.de>; Sun, 17 Nov 2024 05:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7DF12E7E;
	Sun, 17 Nov 2024 05:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XtpjOYH8"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B7D79DC
	for <linux-efi@vger.kernel.org>; Sun, 17 Nov 2024 05:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731819899; cv=none; b=bdF82y47Z2u504snPXcRr2JyWtbF5L8qRPTbg+zMnUvIZkIy/UJncb0+MnZ5aAvSaAUQFm9/Rrc4mZSxBeS0joc2zalUBx2ZFRY3novWb4GDY8YUnoTU/pCgkzZg0XoTosS+g6dTaw25c0ob2r0L2TPugCo1rDqDz0ZgDAqK6ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731819899; c=relaxed/simple;
	bh=ndMyTrE/eufFAjs1aspgtRBjcU/z9cS6DONPFlZa8jY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XutgeO73TI/+cNB7W6WnThph6pxPkF0+7gjy5FAiwrCXFze59XRzLMXJzz3GUt4wbB859Nz5yWsD6arnYXojq+tga3eD7I+JcIFPvcfAF1nKCunKe51j65h8p8DwhU2H7JzsqEu+BzLFOGH9ZEUxhRiQM2f2or8e1BhITt01y0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XtpjOYH8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731819897; x=1763355897;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ndMyTrE/eufFAjs1aspgtRBjcU/z9cS6DONPFlZa8jY=;
  b=XtpjOYH8hUU2WAOdzYfDXERf7TFVtUGkTmDrH6iEgXnJwBdyRdIIZul/
   4OIHsix0bQeztmy+J7l21hv1NcjornThfFm4Loh7WmkZE+efr29RWaoaV
   dqW/cYBTSpgS9YtneHpWplHhyu14gsRuB9gqMc8YUVpBgSAmbsfcYjkVG
   2PCXVDlz57m7qQjbl7eziF06PcHeQnwcPf1gB60n1LeMSO+wOZyxxJh8G
   YpawAUumXhM/744f02X2MEZfh75Ad9TtzZkA4oM86KPDpHx1eUCw4V70S
   URZV53nlsL7SO62Ew/hJjm8FSzpnHwfWJk/ful0poT5ipNdzzjVWwUeqP
   A==;
X-CSE-ConnectionGUID: QiSFeMnWTBy1STkRzImrKA==
X-CSE-MsgGUID: y0Bg3RyCTASIFWk/7lYUZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="31713537"
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="31713537"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 21:04:56 -0800
X-CSE-ConnectionGUID: xqVdjCJqR4KpqTeAXtciOA==
X-CSE-MsgGUID: PziM0WyNR3aBYvIf4Ho5kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="119853904"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 16 Nov 2024 21:04:54 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCXSu-0001Wz-1t;
	Sun, 17 Nov 2024 05:04:52 +0000
Date: Sun, 17 Nov 2024 13:04:46 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-efi@vger.kernel.org
Subject: [efi:next 14/16] drivers/firmware/efi/libstub/file.c:221:3: warning:
 label followed by a declaration is a C23 extension
Message-ID: <202411171305.mtelLSJK-lkp@intel.com>
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
config: arm-randconfig-002-20241117 (https://download.01.org/0day-ci/archive/20241117/202411171305.mtelLSJK-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411171305.mtelLSJK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411171305.mtelLSJK-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/firmware/efi/libstub/file.c:11:
   In file included from arch/arm/include/asm/efi.h:9:
   In file included from arch/arm/include/asm/cacheflush.h:10:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/firmware/efi/libstub/file.c:221:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     221 |                 static const efi_char16_t builtin_cmdline[] = L"" CONFIG_CMDLINE;
         |                 ^
   2 warnings generated.


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

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

