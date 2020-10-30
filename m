Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF2429FE8A
	for <lists+linux-efi@lfdr.de>; Fri, 30 Oct 2020 08:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgJ3Hkn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Oct 2020 03:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3Hkm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 30 Oct 2020 03:40:42 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC62C0613CF;
        Fri, 30 Oct 2020 00:40:42 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id k1so5669089ilc.10;
        Fri, 30 Oct 2020 00:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4ZZqckq9iBzbPT7QTQmdrh5Ofh971dIkKFYUcVvnOi0=;
        b=vRO2afTP9xmkLrr3hNa8kNY68y/KSMurW2vz5nS9SUnAXwCOlia7Xzivl4msbutPp1
         zKDKvIKa3szrEgA2/QsE9sTy+v1rjIYhgsgzl3mRTLag8Fqkey+pOTBniRo/1kDqyid6
         +ktFIEGbGgNv4lPp6z3OJ4AShoPGnNiOQ5HevhBkIe0BEvhCnkwWc9nEj0TcrwAk/kME
         6LXZnUa8OfATEey9e4roUc/C0mdCXVSRH70h0LVmivFPjMpv+9J4DM20HyBdKDWXSPId
         cSYfcn3ucAeHw0nGOiRaSJTCLIUoxgQThGKM/GAD2TEkvv2aQl3/xeB4bdj0c48i5c14
         gsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4ZZqckq9iBzbPT7QTQmdrh5Ofh971dIkKFYUcVvnOi0=;
        b=rS3HD04rDNSS3E4twVsWUcysykckamuowSqvJTKW8RdkGrz9jWW8q5TFEKuB6YXHea
         bSrCbaqeFy+bn+eFQUZpbT1HxCnJZZFP05GzHuNFtzDbvXGNSPziSbjNc4z15eqLazt3
         btlCsZ/485NXggSJogk+CVnA5CiPfDyGh3ed3Hxa0OS5NlT0ongbqyhHU2R9pe3MWnDM
         8oNN+vltweABfOo1Ye46b2PkMF1XGlqAEK72DxCDH6162T3n/NWLhigNAmWawcw6aRPG
         RUDkOIX+CHgWJC0R0IfhuR2Q4TmEfKzA3XkXbqLbMcLKEBgih1SCIY+sYpNRudT1wJfc
         b8EA==
X-Gm-Message-State: AOAM5338hSl8Of7Wp3jgzv6kfsJ7Q1NfjFGpypc2H9cN3b6pR93oJ0uO
        G7S8yyP6pKPZwAIH6TT7kuI=
X-Google-Smtp-Source: ABdhPJw4nTcSjrU3sa5Yo0joP9sLNG63ac91gZaWxmMbYZ5HM5zOi2XWBEClUB6t/k21OVJpZwQYXw==
X-Received: by 2002:a92:da92:: with SMTP id u18mr975106iln.266.1604043641932;
        Fri, 30 Oct 2020 00:40:41 -0700 (PDT)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id r3sm4188815iog.55.2020.10.30.00.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 00:40:41 -0700 (PDT)
Date:   Fri, 30 Oct 2020 00:40:38 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org,
        linux-mm@kvack.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] treewide: Remove stringification from __alias macro
 definition
