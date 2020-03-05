Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 490C517A077
	for <lists+linux-efi@lfdr.de>; Thu,  5 Mar 2020 08:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgCEHVC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Mar 2020 02:21:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:57204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbgCEHVC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 5 Mar 2020 02:21:02 -0500
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1F3C2166E
        for <linux-efi@vger.kernel.org>; Thu,  5 Mar 2020 07:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583392862;
        bh=sVCSyX5PL4idBbvN6Bl80w4Y0gYN/2UcaYOAik4CYMs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1xM12VVU64PzeUxBGuPI1GuS1ZczDqAskUpn6WAVIcdelQTFCGFqHgBYpmOMfN8r6
         2l8ANERzq66jKCEb/oox/K+KUqEqLPAU02S+zYHHk7a3XwHRDwjG94Ed3dpvgFO1aV
         i7wI7nrYBG/bWEXIeXA6DkoRv4ToxdJbX7LHJXG0=
Received: by mail-wm1-f41.google.com with SMTP id a5so4981985wmb.0
        for <linux-efi@vger.kernel.org>; Wed, 04 Mar 2020 23:21:01 -0800 (PST)
X-Gm-Message-State: ANhLgQ2Ll6FOQCfYMYsLerWahgrq9fCgZPwnnbR7JTySgukcqOQ+5Mud
        48xxfd7zoEsOPLS8Pl+jB0yfwznhp62aIkmY4SLT/A==
X-Google-Smtp-Source: ADFU+vvctrYy4m8EpCJoDAsfXsp0t7dPCLjO+yyjyEvxk5QgJYx3Js/UZ2wDqkfr4XlFhrcv6faNQh07nhMV/vxzlYY=
X-Received: by 2002:a7b:cb93:: with SMTP id m19mr8181328wmi.133.1583392859964;
 Wed, 04 Mar 2020 23:20:59 -0800 (PST)
MIME-Version: 1.0
References: <20200305055047.6097-1-masahiroy@kernel.org>
In-Reply-To: <20200305055047.6097-1-masahiroy@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 5 Mar 2020 08:20:49 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu8KfZZ_v-kUq=vwd+8MfhiOCpTG_AYA06bAuq7G-=c+WQ@mail.gmail.com>
Message-ID: <CAKv+Gu8KfZZ_v-kUq=vwd+8MfhiOCpTG_AYA06bAuq7G-=c+WQ@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: avoid linking libstub/lib-ksyms.o into vmlinux
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 5 Mar 2020 at 06:50, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> drivers/firmware/efi/libstub/Makefile is supposed to create a static
> library, which is not directly linked to vmlinux.
>

This is not true for arm64. Does that matter?

> Since commit 7f2084fa55e6 ("[kbuild] handle exports in lib-y objects
> reliably"), any Makefile using lib-y generates lib-ksyms.o which is
> linked into vmlinux.
>
> In this case, the following garbage object is linked into vmlinux.
>
>   drivers/firmware/efi/libstub/lib-ksyms.o
>
> We do not want to link anything from libstub/ directly to vmlinux,
> so using subdir-y instead of obj-y is the correct way to descend into
> this directory.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  drivers/firmware/efi/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> index 554d795270d9..4fd2fa02f549 100644
> --- a/drivers/firmware/efi/Makefile
> +++ b/drivers/firmware/efi/Makefile
> @@ -19,7 +19,7 @@ obj-$(CONFIG_EFI_VARS_PSTORE)         += efi-pstore.o
>  obj-$(CONFIG_UEFI_CPER)                        += cper.o
>  obj-$(CONFIG_EFI_RUNTIME_MAP)          += runtime-map.o
>  obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)     += runtime-wrappers.o
> -obj-$(CONFIG_EFI_STUB)                 += libstub/
> +subdir-$(CONFIG_EFI_STUB)              += libstub
>  obj-$(CONFIG_EFI_FAKE_MEMMAP)          += fake_map.o
>  obj-$(CONFIG_EFI_BOOTLOADER_CONTROL)   += efibc.o
>  obj-$(CONFIG_EFI_TEST)                 += test/
> --
> 2.17.1
>
