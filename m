Return-Path: <linux-efi+bounces-2767-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 847B8A2B15C
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2025 19:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B9C163618
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2025 18:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1613C195962;
	Thu,  6 Feb 2025 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MA7ngQ2q"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126B017B50B;
	Thu,  6 Feb 2025 18:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738867087; cv=none; b=Xvc1av1KjJhLfk+EyckrIdpjlBybPirouv0taDsYBU9nGLHBeK+5lWfHBZ3hQ37LquafF0hXSbTLyRBA+vfELl1yffU662M/8/rotc1a7LrZpNEdy1JOv3dwl13VqhdgFc+WdFTOfD614HIDSfQfHHdLJSBvUOkEjx1b2Z5XqBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738867087; c=relaxed/simple;
	bh=Zzxphwb+mkc3jCYIqYGiRvaLTPrUew14PSbPsbPi6WI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6zQL+j226Mp/pUBgGHSgZd9JcxkXlaUMsb7ryd+bJQejCFydf+jNEkMhZUjJEWxj4TE3DK71BUdutSBHzeEGxN9OimUcXc4Xt8sjHMlB0QWqeCiZodBWcCOTUbYXU7zUjG9rIXCHUzk2lFHs8R8wldcwlBBSjYrq75hTr2UBJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MA7ngQ2q; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738867085; x=1770403085;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zzxphwb+mkc3jCYIqYGiRvaLTPrUew14PSbPsbPi6WI=;
  b=MA7ngQ2qXGJzvraYGmFhlrsBf0i9bNdj8C+UlvbTdsvjWZyH1GqmYPyW
   wjwY4VOUHQqN9vLeNoD/EqZ+w/PhdS/bBcjO7Q5u2/gegFTKc+k1qbg+q
   OFzC+wIBePdv18be3IzTnnjHP4lDG9/pBagxYDdHpep7KntLGtf3XDW8P
   xLNso9uhH6HvopPAaKkynuYJOiJYUW7bMU91HZ5TNC0i5Dj6/WsAeVAHS
   7zJCI2ftRMPdhN+lRI598/2/F38tl5+EbgD0kcCfoCcCNKgjLJuyzmxxN
   oVVHg7InadpRNR6Pg0Y9bHLv0qvbbOCvCIzq+vHCOnTLYJMnt30r8bW84
   Q==;
X-CSE-ConnectionGUID: Bi6289HgRKiOXRHJ9aJV5w==
X-CSE-MsgGUID: 1T+8cj+oQAq8NsjcBfSMiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43250242"
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="43250242"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 10:38:05 -0800
X-CSE-ConnectionGUID: 1iq3TuweRCynJm18yGqK0A==
X-CSE-MsgGUID: FYohjPr9QViutmATWg+kSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111726704"
Received: from kcaccard-desk.amr.corp.intel.com (HELO [10.125.110.242]) ([10.125.110.242])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 10:38:04 -0800
Message-ID: <f55263fe-b555-4dc3-b2a5-dc3db60bfbe6@intel.com>
Date: Thu, 6 Feb 2025 11:38:02 -0700
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
 Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>,
 "Luck, Tony" <tony.luck@intel.com>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/23/25 1:44 AM, Smita Koralahalli wrote:
> This patchset adds logging support for CXL CPER endpoint and port protocol
> errors.
> 
> The first 3 patches update the existing codebase to support CXL CPER
> Protocol error reporting.
> 
> The last 3 patches introduce recognizing and reporting CXL CPER Protocol
> errors.

Patches 1-4 applied to cxl-next. I fixed up Gregory's review tag. :)
Patches 5 and 6 needs to address comments raised by Dan.

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


