Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D2C1C4670
	for <lists+linux-efi@lfdr.de>; Mon,  4 May 2020 20:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgEDSy2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 4 May 2020 14:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725981AbgEDSy2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 4 May 2020 14:54:28 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076D5C061A0E
        for <linux-efi@vger.kernel.org>; Mon,  4 May 2020 11:54:28 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id a4so266528pgc.0
        for <linux-efi@vger.kernel.org>; Mon, 04 May 2020 11:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WF2Nx60Nb0TFwjbqt9jYYkxk4UjZBSwB8vrR9NKUEjI=;
        b=FgSwhm2K95SYTGITI3XE05bR0yuOAWelpL1zVjzJEh9IifCnZlwmA2GJXgSQmWiU8U
         7oiGBMx5UdLFFjTkrtSSOxQzrpqsd78PV1rjUWgqQHokfboMko8USbg+tM/1Ds8EY6cw
         SccoFp0PQqp6Jbeu7SrTUj+JtcajXb0Kc04YIYoSXhREm6Aja6SuvtHt+VB5RWYLSWeC
         pyvjNtpmcP2q4kDc/s+qWQxgkmYWS8PF7EQVVu/aZJ+jA9xT22AYdUflNxtgUkN+T6Kb
         MejxELf87GI2yjXj2sKR9tI7F1UUd7AsxtdkmfMYtSg25GwOYGl0JmfOLf9TEk4bVujA
         ZvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WF2Nx60Nb0TFwjbqt9jYYkxk4UjZBSwB8vrR9NKUEjI=;
        b=GGWjuUm5ueEJzvlaIncUD6SKMmcjnboOp1+pXwEUCOr9QrzlTrSMdqx6PM30AbeKhc
         LsvN47QeKdiJQSkA60+tW5QsKiOkIhlaHh7vODqGQZQJZMSGySxxVkV0iRWMZ/+pI+ew
         Mn6ErYemBoSkiTguAYe08qAI0TkC5F0SUWWzx5KoYNugk+g4oMXwsRwnB2cnfPuFihXR
         o0l0hY8LSgc9FdUdI/qpeYUkfd3tmvqxIM+zbrj8ASk8+8wKe2GTxbFhrw9KwcQ7y0Id
         LXalvPopfBT95DNPx8IybfnPlH4wyASq4CmCNJIo8Iq1Idi+VkAU2qf2P5ecnDDXArHd
         wD+w==
X-Gm-Message-State: AGi0PuZSbI/3j04e3jeiAs0+t3s0RAqCeWV5UDvTNT2C2hGLADVYWkZX
        OuYX1xog5srPLsB1eLD0VeBSqog5Gi0sNVYS3+k7nQ==
X-Google-Smtp-Source: APiQypKk8oIeMsCv1rLL868zbFhLNQLGwWQY83aPhkPZswCuCQsbF1rkqpJz96X1KRRhlZ5zCIVdd9q/i45WBApnd20=
X-Received: by 2002:a65:5ac4:: with SMTP id d4mr310230pgt.381.1588618467214;
 Mon, 04 May 2020 11:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200504081605.32624-1-ardb@kernel.org>
In-Reply-To: <20200504081605.32624-1-ardb@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 4 May 2020 11:54:16 -0700
Message-ID: <CAKwvOdkmXm9Md6ErKeF26M-9mtk_f2i23zndOwV_Z6G1yWmY3w@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub/x86: work around LLVM ELF quirk build regression
To:     Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Peter Collingbourne <pcc@google.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, May 4, 2020 at 1:16 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> When building the x86 EFI stub with Clang, the libstub Makefile rules
> that manipulate the ELF object files may throw an error like:
>
>     STUBCPY drivers/firmware/efi/libstub/efi-stub-helper.stub.o
>   strip: drivers/firmware/efi/libstub/efi-stub-helper.stub.o: Failed to find link section for section 10
>   objcopy: drivers/firmware/efi/libstub/efi-stub-helper.stub.o: Failed to find link section for section 10
>
> This is the result of a LLVM 'feature' [0] where symbol references are
> stored in a LLVM specific .llvm_addrsig section in a non-transparent way,
> causing generic ELF tools such as strip or objcopy to choke on them.
>
> So drop the .llvm_addrsig section explicitly as well, to work around
> this behavior.
>
> [0] https://sourceware.org/bugzilla/show_bug.cgi?id=23817

This page also has info about the extension:
https://llvm.org/docs/Extensions.html#sht-llvm-addrsig-section-address-significance-table
Peter, do you know if it's possible to prevent the emission of this
section from clang?  Scanning through the sources, it looks like it's
set unconditionally during LTO, but I couldn't find where else?  Is
this section required for more than LTO?

We need a generic way to disable LLVM extensions when we're not using
the LLVM binutils.  We have a couple cases where `-no-integrated-as`
will prevent AsmStreamer from not using assembler extensions, but in
this case it's the linker+objcopy+strip that don't work with the
extensions.

>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Reported-by: Arnd Bergmann <arnd@arndb.de>

Do you have a link to the configs or report so we can repro?

Also, scripts/get_maintainer.pl should recommend our list for patches
mentioning clang or llvm, which is a wider audience that can help test
and review.  I've been out sick much of the past week, so I appreciate
the shared help with code review.  Of course if your intention was to
be more discreet, I'm sorry I may have just messed that up.

> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 8d246b51bd49..4d137615a666 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -66,7 +66,8 @@ CFLAGS_arm64-stub.o           := -DTEXT_OFFSET=$(TEXT_OFFSET)
>  # .data section of the compressed kernel to ensure initialization. Rename the
>  # .bss section here so it's easy to pick out in the linker script.
>  #
> -STUBCOPY_FLAGS-$(CONFIG_X86)   += --rename-section .bss=.bss.efistub,load,alloc
> +STUBCOPY_FLAGS-$(CONFIG_X86)   += -R .llvm_addrsig \
> +                                  --rename-section .bss=.bss.efistub,load,alloc

Do we only observe this for x86, not ARM?

>  STUBCOPY_RELOC-$(CONFIG_X86_32)        := R_386_32
>  STUBCOPY_RELOC-$(CONFIG_X86_64)        := R_X86_64_64
>
> @@ -111,7 +112,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
>  #
>  quiet_cmd_stubcopy = STUBCPY $@
>        cmd_stubcopy =                                                   \
> -       $(STRIP) --strip-debug -o $@ $<;                                \
> +       $(STRIP) --strip-debug -R .llvm_addrsig -o $@ $<;               \
>         if $(OBJDUMP) -r $@ | grep $(STUBCOPY_RELOC-y); then            \
>                 echo "$@: absolute symbol references not allowed in the EFI stub" >&2; \
>                 /bin/false;                                             \
> --
> 2.17.1
>

In the absence of a linker script where we can use `DISCARD` rules,
this looks like the best approach, though I'm still curious about ARM.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
