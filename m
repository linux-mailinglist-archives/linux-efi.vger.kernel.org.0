Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E6131104D
	for <lists+linux-efi@lfdr.de>; Fri,  5 Feb 2021 19:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhBERGX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Feb 2021 12:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbhBEQq2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 Feb 2021 11:46:28 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272BCC0617AA
        for <linux-efi@vger.kernel.org>; Fri,  5 Feb 2021 10:28:09 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id a8so11212372lfi.8
        for <linux-efi@vger.kernel.org>; Fri, 05 Feb 2021 10:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vlQvi4zwrhYdmhWv9Vq2VVPj783HBaHFi1PsMzmm4d4=;
        b=u5KwWnRgD5pCq8gQDMJt0XLX6g9/Z5ZNYeBsQGYQxHdY71V+QRFsaeEOmZm6M+ctjV
         bQD1HKcK8T2Jrh53z9N+NFHan5+3H3Q6/0X4nUMiXYxT09lykwbEWXR88hTWJHYCZIhq
         BXZ7E6G+aqGgYdwAarNmkrhuOVfvFrr2LI3XEFW3W0yoeSQD/UI4GL9HIriyQ1weopok
         aBg/5Bpq9/Gfd1La9sQhfdHOrC5IOja8dkhHG3Vnj3KodZzGKd9qlWAAWxrx00C5gDTb
         GV+nT32hXVTzhYrxrB+kk7t2GJnWTEf/lCcEBxLbN+sY7IS7PCcnP/uGk5Bw82LtIo87
         Obcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vlQvi4zwrhYdmhWv9Vq2VVPj783HBaHFi1PsMzmm4d4=;
        b=TuPI/6S4wo6fvcqUqPOdlBtmarevTaDp6R36L1Rt01el1e+LJfcfPNvZSpAQqFRlQc
         Q0/9i9OwiCy7bF10PSPdFyp/uDiV8GxifGGj/QRyJ/OGcFF1F13r7kvkFQ9KOT6/9W18
         XbOo+D87dfeqoEaBLFGeL8zw7s4zlev4klYbh2MvNPIVcgn5fbOEJGaK8x46aBgl63i/
         q16fooJtFT1P6BWfFVAhniZ9EFNF0THXOxZaSnGTPg6/JtOVK3KHeCgEKy7XEuqwb6Ze
         dUrMcbho93vwWSV1BeIf4T3hegvBRVCAFf/crNR5R0aA7Fi6QdVyGIs3ly74nnn2ZaXV
         4ANg==
X-Gm-Message-State: AOAM531O5FzjJBJ/ye3+j4YdHcs70i3pJmNK1WkDXHn0bFfEcnrqi4vs
        6zQsbeKcvRr6Wb14n+klnId/YEzMo/xzq1olBtaaVw==
X-Google-Smtp-Source: ABdhPJxoVxcfWy4sLC0wCG0jeDvbtQemrdC1T055cQ7tAGl1Ro8Lbv+CThmyk6q7izGLdXtePnVNHF3RHjFU9ad6kug=
X-Received: by 2002:ac2:5e84:: with SMTP id b4mr3353569lfq.73.1612549687415;
 Fri, 05 Feb 2021 10:28:07 -0800 (PST)
MIME-Version: 1.0
References: <20210107223424.4135538-1-arnd@kernel.org> <YAHoB4ODvxSqNhsq@rani.riverdale.lan>
 <YAH6r3lak/F2wndp@rani.riverdale.lan> <CAMj1kXGZFZciN1_KruCr=g6GANNpRrCLR48b3q13+QfK481C7Q@mail.gmail.com>
 <20210118202409.GG30090@zn.tnic> <YAYAvBARSRSg8z8G@rani.riverdale.lan>
 <CAMj1kXHM98-iDYpAozaWEv-qxhZ0-CUMwSdG532x2d+55gXDhQ@mail.gmail.com>
 <20210203185148.GA1711888@localhost> <20210205103457.GC17488@zn.tnic>
