Return-Path: <linux-efi+bounces-1068-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 800608CCA15
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 02:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B021E1C212D1
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 00:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90F9386;
	Thu, 23 May 2024 00:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZwjnPYb5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A147B1852;
	Thu, 23 May 2024 00:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716423777; cv=none; b=QzSbXNMxD2lKaFrFuG8V2pxDcppkgdCsx/qH5MHQZH08ADI7KPJKL766bzUmWS0XdkGkplceB5uFZ07WaPfXQpsFfmRqJ2/nAVhXJU0PrWy7pzowEMklc9Et7FY+m4wtfGF+M/zkZxXcYn/G8vc160Q1LLYJxl8Ms2YLDtnUHSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716423777; c=relaxed/simple;
	bh=VLpY7qGGY9Uj9hsj8eL1ZfMyVa4v25mTJX9xhzdLAww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgf5WUq+1qRag5ujiFvXFAzvXeVS4M2TcBTDlFKBmReA2ha/uHj0N4fBoPc4S0eHtJNAUrnZMpa4KqmS3b93yxY3LHozTVyQK+64nBLDC4XF4ryZujOGPehi1TXrdHvKmeY4kTY/lhCz0zJ4ed6mfTwfvjH4fPwN+7E50FRTUK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZwjnPYb5; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716423775; x=1747959775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VLpY7qGGY9Uj9hsj8eL1ZfMyVa4v25mTJX9xhzdLAww=;
  b=ZwjnPYb5WgJSvPhctOpW5DkkTTI/n5RncwYC+t1Ge81vbQLCU1QdWKR8
   1wLV79uqBUeoCKjTsH/5B/jBOup3zgaidDTWptz8hJAMGwVrL/Of/ZsF8
   3oXGUXUXBbAjgnxVkruE3W9rus81S4fosqB0agkD+UOkbO1PPbwpuv63h
   UfEw7A2YOwsCGGUTL6OMhtt+Gx89ZBnrsV3tntmLGetnr/4pDrhK2AVsz
   WQoM5RT727TInGi35veykeFBOPWrKCbYlAZJfTEMsh15CblRCas7CyyDC
   9HYwy04ccMxTth/5Tw7g9DJFUFfMQsi2Yuq9HV+bZC1GL6oiI6DyBkkzN
   g==;
X-CSE-ConnectionGUID: DYw18mtET5uwH8XhvyXUbQ==
X-CSE-MsgGUID: qJAyBzThSMikeY0EWXKiow==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="12491659"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="12491659"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 17:22:51 -0700
X-CSE-ConnectionGUID: wOj3XFDFRHavHiTz3vtlPw==
X-CSE-MsgGUID: DOeJ2TUmQxGXKYVPwZ0FKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="64318609"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.68.11])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 17:22:50 -0700
Date: Wed, 22 May 2024 17:22:48 -0700
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
Subject: Re: [PATCH 3/4] acpi/ghes, cxl/pci: Trace FW-First CXL Protocol
 Errors
Message-ID: <Zk6MWMYUg77HxbVr@aschofie-mobl2>
References: <20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240522150839.27578-4-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522150839.27578-4-Smita.KoralahalliChannabasappa@amd.com>

On Wed, May 22, 2024 at 03:08:38PM +0000, Smita Koralahalli wrote:
> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
> CPER records.
> 
> Reuse the existing work queue cxl_cper_work registered with GHES to notify
> the CXL subsystem on a Protocol error.
> 
> The defined trace events cxl_aer_uncorrectable_error and
> cxl_aer_correctable_error currently trace native CXL AER errors. Reuse
> them to trace FW-First Protocol Errors.

Will the trace log differentiate between errors reported in FW-First
versus Native mode?  Wondering if that bit of info needs to be logged
or is discoverable elsewhere.

Otherwise, LGTM,
Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/acpi/apei/ghes.c  | 14 ++++++++++++++
>  drivers/cxl/core/pci.c    | 24 ++++++++++++++++++++++++
>  drivers/cxl/cxlpci.h      |  3 +++
>  drivers/cxl/pci.c         | 34 ++++++++++++++++++++++++++++++++--
>  include/linux/cxl-event.h |  1 +
>  5 files changed, 74 insertions(+), 2 deletions(-)

snip



