Return-Path: <linux-efi+bounces-2017-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 814C19AF90E
	for <lists+linux-efi@lfdr.de>; Fri, 25 Oct 2024 07:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45E71C21C5A
	for <lists+linux-efi@lfdr.de>; Fri, 25 Oct 2024 05:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACCF18C353;
	Fri, 25 Oct 2024 05:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1WAhLvf"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6EA18BC05;
	Fri, 25 Oct 2024 05:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729832627; cv=none; b=jbUPyJ+DjQmEYsI4UczFALNI7tskd4Mh9MkuYP6hRha7U5X5wYaVS2njH/zDbIkL93HPqBLAdorI8E2jxPpnOtYurqyZhp4TGng8+tFjoH1lGtTf8NmF8Jdg+GuN265gsSndbaRYXVtstYKP1y6JrGBMAi5NsOTwsw+a3czPk7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729832627; c=relaxed/simple;
	bh=k/3YIX2cJB3IDhrvzlIsnk9CNBlCnPkg+bpj8kp+nZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cF+ETT6e6xORu5d+onXKCdTiIQvULwpW5G1+l6RzQchRM+jUSnSctOXtxjGm2MbSeB7a/YuvyswZsbn+0E3eeTu1V7JsKlxXBprvaM/S6L2M3oLAG0/tcGcqFW9LM+YZ6k2CgOKEXyzOp1t3gCLtNl06xlevu5IJXVxUZfPN0Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1WAhLvf; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729832625; x=1761368625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k/3YIX2cJB3IDhrvzlIsnk9CNBlCnPkg+bpj8kp+nZQ=;
  b=h1WAhLvfDLaIt3QsO1x2Daw6unekOmNR5wm/auetvKEEhO1EMI1Y32sq
   8zkHMkzpWzohP/tUWJ3+N8BuZDizZ9HStWGvyuYfu7VDHC7bbaqwN1j/3
   c0gQ2bSwLuOW3/1MSfPTW2vs/qnovCJwa5qUjLYxWBtzfvlfXgA/Dh64+
   AQGh3OtQtoX/5uetf1auodaYH/pQVqCRFSQsObIyVpuYI/9S5q6QxvZOU
   yJYePm/fSTJ8/jB4+K00c2dELVq35iVf979fDb+TD43THBwvw/halW5CV
   44kzFAMLOhAQ5buH1n18QFWTT4pQKEh6/f3B43kQfu8dnEw5pzbfiZ5oW
   w==;
X-CSE-ConnectionGUID: VEv9+eDkRGm8HWSE8++FTA==
X-CSE-MsgGUID: mP7+yizxSdeJAkKifDJ8vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29392905"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29392905"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 22:03:44 -0700
X-CSE-ConnectionGUID: hWcveicxSgGnL22dtfsTBw==
X-CSE-MsgGUID: q5FeS5fsRbu3j/lMYyR0vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="81123475"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 24 Oct 2024 22:03:42 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4CU7-000Xc2-2d;
	Fri, 25 Oct 2024 05:03:39 +0000
Date: Fri, 25 Oct 2024 13:03:22 +0800
From: kernel test robot <lkp@intel.com>
To: Zeng Heng <zengheng4@huawei.com>, bp@suse.de, javierm@redhat.com,
	ardb@kernel.org, tzimmermann@suse.de, simona.vetter@ffwll.ch
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	bobo.shaobowang@huawei.com, linux-efi@vger.kernel.org
Subject: Re: [PATCH] drivers/firmware: Fix unused const variable
 'efifb_fwnode_ops'
Message-ID: <202410251211.Jze0KkZR-lkp@intel.com>
References: <20241024084435.165333-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024084435.165333-1-zengheng4@huawei.com>

