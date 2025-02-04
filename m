Return-Path: <linux-efi+bounces-2742-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3D6A26865
	for <lists+linux-efi@lfdr.de>; Tue,  4 Feb 2025 01:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 530BF3A072E
	for <lists+linux-efi@lfdr.de>; Tue,  4 Feb 2025 00:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3FD15D1;
	Tue,  4 Feb 2025 00:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGZi5FBY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F204A01;
	Tue,  4 Feb 2025 00:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738628223; cv=none; b=gXj9Q9KrymXajizAWBLKWWJ6tw8e5KjX93ejoWyYNJH8s5fVbsmOpdz8ymB9bHAUVFsHlGgLhnUS+RVT7UIfhExHov7AKJ5wwRlg+A3aR2mhawHwQ4dXFChdh7NQWYHqmhFOQC5jFBQPk6cXFt+0CO6sH9IJ2uz8R8ArKa54ld8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738628223; c=relaxed/simple;
	bh=us5/0V3fRfZxsU8jOvS/Ed5pcHgfeTiXkJTedYqW9RA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbn+SMvcHzjB60QpkNw/7IDJByueka4or6JGnXo07UgJ8Twa1Cl4FO8bjeEU/idMoxWOpneQ2c8kiYYUo5MR3fFXPMMPHVxo6vg1WD87iEcOWdkHz1S5PqC/ICIE3Vw3Uc09Ymib2UqXEXbDMta6KoxOcdJRAP6ZTtwQpWgFYsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGZi5FBY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f01fe1ce8so2697155ad.2;
        Mon, 03 Feb 2025 16:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738628221; x=1739233021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tU4LSJDtEFGjrkMcRZF4apDGKO3yQFj7d3gvcWzEtNg=;
        b=GGZi5FBYllI0U+2EdFaeZmwOiT41MtfqX6resc7rDQWEwXe/skJLn6iEnSaRDjEwxp
         l7/z7QpBedmF/SvnmC+Ptq5prPvLkx1ylJLyuU1j38y1cF89EK+9yFxYbt0nr+Q+MEaG
         Amyiy7U+cVOkMFE2obw+1FwKWeCz6QlCvh6zu65ACgV+fdtGV0gXp1i36g1jXIZr4e4K
         KECpBMFFSLvT5KuYaAPNdIdzc9vN0VE/+b3bDESbszUPO9pX1Ib1waQMmpDKIFMxjVGX
         Iiqv0RM1/+KaGRLs+MQKKOTrH1hhBdhNiMW5DDB1/Nz8Afpg7ZQrDR57Okk22C060q42
         VeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738628221; x=1739233021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tU4LSJDtEFGjrkMcRZF4apDGKO3yQFj7d3gvcWzEtNg=;
        b=cb0a0320f91nUit5aAw39ERho78L0MvSQaUra1CvPGW0hxVKxJYiR4dnCdFQUPHJMl
         shHI53xvExQRXKHlaryZUy7UnlnR9BJFyN7zXBI1eFx9ggLgO3zSM1tlpMcGxfv8yS7b
         eca9kqfg1pnDwX36qONsYtG5EwcHpQ0sYJDslRYGDcon1l5ALMCFVATXzD62NzI0jEQp
         Xi8BpM+C3X2GcAqSmWMQJ4zX/hJ9uUS4VInY6F60Q19vIa7ip1ybyVRDx3LPtsoM/lW5
         dE+HmX70Vjzbwio7aoEDuRAD4idbtLMnDbIjfuLVcQtOzn7SpIVay/ZktAf5H4se/d3W
         Rgxw==
