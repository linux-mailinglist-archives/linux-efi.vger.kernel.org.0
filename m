Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF36B29BC9
	for <lists+linux-efi@lfdr.de>; Fri, 24 May 2019 18:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389902AbfEXQHX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 May 2019 12:07:23 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36083 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389831AbfEXQHW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 May 2019 12:07:22 -0400
Received: by mail-it1-f195.google.com with SMTP id e184so14612131ite.1
        for <linux-efi@vger.kernel.org>; Fri, 24 May 2019 09:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F51aUjlAcqEydtw/abs3ans4pwxkW6lbFz/6ZM6GbTY=;
        b=qpMoa01Nr6q98RY9URswE31bXIom/0XVP8pqvsALmpMM+lROv9SlDc/sFfcFS9f+lb
         7NSkiPcVnyTEWYQgvqGTDVilgbIM+pxgO5gSWljvE8YzbuTIXsajSA3nRpgSwfTeWKl/
         2Sv8jFS0JOZ/6D7nKvCzZYm0eGDkRRdpwU6E6qsMMcn9bS+jeZByzO+H+9nJSpuHY0N8
         YjwSNbcjr1ZfxRSMaSq8UrGeP4ksjiqynFtkLWPrn8A/KdYUSBJZ0Pww0ha7dx1ILssU
         pXYrVHaxp+WZvevnABkNklvmiy0gaYvXAh54CaS5Exs9uMvu49yNQGejtfSEg9fkAlxn
         TQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F51aUjlAcqEydtw/abs3ans4pwxkW6lbFz/6ZM6GbTY=;
        b=g/DwESdlCd0FsIGE87rKewmIVnMmhXXmE1KJbdm/GipEklP1pjShd5uOwd7UW/mjjL
         Yxqh1GRWsfKlp7vVJlbZGBr0tMH7HR/N/3Fqr30mBEiaHLBCtgwVeCloJ8RWfa8rB695
         5TCURZU3AhbWAYornFFnhy3pIek89nnrjlwx8z93piCOekM957oTEhGyn3xotY1Fv6ZR
         ofm7Uq7aFy8d9PqH0JV1cnXQLjqfWXeYF9by3YkM0QaNdy4ZunktZdzSB57+y1c2e5lO
         hso2q8KdB/HiwhEXZYX76WUI7dIn7nrxxcRIwtvbvSMbkWcD7VpaEi0xcPa7D2JeN3X0
         h2Bg==
X-Gm-Message-State: APjAAAWvi4pFm2oAjGGC/bW5s2PlYIjKf1PKBjSLRGPtmUDpYF3uwht2
        vUrPYdxBSUm8gGUYsKvy62gGi2QvBNvHufdcmkzaQQ==
X-Google-Smtp-Source: APXvYqwWGKSkuIwcjfo3DOKE37Iaan3beO3UWxqHzJZRo2ZSSoO3FCyCbj6drihvINLMWgP9KLmQfsYCCKGIkYN8qU0=
X-Received: by 2002:a02:a494:: with SMTP id d20mr4001601jam.62.1558714042097;
 Fri, 24 May 2019 09:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190517082633.GA3890@zhanggen-UX430UQ> <CAKv+Gu98JNK34Q6MNOe3aq0W5rbv6hUFiuc7cHxHJat5aTk_gg@mail.gmail.com>
 <20190517090628.GA4162@zhanggen-UX430UQ> <CAKv+Gu_mwFpdtNZm9QMFn69+vOMTOpv9gvuhnBL2NBXvwkhXqg@mail.gmail.com>
 <20190523005133.GA14881@zhanggen-UX430UQ>
In-Reply-To: <20190523005133.GA14881@zhanggen-UX430UQ>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 24 May 2019 18:07:10 +0200
Message-ID: <CAKv+Gu_wRYZdDYXso0B5m_BPJznGQXpCWq4_0u34bConu0V1ow@mail.gmail.com>
Subject: Re: [PATCH v2] efi_64: Fix a missing-check bug in arch/x86/platform/efi/efi_64.c
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 23 May 2019 at 02:51, Gen Zhang <blackgod016574@gmail.com> wrote:
>
> In efi_call_phys_prolog(), save_pgd is allocated by kmalloc_array().
> And it is dereferenced in the following codes. However, memory
> allocation functions such as kmalloc_array() may fail. Dereferencing
> this save_pgd null pointer may cause the kernel go wrong. Thus we
> should check this allocation.
> Further, if efi_call_phys_prolog() returns NULL, we should abort the
> process in phys_efi_set_virtual_address_map(), and return EFI_ABORTED.
>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
>
> ---
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index e1cb01a..a7189a3 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -85,6 +85,8 @@ static efi_status_t __init phys_efi_set_virtual_address_map(
>         pgd_t *save_pgd;
>
>         save_pgd = efi_call_phys_prolog();
> +       if (!save_pgd)
> +               return EFI_ABORTED;
>
>         /* Disable interrupts around EFI calls: */
>         local_irq_save(flags);
> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index cf0347f..828460a 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -91,6 +91,8 @@ pgd_t * __init efi_call_phys_prolog(void)
>
>         n_pgds = DIV_ROUND_UP((max_pfn << PAGE_SHIFT), PGDIR_SIZE);
>         save_pgd = kmalloc_array(n_pgds, sizeof(*save_pgd), GFP_KERNEL);
> +       if (!save_pgd)
> +               return NULL;
>
>         /*
>          * Build 1:1 identity mapping for efi=old_map usage. Note that
> ---

Apologies for only spotting this now, but I seem to have given some bad advice.

efi_call_phys_prolog() in efi_64.c will also return NULL if
(!efi_enabled(EFI_OLD_MEMMAP)), but this is not an error condition. So
that occurrence has to be updated: please return efi_mm.pgd instead.