In-Reply-To: <20210205103457.GC17488@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Feb 2021 10:27:54 -0800
Message-ID: <CAKwvOdnAoNrbAs2kLng-k3L8j4hGS5HtJUv3L-pVwi+5dARQfg@mail.gmail.com>
Subject: Re: [PATCH] x86: efi: avoid BUILD_BUG_ON() for non-constant p4d_index
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Feb 5, 2021 at 2:35 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Feb 03, 2021 at 11:51:48AM -0700, Nathan Chancellor wrote:
> > x86_64 all{mod,yes}config with clang are going to ship broken in 5.11.
>
> Dunno, it is still broken here even with those build assertions removed. And it
> ain't even an all{mod,yes}config - just my machine's config with
>
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> CONFIG_UBSAN=y
> # CONFIG_UBSAN_TRAP is not set
> CONFIG_CC_HAS_UBSAN_BOUNDS=y
> CONFIG_CC_HAS_UBSAN_ARRAY_BOUNDS=y
> CONFIG_UBSAN_BOUNDS=y
> CONFIG_UBSAN_ARRAY_BOUNDS=y
> CONFIG_UBSAN_SHIFT=y
> CONFIG_UBSAN_DIV_ZERO=y
> CONFIG_UBSAN_SIGNED_OVERFLOW=y
> CONFIG_UBSAN_UNSIGNED_OVERFLOW=y
> CONFIG_UBSAN_OBJECT_SIZE=y
> CONFIG_UBSAN_BOOL=y
> CONFIG_UBSAN_ENUM=y
> CONFIG_UBSAN_ALIGNMENT=y
> CONFIG_UBSAN_SANITIZE_ALL=y
> # CONFIG_TEST_UBSAN is not set
>
> and clang-10:
>
> lib/strncpy_from_user.o: warning: objtool: strncpy_from_user()+0x253: call to __ubsan_handle_add_overflow() with UACCESS enabled
> lib/strnlen_user.o: warning: objtool: strnlen_user()+0x244: call to __ubsan_handle_add_overflow() with UACCESS enabled
> ld: init/main.o: in function `kmalloc':
> /home/boris/kernel/linux/./include/linux/slab.h:557: undefined reference to `__ubsan_handle_alignment_assumption'
> ld: init/initramfs.o: in function `kmalloc':
> /home/boris/kernel/linux/./include/linux/slab.h:552: undefined reference to `__ubsan_handle_alignment_assumption'
> ld: init/initramfs.o: in function `kmalloc_large':
> /home/boris/kernel/linux/./include/linux/slab.h:481: undefined reference to `__ubsan_handle_alignment_assumption'
> ld: init/initramfs.o: in function `kmalloc':
> /home/boris/kernel/linux/./include/linux/slab.h:552: undefined reference to `__ubsan_handle_alignment_assumption'
> ld: /home/boris/kernel/linux/./include/linux/slab.h:552: undefined reference to `__ubsan_handle_alignment_assumption'
> ld: init/initramfs.o:/home/boris/kernel/linux/./include/linux/slab.h:552: more undefined references to `__ubsan_handle_alignment_assumption' follow
> ld: mm/mremap.o: in function `get_extent':
> /home/boris/kernel/linux/mm/mremap.c:355: undefined reference to `__compiletime_assert_327'

^ this one is https://lore.kernel.org/lkml/20201230154104.522605-1-arnd@kernel.org/.
Trying to get the last of these tracked down.  I think there were some
changes to UBSAN configs that weren't tested with clang before merged.

> ld: mm/rmap.o: in function `anon_vma_chain_alloc':
> /home/boris/kernel/linux/mm/rmap.c:136: undefined reference to `__ubsan_handle_alignment_assumption'
> ld: mm/rmap.o: in function `anon_vma_alloc':
> /home/boris/kernel/linux/mm/rmap.c:89: undefined reference to `__ubsan_handle_alignment_assumption'
> ld: mm/rmap.o: in function `anon_vma_chain_alloc':
> /home/boris/kernel/linux/mm/rmap.c:136: undefined reference to `__ubsan_handle_alignment_assumption'
> ld: /home/boris/kernel/linux/mm/rmap.c:136: undefined reference to `__ubsan_handle_alignment_assumption'
> ld: /home/boris/kernel/linux/mm/rmap.c:136: undefined reference to `__ubsan_handle_alignment_assumption'
> ld: mm/vmalloc.o:/home/boris/kernel/linux/mm/vmalloc.c:1213: more undefined references to `__ubsan_handle_alignment_assumption' follow
> make: *** [Makefile:1164: vmlinux] Error 1
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette



-- 
Thanks,
~Nick Desaulniers
