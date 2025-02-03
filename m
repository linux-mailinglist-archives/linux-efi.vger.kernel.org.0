Return-Path: <linux-efi+bounces-2738-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B51A260FB
	for <lists+linux-efi@lfdr.de>; Mon,  3 Feb 2025 18:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F2D16234A
	for <lists+linux-efi@lfdr.de>; Mon,  3 Feb 2025 17:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A6F20B7EF;
	Mon,  3 Feb 2025 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lGGjozCc"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27771D5159;
	Mon,  3 Feb 2025 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738602573; cv=none; b=SM0zyHxUs7ogcXMv3O3Wxy3WZ/f+1162hUt7qfhzqFFfSlj883M0TSwYg/n/Qfwz7Mu3LK6ZeP2AOJoZgkiYheB8RGUmyUV/vshYv4afMVCxbmh0LOZzKhO6MmmhUJx2mpbF4rDjc80RMZDG6DqhfxK1O3GCzqRaCnAVIvOtbXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738602573; c=relaxed/simple;
	bh=Z9XDuHu7bVd8nF328qwy+Qj5EiiwyMI6eckREbDdUG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=koR2nkv7UMfGsGUnJYfOyf6mDfcE59N6UJ1HoWVz8MvdrOVQRvKrBEH6z0TPhfKaIEQbtLVExXZKYWmsafGQVChHJIMtoMBZ3VxbT0vrEvLjJXMmmb8m7jYWxB0+mIGDNhDmb3VlwleKvz8O3j8J0wght4jaHMyFv6AS1ymkuXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lGGjozCc; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738602572; x=1770138572;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z9XDuHu7bVd8nF328qwy+Qj5EiiwyMI6eckREbDdUG8=;
  b=lGGjozCcQlWshhCpAlH10637+hG73VdJgJjDeKdoezLk+DR/3wsC6DP1
   qggrZRHVWdv1eZ/Q8BZKM80KwQJaHajA14MBY4mh2IHxYmyQDb8hd99Rj
   yX/VFcXD7H9khRYpHq2hYIbbNA+hfFGMNp5YUUtDMsjoS4C8ZeHLThWc5
   RdKO/GQum96ulrausYkqSS3vWo7EWDI20woSqCi50c74WonzhU0vtUB+8
   CCB82NJUaRSGbKYAk8XNBnwy8bJIXIUXULFRHk6HNC6LBiSrIk9vnLsHV
   c830KjzrvriDhBPgOpOYfEJgp3L77fRt1P5jjSfmQM5pEog4o/BiBVmGQ
   A==;
X-CSE-ConnectionGUID: HG3/owADTea3S4iPuMXycA==
X-CSE-MsgGUID: TxcyLx92Rqq7+Y+Yfg7/vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="39364463"
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="39364463"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 09:09:31 -0800
X-CSE-ConnectionGUID: dy7a5vIXSP2ysIp3Fpcgcw==
X-CSE-MsgGUID: ICCug2eFTjmbVDo6yM/uVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="141219966"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.109.215]) ([10.125.109.215])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 09:09:31 -0800
Message-ID: <37fec847-47fa-4b8d-9616-14c9c1d55ceb@intel.com>
Date: Mon, 3 Feb 2025 10:09:29 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] acpi/ghes, cper, cxl: Process CXL CPER Protocol
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
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/23/25 1:44 AM, Smita Koralahalli wrote:
> This patchset adds logging support for CXL CPER endpoint and port protocol
> errors.

Hi Ard,
I'd like to apply this series to cxl/next. If the EFI bits look ok to you, can you please ack the relevant patches? Thank you!
 
> 
> The first 3 patches update the existing codebase to support CXL CPER
> Protocol error reporting.
> 
> The last 3 patches introduce recognizing and reporting CXL CPER Protocol
> errors.
> 
> Link to v5:
> https://lore.kernel.org/linux-cxl/20250114120427.149260-1-Smita.KoralahalliChannabasappa@amd.com
> 
> Changes in v5 -> v6:
> [Dave, Jonathan, Ira]: Reviewed-by tags.
> [Dave]: Check for cxlds before assigning fe.
> Merge one of the patches (Port error trace logging) from Terry's Port
> error handling.
> Rename host -> parent.
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
> Smita Koralahalli (6):
>   efi/cper, cxl: Prefix protocol error struct and function names with
>     cxl_
>   efi/cper, cxl: Make definitions and structures global
>   efi/cper, cxl: Remove cper_cxl.h
>   acpi/ghes, cper: Recognize and cache CXL Protocol errors
>   acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors
>   cxl/pci: Add trace logging for CXL PCIe Port RAS errors
> 
>  drivers/acpi/apei/ghes.c        | 103 ++++++++++++++++++++++++++++++++
>  drivers/cxl/core/pci.c          |  62 +++++++++++++++++++
>  drivers/cxl/core/trace.h        |  47 +++++++++++++++
>  drivers/cxl/cxlpci.h            |   9 +++
>  drivers/cxl/pci.c               |  59 +++++++++++++++++-
>  drivers/firmware/efi/cper.c     |   6 +-
>  drivers/firmware/efi/cper_cxl.c |  39 +-----------
>  drivers/firmware/efi/cper_cxl.h |  66 --------------------
>  include/cxl/event.h             | 101 +++++++++++++++++++++++++++++++
>  include/linux/cper.h            |   8 +++
>  10 files changed, 394 insertions(+), 106 deletions(-)
>  delete mode 100644 drivers/firmware/efi/cper_cxl.h
> 


