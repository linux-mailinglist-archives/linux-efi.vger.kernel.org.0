Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA80E7DC421
	for <lists+linux-efi@lfdr.de>; Tue, 31 Oct 2023 03:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjJaCCM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Oct 2023 22:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJaCCL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 30 Oct 2023 22:02:11 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEC9E6
        for <linux-efi@vger.kernel.org>; Mon, 30 Oct 2023 19:02:08 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6ce37d0f1a9so3313706a34.0
        for <linux-efi@vger.kernel.org>; Mon, 30 Oct 2023 19:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698717727; x=1699322527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yszt55EnKWGxg6KcB1UQhlAo9GCdqqf2M9pNnFPrkT0=;
        b=15itxU1Cg2QxBYkQDNhP4DetFGU3yw1a4Uxz4t+Xr36FhKTeOzafkdq7t8CNblZH/X
         DIKeZZqcSJT013/TyaeknFLbmTqJ0Zo08+dFvm6gI7tJiYQnjAJY3LQr3ZynT47q4jX6
         Auuj/0WAFzNiBP7a/krcw462gXcpMjz15r1s37ULekBV0RIQq1ALzCrfKZId0RDzbXdh
         sjPubCYYZgdUwg2KSzpIK9xahtDThr1nVq5oDHt00DZ4SMmtjC1j2WkTjPwV/7TWAqhk
         0MI6qgJO77K4C5j4D0ZV1gtKsvnZ0nBjsbba4ekrWL2a+YH4n6tdC4aMpySlnUo2ZkPm
         0vwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698717727; x=1699322527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yszt55EnKWGxg6KcB1UQhlAo9GCdqqf2M9pNnFPrkT0=;
        b=t9hb97ONedINAJRrVPr/3K698lxiM4YfxvuAq7l00ziyWKYm03ehsnpFyXIjezS+2a
         CTmQrXUtgHR9zjYTbrAsO+ctiJY6Ref/VJAT49Lm1sbuB5EHUlI6kUuV7kPlEdpjUWW+
         p2Ig+Xs12UYhmr2Dzjsk+cgJYLz4yKxU3syEJbeieaCdEYe2phteN0eSbljRBuoK0R7z
         LzbFtpBGJyqupndlMWR8OIWAgNQW7LDFE1eTGpS23KdZjAIK+pUpDfAczdVQveCBuNbR
         8d3/EQE/u0wjN8ufJ1SUqFRicWPyH/uxQFKIRAoDlVI3YNZcfekzsXzFJrWlRVSZVp3e
         CabQ==
X-Gm-Message-State: AOJu0Yxd+7v3hUxe7Qxs0wuS5NbLwU9CqSxLlmSzOx0vqBV0H/3gMNaG
        yZSfmYz2NPazrvGDWEfhIYrLSA==
X-Google-Smtp-Source: AGHT+IGK4VqWQMIzgkqfs2IclS4XLKer/QWMyoOJ9G9Uw/cvi3bkXdHizNw68b2feXrKwcFFmIHdgQ==
X-Received: by 2002:a9d:7d0c:0:b0:6b7:52ce:ff38 with SMTP id v12-20020a9d7d0c000000b006b752ceff38mr11470032otn.16.1698717727674;
        Mon, 30 Oct 2023 19:02:07 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:f2bd:1ee:3a71:49a])
        by smtp.gmail.com with ESMTPSA id d4-20020a05683025c400b006c7c1868b05sm59121otu.50.2023.10.30.19.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 19:02:07 -0700 (PDT)
Date:   Mon, 30 Oct 2023 19:02:04 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     "Wang, Xiao W" <xiao.w.wang@intel.com>
Cc:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "Li, Haicheng" <haicheng.li@intel.com>,
        "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
        "Liu, Yujie" <yujie.liu@intel.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] riscv: Optimize bitops with Zbb extension
Message-ID: <ZUBgHC1GBm/Jg+cy@ghost>
References: <20231030063904.2116277-1-xiao.w.wang@intel.com>
 <20231030063904.2116277-3-xiao.w.wang@intel.com>
 <ZUAT5gKXM+pU6r3w@ghost>
 <DM8PR11MB5751DE93BE278FF01576E5A5B8A0A@DM8PR11MB5751.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5751DE93BE278FF01576E5A5B8A0A@DM8PR11MB5751.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Oct 31, 2023 at 01:53:55AM +0000, Wang, Xiao W wrote:
