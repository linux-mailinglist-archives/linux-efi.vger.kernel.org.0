Return-Path: <linux-efi+bounces-2976-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2F6A5E40A
	for <lists+linux-efi@lfdr.de>; Wed, 12 Mar 2025 20:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FBD87AE07B
	for <lists+linux-efi@lfdr.de>; Wed, 12 Mar 2025 18:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EC42586CC;
	Wed, 12 Mar 2025 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TtdcsGrH"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FA823F388;
	Wed, 12 Mar 2025 19:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741806002; cv=none; b=bsh1RmO+p0EOQxQU3N1WV60AkhyHfqR/Flld0r+7IHDJniFK87AQTdtDe6UL35Ob8r9GvqfIa3tskkAp9c9vbdwPU/vWOnV7K+daKATHw7dw8sMyaoq92CDe4YC0sTatZUvnu5Eap8R+0/l6ljj0UfzviYPlmmLXEg/YaOTcSm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741806002; c=relaxed/simple;
	bh=kGIMlxZvq6PH3ad4OhpiRECFgFh3c214pczSuZX0A4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBnxkn46CvYhlJZsmZvbnG+kipn6bFATIEiGv8HG3iRY0ZhgLVNGlSrdRp8ul9QS0JfQoBCz6lQuguFro4amWU/pdGU6HM9/LGZCs7iQ91ouf3refceeEfq1KZMRLR0H7XqBsJI6N+6y3BvT1w9x8c0kdk8tLPQy0X7B85O7Dmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TtdcsGrH; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741806001; x=1773342001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kGIMlxZvq6PH3ad4OhpiRECFgFh3c214pczSuZX0A4M=;
  b=TtdcsGrHG8PqORjVd/8/pkmewN6ZeitG3XEgqgF+Qi1D+21AvjtcInwJ
   RI9LM/NR+uLZ1qvAS1/1AA0L2vCFGydfTAJCoSn2phcX3vqi0xrS2jmRX
   Q4iP+EnOLBRXtFpQBKro8V8r21oVdrQKNcQLNM/oSsaF8TGNvODSqcnIF
   6HCuV95tjkOhPe1QQtmuq5YQ//QLAdN48S8dBExHgwpsDnebS/3+94H2T
   D9P3bGJJHkBamlGG3D87gIOF9+sStLelquKvGAKQzdCWa4ndhoTyDzQLb
   m7pgdlszZEsXDB2vwSi46WtteXVZX50XpkYfQopom3erQYu4yJE08VyDe
   Q==;
X-CSE-ConnectionGUID: l1RpPqPmTZuKJ0rcQcB6uQ==
X-CSE-MsgGUID: oAEsFaOAQrS8P+13vhhfYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="54272016"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="54272016"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 12:00:00 -0700
X-CSE-ConnectionGUID: DwSZyZZ1Rb29xF6An1cmgw==
X-CSE-MsgGUID: EpbEPYrlROWPSOh8Z46pPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="125797228"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.10])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 11:59:58 -0700
Date: Wed, 12 Mar 2025 11:59:57 -0700
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
Subject: Re: [PATCH v8 2/2] cxl/pci: Add trace logging for CXL PCIe Port RAS
 errors
Message-ID: <Z9HZrXtSEx8wT3Eb@aschofie-mobl2.lan>
References: <20250310223839.31342-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250310223839.31342-3-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310223839.31342-3-Smita.KoralahalliChannabasappa@amd.com>

On Mon, Mar 10, 2025 at 10:38:39PM +0000, Smita Koralahalli wrote:
> The CXL drivers use kernel trace functions for logging endpoint and
> Restricted CXL host (RCH) Downstream Port RAS errors. Similar functionality
> is required for CXL Root Ports, CXL Downstream Switch Ports, and CXL
> Upstream Switch Ports.
> 
> Introduce trace logging functions for both RAS correctable and
> uncorrectable errors specific to CXL PCIe Ports. Use them to trace
> FW-First Protocol errors.
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


