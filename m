Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C5922056E
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jul 2020 08:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgGOGv0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Jul 2020 02:51:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgGOGv0 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 15 Jul 2020 02:51:26 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 574D32067D;
        Wed, 15 Jul 2020 06:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594795885;
        bh=5DttlarQkKvK74ioG6I0+VxDllg5IuyUP93tfyKyKgQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ng5t2TWJzvvsKlj8vhgNYrko2Y/LBVPSqVGt6VfuP/VXJ7kMpneB2xAI4nINZLpni
         yvIwA6yaxpVwOtzCVOBJThcMsykaZjhWnPvYCjF5SL3kSv294DMupYqxVwiZL2LL3J
         YOCbJDzS5uoJN1EmKaoSXNbV7qWobORB+Otw6uUs=
Received: by mail-ot1-f52.google.com with SMTP id 72so676849otc.3;
        Tue, 14 Jul 2020 23:51:25 -0700 (PDT)
X-Gm-Message-State: AOAM531m8UphKIayCokYP4DDUt4ccuU1249SGBxc4p5XDdaToAQiwOEb
        fnvz/cxkj6yD+c+Yrc4Bwj9+EKpOq3+CjJ5gWQM=
X-Google-Smtp-Source: ABdhPJyOUv8yAnl6wxEUDJ3G0ggCymhEObpRdn/b7PFU4YR6YIR4dFTpLKjM9DtkyVqwv4c8oWhWQAbWJrxM6qgMY9U=
X-Received: by 2002:a9d:7553:: with SMTP id b19mr7955857otl.77.1594795884664;
 Tue, 14 Jul 2020 23:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200715032631.1562882-1-nivedita@alum.mit.edu>
In-Reply-To: <20200715032631.1562882-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 15 Jul 2020 09:51:12 +0300
X-Gmail-Original-Message-ID: <CAMj1kXHzZAqHbqgJnrTjxtRvcVkpZan3LC6khFEucdR=cUhYfg@mail.gmail.com>
Message-ID: <CAMj1kXHzZAqHbqgJnrTjxtRvcVkpZan3LC6khFEucdR=cUhYfg@mail.gmail.com>
Subject: Re: [PATCH] arch/x86/boot: Don't add the EFI stub to targets
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     X86 ML <x86@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 15 Jul 2020 at 06:26, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> vmlinux-objs-y is added to targets, which currently means that the EFI
> stub gets added to the targets as well. It shouldn't be added since it
> is built elsewhere.
>
> This confuses Makefile.build which interprets the EFI stub as a target
>         $(obj)/$(objtree)/drivers/firmware/efi/libstub/lib.a
> and will create drivers/firmware/efi/libstub/ underneath
> arch/x86/boot/compressed, to hold this supposed target, if building
> out-of-tree. [0]
>
> Fix this by pulling the stub out of vmlinux-objs-y into efi-obj-y.
>
> [0] See scripts/Makefile.build near the end:
>     # Create directories for object files if they do not exist
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/x86/boot/compressed/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 7619742f91c9..5a828fde7a42 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -90,8 +90,8 @@ endif
>
>  vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
>
> -vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
> +efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
>
>  # The compressed kernel is built with -fPIC/-fPIE so that a boot loader
>  # can place it anywhere in memory and it will still run. However, since
> @@ -115,7 +115,7 @@ endef
>  quiet_cmd_check-and-link-vmlinux = LD      $@
>        cmd_check-and-link-vmlinux = $(cmd_check_data_rel); $(cmd_ld)
>
> -$(obj)/vmlinux: $(vmlinux-objs-y) FORCE
> +$(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
>         $(call if_changed,check-and-link-vmlinux)
>
>  OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
> --
> 2.26.2
>
