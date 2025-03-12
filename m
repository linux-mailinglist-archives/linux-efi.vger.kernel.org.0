Return-Path: <linux-efi+bounces-2975-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B15A5E406
	for <lists+linux-efi@lfdr.de>; Wed, 12 Mar 2025 19:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24E9176D55
	for <lists+linux-efi@lfdr.de>; Wed, 12 Mar 2025 18:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7507E2417F2;
	Wed, 12 Mar 2025 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KcpDhpxf"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A128258CC4;
	Wed, 12 Mar 2025 18:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741805943; cv=none; b=XATYxDtrYm8AgIZyL5f2JHTVaXyZ/z4/Mc5e9vASN7T06okoBuJfBhusun5VB2OS9gXRKX81OKSn+zP1sIrQUI2s/qxeN6k0yJE9CnYV3FTpvkm8CGwFtacNvlT+oxBz85T9GZ5eWOCowFNb1bLelv2iQH3MrmGOfdr/oiPOyMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741805943; c=relaxed/simple;
	bh=2PhGjCIWYy/NlbwWINkGifXYuBI7hQgpOCZLpdiv+2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfBueQuf+/j6Jb8+XFYqYnpy4ai6j1h8Q/GAzSLdeZ6k+zDFOOY7k8Vnco7fMO5rNtx12DSLW2x8WpvgvK3CuayiTu0psEp1pEbNYKk8TgE0eWnuxMR5paUU8jS+XQ9G7Ctg75r36zlmpM/rjNGj28yc/HI67T/KJ0cCJfqF3ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KcpDhpxf; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741805938; x=1773341938;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2PhGjCIWYy/NlbwWINkGifXYuBI7hQgpOCZLpdiv+2Q=;
  b=KcpDhpxf2AZyCObFPPg60iOP/ZYK7jF3a0GAwssiLSBd9zJX7KSC4STn
   3Z/hvI/ssAqF57NEulHUuTEL4zj23UHcmHTo4+G/Bj0M/ZSSyAFnYxdKk
   zXs/XFvTXZrSijiwk163Auuvpg+l8qQqJ413ca5EXPu0MV7CgyUQGPSMw
   m1hjyYJfu2vr1b2KtpeEENY2S9g3+bQylZxpvOChC1b/8J//6byDMDuFc
   zg7DiCq8rR1joFn6WA+h4OFyRMiMAp8uIQAwFwsbViZ9TYlC6fXAgkJCX
   lmOY/DU2zgzzQ/oIBtt+AYzkcbiy9bRFw+DYBS46XlOgfcJd1s51t1yo6
   g==;
X-CSE-ConnectionGUID: R0Y6LehdT4ulPLlH7C1xSw==
X-CSE-MsgGUID: evHzHz16QZWu8PwicaAeyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42762942"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42762942"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 11:58:56 -0700
X-CSE-ConnectionGUID: rt/mLQJXRnaWfn9VeZYr2Q==
X-CSE-MsgGUID: Q99PyXViQWe5x7VORJVQmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="125790262"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.10])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 11:58:56 -0700
Date: Wed, 12 Mar 2025 11:58:54 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v8 1/2] acpi/ghes, cxl/pci: Process CXL CPER Protocol
 Errors
Message-ID: <Z9HZbh_2f0_vbKhI@aschofie-mobl2.lan>
References: <20250310223839.31342-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250310223839.31342-2-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310223839.31342-2-Smita.KoralahalliChannabasappa@amd.com>

On Mon, Mar 10, 2025 at 10:38:38PM +0000, Smita Koralahalli wrote:
> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
> CPER records. Introduce support for handling and logging CXL Protocol
> errors.
> 
> The defined trace events cxl_aer_uncorrectable_error and
> cxl_aer_correctable_error trace native CXL AER endpoint errors. Reuse them
> to trace FW-First Protocol errors.
> 
> Since the CXL code is required to be called from process context and
> GHES is in interrupt context, use workqueues for processing.
> 
> Similar to CXL CPER event handling, use kfifo to handle errors as it
> simplifies queue processing by providing lock free fifo operations.
> 
> Add the ability for the CXL sub-system to register a workqueue to
> process CXL CPER protocol errors.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip

> 

