Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46862952DA
	for <lists+linux-efi@lfdr.de>; Wed, 21 Oct 2020 21:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504904AbgJUTU6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Oct 2020 15:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439215AbgJUTU5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Oct 2020 15:20:57 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32DFC0613CF
        for <linux-efi@vger.kernel.org>; Wed, 21 Oct 2020 12:20:55 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id f19so817563oot.4
        for <linux-efi@vger.kernel.org>; Wed, 21 Oct 2020 12:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akqU1MhDkrT7oithdF82for+lErNOGYxs0P90JR1g3w=;
        b=VCKexwNUnnzXS/Rf8A+074xlup/dCXAnszpZsKM2ngPoq7J3t0UQFMQ/Sih2QN0G05
         82vpKjB7XqsKFy5+h639Xozfne2Ua6mC8xBNHOGs2MDITg+JZdj5JahhSMh4tGqyYtS3
         TBn9mPbVvHdmOCgmk+dciG3n14wwEcB+3s9nmj8l+lQp+NVHJ8kh8T0JcMr9VyJRc+AK
         1EBNFh/W3oW0HK3RbwvTx8T8dS6eujERtqFMzoNd6YGr2YJYvzLkFeWB8ns7FuSQGlp2
         isPer7W0a2y/8NdneMJVyn47bNNm/COWwxMA30gjHXV3fwhMV+KhCQ+ukqkvrR2OP5CZ
         TcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akqU1MhDkrT7oithdF82for+lErNOGYxs0P90JR1g3w=;
        b=unrELmpGYlHVu8JzYzbK/DTffrEq7uv8OsR7tqXgKXO9lqILJ5Q1QCoYSLGlwwDAFZ
         xUh8/MP/nBpThqiU6g+uFZw9qh228SCVgGdt0Xz5ONK4CI9OovhRTRSDA+phhAwSYu0l
         Y0p157qjFlAjNQVpKRcfpbG/k/eWnVJdkyG+xPkWTmlxawfhrUn9GcAY+c0X6NNh17yX
         7CapJdR2dUGM54BXwQDbeXEeg25Whr7Ai9M851ZLZ/lflMbkIZT26Aq0dIFulM/VJ4tj
         DdF7zToyvncjGjDZTnkXzOf404HQVkJwUJyV7LDA67tgkr5+YX5ObRdh9TEuzxJL819m
         1CSg==
X-Gm-Message-State: AOAM532LOdkILmYx9HyQzUUq7bXGqatclDFSraSKzSF7rtX7HWqP6rxQ
        dEHG7ZXE1rf09WnmphtwGqloi9FPq2f7NuKcF20Yfw==
X-Google-Smtp-Source: ABdhPJwfnTIjpdiubx7hjB/8q7LnsZoESpwHk1b79kW9XhcsF5QwrbCbPI9uXIe2TqE98UlMjX/i+wZTBEdhAbD1CpU=
X-Received: by 2002:a4a:751a:: with SMTP id j26mr3679810ooc.14.1603308054842;
 Wed, 21 Oct 2020 12:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <e9b1ba517f06b81bd24e54c84f5e44d81c27c566.camel@perches.com>
In-Reply-To: <e9b1ba517f06b81bd24e54c84f5e44d81c27c566.camel@perches.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 21 Oct 2020 21:20:43 +0200
Message-ID: <CANpmjNP0aKOabKvhY4wcrAPdX6ypp81uMfe5_qhNV0NVnvjAEw@mail.gmail.com>
Subject: Re: [PATCH -next] treewide: Remove stringification from __alias macro definition
To:     Joe Perches <joe@perches.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-efi@vger.kernel.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 21 Oct 2020 at 20:58, Joe Perches <joe@perches.com> wrote:
>
> Like the __section macro, the __alias macro uses
> macro # stringification to create quotes around
> the section name used in the __attribute__.
>
> Remove the stringification and add quotes or a
> stringification to the uses instead.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>
> There is a script that might eventually be applied
> to convert the __section macro definition and uses
> to remove stringification
>
> https://lore.kernel.org/lkml/46f69161e60b802488ba8c8f3f8bbf922aa3b49b.camel@perches.com/
> https://lore.kernel.org/lkml/75393e5ddc272dc7403de74d645e6c6e0f4e70eb.camel@perches.com/
>
> This patch is intended to create commonality
> between the uses of __section and __alias.
>
>  arch/x86/boot/compressed/string.c       |  6 +++---
>  arch/x86/include/asm/syscall_wrapper.h  |  2 +-
>  drivers/firmware/efi/runtime-wrappers.c |  2 +-
>  include/linux/compiler_attributes.h     |  2 +-
>  kernel/kcsan/core.c                     | 10 +++++-----
>  lib/crc32.c                             |  4 ++--
>  lib/crypto/aes.c                        |  4 ++--
>  mm/kasan/generic.c                      |  8 ++++----
>  8 files changed, 19 insertions(+), 19 deletions(-)

