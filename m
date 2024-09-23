Return-Path: <linux-efi+bounces-1794-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9C397E647
	for <lists+linux-efi@lfdr.de>; Mon, 23 Sep 2024 08:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12DEF2811FC
	for <lists+linux-efi@lfdr.de>; Mon, 23 Sep 2024 06:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C0A2A1D8;
	Mon, 23 Sep 2024 06:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fWytdbSi"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1684E8F66
	for <linux-efi@vger.kernel.org>; Mon, 23 Sep 2024 06:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727074681; cv=none; b=gZ9i/LRJ7DB/O2tBlibgYT1UDcwcq1iRK5I/LsclDrVXXyAFN/aUjsIExRgUQc9pGQv4qicwj72vd7cRDRqky/NM46lPfpeLmLV+Gf8YKG/disdIsOpilRIkV4cmSVHDRcpNgVKjGamiHvzIFuDBRx9LEIfcCWOaIq7nw5IjSUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727074681; c=relaxed/simple;
	bh=X6m0UNRfEntKZMqrBloClIeqX+UDhTDwCPIrSNeLses=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6/ZL+1+c3aK6uU+Vg2IbsdSIbp/kl3qvTkdAsy7MPMUIas8h1RceqSw4jiLsh8V9GelIuVKrg3zASb6S73LeNvWyqTEMx39pfuFaLALjygmerlDTBoNcb1udno2Ybd3gDWwFE+wjVGhRJQyXKURKr4iIQYHKyHsSYOf2Rw37jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fWytdbSi; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71971d20ad9so2595596b3a.3
        for <linux-efi@vger.kernel.org>; Sun, 22 Sep 2024 23:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727074679; x=1727679479; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pkusHDhxYhOwHV3orDxc1X5yP7fzkJVdSKdHPv2nwN0=;
        b=fWytdbSicmWiDshLEof2V9O9rTU9oEvBm08TNHukXWUmQGcGvQGjIZmvNO9+XPMMZD
         ZfQZ9xndT+FK5RShrmJc7HtHbnV32hMmODsnoOMpnfT+xwbvkSR1iFGofrPeG8n+84Ir
         pveYDYmWvOfm2e35PYb/nZ6xw0UD4PHyLk63ZevyiymDYFPnDVfJKV/ENo4J46MSMbaY
         kG17ePLSKIRfb6A3iKvGuK71HS2E6p8IrP5LnvKEwl2dwZGUhxB9OLrpE2wg/REDAKwx
         b44nxssdHO72+mcixYSXmpf3fX4obMf8aieRigNYxM3xymEofpxvWZAPKTTxQ/xRvNgX
         m2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727074679; x=1727679479;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pkusHDhxYhOwHV3orDxc1X5yP7fzkJVdSKdHPv2nwN0=;
        b=LGOmxysicMswNw9zZpK8eOMQg1JBJlxHY27+GnRcUAwUnTocidWUHjSn2373Z/BsbL
         CB0oa8/KoWxYX3ZnsYICvEBCv891ZGskKV6KwSHXsTvExkIoyyuBVVHyQKQt4w2mK/3o
         fDq2Xd+Pi/9Ni75O/XOKFRMHZmjN6HWVndkQtJpHh8YIB5hNimfp/RtgAEiFIrXhk6lY
         HnIayaqH4mgnQIJneDJDSSSa0h+WUDVN/atkUL63Mj2by/LCx8Ujn4zAl/93Ce3lr9sm
         c3mxB4X3XRaRQbii5XkT7WdY/IGuoiApOvWAD9fj6WCrTjJ7MWrdFAooiUSgCVNEDm7w
         FiLg==
X-Gm-Message-State: AOJu0YwFO5KF43ZvcqyDjP3k05wo9eOF4d4Bpcj3qPbxwPsh+EXnxd1I
	jDtW4kw2xg4hjNwhIgTKra8aPAZmwyTYGTyditfa4aunB/gRtAArUpt+CITvqiRKl2cCQkVVuxz
	d0vcCiYLYz1UpOqQ5J5An9aYzYZQYG5cpObMS3OpL/RolW1rruAc=
