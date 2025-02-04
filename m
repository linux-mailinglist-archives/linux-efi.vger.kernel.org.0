Return-Path: <linux-efi+bounces-2743-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62FAA2686D
	for <lists+linux-efi@lfdr.de>; Tue,  4 Feb 2025 01:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCDD3A4ACC
	for <lists+linux-efi@lfdr.de>; Tue,  4 Feb 2025 00:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359BF5228;
	Tue,  4 Feb 2025 00:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YC2URhCJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A065684;
	Tue,  4 Feb 2025 00:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738628420; cv=none; b=QUPhcZ81bo/kpXnJUhva0m2fsEpi93n+85yk1qaIIaX0ewqAbVqak3sDHUN1pVMn7xME84g8Ud36w+nHqLXvNCel4ezZICl4IjVQdhC2LL8vic3/Ynfe/tsT6Znkqmel5hfnAIrN3ynmAWJeKnaWY45EQeoZhKS2LT9XeDQo7nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738628420; c=relaxed/simple;
	bh=Q0/e1ZklG8Trg/2xC121npdgO6BVnFC0ZVpEG3nM9z8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjrXZl+sn8fw7+EkGzTZRFanQi0xksjnBbem6/PPB6hBkO2ucEkuIsxk0mAWdN5HYKjOadW07698wQsI+bEuNaLaVLpCwzXaZlDgty/6eLjx7mvlR/rEOkQtRpwPw0PN2HvDOvdbMkFTcg95HvDwSrPks1QK2S3zOUfXVffdnvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YC2URhCJ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f9bed1f521so329835a91.3;
        Mon, 03 Feb 2025 16:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738628418; x=1739233218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=odEKJTgqC2uFQrsEp2G4HNmRV6bgm+8RLC9YpxmWEIY=;
        b=YC2URhCJI+7Ek4Kd3aEk69wx+zhpCJAg9MCFDSwjEYiQKwWSb/rjaxie7r40Vor6oQ
         qcnu4ROyPZb5LDI1qTmqBBepCLYa1oswep0FbWejEzFCg/asrY1Vp64eyq03Kcjde5OL
         5QeRBw4Jqjs8P8Ke8xz4Rt/vUW8Sul4somXvEMKEXbXno3r8CFBGKCxQNZ3rErGlInTD
         SCuxZxevzzPJd/JbhqrTfQXhG1fmtPu6Nq2lCJtdVGgOw/UQxfTJLZ3mxGjPl6XN+V6A
         n2ybPFQklA8fbJ+kAdMXtNkGDHroaDpTDa/fEm3rmxl+GeWUFKFHIwF2Cz3PIhUEkpvb
         fRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738628418; x=1739233218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odEKJTgqC2uFQrsEp2G4HNmRV6bgm+8RLC9YpxmWEIY=;
        b=IBDZvj46ZZAWzCwyfSbb7RrTGwkD6i6mvNhBCPwQ6EBcjDRjGU6T78FJlB+RPB61Z7
         8AU+Phvf+8k3HbjyZ9MYOgCelAX8skWJk5ui9czzh5ZUH8wgDuDxne67HzKS5SfZjk9l
         HAHGNguDaI2IFyBGOmkRVJCwio2VEI+jtimxsgq5f9sS4oQFHooYlgQbXc7lzz6EpG3R
         uWDaP2yJI9SWOEKor5EcW2x8UZtTPp3vXV/UVmRgoBrhk3rD0ZJXaO0qBvRqJBEFGlEI
         enS77N77B8vhRibfhwqoA8ZPv7fU6Rc3jDs0HNNackcaXjmZGVPXHo1H5lQMj9OfYtsh
         iWgA==
X-Forwarded-Encrypted: i=1; AJvYcCWsSKG3cLevxQXBr3GMDQG5gKsGEDAxW31q5KmV63uF37VNEOvYinAMXhYMhxTV0HHnyo15xE/kg0QtDxoo@vger.kernel.org, AJvYcCX/S0E6aHsIDb/ysZ+UT/U5nFRb5hlGnRLqF3utz5GUZEd9i1UXvRdCvQ5SSHWf2dsU9SZfwpyWubg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZcF4iIQmn5D1W8LyD0eV129ic/TGyV/zB4cFdTSExBMpSF52j
	M8sRvtZuBEbJ7zfqfYd1us+5lcL8fLquTUuKTbIMS9HH2iLrJNBH