Reviewed-by: Marco Elver <elver@google.com>

for KCSAN and KASAN.

Thank you!

> diff --git a/arch/x86/boot/compressed/string.c b/arch/x86/boot/compressed/string.c
> index 81fc1eaa3229..d38b122f51ef 100644
> --- a/arch/x86/boot/compressed/string.c
> +++ b/arch/x86/boot/compressed/string.c
> @@ -75,7 +75,7 @@ void *memcpy(void *dest, const void *src, size_t n)
>  }
>
>  #ifdef CONFIG_KASAN
> -extern void *__memset(void *s, int c, size_t n) __alias(memset);
> -extern void *__memmove(void *dest, const void *src, size_t n) __alias(memmove);
> -extern void *__memcpy(void *dest, const void *src, size_t n) __alias(memcpy);
> +extern void *__memset(void *s, int c, size_t n) __alias("memset");
> +extern void *__memmove(void *dest, const void *src, size_t n) __alias("memmove");
> +extern void *__memcpy(void *dest, const void *src, size_t n) __alias("memcpy");
>  #endif
> diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
> index a84333adeef2..f19d1bbbff3d 100644
> --- a/arch/x86/include/asm/syscall_wrapper.h
> +++ b/arch/x86/include/asm/syscall_wrapper.h
> @@ -69,7 +69,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
>         long __##abi##_##name(const struct pt_regs *regs);              \
>         ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);                 \
>         long __##abi##_##name(const struct pt_regs *regs)               \
> -               __alias(__do_##name);
> +               __alias("__do_" #name);
>
>  #define __SYS_STUBx(abi, name, ...)                                    \
>         long __##abi##_##name(const struct pt_regs *regs);              \
> diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
> index 1410beaef5c3..14e380ac65d4 100644
> --- a/drivers/firmware/efi/runtime-wrappers.c
> +++ b/drivers/firmware/efi/runtime-wrappers.c
> @@ -162,7 +162,7 @@ static DEFINE_SEMAPHORE(efi_runtime_lock);
>   * Expose the EFI runtime lock to the UV platform
>   */
>  #ifdef CONFIG_X86_UV
> -extern struct semaphore __efi_uv_runtime_lock __alias(efi_runtime_lock);
> +extern struct semaphore __efi_uv_runtime_lock __alias("efi_runtime_lock");
>  #endif
>
>  /*
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index ea7b756b1c8f..4819512c9abd 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -42,7 +42,7 @@
>  /*
>   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-alias-function-attribute
>   */
> -#define __alias(symbol)                 __attribute__((__alias__(#symbol)))
> +#define __alias(symbol)                 __attribute__((__alias__(symbol)))
>
>  /*
>   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-aligned-function-attribute
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index 3994a217bde7..465f6cfc317c 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -814,7 +814,7 @@ EXPORT_SYMBOL(__kcsan_check_access);
>         }                                                                      \
>         EXPORT_SYMBOL(__tsan_read##size);                                      \
>         void __tsan_unaligned_read##size(void *ptr)                            \
> -               __alias(__tsan_read##size);                                    \
> +               __alias("__tsan_read" #size);                                  \
>         EXPORT_SYMBOL(__tsan_unaligned_read##size);                            \
>         void __tsan_write##size(void *ptr);                                    \
>         void __tsan_write##size(void *ptr)                                     \
> @@ -823,7 +823,7 @@ EXPORT_SYMBOL(__kcsan_check_access);
>         }                                                                      \
>         EXPORT_SYMBOL(__tsan_write##size);                                     \
>         void __tsan_unaligned_write##size(void *ptr)                           \
> -               __alias(__tsan_write##size);                                   \
> +               __alias("__tsan_write" #size);                                 \
>         EXPORT_SYMBOL(__tsan_unaligned_write##size);                           \
>         void __tsan_read_write##size(void *ptr);                               \
>         void __tsan_read_write##size(void *ptr)                                \
> @@ -833,7 +833,7 @@ EXPORT_SYMBOL(__kcsan_check_access);
>         }                                                                      \
>         EXPORT_SYMBOL(__tsan_read_write##size);                                \
>         void __tsan_unaligned_read_write##size(void *ptr)                      \
> -               __alias(__tsan_read_write##size);                              \
> +               __alias("__tsan_read_write" #size);                            \
>         EXPORT_SYMBOL(__tsan_unaligned_read_write##size)
>
>  DEFINE_TSAN_READ_WRITE(1);
> @@ -877,7 +877,7 @@ EXPORT_SYMBOL(__tsan_write_range);
>         }                                                                      \
>         EXPORT_SYMBOL(__tsan_volatile_read##size);                             \
>         void __tsan_unaligned_volatile_read##size(void *ptr)                   \
> -               __alias(__tsan_volatile_read##size);                           \
> +               __alias("__tsan_volatile_read" #size);                         \
>         EXPORT_SYMBOL(__tsan_unaligned_volatile_read##size);                   \
>         void __tsan_volatile_write##size(void *ptr);                           \
>         void __tsan_volatile_write##size(void *ptr)                            \
> @@ -892,7 +892,7 @@ EXPORT_SYMBOL(__tsan_write_range);
>         }                                                                      \
>         EXPORT_SYMBOL(__tsan_volatile_write##size);                            \
>         void __tsan_unaligned_volatile_write##size(void *ptr)                  \
> -               __alias(__tsan_volatile_write##size);                          \
> +               __alias("__tsan_volatile_write" #size);                        \
>         EXPORT_SYMBOL(__tsan_unaligned_volatile_write##size)
>
>  DEFINE_TSAN_VOLATILE_READ_WRITE(1);
> diff --git a/lib/crc32.c b/lib/crc32.c
> index 2a68dfd3b96c..373a17aaa432 100644
> --- a/lib/crc32.c
> +++ b/lib/crc32.c
> @@ -206,8 +206,8 @@ u32 __pure __weak __crc32c_le(u32 crc, unsigned char const *p, size_t len)
>  EXPORT_SYMBOL(crc32_le);
>  EXPORT_SYMBOL(__crc32c_le);
>
> -u32 __pure crc32_le_base(u32, unsigned char const *, size_t) __alias(crc32_le);
> -u32 __pure __crc32c_le_base(u32, unsigned char const *, size_t) __alias(__crc32c_le);
> +u32 __pure crc32_le_base(u32, unsigned char const *, size_t) __alias("crc32_le");
> +u32 __pure __crc32c_le_base(u32, unsigned char const *, size_t) __alias("__crc32c_le");
>
>  /*
>   * This multiplies the polynomials x and y modulo the given modulus.
> diff --git a/lib/crypto/aes.c b/lib/crypto/aes.c
> index 827fe89922ff..5b80514595c2 100644
> --- a/lib/crypto/aes.c
> +++ b/lib/crypto/aes.c
> @@ -82,8 +82,8 @@ static volatile const u8 __cacheline_aligned aes_inv_sbox[] = {
>         0xe1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0c, 0x7d,
>  };
>
> -extern const u8 crypto_aes_sbox[256] __alias(aes_sbox);
> -extern const u8 crypto_aes_inv_sbox[256] __alias(aes_inv_sbox);
> +extern const u8 crypto_aes_sbox[256] __alias("aes_sbox");
> +extern const u8 crypto_aes_inv_sbox[256] __alias("aes_inv_sbox");
>
>  EXPORT_SYMBOL(crypto_aes_sbox);
>  EXPORT_SYMBOL(crypto_aes_inv_sbox);
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 248264b9cb76..4496f897e4f5 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -234,7 +234,7 @@ EXPORT_SYMBOL(__asan_unregister_globals);
>                 check_memory_region_inline(addr, size, false, _RET_IP_);\
>         }                                                               \
>         EXPORT_SYMBOL(__asan_load##size);                               \
> -       __alias(__asan_load##size)                                      \
> +       __alias("__asan_load" #size)                                    \
>         void __asan_load##size##_noabort(unsigned long);                \
>         EXPORT_SYMBOL(__asan_load##size##_noabort);                     \
>         void __asan_store##size(unsigned long addr)                     \
> @@ -242,7 +242,7 @@ EXPORT_SYMBOL(__asan_unregister_globals);
>                 check_memory_region_inline(addr, size, true, _RET_IP_); \
>         }                                                               \
>         EXPORT_SYMBOL(__asan_store##size);                              \
> -       __alias(__asan_store##size)                                     \
> +       __alias("__asan_store" #size)                                   \
>         void __asan_store##size##_noabort(unsigned long);               \
>         EXPORT_SYMBOL(__asan_store##size##_noabort)
>
> @@ -258,7 +258,7 @@ void __asan_loadN(unsigned long addr, size_t size)
>  }
>  EXPORT_SYMBOL(__asan_loadN);
>
> -__alias(__asan_loadN)
> +__alias("__asan_loadN")
>  void __asan_loadN_noabort(unsigned long, size_t);
>  EXPORT_SYMBOL(__asan_loadN_noabort);
>
> @@ -268,7 +268,7 @@ void __asan_storeN(unsigned long addr, size_t size)
>  }
>  EXPORT_SYMBOL(__asan_storeN);
>
> -__alias(__asan_storeN)
> +__alias("__asan_storeN")
>  void __asan_storeN_noabort(unsigned long, size_t);
>  EXPORT_SYMBOL(__asan_storeN_noabort);
>
>
>
>
>
