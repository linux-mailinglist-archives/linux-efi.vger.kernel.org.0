Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DF863F8D9
	for <lists+linux-efi@lfdr.de>; Thu,  1 Dec 2022 21:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiLAUPD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Dec 2022 15:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiLAUPC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Dec 2022 15:15:02 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A0ABEC72
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 12:15:01 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id b2so6889393eja.7
        for <linux-efi@vger.kernel.org>; Thu, 01 Dec 2022 12:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9rF1NBHq0ws7kSXVYhBS+x8P8oRVpTPLaBAUEFTH9TU=;
        b=NPkH1QUNG1gGoFux5lB6w0pjuTKq9L4+bXq0y1Z/jKx0vYcxbAdUbPYk8Nl3WV87qW
         0eLoQyMhgvv5Cj7s/tkekjt73EbzuTE4+1EVjYhObbav/mL3QsCAYWnOMverqaFLqb4Q
         /9Yqpv8eHlnr8Qzu6Sck/7lfYo2wfjnyGTqXyI8ltABvrtfQwym955lcxIzmS+wug/05
         khGKMeRBSCl82Ahy5G7eQZ0m/R9gKf1usbWnU+FoU3TI0b1mIkNrUuzpiEViTGrvnPEI
         hf89gJZLsrQp9Qh8oHr5A2jyj5yR+rqyDxRhT81bZdf9ypAs49eoB1Dx7/gqV1B0ieTZ
         tutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rF1NBHq0ws7kSXVYhBS+x8P8oRVpTPLaBAUEFTH9TU=;
        b=IoLHvAyP7XjBq8qwE1VQ2x0wbTtpRsa2QhucECfwmKWBcJWFPRVytbWwO6xlYLr7+o
         x1lC4aH4eyYZFq2B4wnV8+GkXp22/UOWVup/Y7YHw9ReKNx5g5RTlYulR/aseFd9//51
         aAdJXkGgd3HI1J+O9KbeKxZtBQp1XnDwUHOv7zyhfCAZNEeykrqyxKvcpNnNYBIoqBqJ
         6A0wwfhctDj+opORbSrMcOI/wo6i/ynmsk/2EUfC0c/Fha76VtY+KrMKD5RzRq9eiy5U
         7MRopUCLRQJzEySnBzeQ3fcg6YnAy0bYA7JjGlLEL2wum1OkETVlomlKzCSnHtQpooPV
         zs3w==
X-Gm-Message-State: ANoB5pm+mTF1BTZ691/N2wEkCSa9fNzAWh6PHyGekvs2M+weKnSvPR28
        LZJ6KJjYhAjI4/3s/dwbi9k4gg==
X-Google-Smtp-Source: AA0mqf7SaOX9ybqiK/iTGk8JaGFuCGpQaDY9S0JuAbi+O6nB2sREmIXrwV8v6okdwkS7xQ3wAuv+mQ==
X-Received: by 2002:a17:907:9951:b0:7b2:7e7a:11c1 with SMTP id kl17-20020a170907995100b007b27e7a11c1mr41214691ejc.684.1669925700036;
        Thu, 01 Dec 2022 12:15:00 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id q2-20020a17090676c200b00770812e2394sm2127407ejn.160.2022.12.01.12.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 12:14:59 -0800 (PST)
Date:   Thu, 1 Dec 2022 21:14:57 +0100
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
Message-ID: <20221201201457.azddav22awamxsru@kamzik>
References: <20221130225614.1594256-1-heiko@sntech.de>
 <20221130225614.1594256-14-heiko@sntech.de>
 <20221201200739.t5bnm5kjnopeyygd@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201200739.t5bnm5kjnopeyygd@kamzik>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Dec 01, 2022 at 09:07:41PM +0100, Andrew Jones wrote:
