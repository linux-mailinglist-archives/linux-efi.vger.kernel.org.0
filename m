Return-Path: <linux-efi+bounces-790-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DDF876EDF
	for <lists+linux-efi@lfdr.de>; Sat,  9 Mar 2024 04:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20D31F21A77
	for <lists+linux-efi@lfdr.de>; Sat,  9 Mar 2024 03:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889092D60A;
	Sat,  9 Mar 2024 03:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMNysrTm"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7573E125CA
	for <linux-efi@vger.kernel.org>; Sat,  9 Mar 2024 03:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709953694; cv=none; b=cJNB4ctDFmjYMxcjvJrNurOZxy9kz+u9fJtbf6SrzIA8S9FKXvXiPTUQowFbNggk1/4ocb4MRQGdhlH3xzCydjAOSWv4r+p1LwwpUtFFa+0L4/hnZSwTYCRZjwbSSfpFV/gDF85ughZpeFGFp6K0W71lVCV8l1uCJm6mpWZM1Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709953694; c=relaxed/simple;
	bh=Ep5PM6I3iI1mAVK5L3i7lju2TuYmqHKvtQdg6W8Mols=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X1doJ362Uk508h1k6q3gvYgkuUVVjq3Hhc1bNQwyqRaI1fBotscvGXpddY3pUaUuzvddLGbIYpKmFNXCzx34rp1hOZQ6VOB3O7D4BlvspKhpBu236/dxjlTCsRrlAGlIxT1in7hUvYihh4hV/cUQ5B1kZTIWEAk++jkap9b4tWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMNysrTm; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709953693; x=1741489693;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ep5PM6I3iI1mAVK5L3i7lju2TuYmqHKvtQdg6W8Mols=;
  b=ZMNysrTmTlhsHaZio83tjiaNeep5AT2E7RGhf/M5R+sjB4ncQdE7uOxO
   vo5xsVeo53QyIwTsuB5xfhwRE4dAPSp3bCqlC6ELx6tDNIgLvyDdkcnE1
   y+BrOolaz9S8T3CaeX6dYen5GFsJDqhqxeyjUFsiNbyk3Hxc1nEjkSOSn
   CBO1ZA9EU7tIOmwcXvo7jIwR0los9xDfz+e8T6G54HsmRdZZfjQ/++EV+
   hGsoDXihxtTjj946ZzCcpGC4QjQT9HcSmY5/7VZxCCqCPRy4Ao/WHuTMt
   R3B3xjbgaVucplmqdRGXOfKrlAfzgyDtro2euKziqW5BVfBHVcIVFtiqO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="5286860"
X-IronPort-AV: E=Sophos;i="6.07,111,1708416000"; 
   d="scan'208";a="5286860"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 19:08:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,111,1708416000"; 
   d="scan'208";a="10727003"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 08 Mar 2024 19:08:10 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rin4C-0006up-1V;
	Sat, 09 Mar 2024 03:08:08 +0000
Date: Sat, 9 Mar 2024 11:07:34 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-efi@vger.kernel.org
Subject: [efi:next 1/7]
 drivers/firmware/efi/libstub/efi-stub-helper.c:225:26: warning: field
 tagged_event within 'struct efistub_measured_event' is less aligned than
 'TCG_PCClientTaggedEvent' (aka 'struct tdTCG_PCClientTaggedEvent') and is
 usually due to 'struct efistub_measure...
Message-ID: <202403091104.pfjTGT8z-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
head:   4749cfc7ffaa827b6ecc916ab8d09bae718688bc
commit: bb208e67140ccce8c96f370a3e6f432b8a8f1adf [1/7] efi/libstub: Use TPM event typedefs from the TCG PC Client spec
config: arm-randconfig-001-20240309 (https://download.01.org/0day-ci/archive/20240309/202403091104.pfjTGT8z-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240309/202403091104.pfjTGT8z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403091104.pfjTGT8z-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/firmware/efi/libstub/efi-stub-helper.c:225:26: warning: field tagged_event within 'struct efistub_measured_event' is less aligned than 'TCG_PCClientTaggedEvent' (aka 'struct tdTCG_PCClientTaggedEvent') and is usually due to 'struct efistub_measured_event' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           TCG_PCClientTaggedEvent tagged_event;
                                   ^
   1 warning generated.


vim +225 drivers/firmware/efi/libstub/efi-stub-helper.c

   222	
   223	struct efistub_measured_event {
   224		efi_tcg2_event_t	event_data;
 > 225		TCG_PCClientTaggedEvent tagged_event;
   226	} __packed;
   227	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

