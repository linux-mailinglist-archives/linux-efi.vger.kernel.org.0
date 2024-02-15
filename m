Return-Path: <linux-efi+bounces-567-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D042856312
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 13:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DDC3B231DC
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 12:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CBC12BF17;
	Thu, 15 Feb 2024 12:22:35 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1264912BF06;
	Thu, 15 Feb 2024 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999755; cv=none; b=r8ig2cYGTzHEaVCbUoeUMO8AX4bEBe2FQXD1vNF+huyDEQ4mUQrcAtcOVjV36nTuK6mW+hZrHTNzXZ33So5nD7XQxJfncT091LppnlI6YBlMcMyZB/nGiiPU/pH2nxsf1VtYpipkkLZfgD9tiqXEygyKE287YmItwebJqQszuPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999755; c=relaxed/simple;
	bh=iCn0qgq3STK9IqIqXeF3/s1GYp7tkf4kVddq0DXuwjk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IYj0zAJoTUvSepHsN5Vtu3dhD+DWig7pmPDaGg6Op6jUcAdQTiKdp+1cdUCqU0OE30tg4rF+rb0A0rokCeehGjmJSRA35UcXoDnAa4yemg36vpEqnqW/fMuR+JnJY14jLBepuJ4HJHbv5mnrYBHK9FmN2/szwXSz40ljHNjtDi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbDcM4bQkz6J9nb;
	Thu, 15 Feb 2024 20:18:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E940A1400D4;
	Thu, 15 Feb 2024 20:22:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 12:22:29 +0000
Date: Thu, 15 Feb 2024 12:22:28 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v2 4/4] acpi/ghes, cxl/pci: Trace FW-First CXL Protocol
 Errors
Message-ID: <20240215122228.00000405@Huawei.com>
In-Reply-To: <20240109034755.100555-5-Smita.KoralahalliChannabasappa@amd.com>
References: <20240109034755.100555-1-Smita.KoralahalliChannabasappa@amd.com>
	<20240109034755.100555-5-Smita.KoralahalliChannabasappa@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 9 Jan 2024 03:47:55 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
> CPER records. These CPER records obtained from GHES module, will rely on
> a registered callback to be notified to the CXL subsystem in order to be
> processed.
> 
> Call the existing cxl_cper_callback to notify the CXL subsystem on a
> Protocol error.
> 
> The defined trace events cxl_aer_uncorrectable_error and
> cxl_aer_correctable_error currently trace native CXL AER errors. Reuse
> them to trace FW-First Protocol Errors.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Other than the bits of this that will change due to Ira's look good to me.

Jonathan


