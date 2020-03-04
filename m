Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1149B17981A
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 19:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbgCDSji (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 13:39:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:59868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgCDSjh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Mar 2020 13:39:37 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE5AA20866
        for <linux-efi@vger.kernel.org>; Wed,  4 Mar 2020 18:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583347177;
        bh=9tGRcQmnCs+8mBc+xsHARFOn6Shor2qdv6a+qSVcbqI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vfDJA7Dd3AwkFhExwp4eYq1KDYgYgYvgeUxyYNXoaJ1LDiC039PR0+4wSrkRF4Fjx
         6MG4vqMW82SCJ5qxc9mivHWIYRQBl2CU0BDyvfXSP5WUdRaWxzb6f8snhNB5r1BuuW
         ddUaL7O+Nf8DBtQGYXe04o2dcg22IoWVPROPwFQU=
Received: by mail-wm1-f43.google.com with SMTP id p9so3343702wmc.2
        for <linux-efi@vger.kernel.org>; Wed, 04 Mar 2020 10:39:36 -0800 (PST)
X-Gm-Message-State: ANhLgQ3Om5yKoPv5YXXUmIIRfa6Psz4wcZfimQp37+XAKZJDhcae4acN
        v8xshs3ro+IUKN3ryjcQ5Ob93RcCbG5f0fOzIu9ftw==
X-Google-Smtp-Source: ADFU+vttxjU/Y73QEBY17H75MYW46EApWec4EeV3gpG4CFPchH5eoJU4xLG4yiIpoTbkLzMnTlREglqTaF0Dh20Bf3o=
X-Received: by 2002:a05:600c:24b:: with SMTP id 11mr4758988wmj.1.1583347175359;
 Wed, 04 Mar 2020 10:39:35 -0800 (PST)
MIME-Version: 1.0
References: <20200304183659.257828-1-nivedita@alum.mit.edu>
In-Reply-To: <20200304183659.257828-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 4 Mar 2020 19:39:23 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_Bc5WYG_D7cM_fPi8rV65ouEre8uYUck0FCxN9FSUopw@mail.gmail.com>
Message-ID: <CAKv+Gu_Bc5WYG_D7cM_fPi8rV65ouEre8uYUck0FCxN9FSUopw@mail.gmail.com>
Subject: Re: [PATCH] efi/x86: Move mixed-mode thunk to efi/libstub
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 4 Mar 2020 at 19:37, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Commit c2d0b470154c ("efi/libstub/x86: Incorporate eboot.c into
> libstub") moved all the callers of the mixed-mode thunk into
> efi/libstub, so move the thunk itself as well for completeness.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Thanks for the patch, but I'd prefer to leave the .S pieces under arch/
(unless there's some benefit I'm not seeing)

> ---
>  arch/x86/boot/compressed/Makefile                                | 1 -
>  drivers/firmware/efi/libstub/Makefile                            | 1 +
>  .../firmware/efi/libstub/x86_64-thunk.S                          | 0
>  3 files changed, 1 insertion(+), 1 deletion(-)
>  rename arch/x86/boot/compressed/efi_thunk_64.S => drivers/firmware/efi/libstub/x86_64-thunk.S (100%)
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index e51879bdc51c..047004d39a55 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -88,7 +88,6 @@ endif
>  vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
>
>  vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> -vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
>
>  # The compressed kernel is built with -fPIC/-fPIE so that a boot loader
>  # can place it anywhere in memory and it will still run. However, since
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 4d6246c6f651..85b66e5e5d1f 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -55,6 +55,7 @@ lib-$(CONFIG_EFI_ARMSTUB)     += arm-stub.o fdt.o string.o \
>  lib-$(CONFIG_ARM)              += arm32-stub.o
>  lib-$(CONFIG_ARM64)            += arm64-stub.o
>  lib-$(CONFIG_X86)              += x86-stub.o
> +lib-$(CONFIG_EFI_MIXED)                += x86_64-thunk.o
>  CFLAGS_arm32-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
>  CFLAGS_arm64-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
>
> diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/drivers/firmware/efi/libstub/x86_64-thunk.S
> similarity index 100%
> rename from arch/x86/boot/compressed/efi_thunk_64.S
> rename to drivers/firmware/efi/libstub/x86_64-thunk.S
> --
> 2.24.1
>
