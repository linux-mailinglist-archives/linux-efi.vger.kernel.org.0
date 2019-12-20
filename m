Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA48127703
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2019 09:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfLTILH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Dec 2019 03:11:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34802 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfLTILH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Dec 2019 03:11:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so8509241wrr.1
        for <linux-efi@vger.kernel.org>; Fri, 20 Dec 2019 00:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o6XSOm7xwyGESMoYLzVwZMzxM7SbJe9D4TEojq+XduA=;
        b=QpMUC9HzRkVCP+Ky9G2yxYiQzoFjYiWiWYaG5hY/RYmJ2anwvo78Qop371NF9iPxYH
         VxHVYazFlpaQ+iBaeK/Vjf/vwty4TWxGFbmc7cQDQlPCcWSUBR6sB34Jkno8LwktbLwI
         hhkoxnx82wKABzGp8kvwMbyGNwdF2pNYjA9nwek98T2OT4fSj+pi9TlWeh42sifTS7S6
         cLRVXWXPxzahiFwovOZ7CPZ/JNOVziZR/bgnq9zYUZY25Vu0n8bgzJwWBFcR3teUdKKe
         2YzBdjcqt4CfBmu+wcL/WPlczlVRGkX32zU25BSu847WfVWu+p4Fw+4UQk6rQliYaOgL
         Ps0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o6XSOm7xwyGESMoYLzVwZMzxM7SbJe9D4TEojq+XduA=;
        b=kO2kWhrfbTHceuwHnFQ4XvBVcCtW3e21FlFjxVfbz84juQ/yyQU8C0etKcsUOeKCOI
         QH3SHJ4bFYtT0aWISSnSVOqFS0qxC5OHxxQ7VGn6Yp/yWET+j+kvLadJwScTKkP03T81
         s1Ct+iCuDqf5RfdiWOoebO6Kt6AAwE+Uzz19lbBoQnUprfHtugG+vLIajsUsbIxhj1n1
         +/DKEJPP/8dTKcSsylIYgXWhi9IwE/kboPEmrtnfX5GtVUtCDcIWMr+LLHQ6HYHhnm0F
         JxXVjivEn3vn7KWzeehbCrBVB9fp2cYBotPSt2Xi6Ut9cLctcnM1PpXBy/L3IDEfEeu3
         VQVg==
X-Gm-Message-State: APjAAAXSTP6udk9FnLdAlhT449NAVaHFG227p+s0T8LH933T/OwFOa6V
        V0zLTR/lDNixhIj2wkVIJudA3giK2qmufk4m3Ijj0g==
X-Google-Smtp-Source: APXvYqzOID6b59epOaOgFFEFNC0fhUWOKXyHijQmX46hluJRsdawyUz68MM1Kor7mDBlDU+oQ3mf4/uiIDApGaojZS4=
X-Received: by 2002:a5d:6652:: with SMTP id f18mr14327124wrw.246.1576829465171;
 Fri, 20 Dec 2019 00:11:05 -0800 (PST)
MIME-Version: 1.0
References: <CAKv+Gu9-pcUGmpMVrYd+q+DJNU_737fpqwm5O2-yJJbS5KuGeg@mail.gmail.com>
 <F25F57AE-15C5-4240-99D6-F6C93CFDA447@amacapital.net>
In-Reply-To: <F25F57AE-15C5-4240-99D6-F6C93CFDA447@amacapital.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 20 Dec 2019 10:11:00 +0200
Message-ID: <CAKv+Gu8g8=yMXMNdHee7rsMWNwkhk43ZgbDEwAPHUX6Fj1jscA@mail.gmail.com>
Subject: Re: [PATCH v2 21/21] efi: Allow disabling PCI busmastering on bridges
 during boot
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 20 Dec 2019 at 09:17, Andy Lutomirski <luto@amacapital.net> wrote:
>
>
>
> > On Dec 20, 2019, at 3:07 PM, Ard Biesheuvel <ard.biesheuvel@linaro.org>=
 wrote:
> >
> > =EF=BB=BFOn Thu, 19 Dec 2019 at 22:05, Matthew Garrett <mjg59@google.co=
m> wrote:
> >>
> >>> On Wed, Dec 18, 2019 at 9:03 AM Ard Biesheuvel <ardb@kernel.org> wrot=
e:
> >>> +       status =3D efi_call_early(create_event, EVT_SIGNAL_EXIT_BOOT_=
SERVICES,
> >>> +                               TPL_CALLBACK, handle_exit_boot_servic=
es_event,
> >>> +                               NULL, &exit_boot_services_event);
> >>> +       if (status !=3D EFI_SUCCESS) {
> >>> +               pr_efi_err("Failed to register for EBS() event\n");
> >>> +               goto free_handle;
> >>> +       }
> >>
> >> OVMF's SEV implementation appears to tear down AMD's IOMMU mappings at
> >> EVT_SIGNAL_EXIT_BOOT_SERVICES. How are we ensuring that this happens
> >> first?
> >
> > It doesn't, and that is kind of the point. The only guarantee you have
> > is that this runs before ExitBootServices() returns, but after any
> > other callbacks that have been registered. I know this is not 100%
> > what you're after, but it is the only way we can avoid poking devices
> > behind the backs of their drivers.
> >
>
> Can you clarify (in the changelog or a comment perhaps) why you=E2=80=99r=
e doing this instead of turning off busmastering before calling ExitBootSer=
vices()?  Maybe this was covered in this thread, but I missed it.
>

Sure. The problem is that EBS() is the place where drivers tear down
rings etc and gracefully take down the device. So killing DMA for all
of them by clearing the BM bit of every bridge is likely to cause
problems, because the teardown code wasn't written with the idea in
mind that DMA is no longer possible. On arm64 at least, it may result
in the kernel being entered with a pending SError which will kill the
OS as soon as they are unmasked. But the UEFI drivers themselves may
simply hang or timeout on some DMA access.

> Also, surely this whole mess is a a design error in EFI, at least when SE=
V is involved, and there should be an EFI extension to keep IOMMU enabled. =
 Or a specified way to *guarantee* that DMA is off when we exit boot servic=
es without hackery.

The UEFI spec requires that all devices stop doing DMA at
ExitBootServices() time, which is why they register for this event and
disable DMA in their drivers. So from this pov, the state of the IOMMU
is irrelevant since no device should be doing DMA anyway. The UEFI
spec does not reason at all about IOMMUs.

But indeed, the whole idea that the IOMMU is a 'feature' that you can
ignore if you want since it will be in passthrough mode otherwise is
misguided, but I'm not sure this is a firmware problem. The desire to
be able to run yesterday's OS on today's hardware, especially in the
Windows world, resulted in a situation where many security and
hardening features are opt-in rather than opt-out, with the adoption
you might expect.
