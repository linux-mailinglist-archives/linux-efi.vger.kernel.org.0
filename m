Return-Path: <linux-efi+bounces-2741-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6908AA2685F
	for <lists+linux-efi@lfdr.de>; Tue,  4 Feb 2025 01:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0876F18830A2
	for <lists+linux-efi@lfdr.de>; Tue,  4 Feb 2025 00:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817971372;
	Tue,  4 Feb 2025 00:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c37DZ0Hz"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D888210E4;
	Tue,  4 Feb 2025 00:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738627947; cv=none; b=EPjcvIL4JYgyuCRTXodKaqGOKd/5j4ug2vW87ss9hBcoA9jgg+j4CyzkI4HttXxFq9JUAhZZXO46idDgitwnWuJ97hj1MppEcnDZqBEYXj1DyXJNoOVg32rMeC/D4VG7Yr2vHz1XAZWqUXgX2GGYOjwYMT9GTLcTjzWcEZVMjmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738627947; c=relaxed/simple;
	bh=w8BWhCVM37eKCZvKG1xn0a8IrzGbnKP+472kUAwu/ps=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sM7nuhyGobS2blPIPg04XQ/Rx/RvSIrXRlGrhOUQjQKUrhUZas30B9A2vej+Ump+rcd+KtYK8Jwtqwa+ZiBY2GrUjIn/eHZ3B8SiNiyiHuFfCqvGM497R6Tpl4kIBAsaSFhwgI+JHRBwE2CMLkDQH/NjX8DI1QWshVSNa6TsLbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c37DZ0Hz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2162c0f6a39so105501205ad.0;
        Mon, 03 Feb 2025 16:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738627945; x=1739232745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EpFW0s2jcmN4BByOteWpkZEKGA4PjQRFuWzMWB0DUB4=;
        b=c37DZ0HzO7bHuKNdqbgL/SZDewlJKhsRx4/F0uj2QMUVqfKchnbCGW3UbX9r8uNswL
         o8wYp2PVWJRvNf75bmIxQ1DCHRcT92ch3sKFeh33nDKF9iB4Wq3EnmRH0f2ze9LPqo+P
         xB2pfuFXR6oBDRL2LvZ3kpAXtlrVqfwhSW0lH472rvH2lXFRApTzhXtNlvkPj0cNsg+O
         4nP2JYVBqk+buz+4SA4P1wmJdizxPTc4HPfgJEOnv+Ep1njVTxAmG+ldvy5I2Byc5gBc
         wXeTbgXJjgGLZhkZ6N0qD1ncfRK2mRGyBG1gdFBgLpKobd2/hhAWo6iAymRN4EEwsMBd
         9YPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738627945; x=1739232745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpFW0s2jcmN4BByOteWpkZEKGA4PjQRFuWzMWB0DUB4=;
        b=bNmVIgQh8E3luUbks87Z/HTFHRW3iaieSeeuQWTqU+o3fpZtukk69ECMmPnrlL4tV0
         +9pMZ8AFAutAKU83ySLvScR8PRA7OS7lbhOLmiUtm8fI/antNChe8HlWO5pwzbbKPWPm
         qIZ2o3y60X5D1ji7c5NdhN0R9v5WFVtnh2cEKFlK4eaVsDBxj1ZN3wMl5fv1eznff0kb
         hiYC7eug6ifBpVylCogmOI94sLvZh37cyp6qPcDioV+5HgqAmtBL+AqMHWSMzf8yrWJD
         ETY4o5nkMU7yM52gVDiyGdJRv3Zylgq9Zv44vBcxVU4DbysD5RRiO4N6og9MCinuFqVY
         kd2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUot4ZKu/J8u1KYCXWz3qpOpw/lWOGug5lIb0M57e5eym3GUuClRYusu4ExSSUtH2ZBrIfia7Ex1ow=@vger.kernel.org, AJvYcCVeifj27hljj4a2MhoPtlZJOqBzv4XiR0H7WZpcPNToHUsY41FWfJLe03KuZHc42fsaVOaOAFSl3mvRllhx@vger.kernel.org
X-Gm-Message-State: AOJu0YwUg/E6tCyC1FZlzGItzt+18e0gKVCVp5VBuLvae353aTP67kxN
	rJj02ndmxsjNV1/PINsoxAKSiLYOQtTj12CWOLEqWYft8t2Nea7i
