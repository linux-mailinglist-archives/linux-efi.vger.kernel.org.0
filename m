Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40BF112E82F
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2020 16:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgABPkz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jan 2020 10:40:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35867 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbgABPky (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jan 2020 10:40:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so39655026wru.3
        for <linux-efi@vger.kernel.org>; Thu, 02 Jan 2020 07:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oxp7TTPLp3V9HFX99H9MphqYnjjhYKLtkjOuG5za7hc=;
        b=mPc1jL1TPWFza+B5fDeukT+arfy6x0AhLrgNjt8zZv0Qmhgo1PdHqZ6qSpRVlzjmNA
         gqAfEnt/QW7Jsdv1WOpchBzjqj+h3ymq3hbkWqRPBXRweVlMIjbJYMxmpACNti189vkP
         /PqeoKH3oE/DRXR5T/e23fuFz1zWQAsGCOjc/DVj73Ypp5nxnjtEQeFo2+h2dwItGrcM
         bAW0tZMoRDKhhI6C2Bfd9geCAJEWbCpn1HdvgN2xyMMgvXYRB0uFSSGqSxIgUpOw59uW
         Xw3GXvyqYwV9ZAEf/m9edzgrrXncKEdZuThXvKmfHBX1hzL2Dc3jMeuSuNL3MKRhRf+T
         xL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oxp7TTPLp3V9HFX99H9MphqYnjjhYKLtkjOuG5za7hc=;
        b=NNY0YZoy22GNuF11IIFG/BQgjr4YdhlbQ9V38nD7xB/VPw+f6wxz4o3J/2kITsblea
         GSIaMYS1uTo7anTtXRViMqhv64z4Ho8d8xXz6y4oIeRCRwWVmCoBY+dqONv+rvwQylSa
         TEtrsuXKTQHwO9pt6hiEQ3pdsT/LRbGTMdjWZ6f7hlx72A78qZZWuAYZ1FkzoM5NS88N
         DGsZBbtAvmZppPXqu/feUFHz815Asq65KuwuPxulVOHEeY91MxFyY6tkHacxDo5/ZI4I
         /6BV0KsKh1gDtKbmiBJLpwRAtCoqd3qlQkubNC7rnskuJ2HAKUBRjCz2n4ouNu5hsQ/Q
         Bh7g==
X-Gm-Message-State: APjAAAW//QOAiEK8iyhkeO5pN6zZw3K4HaDssbUwT/0bxxsYM/wjfRV0
        qDNgCQLf8Gg2vqlUOrPSN/z0FKqAd85gna8ljcL2ZQ==
X-Google-Smtp-Source: APXvYqyks0Ih14fYub72wH7T459G2dKcbiS7yu0nZs+LEHsdm0o5hNPLs2WHDnMxEz2UH+i879hnEdSw/5VYuNjGLU0=
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr81185597wrs.200.1577979652983;
 Thu, 02 Jan 2020 07:40:52 -0800 (PST)
MIME-Version: 1.0
References: <CAKv+Gu9-pcUGmpMVrYd+q+DJNU_737fpqwm5O2-yJJbS5KuGeg@mail.gmail.com>
 <F25F57AE-15C5-4240-99D6-F6C93CFDA447@amacapital.net> <CAKv+Gu8g8=yMXMNdHee7rsMWNwkhk43ZgbDEwAPHUX6Fj1jscA@mail.gmail.com>
 <20191220194157.GA251736@rani.riverdale.lan> <fcad423a-6f24-6b86-ff78-2bcad0c73008@redhat.com>
In-Reply-To: <fcad423a-6f24-6b86-ff78-2bcad0c73008@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 2 Jan 2020 16:40:42 +0100
Message-ID: <CAKv+Gu82q3voiyzEojX9PGefErCqrqaYyWW=EVrLptLAu=2BZQ@mail.gmail.com>
Subject: Re: [PATCH v2 21/21] efi: Allow disabling PCI busmastering on bridges
 during boot
To:     Laszlo Ersek <lersek@redhat.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Andy Lutomirski <luto@amacapital.net>,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2 Jan 2020 at 15:46, Laszlo Ersek <lersek@redhat.com> wrote:
>
> On 12/20/19 20:41, Arvind Sankar wrote:
> > On Fri, Dec 20, 2019 at 10:11:00AM +0200, Ard Biesheuvel wrote:
> >> On Fri, 20 Dec 2019 at 09:17, Andy Lutomirski <luto@amacapital.net> wr=
ote:
> >>>
> >>>
> >>>
> >>>> On Dec 20, 2019, at 3:07 PM, Ard Biesheuvel <ard.biesheuvel@linaro.o=
rg> wrote:
> >>>>
> >>>> =EF=BB=BFOn Thu, 19 Dec 2019 at 22:05, Matthew Garrett <mjg59@google=
.com> wrote:
> >>>>>
> >>>>>> On Wed, Dec 18, 2019 at 9:03 AM Ard Biesheuvel <ardb@kernel.org> w=
rote:
> >>>>>> +       status =3D efi_call_early(create_event, EVT_SIGNAL_EXIT_BO=
OT_SERVICES,
> >>>>>> +                               TPL_CALLBACK, handle_exit_boot_ser=
vices_event,
> >>>>>> +                               NULL, &exit_boot_services_event);
> >>>>>> +       if (status !=3D EFI_SUCCESS) {
> >>>>>> +               pr_efi_err("Failed to register for EBS() event\n")=
;
> >>>>>> +               goto free_handle;
> >>>>>> +       }
> >>>>>
> >>>>> OVMF's SEV implementation appears to tear down AMD's IOMMU mappings=
 at
> >>>>> EVT_SIGNAL_EXIT_BOOT_SERVICES. How are we ensuring that this happen=
s
> >>>>> first?
> >>>>
> >>>> It doesn't, and that is kind of the point. The only guarantee you ha=
ve
> >>>> is that this runs before ExitBootServices() returns, but after any
> >>>> other callbacks that have been registered. I know this is not 100%
> >>>> what you're after, but it is the only way we can avoid poking device=
s
> >>>> behind the backs of their drivers.
> >>>>
> >
> > Could we add a comment to describe why we have the two-step event
> > notification, i.e. to ensure the ordering?
> >
> > Regarding SEV, from what Laszlo had said [1] I had understood that the
> > SEV driver left everything blacklisted -- is this necessary at all for
> > SEV or did I misunderstand his comment?
> >
> > [1] https://lore.kernel.org/lkml/9c58f2d2-5712-0972-6ea7-092500f37cf9@r=
edhat.com/
>
> Leaving all guest RAM encrypted after EBS may not be a technical
> requirement for SEV. It is a security goal, however. The OS should
> inherit the most secure environment possible from the firmware, and not
> have to look for pages that were left unencrypted.
>
> >>> Can you clarify (in the changelog or a comment perhaps) why you=E2=80=
=99re doing this instead of turning off busmastering before calling ExitBoo=
tServices()?  Maybe this was covered in this thread, but I missed it.
> >>>
> >>
> >> Sure. The problem is that EBS() is the place where drivers tear down
> >> rings etc and gracefully take down the device. So killing DMA for all
> >> of them by clearing the BM bit of every bridge is likely to cause
> >> problems, because the teardown code wasn't written with the idea in
> >> mind that DMA is no longer possible. On arm64 at least, it may result
> >> in the kernel being entered with a pending SError which will kill the
> >> OS as soon as they are unmasked. But the UEFI drivers themselves may
> >> simply hang or timeout on some DMA access.
> >>
> >
> > As I understand it, the order in which we want the bus-mastering
> > disable to happen is
> > - all PCI device drivers are stopped
> > - bus mastering is disabled
> > - depending on firmware, iommu might get disabled (probably out of our
> >   control)
> >
> > Instead of using the event notifier, could we not explicitly call
> > DisconnectController() for all the PCI devices, then disable
> > bus-mastering, and only then call ExitBootServices()?
>
> This sounds worth investigating to me.
>

I implemented this here:
https://lore.kernel.org/linux-efi/20191231162344.130654-1-ardb@kernel.org/

It works on all the systems I tried, including a mixed mode iMac 24"
and a mixed mode Intel Atom based tablet kindly provided by Hans.

The only thing to keep in mind is that some drivers implement
Gop->Blt() using DMA in some cases, and so we should ensure that this
is really the last thing that happens before ExitBootServices() is
called, since a simple efi_printk() may trigger a DMA access by the
graphics hardware.

> >>> Also, surely this whole mess is a a design error in EFI, at least whe=
n SEV is involved, and there should be an EFI extension to keep IOMMU enabl=
ed.  Or a specified way to *guarantee* that DMA is off when we exit boot se=
rvices without hackery.
> >>
> >> The UEFI spec requires that all devices stop doing DMA at
> >> ExitBootServices() time, which is why they register for this event and
> >> disable DMA in their drivers. So from this pov, the state of the IOMMU
> >> is irrelevant since no device should be doing DMA anyway. The UEFI
> >> spec does not reason at all about IOMMUs.
> >>
> >> But indeed, the whole idea that the IOMMU is a 'feature' that you can
> >> ignore if you want since it will be in passthrough mode otherwise is
> >> misguided, but I'm not sure this is a firmware problem. The desire to
> >> be able to run yesterday's OS on today's hardware, especially in the
> >> Windows world, resulted in a situation where many security and
> >> hardening features are opt-in rather than opt-out, with the adoption
> >> you might expect.
> >
> > Looking at the intel iommu driver [2] there is a PCD entry to control
> > whether to leave the IOMMU enabled. Is it possible to check its value t=
o
> > see whether the bus-master disabling is necessary -- ie IOMMU was
> > enabled during boot and its going to get turned off during
> > ExitBootServices, or even check whether it's settable and if so set it
> > to leave the IOMMU enabled?
> >
> > [2] https://github.com/tianocore/edk2-platforms/blob/0d4d661b5a7cf3114a=
7d81e1c59e5cb57ceaf139/Silicon/Intel/IntelSiliconPkg/Feature/VTd/IntelVTdDx=
e/DmaProtection.c#L601
> >
>
> The platform config database is a PI concept, not a UEFI concept. IOW,
> EFI_PCD_PROTOCOL is specified in the Platform Init spec, and not the
> UEFI spec. A UEFI OS should only rely on the UEFI spec.
>

Agreed. And on top of that, PCDs can be FixedAtBuild or Patchable, in
which case they cannot be controlled via the EFI_PCD_PROTOCOL.
