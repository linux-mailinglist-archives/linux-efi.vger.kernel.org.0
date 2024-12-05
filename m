Return-Path: <linux-efi+bounces-2295-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30B99E60D4
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2024 23:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1208B168A23
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2024 22:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6281F1D0E27;
	Thu,  5 Dec 2024 22:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VlVn95ht"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0951E522;
	Thu,  5 Dec 2024 22:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733438970; cv=none; b=rhSiU0uSTex3rUz1ewUAiCT0HQ2bSL9yP3qoPXoTiiwdnW28UtxDr3kglLjf9Sqbb9L6JvBJUYTquj1PU4byjBaNf4wlARyE2Rf7KInWfNl20PC6/9yrSnv1x79LOLbZJvsZkrQUTkZw23IKwrQ2mT3weI+yEAD6vlQAHuUYzc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733438970; c=relaxed/simple;
	bh=Ou2gxSX0BGU8dCJZomlYlLR0SXr+L0Qw1dH4P4elyPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcD7O7MSZOPnN9epjhAMFrCTygWNHrYT/hI0skSosf4f6O5FsRAyBmsfXbUjhByINYeLqTwb40TeJFIQjZ/owiKwIQkN4vyyStvUAO+/4EEXHzdhw+44Kb4XG3pQ2PEcIQOO+DSyYIb1Y6mxu0PciXHpFB1JP6imfd7n5v9zv6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VlVn95ht; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733438968; x=1764974968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ou2gxSX0BGU8dCJZomlYlLR0SXr+L0Qw1dH4P4elyPw=;
  b=VlVn95htHPGKlPbJ34c35WKnHa1gvh+7ExuDsdnK9be2kzGHVu3jtWa1
   rWRSMkMfVztsIZL935NAgdyJUiCI/HKLDREdBm2QkC6nW5fFWB7dPaeAm
   fy+EoWcd4ASQhEuhxRTEROEo41lM8o/DrN2KeqzTY+qtYD84klLSL2bFy
   6Oyx+ZuI+CpHmMtEYEvHp1gjZmUr6KxTtdExf7B5poR0O+jrkSpCu5Wtu
   hNxLk5Xv9Lz94ZP6kpmFtm+Bk0Pqb+eaR6wrJOiYGy3sMdeGo+e5mfLTe
   cUcyoRRbwEKFMgo1ddG2H7+YV8egcExgQtaTA/CDLsONeG0ISpzUUjWX5
   g==;
X-CSE-ConnectionGUID: bjA0qJX3SMK9IY1Dpiei5w==
X-CSE-MsgGUID: nW2umoGgTzaS46JCVmhm6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="34022298"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="34022298"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:49:27 -0800
X-CSE-ConnectionGUID: G9L0aRp/QR2YhMCrZdSRAQ==
X-CSE-MsgGUID: rpoBs8CmRH2FtJjzsBGktg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="94042939"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.192])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:49:26 -0800
Date: Thu, 5 Dec 2024 14:49:23 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-sound@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-block@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net, arm-scmi@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-gpio@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	linux-hwmon@vger.kernel.org, linux-media@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-scsi@vger.kernel.org, open-iscsi@googlegroups.com,
	linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
	netdev@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v3 10/11] cxl/pmem: Remove match_nvdimm_bridge()
Message-ID: <Z1It83v8xuNuLrOt@aschofie-mobl2.lan>
References: <20241205-const_dfc_done-v3-0-1611f1486b5a@quicinc.com>
 <20241205-const_dfc_done-v3-10-1611f1486b5a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-const_dfc_done-v3-10-1611f1486b5a@quicinc.com>

On Thu, Dec 05, 2024 at 08:10:19AM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>

Suggest conveying more detail in the commit msg:

cxl/pmem> Replace match_nvdimm_bridge() w device_match_type()

> 
> match_nvdimm_bridge(), as matching function of device_find_child(), is to
> match a device with device type @cxl_nvdimm_bridge_type, and is unnecessary

Prefer being clear that this function recently become needless.
Something like:

match_nvdimm_bridge(), as matching function of device_find_child(),
matches a device with device type @cxl_nvdimm_bridge_type. The recently
added API, device_match_type, simplifies that task.
 
Replace match_nvdimm_bridge() usage with device_match_type().

With that you can add:

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/cxl/core/pmem.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> index a8473de24ebfd92f12f47e0556e28b81a29cff7c..0f8166e793e14fc0b1c04ffda79e756a743d9e6b 100644
> --- a/drivers/cxl/core/pmem.c
> +++ b/drivers/cxl/core/pmem.c
> @@ -57,11 +57,6 @@ bool is_cxl_nvdimm_bridge(struct device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(is_cxl_nvdimm_bridge, "CXL");
>  
> -static int match_nvdimm_bridge(struct device *dev, const void *data)
> -{
> -	return is_cxl_nvdimm_bridge(dev);
> -}
> -
>  /**
>   * cxl_find_nvdimm_bridge() - find a bridge device relative to a port
>   * @port: any descendant port of an nvdimm-bridge associated
> @@ -75,7 +70,9 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port)
>  	if (!cxl_root)
>  		return NULL;
>  
> -	dev = device_find_child(&cxl_root->port.dev, NULL, match_nvdimm_bridge);
> +	dev = device_find_child(&cxl_root->port.dev,
> +				&cxl_nvdimm_bridge_type,
> +				device_match_type);
>  
>  	if (!dev)
>  		return NULL;
> 
> -- 
> 2.34.1
> 
> 