X-Forwarded-Encrypted: i=1; AJvYcCW5/QShE92N4PTrM/Kf39CDh3iOF9CSoFdiLavuE9VOF2JRcyyUFrOBrtDoE7ZvDikNJPw6ZGcHF4w=@vger.kernel.org, AJvYcCXv1CKN+oWXhCP4vYhmYog8S66SbTAmXUUWryHV4CtA+oG4Kc1g9pU/6sxNxA++ZjV4j+pzDItWSvUAP05G@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkd0ntuqagCRta4EjfWMmW7+zuq3XY31u/PAJoLGlPoVZ62j2n
	05d9Ely6Cf/8ztQ+m2t2LS6l0dK3yM1rqkwSNCvZEwWJNdevf/Z3
X-Gm-Gg: ASbGncsB76OVqfFemU8biiJegebWfEAK0+Fm387acOpBcvylBRv6U6F8HwBZHefO68X
	TPnc6T5c8Qn4HxGr3fQPvLWxbsq+1XrsBJ6pzgt/WNaTqv4tJfpBPNBEJa17DDDs2DjS1epu57f
	tKciIHWl+Vc3fDazk+2e/NECUyNKygBzriRGj38VamVB1ELhRPeDMGCo7Vna36zaUrX1Cv97IY0
	LVmQkXKf/ks8bdxttrQqW44+uCcy5F+N2v6N2CpTbZwfzSN5LJ5eDPqoJoo4cSTupTf6g7sYXem
	WNc=
X-Google-Smtp-Source: AGHT+IHt66seto9zjCCmsD6qNgzV3HZc+J+rIO3WrCvNAQ8JNMEFoQSqCOIi29l7v2kRbDZxdpk46w==
X-Received: by 2002:a05:6a00:ac8:b0:725:322a:922c with SMTP id d2e1a72fcca58-72fd0bc8c96mr41250196b3a.3.1738628220616;
        Mon, 03 Feb 2025 16:17:00 -0800 (PST)
