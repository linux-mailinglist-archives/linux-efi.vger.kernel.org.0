Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D1B37EB4F
	for <lists+linux-efi@lfdr.de>; Thu, 13 May 2021 00:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245272AbhELTYM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 May 2021 15:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353016AbhELSGk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 12 May 2021 14:06:40 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2261C061344;
        Wed, 12 May 2021 11:04:14 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id l124so4877686vkh.7;
        Wed, 12 May 2021 11:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d6PyBDz5Hz+HLZJQx9m2fhDjeQhvfMXZj/HKgsByeXo=;
        b=EwWfS3nUxUd6F4Hza9Wih48U/DhHt7dkvd7SLfXZB9AGGY0vfd4pqFrdusmN8cEYyS
         lQKD0SvIknzYN1dLg9K0qeIpr0aJTt96qaYa6V4J/wf4mjLc7k/lK18/sRp6PhSws5dv
         r14mRXobZqw+H/tl/bTwJK1xulWqG1EF93+eSdX519DzA3USBFSPV3TRhpryr/imW6/h
         IWEqrrl1Wlc5lDzEUm25bGumfYBqVBftmsSBUcMiOFXjEvh3NzJaGQVLR8+NzPj8bhpr
         mLyRO8xnT7z4aaJ9s2rAEczBml/s9ZWy6r7SvVTO0mFtUSciYzUZLTWk7D1GcQbJdi3a
         CZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6PyBDz5Hz+HLZJQx9m2fhDjeQhvfMXZj/HKgsByeXo=;
        b=FICTEHw+dI4MVkehfttBwt7859WgoZR71tvf924gYIJl4v44TJr4k4yGz7a1IIvBYT
         5R5DLcALZmqinI7+vLKcB/rWBXKQe0YBPwXl4dn4wynYsYUYhMRtLsc6jBpeu9IUX9qt
         xZJkFYyJ8c/aFRC+Kf4ejdEVgF3NunRk50/izw8Dj8ybey0TvSXomFixi8LAi5KMlAox
         oZKrkeuWMGMn7U/Juzmzx7gUk81SKGQNKbQVH4cwhe4DetU8SXFAXy88OaJBdxV06O/W
         U2e4WmjEFvSWNBGFpdFC/0N43U00wMWVtvzPindH1FVStgnyZrgFo0TPp29tFngbw8xV
         Oxew==
X-Gm-Message-State: AOAM530Z3YfLqwLBQFjajtXDHVMNa/SsFXJgsLnqfFwPJ/FZnbC79yWY
        rQxCDnt3obiX1IYuEfm94z5QoW4LVuf+CFH3qJs=
X-Google-Smtp-Source: ABdhPJzu/KIleZZfDrE9427pC4pMWBUduSAchOxtS5+3xBoN5DZNk5IQG0YwqS/XFE66PwTAAAZ4EwHDIAjCHjv9kbA=
X-Received: by 2002:a1f:20c9:: with SMTP id g192mr4453848vkg.8.1620842654032;
 Wed, 12 May 2021 11:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
 <20210511185057.3815777-18-jim.cromie@gmail.com> <CAMj1kXGLKJ19oThbXPhboHzCHfX_oZscxRHn6M7s4jt9Gk8SEA@mail.gmail.com>
In-Reply-To: <CAMj1kXGLKJ19oThbXPhboHzCHfX_oZscxRHn6M7s4jt9Gk8SEA@mail.gmail.com>
From:   jim.cromie@gmail.com
Date:   Wed, 12 May 2021 12:03:47 -0600
Message-ID: <CAJfuBxz+vW_aT=ZVM+UgDxDxwph4D+MKB6r518J9vk2YopX+KA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 17/28] dyndbg: prevent build bugs via -DNO_DYNAMIC_DEBUG_TABLE
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bill Wendling <morbo@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Joerg Roedel <jroedel@suse.de>, Nick Terrell <terrelln@fb.com>,
        Dave Young <dyoung@redhat.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SPARC + UltraSPARC (sparc/sparc64)" 
        <sparclinux@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, May 12, 2021 at 8:55 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 11 May 2021 at 20:51, Jim Cromie <jim.cromie@gmail.com> wrote:
> >
> > The next patch adds DEFINE_DYNAMIC_DEBUG_TABLE(), which broke several
> > subtrees, including efi, vdso, and some of arch/*/boot/compressed,
> > with various relocation errors, iirc.
> >
> > Avoid those problems by adding a define to suppress the "transparent"
> > DEFINE_DYNAMIC_DEBUG_TABLE() invocation.  I found the x86 problems
> > myself, lkp@intel.com found arm & sparc problems, and may yet find
> > others.
> >
>
> Given that I was only cc'ed on this patch in isolation, would you mind
> adding more clarification here? What is DEFINE_DYNAMIC_DEBUG_TABLE()
> supposed to do, and why is it breaking standalone binaries?
>
>

hi Ard,

the thread starts here:
https://lore.kernel.org/linux-mm/20210511185057.3815777-1-jim.cromie@gmail.com/

the _TABLE macro derives from DEFINE_DYNAMIC_DEBUG_METADATA,
which puts private static struct _ddebug's in section("__dyndbg")
the _TABLE macro populates a different section(".gnu.linkonce.dyndbg"),
which is then placed by linker script at the start of the section.

ISTM that the new section might be whats breaking things.
And maybe that the vmlinux linker script isnt involved.
so the storage the _TABLE wants to define is unbound
(and unused, since there are no pr_debugs)
I did see relocation errors somewhere...

This is my 1st time doing something creative with the linker


As to larger purpose, I'll try to restate the patchset mission:

theres ~45kb savings possible by compressing the highly redundant data (~70kb)
 which decorates pr_debug messages.

1 - split the compressible/decoration columns to a different
section|block, for block compression
      this adds temporary .site pointer from _ddebug -> _ddebug_site

2 -  change code so !site is safe.


_TABLEs only real job is to provide a header record, at the beginning
of the section/array,
for a single .site pointer to the _dyndbg_sites section added in 1.
Because the header has a fixed offset from any pr_debug in the vector,
all pr_debugs can use the headers copy of .site, and dont need their own.
specialize & unionize

So it allows to drop the temporary pointer, restoring memory size
parity with master.
And we then have the _dyndbg_sites  section, full of redundant data,
ready to compress.

suppression with -DNO_DYNAMIC_DEBUG was a workaround, didnt think
about it afterwards

does this clarify ?


thanks
Jim
