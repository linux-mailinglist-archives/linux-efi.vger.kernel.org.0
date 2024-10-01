Return-Path: <linux-efi+bounces-1870-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 052F598C4B7
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2024 19:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804F71F256AE
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2024 17:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E7F1CBEAA;
	Tue,  1 Oct 2024 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeRbtqoY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E8A1CB312;
	Tue,  1 Oct 2024 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727804509; cv=none; b=cnfO/tNfuBShLgNIgM8BCstTAK/geqtwbIvVAHEch1C30YCSp3dmXF6peHUphWt/6HDRkBh0nmwIcswEnI3efDyo1p6lM7TJVgDAKlhc/sP+96b3bPJgEzcw0n6dr3ThlfGsq3meNdx74o4bQvziMQHtZS2saZ3vqauVn6P/sJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727804509; c=relaxed/simple;
	bh=LOC0bFakV8X8LMSei2yZtBKCG9MitAs/kdj4g3baMsY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0HAcC6021D8qo6BGo2PUou5BMVtrQO1KVmwDalugMfWzN8Si+/CKWUIm7gxjkz5Hpg8cIjBZqQCOgPP22jLZqTpZTqfyeOhessBBhqrgKcT2W7PnbLq3ek+T7hUMFPH3PFLS3Txm0z0k7lc24CZWrsJep8i3wenSvLrGgJHL9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeRbtqoY; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e0894f1b14so4374953a91.1;
        Tue, 01 Oct 2024 10:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727804507; x=1728409307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1l+2UE4lLIqZawFA+83hjv4rfdjxJdPZSh1jfmLlOxo=;
        b=UeRbtqoYSij86qekgdACJU4Iw2a8zGc/8PGD1Nn5JZ5xrD6OR7tVPBv/cryFLQ3OIQ
         +unrjvSqfOIFPm0vd5WI6NOTxY0jw7DyG83cfJD1eDbv4QDeYPyrSy5bV+C3SF9//suD
         X0HIX3UFxYy7/ws7k2XV35O5CJn8SP6H4Cn6FDk5SimmZNZNV1wne7poHRTPrXIEhC4/
         K9eGR45+UP1S0nETqGcgH5OcipCwwVeekbYpBr2ANONG9N0YazMBQdlT52yJi43I0V4h
         HX09/0hshdEbEChAP2LhCBZEYY86P6ixByWrSsQWj/Wgyj8ifysA8LXojtGhV3pEBoy6
         ojuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727804507; x=1728409307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1l+2UE4lLIqZawFA+83hjv4rfdjxJdPZSh1jfmLlOxo=;
        b=AkIqRccxkBd2IhvF4J7h9354jxWXTo2TVbGT/NuZxHC59aDMW34nfUrZfSfGXTeLeP
         acc+QPBXmJ++/8V74tWctm4rBYu6M1zrwZdXf06f0QZX5rmB8XFO1O4ObFklxWqdhjiD
         5SaSvuQl8G9N+wDkAI2iPDmG5QZnxJJJgkMRopQD88H0omr3OqExzV5FCCDp1p+LaGuK
         E+XabaiTgduRGX83T9UfRy8Zo3nDQppmrCJjVGZ8ZChm34Sc3UYYbrQBsNr3CO60PcN5
         Rwwq5yFB8Hs686NM9/fhRpL9etZRkzCQ5DZ+S4FmDm/I68aZ5upvDCOmrRBz46hhxSol
         iNKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKZGwkqdooXylr93EJV9coT25sjop4Gg6+kxCcrJsByjN6iSUq00LPCChDIunPe+n++V8tyyQ6CG0=@vger.kernel.org, AJvYcCV+6QXOiwakkfcJLYRgc9UsJCldnLM8PP93PEynCeY1meJ0Y5NFiJf8own1+FUCf7m7IGk4rT37m9u/XoGW@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx3Gj4v3EloTmQVxLhcAbVSVMSBluMsWj8qzcioNio5zc+pqVp
	+1km0335p5DPMDxYCDy02BnT9bDaevK2uPJoOK0JFlngJfKfT3Bq
