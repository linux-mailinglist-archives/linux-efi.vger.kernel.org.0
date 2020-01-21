Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F35DA14473C
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jan 2020 23:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgAUWYO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Jan 2020 17:24:14 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33459 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbgAUWYN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Jan 2020 17:24:13 -0500
Received: by mail-pj1-f66.google.com with SMTP id u63so1316019pjb.0
        for <linux-efi@vger.kernel.org>; Tue, 21 Jan 2020 14:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SJrNbmsXY+uNHtldg6ujmrZJBSnH5PypztQmMUfyJQ8=;
        b=l4ra+nRo2WQfBPlomm6na3K4uw0/MLWXMD5r3BrDeobxKXSU+U+9cytQVFhhteayeK
         qVchFG+xNywegBp+6bo+Esu3AuZXs5KhxkWmg6U6koTmqOLW04louia/iqRSAGybJ40x
         cbPDdA3HKC1Kb819jW2b1KW2gtI/hmX5j9ObRVgfD8qakk8KhcbsZ0aIj8HVyJkB0rr9
         U9ilsdMa7Xnu8bbChVHxH15OE5yveVq+whvx7p30nQS4JSVXxWUsk7eb6kPZr2j9b0Aa
         jKvGdsZzXyoiyTa9bnYrUyJQK3AmBymuo2StmRjx2jkZ5ZVh+DUYHp2z/EW2GPfvOBzt
         V2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SJrNbmsXY+uNHtldg6ujmrZJBSnH5PypztQmMUfyJQ8=;
        b=ZURmbqDh2yEiSmdXl3GOJjYSJelxJOKdkhQgC0T3FakpbhJd5P09JKzSlUNj2B1zUB
         y57fC+gjEGkCL+qdUUlY/OEp8ySG9QGD9DG3dwX0wby7+cMiqDIfmYA1Wm8pLx7jPM2A
         0eyTedAaKfuC86PyxuEK70mjsNyOz0bSG/mSKR01UeW/ewfD9zTcOJatCGmSGawmIZDf
         PBpNuYtmaK0LyNr1kjWnDC2nosbphfcrI57IzxxN13wWo5s0ViwKdYxhbTzsjWiR+9xF
         O0FApsW8xKXh124GDMXR50oP0JROZCO5s4mTkRvIK+VMdV3SAWyWgzhKNuit2uBWh1lc
         UoLg==
X-Gm-Message-State: APjAAAWC6GYzrgmVgo6m8+JOWdwojoomdv34OW9xiJTUwAqyeGAcvMwU
        UM/M7wWCfTNPBOVv5B1kc0lxf5vpseIOywwTHwASw5BGSh8=
X-Google-Smtp-Source: APXvYqwLOdfZ6450LjWeYnbIjWhzt2CKpEyDodVcG6E09TwsWSrRelMlMRpVJblw0pciKXK87biqtYCL9cMdx/m35so=
X-Received: by 2002:a17:902:bf03:: with SMTP id bi3mr7243112plb.119.1579645452580;
 Tue, 21 Jan 2020 14:24:12 -0800 (PST)
MIME-Version: 1.0
References: <20200118165705.16544-1-ardb@kernel.org> <20200118165705.16544-3-ardb@kernel.org>
In-Reply-To: <20200118165705.16544-3-ardb@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 21 Jan 2020 14:24:01 -0800
Message-ID: <CAKwvOdk83EybXULNANONOtY6pwK5KBtFpZyCXM512YHhmLoVbw@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/boot/compressed: relax sed symbol type regex for
 LLVM ld.lld
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Jan 18, 2020 at 8:57 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> The final build stage of the x86 kernel captures some symbol
> addresses from the decompressor binary and copies them into zoffset.h.
> It uses sed with a regular expression that matches the address, symbol
> type and symbol name, and mangles the captured addresses and the names
> of symbols of interest into #define directives that are added to
> zoffset.h
>
> The symbol type is indicated by a single letter, which we match
> strictly: only letters in the set 'ABCDGRSTVW' are matched, even
> though the actual symbol type is relevant and therefore ignored.
>
> Commit bc7c9d620 ("efi/libstub/x86: Force 'hidden' visibility for
> extern declarations") made a change to the way external symbol
> references are classified, resulting in 'startup_32' now being
> emitted as a hidden symbol. This prevents the use of GOT entries to
> refer to this symbol via its absolute address, which recent toolchains
> (including Clang based ones) already avoid by default, making this
> change a no-op in the majority of cases.
>
> However, as it turns out, the LLVM linker classifies such hidden
> symbols as symbols with static linkage in fully linked ELF binaries,
> causing tools such as NM to output a lowercase 't' rather than an upper
> case 'T' for the type of such symbols. Since our sed expression only
> matches upper case letters for the symbol type, the line describing
> startup_32 is disregarded, resulting in a build error like the following
>
>   arch/x86/boot/header.S:568:18: error: symbol 'ZO_startup_32' can not be
>                                         undefined in a subtraction expression
>   init_size: .long (0x00000000008fd000 - ZO_startup_32 +
>                     (((0x0000000001f6361c + ((0x0000000001f6361c >> 8) + 65536)
>                      - 0x00000000008c32e5) + 4095) & ~4095)) # kernel initialization size
>
> Given that we are only interested in the value of the symbol, let's match
> any character in the set 'a-zA-Z' instead.
>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>

Thanks for the patch! This fixes a build breakage for us.
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/842

> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> index 95410d6ee2ff..748b6d28a91d 100644
> --- a/arch/x86/boot/Makefile
> +++ b/arch/x86/boot/Makefile
> @@ -88,7 +88,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
>
>  SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
>
> -sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [ABCDGRSTVW] \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
> +sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
>
>  quiet_cmd_zoffset = ZOFFSET $@
>        cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
