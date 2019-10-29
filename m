Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC5F2E8FC0
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2019 20:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbfJ2TOc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Oct 2019 15:14:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58556 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730743AbfJ2TOc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 29 Oct 2019 15:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572376471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nxayejYSVXr47U447mSkKDwpy7jX9q8NIi6Fc4NbQBc=;
        b=DO1hZp2rjjvGs0jb/saN3Upvu+3I57KcitSChkmaHYFCzWvmrMpmhjglL/wfI7B2FF/bwh
        Q4ADd1EqsE0IKPHgmeZeqLippB+3uN9FjtnbxzKVKIyGhOHTIkEP8P17C2IyL+pycV2Csn
        HmYA+tCZgpoeOFwz+723SuMVnUzaipA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-D66aXY2-Nw-SymNVYgXhfg-1; Tue, 29 Oct 2019 15:14:29 -0400
Received: by mail-lj1-f200.google.com with SMTP id i27so2896733ljb.17
        for <linux-efi@vger.kernel.org>; Tue, 29 Oct 2019 12:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwzekU6FTVb4WJ1KYylvE2Fm3CGIkd3DwRcFLlZGbuw=;
        b=g/H0C5KZa0PafAmE6t6Q/VSjY6afEj/JVltC3oVSaJa37UOA+LKILCyxzOamOtR5ph
         FHk7Mww/BqUluZ7WB6noS+yYzUP/fvRbRf2FrM387Qid2Y3JhnPlsyXJ/kfiBtoi9nlT
         5UsqCs77VJc7x7aLhedlTkVYC/eQIjxBOEtGuFGpBeExb6KF/Ha4MTADJy+tSgA9tLfW
         zqdnlFz5IumljhORtHNUAXjXZr+cT8K2DnKzk9KuyxYliKnhECNw0CxGFyGkydlFlq86
         3B4tpsZZkb3KtWq1Hgfrd1KhXW/tEYyeVavAc/lROYQJDegK8d3NghlAnq5iMNOeSYlj
         sJlA==
X-Gm-Message-State: APjAAAWAM+WB/3UY1EUJIilwAVchCSm6+tbGBFDPA1Koc4d3cfYQscmo
        MHAc+icBemKraXUJZIKq6xxTP9QSXH1uj83L0ey95EXXA3ESTUe7M06LLj9JYP2IH/QcpxzrvDp
        vzU75Ipy5xBAeBBZRRn/cRGug3NvsShgmBR0C
X-Received: by 2002:a19:ac04:: with SMTP id g4mr3546577lfc.63.1572376467656;
        Tue, 29 Oct 2019 12:14:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyB0C3Ii5OEJM05OMOUAAZ49o0SiI0p8Oyn3T8k9fDZCZX9ZMdZD7rNOLGdjhWiT4TOIpbqxNY+7kioHW7fcD4=
X-Received: by 2002:a19:ac04:: with SMTP id g4mr3546566lfc.63.1572376467423;
 Tue, 29 Oct 2019 12:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191029173755.27149-1-ardb@kernel.org> <20191029173755.27149-4-ardb@kernel.org>
In-Reply-To: <20191029173755.27149-4-ardb@kernel.org>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Wed, 30 Oct 2019 00:44:14 +0530
Message-ID: <CACi5LpMAagnn_yEmqRBGfxJFZcAUzohU30NACeGvdXaHFZwAMA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] efi/random: treat EFI_RNG_PROTOCOL output as
 bootloader randomness
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-MC-Unique: D66aXY2-Nw-SymNVYgXhfg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Tue, Oct 29, 2019 at 11:10 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> From: Dominik Brodowski <linux@dominikbrodowski.net>
>
> Commit 428826f5358c ("fdt: add support for rng-seed") introduced
> add_bootloader_randomness(), permitting randomness provided by the
> bootloader or firmware to be credited as entropy. However, the fact
> that the UEFI support code was already wired into the RNG subsystem
> via a call to add_device_randomness() was overlooked, and so it was
> not converted at the same time.
>
> Note that this UEFI (v2.4 or newer) feature is currently only
> implemented for EFI stub booting on ARM, and further note that
> CONFIG_RANDOM_TRUST_BOOTLOADER must be enabled, and this should be
> done only if there indeed is sufficient trust in the bootloader
> _and_ its source of randomness.
>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> [ardb: update commit log]
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Seems my Tested-by was dropped which I provide for the RFC version of
this patch.
See <https://www.mail-archive.com/linux-efi@vger.kernel.org/msg12281.html>
for details.

I can provide a similar Tested-by for this version as well.

Thanks,
Bhupesh


> ---
>  drivers/firmware/efi/efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 69f00f7453a3..e98bbf8e56d9 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -554,7 +554,7 @@ int __init efi_config_parse_tables(void *config_table=
s, int count, int sz,
>                                               sizeof(*seed) + size);
>                         if (seed !=3D NULL) {
>                                 pr_notice("seeding entropy pool\n");
> -                               add_device_randomness(seed->bits, seed->s=
ize);
> +                               add_bootloader_randomness(seed->bits, see=
d->size);
>                                 early_memunmap(seed, sizeof(*seed) + size=
);
>                         } else {
>                                 pr_err("Could not map UEFI random seed!\n=
");
> --
> 2.17.1
>