Message-ID: <20201030074038.GA1747580@ubuntu-m3-large-x86>
References: <8451df41359b52f048780d19e07b6fa4445b6392.1604026698.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8451df41359b52f048780d19e07b6fa4445b6392.1604026698.git.joe@perches.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 29, 2020 at 08:07:31PM -0700, Joe Perches wrote:
> Like the old __section macro, the __alias macro uses macro # stringification
> to create quotes around the symbol name used in the __attribute__.
> 
> This can cause differences between gcc and clang when the stringification
> itself contains a quote character.  So avoid these differences by always
> using quotes to define the aliased symbol.
> 
> Remove the stringification and add quotes and when necessary a stringification
> when existing uses have a ## concatenation.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
> 
> Unlike the __section macro conversion in commit 33def8498fdd
> ("treewide: Convert macro and uses of __section(foo) to __section("foo")")
> this one was done by hand.
> 
> No other use of __alias exists in the kernel.
> 
> This patch does _not_ convert any uses of __attribute__((alias("<foo>")))
> so it should not cause any compilation issues.
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
>  	long __##abi##_##name(const struct pt_regs *regs);		\
>  	ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);			\
>  	long __##abi##_##name(const struct pt_regs *regs)		\
> -		__alias(__do_##name);
> +		__alias("__do_" #name);
>  
>  #define __SYS_STUBx(abi, name, ...)					\
>  	long __##abi##_##name(const struct pt_regs *regs);		\
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
>  	}                                                                      \
>  	EXPORT_SYMBOL(__tsan_read##size);                                      \
>  	void __tsan_unaligned_read##size(void *ptr)                            \
> -		__alias(__tsan_read##size);                                    \
> +		__alias("__tsan_read" #size);                                  \
>  	EXPORT_SYMBOL(__tsan_unaligned_read##size);                            \
>  	void __tsan_write##size(void *ptr);                                    \
>  	void __tsan_write##size(void *ptr)                                     \
> @@ -823,7 +823,7 @@ EXPORT_SYMBOL(__kcsan_check_access);
>  	}                                                                      \
>  	EXPORT_SYMBOL(__tsan_write##size);                                     \
>  	void __tsan_unaligned_write##size(void *ptr)                           \
> -		__alias(__tsan_write##size);                                   \
> +		__alias("__tsan_write" #size);                                 \
>  	EXPORT_SYMBOL(__tsan_unaligned_write##size);                           \
>  	void __tsan_read_write##size(void *ptr);                               \
>  	void __tsan_read_write##size(void *ptr)                                \
> @@ -833,7 +833,7 @@ EXPORT_SYMBOL(__kcsan_check_access);
>  	}                                                                      \
>  	EXPORT_SYMBOL(__tsan_read_write##size);                                \
>  	void __tsan_unaligned_read_write##size(void *ptr)                      \
> -		__alias(__tsan_read_write##size);                              \
> +		__alias("__tsan_read_write" #size);                            \
>  	EXPORT_SYMBOL(__tsan_unaligned_read_write##size)
>  
>  DEFINE_TSAN_READ_WRITE(1);
> @@ -877,7 +877,7 @@ EXPORT_SYMBOL(__tsan_write_range);
>  	}                                                                      \
>  	EXPORT_SYMBOL(__tsan_volatile_read##size);                             \
>  	void __tsan_unaligned_volatile_read##size(void *ptr)                   \
> -		__alias(__tsan_volatile_read##size);                           \
> +		__alias("__tsan_volatile_read" #size);                         \
>  	EXPORT_SYMBOL(__tsan_unaligned_volatile_read##size);                   \
>  	void __tsan_volatile_write##size(void *ptr);                           \
>  	void __tsan_volatile_write##size(void *ptr)                            \
> @@ -892,7 +892,7 @@ EXPORT_SYMBOL(__tsan_write_range);
>  	}                                                                      \
>  	EXPORT_SYMBOL(__tsan_volatile_write##size);                            \
>  	void __tsan_unaligned_volatile_write##size(void *ptr)                  \
> -		__alias(__tsan_volatile_write##size);                          \
> +		__alias("__tsan_volatile_write" #size);                        \
>  	EXPORT_SYMBOL(__tsan_unaligned_volatile_write##size)
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
>  	0xe1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0c, 0x7d,
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
>  		check_memory_region_inline(addr, size, false, _RET_IP_);\
>  	}								\
>  	EXPORT_SYMBOL(__asan_load##size);				\
> -	__alias(__asan_load##size)					\
> +	__alias("__asan_load" #size)					\
>  	void __asan_load##size##_noabort(unsigned long);		\
>  	EXPORT_SYMBOL(__asan_load##size##_noabort);			\
>  	void __asan_store##size(unsigned long addr)			\
> @@ -242,7 +242,7 @@ EXPORT_SYMBOL(__asan_unregister_globals);
>  		check_memory_region_inline(addr, size, true, _RET_IP_);	\
>  	}								\
>  	EXPORT_SYMBOL(__asan_store##size);				\
> -	__alias(__asan_store##size)					\
> +	__alias("__asan_store" #size)					\
>  	void __asan_store##size##_noabort(unsigned long);		\
>  	EXPORT_SYMBOL(__asan_store##size##_noabort)
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
> -- 
> 2.26.0
> 
