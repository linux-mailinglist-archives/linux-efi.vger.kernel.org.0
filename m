Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95BE799BE8
	for <lists+linux-efi@lfdr.de>; Sun, 10 Sep 2023 00:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbjIIWa7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 9 Sep 2023 18:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345068AbjIIWa7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 9 Sep 2023 18:30:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D3B19E;
        Sat,  9 Sep 2023 15:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694298655; x=1725834655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nPh5kN86S2eqPb19pMUhL45pIE4wp86MSMDjsHHLLU8=;
  b=P1EQPUPGJu9pjOC/ccQXfy8VGnzkP84SpIURaM8EDx0bXYZy4nHiLKz9
   SbmQbrS0eA7FnMz0tFzwe8cVLYaFXhBCNbTSSE27TYOY2jf4M3gD0rcvo
   fFG8mktiMYFqgFNlVUMxg3Lc0wMoKsmy0p6vNYodpvAgLwR0kMh7HmTLA
   4w5Afb4cyKCQOvhlMD7xb9Zi8aae9IN0hHRel8ye/oMYEU2J0U1trFv8a
   BGgB358ZXzdNRGHV9NbJawoo/Dya+sWk1jOwBE8feKnVFosqmwAKemYTX
   vyNKi5oyNRu1qkx60qNxA4zzA6BuSOz18lFM/6RNiMNn4+H62BK0RBI/H
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="381671702"
X-IronPort-AV: E=Sophos;i="6.02,240,1688454000"; 
   d="scan'208";a="381671702"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 15:30:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="772123760"
X-IronPort-AV: E=Sophos;i="6.02,240,1688454000"; 
   d="scan'208";a="772123760"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 09 Sep 2023 15:30:52 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qf6TZ-00040M-2w;
        Sat, 09 Sep 2023 22:30:49 +0000
Date:   Sun, 10 Sep 2023 06:30:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Anisse Astier <an.astier@criteo.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] efivarfs: fix statfs() on efivarfs
Message-ID: <202309100610.zLYrHmqr-lkp@intel.com>
References: <20230909180812.10904-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230909180812.10904-1-heinrich.schuchardt@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Heinrich,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.5 next-20230908]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Heinrich-Schuchardt/efivarfs-fix-statfs-on-efivarfs/20230910-020949
base:   linus/master
patch link:    https://lore.kernel.org/r/20230909180812.10904-1-heinrich.schuchardt%40canonical.com
patch subject: [PATCH 1/1] efivarfs: fix statfs() on efivarfs
config: riscv-randconfig-r003-20230910 (https://download.01.org/0day-ci/archive/20230910/202309100610.zLYrHmqr-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230910/202309100610.zLYrHmqr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309100610.zLYrHmqr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/efivarfs/super.c:45:6: warning: variable 'remaining_space' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (efi_rt_services_supported(EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO)) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/efivarfs/super.c:60:6: note: uninitialized use occurs here
           if (remaining_space > efivar_reserved_space())
               ^~~~~~~~~~~~~~~
   fs/efivarfs/super.c:45:2: note: remove the 'if' if its condition is always true
           if (efi_rt_services_supported(EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO)) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/efivarfs/super.c:32:36: note: initialize the variable 'remaining_space' to silence this warning
           u64 storage_space, remaining_space, max_variable_size;
                                             ^
                                              = 0
   1 warning generated.


vim +45 fs/efivarfs/super.c

    26	
    27	static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
    28	{
    29		const u32 attr = EFI_VARIABLE_NON_VOLATILE |
    30				 EFI_VARIABLE_BOOTSERVICE_ACCESS |
    31				 EFI_VARIABLE_RUNTIME_ACCESS;
    32		u64 storage_space, remaining_space, max_variable_size;
    33		efi_status_t status;
    34	
    35		/*
    36		 * This is not a normal filesystem, so no point in pretending it has a block
    37		 * size; we declare f_bsize to 1, so that we can then report the exact value
    38		 * sent by EFI QueryVariableInfo in f_blocks and f_bfree
    39		 */
    40		buf->f_bsize	= 1;
    41		buf->f_namelen	= NAME_MAX;
    42		buf->f_type	= dentry->d_sb->s_magic;
    43	
    44		/* Some UEFI firmware does not implement QueryVariable() */
  > 45		if (efi_rt_services_supported(EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO)) {
    46			status = efivar_query_variable_info(attr, &storage_space,
    47							    &remaining_space,
    48							    &max_variable_size);
    49			if (status == EFI_SUCCESS) {
    50				buf->f_blocks	= storage_space;
    51				buf->f_bfree	= remaining_space;
    52			}
    53		}
    54	
    55		/*
    56		 * In f_bavail we declare the free space that the kernel will allow writing
    57		 * when the storage_paranoia x86 quirk is active. To use more, users
    58		 * should boot the kernel with efi_no_storage_paranoia.
    59		 */
    60		if (remaining_space > efivar_reserved_space())
    61			buf->f_bavail = remaining_space - efivar_reserved_space();
    62		else
    63			buf->f_bavail = 0;
    64	
    65		return 0;
    66	}
    67	static const struct super_operations efivarfs_ops = {
    68		.statfs = efivarfs_statfs,
    69		.drop_inode = generic_delete_inode,
    70		.evict_inode = efivarfs_evict_inode,
    71	};
    72	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
