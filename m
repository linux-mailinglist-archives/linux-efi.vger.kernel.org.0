Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1909620FB98
	for <lists+linux-efi@lfdr.de>; Tue, 30 Jun 2020 20:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgF3STj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 30 Jun 2020 14:19:39 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:34233 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387763AbgF3STh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 30 Jun 2020 14:19:37 -0400
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 05UIJBBj027071;
        Wed, 1 Jul 2020 03:19:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 05UIJBBj027071
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1593541152;
        bh=nuIrJNssJvUSsVaRNApdroyqPo/OAvlKGRbXB/qKIrg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KpDrOoEw772uK9jxrurMZfgZKTN2IhGLURQb2EIH5VbI9f8MUa79WFAaaTBkNdjwV
         NvUAghYSn+qTj2C9neBsIiZIreVC742n69o/aBSZQtMkkSBlBhRfc8yFe2DiNquEBZ
         kMkZ+wDlYPto1GkucIshckkQHAnqShVIUpTPt4vjoG1AXdcmvOFmxNidnQRAVBfZ1n
         BzLpZqhVgSxQeAE12KPJ757Z3kB9kYJiGVwsEmyt1OH73vyWGL7IqY4IKFtnVJDb3q
         x4dMfjtISWzM8gDTZdMLhIrTzt/50LhVFeua6FY8LNGbwU3nB1tXcG99SCrREc2lVE
         8gqr1hmKWc97w==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id m25so11742593vsp.8;
        Tue, 30 Jun 2020 11:19:12 -0700 (PDT)
X-Gm-Message-State: AOAM533ds2pA0QFAbknHCRDszuc+UdhjjVzUCNVvr0J3Ic8lPQDrscZ7
        amWvUpScOJs6Gymk9AHz7PMreEScScP8zu2pFpU=
X-Google-Smtp-Source: ABdhPJwfLoWOY5ns4C+ed5bfxdVr3dA3IYv4tnLqIiAwjXuh/1l8/DPg8aKaJ67yb3qQ8Lwt2TtY3rl1rFdOZBDTIPM=
X-Received: by 2002:a67:694d:: with SMTP id e74mr16669112vsc.155.1593541150808;
 Tue, 30 Jun 2020 11:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200626185913.92890-1-masahiroy@kernel.org> <CAKwvOd=V_M43CP7G87K3TqSsxua2NcXPz6BnDt-z6167O2WAzQ@mail.gmail.com>
 <CAK7LNATcwGkSWV7NSgwG_WqzvTPphT9=KK+qvT3FK_7y1UCzTA@mail.gmail.com>
 <CAKwvOdntZw2k8ZZ7txPC-FD+50cPpMwctGYTW0j2zw+FVj9SgA@mail.gmail.com> <CAKwvOd=JbEJNdWzk_xdMiy9QewbU3ESOHcokAXKkARrgm-ibEg@mail.gmail.com>
