Return-Path: <linux-efi+bounces-3000-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B093BA64D44
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 12:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1135E168CAD
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 11:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AB1236445;
	Mon, 17 Mar 2025 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKZAFrpG"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2456117D346
	for <linux-efi@vger.kernel.org>; Mon, 17 Mar 2025 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212219; cv=none; b=mkDW9gh27eYcFiEk/MI0cy34wccRq4HLi4noE5qGTyxcsPPAs1saOanglcZpLJGKjwgELr7BvvoMnzsB3JOR+CJ1aCfipAQggZRrhhYnc9sw+/ao1NxmFwWfpkHOWyvRmNkS3ypRbRSiVpmP+S3OFhIEh2oPh7EMaULCHtsQxOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212219; c=relaxed/simple;
	bh=m5OUfgEzqEbwIrxovSI+gpxHqd9UNoQAGLNyabIME8E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Nj9qZjaalkNr38TawbDgNP6lNWzmkV6wfxWv1P/PKSYamZVbAWtg1+2RFzGZO9JgcDOydxhqea1tqin+db9xZjJBOvJpyFUp0pI+Ey/6px7MZaF+/IHf86LaFol/EPsdt/5c/DhqSv1WnxNmJh59OnxO8tzTbruRxpVcWFJTets=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKZAFrpG; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742212218; x=1773748218;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m5OUfgEzqEbwIrxovSI+gpxHqd9UNoQAGLNyabIME8E=;
  b=NKZAFrpGEvSXbAB49SgJS4OC4lda/m72ukEeIUBm7vjXunm2xByhckHu
   LCJhyOLzS4p1dC/4kPMdg7SH0M5Ke26A9dSNcvwmk4d6FcqUdl+hzcYGe
   9d8eAu6XywNSpW9od4BXBEc+092vs6cttaRtt/0zx1m8ZnPUJwUjaPU9j
   AhQ/pZtafoq8nUfPuwjag79R26PQB7cn+lOP+Urc9PdruvpZUv/BXeuVV
   TROzngxsVrZZjUBDBo4c+5JuWQCztalfesTdvKyDp2MX8c66gVUieC4vs
   K8TeRuv6Lsdcx6RxI4MT7IbREQIFO6d/mdBN6hs+Q6tywX7nYgazY+qnc
   A==;
X-CSE-ConnectionGUID: 4uxSnCyRQIqF1lpnbkFlBg==
X-CSE-MsgGUID: iuL8vheUQw6/etj2BY3Qug==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="46068519"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="46068519"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 04:50:18 -0700
X-CSE-ConnectionGUID: JYC56+MrTPKLn+ZZ80/LfA==
X-CSE-MsgGUID: ac3aofM9ReKUTLFvPgBxUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="121928660"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 17 Mar 2025 04:50:16 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tu8yw-000Ci5-0F;
	Mon, 17 Mar 2025 11:50:11 +0000
Date: Mon, 17 Mar 2025 19:49:43 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-efi@vger.kernel.org
Subject: [efi:urgent 10/10] fs/efivarfs/super.c:424:27: error: use of
 undeclared identifier 'INODE_CHILD'
Message-ID: <202503171938.8Qee3VKa-lkp@intel.com>
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
config: arm-randconfig-004-20250317 (https://download.01.org/0day-ci/archive/20250317/202503171938.8Qee3VKa-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 87916f8c32ebd8e284091db9b70339df57fd1e90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250317/202503171938.8Qee3VKa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503171938.8Qee3VKa-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/efivarfs/super.c:424:27: error: use of undeclared identifier 'INODE_CHILD'
     424 |         inode_lock_nested(inode, INODE_CHILD);
         |                                  ^
   1 error generated.


vim +/INODE_CHILD +424 fs/efivarfs/super.c

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

