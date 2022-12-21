Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5836653260
	for <lists+linux-efi@lfdr.de>; Wed, 21 Dec 2022 15:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbiLUOYC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Dec 2022 09:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbiLUOX6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Dec 2022 09:23:58 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E6722BF9
        for <linux-efi@vger.kernel.org>; Wed, 21 Dec 2022 06:23:48 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id f13-20020a1cc90d000000b003d08c4cf679so1559349wmb.5
        for <linux-efi@vger.kernel.org>; Wed, 21 Dec 2022 06:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pHd3rehtJfdxGw9liVvNFHcBIni6Z85SwwxIj+0xI2s=;
        b=Rdsoz3upzbF0KnB5RMQeOiafL2CuQGOxPgVFaKN3yTg/y656JrD/yAoz2eNT/KouGG
         ECzmoDoug9ucNRY9BULO+DrZpmvpKGZLmKxG7nbWu5P0hSo2G7VJXU6Rdelud2+aJcm1
         9pzdU8Kl7Y/P2Zoa03cfGIlZgfjkWiWaHzp6KiPpenU3GxiPNgnFcwT/PJHoYC1R+k0D
         ogeKzhLTPEFwYt7PsPjj045vhM1eQ2jHX4VXV3jBQAi4UD/pj9qzw/TCBe/iyQ8zE7Xw
         NZrovzgb07r/oCvSmVMUdnGVfdAkdEkb7OpdtJaM8lYIdavk7GYPT5WMvuKrKvdJajFC
         yRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHd3rehtJfdxGw9liVvNFHcBIni6Z85SwwxIj+0xI2s=;
        b=yDw7XRDmYsci7emSQTxiOExh+JcHs1oiTUdTmm0Kn2obeJbnKmkhmfGBExymfafPwp
         xKwfjZikkC+kKHiwFGTJw8abhP1pkVq9upBBZS5/41ont8ZyhY3jSNYgv/FybeMK7O0j
         axdm1Ry9SfpV8nRYZFkDlQL8VkXHKtm/3X8TH5p8hwo0DKFAoPWux2A+BST5lzZJH6QR
         lS3EJkUOhWmBdE5W4WL9uPxTCTmTGwixNwq37FtHN5WRsEYOt1pSgP2JeeZtkr4iDrLq
         zjYgcK0IXWr2D7bIwR59Cz1FCBrKp/mJpdq7cFcsZyW7fyIbtdwz9RxAtV+JPRij97NH
         lBQA==
X-Gm-Message-State: AFqh2kppS7Q/Qqfh0W2Zfs+1zw5pHbqUJvDs7dBt7VoNDHiEtzbM74Oo
        uiL+uoTxkInWryNxkK8Rj9ZgxL3SrOo+Scc6AYZLMA==
X-Google-Smtp-Source: AMrXdXsB84kMk8mAXxtr/f9tZ0L/u3ul+lmOdS6DfXlM9ey8JK+C/2BS3j/slVxQM6a+wlCgKDAjV7cFTYERnjjjoNA=
X-Received: by 2002:a05:600c:3d16:b0:3cf:a80d:59cd with SMTP id
 bh22-20020a05600c3d1600b003cfa80d59cdmr137973wmb.5.1671632626854; Wed, 21 Dec
 2022 06:23:46 -0800 (PST)
MIME-Version: 1.0
References: <20221216162141.1701255-1-alexghiti@rivosinc.com>
 <20221216162141.1701255-5-alexghiti@rivosinc.com> <Y6MSxBaJU7JqfkJO@spud>
In-Reply-To: <Y6MSxBaJU7JqfkJO@spud>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Wed, 21 Dec 2022 15:23:36 +0100
Message-ID: <CAHVXubgzac0gXNF2FVeUrCAnOe7U9QhAfj3nWd_jc0maaepN2g@mail.gmail.com>
Subject: Re: [PATCH 4/6] riscv: Fix EFI stub usage of KASAN instrumented
 string functions
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Conor,

