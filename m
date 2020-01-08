Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61C5913461E
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2020 16:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgAHPZy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jan 2020 10:25:54 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36349 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgAHPZy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Jan 2020 10:25:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so3840505wru.3
        for <linux-efi@vger.kernel.org>; Wed, 08 Jan 2020 07:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJN2zDFQtbWUai9TmJxJ3JiSDO6k5NDavivm5Yv7aAc=;
        b=DR167N5d5aEOZOfSbyMAAh5QG3V/rkU8MyNFjrVzcGAEdvVLH6bYXu2UDiAJ80wfkH
         NElkuRqFHduQmfb7n4fNXKFHpeMlAwosQHCjNeV8P3wvPshj3ZV29MGiqZ07qcYBSBeJ
         dyHErPVp5u9oSSGCHxbguNdZ+q+nmK4O1aBxWHziVqJPHrjyrUydybq53hwZ/oJIoESA
         ESQkfcgRng8JG3pnAzQZBJOK+rYmIqFvSZ4Fm0ssbGtPVXCVUozgcshT3ygA87TzjpDX
         w7y+FvUf4kPBeENvtJbEA1ixag55m7/sQqySLi01hyVehVpjcYY3bE6JPYgLR+iCJPqB
         GyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJN2zDFQtbWUai9TmJxJ3JiSDO6k5NDavivm5Yv7aAc=;
        b=KT6ESqSssGtw1evTDWJm0L3OvjzdbsWfm0s2d/aUGwbJvauf9TNt+gLmiGzN95awwy
         L0OnyHxN6BYvyRJcegNTSX9k55cpbE0B4kJ67AxkK6VEoKAYyStlBjxdxO5ps9mTkZYB
         Ucy6B27vRcROtvT+gg81ugv36+UR8XJGwVYEssrGZSKLZFi/ULyG/U3SqUKq6cgwIyVM
         31VUDKISsK3QI76oKBHbuDC7hr9jPnNUjmjLQpWR5MTZW7ZNf59QnN+Cb0tONZNVjksP
         Lz67Pb056V/8uquTNthZPEmljEADLf5TiFDWCQ7klkHGoN0wSvD2Gji7rDq7C/9ink+g
         AyKw==
X-Gm-Message-State: APjAAAWxVak4tyMJSMpw3aMB16R2zwlJM2QtFFsa+QCkJ5rYCHu1ROIc
        jlOdNnJ3jlFVlozhBUU7377QZR/AjhZ4IJBc7EpjPw==
X-Google-Smtp-Source: APXvYqxCh6n6fGiM82LfVcvEhykS5MXpUOuaDnbnn+xTAoE1Tdzbc2PEQm6qW3HVoccgch1n4tvEagRJXe22/mitUjQ=
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr4958135wrj.325.1578497152188;
 Wed, 08 Jan 2020 07:25:52 -0800 (PST)
MIME-Version: 1.0
References: <20200108074502.10960-1-ardb@kernel.org> <20200108074502.10960-2-ardb@kernel.org>
 <20200108152325.GA2499882@rani.riverdale.lan> <CAKv+Gu80MujqKcyxAu9M_dR90cbcHo2_UDrHjuCLO_B0Adm7YQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu80MujqKcyxAu9M_dR90cbcHo2_UDrHjuCLO_B0Adm7YQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 8 Jan 2020 16:25:41 +0100
Message-ID: <CAKv+Gu9bPdCB6=YhDNjPL-S3oWexeEf0wLDuvo-kr0HZ31Feeg@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi/libstub/x86: use const attribute for efi_is_64bit()
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 8 Jan 2020 at 16:25, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Wed, 8 Jan 2020 at 16:23, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Wed, Jan 08, 2020 at 08:45:01AM +0100, Ard Biesheuvel wrote:
> > > Reshuffle the x86 stub code a bit so that we can tag the efi_is_64bit()
> > > function with the 'const' attribute, which permits the compiler to
> > > optimize away any redundant calls. Since we have two different entry
> > > points for 32 and 64 bit firmware in the startup code, this also
> > > simplifies the C code since we'll enter it with the efi_is64 variable
> > > already set.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/x86/boot/compressed/eboot.c   | 14 ++++++--------
> > >  arch/x86/boot/compressed/head_64.S |  7 +++----
> > >  arch/x86/include/asm/efi.h         |  2 +-
> > >  3 files changed, 10 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> > > index 4afd29eb5b34..ab3a40283db7 100644
> > > --- a/arch/x86/boot/compressed/eboot.c
> > > +++ b/arch/x86/boot/compressed/eboot.c
> > > @@ -21,16 +21,18 @@
> > >  #include "eboot.h"
> > >
> > >  static efi_system_table_t *sys_table;
> > > -static bool efi_is64 = IS_ENABLED(CONFIG_X86_64);
> > > +extern const bool efi_is64;
> > >
> >
> > Didn't we need to declare this with hidden visibility? Or use the
> > #pragma GCC visibility push(hidden)?
>
> Yes. So this patch depends on

https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?h=next&id=c71339946177f235aa1f750b2dc556ede3288c23

which is part of the open PR to the TIP maintainers.
