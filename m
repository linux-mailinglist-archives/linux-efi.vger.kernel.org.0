Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A2D7D8E9A
	for <lists+linux-efi@lfdr.de>; Fri, 27 Oct 2023 08:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjJ0GYr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Oct 2023 02:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0GYq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Oct 2023 02:24:46 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6DF1B1
        for <linux-efi@vger.kernel.org>; Thu, 26 Oct 2023 23:24:42 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-27d11401516so1425036a91.2
        for <linux-efi@vger.kernel.org>; Thu, 26 Oct 2023 23:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698387882; x=1698992682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m/1+2Org+HUdzphpjgQxHya0pQZCLqwEr7eM4fM+ags=;
        b=Fszx3KzqcpVLQdhy+UcFX1BQTfOMFDNjQ8l18Y6+FWJ+4hNk4yiH6XxUM+NrtYQiQs
         yc2ZW2W3m9NnCOVt7+MonVa+WzlfHRVI5WdsVEaRd1aUIZrs1ORfiQU1NDOKL7fFjUjo
         I9uuPiR7BZjEtf7UamvmYncEBxm2qHwtnF+9eVBGIrSIYDQKSxkFKaL3jjtu5z/TYP5Y
         HxjRZpp3MONtY8GOUF+sfcdJ/aO/7IPgjSkmO5j6bCyMCLh9i/3k6YQnotB2mLZpCfmZ
         v5EEloGBMRXcbm+qrsrG7IEV6agneV/c+eipMIbZ6qmYFyPYQrirr5PdFHJP9tZuJMbc
         ntEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698387882; x=1698992682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/1+2Org+HUdzphpjgQxHya0pQZCLqwEr7eM4fM+ags=;
        b=vLj8XeLRGzaqbFKtoe+95lRy3qV2I/0hUTTyBh67M85zop3vqQ8sKcStzSkiJMGjZ3
         6LP4n+bjGX4eXqkWxDGJmk2yWx+dVplw+0akYAwZqt9ImviR9VdMBgDCtqcRjojcJE3Y
         nepIRn7ZstD0tTW7WSGOdOPCzz3YkUJF2+GTc6GdEy2LzN9cP3/qq+UTsOdzN7pPgKZf
         TJFRlhuVkZLkZyPbb0pGW1oAAUNTKtigVY3TAcLVtHbsfatwMTP1gNPMLf/+H9lMR2rZ
         KpdfGUR0aXJKWkqrlnAaJhmbvma+rMig3VDXAtTX+wViKjqQKAZWHbevjx8bVXjclUGp
         V6hw==
X-Gm-Message-State: AOJu0YwU+jbsucZDKdpxxVD/PUJ+x9fhxO/eakRHuUC7bRRK3RyOJeIF
        KJms1sWpHjF/ti4bxGAX/wi+/Q==
X-Google-Smtp-Source: AGHT+IEXpMoigp46bv/9xLednIkJmxXn1P+zuqlkPr25L8zeynBTmjXMBJzy7BK0AeO0D4RAUb1CyQ==
X-Received: by 2002:a17:90a:7525:b0:27d:247b:2c3c with SMTP id q34-20020a17090a752500b0027d247b2c3cmr1831073pjk.23.1698387881994;
        Thu, 26 Oct 2023 23:24:41 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:6a7f:e823:958a:bc95])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a195e00b0027cfd582b51sm2909553pjh.3.2023.10.26.23.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 23:24:41 -0700 (PDT)
Date:   Thu, 26 Oct 2023 23:24:39 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Xiao Wang <xiao.w.wang@intel.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ardb@kernel.org, anup@brainfault.org,
        haicheng.li@intel.com, ajones@ventanamicro.com,
        yujie.liu@intel.com, linux-riscv@lists.infradead.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] riscv: Optimize bitops with Zbb extension
Message-ID: <ZTtXp/jhzvjGqBTT@ghost>
References: <20230926094655.3102758-1-xiao.w.wang@intel.com>
 <20230926094655.3102758-3-xiao.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926094655.3102758-3-xiao.w.wang@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Sep 26, 2023 at 05:46:55PM +0800, Xiao Wang wrote:
