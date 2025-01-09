Return-Path: <linux-efi+bounces-2555-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C98A081EF
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2025 22:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5D03A056F
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2025 21:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E7C1F8F01;
	Thu,  9 Jan 2025 21:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GhxgPZGl"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A98A77102
	for <linux-efi@vger.kernel.org>; Thu,  9 Jan 2025 21:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736456602; cv=none; b=gNBJdoGeSKiWi0JRvafk0DSUh4P8fKwbeUAoyVcmhwy+QnugLNElbHebzV1OctA9s3akHYY7skhu0l1dBYAdpaTTuE23k8ghHZWeBeJ4eg2OqQj6AkIEPEKJfPZNz/EtzrLH1BjbBWlYdMFdOwoKU3ACfygguL+iQgR1wg6cySI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736456602; c=relaxed/simple;
	bh=ULjB5IbcbiHpA9dXjd720m4BZQpOPc5nrJKVP3ppMQs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rEQg6rwRoffVWjjGl+15kbwT9ED2XAg26KLYb+u58GB1EvvMGaBM5gTLDW9JWKnJ8/cIkpB4265cj/lLFGRdwrCU4WSYHAy14wf/IfYeWDrh0SfL05v1cJ996wdRTR96rI0YigtfFE+5UFXMKqioqbSAudzwxtxqFmUAQKmJ4Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GhxgPZGl; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736456601; x=1767992601;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ULjB5IbcbiHpA9dXjd720m4BZQpOPc5nrJKVP3ppMQs=;
  b=GhxgPZGlIIbZg8btMj50b6SbUtCL2BMWllReYfsu0Ly8IHb61CoikRLh
   OPUGi3urpUll7kvC3logQxbQ0THqx4VmPDB/ki8zrX0Rvlib48FBR1/2i
   B5FhUMqMvt9QuoDY6OLkRedqms6wpilOFlNEs/Xs0BoF5frhLAvHgZUYS
   hoK3uWcJnEU2SB+qR3lYy7RZ3PCzCIMB289lAvI+wxsD8Lv0DsClcaTbm
   DqwglriypxzahzFrkysW/wGS3OoSed6MS2Rrk6g2PQTGNZAwGiiqJtFH7
   Uv71paqYjXIiuEfK6PAnmTmi4kCiBJgjzryQ9d2abYq+hRjWJCzjvOOCt
   A==;
X-CSE-ConnectionGUID: FNWpFz0RTbKR2aHdxo+nKg==
X-CSE-MsgGUID: sUXIZvRbTeydogmuul6L+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36623880"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36623880"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 13:03:20 -0800
X-CSE-ConnectionGUID: sLBhDsNsQ3WHERvcExZ3Zg==
X-CSE-MsgGUID: VGnp6A2cSXOvnjU/Sqqleg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="103490727"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 09 Jan 2025 13:03:18 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tVzgR-000I8d-30;
	Thu, 09 Jan 2025 21:03:15 +0000
Date: Fri, 10 Jan 2025 05:02:52 +0800
From: kernel test robot <lkp@intel.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-efi@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: fs/efivarfs/vars.c:375: warning: Function parameter or struct member
 'duplicate_check' not described in 'efivar_init'
