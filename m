Return-Path: <linux-efi+bounces-2981-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7A4A6015A
	for <lists+linux-efi@lfdr.de>; Thu, 13 Mar 2025 20:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E67F3BDDA5
	for <lists+linux-efi@lfdr.de>; Thu, 13 Mar 2025 19:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5B21EF39C;
	Thu, 13 Mar 2025 19:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJRpfV2e"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36BF5464E;
	Thu, 13 Mar 2025 19:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741894711; cv=none; b=d6wVWPeksUAvCYKuLOhdh8r48gS5AyjfHNCbvfUm9qXLSlDnoxJuKH7GsGzELwbtluCHzC0reBDHrXzz9hS45Xg09VZNPLTlx8pqEEXp7+9emmBNjhaV12ZjbRhTbz6FQAIUj7xxZcphuUmwgodggjhdvTOSzjiEToLTRTSBcT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741894711; c=relaxed/simple;
	bh=V1Ch0wSo81DMawR++dmrxZcbrNPbwcgUzALo7nNs0ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=undq8DRh5Rq8pU6tUMtpApFL6ZYvktnI527pZ+Rlvk97tQS4r3W0IgqWJLQppl0OcvuNm2qw3UTuwyMkZzCbnNEHg85FQuAqvrTolIyh9m+MwcScyvmKny4nASl6hrD/P6t2HyYPBMqRXisVEwUhQEunr/2YUwr+uYo5ERipjAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJRpfV2e; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741894710; x=1773430710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V1Ch0wSo81DMawR++dmrxZcbrNPbwcgUzALo7nNs0ng=;
  b=jJRpfV2eChUEJgZvlE/0WQARZMqoi5qbxeoIU3V+PuCRIap41xe193CF
   z6mIrZee0XzaRZpzmRjr6gKWrBBCJb0SDIZVuaA2+gJETzX8Zq7Z+SUJR
   cK+WKRUcaSLeR9zbAnrlXEh9yx7yRXI/8wLy1s4ELzl4gmu6aUeYA3w8X
   lH8PKFovxHXAzbLFqz3smGW/O24822Vk77Aom0okncCf7wpAzTQsUHIt+
   BvOblqT9a4WVqZ6mSzG5+Tae58BPOVUntIaePddKu00EFVGi8U+mwbXlC
   zytRXJVqYssFal6ZuUYolRTpwu/9dwtB40KwGDekqfEduQh6+xaxDqYLn
   A==;
X-CSE-ConnectionGUID: ZMacXrYzTDyyILW1Z+AbNQ==
X-CSE-MsgGUID: 0u/WqbyASp6bWb7AEGMocA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43237767"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="43237767"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 12:38:29 -0700
X-CSE-ConnectionGUID: AuNVzmnSQ4qYaepR2rbqJA==
X-CSE-MsgGUID: 2FsDA+a8STyEE2KH8ZdO1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="151990008"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 12:38:29 -0700
Date: Thu, 13 Mar 2025 12:38:27 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v8 0/2] acpi/ghes, cper, cxl: Process CXL CPER Protocol
 errors
Message-ID: <Z9M0M4RzHPnwWoTS@agluck-desk3>
References: <20250310223839.31342-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310223839.31342-1-Smita.KoralahalliChannabasappa@amd.com>

On Mon, Mar 10, 2025 at 10:38:37PM +0000, Smita Koralahalli wrote:
> This patchset adds logging support for CXL CPER endpoint and port Protocol
> errors.
> 
> Based on top of cxl-next.

Seems like a a lot of stuff happening in patch 1, but I don't see an
obvious place to split it.

Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony


