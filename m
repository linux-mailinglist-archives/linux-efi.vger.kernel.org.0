Return-Path: <linux-efi+bounces-1720-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA2D9778E9
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 08:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83851C24E14
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 06:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C45C1B985E;
	Fri, 13 Sep 2024 06:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hwpyuUx8"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF01C187350
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726209670; cv=none; b=PxMYk9bpxhRiMVFqHQcMzj4eaMYJe4VsCgobBl1LXp3MlrUwGAOOUcufsOXVS10yBMeVO9PdtuSjQCim0X7DSHmESx9GEVgIx2NbywwNDKb6DO4TMlb1TUt6rGQiOx3OxL+k+xSWsWxwAW8VY21F7ciCkiMN5KdV8LwyotBZOXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726209670; c=relaxed/simple;
	bh=ehcs3zWtTc6DmoyDuY/1gTW6lTSxcf2UYJrb+rJ+Qj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3JYdCfc4BCdQHTwbxXRXqn6OGEtqj3wBWRmXjODWYVraBBpdvZdPhTHxPtnGaKzKHedkpXysgtSGjx+luB5bjro/tZcyjVTaxHD6Btpmw9cqGl7E+mUF4wvk5tOqa1Lwe07OnrBxiVgMOR6j41PupLv6XscDhrOwzlWjlMH2ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hwpyuUx8; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e042f4636dso285437b6e.1
        for <linux-efi@vger.kernel.org>; Thu, 12 Sep 2024 23:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726209667; x=1726814467; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mST6gEktXZQHF6SwcttPjz/jfWpwUS5ebz/OPlAa6uM=;
        b=hwpyuUx8kby7PIvgpgWRUzru/HiIvei8Ymq2juzp6bqcYR7XRypMD75XFFesXTQBtU
         rdc+qL8LFqOZbEkbshOLysYmeKvmmTUUehouHLDorktfsMrOayireLe86tUE28zx5T0g
         1XJAZcdc3vfsYKBxGJGOeZrtEjl2m3MBP1RJZofjaIa3UYkGlyZnrackZpTNY7MLU7an
         gKE4jMGJo4gOwI4xmHYMtQDUAteW0QwdJoTSm1vPnA0b+rcgQpYF8d/nvtDuwbgPferI
         gbkCKLXpyEy80az2QAhCu1Vtikv3bxkJY4uznT80uahUHqzIAifabmyu6kog66BcqY9z
         6jzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726209667; x=1726814467;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mST6gEktXZQHF6SwcttPjz/jfWpwUS5ebz/OPlAa6uM=;
        b=uQTEFzh7BnuIr3K8/sjduY/kPdQItQJdY9EWWNl2ygImoRQeGBkcwmzEDZOg158z6R
         aYMlwUU+T3KBFOcwJyEDEOPfmoQtQ/qqd56ksuKU24GKoASpXTbZ2Q79mZE2QjulhpWI
         oTEJgw+SB67txZY88iDKnb2E43XOdHcOGNXxpuKxrkA5gMK1w1eW7d9p6VOipb4NTLjY
         Prp9BXyiRlR8t5A65rwqDfSrtRTWeQcTK6HPrVB4BXQZ7o/RT7ctDhNTsejsO5Gbr4Sf
         wftoRR92lkUVfM1C9QAUIRh5CeYZ6e1xZf8zKw2JJS1pjdVXaYjXtrizN3zfCsxzNFB+
         1KBQ==
X-Gm-Message-State: AOJu0Yx0JZsZOXGcOB0wKt1sR1Y9AvRMauHYHpbXb2iYLhiSDfwP3eWm
	u+CXEZTL9mMjh+a3ELpJkQ8forf887APt1mSuw61wUUNtRtVtQjpWUOVD1YNDjUKgoVnFy1+lOO
	NML+Gs+wGMAMqTi0QkpyeWhlHomHKSccANY/4CA==
X-Google-Smtp-Source: AGHT+IHq7LKuC8w8KZXTC1aYQokjs33/F/qEQAisoiDkuE50PH9P5dpa/EWsmU4eHs1SO0Aao6x1WX+8wzR8ghf5Hk0=
X-Received: by 2002:a05:6871:e2a9:b0:25e:eab:6d32 with SMTP id
 586e51a60fabf-27c688c0640mr1090936fac.5.1726209666728; Thu, 12 Sep 2024
 23:41:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906202745.11159-1-gourry@gourry.net> <20240906202745.11159-5-gourry@gourry.net>
In-Reply-To: <20240906202745.11159-5-gourry@gourry.net>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Sep 2024 09:40:30 +0300
Message-ID: <CAC_iWjJizjQWucDbrqKGdZTcj7FFxiPN97=p1zwfnPE=sAC6RQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] tpm: sanity check the log version before using it
To: Gregory Price <gourry@gourry.net>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, ardb@kernel.org, 
	leitao@debian.org, usamaarif642@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Gregory,

On Fri, 6 Sept 2024 at 23:28, Gregory Price <gourry@gourry.net> wrote:
>
> If the log version is not sane (0 or >2), don't attempt to use
> the rest of the log values for anything to avoid potential corruption.
>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/firmware/efi/tpm.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> index 6e03eed0dc6f..9a080887a3e0 100644
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -60,6 +60,15 @@ int __init efi_tpm_eventlog_init(void)
>                 return -ENOMEM;
>         }
>
> +       if (!log_tbl->version ||
> +           log_tbl->version > EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
> +               pr_err(FW_BUG "TPM Events table version invalid (%x)\n",
> +                      log_tbl->version);
> +               early_memunmap(log_tbl, sizeof(*log_tbl));
> +               efi.tpm_log = EFI_INVALID_TABLE_ADDR;
> +               return -EINVAL;

I don't think we need this check at all. Did you actually see this happening?
efi_retrieve_eventlog() that runs during the efistub tries to retrieve
the log and the EFI protocol itself explicitly says that the firmware
*must* return EFI_INVALID_PARAMETER if the event log is not in 1.2 or
2.0 format. If the firmware does something wrong, we should report the
FW BUG in that function, instead of installing the config tables Linux
uses internally to handover the log and catching it late.

Thanks
/Ilias



> +       }
> +
>         tbl_size = sizeof(*log_tbl) + log_tbl->size;
>         if (memblock_reserve(efi.tpm_log, tbl_size)) {
>                 pr_err("TPM Event Log memblock reserve fails (0x%lx, 0x%x)\n",
> --
> 2.43.0
>

