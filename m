Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B56E92C76F
	for <lists+linux-efi@lfdr.de>; Tue, 28 May 2019 15:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfE1NJw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 May 2019 09:09:52 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36889 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbfE1NJv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 May 2019 09:09:51 -0400
Received: by mail-io1-f65.google.com with SMTP id e5so6659560iok.4
        for <linux-efi@vger.kernel.org>; Tue, 28 May 2019 06:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3gMjgQF6nVEpAjnECu8ew++wo5leqfpmshMTC4gXxYo=;
        b=aQnbN08kY+fZnKaZkc6Jz47og1ZVNUJYTwBk+2rjH4tB794JCbcokx4ppHBUIfhYsh
         x//fmeBbsj76sAFoOntCBGhgDq0lg0eCxQjhB5H+wAklR3N252PW8ZUyDBrKeoaimS9t
         /Ox2+TFsUhYllJXGgVC6JyJ+DaEMHC0Kg+jPaUJYGudA3FULPTDB6fPZNZ8xDXa8ZzMU
         y7Z9PgOPmwhkHPsK9a48ubymnrRL4WFX1exKVXnTYk61mmswNcr85RK0bIFxXIuVGhKj
         VqVFNMYES/D/pvAA8wVV1XuSBNoC2B0rM3LB6koVQ9iBrfeFgHGsfWUHlTKRLDIftMEH
         hmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3gMjgQF6nVEpAjnECu8ew++wo5leqfpmshMTC4gXxYo=;
        b=iaXGOntwg0h1ZOV9iSDo+49FyZhkMRkSr4HSiXsz5gB5ZTB3bYJTwaeiy8Fm8N10+D
         48uE/tO0GPqsTOjIRMcWrnI+R+rjAIXLvTRRjrL+ev7YCxm0VhpCsgrp6ZfQCnUL4cbe
         RbSlxVuqotpvV0cDeM3jH9uCnhaX3pOru3JccPD++3Q+eRlrblRczvxc9/vOKmcc6MCI
         pbbRRX9JXN4y/D2W330HArKSS+LjBNTCS1w0gyWNyoqCwwddjeinSif0ggziSTYTSQ9/
         /8XLIujqDCXNGdiNho0qBYQ6f7G3ZrqZCodG6yCQEFbFPmdaQ2GzA63JV/nwfK5KD5w+
         aMhw==
X-Gm-Message-State: APjAAAWgH5YAJlOQBledQHD/n7lK0gdPdSnWKbeZB/MFVfUuYdaWAI/8
        aUQTYWTPGaSv/wRmXKOhfIpYC/McLeXuW//gWv6CTA==
X-Google-Smtp-Source: APXvYqz2NSY8Eub8B3tcZ0h/NOiXNc3gT/E67sal88UPCko5gQx0ik+z614GKA+mx2KpIkYqi6sIXUQFqE9LG/ygZX0=
X-Received: by 2002:a5d:968e:: with SMTP id m14mr38913390ion.49.1559048990760;
 Tue, 28 May 2019 06:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190528125805.2166-1-mail@lennart-glauer.de>
In-Reply-To: <20190528125805.2166-1-mail@lennart-glauer.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 28 May 2019 15:09:38 +0200
Message-ID: <CAKv+Gu8hXOLHLrBMJLYnDyW8xYhSHTAsNk6i034KA7gThjSpJQ@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: Free efi_pgd with free_pages()
To:     Lennart Glauer <mail@lennart-glauer.de>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Lennart,

Thanks for the patch.

On Tue, 28 May 2019 at 14:58, Lennart Glauer <mail@lennart-glauer.de> wrote:
>
> This patch fixes another occurrence of free_page() that was missed
> in 06ace26.

Please don't trim commit IDs like that. I think 12 digits is our
current minimum?

error: short SHA1 06ace26 is ambiguous
hint: The candidates are:
hint:   06ace26edc14 commit 2016-02-12 - staging: lustre: fix all NULL
comparisons in LNet layer
hint:   06ace26f4e6f commit 2018-03-22 - x86/efi: Free efi_pgd with free_pages()

> The efi_pgd is allocated as PGD_ALLOCATION_ORDER pages and therefore must
> also be freed as PGD_ALLOCATION_ORDER pages with free_pages().
>
> Signed-off-by: Lennart Glauer <mail@lennart-glauer.de>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Ingo, can you take this directly? I can't really test this anyway.


> ---
>  arch/x86/platform/efi/efi_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index 08ce8177c3af..acad22a44774 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -222,7 +222,7 @@ int __init efi_alloc_page_tables(void)
>         pgd = efi_pgd + pgd_index(EFI_VA_END);
>         p4d = p4d_alloc(&init_mm, pgd, EFI_VA_END);
>         if (!p4d) {
> -               free_page((unsigned long)efi_pgd);
> +               free_pages((unsigned long)efi_pgd, PGD_ALLOCATION_ORDER);
>                 return -ENOMEM;
>         }
>
> --
> 2.17.1
