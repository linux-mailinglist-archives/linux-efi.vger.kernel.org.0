Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C747E34A83D
	for <lists+linux-efi@lfdr.de>; Fri, 26 Mar 2021 14:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhCZNim (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 Mar 2021 09:38:42 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:45039 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhCZNih (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 26 Mar 2021 09:38:37 -0400
Received: by mail-pl1-f172.google.com with SMTP id d8so919989plh.11;
        Fri, 26 Mar 2021 06:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sjVdsVi2cOMNdrCvfZtZ3oLI1gCE7hob4inFlEl7ClM=;
        b=rqQDS7XGoqUtpUeaZIeCD5RSKVBoBdn0QvPJjBIZoKUE/mPtQZq75rODBscPN+pMGZ
         +EQWjp9/hcyawAsVZPlI0dIQouXei4NzFUpTD2H6hjBoA009b6oPs5Y3Nwco8hfqOWAq
         l/iptMv4OxivEFK0A38Q+HO2acrjiADwA0Ewr0Cy/5qD9+EDNG+pUYd6aEpRipGqJLn2
         Xd7yohAphzpBSm+eZ1tNEYpgfbr7sguq8WcTUGYgWHp4w8hrXYYUh92TtS9NAaF3rX/d
         9Fzv6FYAN+kbOv97AGUTnEh6EBUlHQZUaE4lld3JHfZJ3hhQhdAJd8gQWcErFj3X439T
         ns/g==
X-Gm-Message-State: AOAM531Q95b+HwqIZarrthafCN/95RM/b3h0d+5RVLmFyZCOmHLZQY3c
        bX0QBnt3Fws+tBII0CooUYU=
X-Google-Smtp-Source: ABdhPJxhLAaakq2et9TW5baLVPKl8QCBjXLxdJ4mK22v4C0BUr+ccWqx6FIqXdPbOarrOZclY3bUWA==
X-Received: by 2002:a17:90a:8083:: with SMTP id c3mr13295578pjn.134.1616765916672;
        Fri, 26 Mar 2021 06:38:36 -0700 (PDT)
Received: from macbook.local (ae142046.dynamic.ppp.asahi-net.or.jp. [14.3.142.46])
        by smtp.gmail.com with ESMTPSA id q66sm8672644pja.27.2021.03.26.06.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 06:38:35 -0700 (PDT)
Subject: Re: [PATCH 1/3] x86: Propagate $(CLANG_FLAGS) to $(REALMODE_FLAGS)
To:     Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sedat Dilek <sedat.dilek@gmail.com>
References: <20210326000435.4785-1-nathan@kernel.org>
 <20210326000435.4785-2-nathan@kernel.org>
From:   John Millikin <john@john-millikin.com>
Message-ID: <28a887a4-3524-fd54-0953-d4c813fb676b@john-millikin.com>
Date:   Fri, 26 Mar 2021 22:38:31 +0900
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210326000435.4785-2-nathan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 3/26/21 09:04, Nathan Chancellor wrote:
> From: John Millikin <john@john-millikin.com>
> 
> When cross-compiling with Clang, the `$(CLANG_FLAGS)' variable
> contains additional flags needed to build C and assembly sources
> for the target platform. Normally this variable is automatically
> included in `$(KBUILD_CFLAGS)' by via the top-level Makefile.
> 
> The x86 real-mode makefile builds `$(REALMODE_CFLAGS)' from a
> plain assignment and therefore drops the Clang flags. This causes
> Clang to not recognize x86-specific assembler directives:
> 
>   arch/x86/realmode/rm/header.S:36:1: error: unknown directive
>   .type real_mode_header STT_OBJECT ; .size real_mode_header, .-real_mode_header
>   ^
> 
> Explicit propagation of `$(CLANG_FLAGS)' to `$(REALMODE_CFLAGS)',
> which is inherited by real-mode make rules, fixes cross-compilation
> with Clang for x86 targets.
> 
> Relevant flags:
> 
> * `--target' sets the target architecture when cross-compiling. This
>   flag must be set for both compilation and assembly (`KBUILD_AFLAGS')
>   to support architecture-specific assembler directives.
> 
> * `-no-integrated-as' tells clang to assemble with GNU Assembler
>   instead of its built-in LLVM assembler. This flag is set by default
>   unless `LLVM_IAS=1' is set, because the LLVM assembler can't yet
>   parse certain GNU extensions.
> 
> Signed-off-by: John Millikin <john@john-millikin.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/x86/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 2d6d5a28c3bf..9a73e0cea19c 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -33,6 +33,7 @@ REALMODE_CFLAGS += -ffreestanding
>  REALMODE_CFLAGS += -fno-stack-protector
>  REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -Wno-address-of-packed-member)
>  REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), $(cc_stack_align4))
> +REALMODE_CFLAGS += $(CLANG_FLAGS)
>  export REALMODE_CFLAGS
>  
>  # BITS is used as extension for files which are available in a 32 bit
> 

Just wanted to say "thank you" for picking this up -- I ran into some real-life situations and didn't have time to debug why my patch was failing the Git validity check (presumed to be an email client misconfiguration).
