Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DE62C18FB
	for <lists+linux-efi@lfdr.de>; Mon, 23 Nov 2020 23:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387487AbgKWWxx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Nov 2020 17:53:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:51864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387899AbgKWWxw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 23 Nov 2020 17:53:52 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A39792071E
        for <linux-efi@vger.kernel.org>; Mon, 23 Nov 2020 22:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606172031;
        bh=8H6VsgRRvARu2tmiou3bkT3rMJZFC+NK7/An4n78Jp0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PRPNFW8ew1NgtGzcK+VWEjdlAHhZwecxniJTX5Al0EJGXajJFDEN0jUVQha8PEzbH
         YQWQw6O3X+z3riczQV7nFpQC/TXo75kNVOwR4iPVjwoKDMzCIk6Gos30EDpX5YWhH1
         gX6nnNOWKEKYS7k3GT0ZSniMII8/CF1xMViX+Nmo=
Received: by mail-ot1-f43.google.com with SMTP id n11so17546195ota.2
        for <linux-efi@vger.kernel.org>; Mon, 23 Nov 2020 14:53:51 -0800 (PST)
X-Gm-Message-State: AOAM533Qwyc+QjHiGECr/Xy2kcY+kjmHDI99EWhSGUhCMpjnM5Bw7mVb
        gOrwAjY/JW2na93o8yywIStSU2k0sN4z8IfDQ8E=
X-Google-Smtp-Source: ABdhPJzdj9Ri4Aw6ZeECxCp8xA+/lXKkibKC6nTjDntb0+hogEXh2NEKndTEv+CiPGuL5HhE2Ax+PMbBxAOsdiz0tz4=
X-Received: by 2002:a9d:62c1:: with SMTP id z1mr1254139otk.108.1606172030893;
 Mon, 23 Nov 2020 14:53:50 -0800 (PST)
MIME-Version: 1.0
References: <20201123172817.124146-1-amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20201123172817.124146-1-amadeuszx.slawinski@linux.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 23 Nov 2020 23:53:40 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEY14MWoCnMHTzGpyC7V8=dF3fxT44tDqzRXZtXRRf87w@mail.gmail.com>
Message-ID: <CAMj1kXEY14MWoCnMHTzGpyC7V8=dF3fxT44tDqzRXZtXRRf87w@mail.gmail.com>
Subject: Re: [PATCH] efi/efivars: Set generic ops before loading SSDT
To:     =?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 23 Nov 2020 at 16:11, Amadeusz S=C5=82awi=C5=84ski
<amadeuszx.slawinski@linux.intel.com> wrote:
>
> Efivar allows for overriding of SSDT tables, however starting with
> commit bf67fad19e493b ("efi: Use more granular check for availability for=
 variable services")
> this use case is broken. When loading SSDT generic ops should be set
> first, however mentioned commit reversed order of operations. Fix this
> by restoring original order of operations.
>
> Fixes: bf67fad19e493b ("efi: Use more granular check for availability for=
 variable services")
> Signed-off-by: Amadeusz S=C5=82awi=C5=84ski <amadeuszx.slawinski@linux.in=
tel.com>
> ---
>  drivers/firmware/efi/efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 5e5480a0a32d..6c6eec044a97 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -390,10 +390,10 @@ static int __init efisubsys_init(void)
>
>         if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE |
>                                       EFI_RT_SUPPORTED_GET_NEXT_VARIABLE_=
NAME)) {
> -               efivar_ssdt_load();
>                 error =3D generic_ops_register();
>                 if (error)
>                         goto err_put;
> +               efivar_ssdt_load();
>                 platform_device_register_simple("efivars", 0, NULL, 0);
>         }
>
> --
> 2.25.1
>

Thanks. Queued as a fix.