> This patch leverages the alternative mechanism to dynamically optimize
> bitops (including __ffs, __fls, ffs, fls) with Zbb instructions. When
> Zbb ext is not supported by the runtime CPU, legacy implementation is
> used. If Zbb is supported, then the optimized variants will be selected
> via alternative patching.
> 
> The legacy bitops support is taken from the generic C implementation as
> fallback.
> 
> If the parameter is a build-time constant, we leverage compiler builtin to
> calculate the result directly, this approach is inspired by x86 bitops
> implementation.
> 
> EFI stub runs before the kernel, so alternative mechanism should not be
> used there, this patch introduces a macro NO_ALTERNATIVE for this purpose.
> 
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
>  arch/riscv/include/asm/bitops.h       | 266 +++++++++++++++++++++++++-
>  drivers/firmware/efi/libstub/Makefile |   2 +-
>  2 files changed, 264 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
> index 3540b690944b..c97e774cb647 100644
> --- a/arch/riscv/include/asm/bitops.h
> +++ b/arch/riscv/include/asm/bitops.h
> @@ -15,13 +15,273 @@
>  #include <asm/barrier.h>
>  #include <asm/bitsperlong.h>
>  
> +#if !defined(CONFIG_RISCV_ISA_ZBB) || defined(NO_ALTERNATIVE)
>  #include <asm-generic/bitops/__ffs.h>
> -#include <asm-generic/bitops/ffz.h>
> -#include <asm-generic/bitops/fls.h>
>  #include <asm-generic/bitops/__fls.h>
> +#include <asm-generic/bitops/ffs.h>
> +#include <asm-generic/bitops/fls.h>
> +
> +#else
> +#include <asm/alternative-macros.h>
> +#include <asm/hwcap.h>
> +
> +#if (BITS_PER_LONG == 64)
> +#define CTZW	"ctzw "
> +#define CLZW	"clzw "
> +#elif (BITS_PER_LONG == 32)
> +#define CTZW	"ctz "
> +#define CLZW	"clz "
> +#else
> +#error "Unexpected BITS_PER_LONG"
> +#endif
> +
> +static __always_inline unsigned long variable__ffs(unsigned long word)
> +{
> +	int num;
> +
> +	asm_volatile_goto(
> +		ALTERNATIVE("j %l[legacy]", "nop", 0, RISCV_ISA_EXT_ZBB, 1)
> +		: : : : legacy);
> +
> +	asm volatile (
> +		".option push\n"
> +		".option arch,+zbb\n"
> +		"ctz %0, %1\n"
> +		".option pop\n"
> +		: "=r" (word) : "r" (word) :);
> +
> +	return word;

That's so clean!

> +
> +legacy:
> +	num = 0;
> +#if BITS_PER_LONG == 64
> +	if ((word & 0xffffffff) == 0) {
> +		num += 32;
> +		word >>= 32;
> +	}
> +#endif
> +	if ((word & 0xffff) == 0) {
> +		num += 16;
> +		word >>= 16;
> +	}
> +	if ((word & 0xff) == 0) {
> +		num += 8;
> +		word >>= 8;
> +	}
> +	if ((word & 0xf) == 0) {
> +		num += 4;
> +		word >>= 4;
> +	}
> +	if ((word & 0x3) == 0) {
> +		num += 2;
> +		word >>= 2;
> +	}
> +	if ((word & 0x1) == 0)
> +		num += 1;
> +	return num;
> +}
> +
> +/**
> + * __ffs - find first set bit in a long word
> + * @word: The word to search
> + *
> + * Undefined if no set bit exists, so code should check against 0 first.
> + */
> +#define __ffs(word)				\
> +	(__builtin_constant_p(word) ?		\
> +	 (unsigned long)__builtin_ctzl(word) :	\
> +	 variable__ffs(word))
> +
> +static __always_inline unsigned long variable__fls(unsigned long word)
> +{
> +	int num;
> +
> +	asm_volatile_goto(
> +		ALTERNATIVE("j %l[legacy]", "nop", 0, RISCV_ISA_EXT_ZBB, 1)
> +		: : : : legacy);
> +
> +	asm volatile (
> +		".option push\n"
> +		".option arch,+zbb\n"
> +		"clz %0, %1\n"
> +		".option pop\n"
> +		: "=r" (word) : "r" (word) :);
> +
> +	return BITS_PER_LONG - 1 - word;
> +
> +legacy:
> +	num = BITS_PER_LONG - 1;
> +#if BITS_PER_LONG == 64
> +	if (!(word & (~0ul << 32))) {
> +		num -= 32;
> +		word <<= 32;
> +	}
> +#endif
> +	if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
> +		num -= 16;
> +		word <<= 16;
> +	}
> +	if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
> +		num -= 8;
> +		word <<= 8;
> +	}
> +	if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
> +		num -= 4;
> +		word <<= 4;
> +	}
> +	if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
> +		num -= 2;
> +		word <<= 2;
> +	}
> +	if (!(word & (~0ul << (BITS_PER_LONG-1))))
> +		num -= 1;
> +	return num;
> +}
> +
> +/**
> + * __fls - find last set bit in a long word
> + * @word: the word to search
> + *
> + * Undefined if no set bit exists, so code should check against 0 first.
> + */
> +#define __fls(word)							\
> +	(__builtin_constant_p(word) ?					\
> +	 (unsigned long)(BITS_PER_LONG - 1 - __builtin_clzl(word)) :	\
> +	 variable__fls(word))
> +
> +static __always_inline int variable_ffs(int x)
> +{
> +	int r;
> +
> +	asm_volatile_goto(
> +		ALTERNATIVE("j %l[legacy]", "nop", 0, RISCV_ISA_EXT_ZBB, 1)
> +		: : : : legacy);
> +
> +	asm volatile (
> +		".option push\n"
> +		".option arch,+zbb\n"
> +		"bnez %1, 1f\n"
> +		"li %0, 0\n"
> +		"j 2f\n"
> +		"1:\n"
> +		CTZW "%0, %1\n"
> +		"addi %0, %0, 1\n"
> +		"2:\n"
> +		".option pop\n"
> +		: "=r" (r) : "r" (x) :);
> +
> +	return r;
> +

I generally like to move as much code out of asm as possible. You are
also able to remove one of the branches if you rearrange as follows:

if (!x)
	return 0;

asm volatile (
	".option push\n"
        ".option arch,+zbb\n"
        CTZW "%0, %1\n"
        ".option pop\n"
        : "=r" (r) : "r" (x) :);

return r + 1;

You could then also extract out the "if (!x)" at the beginning of the
legacy section at put it at the top of the function.

> +legacy:
> +	r = 1;
> +	if (!x)
> +		return 0;
> +	if (!(x & 0xffff)) {
> +		x >>= 16;
> +		r += 16;
> +	}
> +	if (!(x & 0xff)) {
> +		x >>= 8;
> +		r += 8;
> +	}
> +	if (!(x & 0xf)) {
> +		x >>= 4;
> +		r += 4;
> +	}
> +	if (!(x & 3)) {
> +		x >>= 2;
> +		r += 2;
> +	}
> +	if (!(x & 1)) {
> +		x >>= 1;
> +		r += 1;
> +	}
> +	return r;
> +}
> +
> +/**
> + * ffs - find first set bit in a word
> + * @x: the word to search
> + *
> + * This is defined the same way as the libc and compiler builtin ffs routines.
> + *
> + * ffs(value) returns 0 if value is 0 or the position of the first set bit if
> + * value is nonzero. The first (least significant) bit is at position 1.
> + */
> +#define ffs(x) (__builtin_constant_p(x) ? __builtin_ffs(x) : variable_ffs(x))
> +
> +static __always_inline int variable_fls(unsigned int x)
> +{
> +	int r;
> +
> +	asm_volatile_goto(
> +		ALTERNATIVE("j %l[legacy]", "nop", 0, RISCV_ISA_EXT_ZBB, 1)
> +		: : : : legacy);
> +
> +	asm volatile (
> +		".option push\n"
> +		".option arch,+zbb\n"
> +		"bnez %1, 1f\n"
> +		"li %0, 0\n"
> +		"j 2f\n"
> +		"1:\n"
> +		CLZW "%0, %1\n"
> +		"neg %0, %0\n"
> +		"addi %0, %0, 32\n"
> +		"2:\n"
> +		".option pop\n"
> +		: "=r" (r) : "r" (x) :);
> +
> +	return r;
> +

Same comment as above but with appropriate changes.

> +legacy:
> +	r = 32;
> +	if (!x)
> +		return 0;
> +	if (!(x & 0xffff0000u)) {
> +		x <<= 16;
> +		r -= 16;
> +	}
> +	if (!(x & 0xff000000u)) {
> +		x <<= 8;
> +		r -= 8;
> +	}
> +	if (!(x & 0xf0000000u)) {
> +		x <<= 4;
> +		r -= 4;
> +	}
> +	if (!(x & 0xc0000000u)) {
> +		x <<= 2;
> +		r -= 2;
> +	}
> +	if (!(x & 0x80000000u)) {
> +		x <<= 1;
> +		r -= 1;
> +	}
> +	return r;
> +}
> +
> +/**
> + * fls - find last set bit in a word
> + * @x: the word to search
> + *
> + * This is defined in a similar way as ffs, but returns the position of the most
> + * significant set bit.
> + *
> + * fls(value) returns 0 if value is 0 or the position of the last set bit if
> + * value is nonzero. The last (most significant) bit is at position 32.
> + */
> +#define fls(x)								\
> +	(__builtin_constant_p(x) ?					\
> +	 (int)(((x) != 0) ?						\
> +	  (sizeof(unsigned int) * 8 - __builtin_clz(x)) : 0) :		\
> +	 variable_fls(x))
> +
> +#endif

As a nit, it's nice when large #ifdef blocks have a comment like

/* !defined(CONFIG_RISCV_ISA_ZBB) || defined(NO_ALTERNATIVE) */

Overall great changes, just that small optimization to get rid of the
jump.

- Charlie

> +
> +#include <asm-generic/bitops/ffz.h>
>  #include <asm-generic/bitops/fls64.h>
>  #include <asm-generic/bitops/sched.h>
> -#include <asm-generic/bitops/ffs.h>
>  
>  #include <asm-generic/bitops/hweight.h>
>  
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index a1157c2a7170..d68cacd4e3af 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -28,7 +28,7 @@ cflags-$(CONFIG_ARM)		+= -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
>  				   -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
>  				   -DEFI_HAVE_STRCMP -fno-builtin -fpic \
>  				   $(call cc-option,-mno-single-pic-base)
> -cflags-$(CONFIG_RISCV)		+= -fpic
> +cflags-$(CONFIG_RISCV)		+= -fpic -DNO_ALTERNATIVE
>  cflags-$(CONFIG_LOONGARCH)	+= -fpie
>  
>  cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= -I$(srctree)/scripts/dtc/libfdt
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
