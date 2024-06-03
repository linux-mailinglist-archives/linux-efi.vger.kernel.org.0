Return-Path: <linux-efi+bounces-1123-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023CE8FA626
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 01:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B550928968D
	for <lists+linux-efi@lfdr.de>; Mon,  3 Jun 2024 23:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAC013CA87;
	Mon,  3 Jun 2024 23:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ICuYMLam"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F11D5028C
	for <linux-efi@vger.kernel.org>; Mon,  3 Jun 2024 23:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717455763; cv=none; b=HSMhmqPEk999je2X9yfpfRiaBeX3zkV9nn799JtTM2Y8kyK7MHZjhINpwVkJs6sZbz6Wk7Ab3MKCrA/bkCH9i+CLtMpSNIOXfsQ2vZqF6OP1+j1eNTvYE/GuSYlzGmunlLlDXERKf4GJJBifFFTx0V2lx9x4H5hCx2qGUtVk218=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717455763; c=relaxed/simple;
	bh=5tOD2pHjMWWdT8TSGj9EPKKaUP3pnp/j6cP/I84FMmg=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M68aRoOVe6t54g9qsuf3D2GVTFHYeS7lepsyJKFyTJ2mDTP8CF0QLxgaUATqdjaITQDztXfxG3Spl1rA0lY9LDLjhmB21AaPYoaVcb1t1bFrNT4eMZ2xZTjWMSjnSmONfkxS5vURcHYQu55nQFlAUjgRqhqZmOSU/cuf4EHc8Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ICuYMLam; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ba33b08550so1123197eaf.2
        for <linux-efi@vger.kernel.org>; Mon, 03 Jun 2024 16:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717455759; x=1718060559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ggaQ6J5T1IxPl9jccfKKlkkSH+FkZbGLyq3WMqICX4c=;
        b=ICuYMLamE/chWrfVWwNlsbzjO57nSS56w+ONXVTWS8yzc71ECSuIjvJnPXBVCjYVkP
         PrscTxhX9+Z1SKVYBYdeB4JmFPj2qYnL45xhIWlO5snkkfLV+9CAmANwx6LhlLNqVdZG
         COsNljzFFRJpyjfhN6gQnaYAuD5bxwPSck6uQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717455759; x=1718060559;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggaQ6J5T1IxPl9jccfKKlkkSH+FkZbGLyq3WMqICX4c=;
        b=ICLBds/ZLxF2MWiNsJ4/kQrMTdTlvgOolz2a3huvMjejmENttIzKWuQB62x9xADMuR
         JfM4uiNbhyC3+sD05UkfV+Lafs6JJORPe/QM3hBYzIjJ0og/nTfCCsQ2Z7znmSYBLXaS
         Dbjw1OE3+YJhIVwqHGMtO2fJnMqplUrCVnY/uYx9yvfi1CW5QslyfdxO5saopqJ9G99x
         i7bnxNIDXz5vL6pXnwqM20AYBSFWm5GJ8YfsMGrxYXbrGjkW/JvPMsStsHAfg4TyUMJP
         72wolBn/2C1+sAc9poNwXYKBUF1baduNz0NoCkuQi7HubmiSMtdnEuwzj+GYtlJr3XxM
         ZPMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxMQR2WKOSkrM4Q3yRmtK1LGXacBcl8dGoG7dDTMEHkGpM6Of4jKXyifD7u2/YgdP5ux8WOywGv6g3TwwYaLVkIV+xicAeEc7R
X-Gm-Message-State: AOJu0YztjVmBZuCcXK1gTmWl1P7UYR2cQuAicjc23YmDpdV+spK4xFxi
	delCiNPWiQdOC9EXjJeowNKMUUGG2RwOoHCxY1EdJ5c72pixSy0wkBgYafGW6H/Wny5n6D+QBMd
	9d5pMx2mmVE2gNF7AnaB7cPBAAd27YMeYEaK2
X-Google-Smtp-Source: AGHT+IF7d/TDt2PvSfLYQF36A+sjUkHpPi0ohhg8rJGf+olIn56FTIptan9DUYCXFiaG4Z93Ic9j80AfvaYOMw8ZPZU=
X-Received: by 2002:a05:6870:d8d3:b0:24f:d6c1:692 with SMTP id
 586e51a60fabf-2508ba20045mr12189521fac.29.1717455759199; Mon, 03 Jun 2024
 16:02:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Jun 2024 16:02:38 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20221006224212.569555-8-gpiccoli@igalia.com>
References: <20221006224212.569555-1-gpiccoli@igalia.com> <20221006224212.569555-8-gpiccoli@igalia.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Mon, 3 Jun 2024 16:02:38 -0700
Message-ID: <CAE-0n50vo5xkUNK0-cF9HZRXShsxbikqmdVnmMzRsn+Z7MEJTg@mail.gmail.com>
Subject: Re: [PATCH 7/8] efi: pstore: Follow convention for the efi-pstore
 backend name
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: kernel-dev@igalia.com, kernel@gpiccoli.net, keescook@chromium.org, 
	anton@enomsg.org, ccross@android.com, tony.luck@intel.com, 
	linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Guilherme G. Piccoli (2022-10-06 15:42:11)
> For some reason, the efi-pstore backend name (exposed through the
> pstore infrastructure) is hardcoded as "efi", whereas all the other
> backends follow a kind of convention in using the module name.
>
> Let's do it here as well, to make user's life easier (they might
> use this info for unloading the module backend, for example).

This patch broke ChromeOS' crash reporter when running on EFI[1], which
luckily isn't the typical mode of operation for Chromebooks. The problem
was that we had hardcoded something like dmesg-efi-<number> into the
regex logic that finds EFI pstore records. I didn't write the original
code but I think the idea was to speed things up by parsing the
filenames themselves to collect the files related to a crash record
instead of opening and parsing the header from the files to figure out
which file corresponds to which record.

I suspect the fix is pretty simple (make the driver name match either
one via a regex) but I just wanted to drop a note here that this made
some lives harder, not easier.

>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>  drivers/firmware/efi/efi-pstore.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
> index 3bddc152fcd4..97a9e84840a0 100644
> --- a/drivers/firmware/efi/efi-pstore.c
> +++ b/drivers/firmware/efi/efi-pstore.c
> @@ -207,7 +207,7 @@ static int efi_pstore_erase(struct pstore_record *record)
>
>  static struct pstore_info efi_pstore_info = {
>         .owner          = THIS_MODULE,
> -       .name           = "efi",
> +       .name           = KBUILD_MODNAME,
>         .flags          = PSTORE_FLAGS_DMESG,
>         .open           = efi_pstore_open,
>         .close          = efi_pstore_close,

[1] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform2/crash-reporter/kernel_collector.cc;l=54;drc=7a522166f0b2b32ece60f520b5d3d571c7545b0b