X-Google-Smtp-Source: AGHT+IGOkQ9PzM4pulpEZePjxRxN82y8aoFWPRcbE1/tcaVtRNuCyOUYItKeWCosIlBw0FfypZBj6Q==
X-Received: by 2002:a17:90b:4a92:b0:2d3:cf20:80bd with SMTP id 98e67ed59e1d1-2e1846bea1bmr568466a91.17.1727804506671;
        Tue, 01 Oct 2024 10:41:46 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:7dd:d82b:9686:b02a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c7729fsm10611216a91.22.2024.10.01.10.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 10:41:46 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 1 Oct 2024 10:41:30 -0700
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Bowman Terry <terry.bowman@amd.com>
Subject: Re: [PATCH v2 3/4] acpi/ghes, efi/cper: Recognize and process CXL
 Protocol Errors.
Message-ID: <Zvw0SnS40Rf_jWbB@fan>
References: <20241001005234.61409-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241001005234.61409-4-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001005234.61409-4-Smita.KoralahalliChannabasappa@amd.com>

On Tue, Oct 01, 2024 at 12:52:33AM +0000, Smita Koralahalli wrote:
> UEFI v2.10 section N.2.13 defines a CPER record for CXL Protocol errors.
> 
> Add GHES support to detect CXL CPER Protocol Error Record and Cache Error
> Severity, Device ID, Device Serial number and CXL RAS capability struct in
> struct cxl_cper_prot_err. Include this struct as a member of struct
> cxl_cper_work_data.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
> v2:
> 	Defined array of structures for Device ID and Serial number
> 	comparison.
> 	p_err -> rec/p_rec.
> ---
>  drivers/acpi/apei/ghes.c        |  10 +++
>  drivers/firmware/efi/cper_cxl.c | 115 ++++++++++++++++++++++++++++++++
>  include/cxl/event.h             |  26 ++++++++
>  3 files changed, 151 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index ada93cfde9ba..9dcf0f78458f 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -717,6 +717,14 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
>  	schedule_work(cxl_cper_work);
>  }
>  
> +static void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
> +{
> +	struct cxl_cper_work_data wd;
> +
> +	if (cxl_cper_handle_prot_err_info(gdata, &wd.p_rec))
> +		return;
> +}

Why we need a if here? It seems the function will return anyway.