Hi Zeng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on efi/next]
[also build test WARNING on linus/master v6.12-rc4 next-20241024]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zeng-Heng/drivers-firmware-Fix-unused-const-variable-efifb_fwnode_ops/20241024-163259
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
patch link:    https://lore.kernel.org/r/20241024084435.165333-1-zengheng4%40huawei.com
patch subject: [PATCH] drivers/firmware: Fix unused const variable 'efifb_fwnode_ops'
config: x86_64-buildonly-randconfig-002-20241025 (https://download.01.org/0day-ci/archive/20241025/202410251211.Jze0KkZR-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410251211.Jze0KkZR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410251211.Jze0KkZR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/firmware/efi/sysfb_efi.c:328:12: warning: 'efifb_add_links' defined but not used [-Wunused-function]
     328 | static int efifb_add_links(struct fwnode_handle *fwnode)
         |            ^~~~~~~~~~~~~~~
>> drivers/firmware/efi/sysfb_efi.c:94:19: warning: 'efifb_set_system' defined but not used [-Wunused-function]
      94 | static int __init efifb_set_system(const struct dmi_system_id *id)
         |                   ^~~~~~~~~~~~~~~~


vim +/efifb_add_links +328 drivers/firmware/efi/sysfb_efi.c

8633ef82f101c0 Javier Martinez Canillas 2021-06-25  320  
8633ef82f101c0 Javier Martinez Canillas 2021-06-25  321  /*
8633ef82f101c0 Javier Martinez Canillas 2021-06-25  322   * If the efifb framebuffer is backed by a PCI graphics controller, we have
8633ef82f101c0 Javier Martinez Canillas 2021-06-25  323   * to ensure that this relation is expressed using a device link when
8633ef82f101c0 Javier Martinez Canillas 2021-06-25  324   * running in DT mode, or the probe order may be reversed, resulting in a
8633ef82f101c0 Javier Martinez Canillas 2021-06-25  325   * resource reservation conflict on the memory window that the efifb
8633ef82f101c0 Javier Martinez Canillas 2021-06-25  326   * framebuffer steals from the PCIe host bridge.
8633ef82f101c0 Javier Martinez Canillas 2021-06-25  327   */
8633ef82f101c0 Javier Martinez Canillas 2021-06-25 @328  static int efifb_add_links(struct fwnode_handle *fwnode)
8633ef82f101c0 Javier Martinez Canillas 2021-06-25  329  {
8633ef82f101c0 Javier Martinez Canillas 2021-06-25  330  	struct device_node *sup_np;
8633ef82f101c0 Javier Martinez Canillas 2021-06-25  331  
8633ef82f101c0 Javier Martinez Canillas 2021-06-25  332  	sup_np = find_pci_overlap_node();
8633ef82f101c0 Javier Martinez Canillas 2021-06-25  333  
8633ef82f101c0 Javier Martinez Canillas 2021-06-25  334  	/*
8633ef82f101c0 Javier Martinez Canillas 2021-06-25  335  	 * If there's no PCI graphics controller backing the efifb, we are
8633ef82f101c0 Javier Martinez Canillas 2021-06-25  336  	 * done here.
8633ef82f101c0 Javier Martinez Canillas 2021-06-25  337  	 */
8633ef82f101c0 Javier Martinez Canillas 2021-06-25  338  	if (!sup_np)
8633ef82f101c0 Javier Martinez Canillas 2021-06-25  339  		return 0;
8633ef82f101c0 Javier Martinez Canillas 2021-06-25  340  
75cde56a5b504d Saravana Kannan          2024-03-04  341  	fwnode_link_add(fwnode, of_fwnode_handle(sup_np), 0);
8633ef82f101c0 Javier Martinez Canillas 2021-06-25  342  	of_node_put(sup_np);
8633ef82f101c0 Javier Martinez Canillas 2021-06-25  343  
8633ef82f101c0 Javier Martinez Canillas 2021-06-25  344  	return 0;
8633ef82f101c0 Javier Martinez Canillas 2021-06-25  345  }
8633ef82f101c0 Javier Martinez Canillas 2021-06-25  346  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