Received: from fan ([2601:642:4c00:5ce4:43f:54b:5b70:652e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe631be3csm9124411b3a.7.2025.02.03.16.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 16:17:00 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 3 Feb 2025 16:16:57 -0800
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
Subject: Re: [PATCH v6 2/6] efi/cper, cxl: Make definitions and structures
 global
Message-ID: <Z6FceahoczClpTn6@fan>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-3-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123084421.127697-3-Smita.KoralahalliChannabasappa@amd.com>

On Thu, Jan 23, 2025 at 08:44:17AM +0000, Smita Koralahalli wrote:
> In preparation to add tracepoint support, move protocol error UUID
> definition to a common location, Also, make struct CXL RAS capability,
s/, Also/. Also/

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> cxl_cper_sec_prot_err and CPER validation flags global for use across
> different modules.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/firmware/efi/cper.c     |  1 +
>  drivers/firmware/efi/cper_cxl.c | 35 +--------------
>  drivers/firmware/efi/cper_cxl.h | 51 ---------------------
>  include/cxl/event.h             | 80 +++++++++++++++++++++++++++++++++
>  include/linux/cper.h            |  4 ++
>  5 files changed, 86 insertions(+), 85 deletions(-)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 8e5762f7ef2e..ae1953e2b214 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -24,6 +24,7 @@
>  #include <linux/bcd.h>
>  #include <acpi/ghes.h>
>  #include <ras/ras_event.h>
> +#include <cxl/event.h>
>  #include "cper_cxl.h"
>  
>  /*
> diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
> index cbaabcb7382d..64c0dd27be6e 100644
> --- a/drivers/firmware/efi/cper_cxl.c
> +++ b/drivers/firmware/efi/cper_cxl.c
> @@ -8,27 +8,9 @@
>   */
>  
>  #include <linux/cper.h>
> +#include <cxl/event.h>
>  #include "cper_cxl.h"
>  
> -#define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
> -#define PROT_ERR_VALID_AGENT_ADDRESS		BIT_ULL(1)
> -#define PROT_ERR_VALID_DEVICE_ID		BIT_ULL(2)
> -#define PROT_ERR_VALID_SERIAL_NUMBER		BIT_ULL(3)
> -#define PROT_ERR_VALID_CAPABILITY		BIT_ULL(4)
> -#define PROT_ERR_VALID_DVSEC			BIT_ULL(5)
> -#define PROT_ERR_VALID_ERROR_LOG		BIT_ULL(6)
> -
> -/* CXL RAS Capability Structure, CXL v3.0 sec 8.2.4.16 */
> -struct cxl_ras_capability_regs {
> -	u32 uncor_status;
> -	u32 uncor_mask;
> -	u32 uncor_severity;
> -	u32 cor_status;
> -	u32 cor_mask;
> -	u32 cap_control;
> -	u32 header_log[16];
> -};
> -
>  static const char * const prot_err_agent_type_strs[] = {
>  	"Restricted CXL Device",
>  	"Restricted CXL Host Downstream Port",
> @@ -40,21 +22,6 @@ static const char * const prot_err_agent_type_strs[] = {
>  	"CXL Upstream Switch Port",
>  };
>  
> -/*
> - * The layout of the enumeration and the values matches CXL Agent Type
> - * field in the UEFI 2.10 Section N.2.13,
> - */
> -enum {
> -	RCD,	/* Restricted CXL Device */
> -	RCH_DP,	/* Restricted CXL Host Downstream Port */
> -	DEVICE,	/* CXL Device */
> -	LD,	/* CXL Logical Device */
> -	FMLD,	/* CXL Fabric Manager managed Logical Device */
> -	RP,	/* CXL Root Port */
> -	DSP,	/* CXL Downstream Switch Port */
> -	USP,	/* CXL Upstream Switch Port */
> -};
> -
>  void cxl_cper_print_prot_err(const char *pfx,
>  			     const struct cxl_cper_sec_prot_err *prot_err)
>  {
> diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
> index 0e3ab0ba17c3..5ce1401ee17a 100644
> --- a/drivers/firmware/efi/cper_cxl.h
> +++ b/drivers/firmware/efi/cper_cxl.h
> @@ -10,57 +10,6 @@
>  #ifndef LINUX_CPER_CXL_H
>  #define LINUX_CPER_CXL_H
>  
> -/* CXL Protocol Error Section */
> -#define CPER_SEC_CXL_PROT_ERR						\
> -	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
> -		  0x4B, 0x77, 0x10, 0x48)
> -
> -#pragma pack(1)
> -
> -/* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
> -struct cxl_cper_sec_prot_err {
> -	u64 valid_bits;
> -	u8 agent_type;
> -	u8 reserved[7];
> -
> -	/*
> -	 * Except for RCH Downstream Port, all the remaining CXL Agent
> -	 * types are uniquely identified by the PCIe compatible SBDF number.
> -	 */
> -	union {
> -		u64 rcrb_base_addr;
> -		struct {
> -			u8 function;
> -			u8 device;
> -			u8 bus;
> -			u16 segment;
> -			u8 reserved_1[3];
> -		};
> -	} agent_addr;
> -
> -	struct {
> -		u16 vendor_id;
> -		u16 device_id;
> -		u16 subsystem_vendor_id;
> -		u16 subsystem_id;
> -		u8 class_code[2];
> -		u16 slot;
> -		u8 reserved_1[4];
> -	} device_id;
> -
> -	struct {
> -		u32 lower_dw;
> -		u32 upper_dw;
> -	} dev_serial_num;
> -
> -	u8 capability[60];
> -	u16 dvsec_len;
> -	u16 err_len;
> -	u8 reserved_2[4];
> -};
> -
> -#pragma pack()
> -
>  void cxl_cper_print_prot_err(const char *pfx,
>  			     const struct cxl_cper_sec_prot_err *prot_err);
>  
> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index 0bea1afbd747..66d85fc87701 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -152,6 +152,86 @@ struct cxl_cper_work_data {
>  	struct cxl_cper_event_rec rec;
>  };
>  
> +#define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
> +#define PROT_ERR_VALID_AGENT_ADDRESS		BIT_ULL(1)
> +#define PROT_ERR_VALID_DEVICE_ID		BIT_ULL(2)
> +#define PROT_ERR_VALID_SERIAL_NUMBER		BIT_ULL(3)
> +#define PROT_ERR_VALID_CAPABILITY		BIT_ULL(4)
> +#define PROT_ERR_VALID_DVSEC			BIT_ULL(5)
> +#define PROT_ERR_VALID_ERROR_LOG		BIT_ULL(6)
> +
> +/*
> + * The layout of the enumeration and the values matches CXL Agent Type
> + * field in the UEFI 2.10 Section N.2.13,
> + */
> +enum {
> +	RCD,	/* Restricted CXL Device */
> +	RCH_DP,	/* Restricted CXL Host Downstream Port */
> +	DEVICE,	/* CXL Device */
> +	LD,	/* CXL Logical Device */
> +	FMLD,	/* CXL Fabric Manager managed Logical Device */
> +	RP,	/* CXL Root Port */
> +	DSP,	/* CXL Downstream Switch Port */
> +	USP,	/* CXL Upstream Switch Port */
> +};
> +
> +#pragma pack(1)
> +
> +/* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
> +struct cxl_cper_sec_prot_err {
> +	u64 valid_bits;
> +	u8 agent_type;
> +	u8 reserved[7];
> +
> +	/*
> +	 * Except for RCH Downstream Port, all the remaining CXL Agent
> +	 * types are uniquely identified by the PCIe compatible SBDF number.
> +	 */
> +	union {
> +		u64 rcrb_base_addr;
> +		struct {
> +			u8 function;
> +			u8 device;
> +			u8 bus;
> +			u16 segment;
> +			u8 reserved_1[3];
> +		};
> +	} agent_addr;
> +
> +	struct {
> +		u16 vendor_id;
> +		u16 device_id;
> +		u16 subsystem_vendor_id;
> +		u16 subsystem_id;
> +		u8 class_code[2];
> +		u16 slot;
> +		u8 reserved_1[4];
> +	} device_id;
> +
> +	struct {
> +		u32 lower_dw;
> +		u32 upper_dw;
> +	} dev_serial_num;
> +
> +	u8 capability[60];
> +	u16 dvsec_len;
> +	u16 err_len;
> +	u8 reserved_2[4];
> +};
> +
> +#pragma pack()
> +
> +/* CXL RAS Capability Structure, CXL v3.0 sec 8.2.4.16 */
> +struct cxl_ras_capability_regs {
> +	u32 uncor_status;
> +	u32 uncor_mask;
> +	u32 uncor_severity;
> +	u32 cor_status;
> +	u32 cor_mask;
> +	u32 cap_control;
> +	u32 header_log[16];
> +};
> +
>  #ifdef CONFIG_ACPI_APEI_GHES
>  int cxl_cper_register_work(struct work_struct *work);
>  int cxl_cper_unregister_work(struct work_struct *work);
> diff --git a/include/linux/cper.h b/include/linux/cper.h
> index 265b0f8fc0b3..5c6d4d5b9975 100644
> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -89,6 +89,10 @@ enum {
>  #define CPER_NOTIFY_DMAR						\
>  	GUID_INIT(0x667DD791, 0xC6B3, 0x4c27, 0x8A, 0x6B, 0x0F, 0x8E,	\
>  		  0x72, 0x2D, 0xEB, 0x41)
> +/* CXL Protocol Error Section */
> +#define CPER_SEC_CXL_PROT_ERR						\
> +	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
> +		  0x4B, 0x77, 0x10, 0x48)
>  
>  /* CXL Event record UUIDs are formatted as GUIDs and reported in section type */
>  /*
> -- 
> 2.17.1
> 

-- 
Fan Ni

