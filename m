Return-Path: <linux-efi+bounces-2884-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E24A4EF5B
	for <lists+linux-efi@lfdr.de>; Tue,  4 Mar 2025 22:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3CBD172C69
	for <lists+linux-efi@lfdr.de>; Tue,  4 Mar 2025 21:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8404925F979;
	Tue,  4 Mar 2025 21:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WAJlByuH"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B323202C53;
	Tue,  4 Mar 2025 21:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741123280; cv=none; b=G45xSYDtfhK0HcNHJ8FU60ECyuHAHAP3A5ovRiC2Xg86SQS45nk6F1PRI5F5AZTXrb1cU1sd6OI0qKfnMsVJbwmkVl29rGFBv3jouGAt+V/k599ZJQdbT/dJ8qknXNvRgudQiWTVUNF5h6TJZgFUI724US0gmRX45rOYVbQNQAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741123280; c=relaxed/simple;
	bh=WXQBuvTahnb8x9uQmAs4kaSmaJWNKGYSV+qNDz+xF6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZIYJq+GyZzqbJDfJ/juOGs6DsJVvvDbRo4IenxPiRNs1HDJcrPI3BrBAQOMjObOJ+S3FqaCo0Pg1bMynhDCMhZKJsfKed94UPaS3JyJa1msCr5f7pOiqLkV2w/mHrkLpEsNj6ItoePhyXD8AL+MbMAI4+mGajyiXOGNPwUFres=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WAJlByuH; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741123279; x=1772659279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WXQBuvTahnb8x9uQmAs4kaSmaJWNKGYSV+qNDz+xF6A=;
  b=WAJlByuHezLU6m0duPxRo3CDePax6EE2keEIDtcovdxkWN4oJMd21UQM
   NWuQRQ8xD5xAybbWTwL4lxrmPyfqV+8PuWwnNr2GCWrXt6GAK1ZR3CNLV
   +vTT8PSZ18I+DHYPnrq46OZWlMyt5zUNqUl/QDqdevNXypSZyxAPwYJK/
   6d5zShixeO3E7JnnkXROicrxUzGBg75bX8dr7nsRdIQ73av5KE9Tj56Kl
   TNHsJf9zKS/0fS4ZrgAEB0TfAh8MKQHFsIBOvwNYXHw4i31Clpth9v3X+
   KVYX+1DX8+aRe6y9fS+nQczXkO9VmTO+SYQnjU0/OvcZrWrwCXKkOMgY1
   Q==;
X-CSE-ConnectionGUID: 4ndt5XqXSEOJ4ihptwjIbA==
X-CSE-MsgGUID: 4erABeSbR+GqYQvbgfjc0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="64506112"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="64506112"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 13:21:18 -0800
X-CSE-ConnectionGUID: +bbhqhejTQqFjKUCKTAcyA==
X-CSE-MsgGUID: MourMwfqSni8JykwSzE9lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="141740201"
Received: from jbfryman-mobl9.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.109.168])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 13:21:17 -0800
Date: Tue, 4 Mar 2025 13:21:15 -0800
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
Message-ID: <Z8duy-pPjH82Khyc@aschofie-mobl2.lan>
References: <20250226221157.149406-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250226221157.149406-3-Smita.KoralahalliChannabasappa@amd.com>
 <Z8dM80wy5Q8UQomz@aschofie-mobl2.lan>
 <19fd5db5-cc52-4f05-8ecc-64a4eea3b9a1@amd.com>
 <Z8dsM1hJm7H3ddgj@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8dsM1hJm7H3ddgj@aschofie-mobl2.lan>

On Tue, Mar 04, 2025 at 01:10:11PM -0800, Alison Schofield wrote:
> On Tue, Mar 04, 2025 at 12:33:56PM -0800, Koralahalli Channabasappa, Smita wrote:
> snip
> > > > +TRACE_EVENT(cxl_port_aer_uncorrectable_error,
> > > > +	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
> > > > +	TP_ARGS(dev, status, fe, hl),
> > > > +	TP_STRUCT__entry(
> > > > +		__string(devname, dev_name(dev))
> > > > +		__string(parent, dev_name(dev->parent))
> > > 
> > > Above devname, parent
> > 
> > Ok I'm planning to keep as device and parent. Let me know if wording "host"
> > is preferred over "parent".
> 
> Take a look at these in the same file that use memdev, 'host'.
> Maybe you want to be similar.
> 
> TRACE_EVENT(cxl_aer_uncorrectable_error,
> TRACE_EVENT(cxl_aer_correctable_error,

BTW - I wasn't being intentionally vague. I don't know what is the
best lingo. Do memdev's have hosts and ports have parents? If
that's the right lingo, then go with it. 


> 
> snip
> > 
> 

