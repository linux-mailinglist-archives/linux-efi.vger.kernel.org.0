Return-Path: <linux-efi+bounces-2213-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 758359D9AA9
	for <lists+linux-efi@lfdr.de>; Tue, 26 Nov 2024 16:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF35164CE2
	for <lists+linux-efi@lfdr.de>; Tue, 26 Nov 2024 15:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08921D63E2;
	Tue, 26 Nov 2024 15:51:18 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85DA1D63F1;
	Tue, 26 Nov 2024 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636278; cv=none; b=WLtDsQtjKIh7SEm50op8o2zXndsv/V97KYjMsU8Jip2GSn7KJuU+EN+5Kgas/tE19ZhPP9wFHMew5+r5WksaCQEJGGK3WUVsImpp2qb2oYDoDSTT4cwHWmHjSAe+yjKTnvlUF6GzRIYYIyOU4MdLjp+kV+NdH0khgENvKElX2wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636278; c=relaxed/simple;
	bh=pbUmUU0R09Fgsr4P8mMC+kzcClsJB3tYXl4UJuJ9fvk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=btjQH4R4XPg2bPwxLrhLDXxPQ72EvI3JStIzAuOq4s4CNgGaXwuGhOHQoBXFOaMCBNY2qA8hNV/Bdr7B66TJzPToraocEkYCcgzFtEfWV98q87rj+fesyJjUt4f6Ysl4u35aRUHEIeF/E9mbsrae8NQ7vPWRtArZ93SE21FgzB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XyRnL6Q5Lz6K9MV;
	Tue, 26 Nov 2024 23:48:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5085C1400CB;
	Tue, 26 Nov 2024 23:51:13 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 26 Nov
 2024 16:51:12 +0100
Date: Tue, 26 Nov 2024 15:51:11 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, "Terry
 Bowman" <terry.bowman@amd.com>
Subject: Re: [PATCH v3 3/7] efi/cper, cxl: Remove cper_cxl.h
Message-ID: <20241126155111.00002d79@huawei.com>
In-Reply-To: <20241119003915.174386-4-Smita.KoralahalliChannabasappa@amd.com>
References: <20241119003915.174386-1-Smita.KoralahalliChannabasappa@amd.com>
	<20241119003915.174386-4-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 19 Nov 2024 00:39:11 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> Move the declaration of cxl_cper_print_prot_err() to include/linux/cper.h
> to avoid maintaining a separate header file just for this function
> declaration. Remove drivers/firmware/efi/cper_cxl.h as its contents have
> been reorganized.
> 
> Eliminate its corresponding #include directives from source files that
> previously included it, since the header file has been removed.

You lost me on this one.  Looks like only place these existed was the now
empty header?  I'd not mention that as it's just bit confusing.


> 
> No functional changes.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
> deleted file mode 100644
> index 5ce1401ee17a..000000000000
> --- a/drivers/firmware/efi/cper_cxl.h
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * UEFI Common Platform Error Record (CPER) support for CXL Section.
> - *
> - * Copyright (C) 2022 Advanced Micro Devices, Inc.
> - *
> - * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> - */
> -
> -#ifndef LINUX_CPER_CXL_H
> -#define LINUX_CPER_CXL_H
> -
> -void cxl_cper_print_prot_err(const char *pfx,
> -			     const struct cxl_cper_sec_prot_err *prot_err);
> -
> -#endif //__CPER_CXL_

