Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C03E25B43A
	for <lists+linux-efi@lfdr.de>; Wed,  2 Sep 2020 21:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgIBTEr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Sep 2020 15:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgIBTEp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Sep 2020 15:04:45 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88647C061246
        for <linux-efi@vger.kernel.org>; Wed,  2 Sep 2020 12:04:45 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 5so148261pgl.4
        for <linux-efi@vger.kernel.org>; Wed, 02 Sep 2020 12:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mbvYxT8uYxty8dNjUEj6f2xpfkVHdqq7oce2X4nNcd0=;
        b=iRP4fz5N8zXBPyKNAgNfPmXCcxrmonkm0Os8not5I3SkTH+uCEvtntcSzwpjmUH5Ew
         fJ53jdwnD1OmSm2/LLlE9h3yEA3384P9xBIx1fM5B8WvPo8eT5i8XW74TzOZSJCiVhIQ
         t8yPjErzTguaK5SK/lPFV6JrgE+zApxHY7n4T9h0IFgeVDfPSLH9i4Igh1E1y1VUrZdk
         Qg7e+ShQRcDa4r6b5/n24liH+AW0DosuNG55yaEmh6cl88S64ZokJ0z50525m3rjaIIP
         mYAZj935dcrmRet9hObLhGeVLVc7w/6Lgr7OBukbh6zJ3YwQfJx6ajWrb4RHKGYufli4
         4/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mbvYxT8uYxty8dNjUEj6f2xpfkVHdqq7oce2X4nNcd0=;
        b=Tw9YzHjuInb11yN6zzqPR3C3v9HletYcg/mRBidSi9ecDo3vrirZe3G0ZPelIKxScA
         rXhxf/2JsieHXsFwxwTDMkv2DzGTXZl87BudqtB0yHVxpdDtVrzVN0s47X40vx0SPpME
         6UttFO/VZIWHb3ZiWPqhFJedQsJf2Wfj4pvK0V33q2tC5gJipEa18Nj96uadfXZgIUq4
         KGBQ0uobG5yWtoLwcQhxko1EdJrhDT/+TJ1F3Z3twW6zZ3Ckt/0pv2jzVDdgjRnqmWRo
         01Owfopav36TyEhSb574FitvfXo4BPgQIY7roGt6SXkAn0NIQ0wUve5wCnm9TQIFTsRj
         Be9A==
X-Gm-Message-State: AOAM530KSAjLwqqNP17T7XZa+398+Q8aE8Kz50omMNXUdicIzCvXzPo5
        UEwRQIUVbIxUGMWNCVDDOILH7DzzX9gqGshoayQB8Q==
X-Google-Smtp-Source: ABdhPJwtTfyrpkBmwDaLJ+GfXiTisNqMpq2rz/OkurrFhQR8CPZaebvC/gVhdDeDVHmXMpt9IxQQan8xa319O8Ek0ZQ=
X-Received: by 2002:a62:1896:: with SMTP id 144mr3540419pfy.143.1599073484594;
 Wed, 02 Sep 2020 12:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200902025347.2504702-1-keescook@chromium.org>
In-Reply-To: <20200902025347.2504702-1-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 2 Sep 2020 12:04:33 -0700
Message-ID: <CAKwvOd=r8X1UeBRgYMcjUoQX_nbOEbXCQYGX6n7kMnJhGXis=Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Warn on orphan section placement
To:     Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Sep 1, 2020 at 7:53 PM Kees Cook <keescook@chromium.org> wrote:
>
> Hi Ingo,
>
> The ever-shortening series. ;) Here is "v7", which is just the remaining
> Makefile changes to enable orphan section warnings, now updated to
> include ld-option calls.
>
> Thanks for getting this all into -tip!

For the series,
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

As the recent ppc vdso boogaloo exposed, what about the vdsos?
* arch/x86/entry/vdso/Makefile
* arch/arm/vdso/Makefile
* arch/arm64/kernel/vdso/Makefile
* arch/arm64/kernel/vdso32/Makefile

>
> -Kees
>
> v6: https://lore.kernel.org/lkml/20200821194310.3089815-1-keescook@chromium.org/
> v5: https://lore.kernel.org/lkml/20200731230820.1742553-1-keescook@chromium.org/
> v4: https://lore.kernel.org/lkml/20200629061840.4065483-1-keescook@chromium.org/
> v3: https://lore.kernel.org/lkml/20200624014940.1204448-1-keescook@chromium.org/
> v2: https://lore.kernel.org/lkml/20200622205815.2988115-1-keescook@chromium.org/
> v1: https://lore.kernel.org/lkml/20200228002244.15240-1-keescook@chromium.org/
>
> Kees Cook (5):
>   arm64/build: Warn on orphan section placement
>   arm/build: Warn on orphan section placement
>   arm/boot: Warn on orphan section placement
>   x86/build: Warn on orphan section placement
>   x86/boot/compressed: Warn on orphan section placement
>
>  arch/arm/Makefile                 | 4 ++++
>  arch/arm/boot/compressed/Makefile | 2 ++
>  arch/arm64/Makefile               | 4 ++++
>  arch/x86/Makefile                 | 4 ++++
>  arch/x86/boot/compressed/Makefile | 1 +
>  5 files changed, 15 insertions(+)
>
> --
> 2.25.1
>


-- 
Thanks,
~Nick Desaulniers
