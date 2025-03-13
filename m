Return-Path: <linux-efi+bounces-2982-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE3DA601B4
	for <lists+linux-efi@lfdr.de>; Thu, 13 Mar 2025 20:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C808803B4
	for <lists+linux-efi@lfdr.de>; Thu, 13 Mar 2025 19:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7FD1F3FE3;
	Thu, 13 Mar 2025 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ldIsv9ef"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED30EADA;
	Thu, 13 Mar 2025 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741895914; cv=none; b=fCrup6f21AKhkeXcCkaloA6BXno8W3tVqWEq2tEdEIwGEm0tnmwGtMLynNhk6xggS7vrMKnfhMkOBp01ujEzmbDQWCYOIsFmxIeuzKrpSGngUgACQcM6yZVC/Pb5kDV3HH//yisL+qW0gIbXAeIGR5YzP3MKalZVokPU1ytycsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741895914; c=relaxed/simple;
	bh=DYc4V0dV0L0bru9dNz6I4X8FiM0jnOWw5XEeeV3iSLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XbsLy/efNShRs+H/U0y1Rqlll9X4fy+zM6xjcvjraxedtUGI30Gsyj3btDa3SeIdUbvs6MuW5xHdd3NKLHuhN/+4bHIF56Vz/cSBEp6bY/yUJZ9biVJwQqfXHCrxDftns8AV0RKSzvXNULq0thnwv9Ln6hCK4D5lDSZTzCc7Idk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ldIsv9ef; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741895913; x=1773431913;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DYc4V0dV0L0bru9dNz6I4X8FiM0jnOWw5XEeeV3iSLE=;
  b=ldIsv9efbig1QSAjQLjmiXuLs5e3Ho+Ik8mzUvYkRzrVBWZY+U+KmJJ1
   mA1Wo+vRDstLytYsOkOrK9cJwL+LUTvoqZ42JpwH99xxyFDNrqlaxiJXL
   aAplxiA/3qwdNlpQCsaa3MWLasKnGSoZJaSiDU9JCtBQQqn3KANk7IEIe
   uy2+9pWR/FjTCrQQkSsGOTfwlF/Roke3s8INdUs0cUOnKv/EMkPUDztKX
   Nmv+fBepNKFYxXzHdUXuVDuO/c+4ZNHBVjXwWhVz/KffeDsStOf+5d9N2
   5CS1u5QRLAA0v4EnCoxVVMuLybtWPoSqR7BBDSLVNHOrni7T93CBZS5mI
   w==;
X-CSE-ConnectionGUID: v6PtWAHmSDOKkp3yJU19eQ==
X-CSE-MsgGUID: CYSIcQd1T6SlvoT1aQD7rA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="53670841"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="53670841"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 12:58:32 -0700
X-CSE-ConnectionGUID: 7XCm7Sv/RPibPi302npB+Q==
X-CSE-MsgGUID: cE08E2m/SBio8NW1WX0X5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="126235700"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.108.86]) ([10.125.108.86])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 12:58:31 -0700
Message-ID: <ac3720e3-2fa4-4fb5-9344-ae31f1a6643f@intel.com>
Date: Thu, 13 Mar 2025 12:58:30 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] acpi/ghes, cper, cxl: Process CXL CPER Protocol
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
 "Luck, Tony" <tony.luck@intel.com>, Li Ming <ming.li@zohomail.com>
References: <20250310223839.31342-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250310223839.31342-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/10/25 3:38 PM, Smita Koralahalli wrote:
> This patchset adds logging support for CXL CPER endpoint and port Protocol
> errors.
> 
> Based on top of cxl-next.

Applied to cxl/next with change suggested by Ming.


> 
> Link to v7:
> https://lore.kernel.org/linux-cxl/20250226221157.149406-1-Smita.KoralahalliChannabasappa@amd.com
> 
> Changes in v7 -> v8:
> [Yazen]: Moved guard() after !pdev check.
> [Ira]: Included ras.o in test build file.
> [Alison]: Naming consistency: devname -> device, parent -> host.
> 
> Changes in v6 -> v7:
> Reworked to move registration and protocol error handling into a new
> file inside CXL core. (cxl/core/ras.c).
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
> Smita Koralahalli (2):
>   acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors
>   cxl/pci: Add trace logging for CXL PCIe Port RAS errors
> 
>  drivers/acpi/apei/ghes.c  |  49 +++++++++++++++
>  drivers/cxl/core/Makefile |   1 +
>  drivers/cxl/core/core.h   |   3 +
>  drivers/cxl/core/port.c   |   7 +++
>  drivers/cxl/core/ras.c    | 123 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/trace.h  |  47 +++++++++++++++
>  include/cxl/event.h       |  15 +++++
>  tools/testing/cxl/Kbuild  |   1 +
>  8 files changed, 246 insertions(+)
>  create mode 100644 drivers/cxl/core/ras.c
> 


