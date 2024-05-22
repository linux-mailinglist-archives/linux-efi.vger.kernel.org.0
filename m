Return-Path: <linux-efi+bounces-1066-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A76268CC9C6
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 01:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0A51F22A94
	for <lists+linux-efi@lfdr.de>; Wed, 22 May 2024 23:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC60914BFBF;
	Wed, 22 May 2024 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M37YCKoK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304EA824B1;
	Wed, 22 May 2024 23:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716421230; cv=none; b=XcbboxXddreFZQVypJLJ8w8VGkr3owUxxvAwu3UShXU5GZT9XKvNqrWzDXqpo6lznGbhQQ6zAa9L8b4wq3r0wrvaILnZOaVqiNWqP6cgpgeyFaVciYSZ/5JsPVQTIDNYoj7vMnJVASwh2vbomMyw8vdUGGEbJE9oLhTu2hTDG/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716421230; c=relaxed/simple;
	bh=Lac8YCfjoaXKhule2JmpslgLs5slviDNOTBA0T1TU9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4GA8CoVTptM9W4cq/PR5CuaqC5qw4Ha/o1oOba0jLtaoMUMWQthUwUCPn5N8zy125dMasTz1IC7vWtdNvAg+JJGujX2XQLpfINIwzAZ0hL/2y4Zn5JZhEAt729EVzVB9ouot53wvQKKTVppDzZU/w84wB0qK+1rst9hNi9kH4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M37YCKoK; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716421229; x=1747957229;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lac8YCfjoaXKhule2JmpslgLs5slviDNOTBA0T1TU9E=;
  b=M37YCKoKQz+Ks/hADcOQZCohy2m1LJqP6q5J6G/QmbpdZNCZ4A7o9fSG
   u7tDSrtXMNVY0EihfiYCXVmN9X+gVbdPlfsK6TO4MZFBR89rF3c+xxk47
   uKctDCS5zdo3oWx/+6SEjrXsMCIwK2xyUb6uaQjT/9EiZkslODE+rXJrh
   sTEB8QqqvpqgEitdfwdW+MnWThwLSvAZdUSSZc9zFC9iYPbEZagMc0WIm
   01TatTAlu8NvIeoa+ntfu89eV29GT21lqSugO2zGGcOi+STjLS3yZAVKj
   JUN74c0SIPPwdm8/rDPukrVA+fgcAK0dRw/2+OW4QdGMCgMeUgTleadk8
   A==;
X-CSE-ConnectionGUID: SeJlr5eASEi14wjPT9M1+A==
X-CSE-MsgGUID: aHnpfyXeQBKf5DV8zi3+Gg==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="30239654"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="30239654"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 16:40:28 -0700
X-CSE-ConnectionGUID: c6OzR8POStKsGfZPVBt85A==
X-CSE-MsgGUID: jrMO2U2QSOiWE5exff0bxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="33357557"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.68.11])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 16:40:28 -0700
Date: Wed, 22 May 2024 16:40:26 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Bowman Terry <terry.bowman@amd.com>
Subject: Re: [PATCH 1/4] efi/cper, cxl: Make definitions and structures global
Message-ID: <Zk6CaqJ+vELPUrXj@aschofie-mobl2>
References: <20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240522150839.27578-2-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522150839.27578-2-Smita.KoralahalliChannabasappa@amd.com>

On Wed, May 22, 2024 at 03:08:36PM +0000, Smita Koralahalli wrote:
> In preparation to add tracepoint support, move protocol error UUID
> definition to a common location and make CXL RAS capability struct
> global for use across different modules.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/firmware/efi/cper_cxl.c | 11 -----------
>  drivers/firmware/efi/cper_cxl.h |  7 ++-----
>  include/linux/cper.h            |  4 ++++
>  include/linux/cxl-event.h       | 11 +++++++++++
>  4 files changed, 17 insertions(+), 16 deletions(-)
> 

snip to end