Fan
> +
>  int cxl_cper_register_work(struct work_struct *work)
>  {
>  	if (cxl_cper_work)
> @@ -791,6 +799,8 @@ static bool ghes_do_proc(struct ghes *ghes,
>  			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
>  
>  			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
> +		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
> +			cxl_cper_handle_prot_err(gdata);
>  		} else {
>  			void *err = acpi_hest_get_payload(gdata);
>  
> diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
> index 4fd8d783993e..08da7764c066 100644
> --- a/drivers/firmware/efi/cper_cxl.c
> +++ b/drivers/firmware/efi/cper_cxl.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/cper.h>
> +#include <acpi/ghes.h>
>  #include "cper_cxl.h"
>  
>  #define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
> @@ -44,6 +45,66 @@ enum {
>  	USP,	/* CXL Upstream Switch Port */
>  };
>  
> +struct agent_info {
> +	const char *string;
> +	bool req_sn;
> +	bool req_sbdf;
> +};
> +
> +static const struct agent_info agent_info[] = {
> +	[RCD] = {
> +		.string = "Restricted CXL Device",
> +		.req_sbdf = true,
> +		.req_sn = true,
> +	},
> +	[RCH_DP] = {
> +		.string = "Restricted CXL Host Downstream Port",
> +		.req_sbdf = false,
> +		.req_sn = false,
> +	},
> +	[DEVICE] = {
> +		.string = "CXL Device",
> +		.req_sbdf = true,
> +		.req_sn = true,
> +	},
> +	[LD] = {
> +		.string = "CXL Logical Device",
> +		.req_sbdf = true,
> +		.req_sn = true,
> +	},
> +	[FMLD] = {
> +		.string = "CXL Fabric Manager managed Logical Device",
> +		.req_sbdf = true,
> +		.req_sn = true,
> +	},
> +	[RP] = {
> +		.string = "CXL Root Port",
> +		.req_sbdf = true,
> +		.req_sn = false,
> +	},
> +	[DSP] = {
> +		.string = "CXL Downstream Switch Port",
> +		.req_sbdf = true,
> +		.req_sn = false,
> +	},
> +	[USP] = {
> +		.string = "CXL Upstream Switch Port",
> +		.req_sbdf = true,
> +		.req_sn = false,
> +	},
> +};
> +
> +static enum cxl_aer_err_type cper_severity_cxl_aer(int cper_severity)
> +{
> +	switch (cper_severity) {
> +	case CPER_SEV_RECOVERABLE:
> +	case CPER_SEV_FATAL:
> +		return CXL_AER_UNCORRECTABLE;
> +	default:
> +		return CXL_AER_CORRECTABLE;
> +	}
> +}
> +
>  void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err)
>  {
>  	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_TYPE)
> @@ -176,3 +237,57 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
>  			       sizeof(cxl_ras->header_log), 0);
>  	}
>  }
> +
> +int cxl_cper_handle_prot_err_info(struct acpi_hest_generic_data *gdata,
> +				  struct cxl_cper_prot_err *rec)
> +{
> +	struct cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
> +	u8 *dvsec_start, *cap_start;
> +
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_DEVICE_ID)) {
> +		pr_err(FW_WARN "No Device ID\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * The device ID or agent address is required for CXL RCD, CXL
> +	 * SLD, CXL LD, CXL Fabric Manager Managed LD, CXL Root Port,
> +	 * CXL Downstream Switch Port and CXL Upstream Switch Port.
> +	 */
> +	if (!(agent_info[prot_err->agent_type].req_sbdf)) {
> +		pr_err(FW_WARN "Invalid agent type\n");
> +		return -EINVAL;
> +	}
> +
> +	rec->segment = prot_err->agent_addr.segment;
> +	rec->bus = prot_err->agent_addr.bus;
> +	rec->device = prot_err->agent_addr.device;
> +	rec->function = prot_err->agent_addr.function;
> +
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
> +		pr_err(FW_WARN "Invalid Protocol Error log\n");
> +		return -EINVAL;
> +	}
> +
> +	dvsec_start = (u8 *)(prot_err + 1);
> +	cap_start = dvsec_start + prot_err->dvsec_len;
> +	rec->cxl_ras = *(struct cxl_ras_capability_regs *)cap_start;
> +
> +	/*
> +	 * Set device serial number unconditionally.
> +	 *
> +	 * Print a warning message if it is not valid. The device serial
> +	 * number is required for CXL RCD, CXL SLD, CXL LD and CXL Fabric
> +	 * Manager Managed LD.
> +	 */
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER) ||
> +	    !(agent_info[prot_err->agent_type].req_sn))
> +		pr_warn(FW_WARN "No Device Serial number\n");
> +
> +	rec->lower_dw = prot_err->dev_serial_num.lower_dw;
> +	rec->upper_dw = prot_err->dev_serial_num.upper_dw;
> +
> +	rec->severity = cper_severity_cxl_aer(gdata->error_severity);
> +
> +	return 0;
> +}
> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index 57b4630568f6..5b316150556a 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -158,11 +158,37 @@ struct cxl_ras_capability_regs {
>  	u32 header_log[16];
>  };
>  
> +enum cxl_aer_err_type {
> +	CXL_AER_UNCORRECTABLE,
> +	CXL_AER_CORRECTABLE,
> +};
> +
> +struct cxl_cper_prot_err {
> +	struct cxl_ras_capability_regs cxl_ras;
> +
> +	/* Device ID */
> +	u8 function;
> +	u8 device;
> +	u8 bus;
> +	u16 segment;
> +
> +	/* Device Serial Number */
> +	u32 lower_dw;
> +	u32 upper_dw;
> +
> +	int severity;
> +};
> +
>  struct cxl_cper_work_data {
>  	enum cxl_event_type event_type;
>  	struct cxl_cper_event_rec rec;
> +	struct cxl_cper_prot_err p_rec;
>  };
>  
> +struct acpi_hest_generic_data;
> +int cxl_cper_handle_prot_err_info(struct acpi_hest_generic_data *gdata,
> +				  struct cxl_cper_prot_err *rec);
> +
>  #ifdef CONFIG_ACPI_APEI_GHES
>  int cxl_cper_register_work(struct work_struct *work);
>  int cxl_cper_unregister_work(struct work_struct *work);
> -- 
> 2.17.1
> 

-- 
Fan Ni

