Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A194363F8C7
	for <lists+linux-efi@lfdr.de>; Thu,  1 Dec 2022 21:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiLAUHq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Dec 2022 15:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiLAUHp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Dec 2022 15:07:45 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373A216581
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 12:07:42 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id gu23so6810122ejb.10
        for <linux-efi@vger.kernel.org>; Thu, 01 Dec 2022 12:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qM3bl2BktgRaqgaHH9cukpNicbPFUy0vbzMn1dB0K1s=;
        b=dQ+LhnNfuxERUE7TSrFNBPyL4g1gAsRP80r3DtrYSc3ncXaMkRgIKVsly+w5XEQNB+
         uvgQhlSn3cvXOkeneBpmOqvTHoJVnhjeX4ixA+euUQ6dyBkHjykTINAj4eX2dnlT0Drr
         HD2v+q3CmHMrJGlX3RXCLgNN2wUW9H1i3X3PtEdUJ/JaKxT0qdzT95V1xd5Viga08fLS
         mj7/LzMp3psVC1LZidDJxQXDzFrBc/YqwgK2lL3Zz5zpYKPi71CWnLsoFPL02K8TNLSe
         68EbpnoYo8h91sj6i/mToKt6EWw/PnlRPzt16KASWAv+a5TZAWj4NuF6KI84MhoSLm3s
         7iIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qM3bl2BktgRaqgaHH9cukpNicbPFUy0vbzMn1dB0K1s=;
        b=t3ORYjq0K0A8JzEaCIEPRqpZAxsuSfwOnw87iiKBGmw4sFLrvtKjxGt0ZnXVvDDb8r
         bUj0gYRf8mWg3cbAJsTsZR5WMvbJprq7GV2SwoUr5TKGySLakxwxvbjZnZlTQ9oBlLlQ
         mjHuceTMmd/EXShHLjFYUO9i1jC0u+89ZU70WoN2qTWrJEI8ESmoFJD4p1VI2aJqeivy
         oJLUFGv+6gPphhfNISvQ1Ms+h08CmoR3o5FiN4pfu/tVaOh+RrjKQNSLZj4V8evo24H4
         CUViHaMsyHSka785WRp+ZSo6uDl4SK7Y+UjOe6kZeVHaIyIO0u9cOzMKP2bgeU40Yzah
         y6nw==
X-Gm-Message-State: ANoB5pkRq9GLKwWX+03NugGgpfnZ1SCS1RcsnNj4XZ9bdPzvEkY7kNg1
        ktGTmRBX6kiz3EcRJO+Ep/7pPA==
X-Google-Smtp-Source: AA0mqf6kyRlzqQgZMnFy4mDBSbekYCkY8UNQYrOe+oWs/lYZN7ydlFdtFTkrJSP5IIp7cNuM3J5/GA==
X-Received: by 2002:a17:906:9d16:b0:7ae:c45b:98fb with SMTP id fn22-20020a1709069d1600b007aec45b98fbmr47752721ejc.478.1669925261322;
        Thu, 01 Dec 2022 12:07:41 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id ha7-20020a170906a88700b007c0bb571da5sm421321ejb.41.2022.12.01.12.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 12:07:40 -0800 (PST)
Date:   Thu, 1 Dec 2022 21:07:39 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        christoph.muellner@vrull.eu, prabhakar.csengg@gmail.com,
        conor@kernel.org, philipp.tomsich@vrull.eu,
        emil.renner.berthing@canonical.com, ardb@kernel.org,
        linux-efi@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 13/14] RISC-V: add infrastructure to allow different
 str* implementations
Message-ID: <20221201200739.t5bnm5kjnopeyygd@kamzik>
References: <20221130225614.1594256-1-heiko@sntech.de>
 <20221130225614.1594256-14-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130225614.1594256-14-heiko@sntech.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 30, 2022 at 11:56:13PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> Depending on supported extensions on specific RISC-V cores,
> optimized str* functions might make sense.
> 
> This adds basic infrastructure to allow patching the function calls
> via alternatives later on.
> 
> The main idea is to have the core str* functions be inline functions
> which then call the most optimized variant and this call then be
> replaced via alternatives.
> 
> The big advantage is that we don't need additional calls.
> Though we need to duplicate the generic functions as the main code
> expects either itself or the architecture to provide the str* functions.

That's a bummer, but at least the duplicated functions are simple.

