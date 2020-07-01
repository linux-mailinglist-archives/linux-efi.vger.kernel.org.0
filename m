Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E76A210F16
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jul 2020 17:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbgGAPZR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jul 2020 11:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731715AbgGAPZR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 1 Jul 2020 11:25:17 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F0D820899;
        Wed,  1 Jul 2020 15:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593617116;
        bh=yRmjzMu9YWj+NOLepjKm+aB0pjmOhF8mZmELt36mcA0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YAjxA7qonfZicJTji5t6KrKshQc8SIIF1shTK/aOyeWiOJNB3+/YbRLfQA+BaC+qM
         PJFwrSlA2jr7+HlaJAsBbo8TrE2pGeqol7bAH3Z1awMtGP8LQJJTZ1Nq1WrjvHz+bC
         KU+tCPmVN0Du4tkFI1t50hITsOEHx26RR25GMYZs=
Received: by mail-yb1-f169.google.com with SMTP id o4so12184547ybp.0;
        Wed, 01 Jul 2020 08:25:16 -0700 (PDT)
X-Gm-Message-State: AOAM530INUP0sylri8YwAYPWl2swvYGLZkkXBs9OJBfPpra4HtfLv1gb
        0Xb8Ske1/ItWj4EbawTuQvW4SRvdb+I9ldDlLjA=
X-Google-Smtp-Source: ABdhPJy9AKnU7TLcunRsA3LE7E5ZGLLHAN/4GGZWVlhQ9VRoyei2I2CxfreGz6IXtL350r2vzowvmiQuGW9yiXJrzBc=
X-Received: by 2002:a9d:4a8f:: with SMTP id i15mr24502977otf.77.1593617115444;
 Wed, 01 Jul 2020 08:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200701141731.377252388@hpe.com> <20200701141732.706351085@hpe.com>
In-Reply-To: <20200701141732.706351085@hpe.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 1 Jul 2020 17:25:04 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE63uh2QhN1mrdSjwNM6yQqM7EY1kRnLBEmdeLovXYmSQ@mail.gmail.com>
Message-ID: <CAMj1kXE63uh2QhN1mrdSjwNM6yQqM7EY1kRnLBEmdeLovXYmSQ@mail.gmail.com>
Subject: Re: [patch 10/13] Delete SGI UV1 detection.
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oliver Neukum <oneukum@suse.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Young <dyoung@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Austin Kim <austindh.kim@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Russ Anderson <rja@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 1 Jul 2020 at 16:18, <steve.wahl@hpe.com> wrote:
>
> As a part of UV1 platform removal, don't try to recognize the platform
> through DMI to set the EFI_UV1_MEMMAP bit.
>
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/x86/platform/efi/quirks.c |   23 -----------------------
>  1 file changed, 23 deletions(-)
>
> --- linux.orig/arch/x86/platform/efi/quirks.c   2020-06-17 14:29:45.510015978 -0500
> +++ linux/arch/x86/platform/efi/quirks.c        2020-06-17 14:36:34.473414139 -0500
> @@ -558,16 +558,6 @@ out:
>         return ret;
>  }
>
> -static const struct dmi_system_id sgi_uv1_dmi[] __initconst = {
> -       { NULL, "SGI UV1",
> -               {       DMI_MATCH(DMI_PRODUCT_NAME,     "Stoutland Platform"),
> -                       DMI_MATCH(DMI_PRODUCT_VERSION,  "1.0"),
> -                       DMI_MATCH(DMI_BIOS_VENDOR,      "SGI.COM"),
> -               }
> -       },
> -       { } /* NULL entry stops DMI scanning */
> -};
> -
>  void __init efi_apply_memmap_quirks(void)
>  {
>         /*
> @@ -579,17 +569,6 @@ void __init efi_apply_memmap_quirks(void
>                 pr_info("Setup done, disabling due to 32/64-bit mismatch\n");
>                 efi_memmap_unmap();
>         }
> -
> -       /* UV2+ BIOS has a fix for this issue.  UV1 still needs the quirk. */
> -       if (dmi_check_system(sgi_uv1_dmi)) {
> -               if (IS_ENABLED(CONFIG_X86_UV)) {
> -                       set_bit(EFI_UV1_MEMMAP, &efi.flags);
> -               } else {
> -                       pr_warn("EFI runtime disabled, needs CONFIG_X86_UV=y on UV1\n");
> -                       clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
> -                       efi_memmap_unmap();
> -               }
> -       }
>  }
>
>  /*
> @@ -723,8 +702,6 @@ void efi_recover_from_page_fault(unsigne
>
>         /*
>          * Make sure that an efi runtime service caused the page fault.
> -        * "efi_mm" cannot be used to check if the page fault had occurred
> -        * in the firmware context because the UV1 memmap doesn't use efi_pgd.
>          */
>         if (efi_rts_work.efi_rts_id == EFI_NONE)
>                 return;
>
