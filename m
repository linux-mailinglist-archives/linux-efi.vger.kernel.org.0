Return-Path: <linux-efi+bounces-4203-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 810BAAFDFD1
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 08:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708AF4E1A51
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 06:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5076C26B093;
	Wed,  9 Jul 2025 06:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FoN370EQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A11F2AD22
	for <linux-efi@vger.kernel.org>; Wed,  9 Jul 2025 06:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752041453; cv=none; b=ZCsQAX0Pt3pAk9upBXickqr/4AuGok8+WBci0MSzWGo+OLzoTteAF6PzvDNvyET/+mRt9D4e1chXD6yPPEOC4MAmQ4FGADNBqNlNAihgkKryJR2l1etTFWOzUA14Pmmsat6JSeqsShTiFdqv0ualJAzcWO1ol4UTP9KLQsOBFlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752041453; c=relaxed/simple;
	bh=iYAfPRz2PRj+sG4Tewmi3AaDfT3ypJ2gs15kgu1VCy0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CfdGDlv90VIxBbbCHqlUk2D5mfPcaT+48Nl+YsJZXgBRg1GzWhahZXI8NQLv7YQp1i5P52uGIhcrydwddyRdSNP9rQf+dKg/qtypS7WmXyY7xJrRaatWE1kf2sVuOQN5+ttjrvGtzWGiBCQymdaqiqurRmx/DdQpGFCZ60i/mBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FoN370EQ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752041451; x=1783577451;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iYAfPRz2PRj+sG4Tewmi3AaDfT3ypJ2gs15kgu1VCy0=;
  b=FoN370EQ6T/ktwAAouPtWRMv293y0TJ/FNw4T25PF9p9Rp1jc37X+iD7
   pY+E8ERcWv7nd6HGe1ykaSBb0lUlYLGiql46GpTxVVwGxNimQck2pZEFo
   sBlbn/UUw54tRp8d628TWpbeAe+ksQYSiIh09mizuPkgonWrW6RDmsQmn
   OGe//xyWbDxSkJfo5CGezZZVZxi6fGz0NO1GD3oN3S6jmkrZVThZTlWeA
   ikCvIhxZ+rTLjkPAh7Rrg4iVlBA6z0uMXgS2Sb1vdHAwnHzkJ872M9Ufr
   FMVDbXAL5pWVpgPm29/zHAptDpCFk9l/TsUEye1FFy2DKCkas0oE68AIX
   w==;
X-CSE-ConnectionGUID: WkhOI4pBRJ6pPbIFuC/bCA==
X-CSE-MsgGUID: LMUOJqjVTNCcrgBKK8H1QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="71873395"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="71873395"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 23:10:49 -0700
X-CSE-ConnectionGUID: EXnvabQsTGS/cquBiEygmA==
X-CSE-MsgGUID: BomEpb7FRpe6+ECdj0iSrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155772191"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 08 Jul 2025 23:10:48 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZO10-0003AT-1D;
	Wed, 09 Jul 2025 06:10:46 +0000
Date: Wed, 9 Jul 2025 14:10:09 +0800
From: kernel test robot <lkp@intel.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [efi:next 1/1] ERROR: modpost: "efi_kobj"
 [drivers/firmware/efi/ovmf-debug-log.ko] undefined!
Message-ID: <202507091432.rbbrjGoU-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
head:   42c68c6e354f71498f9e3e31aa5b0f9243bc1618
commit: 42c68c6e354f71498f9e3e31aa5b0f9243bc1618 [1/1] efi: add ovmf debug log driver
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20250709/202507091432.rbbrjGoU-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250709/202507091432.rbbrjGoU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507091432.rbbrjGoU-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "efi_kobj" [drivers/firmware/efi/ovmf-debug-log.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