> 
> The added *_generic functions are done in assembler (taken from
> disassembling the main-kernel functions for now) to allow us to control
> the used registers.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> ---
>  arch/riscv/Makefile             |  3 ++
>  arch/riscv/include/asm/string.h | 66 +++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/image-vars.h  |  6 +--
>  arch/riscv/lib/Makefile         |  3 ++
>  arch/riscv/lib/strcmp.S         | 38 +++++++++++++++++++
>  arch/riscv/lib/strlen.S         | 29 +++++++++++++++
>  arch/riscv/lib/strncmp.S        | 41 ++++++++++++++++++++
>  7 files changed, 183 insertions(+), 3 deletions(-)
>  create mode 100644 arch/riscv/lib/strcmp.S
>  create mode 100644 arch/riscv/lib/strlen.S
>  create mode 100644 arch/riscv/lib/strncmp.S
> 
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 0d13b597cb55..581e4370c2a6 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -80,6 +80,9 @@ ifeq ($(CONFIG_PERF_EVENTS),y)
>          KBUILD_CFLAGS += -fno-omit-frame-pointer
>  endif
>  
> +# strchr is special case, as gcc might want to call its own strlen from there
> +KBUILD_CFLAGS += -fno-builtin-strlen -fno-builtin-strcmp -fno-builtin-strncmp -fno-builtin-strchr
> +
>  KBUILD_CFLAGS_MODULE += $(call cc-option,-mno-relax)
>  KBUILD_AFLAGS_MODULE += $(call as-option,-Wa$(comma)-mno-relax)
>  
> diff --git a/arch/riscv/include/asm/string.h b/arch/riscv/include/asm/string.h
> index 909049366555..b98481d2d154 100644
> --- a/arch/riscv/include/asm/string.h
> +++ b/arch/riscv/include/asm/string.h
> @@ -18,6 +18,72 @@ extern asmlinkage void *__memcpy(void *, const void *, size_t);
>  #define __HAVE_ARCH_MEMMOVE
>  extern asmlinkage void *memmove(void *, const void *, size_t);
>  extern asmlinkage void *__memmove(void *, const void *, size_t);
> +
> +#define __HAVE_ARCH_STRCMP
> +extern asmlinkage int __strcmp_generic(const char *cs, const char *ct);
> +
> +static inline int strcmp(const char *cs, const char *ct)
> +{
> +#ifdef RISCV_EFISTUB
> +	return __strcmp_generic(cs, ct);
> +#else
> +	register const char *a0 asm("a0") = cs;
> +	register const char *a1 asm("a1") = ct;
> +	register int a0_out asm("a0");
> +
> +	asm volatile("call __strcmp_generic\n\t"
> +		: "=r"(a0_out)
> +		: "r"(a0), "r"(a1)
> +		: "ra", "t0", "t1", "t2");
> +
> +	return a0_out;
> +#endif
> +}
> +
> +#define __HAVE_ARCH_STRNCMP
> +extern asmlinkage int __strncmp_generic(const char *cs,
> +					const char *ct, size_t count);
> +
> +static inline int strncmp(const char *cs, const char *ct, size_t count)
> +{
> +#ifdef RISCV_EFISTUB
> +	return __strncmp_generic(cs, ct, count);
> +#else
> +	register const char *a0 asm("a0") = cs;
> +	register const char *a1 asm("a1") = ct;
> +	register size_t a2 asm("a2") = count;
> +	register int a0_out asm("a0");
> +
> +	asm volatile("call __strncmp_generic\n\t"
> +		: "=r"(a0_out)
> +		: "r"(a0), "r"(a1), "r"(a2)
> +		: "ra", "t0", "t1", "t2");
> +
> +	return a0_out;
> +#endif
> +}
> +
> +#define __HAVE_ARCH_STRLEN
> +extern asmlinkage __kernel_size_t __strlen_generic(const char *);
> +
> +static inline __kernel_size_t strlen(const char *s)
> +{
> +#ifdef RISCV_EFISTUB
> +	return __strlen_generic(s);
> +#else
> +	register const char *a0 asm("a0") = s;
> +	register int a0_out asm("a0");
> +
> +	asm volatile(
> +		"call __strlen_generic\n\t"
> +		: "=r"(a0_out)
> +		: "r"(a0)
> +		: "ra", "t0", "t1");
> +
> +	return a0_out;
> +#endif
> +}
> +
>  /* For those files which don't want to check by kasan. */
>  #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
>  #define memcpy(dst, src, len) __memcpy(dst, src, len)
> diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image-vars.h
> index d6e5f739905e..2f270b9fde63 100644
> --- a/arch/riscv/kernel/image-vars.h
> +++ b/arch/riscv/kernel/image-vars.h
> @@ -25,10 +25,10 @@
>   */
>  __efistub_memcmp		= memcmp;
>  __efistub_memchr		= memchr;
> -__efistub_strlen		= strlen;
> +__efistub___strlen_generic	= __strlen_generic;
>  __efistub_strnlen		= strnlen;
> -__efistub_strcmp		= strcmp;
> -__efistub_strncmp		= strncmp;
> +__efistub___strcmp_generic	= __strcmp_generic;
> +__efistub___strncmp_generic	= __strncmp_generic;
>  __efistub_strrchr		= strrchr;
>  
>  __efistub__start		= _start;
> diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
> index 25d5c9664e57..6c74b0bedd60 100644
> --- a/arch/riscv/lib/Makefile
> +++ b/arch/riscv/lib/Makefile
> @@ -3,6 +3,9 @@ lib-y			+= delay.o
>  lib-y			+= memcpy.o
>  lib-y			+= memset.o
>  lib-y			+= memmove.o
> +lib-y			+= strcmp.o
> +lib-y			+= strlen.o
> +lib-y			+= strncmp.o