In-Reply-To: <CAKwvOd=JbEJNdWzk_xdMiy9QewbU3ESOHcokAXKkARrgm-ibEg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 1 Jul 2020 03:18:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQhGVm9ZBYOSosPx3DZvY020LTy+MZr3LUbvDaa0j19RQ@mail.gmail.com>
Message-ID: <CAK7LNAQhGVm9ZBYOSosPx3DZvY020LTy+MZr3LUbvDaa0j19RQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: remove cc-option test of -fno-stack-protector
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 30, 2020 at 7:39 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Jun 29, 2020 at 11:26 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Sat, Jun 27, 2020 at 4:59 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > On Sat, Jun 27, 2020 at 5:13 AM Nick Desaulniers
> > > <ndesaulniers@google.com> wrote:
> > > >
> > > > On Fri, Jun 26, 2020 at 12:00 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > > >
> > > > > diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
> > > > > index dba6a83bc349..93792b457b81 100644
> > > > > --- a/arch/x86/kernel/cpu/Makefile
> > > > > +++ b/arch/x86/kernel/cpu/Makefile
> > > > > @@ -17,8 +17,7 @@ KCOV_INSTRUMENT_perf_event.o := n
> > > > >  KCSAN_SANITIZE_common.o := n
> > > > >
> > > > >  # Make sure load_percpu_segment has no stackprotector
> > > > > -nostackp := $(call cc-option, -fno-stack-protector)
> > > > > -CFLAGS_common.o                := $(nostackp)
> > > > > +CFLAGS_common.o                := -fno-stack-protector
> > > >
> > > > Any time I see `:=` assignment to a CFLAGS variable, it's a red flag
> > > > for overwriting existing CFLAGS, which is a common source of bugs.  I
> > > > recognize the kernel is current a mix and match for:
> > > >
> > > > CFLAGS_<file>.o
> > > >
> > > > rules to either use `+=` or `:=`, but I wish we were consistent, and
> > > > consistent in our use of `+=`.  For those rules, is there a difference
> > > > between the use of `+=` and `:=` like there is for the more general
> > > > case of appending to KBUILD_CFLAGS?  If not, it's ok to match the
> > > > existing style, but it's curious to me in this patch to see a mixed
> > > > use of `+=` and `:=`.
> > >
> > >
> > > I think Kees mostly answered your question.
> > >
> > > Let me add some comments.
> > >
> > >
> > > '+=' is the most used in kernel Makefiles, but
> > > ':=' and '=' are also used.
> > >
> > > So, you are right, we are inconsistent.
> > > This applies to not only CFLAGS_<file>.o, but also obj-y, etc.
> > >
> > > For example,
> > > https://github.com/torvalds/linux/blob/v5.7/arch/arm64/kernel/Makefile#L15
> > > 'obj-y :=' works since it is the first assignment to obj-y in that file.
> > > 'obj-y +=' also works, of course.
> > >
> > > We can consistently use '+=' everywhere, but I do not send
> > > patches for churn.
> > >
> > >
> > > You can use any assignment operator to CFLAGS_<file>.o
> > > if it is the first assignment in the Makefile.
> > > Using '+=' is robust for future code insertion/removal, though.
> > >
> > >
> > > If the right-hand side contains variable references,
> > > there is important difference in the behavior.
> > >
> > > You may know two flavors in variables
> > > (https://www.gnu.org/software/make/manual/make.html#Flavors)
> >
> > Cool, thanks for all the info.  With that, I'm happy with this patch.
> >
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> >
> > > CFLAGS_foo.o := $(call cc-option,-fno-stack-protector)
> > > The cc-option is expanded immediately when this line is parsed.
> > > (So, the compiler is invoked for 'make clean' too)
> > >
> > >
> > > CFLAGS_foo.o += $(call cc-option,-fno-stack-protector)
> > > If this is the first assignment in the file,
> > > '+=' act as '=', so the evaluation of cc-option
> > > is delayed until $(CFLAGS_foo.o) is expanded.
> > > (So, the compiler is NOT invoked for 'make clean')
> >
> > Ah, I think that may explain: I've been seeing the occasional warning
> > from $(NM) when running `make clean` for ARCH=arm, I'll bet that's
> > where this is coming from then.  Next time I reproduce it, I'll try to
> > find maybe where we're using `:=` or `=` with `$(NM)`.
> >
> > Maybe arch/arm/boot/compressed/Makefile, KBSS_SZ is evaluated for
> > `make clean`? (If you start an arm build, but kill it before vmlinux
> > is created, then `make clean` I suspect that KBSS_SZ is evaluated?)
>
> $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make LLVM=1 -j71
> $ rm vmlinux
> $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make LLVM=1 -j71 clean
> llvm-nm: error: arch/arm/boot/compressed/../../../../vmlinux: No such
> file or directory.

yeah, I had noticed this noise, but
I did not get around to digging into it.


> I suspect I see this from doing an ARCH=arm build, then building a
> different ARCH and killing the build before vmlinux is produced or
> `make clean` for a different ARCH, then run a `make clean` for
> ARCH=arm.
>
> Is the above (regarding lazy evaluation) not true for LDFLAGS_vmlinux?
> I would have thought this would work:


No, this does not work.

LDFLAGS_vmlinux is assigned by '=',
so it already has the lazy expansion flavor.


Unexporting LDFLAGS_vmlinux will fix it.
(I may write a better patch, though)



diff --git a/arch/arm/boot/compressed/Makefile
b/arch/arm/boot/compressed/Makefile
index 00602a6fba04..fab54b1c39aa 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -131,6 +131,8 @@ LDFLAGS_vmlinux += -X
 # Next argument is a linker script
 LDFLAGS_vmlinux += -T

+unexport LDFLAGS_vmlinux
+
 # For __aeabi_uidivmod
 lib1funcs = $(obj)/lib1funcs.o




-- 
Best Regards
Masahiro Yamada
