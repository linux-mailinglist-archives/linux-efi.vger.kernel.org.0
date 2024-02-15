Return-Path: <linux-efi+bounces-564-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F19BE856258
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 12:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301E81C22F88
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 11:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7543C57872;
	Thu, 15 Feb 2024 11:58:45 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F367912B15B;
	Thu, 15 Feb 2024 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998325; cv=none; b=HLvkEJVtPiPvniEnv9By31iVrnPZ6Mu/3YLnc7sh8zuHEfIzv1nEVcP5FZ296edT/C8k4jKYYOatgONLMLTXxMAF9ITJyEIvspKfM7dflOQbMPwDKnibGPd7SWjRfzP5j1c+8h8uIfFPIRNZKMo+sUvhNeHYyIJM7YSgC3OjMzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998325; c=relaxed/simple;
	bh=K7xEpsB2cMveNQiHzXYyaP1JLMAMdzqrLnMo4zJBzco=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mjug8V4lDVfv4U4jjuCWYyaDJ7uZFnDrtKs3exMYD/iZ70oyptrbKrPP/U+adUJlxHA1iUYcDxYXctcPWlO9d9u+QhSLlQnXdfUf3Zx8pqmooV3CSmNjE9xYPFO6Kp8fHCAN3aGpjGJvRwn7FiqF6Z/3U0kaPbR8e0EANLCDxR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbD5W4fnRz6K8wc;
	Thu, 15 Feb 2024 19:55:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 43C96140B55;
	Thu, 15 Feb 2024 19:58:39 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 11:58:38 +0000
Date: Thu, 15 Feb 2024 11:58:38 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v2 2/4] efi/cper, cxl: Make definitions and structures
 global
Message-ID: <20240215115838.000050b1@Huawei.com>
In-Reply-To: <20240109034755.100555-3-Smita.KoralahalliChannabasappa@amd.com>
References: <20240109034755.100555-1-Smita.KoralahalliChannabasappa@amd.com>
	<20240109034755.100555-3-Smita.KoralahalliChannabasappa@amd.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 9 Jan 2024 03:47:53 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> In preparation to add tracepoint support, move protocol error UUID
> definition to a common location and make CXL RAS capability struct
> global for use across different modules.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> v2:
> 	No change.
> ---
>  drivers/firmware/efi/cper_cxl.c | 11 -----------
>  drivers/firmware/efi/cper_cxl.h |  7 ++-----
>  include/linux/cper.h            |  4 ++++
>  include/linux/cxl-event.h       | 11 +++++++++++
>  4 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
> index a55771b99a97..4fd8d783993e 100644
> --- a/drivers/firmware/efi/cper_cxl.c
> +++ b/drivers/firmware/efi/cper_cxl.c
> @@ -18,17 +18,6 @@
>  #define PROT_ERR_VALID_DVSEC			BIT_ULL(5)
>  #define PROT_ERR_VALID_ERROR_LOG		BIT_ULL(6)
>  
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
> diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
> index 86bfcf7909ec..6f8c00495708 100644
> --- a/drivers/firmware/efi/cper_cxl.h
> +++ b/drivers/firmware/efi/cper_cxl.h
> @@ -7,14 +7,11 @@
>   * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>   */
>  
> +#include <linux/cxl-event.h>
> +
>  #ifndef LINUX_CPER_CXL_H
>  #define LINUX_CPER_CXL_H
>  
> -/* CXL Protocol Error Section */
> -#define CPER_SEC_CXL_PROT_ERR						\
> -	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
> -		  0x4B, 0x77, 0x10, 0x48)
> -
>  #pragma pack(1)
>  
>  /* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
> diff --git a/include/linux/cper.h b/include/linux/cper.h
> index c1a7dc325121..2cbf0a93785a 100644
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
>  /*
>   * Flags bits definitions for flags in struct cper_record_header
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 6ce839c59749..3a41dd5723e8 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -141,6 +141,17 @@ struct cxl_cper_event_rec {
>  	union cxl_event event;
>  } __packed;
>  
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
>  struct cxl_cper_event_info {
>  	struct cxl_cper_event_rec rec;
>  };