X-Gm-Gg: ASbGncudgIFTIFHx3AoTXpH/hksQsPTTdmn4u+5hICuGMLW5xBpX0G37jhbc6AczqFl
	jeZuYB1pj3ZSyHBPREw1q7CAvf24VTLj9VF4menY8BiTDCtSNGTPMEOUn7QqvS3jqbLIhF7VT7z
	mm5cTKm1u5S6VQC7LIdrPwyDsjeqyvr5QKy348iYbgiqHvo8doVcyFhjollAbNJSnu5PdND32M+
	LQvkyEfIv5mdnXZ9x+HrKcE38vG9CbwGDb3cjZBD4qMD6Sg205GWUT2joyEBiXLDwDIfYg345rq
	FNY=
X-Google-Smtp-Source: AGHT+IG71nKM/QN7fc02bYR+OhLF/fdwYiroEm3IGqQ+KzXrPPH1p1qBGDJUXIb5FvBgoQNfGPcs+A==
X-Received: by 2002:a17:90b:5387:b0:2ee:5111:a54b with SMTP id 98e67ed59e1d1-2f83ac8ad6emr32693378a91.31.1738628417416;
        Mon, 03 Feb 2025 16:20:17 -0800 (PST)
Received: from fan ([2601:642:4c00:5ce4:43f:54b:5b70:652e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f848aef018sm10773640a91.49.2025.02.03.16.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 16:20:16 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 3 Feb 2025 16:20:14 -0800
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
Subject: Re: [PATCH v6 3/6] efi/cper, cxl: Remove cper_cxl.h
Message-ID: <Z6FdPmM_mwUjBE1G@fan>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-4-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123084421.127697-4-Smita.KoralahalliChannabasappa@amd.com>

On Thu, Jan 23, 2025 at 08:44:18AM +0000, Smita Koralahalli wrote:
> Move the declaration of cxl_cper_print_prot_err() to include/linux/cper.h
> to avoid maintaining a separate header file just for this function
> declaration. Remove drivers/firmware/efi/cper_cxl.h as its contents have
> been reorganized.
> 
> No functional changes.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  drivers/firmware/efi/cper.c     |  1 -
>  drivers/firmware/efi/cper_cxl.c |  1 -
>  drivers/firmware/efi/cper_cxl.h | 16 ----------------
>  include/linux/cper.h            |  4 ++++
>  4 files changed, 4 insertions(+), 18 deletions(-)
>  delete mode 100644 drivers/firmware/efi/cper_cxl.h
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index ae1953e2b214..928409199a1a 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -25,7 +25,6 @@
>  #include <acpi/ghes.h>
>  #include <ras/ras_event.h>
>  #include <cxl/event.h>
> -#include "cper_cxl.h"
>  
>  /*
>   * CPER record ID need to be unique even after reboot, because record
> diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
> index 64c0dd27be6e..8a7667faf953 100644
> --- a/drivers/firmware/efi/cper_cxl.c
> +++ b/drivers/firmware/efi/cper_cxl.c
> @@ -9,7 +9,6 @@
>  
>  #include <linux/cper.h>
>  #include <cxl/event.h>
> -#include "cper_cxl.h"
>  
>  static const char * const prot_err_agent_type_strs[] = {
>  	"Restricted CXL Device",
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
> diff --git a/include/linux/cper.h b/include/linux/cper.h
> index 5c6d4d5b9975..0ed60a91eca9 100644
> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -605,4 +605,8 @@ void cper_estatus_print(const char *pfx,
>  int cper_estatus_check_header(const struct acpi_hest_generic_status *estatus);
>  int cper_estatus_check(const struct acpi_hest_generic_status *estatus);
>  
> +struct cxl_cper_sec_prot_err;
> +void cxl_cper_print_prot_err(const char *pfx,
> +			     const struct cxl_cper_sec_prot_err *prot_err);
> +
>  #endif
> -- 
> 2.17.1
> 

-- 
Fan Ni

