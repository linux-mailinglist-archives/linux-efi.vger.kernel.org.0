Return-Path: <linux-efi+bounces-2883-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F00A4EF2D
	for <lists+linux-efi@lfdr.de>; Tue,  4 Mar 2025 22:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282C416B393
	for <lists+linux-efi@lfdr.de>; Tue,  4 Mar 2025 21:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965351FDA9D;
	Tue,  4 Mar 2025 21:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mktH5nY4"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673921C84DB;
	Tue,  4 Mar 2025 21:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122616; cv=none; b=ovk8qwdv0gkEvsuSKUujCOepAuPtwcCO5mISKNL3ATzp+F6czUYJTKaXtYD0leSyfL76KqEn0LAXPeNgCuSJb+GzJcx00+cupl4skDovLifVcVttmnIXYuOSqtjW5wNMTKDye5N1cXTGFS6vVeaigOfNDB+oqRFXivrXIw7HYC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122616; c=relaxed/simple;
	bh=2Z9ExiESYGPkHbDyTxWla2kp5aMJQiIVZir7zENRQV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rF6QswFMVmvNungBwhKdaNfOuCeCViNkbNCugXOO2AXAu1H1qdwHoMOHvXA4fcLl1xjW4fQHenjqKAxzmUEIGY0NszR9KUN8D/sbQi2UIM0UkwD/HBm5Nl3EmzyPTXJHiP4BH+DIvPDfXfs1WWA3GmIIsVJn7ZPXxgvJ1AWPdZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mktH5nY4; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741122614; x=1772658614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Z9ExiESYGPkHbDyTxWla2kp5aMJQiIVZir7zENRQV0=;
  b=mktH5nY4ed3PZdNbqtQ/qINfFgcnpyn4YLihDrbqp9xNEFw2ZRYbSFRH
   L04mNwnmvZDMtgJ7LFljs+i1+9aTRJZ3JgDK3V91m3EAvfXS0wKpc4UXt
   nCusZL7Uft3AHiG1W3ShgtPHKar8XiJibZO31evt6W0ZFTmPm/qxsOpQ8
   8ggNq/+qPHY3sN+30+Ip0QqvXzg2R7xb22w2tJiO0jjgIqY197vCYnCfy
   dZensdUDRPf1xSMtXrpiCKqBpqA5ff0sN1uGtcjimIZHay5a4y5ennHF0
   +XKON4dcX6mmtmY8o5lPsS/t0rLhNGMtlgpyg4I/OSOs/jMCI8i/quCtH
   A==;
X-CSE-ConnectionGUID: utcp0CNBReCiDLHJAONo0A==
X-CSE-MsgGUID: gX1do/EZR9Ss8pT/DRPc/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41243011"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="41243011"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 13:10:13 -0800
X-CSE-ConnectionGUID: QIfkK/b4QMC/CbzzhPTorA==
X-CSE-MsgGUID: HJUvxuN8QKWP4KVRkzZmEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="119173075"
Received: from jbfryman-mobl9.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.109.168])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 13:10:13 -0800
Date: Tue, 4 Mar 2025 13:10:11 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: "Koralahalli Channabasappa, Smita" <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v7 2/2] cxl/pci: Add trace logging for CXL PCIe Port RAS
 errors
Message-ID: <Z8dsM1hJm7H3ddgj@aschofie-mobl2.lan>
References: <20250226221157.149406-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250226221157.149406-3-Smita.KoralahalliChannabasappa@amd.com>
 <Z8dM80wy5Q8UQomz@aschofie-mobl2.lan>
 <19fd5db5-cc52-4f05-8ecc-64a4eea3b9a1@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19fd5db5-cc52-4f05-8ecc-64a4eea3b9a1@amd.com>

On Tue, Mar 04, 2025 at 12:33:56PM -0800, Koralahalli Channabasappa, Smita wrote:
snip
> > > +TRACE_EVENT(cxl_port_aer_uncorrectable_error,
> > > +	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
> > > +	TP_ARGS(dev, status, fe, hl),
> > > +	TP_STRUCT__entry(
> > > +		__string(devname, dev_name(dev))
> > > +		__string(parent, dev_name(dev->parent))
> > 
> > Above devname, parent
> 
> Ok I'm planning to keep as device and parent. Let me know if wording "host"
> is preferred over "parent".

Take a look at these in the same file that use memdev, 'host'.
Maybe you want to be similar.

TRACE_EVENT(cxl_aer_uncorrectable_error,
TRACE_EVENT(cxl_aer_correctable_error,

snip
> 

