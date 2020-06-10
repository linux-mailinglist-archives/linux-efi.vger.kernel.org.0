Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C204B1F50F6
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jun 2020 11:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgFJJKk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Jun 2020 05:10:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbgFJJKk (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Jun 2020 05:10:40 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2F97206F4;
        Wed, 10 Jun 2020 09:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591780239;
        bh=eA9b9r/VfrB6XIgnaOoOlI7iRbldULAZTDwgqhhpxns=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ysqkV0trPvjiou3OvlVUwFiMEbfJsJWB2NCYw87pPBFoAmnvtTa2U+oy4Zoic5MY8
         5Tc+yvPbaHY0s8T9+K35Jr75czQDlTVaR8X/vSY94btpo2Y5Y0c16YQhRnYUeaoeyh
         exMxp1EYO2b48yb+9aNsvpni/PNS3QOJZjRxK0PA=
Received: by mail-ot1-f51.google.com with SMTP id k15so1137856otp.8;
        Wed, 10 Jun 2020 02:10:39 -0700 (PDT)
X-Gm-Message-State: AOAM5317uMzkx8km+CgKSOQtI+Xe4MrXzEcaA8kH5ho+gH5I003R43e2
        lhGZSGhhf9vowB1jWRIZDz+1qhP0Hg8zjFI4Sos=
X-Google-Smtp-Source: ABdhPJyrpM2kAa85IxQlBAnrXXaGFJblaR/dF94rvrYfkdYJt0hYgrbcRlP2X8+uJW1d97ToMjRO5FTwp3KOw5XmtuY=
X-Received: by 2002:a9d:42e:: with SMTP id 43mr1845458otc.108.1591780238955;
 Wed, 10 Jun 2020 02:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200610071446.3737-1-zhenzhong.duan@gmail.com> <20200610085932.GA461993@ubuntu-n2-xlarge-x86>
In-Reply-To: <20200610085932.GA461993@ubuntu-n2-xlarge-x86>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 10 Jun 2020 11:10:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHun8-SS4L03ccp=pt1oyPSfpuPezju294NnJoKLtcvcA@mail.gmail.com>
Message-ID: <CAMj1kXHun8-SS4L03ccp=pt1oyPSfpuPezju294NnJoKLtcvcA@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: Fix build error with libstub
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 10 Jun 2020 at 10:59, Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Wed, Jun 10, 2020 at 03:14:46PM +0800, Zhenzhong Duan wrote:
> > Got below error during build:
> >
> >   In file included from drivers/firmware/efi/libstub/efi-stub-helper.c:=
16:0:
> >   drivers/firmware/efi/libstub/efi-stub-helper.c: In function =E2=80=98=
efi_char16_puts=E2=80=99:
> >   arch/x86/include/asm/efi.h:355:3: sorry, unimplemented: ms_abi attrib=
ute requires -maccumulate-outgoing-args or subtarget optimization implying =
it
> >      : __efi64_thunk_map(inst, func, inst, ##__VA_ARGS__))
> >      ^
> >   drivers/firmware/efi/libstub/efi-stub-helper.c:37:2: note: in expansi=
on of macro =E2=80=98efi_call_proto=E2=80=99
> >     efi_call_proto(efi_table_attr(efi_system_table, con_out),
> >     ^
> >   drivers/firmware/efi/libstub/efi-stub-helper.c:37: confused by earlie=
r errors, bailing out
> >
> > Fix it by adding -maccumulate-outgoing-args for efi libstub build
> > as suggested by gcc.
> >
> > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> > ---
> >  drivers/firmware/efi/libstub/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/e=
fi/libstub/Makefile
> > index cce4a74..25e5d02 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -6,7 +6,7 @@
> >  # enabled, even if doing so doesn't break the build.
> >  #
> >  cflags-$(CONFIG_X86_32)              :=3D -march=3Di386
> > -cflags-$(CONFIG_X86_64)              :=3D -mcmodel=3Dsmall
> > +cflags-$(CONFIG_X86_64)              :=3D -mcmodel=3Dsmall -maccumulat=
e-outgoing-args
>
> This will need a cc-option call if this patch is necessary because clang
> does not support this flag.
>
> clang-11: error: unknown argument: '-maccumulate-outgoing-args'
>

A fix was already sent for this

https://lore.kernel.org/bpf/20200605150638.1011637-1-nivedita@alum.mit.edu/

which does the right thing here.

> >  cflags-$(CONFIG_X86)         +=3D -m$(BITS) -D__KERNEL__ \
> >                                  -fPIC -fno-strict-aliasing -mno-red-zo=
ne \
> >                                  -mno-mmx -mno-sse -fshort-wchar \
> > --
> > 1.8.3.1
> >
>
> Cheers,
> Nathan
