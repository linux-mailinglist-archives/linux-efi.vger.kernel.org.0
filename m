Return-Path: <linux-efi+bounces-568-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05DF856687
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 15:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D16F28C49A
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 14:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187EA132489;
	Thu, 15 Feb 2024 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECIszJOQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC43A132487;
	Thu, 15 Feb 2024 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008489; cv=none; b=Kxsy9G5pE7oMRXmynqjYX/ylbv78Vl3zNCqh1kmm9Ei7lfscZ+NY3HEnx+K2LSUHDk3ZYPiSGtJiY3Iu8sD75cnVDK5/ldMm9gTXGjD5K7uShoKGDRTocA+s9m0z7N3He/zWC8rWckZ6TDDEhbMFpTBB3/EDQE+pEZQf8/IFUbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008489; c=relaxed/simple;
	bh=0+eV2z62wC4M1HPoT2S+05ApoAOXW0O0QiIlxgy+rog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pk1S2GbZcuB2aTTAz89FfBp+fvACRvkDP6d3ADnIO3bt0mqJg+O3hDq4tPR26fydpHQsSgwzV3LRPo+hmhIjiinni1A1rdWvKhpAxPczHNCqI56lfLcYcurtjiXoZB1qvR/fQE38KnYeu3Sau03JFQAbmEiGYdqMmlmOGrTs874=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECIszJOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C255C43390;
	Thu, 15 Feb 2024 14:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708008488;
	bh=0+eV2z62wC4M1HPoT2S+05ApoAOXW0O0QiIlxgy+rog=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ECIszJOQGoQ2anjbO4YmfzCJzHkllqvxa+8pVFJXr0jERLsNeBO/x6IXesUGya4IS
	 vcAGz2L4L8JnS8CEFBkxqxu77+/Xwfy0ZrhzpADod4tkSt3TZqog28Fa7GlBPsCewj
	 nJ8RGQRKYqghzEMiEtYzdYorMHitXDhbdboJQhVLfKOAQRmbrkfenEWAVohDJ2Ugj/
	 CzsqGUoacwiG0+dMTg0HIJziyvrZHxYxv3Mtan2IpROHW+WpwsRVhtFvDDF9G/shmx
	 sNFS/JU6oCOK3kEqrKV89yAXk7yQ0IoxnJJaLeMw63x/9ZNWmtsO6OQ9lE+boAKHeu
	 Uah81SXH9lbrQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-511a4a1c497so1020728e87.3;
        Thu, 15 Feb 2024 06:48:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXSMoxJhe3bRPfzy/l+AXqU/fa/S8Mq2xknfNQmV0adDuNBGj6pHFE1pxadD4AymVdj+41+mq+wtAmMz0oledNdz1uenF/jhERgqi+wbZgMvDKxyvWqyB5wEjGBuX/FbV4tWzIoQf44
X-Gm-Message-State: AOJu0YzsAIvVmwA0RfygjzvyxZZdqqdExj5mX5Zit3HwBbEuKF+JO/k+
	KLebyiQkXpDxFK5v0aOK69luPbhe3Ay4ZM91DZ9SZ1nVFRMqciYRICWIKeRbUWbnPfK0XeDWzUm
	LLeTE2nTVngkBiP2aavqLJaAdU4o=
X-Google-Smtp-Source: AGHT+IEZw0KmJnT1uU8Ft00FTsupt30pFi4+zk6kJV4/CX34SXviVJUOot0Yh2Y2rwLBIufyF9SkYEGj4qQU6pesW0g=
X-Received: by 2002:a05:6512:601:b0:511:ae21:97ab with SMTP id
 b1-20020a056512060100b00511ae2197abmr1705357lfe.25.1708008486587; Thu, 15 Feb
 2024 06:48:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109034755.100555-1-Smita.KoralahalliChannabasappa@amd.com> <20240109034755.100555-3-Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20240109034755.100555-3-Smita.KoralahalliChannabasappa@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 15 Feb 2024 15:47:54 +0100
X-Gmail-Original-Message-ID: <CAMj1kXESytb-wD6ybRqrA+D0sOnfSRyFVLxEOyok7OqPofjCGw@mail.gmail.com>
Message-ID: <CAMj1kXESytb-wD6ybRqrA+D0sOnfSRyFVLxEOyok7OqPofjCGw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] efi/cper, cxl: Make definitions and structures global
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-cxl@vger.kernel.org, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Yazen Ghannam <yazen.ghannam@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jan 2024 at 04:48, Smita Koralahalli
<Smita.KoralahalliChannabasappa@amd.com> wrote:
>
> In preparation to add tracepoint support, move protocol error UUID
> definition to a common location and make CXL RAS capability struct
> global for use across different modules.
>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
> v2:
>         No change.
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
>  #define PROT_ERR_VALID_DVSEC                   BIT_ULL(5)
>  #define PROT_ERR_VALID_ERROR_LOG               BIT_ULL(6)
>
> -/* CXL RAS Capability Structure, CXL v3.0 sec 8.2.4.16 */
> -struct cxl_ras_capability_regs {
> -       u32 uncor_status;
> -       u32 uncor_mask;
> -       u32 uncor_severity;
> -       u32 cor_status;
> -       u32 cor_mask;
> -       u32 cap_control;
> -       u32 header_log[16];
> -};
> -
>  static const char * const prot_err_agent_type_strs[] = {
>         "Restricted CXL Device",
>         "Restricted CXL Host Downstream Port",
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
> -#define CPER_SEC_CXL_PROT_ERR                                          \
> -       GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,   \
> -                 0x4B, 0x77, 0x10, 0x48)
> -
>  #pragma pack(1)
>
>  /* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
> diff --git a/include/linux/cper.h b/include/linux/cper.h
> index c1a7dc325121..2cbf0a93785a 100644
> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -89,6 +89,10 @@ enum {
>  #define CPER_NOTIFY_DMAR                                               \
>         GUID_INIT(0x667DD791, 0xC6B3, 0x4c27, 0x8A, 0x6B, 0x0F, 0x8E,   \
>                   0x72, 0x2D, 0xEB, 0x41)
> +/* CXL Protocol Error Section */
> +#define CPER_SEC_CXL_PROT_ERR                                          \
> +       GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,   \
> +                 0x4B, 0x77, 0x10, 0x48)
>
>  /*
>   * Flags bits definitions for flags in struct cper_record_header
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 6ce839c59749..3a41dd5723e8 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -141,6 +141,17 @@ struct cxl_cper_event_rec {
>         union cxl_event event;
>  } __packed;
>
> +/* CXL RAS Capability Structure, CXL v3.0 sec 8.2.4.16 */
> +struct cxl_ras_capability_regs {
> +       u32 uncor_status;
> +       u32 uncor_mask;
> +       u32 uncor_severity;
> +       u32 cor_status;
> +       u32 cor_mask;
> +       u32 cap_control;
> +       u32 header_log[16];
> +};
> +
>  struct cxl_cper_event_info {
>         struct cxl_cper_event_rec rec;
>  };
> --
> 2.17.1
>
>