> 
> 
> > -----Original Message-----
> > From: Charlie Jenkins <charlie@rivosinc.com>
> > Sent: Tuesday, October 31, 2023 4:37 AM
> > To: Wang, Xiao W <xiao.w.wang@intel.com>
> > Cc: paul.walmsley@sifive.com; palmer@dabbelt.com;
> > aou@eecs.berkeley.edu; ardb@kernel.org; anup@brainfault.org; Li, Haicheng
> > <haicheng.li@intel.com>; ajones@ventanamicro.com; Liu, Yujie
> > <yujie.liu@intel.com>; linux-riscv@lists.infradead.org; linux-
> > efi@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v4 2/2] riscv: Optimize bitops with Zbb extension
> > 
> > On Mon, Oct 30, 2023 at 02:39:04PM +0800, Xiao Wang wrote:
> > > This patch leverages the alternative mechanism to dynamically optimize
> > > bitops (including __ffs, __fls, ffs, fls) with Zbb instructions. When
> > > Zbb ext is not supported by the runtime CPU, legacy implementation is
> > > used. If Zbb is supported, then the optimized variants will be selected
> > > via alternative patching.
> > >
> > > The legacy bitops support is taken from the generic C implementation as
> > > fallback.
> > >
> > > If the parameter is a build-time constant, we leverage compiler builtin to
> > > calculate the result directly, this approach is inspired by x86 bitops
> > > implementation.
> > >
> > > EFI stub runs before the kernel, so alternative mechanism should not be
> > > used there, this patch introduces a macro NO_ALTERNATIVE for this
> > purpose.
> > >
> > > Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> > > ---
> > >  arch/riscv/include/asm/bitops.h       | 255 +++++++++++++++++++++++++-
> > >  drivers/bitopstest/Kconfig            |   1 +
> > >  drivers/firmware/efi/libstub/Makefile |   2 +-
> > >  3 files changed, 254 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/bitops.h
> > b/arch/riscv/include/asm/bitops.h
> > > index 3540b690944b..ef35c9ebc2ed 100644
> > > --- a/arch/riscv/include/asm/bitops.h
> > > +++ b/arch/riscv/include/asm/bitops.h
> > > @@ -15,13 +15,262 @@
> > >  #include <asm/barrier.h>
> > >  #include <asm/bitsperlong.h>
> > >
> > > +#if !defined(CONFIG_RISCV_ISA_ZBB) || defined(NO_ALTERNATIVE)
> > >  #include <asm-generic/bitops/__ffs.h>
> > > -#include <asm-generic/bitops/ffz.h>
> > > -#include <asm-generic/bitops/fls.h>
> > >  #include <asm-generic/bitops/__fls.h>
> > > +#include <asm-generic/bitops/ffs.h>
> > > +#include <asm-generic/bitops/fls.h>
> > > +
> > > +#else
> > > +#include <asm/alternative-macros.h>
> > > +#include <asm/hwcap.h>
> > > +
> > > +#if (BITS_PER_LONG == 64)
> > > +#define CTZW	"ctzw "
> > > +#define CLZW	"clzw "
> > > +#elif (BITS_PER_LONG == 32)
> > > +#define CTZW	"ctz "
> > > +#define CLZW	"clz "
> > > +#else
> > > +#error "Unexpected BITS_PER_LONG"
> > > +#endif
> > > +
> > > +static __always_inline unsigned long variable__ffs(unsigned long word)
> > > +{
> > > +	int num;
> > > +
> > > +	asm_volatile_goto(
> > > +		ALTERNATIVE("j %l[legacy]", "nop", 0, RISCV_ISA_EXT_ZBB, 1)
> > > +		: : : : legacy);
> > > +
> > 
> > On this and following asm blocks, checkpatch outputs:  "Lines should not
> > end with a '('".
> 
> I did below check, but I got no warning.
> # ./scripts/checkpatch.pl v4-0002-riscv-Optimize-bitops-with-Zbb-extension.patch
> total: 0 errors, 0 warnings, 280 lines checked
> May I know how you do the check?
> BTW, I see arch/riscv/include/asm/jump_label.h and arch/riscv/include/asm/cpufeature.h have similar code.

I normally use the --strict flag since that is what the Patchwork server
uses.

> 
> > 
> > > +	asm volatile (
> > > +		".option push\n"
> > > +		".option arch,+zbb\n"
> > > +		"ctz %0, %1\n"
> > > +		".option pop\n"
> > > +		: "=r" (word) : "r" (word) :);
> > > +
> > > +	return word;
> > > +
> > > +legacy:
> > > +	num = 0;
> > > +#if BITS_PER_LONG == 64
> > > +	if ((word & 0xffffffff) == 0) {
> > > +		num += 32;
> > > +		word >>= 32;
> > > +	}
> > > +#endif
> > > +	if ((word & 0xffff) == 0) {
> > > +		num += 16;
> > > +		word >>= 16;
> > > +	}
> > > +	if ((word & 0xff) == 0) {
> > > +		num += 8;
> > > +		word >>= 8;
> > > +	}
> > > +	if ((word & 0xf) == 0) {
> > > +		num += 4;
> > > +		word >>= 4;
> > > +	}
> > > +	if ((word & 0x3) == 0) {
> > > +		num += 2;
> > > +		word >>= 2;
> > > +	}
> > > +	if ((word & 0x1) == 0)
> > > +		num += 1;
> > > +	return num;
> > > +}
> > > +
> > > +/**
> > > + * __ffs - find first set bit in a long word
> > > + * @word: The word to search
> > > + *
> > > + * Undefined if no set bit exists, so code should check against 0 first.
> > > + */
> > > +#define __ffs(word)				\
> > > +	(__builtin_constant_p(word) ?		\
> > > +	 (unsigned long)__builtin_ctzl(word) :	\
> > > +	 variable__ffs(word))
> > > +
> > > +static __always_inline unsigned long variable__fls(unsigned long word)
> > > +{
> > > +	int num;
> > > +
> > > +	asm_volatile_goto(
> > > +		ALTERNATIVE("j %l[legacy]", "nop", 0, RISCV_ISA_EXT_ZBB, 1)
> > > +		: : : : legacy);
> > > +
> > > +	asm volatile (
> > > +		".option push\n"
> > > +		".option arch,+zbb\n"
> > > +		"clz %0, %1\n"
> > > +		".option pop\n"
> > > +		: "=r" (word) : "r" (word) :);
> > > +
> > > +	return BITS_PER_LONG - 1 - word;
> > > +
> > > +legacy:
> > > +	num = BITS_PER_LONG - 1;
> > > +#if BITS_PER_LONG == 64
> > > +	if (!(word & (~0ul << 32))) {
> > > +		num -= 32;
> > > +		word <<= 32;
> > > +	}
> > > +#endif
> > > +	if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
> > > +		num -= 16;
> > > +		word <<= 16;
> > > +	}
> > > +	if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
> > > +		num -= 8;
> > > +		word <<= 8;
> > > +	}
> > > +	if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
> > > +		num -= 4;
> > > +		word <<= 4;
> > > +	}
> > > +	if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
> > > +		num -= 2;
> > > +		word <<= 2;
> > > +	}
> > > +	if (!(word & (~0ul << (BITS_PER_LONG-1))))
> > > +		num -= 1;
> > > +	return num;
> > > +}
> > > +
> > > +/**
> > > + * __fls - find last set bit in a long word
> > > + * @word: the word to search
> > > + *
> > > + * Undefined if no set bit exists, so code should check against 0 first.
> > > + */
> > > +#define __fls(word)							\
> > > +	(__builtin_constant_p(word) ?					\
> > > +	 (unsigned long)(BITS_PER_LONG - 1 - __builtin_clzl(word)) :	\
> > > +	 variable__fls(word))
> > > +
> > > +static __always_inline int variable_ffs(int x)
> > > +{
> > > +	int r;
> > > +
> > > +	if (!x)
> > > +		return 0;
> > > +
> > > +	asm_volatile_goto(
> > > +		ALTERNATIVE("j %l[legacy]", "nop", 0, RISCV_ISA_EXT_ZBB, 1)
> > > +		: : : : legacy);
> > > +
> > > +	asm volatile (
> > > +		".option push\n"
> > > +		".option arch,+zbb\n"
> > > +		CTZW "%0, %1\n"
> > > +		".option pop\n"
> > > +		: "=r" (r) : "r" (x) :);
> > > +
> > > +	return r + 1;
> > > +
> > > +legacy:
> > > +	r = 1;
> > > +	if (!(x & 0xffff)) {
> > > +		x >>= 16;
> > > +		r += 16;
> > > +	}
> > > +	if (!(x & 0xff)) {
> > > +		x >>= 8;
> > > +		r += 8;
> > > +	}
> > > +	if (!(x & 0xf)) {
> > > +		x >>= 4;
> > > +		r += 4;
> > > +	}
> > > +	if (!(x & 3)) {
> > > +		x >>= 2;
> > > +		r += 2;
> > > +	}
> > > +	if (!(x & 1)) {
> > > +		x >>= 1;
> > > +		r += 1;
> > > +	}
> > > +	return r;
> > > +}
> > > +
> > > +/**
> > > + * ffs - find first set bit in a word
> > > + * @x: the word to search
> > > + *
> > > + * This is defined the same way as the libc and compiler builtin ffs routines.
> > > + *
> > > + * ffs(value) returns 0 if value is 0 or the position of the first set bit if
> > > + * value is nonzero. The first (least significant) bit is at position 1.
> > > + */
> > > +#define ffs(x) (__builtin_constant_p(x) ? __builtin_ffs(x) : variable_ffs(x))
> > > +
> > > +static __always_inline int variable_fls(unsigned int x)
> > > +{
> > > +	int r;
> > > +
> > > +	if (!x)
> > > +		return 0;
> > > +
> > > +	asm_volatile_goto(
> > > +		ALTERNATIVE("j %l[legacy]", "nop", 0, RISCV_ISA_EXT_ZBB, 1)
> > > +		: : : : legacy);
> > > +
> > > +	asm volatile (
> > > +		".option push\n"
> > > +		".option arch,+zbb\n"
> > > +		CLZW "%0, %1\n"
> > > +		".option pop\n"
> > > +		: "=r" (r) : "r" (x) :);
> > > +
> > > +	return 32 - r;
> > > +
> > > +legacy:
> > > +	r = 32;
> > > +	if (!(x & 0xffff0000u)) {
> > > +		x <<= 16;
> > > +		r -= 16;
> > > +	}
> > > +	if (!(x & 0xff000000u)) {
> > > +		x <<= 8;
> > > +		r -= 8;
> > > +	}
> > > +	if (!(x & 0xf0000000u)) {
> > > +		x <<= 4;
> > > +		r -= 4;
> > > +	}
> > > +	if (!(x & 0xc0000000u)) {
> > > +		x <<= 2;
> > > +		r -= 2;
> > > +	}
> > > +	if (!(x & 0x80000000u)) {
> > > +		x <<= 1;
> > > +		r -= 1;
> > > +	}
> > > +	return r;
> > > +}
> > > +
> > > +/**
> > > + * fls - find last set bit in a word
> > > + * @x: the word to search
> > > + *
> > > + * This is defined in a similar way as ffs, but returns the position of the most
> > > + * significant set bit.
> > > + *
> > > + * fls(value) returns 0 if value is 0 or the position of the last set bit if
> > > + * value is nonzero. The last (most significant) bit is at position 32.
> > > + */
> > > +#define fls(x)
> > 	\
> > > +	(__builtin_constant_p(x) ?					\
> > > +	 (int)(((x) != 0) ?						\
> > > +	  (sizeof(unsigned int) * 8 - __builtin_clz(x)) : 0) :		\
> > > +	 variable_fls(x))
> > > +
> > 
> > Checkpath complains: "Macro argument reuse 'x' - possible side-effects"
> > 
> 
> Ditto.
> 
> > > +#endif /* !defined(CONFIG_RISCV_ISA_ZBB) || defined(NO_ALTERNATIVE)
> > */
> > > +
> > > +#include <asm-generic/bitops/ffz.h>
> > >  #include <asm-generic/bitops/fls64.h>
> > >  #include <asm-generic/bitops/sched.h>
> > > -#include <asm-generic/bitops/ffs.h>
> > >
> > >  #include <asm-generic/bitops/hweight.h>
> > >
> > > diff --git a/drivers/bitopstest/Kconfig b/drivers/bitopstest/Kconfig
> > > index d0e2af4b801e..6ef6dcd41d49 100644
> > > --- a/drivers/bitopstest/Kconfig
> > > +++ b/drivers/bitopstest/Kconfig
> > > @@ -1,6 +1,7 @@
> > >  # SPDX-License-Identifier: GPL-2.0-only
> > >  menuconfig BITOPSTEST
> > >  	tristate "self test for bitops optimization"
> > > +	default y
> > >  	help
> > >  	  Enable this to test the bitops APIs.
> > 
> > Is this a test you wanted to add? The source code isn't included.
> 
> Sorry, I mistakenly did a "git add" for my local test. Will drop it.
> 
> BRs,
> Xiao
> 
> > 
> > - Charlie

In the next version after you remove this Kconfig file you can add my
reviewed-by signature to this series.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

> > 
> > >
> > > diff --git a/drivers/firmware/efi/libstub/Makefile
> > b/drivers/firmware/efi/libstub/Makefile
> > > index a1157c2a7170..d68cacd4e3af 100644
> > > --- a/drivers/firmware/efi/libstub/Makefile
> > > +++ b/drivers/firmware/efi/libstub/Makefile
> > > @@ -28,7 +28,7 @@ cflags-$(CONFIG_ARM)		+= -
> > DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
> > >  				   -DEFI_HAVE_MEMCHR -
> > DEFI_HAVE_STRRCHR \
> > >  				   -DEFI_HAVE_STRCMP -fno-builtin -fpic \
> > >  				   $(call cc-option,-mno-single-pic-base)
> > > -cflags-$(CONFIG_RISCV)		+= -fpic
> > > +cflags-$(CONFIG_RISCV)		+= -fpic -DNO_ALTERNATIVE
> > >  cflags-$(CONFIG_LOONGARCH)	+= -fpie
> > >
> > >  cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= -
> > I$(srctree)/scripts/dtc/libfdt
> > > --
> > > 2.25.1
> > >
