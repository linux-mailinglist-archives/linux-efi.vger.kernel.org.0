Return-Path: <linux-efi+bounces-3008-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168CCA6551C
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 16:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061EB16A168
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 15:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD43721CC5C;
	Mon, 17 Mar 2025 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZkHujuMV"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AB9221568
	for <linux-efi@vger.kernel.org>; Mon, 17 Mar 2025 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742224149; cv=none; b=ZT+yAbOSeZD9dBsB92ZpHOpIIsfOwhvEOOftuwWJiMuOY7SqcjbZpeQ3KZEn/KyvrtSMDm24vEpi0XoJv1hxVz8WZmbbKvN+3wbnrRTEvPRHj4dbzwCxWsZQ0NKzdYw2asdmr5ILg+yDuuFWSrAwJ3MfZUgySm2dSXoxSrDiO/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742224149; c=relaxed/simple;
	bh=Ck8xWHa15YjzQmKK9w2kTGM38RzjSZWr/Mo19kvV+ls=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xss7gqhX5hFWVLTfKbQ5hGGpu4KOdyetFW8AmQklzyTYBtAhanPv1U95OOiS7DmSvKuEI1lgbbWY/IYiANvD3+IRxllcl4zCRg59osUPnSTnKhD6cYIIe+h1LDkL7ypt5Hn9Ki9S1L8oOTl/wcBSFxIWqu2p4nZ1AGw1ba5xP6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZkHujuMV; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742224148; x=1773760148;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ck8xWHa15YjzQmKK9w2kTGM38RzjSZWr/Mo19kvV+ls=;
  b=ZkHujuMV+3hLArrahyMbcmHC+mq2cTs7vTp55Ey5ko6SEP0MdhRqCnCZ
   xmAmY1MW3DNlV2XoDbqs07mUpMpazLGvB6TM7kDVWnXok/jWj2TIf25oH
   CxRpVXds4rn08m5biGsauHjyyHS/J3Ey4cSA3g7in7ZZ6joRR6yY6ouYQ
   tS4oqm3+pYHC9qNQ4kVPpme86I2F2gzDlW7ljSljNXQ3BOYrzTTkXZLLN
   KjoVygNonO2PJTNvlZrk7usg9OeJurBV3JZOeb7C8Q+tr3vqAuGlaLWxK
   NStBiABVMmyQbVfUSc13OHE0BARNErnQg68UPm7L2UHv3JbS51bpX2dO0
   w==;
X-CSE-ConnectionGUID: Mw0a9BTDQG+Cy+wxbNLCpw==
X-CSE-MsgGUID: So0q5IFBTzKYY0VXwHZ5ZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="65787220"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="65787220"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 08:09:07 -0700
X-CSE-ConnectionGUID: uzFlDnwOS2ChbyHkv7ABoQ==
X-CSE-MsgGUID: LSoRpkSHQ+eU7Coj602z8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="121689790"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 17 Mar 2025 08:09:07 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuC5K-000Crv-1S;
	Mon, 17 Mar 2025 15:08:59 +0000
Date: Mon, 17 Mar 2025 23:08:07 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-efi@vger.kernel.org
Subject: [efi:urgent 10/10] fs/efivarfs/super.c:424:34: error: 'INODE_CHILD'
 undeclared; did you mean 'I_MUTEX_CHILD'?
Message-ID: <202503172331.vqCmniUS-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
head:   2379221e8c43a4be62811f4d8a71cfffc23df5b0
commit: 2379221e8c43a4be62811f4d8a71cfffc23df5b0 [10/10] efivarfs: use INODE_CHILD nested lock to traverse variables on resume
config: riscv-randconfig-001-20250317 (https://download.01.org/0day-ci/archive/20250317/202503172331.vqCmniUS-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250317/202503172331.vqCmniUS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503172331.vqCmniUS-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/efivarfs/super.c: In function 'efivarfs_actor':
>> fs/efivarfs/super.c:424:34: error: 'INODE_CHILD' undeclared (first use in this function); did you mean 'I_MUTEX_CHILD'?
     424 |         inode_lock_nested(inode, INODE_CHILD);
         |                                  ^~~~~~~~~~~
         |                                  I_MUTEX_CHILD
   fs/efivarfs/super.c:424:34: note: each undeclared identifier is reported only once for each function it appears in


vim +424 fs/efivarfs/super.c

   401	
   402	static bool efivarfs_actor(struct dir_context *ctx, const char *name, int len,
   403				   loff_t offset, u64 ino, unsigned mode)
   404	{
   405		unsigned long size;
   406		struct efivarfs_ctx *ectx = container_of(ctx, struct efivarfs_ctx, ctx);
   407		struct qstr qstr = { .name = name, .len = len };
   408		struct dentry *dentry = d_hash_and_lookup(ectx->sb->s_root, &qstr);
   409		struct inode *inode;
   410		struct efivar_entry *entry;
   411		int err;
   412	
   413		if (IS_ERR_OR_NULL(dentry))
   414			return true;
   415	
   416		inode = d_inode(dentry);
   417		entry = efivar_entry(inode);
   418	
   419		err = efivar_entry_size(entry, &size);
   420		size += sizeof(__u32);	/* attributes */
   421		if (err)
   422			size = 0;
   423	
 > 424		inode_lock_nested(inode, INODE_CHILD);
   425		i_size_write(inode, size);
   426		inode_unlock(inode);
   427	
   428		if (!size) {
   429			ectx->dentry = dentry;
   430			return false;
   431		}
   432	
   433		dput(dentry);
   434	
   435		return true;
   436	}
   437	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

