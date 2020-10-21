Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB9B2952A7
	for <lists+linux-efi@lfdr.de>; Wed, 21 Oct 2020 21:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502431AbgJUTCx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Oct 2020 15:02:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502332AbgJUTCx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 21 Oct 2020 15:02:53 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F5E52416E;
        Wed, 21 Oct 2020 19:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603306971;
        bh=/Kc4AavXiYxFneptkkOgmh0nxkppgUuDDEkboR79oDA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fxEa08KdpLvPtws+P6Sjyh9+5I40+0RjqHy73q7akLwW3G7pluIbpYstOGKbyRAjf
         Yt4QnFYSGebewxzxKZU2RoZ9wQi1NMivfPZ9QRaDmWdhrcc0Uy4a9oqayWEsPVD1RX
         DRYK+9uq73LEfhK5xv6zv2s7wzllasC7SosNdzmM=
Received: by mail-ot1-f43.google.com with SMTP id t15so2864891otk.0;
        Wed, 21 Oct 2020 12:02:51 -0700 (PDT)
X-Gm-Message-State: AOAM532lAt7YoXOCbbaF8MpXxra7Xu6pBpUgKVcxcLeJpxPXJNzK/G4t
        6ObfnEhoLTrLUh42d9rbQscCntBcvxPkEVYXz6k=
X-Google-Smtp-Source: ABdhPJxK9S2C17fLOYaO38K9n9/IdbQJbgZVlKTsTcNERgr0NtWibtxTcVfThIvjnUBUZVyNweB4vPcgAY/ePVYuzMY=
X-Received: by 2002:a9d:6a85:: with SMTP id l5mr3828841otq.77.1603306970159;
 Wed, 21 Oct 2020 12:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <e9b1ba517f06b81bd24e54c84f5e44d81c27c566.camel@perches.com>
In-Reply-To: <e9b1ba517f06b81bd24e54c84f5e44d81c27c566.camel@perches.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 21 Oct 2020 21:02:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHe0hEDiGNMM_fg3_RYjM6B6mbKJ+1R7tsnA66ZzsiBgw@mail.gmail.com>
Message-ID: <CAMj1kXHe0hEDiGNMM_fg3_RYjM6B6mbKJ+1R7tsnA66ZzsiBgw@mail.gmail.com>
Subject: Re: [PATCH -next] treewide: Remove stringification from __alias macro definition
To:     Joe Perches <joe@perches.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
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

Why?

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
>
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