On Wed, Dec 21, 2022 at 3:06 PM Conor Dooley <conor@kernel.org> wrote:
>
> Hey Alex!
>
> On Fri, Dec 16, 2022 at 05:21:39PM +0100, Alexandre Ghiti wrote:
> > The EFI stub must not use any KASAN instrumented code as the kernel
> > proper did not initialize the thread pointer and the mapping for the
> > KASAN shadow region.
> >
> > Avoid using generic string functions by copying stub dependencies from
> > lib/string.c to drivers/firmware/efi/libstub/string.c as RISC-V does
> > not implement architecture-specific versions of those functions.
>
> To the unaware among us, how does this interact with Heiko's custom
> functions for bitmanip extensions? Is this diametrically opposed to
> that, or does it actually help avoid having to have special handling
> for the efi stub?

I'm not sure which patchset you are referring to, but I guess you are
talking about arch-specific string functions:

- If they are written in assembly and are then not kasan-instrumented,
we'll be able to use them and then revert part of this patch.
- If they are written in C and are then kasan-instrumented (because
we'll want to instrument them), we'll keep using the implementation
added here.

Hope that answers your question!

Alex

>
> Also, checkpatch seems to be rather unhappy with you here:
> https://gist.github.com/conor-pwbot/e5b4c8f2c3b88b4a8fcab4df437613e2

Yes, those new functions are exact copies from lib/string.c, I did not
want to fix those checkpatch errors in this patchset.

>
> Thanks,
> Conor.
>
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/kernel/image-vars.h        |   8 --
> >  drivers/firmware/efi/libstub/Makefile |   7 +-
> >  drivers/firmware/efi/libstub/string.c | 133 ++++++++++++++++++++++++++
> >  3 files changed, 137 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image-vars.h
> > index d6e5f739905e..15616155008c 100644
> > --- a/arch/riscv/kernel/image-vars.h
> > +++ b/arch/riscv/kernel/image-vars.h
> > @@ -23,14 +23,6 @@
> >   * linked at. The routines below are all implemented in assembler in a
> >   * position independent manner
> >   */
> > -__efistub_memcmp             = memcmp;
> > -__efistub_memchr             = memchr;
> > -__efistub_strlen             = strlen;
> > -__efistub_strnlen            = strnlen;
> > -__efistub_strcmp             = strcmp;
> > -__efistub_strncmp            = strncmp;
> > -__efistub_strrchr            = strrchr;
> > -
> >  __efistub__start             = _start;
> >  __efistub__start_kernel              = _start_kernel;
> >  __efistub__end                       = _end;
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > index b1601aad7e1a..031d2268bab5 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -130,9 +130,10 @@ STUBCOPY_RELOC-$(CONFIG_ARM)     := R_ARM_ABS
> >  # also means that we need to be extra careful to make sure that the stub does
> >  # not rely on any absolute symbol references, considering that the virtual
> >  # kernel mapping that the linker uses is not active yet when the stub is
> > -# executing. So build all C dependencies of the EFI stub into libstub, and do
> > -# a verification pass to see if any absolute relocations exist in any of the
> > -# object files.
> > +# executing. In addition, we need to make sure that the stub does not use KASAN
> > +# instrumented code like the generic string functions. So build all C
> > +# dependencies of the EFI stub into libstub, and do a verification pass to see
> > +# if any absolute relocations exist in any of the object files.
> >  #
> >  STUBCOPY_FLAGS-$(CONFIG_ARM64)       += --prefix-alloc-sections=.init \
> >                                  --prefix-symbols=__efistub_
> > diff --git a/drivers/firmware/efi/libstub/string.c b/drivers/firmware/efi/libstub/string.c
> > index 5d13e43869ee..5154ae6e7f10 100644
> > --- a/drivers/firmware/efi/libstub/string.c
> > +++ b/drivers/firmware/efi/libstub/string.c
> > @@ -113,3 +113,136 @@ long simple_strtol(const char *cp, char **endp, unsigned int base)
> >
> >       return simple_strtoull(cp, endp, base);
> >  }
> > +
> > +#ifndef __HAVE_ARCH_STRLEN
> > +/**
> > + * strlen - Find the length of a string
> > + * @s: The string to be sized
> > + */
> > +size_t strlen(const char *s)
> > +{
> > +     const char *sc;
> > +
> > +     for (sc = s; *sc != '\0'; ++sc)
> > +             /* nothing */;
> > +     return sc - s;
> > +}
> > +EXPORT_SYMBOL(strlen);
> > +#endif
> > +
> > +#ifndef __HAVE_ARCH_STRNLEN
> > +/**
> > + * strnlen - Find the length of a length-limited string
> > + * @s: The string to be sized
> > + * @count: The maximum number of bytes to search
> > + */
> > +size_t strnlen(const char *s, size_t count)
> > +{
> > +     const char *sc;
> > +
> > +     for (sc = s; count-- && *sc != '\0'; ++sc)
> > +             /* nothing */;
> > +     return sc - s;
> > +}
> > +EXPORT_SYMBOL(strnlen);
> > +#endif
> > +
> > +#ifndef __HAVE_ARCH_STRCMP
> > +/**
> > + * strcmp - Compare two strings
> > + * @cs: One string
> > + * @ct: Another string
> > + */
> > +int strcmp(const char *cs, const char *ct)
> > +{
> > +     unsigned char c1, c2;
> > +
> > +     while (1) {
> > +             c1 = *cs++;
> > +             c2 = *ct++;
> > +             if (c1 != c2)
> > +                     return c1 < c2 ? -1 : 1;
> > +             if (!c1)
> > +                     break;
> > +     }
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(strcmp);
> > +#endif
> > +
> > +#ifndef __HAVE_ARCH_STRRCHR
> > +/**
> > + * strrchr - Find the last occurrence of a character in a string
> > + * @s: The string to be searched
> > + * @c: The character to search for
> > + */
> > +char *strrchr(const char *s, int c)
> > +{
> > +     const char *last = NULL;
> > +     do {
> > +             if (*s == (char)c)
> > +                     last = s;
> > +     } while (*s++);
> > +     return (char *)last;
> > +}
> > +EXPORT_SYMBOL(strrchr);
> > +#endif
> > +
> > +#ifndef __HAVE_ARCH_MEMCMP
> > +/**
> > + * memcmp - Compare two areas of memory
> > + * @cs: One area of memory
> > + * @ct: Another area of memory
> > + * @count: The size of the area.
> > + */
> > +#undef memcmp
> > +__visible int memcmp(const void *cs, const void *ct, size_t count)
> > +{
> > +     const unsigned char *su1, *su2;
> > +     int res = 0;
> > +
> > +#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > +     if (count >= sizeof(unsigned long)) {
> > +             const unsigned long *u1 = cs;
> > +             const unsigned long *u2 = ct;
> > +             do {
> > +                     if (get_unaligned(u1) != get_unaligned(u2))
> > +                             break;
> > +                     u1++;
> > +                     u2++;
> > +                     count -= sizeof(unsigned long);
> > +             } while (count >= sizeof(unsigned long));
> > +             cs = u1;
> > +             ct = u2;
> > +     }
> > +#endif
> > +     for (su1 = cs, su2 = ct; 0 < count; ++su1, ++su2, count--)
> > +             if ((res = *su1 - *su2) != 0)
> > +                     break;
> > +     return res;
> > +}
> > +EXPORT_SYMBOL(memcmp);
> > +#endif
> > +
> > +#ifndef __HAVE_ARCH_MEMCHR
> > +/**
> > + * memchr - Find a character in an area of memory.
> > + * @s: The memory area
> > + * @c: The byte to search for
> > + * @n: The size of the area.
> > + *
> > + * returns the address of the first occurrence of @c, or %NULL
> > + * if @c is not found
> > + */
> > +void *memchr(const void *s, int c, size_t n)
> > +{
> > +     const unsigned char *p = s;
> > +     while (n-- != 0) {
> > +             if ((unsigned char)c == *p++) {
> > +                     return (void *)(p - 1);
> > +             }
> > +     }
> > +     return NULL;
> > +}
> > +EXPORT_SYMBOL(memchr);
> > +#endif
> > --
> > 2.37.2
> >
> >