X-Gm-Gg: ASbGncsta0OFjV5aDvMSunuBRKotagb/GGsc4YKbm/pGddbOsxSC8UWvW09OwMhE4m1
	OfCkcdhsxxO1jzZvISge5N5++8oenYgZuvdQuwp7jExBoe/1E4aswfYuzjuxmN423NfjJgVyBd5
	B1CvPcqJzjKBBinrqM9uA4BeElIzApxYGHwXyQUWgh++emy4lBp2NFV/yRUwEwbtTUggc6x2UjA
	8gBb8XAJL0jpTMYLxmEBCeCdE/TgMnSw1kNdpOUrqhy5QANj+hsofJBkt5i8+1GxBx+3w4SSiiK
	THI=
X-Google-Smtp-Source: AGHT+IGYBTnV99auHRWhDyAaTEdApH6wGNb1OoGu1AOpBuwm+RfjvDxltfsqZJVAAGIdtD6GoJ/28Q==
X-Received: by 2002:a05:6a20:7350:b0:1e1:ffec:b1a9 with SMTP id adf61e73a8af0-1edd765e63amr2504431637.3.1738627944779;
        Mon, 03 Feb 2025 16:12:24 -0800 (PST)
Received: from fan ([2601:642:4c00:5ce4:43f:54b:5b70:652e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acebe856951sm8501414a12.34.2025.02.03.16.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 16:12:24 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 3 Feb 2025 16:12:21 -0800
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
Subject: Re: [PATCH v6 1/6] efi/cper, cxl: Prefix protocol error struct and
 function names with cxl_
Message-ID: <Z6FbZRp7nJDlcpmZ@fan>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-2-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123084421.127697-2-Smita.KoralahalliChannabasappa@amd.com>

On Thu, Jan 23, 2025 at 08:44:16AM +0000, Smita Koralahalli wrote:
> Rename the protocol error struct from struct cper_sec_prot_err to
> struct cxl_cper_sec_prot_err and cper_print_prot_err() to
> cxl_cper_print_prot_err() to maintain naming consistency. No
> functional changes.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  drivers/firmware/efi/cper.c     | 4 ++--
>  drivers/firmware/efi/cper_cxl.c | 3 ++-
>  drivers/firmware/efi/cper_cxl.h | 5 +++--
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index b69e68ef3f02..8e5762f7ef2e 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -624,11 +624,11 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
>  		else
>  			goto err_section_too_small;
>  	} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
> -		struct cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
> +		struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
>  
>  		printk("%ssection_type: CXL Protocol Error\n", newpfx);
>  		if (gdata->error_data_length >= sizeof(*prot_err))
> -			cper_print_prot_err(newpfx, prot_err);
> +			cxl_cper_print_prot_err(newpfx, prot_err);
>  		else
>  			goto err_section_too_small;
>  	} else {
> diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
> index a55771b99a97..cbaabcb7382d 100644
> --- a/drivers/firmware/efi/cper_cxl.c
> +++ b/drivers/firmware/efi/cper_cxl.c
> @@ -55,7 +55,8 @@ enum {
>  	USP,	/* CXL Upstream Switch Port */
>  };
>  
> -void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err)
> +void cxl_cper_print_prot_err(const char *pfx,
> +			     const struct cxl_cper_sec_prot_err *prot_err)
>  {
>  	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_TYPE)
>  		pr_info("%s agent_type: %d, %s\n", pfx, prot_err->agent_type,
> diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
> index 86bfcf7909ec..0e3ab0ba17c3 100644
> --- a/drivers/firmware/efi/cper_cxl.h
> +++ b/drivers/firmware/efi/cper_cxl.h
> @@ -18,7 +18,7 @@
>  #pragma pack(1)
>  
>  /* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
> -struct cper_sec_prot_err {
> +struct cxl_cper_sec_prot_err {
>  	u64 valid_bits;
>  	u8 agent_type;
>  	u8 reserved[7];
> @@ -61,6 +61,7 @@ struct cper_sec_prot_err {
>  
>  #pragma pack()
>  
> -void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err);
> +void cxl_cper_print_prot_err(const char *pfx,
> +			     const struct cxl_cper_sec_prot_err *prot_err);
>  
>  #endif //__CPER_CXL_
> -- 
> 2.17.1
> 

-- 
Fan Ni

