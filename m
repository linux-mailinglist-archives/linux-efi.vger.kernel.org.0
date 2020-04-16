Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10401ABA17
	for <lists+linux-efi@lfdr.de>; Thu, 16 Apr 2020 09:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439305AbgDPHiw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Apr 2020 03:38:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439282AbgDPHiu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 16 Apr 2020 03:38:50 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A38F220732;
        Thu, 16 Apr 2020 07:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587022728;
        bh=VV/3DC9vERvU4YrbpBLum76SN/pkTOMrb0l8+7m+IYc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=THez1ktQblEbH8mIOjliZ9nHegmEdCiCQOVY75ZyKMIONgngNQ3kLhYCOF/0qE3nL
         Kr2pWUkvMGr//TIo7flY+1AJ0u6LfKGLOKzRyVczRntnBOzY5OrMCZe7F8rY9K+xSz
         weDjNA049UXEK24cRxf1QWjTYH+GKtkLwk6TtoBA=
Received: by mail-il1-f181.google.com with SMTP id e4so6005785ils.4;
        Thu, 16 Apr 2020 00:38:48 -0700 (PDT)
X-Gm-Message-State: AGi0PuYwXGJyRBc4wwujuOIpq3S8aGaM+p82ne0wsDhAfkMkHMyMX0BV
        nU6s0Ls8v2dRIDBcEMusVgh8JSvkz2NhYB1iFMg=
X-Google-Smtp-Source: APiQypKwS2h8U391uzNKCmOqjuNNrE1w7gTx5KL56FsELQfE8h+3cnsyXXe3rqGBVOXTBgNa0YzocF8xftIYsai20hQ=
X-Received: by 2002:a92:c788:: with SMTP id c8mr9210476ilk.279.1587022728075;
 Thu, 16 Apr 2020 00:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200415221520.2692512-1-nivedita@alum.mit.edu> <20200415221520.2692512-6-nivedita@alum.mit.edu>
In-Reply-To: <20200415221520.2692512-6-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 16 Apr 2020 09:38:36 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFMMeYUPirY10JJfs31Z5GnHvUe=gLgG6SUJY9uWj588g@mail.gmail.com>
Message-ID: <CAMj1kXFMMeYUPirY10JJfs31Z5GnHvUe=gLgG6SUJY9uWj588g@mail.gmail.com>
Subject: Re: [PATCH 5/5] efi/x86: Check for bad relocations
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 16 Apr 2020 at 00:15, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Add relocation checking for x86 as well to catch non-PC-relative
> relocations that require runtime processing, since the EFI stub does not
> do any runtime relocation processing.
>
> This will catch, for example, data relocations created by static
> initializers of pointers.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  drivers/firmware/efi/libstub/Makefile | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 0bb2916eb12b..2aff59812a54 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -96,6 +96,8 @@ STUBCOPY_RELOC-$(CONFIG_ARM)  := R_ARM_ABS
>  # .bss section here so it's easy to pick out in the linker script.
>  #
>  STUBCOPY_FLAGS-$(CONFIG_X86)   += --rename-section .bss=.bss.efistub,load,alloc
> +STUBCOPY_RELOC-$(CONFIG_X86_32) := 'R_X86_32_(8|16|32)'

This should be R_386_xxx

> +STUBCOPY_RELOC-$(CONFIG_X86_64) := 'R_X86_64_(8|16|32|32S|64)'
>

... and in general, I think we only need the native pointer sized ones, so

R_386_32
R_X86_64_64

>  $(obj)/%.stub.o: $(obj)/%.o FORCE
>         $(call if_changed,stubcopy)
> @@ -107,16 +109,14 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
>  # this time, use objcopy and leave all sections in place.
>  #
>
> -cmd_stubrelocs_check-y = /bin/true
> -
> -cmd_stubrelocs_check-$(CONFIG_EFI_ARMSTUB) =                           \
> +cmd_stubrelocs_check =                                                 \
>         $(STRIP) --strip-debug -o $@ $<;                                \
> -       if $(OBJDUMP) -r $@ | grep $(STUBCOPY_RELOC-y); then            \
> +       if $(OBJDUMP) -r $@ | grep -E $(STUBCOPY_RELOC-y); then         \

... which means we don't need to -E either

>                 echo "$@: absolute symbol references not allowed in the EFI stub" >&2; \
>                 /bin/false;                                             \
>         fi
>
>  quiet_cmd_stubcopy = STUBCPY $@
>        cmd_stubcopy =                                                   \
> -       $(cmd_stubrelocs_check-y);                                      \
> +       $(cmd_stubrelocs_check);                                        \
>         $(OBJCOPY) $(STUBCOPY_FLAGS-y) $< $@
> --
> 2.24.1
>

Could we fold this into the previous x86 patch, and drop the one that
splits off the relocation check from stubcpy?