> On Wed, Nov 30, 2022 at 11:56:13PM +0100, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > 
> > Depending on supported extensions on specific RISC-V cores,
> > optimized str* functions might make sense.
> > 
> > This adds basic infrastructure to allow patching the function calls
> > via alternatives later on.
> > 
> > The main idea is to have the core str* functions be inline functions
> > which then call the most optimized variant and this call then be
> > replaced via alternatives.
> > 
> > The big advantage is that we don't need additional calls.
> > Though we need to duplicate the generic functions as the main code
> > expects either itself or the architecture to provide the str* functions.
> 
> That's a bummer, but at least the duplicated functions are simple.
> 
> > 
> > The added *_generic functions are done in assembler (taken from
> > disassembling the main-kernel functions for now) to allow us to control
> > the used registers.
> > 
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > ---
> >  arch/riscv/Makefile             |  3 ++
> >  arch/riscv/include/asm/string.h | 66 +++++++++++++++++++++++++++++++++
> >  arch/riscv/kernel/image-vars.h  |  6 +--
> >  arch/riscv/lib/Makefile         |  3 ++
> >  arch/riscv/lib/strcmp.S         | 38 +++++++++++++++++++
> >  arch/riscv/lib/strlen.S         | 29 +++++++++++++++
> >  arch/riscv/lib/strncmp.S        | 41 ++++++++++++++++++++
> >  7 files changed, 183 insertions(+), 3 deletions(-)
> >  create mode 100644 arch/riscv/lib/strcmp.S
> >  create mode 100644 arch/riscv/lib/strlen.S
> >  create mode 100644 arch/riscv/lib/strncmp.S
> > 
> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > index 0d13b597cb55..581e4370c2a6 100644
> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -80,6 +80,9 @@ ifeq ($(CONFIG_PERF_EVENTS),y)
> >          KBUILD_CFLAGS += -fno-omit-frame-pointer
> >  endif
> >  
> > +# strchr is special case, as gcc might want to call its own strlen from there
> > +KBUILD_CFLAGS += -fno-builtin-strlen -fno-builtin-strcmp -fno-builtin-strncmp -fno-builtin-strchr
> > +
> >  KBUILD_CFLAGS_MODULE += $(call cc-option,-mno-relax)
> >  KBUILD_AFLAGS_MODULE += $(call as-option,-Wa$(comma)-mno-relax)
> >  
> > diff --git a/arch/riscv/include/asm/string.h b/arch/riscv/include/asm/string.h
> > index 909049366555..b98481d2d154 100644
> > --- a/arch/riscv/include/asm/string.h
> > +++ b/arch/riscv/include/asm/string.h
> > @@ -18,6 +18,72 @@ extern asmlinkage void *__memcpy(void *, const void *, size_t);
> >  #define __HAVE_ARCH_MEMMOVE
> >  extern asmlinkage void *memmove(void *, const void *, size_t);
> >  extern asmlinkage void *__memmove(void *, const void *, size_t);
> > +
> > +#define __HAVE_ARCH_STRCMP
> > +extern asmlinkage int __strcmp_generic(const char *cs, const char *ct);
> > +
> > +static inline int strcmp(const char *cs, const char *ct)
> > +{
> > +#ifdef RISCV_EFISTUB
> > +	return __strcmp_generic(cs, ct);
> > +#else
> > +	register const char *a0 asm("a0") = cs;
> > +	register const char *a1 asm("a1") = ct;
> > +	register int a0_out asm("a0");
> > +
> > +	asm volatile("call __strcmp_generic\n\t"
> > +		: "=r"(a0_out)
> > +		: "r"(a0), "r"(a1)
> > +		: "ra", "t0", "t1", "t2");

Don't we need "memory" in all these clobber lists?

Thanks,
drew

> > +
> > +	return a0_out;
> > +#endif
> > +}
> > +
> > +#define __HAVE_ARCH_STRNCMP
> > +extern asmlinkage int __strncmp_generic(const char *cs,
> > +					const char *ct, size_t count);
> > +
> > +static inline int strncmp(const char *cs, const char *ct, size_t count)
> > +{
> > +#ifdef RISCV_EFISTUB
> > +	return __strncmp_generic(cs, ct, count);
> > +#else
> > +	register const char *a0 asm("a0") = cs;
> > +	register const char *a1 asm("a1") = ct;
> > +	register size_t a2 asm("a2") = count;
> > +	register int a0_out asm("a0");
> > +
> > +	asm volatile("call __strncmp_generic\n\t"
> > +		: "=r"(a0_out)
> > +		: "r"(a0), "r"(a1), "r"(a2)
> > +		: "ra", "t0", "t1", "t2");
> > +
> > +	return a0_out;
> > +#endif
> > +}
> > +
> > +#define __HAVE_ARCH_STRLEN
> > +extern asmlinkage __kernel_size_t __strlen_generic(const char *);
> > +
> > +static inline __kernel_size_t strlen(const char *s)
> > +{
> > +#ifdef RISCV_EFISTUB
> > +	return __strlen_generic(s);
> > +#else
> > +	register const char *a0 asm("a0") = s;
> > +	register int a0_out asm("a0");
> > +
> > +	asm volatile(
> > +		"call __strlen_generic\n\t"
> > +		: "=r"(a0_out)
> > +		: "r"(a0)
> > +		: "ra", "t0", "t1");
> > +
> > +	return a0_out;
> > +#endif
> > +}
> > +
> >  /* For those files which don't want to check by kasan. */
> >  #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
> >  #define memcpy(dst, src, len) __memcpy(dst, src, len)
> > diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image-vars.h
> > index d6e5f739905e..2f270b9fde63 100644
> > --- a/arch/riscv/kernel/image-vars.h
> > +++ b/arch/riscv/kernel/image-vars.h
> > @@ -25,10 +25,10 @@
> >   */
> >  __efistub_memcmp		= memcmp;
> >  __efistub_memchr		= memchr;
> > -__efistub_strlen		= strlen;
> > +__efistub___strlen_generic	= __strlen_generic;
> >  __efistub_strnlen		= strnlen;
> > -__efistub_strcmp		= strcmp;
> > -__efistub_strncmp		= strncmp;
> > +__efistub___strcmp_generic	= __strcmp_generic;
> > +__efistub___strncmp_generic	= __strncmp_generic;
> >  __efistub_strrchr		= strrchr;
> >  
> >  __efistub__start		= _start;
> > diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
> > index 25d5c9664e57..6c74b0bedd60 100644
> > --- a/arch/riscv/lib/Makefile
> > +++ b/arch/riscv/lib/Makefile
> > @@ -3,6 +3,9 @@ lib-y			+= delay.o
> >  lib-y			+= memcpy.o
> >  lib-y			+= memset.o
> >  lib-y			+= memmove.o
> > +lib-y			+= strcmp.o
> > +lib-y			+= strlen.o
> > +lib-y			+= strncmp.o
> 
> Can't we just create a single string.S file?
> 
> >  lib-$(CONFIG_MMU)	+= uaccess.o
> >  lib-$(CONFIG_64BIT)	+= tishift.o
> >  
> > diff --git a/arch/riscv/lib/strcmp.S b/arch/riscv/lib/strcmp.S
> > new file mode 100644
> > index 000000000000..f4b7f4e806f0
> > --- /dev/null
> > +++ b/arch/riscv/lib/strcmp.S
> > @@ -0,0 +1,38 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#include <linux/linkage.h>
> > +#include <asm/asm.h>
> > +#include <asm-generic/export.h>
> > +
> > +/* int __strcmp_generic(const char *cs, const char *ct) */
> > +ENTRY(__strcmp_generic)
> > +	/*
> > +	 * Returns
> > +	 *   a0 - comparison result, value like strcmp
> > +	 *
> > +	 * Parameters
> > +	 *   a0 - string1
> > +	 *   a1 - string2
> > +	 *
> > +	 * Clobbers
> > +	 *   t0, t1, t2
> > +	 */
> > +	mv	t2, a1
> > +1:
> > +	lbu	t1, 0(a0)
> > +	lbu	t0, 0(a1)
> > +	addi	a0, a0, 1
> > +	addi	a1, a1, 1
> > +	beq	t1, t0, 3f
> > +	li	a0, 1
> > +	bgeu	t1, t0, 2f
> > +	li	a0, -1
> > +2:
> > +	mv	a1, t2
> > +	ret
> > +3:
> > +	bnez	t1, 1b
> > +	li	a0, 0
> > +	j	2b
> > +END(__strcmp_generic)
> > +EXPORT_SYMBOL(__strcmp_generic)
> > diff --git a/arch/riscv/lib/strlen.S b/arch/riscv/lib/strlen.S
> > new file mode 100644
> > index 000000000000..e0e7440ac724
> > --- /dev/null
> > +++ b/arch/riscv/lib/strlen.S
> > @@ -0,0 +1,29 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#include <linux/linkage.h>
> > +#include <asm/asm.h>
> > +#include <asm-generic/export.h>
> > +
> > +/* int __strlen_generic(const char *s) */
> > +ENTRY(__strlen_generic)
> > +	/*
> > +	 * Returns
> > +	 *   a0 - string length
> > +	 *
> > +	 * Parameters
> > +	 *   a0 - String to measure
> > +	 *
> > +	 * Clobbers:
> > +	 *   t0, t1
> > +	 */
> > +	mv	t1, a0
> > +1:
> > +	lbu	t0, 0(t1)
> > +	bnez	t0, 2f
> > +	sub	a0, t1, a0
> > +	ret
> > +2:
> > +	addi	t1, t1, 1
> > +	j	1b
> > +END(__strlen_generic)
> > +EXPORT_SYMBOL(__strlen_generic)
> > diff --git a/arch/riscv/lib/strncmp.S b/arch/riscv/lib/strncmp.S
> > new file mode 100644
> > index 000000000000..7e116d942265
> > --- /dev/null
> > +++ b/arch/riscv/lib/strncmp.S
> > @@ -0,0 +1,41 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#include <linux/linkage.h>
> > +#include <asm/asm.h>
> > +#include <asm-generic/export.h>
> > +
> > +/* int __strncmp_generic(const char *cs, const char *ct, size_t count) */
> > +ENTRY(__strncmp_generic)
> > +	/*
> > +	 * Returns
> > +	 *   a0 - comparison result, value like strncmp
> > +	 *
> > +	 * Parameters
> > +	 *   a0 - string1
> > +	 *   a1 - string2
> > +	 *   a2 - number of characters to compare
> > +	 *
> > +	 * Clobbers
> > +	 *   t0, t1, t2
> > +	 */
> > +	li	t0, 0
> > +1:
> > +	beq	a2, t0, 4f
> > +	add	t1, a0, t0
> > +	add	t2, a1, t0
> > +	lbu	t1, 0(t1)
> > +	lbu	t2, 0(t2)
> > +	beq	t1, t2, 3f
> > +	li	a0, 1
> > +	bgeu	t1, t2, 2f
> > +	li	a0, -1
> > +2:
> > +	ret
> > +3:
> > +	addi	t0, t0, 1
> > +	bnez	t1, 1b
> > +4:
> > +	li	a0, 0
> > +	j	2b
> > +END(__strncmp_generic)
> > +EXPORT_SYMBOL(__strncmp_generic)
> > -- 
> > 2.35.1
> >
> 
> Besides the consolidation of functions to one file request,
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
> Thanks,
> drew
