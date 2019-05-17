Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F214521576
	for <lists+linux-efi@lfdr.de>; Fri, 17 May 2019 10:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfEQIll (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 May 2019 04:41:41 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38461 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfEQIlk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 May 2019 04:41:40 -0400
Received: by mail-it1-f193.google.com with SMTP id i63so10720694ita.3
        for <linux-efi@vger.kernel.org>; Fri, 17 May 2019 01:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OzAD5c2YizDdXZbA4lFyJqsN3eVyddIrW3Cl6aBVZRg=;
        b=Xlq1AsNGys96BcJAGk3jRBqqXiqDnK5XJM67Eue97/ry1AF7IBdBuiWHQqQt8ybR72
         turN3fd11DHO0M++Ig3/ByLeWYX4w6mK480OfEHBndQywtZ/KxrBuBlRHPutEkc93JQh
         wS8DPbkSd+GU+EjD5Y1YzoWf/hFXsM4Ud1ZixydW7cqiHx50m2u3ifeFFg008+JfPufC
         DciS5AmnXx6+pmy3bzhFCOOrHD+rrMVtdLUrN9JxhVVJN8M8BbM5PgLBniecKgNHiydU
         Zyl7gY5mGVtybOTP6jrLwWU/H1nIlDEh7Tf9wDJJXDETE4WxisDYJckOZLcLPNPA71H8
         Qv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OzAD5c2YizDdXZbA4lFyJqsN3eVyddIrW3Cl6aBVZRg=;
        b=ogDbzvHlbnidIU7kN/uQzaVqyvDwHVmmyvV4VB848vnOlvPxxTWVdd3jHr3bhm39LZ
         dpAAObi41skmFREY5fQmDygYUmSYYbV6OLSfcraZxOyhOls3HrspfeMNZQ/HyfesX9uv
         oUExjsgCVGijrqYRTcoN9fsm3b9AlEVCXcj+9vGnQGARS4pFG65AOGFBk1qHINL9uCia
         2uCTQRFWJw8ZA4ncMYVE8n/xHQZdE9oELX7/bePOshWBQaVnYcz52aJ2SoMiBYnEcW9u
         XmqrSt6ysa76E66DKxQ8W6cJ1kqCySQNo7wOeGV4GqzYD7xjJXNBrYdoy2xppEjtGYdD
         uLlg==
X-Gm-Message-State: APjAAAXZ6STRtA+Bv93nY1WCP3emOhsyg3JDu4W0csRri3a9rMeVjKST
        VaNit2Irt9lulRec/H03P92gWSDJtg7jiZ6TVxZKpw==
X-Google-Smtp-Source: APXvYqxxG19vrc4zh9B8cysrofVDaZKTfnys80lHH5g51hp2fuu5wvhQpGmof7CNTeCpZzuD/GyqsNliegUDGmUlJpw=
X-Received: by 2002:a24:9fc5:: with SMTP id c188mr1592711ite.104.1558082499923;
 Fri, 17 May 2019 01:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190517082633.GA3890@zhanggen-UX430UQ>
In-Reply-To: <20190517082633.GA3890@zhanggen-UX430UQ>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 17 May 2019 10:41:28 +0200
Message-ID: <CAKv+Gu98JNK34Q6MNOe3aq0W5rbv6hUFiuc7cHxHJat5aTk_gg@mail.gmail.com>
Subject: Re: [PATCH] efi_64: Fix a missing-check bug in arch/x86/platform/efi/efi_64.c
 of Linux 5.1
To:     Gen Zhang <blackgod016574@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>
Cc:     Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Gen,

Thanks for the patch.

On Fri, 17 May 2019 at 10:26, Gen Zhang <blackgod016574@gmail.com> wrote:
>
> save_pgd is allocated by kmalloc_array. And it is dereferenced in the
> following codes. However, memory allocation functions such as
> kmalloc_array may fail. Dereferencing this save_pgd null pointer may
> cause the kernel go wrong. Thus we should check this allocation and add
> error handling code.
>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
>
> ---
> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index cf0347f..fb9ae57 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -91,6 +91,8 @@ pgd_t * __init efi_call_phys_prolog(void)
>
>         n_pgds = DIV_ROUND_UP((max_pfn << PAGE_SHIFT), PGDIR_SIZE);
>         save_pgd = kmalloc_array(n_pgds, sizeof(*save_pgd), GFP_KERNEL);
> +       if (!save_pgd)
> +               goto err;
>
>         /*
>          * Build 1:1 identity mapping for efi=old_map usage. Note that
> @@ -142,6 +144,9 @@ pgd_t * __init efi_call_phys_prolog(void)
>         __flush_tlb_all();
>
>         return save_pgd;
> +err:
> +       __flush_tlb_all();

What is the point of the goto and the TLB flush?

> +       return ERR_PTR(-ENOMEM);

Returning an error here is not going to make much difference, given
that the caller of efi_call_phys_prolog() does not bother to check it,
and passes the result straight into efi_call_phys_epilog(), which
happily attempts to dereference it.

So if you want to fix this properly, please fix it at the call site as
well. I'd prefer to avoid ERR_PTR() and just return NULL for a failed
allocation though.

>  }
>
>  void __init efi_call_phys_epilog(pgd_t *save_pgd)
> ---
