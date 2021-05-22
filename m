Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAD738D5C1
	for <lists+linux-efi@lfdr.de>; Sat, 22 May 2021 14:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhEVMLG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 22 May 2021 08:11:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230360AbhEVMLG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 22 May 2021 08:11:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A73C61132;
        Sat, 22 May 2021 12:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621685381;
        bh=9T2kqkYRlBFg6M+r87a0QKtYHZee+OSyZCnhm0RwhGc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nmgbmj+vh/ZbFFsNqC0MYt5yDbsp4syhZCa1TykgmUDEMYPLOctzLoSSzNJEkmFoV
         WDL9XptsD8N0lsrE1Afbz0pfKppPcXQAf6Bte+e8NYpKzpKFsdnnkSZUsGdQyYF7YK
         dup7VyMk6kDSgldNsHMxOEAocyh4HwNAH9QqQAREj0wrE9aqhgQlIMMnp74JZDGLEx
         tFGEjFfQPWJZ6M2WJRREbA+F3WdmmRrYNSQdb3teQ9vIWpOMHHezfqOCJs7L+oAGlj
         NLUuWnM211fVvaA2wOaxwNFLQNQoU6Zt/dF4JjFhaKluG4xfj8tmwgXhybUfAyDgfB
         7zvUEMXmm2RKA==
Received: by mail-ot1-f49.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so20539894otp.4;
        Sat, 22 May 2021 05:09:41 -0700 (PDT)
X-Gm-Message-State: AOAM5303CyeEM19NAueyAs9bPlmvbDk5Lz0RfuDRU48OaGbLHY7tbmr1
        wAOAsnFpDrsa7onNEqt4/YRlz5urhlNPiKQ/9QQ=
X-Google-Smtp-Source: ABdhPJzuh0wK2buuGxkzuTx4IPfRmkUDwRgK2S+Q8boHOQBaDpcj40nLkeUsrnh0wLU5YjRaPIjHWPPk5bIHOm9Lxds=
X-Received: by 2002:a9d:69c5:: with SMTP id v5mr12105901oto.108.1621685380892;
 Sat, 22 May 2021 05:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210515081404.6334-1-pmenzel@molgen.mpg.de>
In-Reply-To: <20210515081404.6334-1-pmenzel@molgen.mpg.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 22 May 2021 14:09:29 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGCGysZCk59yMjsKWX5PcENvJnyv0nV12kGYObtjE3x3w@mail.gmail.com>
Message-ID: <CAMj1kXGCGysZCk59yMjsKWX5PcENvJnyv0nV12kGYObtjE3x3w@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: Log 32/64-bit mismatch with kernel as an error
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 15 May 2021 at 10:14, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Log the message
>
>     No EFI runtime due to 32/64-bit mismatch with kernel
>
> as an error condition, as several things like efivarfs won=E2=80=99t work
> without the EFI runtime.
>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  arch/x86/platform/efi/efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 8a26e705cb06..147c30a81f15 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -468,7 +468,7 @@ void __init efi_init(void)
>          */
>
>         if (!efi_runtime_supported())
> -               pr_info("No EFI runtime due to 32/64-bit mismatch with ke=
rnel\n");
> +               pr_err("No EFI runtime due to 32/64-bit mismatch with ker=
nel\n");
>
>         if (!efi_runtime_supported() || efi_runtime_disabled()) {
>                 efi_memmap_unmap();
> --
> 2.31.1
>

Queued up now, thanks.
