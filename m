Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263331D615E
	for <lists+linux-efi@lfdr.de>; Sat, 16 May 2020 15:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgEPNci (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 May 2020 09:32:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbgEPNci (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 16 May 2020 09:32:38 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56FDF20756;
        Sat, 16 May 2020 13:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589635957;
        bh=x1VGZVD7JGuiKj+pm+HBOm+dMp8uyqR2Xs7eyZmYtX4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jq32bZbZekzVa1GAPKdO2LRSd+nc0x5YDr+1/UhyuFOgqt0u/a81Xv6+YQbmq8vgM
         VBnnHqYqcZnR4uMtkmfQHhvjZtpOUe0rltSAoZC7pQXgfrNGDaXFlIV/9ojvGMzMxA
         ixyEDjxSOoxDBzUy66fyuZi71PMbUMzGpvtK3uWU=
Received: by mail-io1-f46.google.com with SMTP id 79so5688333iou.2;
        Sat, 16 May 2020 06:32:37 -0700 (PDT)
X-Gm-Message-State: AOAM530vLaTayoVP6DrHZEBFgf9k2cGGcALtzcZRthrOiePF1fk3iGLI
        mLpR//b2tdpeDDKc29UVlAwR+wd6KBYXHFpL+QY=
X-Google-Smtp-Source: ABdhPJxWGyhi7A2kw6W8vFsxwjOhMuibfVYxiaEbSTGyMnYSnZ8x4lljptFeXbyr/Xcekzla4fZWO4yJmCHKRguI+e0=
X-Received: by 2002:a02:6a1e:: with SMTP id l30mr7419565jac.98.1589635956707;
 Sat, 16 May 2020 06:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200516132647.14568-1-b.thiel@posteo.de>
In-Reply-To: <20200516132647.14568-1-b.thiel@posteo.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 16 May 2020 15:32:25 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE92_hmbaNURjW9FuRo02B9my1UBBUhPZi_CS+FRr8-aw@mail.gmail.com>
Message-ID: <CAMj1kXE92_hmbaNURjW9FuRo02B9my1UBBUhPZi_CS+FRr8-aw@mail.gmail.com>
Subject: Re: [PATCH v2] efi: Pull up arch-specific prototype efi_systab_show_arch()
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

On Sat, 16 May 2020 at 15:26, Benjamin Thiel <b.thiel@posteo.de> wrote:
>
> ... in order to fix a -Wmissing-prototypes warning:
>
> arch/x86/platform/efi/efi.c:957:7: warning: no previous prototype for
> =E2=80=98efi_systab_show_arch=E2=80=99 [-Wmissing-prototypes]
> char *efi_systab_show_arch(char *str)
>
> Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>

Thanks, I'll queue this as a fix.

Nit: please don't treat the subject line as the first N words of the
commit log, but start with a full sentence. Not all mail readers show
the subject line and the body together. I've fixed it up for now.



> ---
>  drivers/firmware/efi/efi.c | 5 +----
>  include/linux/efi.h        | 2 ++
>  2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 911a2bd0f6b7..4e3055238f31 100644
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
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 251f1f783cdf..9430d01c0c3d 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1245,4 +1245,6 @@ struct linux_efi_memreserve {
>
>  void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size);
>
> +char *efi_systab_show_arch(char *str);
> +
>  #endif /* _LINUX_EFI_H */
> --
> 2.20.1
>
