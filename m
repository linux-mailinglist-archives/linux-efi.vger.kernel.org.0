Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DD9210F0E
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jul 2020 17:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731679AbgGAPYf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jul 2020 11:24:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731586AbgGAPYe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 1 Jul 2020 11:24:34 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEC7C208A7;
        Wed,  1 Jul 2020 15:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593617073;
        bh=bO7Ihk/HS0/rvZ7NgpWVL3v41vS9CJ7TR7JSULgWAG4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KBL0tXamRa5xkBoTIymtjt/03noo1ylOoJa5IigXxtOy5W8cppvG2KmA3uheBWNVy
         vUAgIzb8vmID0j0E/WfZc8Ih5Ipyx0BeEcdzCLKQ1f8cyAcjiMpBrd6nrI3r7XWviG
         x+rVZ1tswlB0NS+QU/cYjjrCBiuLtwa/iAlGW4Uo=
Received: by mail-oi1-f175.google.com with SMTP id k4so20934623oik.2;
        Wed, 01 Jul 2020 08:24:33 -0700 (PDT)
X-Gm-Message-State: AOAM531ZurMrboFIkVXNjHUskAtL2DYGUxTp5XMEdw1e7AtvcTHveNtE
        si1KeO49k+SF9BcvqLGzRaJ+fLu7xv2Nz+4WRdM=
X-Google-Smtp-Source: ABdhPJy1cz/ShrBpq94SUsalWMM/TfrGll8oCwZKb3ypsLE5U8A8cjgi0RPJTWJ83of+OTvxTXrQftDnUbA11/sSQTw=
X-Received: by 2002:aca:f257:: with SMTP id q84mr6640957oih.174.1593617072798;
 Wed, 01 Jul 2020 08:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200701141731.377252388@hpe.com> <20200701141732.581935948@hpe.com>
In-Reply-To: <20200701141732.581935948@hpe.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 1 Jul 2020 17:24:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFm+HVORRtTWJtVKorE8rDJGi6FDOr2ZXSA3+ZG4u=LnQ@mail.gmail.com>
Message-ID: <CAMj1kXFm+HVORRtTWJtVKorE8rDJGi6FDOr2ZXSA3+ZG4u=LnQ@mail.gmail.com>
Subject: Re: [patch 09/13] Remove efi=old_map command line option
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
> As a part of UV1 platform removal, delete the efi=old_map option,
> which should no longer be needed.
>
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>

Noting that the diffstat does not reflect the patch, but this is
explained in the cover letter.

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  Documentation/admin-guide/kernel-parameters.txt |    4 +---
>  arch/x86/platform/uv/bios_uv.c                  |   14 --------------
>  2 files changed, 1 insertion(+), 17 deletions(-)
>
> --- linux.orig/arch/x86/platform/uv/bios_uv.c   2020-06-18 16:26:33.963087219 -0500
> +++ linux/arch/x86/platform/uv/bios_uv.c        2020-06-25 09:53:43.013835162 -0500
> @@ -356,17 +356,3 @@ void __iomem *__init efi_ioremap(unsigne
>
>         return (void __iomem *)__va(phys_addr);
>  }
> -
> -static int __init arch_parse_efi_cmdline(char *str)
> -{
> -       if (!str) {
> -               pr_warn("need at least one option\n");
> -               return -EINVAL;
> -       }
> -
> -       if (!efi_is_mixed() && parse_option_str(str, "old_map"))
> -               set_bit(EFI_UV1_MEMMAP, &efi.flags);
> -
> -       return 0;
> -}
> -early_param("efi", arch_parse_efi_cmdline);
>