Can't we just create a single string.S file?

>  lib-$(CONFIG_MMU)	+= uaccess.o
>  lib-$(CONFIG_64BIT)	+= tishift.o
>  
> diff --git a/arch/riscv/lib/strcmp.S b/arch/riscv/lib/strcmp.S
> new file mode 100644
> index 000000000000..f4b7f4e806f0
> --- /dev/null
> +++ b/arch/riscv/lib/strcmp.S
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#include <linux/linkage.h>
> +#include <asm/asm.h>
> +#include <asm-generic/export.h>
> +
> +/* int __strcmp_generic(const char *cs, const char *ct) */
> +ENTRY(__strcmp_generic)
> +	/*
> +	 * Returns
> +	 *   a0 - comparison result, value like strcmp
> +	 *
> +	 * Parameters
> +	 *   a0 - string1
> +	 *   a1 - string2
> +	 *
> +	 * Clobbers
> +	 *   t0, t1, t2
> +	 */
> +	mv	t2, a1
> +1:
> +	lbu	t1, 0(a0)
> +	lbu	t0, 0(a1)
> +	addi	a0, a0, 1
> +	addi	a1, a1, 1
> +	beq	t1, t0, 3f
> +	li	a0, 1
> +	bgeu	t1, t0, 2f
> +	li	a0, -1
> +2:
> +	mv	a1, t2
> +	ret
> +3:
> +	bnez	t1, 1b
> +	li	a0, 0
> +	j	2b
> +END(__strcmp_generic)
> +EXPORT_SYMBOL(__strcmp_generic)
> diff --git a/arch/riscv/lib/strlen.S b/arch/riscv/lib/strlen.S
> new file mode 100644
> index 000000000000..e0e7440ac724
> --- /dev/null
> +++ b/arch/riscv/lib/strlen.S
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#include <linux/linkage.h>
> +#include <asm/asm.h>
> +#include <asm-generic/export.h>
> +
> +/* int __strlen_generic(const char *s) */
> +ENTRY(__strlen_generic)
> +	/*
> +	 * Returns
> +	 *   a0 - string length
> +	 *
> +	 * Parameters
> +	 *   a0 - String to measure
> +	 *
> +	 * Clobbers:
> +	 *   t0, t1
> +	 */
> +	mv	t1, a0
> +1:
> +	lbu	t0, 0(t1)
> +	bnez	t0, 2f
> +	sub	a0, t1, a0
> +	ret
> +2:
> +	addi	t1, t1, 1
> +	j	1b
> +END(__strlen_generic)
> +EXPORT_SYMBOL(__strlen_generic)
> diff --git a/arch/riscv/lib/strncmp.S b/arch/riscv/lib/strncmp.S
> new file mode 100644
> index 000000000000..7e116d942265
> --- /dev/null
> +++ b/arch/riscv/lib/strncmp.S
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#include <linux/linkage.h>
> +#include <asm/asm.h>
> +#include <asm-generic/export.h>
> +
> +/* int __strncmp_generic(const char *cs, const char *ct, size_t count) */
> +ENTRY(__strncmp_generic)
> +	/*
> +	 * Returns
> +	 *   a0 - comparison result, value like strncmp
> +	 *
> +	 * Parameters
> +	 *   a0 - string1
> +	 *   a1 - string2
> +	 *   a2 - number of characters to compare
> +	 *
> +	 * Clobbers
> +	 *   t0, t1, t2
> +	 */
> +	li	t0, 0
> +1:
> +	beq	a2, t0, 4f
> +	add	t1, a0, t0
> +	add	t2, a1, t0
> +	lbu	t1, 0(t1)
> +	lbu	t2, 0(t2)
> +	beq	t1, t2, 3f
> +	li	a0, 1
> +	bgeu	t1, t2, 2f
> +	li	a0, -1
> +2:
> +	ret
> +3:
> +	addi	t0, t0, 1
> +	bnez	t1, 1b
> +4:
> +	li	a0, 0
> +	j	2b
> +END(__strncmp_generic)
> +EXPORT_SYMBOL(__strncmp_generic)
> -- 
> 2.35.1
>

Besides the consolidation of functions to one file request,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
