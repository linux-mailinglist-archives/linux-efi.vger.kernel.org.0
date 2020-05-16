Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72911D612D
	for <lists+linux-efi@lfdr.de>; Sat, 16 May 2020 15:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgEPNBm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 May 2020 09:01:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgEPNBl (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 16 May 2020 09:01:41 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCC66207C3;
        Sat, 16 May 2020 13:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589634100;
        bh=aUSKYU0EFvXVvbVk/E1SoQBPYzwwjWSjSu2T1APZSEQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KNM4sYZUQ6491jPPl5VQCVzfKDYAh+TUjvhKuta5vjnW4R0RH6/694dwHEeuAF4So
         HjQdarNfe8RFtjIJ9kkb1qxMo9KFMijDLSUbUJ8D6o5CLfQlsjtmA7WiEpq+jZl6m2
         cLmoL689cOiVnQV8UcYrbqPvIR6uKgb6UetiAQKo=
Received: by mail-il1-f181.google.com with SMTP id b15so5244911ilq.12;
        Sat, 16 May 2020 06:01:40 -0700 (PDT)
X-Gm-Message-State: AOAM531Xhi4m/naqBTyx8N3DOXjrMzzcZSTBQTFzXm1OHH3tZq0aa75m
        ZScr3uNU6qzY/YrvIqa3zg/fzcI3I78iBfFryjM=
X-Google-Smtp-Source: ABdhPJxpHqXqjze2yvSnonUIIODhpCpJSXCXFjp0ujBwNiEbn9oulBsuCxK8ZoNCzU3FMBkB6OEybcxg3eITwgK2S+w=
X-Received: by 2002:a92:a312:: with SMTP id a18mr8081838ili.80.1589634100230;
 Sat, 16 May 2020 06:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200516125948.3459-1-b.thiel@posteo.de>
In-Reply-To: <20200516125948.3459-1-b.thiel@posteo.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 16 May 2020 15:01:29 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH-NC1=gkKkDTGp-TFzMEVPT4txud4BDUv4UA4YGTYQ6Q@mail.gmail.com>
Message-ID: <CAMj1kXH-NC1=gkKkDTGp-TFzMEVPT4txud4BDUv4UA4YGTYQ6Q@mail.gmail.com>
Subject: Re: [PATCH] efi: Pull up arch-specific prototype efi_systab_show_arch()
To:     Benjamin Thiel <b.thiel@posteo.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Benjamin,

Thanks for the fix. Comments below.

On Sat, 16 May 2020 at 14:59, Benjamin Thiel <b.thiel@posteo.de> wrote:
>
> ... in order to fix a -Wmissing-prototypes warning:
>
> arch/x86/platform/efi/efi.c:957:7: warning: no previous prototype for
> =E2=80=98efi_systab_show_arch=E2=80=99 [-Wmissing-prototypes]
> char *efi_systab_show_arch(char *str)
>
> Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
> ---
>  drivers/firmware/efi/efi.c | 7 ++-----
>  include/linux/efi.h        | 4 ++++
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 911a2bd0f6b7..d3e7ce6f1027 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -130,11 +130,8 @@ static ssize_t systab_show(struct kobject *kobj,
>         if (efi.smbios !=3D EFI_INVALID_TABLE_ADDR)
>                 str +=3D sprintf(str, "SMBIOS=3D0x%lx\n", efi.smbios);
>
> -       if (IS_ENABLED(CONFIG_IA64) || IS_ENABLED(CONFIG_X86)) {
> -               extern char *efi_systab_show_arch(char *str);
> -
> +       if (IS_ENABLED(CONFIG_IA64) || IS_ENABLED(CONFIG_X86))
>                 str =3D efi_systab_show_arch(str);
> -       }
>
>         return str - buf;
>  }
> @@ -1012,4 +1009,4 @@ static int __init register_update_efi_random_seed(v=
oid)
>         return register_reboot_notifier(&efi_random_seed_nb);
>  }
>  late_initcall(register_update_efi_random_seed);
> -#endif
> +#endifefi_systab_show_arch
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 251f1f783cdf..e47dae8c8d5f 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1245,4 +1245,8 @@ struct linux_efi_memreserve {
>
>  void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size);
>
> +#if defined(CONFIG_IA64) || defined(CONFIG_X86)

Please drop this conditional

> +extern char *efi_systab_show_arch(char *str);

and please drop the 'extern' as well - it is redundant for functions.

> +#endif
> +
>  #endif /* _LINUX_EFI_H */
> --
> 2.20.1
>
