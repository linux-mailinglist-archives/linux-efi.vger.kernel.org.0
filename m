Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFBE3F9A86
	for <lists+linux-efi@lfdr.de>; Fri, 27 Aug 2021 15:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhH0N5m (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Aug 2021 09:57:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231675AbhH0N5m (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Aug 2021 09:57:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92B6560F35
        for <linux-efi@vger.kernel.org>; Fri, 27 Aug 2021 13:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630072613;
        bh=xTMrR/+Di4u84mT1/ADwHuGsAHWnH465vDxM0jGQXEw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X+FvTnQEaOOtjhrRPBqrZBVIJ2O9rZWo8gnZwLJ5H4tNx/DgKItUw/M2+Vd95jl54
         svPYd6AeFY7Yd2yAcea+xZEtQMyZv9A1tWlNn5mDU6Da4IyDYIM7++iRzG52YWTVh7
         jXFlrq+Gpu3Y6ngOt6+W1LsCzloNjdCSIjMPrk5X2Dao3PRROukpxsTfdMSpx4gKte
         yOXfAvsHgd8Gj+/2pTzk+7RZCreEbd09DroBmSKcxhH025OqLu76abay4PzJZ0M/Mw
         du4yTfOR+ojHCA9EpxOqiO9zphQyvBLiv/sIoaiBtDMdzHb22EwcrjNbDnWBgJNfQd
         bsvYN2/8rz30Q==
Received: by mail-oi1-f178.google.com with SMTP id n27so10009042oij.0
        for <linux-efi@vger.kernel.org>; Fri, 27 Aug 2021 06:56:53 -0700 (PDT)
X-Gm-Message-State: AOAM531a6on1Di1Jhol0NihBlIwRonFEBLTioGWrSlWYdwSwsjiYscfD
        9HJt1kCnNqgGgccAdBgcUYxFmHpcPGSRMNJMQ8w=
X-Google-Smtp-Source: ABdhPJztZ0OEIB9TM9Exc3IVz2olakTNtAp9kg7LQ/UGA1R/7CTEHc4nE7qNhvSxLy4cK+nALIdxFwC0KzXJQkwlAqU=
X-Received: by 2002:aca:ea54:: with SMTP id i81mr6528767oih.174.1630072612889;
 Fri, 27 Aug 2021 06:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <dad4cdef71cf415f8ee6f0987b467b01@intel.com> <20210514032137.94458-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20210514032137.94458-1-qiuxu.zhuo@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 27 Aug 2021 15:56:41 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHNtX3Qa4Zvmhq5XEkPSpW6DDpTvCW813fnbbLxeP3pzw@mail.gmail.com>
Message-ID: <CAMj1kXHNtX3Qa4Zvmhq5XEkPSpW6DDpTvCW813fnbbLxeP3pzw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] eif/capsule-pstore: Add capsule pstore backend
To:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc:     Kees Cook <keescook@chromium.org>, liming.gao@intel.com,
        linux-efi <linux-efi@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 14 May 2021 at 05:21, Qiuxu Zhuo <qiuxu.zhuo@intel.com> wrote:
>
> >> From: linux-efi-owner@vger.kernel.org <linux-efi-owner@vger.kernel.org=
> On Behalf Of Ard Biesheuvel
> >> ...
> >>
> >> OK, so I see one complication with this. The EFI UpdateCapsule() runti=
me
> >> service expects the OS to use the EFI ResetSystem() runtime service to
> >> perform the reboot. pstore is designed to record whatever it can while=
 the
> >> system is crashing, and so it this would need reboot_on_panic at the v=
ery
> >> least, but even then, it is not very likely that you would be able to =
do a
> >> clean soft reboot from that state in the general case.
> >>
> >> So unless there is a way to perform the test steps /without/ relying o=
n
> >> magic SysRq to do a soft reboot after the system has panicked, I'm not=
 convinced this is worthwhile.
>
>
> > Hi Ard,
> >
> > Your concern is reasonable! Thanks!
> >
> > Yes, the capsule-pstore driver depends on the EFI ResetSystem() runtime=
 service
> > to perform the reboot to save the capsules of crashing dump across a wa=
rm reset.
> > Investigation on current Linux kernel reboot code (see the commits belo=
w) of
> > arm64 and x86 shows that if the system is UEFI Runtime Services availab=
le or
> > if an EFI capsule has been sent to the firmware then the system is forc=
ed to
> > use EFI ResetSystem(). I.e., the EFI ResetSystem() will be the preferre=
d reboot
> > path if we have EFI capsules.
> >
> >      arm64: 60c0d45a7f7a ("efi/arm64: use UEFI for system reset and pow=
eroff")
> >        x86: 87615a34d561 ("x86/efi: Force EFI reboot to process pending=
 capsules")
> >
> > So the capsule-pstore simply depends on reboot_on_panic. The dependency=
 may
> > make it seem to be different from some other pstore backend drivers tha=
t save
> > the dump to some persistent memory, so they don=E2=80=99t care how the =
system is reset
> > (could even be power-cycled). Whether rebooting the kernel or pinning i=
t in a
> > loop on panic is controlled by "panic_timeout" which is exported for ex=
ternal
> > modules. The capsule-pstore driver may check it and print a warning mes=
sage if
> > it isn't set to trigger a reboot (panic_timeout=3D0).
> >
> > One more example of pstore successfully using the capsule-pstore driver=
 is showed
> > as below (the panic_timeout=3D1 was pre-set, so the kernel got reboot o=
n panic).
> > It didn't relying on magic SysRq to reboot the system. Tested the capsu=
le-pstore
> > driver that it still worked well.
> >
> > Summary: The capsule-pstore only depends on panic_timeout !=3D0. If pan=
ic_timeout !=3D0,
> > then the capsule-pstore can work (certainly, the system should have EFI=
 Runtime Services).
> > Hope the capsule-pstore is still a worthwhile pstore backend.  :-)
> > ...
>
> Hi Ard,
>
> Hope all is well with you. May I know whether the comments above make sen=
se for you?
> Thanks!
>

The point is really that even when reboot_on_panic is enabled, there
are many cases where a panic condition prevents the kernel from doing
anything at all, including scheduling the workqueue thread that
handles EFI runtime service calls.

Of course, this applies equally to efi-pstore itself, but at least
that uses EFI runtime services that can be expected to work at
runtime, as opposed to UpdateCapsule(), which is only ever used at
boot time in that majority of cases (both Linux and Windows carry a
special capsule loader that reboots into UEFI so that UpdateCapsule()
can be invoked at boot time, as UpdateCapsule() at runtime is hardly
tested and therefore broken on most production PC hardware)
