Return-Path: <linux-efi+bounces-2701-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 269ACA18625
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jan 2025 21:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB18F188BEB4
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jan 2025 20:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BA11F7087;
	Tue, 21 Jan 2025 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mTHFMih6"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBF91B1D65;
	Tue, 21 Jan 2025 20:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737491567; cv=none; b=c/SYV/WAa4ErsS471jiBkYXhOIr3U7sw/fzdOG/mEGfs2sakPIk3Hluuqb+FJvCVV1kMrD355skxsT8dQxgIOoohocSNa2bcQIMULH2OF9qMuEX4v0XeuNiwtJSmEkIVPzpbU1Ato/PL2xtG9UNUweRaaAG7dKgXuD60CLoMh1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737491567; c=relaxed/simple;
	bh=rmu+V9oqvedpShhVh6vyXzg8csFty2UJu/7FoOHJdJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qPNx0N2pX8ASeirzcRshmsOSbI7Cx3o3h8yloWEzTIsH0ULlPXXKDbifupoeU09HEyAu93lZ9ge8EAYfrbJKhrQZx1TodBgLivJjjAvTCSpOkGg9IhkKpTTrdESWvVFXXmD6q7PVA+YS3EELy8OCMBvHSFjDLV3wArQ/uIILrcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mTHFMih6; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737491565; x=1769027565;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rmu+V9oqvedpShhVh6vyXzg8csFty2UJu/7FoOHJdJg=;
  b=mTHFMih6ZZpcrdYROlPka/5J3LA3CPS0VQfsrPA1hm5LWWi+LOFVEHzS
   EOQh8rU06NEyaT+2+LfWy1NF7DOwNjQ2uO2Ve9M4M6/lwfqmtsULsdYYd
   ZkJc+kQYeWdzAytGwuyhrnJiAU+gRgqujHJAbFcWaB9gDxIE903L+ekPs
   7FK5pKYBiUQAJ0V+gcobXzjhm3cISVal/vxPCeOWwbg9zDN+HR5Wgvj8s
   jk6QniUbwsHzJtNGtngwe33ipo5kYVUhyPW7Rd7fBwMEmaT0wLLvEZcmI
   KBldmEAGgpL5S+AHmN2TX/blLWVZ+J7U2tQxgbYIVhwzphDBfTm2B+Pa7
   A==;
X-CSE-ConnectionGUID: XDPLhCUiQ6OhtFx9SOeTgA==
X-CSE-MsgGUID: 7dsIF+YCRxOR7OccUR0R4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="37801183"
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; 
   d="scan'208";a="37801183"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 12:32:44 -0800
X-CSE-ConnectionGUID: B+A1958ARAOAyCdz9B3GRw==
X-CSE-MsgGUID: K7P7MwRYQz2IahjK42N+tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; 
   d="scan'208";a="107457590"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO [10.125.110.49]) ([10.125.110.49])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 12:32:43 -0800
Message-ID: <977859ca-3971-4d03-b514-9bf37bbceff3@intel.com>
Date: Tue, 21 Jan 2025 13:32:42 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] acpi/ghes, cper, cxl: Process CXL CPER Protocol
 errors
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>
References: <20250114120427.149260-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250114120427.149260-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/25 5:04 AM, Smita Koralahalli wrote:
> This patchset adds logging support for CXL CPER endpoint and port protocol
> errors.

Ard,
Do you mind giving an ACK for the series if it looks ok to you? I can pick up the series through the CXL tree with your ACKs. Thanks!

Smita,
Can you please respin a v6 based on top of latest upstream instead of Terry's changes? I think we are ready to pick this up before Terry's series. Thank you. 

> 
> The first 3 patches update the existing codebase to support CXL CPER
> Protocol error reporting.
> 
> The last 2 patches introduce recognizing and reporting CXL CPER Protocol
> errors.
> 
> Should be based on top of:
> https://lore.kernel.org/linux-cxl/20250107143852.3692571-1-terry.bowman@amd.com
> 
> Link to v4:
> https://lore.kernel.org/linux-cxl/20241217022032.87298-1-Smita.KoralahalliChannabasappa@amd.com
> 
> Changes in v4 -> v5:
> [Dave]: Reviewed-by tags.
> [Jonathan]: Remove blank line.
> [Jonathan, Ira]: Change CXL -> "CXL".
> [Ira]: Fix build error for CONFIG_ACPI_APEI_PCIEAER.
> 
> Changes in v3 -> v4:
> [Ira]: Use memcpy() for RAS Cap struct.
> [Jonathan]: Commit description edits.
> [Jonathan]: Use separate work registration functions for protocol and
> component errors.
> [Jonathan, Ira]: Replace flags with separate functions for port and
> device errors.
> [Jonathan]: Use goto for register and unregister calls.
> 
> Changes in v2 -> v3:
> [Dan]: Define a new workqueue for CXL CPER Protocol errors and avoid
> reusing existing workqueue which handles CXL CPER events.
> [Dan] Update function and struct names.
> [Ira] Don't define common function get_cxl_devstate().
> [Dan] Use switch cases rather than defining array of structures.
> [Dan] Pass the entire cxl_cper_prot_err struct for CXL subsystem.
> [Dan] Use pr_err_ratelimited().
> [Dan] Use AER_ severities directly. Don't define CXL_ severities.
> [Dan] Limit either to Device ID or Agent Info check.
> [Dan] Validate size of RAS field matches expectations.
> 
> Changes in v2 -> v1:
> [Jonathan] Refactor code for trace support. Rename get_cxl_dev()
> to get_cxl_devstate().
> [Jonathan] Cleanups for get_cxl_devstate().
> [Alison, Jonathan]: Define array of structures for Device ID and Serial
> number comparison.
> [Dave] p_err -> rec/p_rec.
> [Jonathan] Remove pr_warn.
> 
> Smita Koralahalli (5):
>   efi/cper, cxl: Prefix protocol error struct and function names with
>     cxl_
>   efi/cper, cxl: Make definitions and structures global
>   efi/cper, cxl: Remove cper_cxl.h
>   acpi/ghes, cper: Recognize and cache CXL Protocol errors
>   acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors
> 
>  drivers/acpi/apei/ghes.c        | 103 ++++++++++++++++++++++++++++++++
>  drivers/cxl/core/pci.c          |  62 +++++++++++++++++++
>  drivers/cxl/cxlpci.h            |   9 +++
>  drivers/cxl/pci.c               |  59 +++++++++++++++++-
>  drivers/firmware/efi/cper.c     |   6 +-
>  drivers/firmware/efi/cper_cxl.c |  39 +-----------
>  drivers/firmware/efi/cper_cxl.h |  66 --------------------
>  include/cxl/event.h             | 101 +++++++++++++++++++++++++++++++
>  include/linux/cper.h            |   8 +++
>  9 files changed, 347 insertions(+), 106 deletions(-)
>  delete mode 100644 drivers/firmware/efi/cper_cxl.h
> 


