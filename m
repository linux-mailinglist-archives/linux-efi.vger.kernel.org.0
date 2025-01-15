Return-Path: <linux-efi+bounces-2633-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172ACA124B6
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2025 14:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC65B3A1C41
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2025 13:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E469E2416B4;
	Wed, 15 Jan 2025 13:29:46 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5141F9A81;
	Wed, 15 Jan 2025 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736947786; cv=none; b=gnVtjJlhHFLRrFBx5e8VcN3zCOG5F/hJdu9HKGi+t1Zuixc1nEojQqj9VeDW1bMoc+jJ4tWR+IY6QN8cgHHiJ4Pg2K0e0T3iRbb+y/ojgW0o4g3/+1Zmpa1/YgQFFSsY7Ntio8zQVo8M4dwlcoaAXZzSaaZ6eI4JhCFYgMPJ1fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736947786; c=relaxed/simple;
	bh=ohisbrkYuCSLfIR38hq6qfpyfQ4uU2LOMB8NfJOeST8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trMD7fUvMIQ9ox9Z/nwcPa6RaINwi1+6FFfllHzDnJgD2mQQupE2Nztrnc7IlbqEUCD3CyntDaZqS5hxBoZ8USxbu7x8fQgTPufHErW1WWtuRQBQo2R1seNZyTrXZz9csKD2gMAKJTyVX5XK72i9uub6xPePi/pk8dRiy+KVB5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YY6Hv4R2Bz6LD45;
	Wed, 15 Jan 2025 21:27:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BEFBF1400F4;
	Wed, 15 Jan 2025 21:29:40 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 15 Jan
 2025 14:29:40 +0100
Date: Wed, 15 Jan 2025 13:29:39 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, "Terry
 Bowman" <terry.bowman@amd.com>
Subject: Re: [PATCH v5 5/5] acpi/ghes, cxl/pci: Process CXL CPER Protocol
 Errors
Message-ID: <20250115132939.00003d58@huawei.com>
In-Reply-To: <20250114120427.149260-6-Smita.KoralahalliChannabasappa@amd.com>
References: <20250114120427.149260-1-Smita.KoralahalliChannabasappa@amd.com>
	<20250114120427.149260-6-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 14 Jan 2025 12:04:27 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
> CPER records. Introduce support for handling and logging CXL Protocol
> errors.
> 
> The defined trace events cxl_aer_uncorrectable_error and
> cxl_aer_correctable_error trace native CXL AER endpoint errors, while
> cxl_cper_trace_corr_prot_err and cxl_cper_trace_uncorr_prot_err
> trace native CXL AER port errors. Reuse both sets to trace FW-First
> protocol errors.
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