Message-ID: <202501100429.RSwlJMm0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
head:   5e948d5cefebebe2315faf356d7b5180144b17b0
commit: 43039cdd1a14ed12c7b506a2d78c7fa708444b06 efivarfs: add variable resync after hibernation
date:   11 hours ago
config: x86_64-buildonly-randconfig-002-20250109 (https://download.01.org/0day-ci/archive/20250110/202501100429.RSwlJMm0-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250110/202501100429.RSwlJMm0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501100429.RSwlJMm0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/efivarfs/vars.c:375: warning: Function parameter or struct member 'duplicate_check' not described in 'efivar_init'


vim +375 fs/efivarfs/vars.c

2d82e6227ea189 Ard Biesheuvel  2022-06-20  362  
2d82e6227ea189 Ard Biesheuvel  2022-06-20  363  /**
2d82e6227ea189 Ard Biesheuvel  2022-06-20  364   * efivar_init - build the initial list of EFI variables
2d82e6227ea189 Ard Biesheuvel  2022-06-20  365   * @func: callback function to invoke for every variable
2d82e6227ea189 Ard Biesheuvel  2022-06-20  366   * @data: function-specific data to pass to @func
2d82e6227ea189 Ard Biesheuvel  2022-06-20  367   *
2d82e6227ea189 Ard Biesheuvel  2022-06-20  368   * Get every EFI variable from the firmware and invoke @func. @func
b538f1e229e58c James Bottomley 2025-01-06  369   * should populate the initial dentry and inode tree.
2d82e6227ea189 Ard Biesheuvel  2022-06-20  370   *
2d82e6227ea189 Ard Biesheuvel  2022-06-20  371   * Returns 0 on success, or a kernel error code on failure.
2d82e6227ea189 Ard Biesheuvel  2022-06-20  372   */
b538f1e229e58c James Bottomley 2025-01-06  373  int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
43039cdd1a14ed James Bottomley 2025-01-07  374  		void *data, bool duplicate_check)
2d82e6227ea189 Ard Biesheuvel  2022-06-20 @375  {
f45812cc23fb74 Tim Schumacher  2024-01-26  376  	unsigned long variable_name_size = 512;
2d82e6227ea189 Ard Biesheuvel  2022-06-20  377  	efi_char16_t *variable_name;
2d82e6227ea189 Ard Biesheuvel  2022-06-20  378  	efi_status_t status;
2d82e6227ea189 Ard Biesheuvel  2022-06-20  379  	efi_guid_t vendor_guid;
2d82e6227ea189 Ard Biesheuvel  2022-06-20  380  	int err = 0;
2d82e6227ea189 Ard Biesheuvel  2022-06-20  381  
2d82e6227ea189 Ard Biesheuvel  2022-06-20  382  	variable_name = kzalloc(variable_name_size, GFP_KERNEL);
2d82e6227ea189 Ard Biesheuvel  2022-06-20  383  	if (!variable_name) {
2d82e6227ea189 Ard Biesheuvel  2022-06-20  384  		printk(KERN_ERR "efivars: Memory allocation failed.\n");
2d82e6227ea189 Ard Biesheuvel  2022-06-20  385  		return -ENOMEM;
2d82e6227ea189 Ard Biesheuvel  2022-06-20  386  	}
2d82e6227ea189 Ard Biesheuvel  2022-06-20  387  
2d82e6227ea189 Ard Biesheuvel  2022-06-20  388  	err = efivar_lock();
2d82e6227ea189 Ard Biesheuvel  2022-06-20  389  	if (err)
2d82e6227ea189 Ard Biesheuvel  2022-06-20  390  		goto free;
2d82e6227ea189 Ard Biesheuvel  2022-06-20  391  
2d82e6227ea189 Ard Biesheuvel  2022-06-20  392  	/*
f45812cc23fb74 Tim Schumacher  2024-01-26  393  	 * A small set of old UEFI implementations reject sizes
f45812cc23fb74 Tim Schumacher  2024-01-26  394  	 * above a certain threshold, the lowest seen in the wild
f45812cc23fb74 Tim Schumacher  2024-01-26  395  	 * is 512.
2d82e6227ea189 Ard Biesheuvel  2022-06-20  396  	 */
2d82e6227ea189 Ard Biesheuvel  2022-06-20  397  
2d82e6227ea189 Ard Biesheuvel  2022-06-20  398  	do {
f45812cc23fb74 Tim Schumacher  2024-01-26  399  		variable_name_size = 512;
cda30c6542c8bb Tim Schumacher  2024-03-28  400  		BUILD_BUG_ON(EFI_VAR_NAME_LEN < 512);
2d82e6227ea189 Ard Biesheuvel  2022-06-20  401  
2d82e6227ea189 Ard Biesheuvel  2022-06-20  402  		status = efivar_get_next_variable(&variable_name_size,
2d82e6227ea189 Ard Biesheuvel  2022-06-20  403  						  variable_name,
2d82e6227ea189 Ard Biesheuvel  2022-06-20  404  						  &vendor_guid);
2d82e6227ea189 Ard Biesheuvel  2022-06-20  405  		switch (status) {
2d82e6227ea189 Ard Biesheuvel  2022-06-20  406  		case EFI_SUCCESS:
2d82e6227ea189 Ard Biesheuvel  2022-06-20  407  			variable_name_size = var_name_strnsize(variable_name,
2d82e6227ea189 Ard Biesheuvel  2022-06-20  408  							       variable_name_size);
2d82e6227ea189 Ard Biesheuvel  2022-06-20  409  
2d82e6227ea189 Ard Biesheuvel  2022-06-20  410  			/*
2d82e6227ea189 Ard Biesheuvel  2022-06-20  411  			 * Some firmware implementations return the
2d82e6227ea189 Ard Biesheuvel  2022-06-20  412  			 * same variable name on multiple calls to
2d82e6227ea189 Ard Biesheuvel  2022-06-20  413  			 * get_next_variable(). Terminate the loop
2d82e6227ea189 Ard Biesheuvel  2022-06-20  414  			 * immediately as there is no guarantee that
2d82e6227ea189 Ard Biesheuvel  2022-06-20  415  			 * we'll ever see a different variable name,
2d82e6227ea189 Ard Biesheuvel  2022-06-20  416  			 * and may end up looping here forever.
2d82e6227ea189 Ard Biesheuvel  2022-06-20  417  			 */
43039cdd1a14ed James Bottomley 2025-01-07  418  			if (duplicate_check &&
43039cdd1a14ed James Bottomley 2025-01-07  419  			    efivarfs_variable_is_present(variable_name,
4ec7bd5db9a1f6 James Bottomley 2025-01-06  420  							 &vendor_guid, data)) {
2d82e6227ea189 Ard Biesheuvel  2022-06-20  421  				dup_variable_bug(variable_name, &vendor_guid,
2d82e6227ea189 Ard Biesheuvel  2022-06-20  422  						 variable_name_size);
2d82e6227ea189 Ard Biesheuvel  2022-06-20  423  				status = EFI_NOT_FOUND;
2d82e6227ea189 Ard Biesheuvel  2022-06-20  424  			} else {
2d82e6227ea189 Ard Biesheuvel  2022-06-20  425  				err = func(variable_name, vendor_guid,
b538f1e229e58c James Bottomley 2025-01-06  426  					   variable_name_size, data);
2d82e6227ea189 Ard Biesheuvel  2022-06-20  427  				if (err)
2d82e6227ea189 Ard Biesheuvel  2022-06-20  428  					status = EFI_NOT_FOUND;
2d82e6227ea189 Ard Biesheuvel  2022-06-20  429  			}
2d82e6227ea189 Ard Biesheuvel  2022-06-20  430  			break;
2d82e6227ea189 Ard Biesheuvel  2022-06-20  431  		case EFI_UNSUPPORTED:
2d82e6227ea189 Ard Biesheuvel  2022-06-20  432  			err = -EOPNOTSUPP;
2d82e6227ea189 Ard Biesheuvel  2022-06-20  433  			status = EFI_NOT_FOUND;
2d82e6227ea189 Ard Biesheuvel  2022-06-20  434  			break;
2d82e6227ea189 Ard Biesheuvel  2022-06-20  435  		case EFI_NOT_FOUND:
2d82e6227ea189 Ard Biesheuvel  2022-06-20  436  			break;
f45812cc23fb74 Tim Schumacher  2024-01-26  437  		case EFI_BUFFER_TOO_SMALL:
f45812cc23fb74 Tim Schumacher  2024-01-26  438  			pr_warn("efivars: Variable name size exceeds maximum (%lu > 512)\n",
f45812cc23fb74 Tim Schumacher  2024-01-26  439  				variable_name_size);
f45812cc23fb74 Tim Schumacher  2024-01-26  440  			status = EFI_NOT_FOUND;
f45812cc23fb74 Tim Schumacher  2024-01-26  441  			break;
2d82e6227ea189 Ard Biesheuvel  2022-06-20  442  		default:
f45812cc23fb74 Tim Schumacher  2024-01-26  443  			pr_warn("efivars: get_next_variable: status=%lx\n", status);
2d82e6227ea189 Ard Biesheuvel  2022-06-20  444  			status = EFI_NOT_FOUND;
2d82e6227ea189 Ard Biesheuvel  2022-06-20  445  			break;
2d82e6227ea189 Ard Biesheuvel  2022-06-20  446  		}
2d82e6227ea189 Ard Biesheuvel  2022-06-20  447  
2d82e6227ea189 Ard Biesheuvel  2022-06-20  448  	} while (status != EFI_NOT_FOUND);
2d82e6227ea189 Ard Biesheuvel  2022-06-20  449  
2d82e6227ea189 Ard Biesheuvel  2022-06-20  450  	efivar_unlock();
2d82e6227ea189 Ard Biesheuvel  2022-06-20  451  free:
2d82e6227ea189 Ard Biesheuvel  2022-06-20  452  	kfree(variable_name);
2d82e6227ea189 Ard Biesheuvel  2022-06-20  453  
2d82e6227ea189 Ard Biesheuvel  2022-06-20  454  	return err;
2d82e6227ea189 Ard Biesheuvel  2022-06-20  455  }
2d82e6227ea189 Ard Biesheuvel  2022-06-20  456  

:::::: The code at line 375 was first introduced by commit
:::::: 2d82e6227ea189c0589e7383a36616ac2a2d248c efi: vars: Move efivar caching layer into efivarfs

:::::: TO: Ard Biesheuvel <ardb@kernel.org>
:::::: CC: Ard Biesheuvel <ardb@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

