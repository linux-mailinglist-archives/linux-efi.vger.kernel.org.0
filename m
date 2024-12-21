Return-Path: <linux-efi+bounces-2430-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA119FA2EC
	for <lists+linux-efi@lfdr.de>; Sun, 22 Dec 2024 00:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1741318840AE
	for <lists+linux-efi@lfdr.de>; Sat, 21 Dec 2024 23:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3181DE8B2;
	Sat, 21 Dec 2024 23:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aPCV5QbM"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C619B1DE3DD;
	Sat, 21 Dec 2024 23:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734823741; cv=none; b=PirVcdv+IOOLCGclE9D4QJVlvrbig0ul0mq9MxHuvZQHWHKljg/HYJziwCy7yq4is4b/UaX7v4/A7uW1z9TgBVyEsFqb0jSZawTiPGdHG2DLzX8N690yVD6YBwKrMBk9sfz/+WyczIZ7ptYz/+PjJz40dlbb6sKCYCJX36uMuDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734823741; c=relaxed/simple;
	bh=1+aAgOPDSjnLAePAC69Z6dC8JwBpDYKJiZOGw5bW4I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4qa+A0MUDgwD+LMtHLbuMGldKe3LGuBkkmGqQMLlJ0jelr3LR0dWAgQkm6HQsQtQCSfriR5hxLChDqsiCq93LQn49zL3sXC0p6/rsH/11z6GOHiaSCwDNUgmyzs7GEW/y0UNdCiwgdgbNYsDtZ5q/i1vbvzNzgCZ1/zePtRC8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aPCV5QbM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734823738; x=1766359738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1+aAgOPDSjnLAePAC69Z6dC8JwBpDYKJiZOGw5bW4I8=;
  b=aPCV5QbMv/LEnbrXJzA1dp18iHhbYfiAAgR8bZWEQx+E/S8gbN3yqKp2
   WQ7wpqWOaQ9QxylL58UBBQChkQiuWCqANqd4e+30+yvYOJ/kRcwWrW1IC
   XZ06LBw56FGla5OFMYM4jQBvT2Vaf0MXBlCmy6SWpLUtpvjTj63s+xvyh
   t2nsBnOizPTvnCJ8iI47gRYe3VdHsS2tnrwZmznT5tvNdFNPa9kPvUwYk
   4EHagfBDQk9hvNp24Jss09w5a/nOMxqHGRe6ctfN2e5uIlkMFF3Y3C80j
   D6b9pZyOjQF7rCqjJFyFPynbFrcQs2uOwg0bn5OZyPN7qwq7NlCbgmhVH
   Q==;
X-CSE-ConnectionGUID: E7SpFTQCTmaUh5NMhUAIHw==
X-CSE-MsgGUID: VegQJYhDT8OyIX+FzovqGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11293"; a="46342016"
X-IronPort-AV: E=Sophos;i="6.12,254,1728975600"; 
   d="scan'208";a="46342016"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2024 15:28:57 -0800
X-CSE-ConnectionGUID: 8v1WbsIkQg+D/QDA6fXyrQ==
X-CSE-MsgGUID: 2RrLNAJaTTab8oHc0hyK4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="99323289"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 21 Dec 2024 15:28:56 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tP8tx-0002Yp-1e;
	Sat, 21 Dec 2024 23:28:53 +0000
Date: Sun, 22 Dec 2024 07:28:19 +0800
From: kernel test robot <lkp@intel.com>
To: Zhou Ding <zhouding@cmss.chinamobile.com>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Zhou Ding <zhouding@cmss.chinamobile.com>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi: Fix missing `efi_handover_entry` prototype
Message-ID: <202412220717.yUDPy17I-lkp@intel.com>
References: <20241212161517.443855-1-zhouding@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212161517.443855-1-zhouding@cmss.chinamobile.com>

Hi Zhou,

kernel test robot noticed the following build errors:

[auto build test ERROR on efi/next]
[also build test ERROR on linus/master v6.13-rc3 next-20241220]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhou-Ding/efi-Fix-missing-efi_handover_entry-prototype/20241213-175109
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
patch link:    https://lore.kernel.org/r/20241212161517.443855-1-zhouding%40cmss.chinamobile.com
patch subject: [PATCH] efi: Fix missing `efi_handover_entry` prototype
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241222/202412220717.yUDPy17I-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241222/202412220717.yUDPy17I-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412220717.yUDPy17I-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: efi_handover_entry
   >>> referenced by arch/x86/boot/compressed/efi_mixed.o:(efi64_stub_entry)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