X-Google-Smtp-Source: AGHT+IGY0ecO8UbJMituimRhZAv/jdCoeJy6X6X+k4RAZ8zVLV3b4OxIACoaBwjBM/NPeOPhWCSytL15SQpCuIHDq2Q=
X-Received: by 2002:a05:6a00:1896:b0:714:17b5:c1d9 with SMTP id
 d2e1a72fcca58-7199c97ce01mr15682172b3a.1.1727074679361; Sun, 22 Sep 2024
 23:57:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913231954.20081-1-gourry@gourry.net> <20240913231954.20081-2-gourry@gourry.net>
In-Reply-To: <20240913231954.20081-2-gourry@gourry.net>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 23 Sep 2024 09:57:22 +0300
Message-ID: <CAC_iWjLf2ttNXdsmcFw+CnqPzoRPa__cg5vpNvwqoW6jwxEPKA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] tpm: fix signed/unsigned bug when checking event logs
To: Gregory Price <gourry@gourry.net>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, ardb@kernel.org, 
	leitao@debian.org, usamaarif642@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Sept 2024 at 02:20, Gregory Price <gourry@gourry.net> wrote:
>
> A prior bugfix that fixes a signed/unsigned error causes
> another signed unsigned error.
>
> A situation where log_tbl->size is invalid can cause the
> size passed to memblock_reserve to become negative.
>
> log_size from the main event log is an unsigned int, and
> the code reduces to the following
>
> u64 value = (int)unsigned_value;
>
> This results in sign extension, and the value sent to
> memblock_reserve becomes effectively negative.
>
> Fixes: be59d57f9806 ("efi/tpm: Fix sanity check of unsigned tbl_size being less than zero")
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/firmware/efi/tpm.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> index e8d69bd548f3..9c3613e6af15 100644
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -40,7 +40,8 @@ int __init efi_tpm_eventlog_init(void)
>  {
>         struct linux_efi_tpm_eventlog *log_tbl;
>         struct efi_tcg2_final_events_table *final_tbl;
> -       int tbl_size;
> +       unsigned int tbl_size;

nit, perhaps u32 is better here

> +       int final_tbl_size;
>         int ret = 0;
>
>         if (efi.tpm_log == EFI_INVALID_TABLE_ADDR) {
> @@ -80,26 +81,26 @@ int __init efi_tpm_eventlog_init(void)
>                 goto out;
>         }
>
> -       tbl_size = 0;
> +       final_tbl_size = 0;
>         if (final_tbl->nr_events != 0) {
>                 void *events = (void *)efi.tpm_final_log
>                                 + sizeof(final_tbl->version)
>                                 + sizeof(final_tbl->nr_events);
>
> -               tbl_size = tpm2_calc_event_log_size(events,
> -                                                   final_tbl->nr_events,
> -                                                   log_tbl->log);
> +               final_tbl_size = tpm2_calc_event_log_size(events,
> +                                                         final_tbl->nr_events,
> +                                                         log_tbl->log);
>         }
>
> -       if (tbl_size < 0) {
> +       if (final_tbl_size < 0) {
>                 pr_err(FW_BUG "Failed to parse event in TPM Final Events Log\n");
>                 ret = -EINVAL;
>                 goto out_calc;
>         }
>
>         memblock_reserve(efi.tpm_final_log,
> -                        tbl_size + sizeof(*final_tbl));
> -       efi_tpm_final_log_size = tbl_size;
> +                        final_tbl_size + sizeof(*final_tbl));
> +       efi_tpm_final_log_size = final_tbl_size;
>
>  out_calc:
>         early_memunmap(final_tbl, sizeof(*final_tbl));
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

