Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF151A850B
	for <lists+linux-efi@lfdr.de>; Tue, 14 Apr 2020 18:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391749AbgDNQcy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Apr 2020 12:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391745AbgDNQcp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Apr 2020 12:32:45 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A92FC061A0C;
        Tue, 14 Apr 2020 09:32:44 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y4so451721ljn.7;
        Tue, 14 Apr 2020 09:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UIF3BoyuEURXStfcfS+K3X+B8H9N0p09Wke+0dl3XYI=;
        b=TPH+wfkPooywpXdD9Cf7DoG2SqrrH+5LpkpkmZTl2bh9FId8Wj45SwrTvanUR+//y4
         1gyvpoEbxgDB6f6yK/MJENkQqPxMTz5nTI3FzoffpEyVA17tiyTDji/CIDQhBod3hB0t
         gv65qG85q4UmhmbqFsxqMtyltgGFNkSTKJxcG/BivRtkIXzTdW1pPGXkjePT2Y2Ya4gb
         mDnqUTHkMGID7WFd2qOqiHKII7nPj4rrp650VIA1YKaaX3WTwLdojM4zxt0/Fbu1VF/h
         myLEbsGAEwjtSKTBFBFo39mWBo5ExLUaB+Dc6Zs3wyZn0yUbf9c2mVU5Y7SXZ+x98az/
         9Fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UIF3BoyuEURXStfcfS+K3X+B8H9N0p09Wke+0dl3XYI=;
        b=uBUpXBDrZWBeUlxR68PndaAkWqVwkCZ+2USAAmwMKOcwoJd0/v6koU9rcnoGI+F5Ju
         Ul/I5dSVphTjXOyMAYR5BkrNbQk2eVWe0zMSVJW4fIC65/ylDdWA7ihEikucZQl76JKL
         sZB4cD1v09XAmKdSeCiVTJwrJaqeG6iLW5vpzIO108CXP0yDa9f2yJ6rISmlES88W+Vg
         L29HjciRLDlVbxzAQWTOPCqtLqGPMF3XVjRe+E7J0F7YCGnNZlIXp7WXvniQVN4y76hb
         su036Jm9PEnTzn/OYTukhxHRfW3NAwqeCgURSx/CwNupTqsbiHublCzpunIsJNc0Xpv4
         XLDw==
X-Gm-Message-State: AGi0PuaQu2c0489JGCKUp0G5AFfARMUouG5GJKd7mIJ67HbTZabNGD3q
        d9mbZ0vjugqyygKTmKwhWDGNNy6OyIc6wdv0iEGd
X-Google-Smtp-Source: APiQypKnvMdqW175yj1MgsnJQRnNqTHf4wkmjSzS+0xThgvpXsnNBDZYsd9iTF/sm8QIq/tkcEC8WgbmdDmZUCqtAAI=
X-Received: by 2002:a2e:2a42:: with SMTP id q63mr563631ljq.81.1586881963108;
 Tue, 14 Apr 2020 09:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <CADDKRnBdM_T1W=iECrt89hmAmbRRyskGhS4d3ozTz1nWj_i_qQ@mail.gmail.com>
 <CAMj1kXGuMjHi=E6cVGGpwrKF_-KXcj0VRcvAdFS_vmwV7PudCQ@mail.gmail.com>
In-Reply-To: <CAMj1kXGuMjHi=E6cVGGpwrKF_-KXcj0VRcvAdFS_vmwV7PudCQ@mail.gmail.com>
From:   =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Date:   Tue, 14 Apr 2020 18:32:32 +0200
Message-ID: <CADDKRnAvC7U6kWdiqmib40cJ7r41COyic4LTdO9utsp4GOJnvA@mail.gmail.com>
Subject: Re: Kernel V5.7-rc1 doesn't boot (EFI?)
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Am Di., 14. Apr. 2020 um 12:50 Uhr schrieb Ard Biesheuvel <ardb@kernel.org>=
:
>
> On Tue, 14 Apr 2020 at 12:40, J=C3=B6rg Otte <jrg.otte@gmail.com> wrote:
> >
> > Booting my notebook with kernel V57-rc1 I get following
> > display:
> >
> > exit_boot() failed!
> > efi_main() failed!
> > StartImage failed: Buffer Too Small
> >
> > Booting Kernel V5.6 works well.
> >
> > From dmesg (kernel V5.6):
> > efi: EFI v2.31 by Phoenix Technologies Ltd.
> > efi:  ACPI=3D0xdcffe000  ACPI 2.0=3D0xdcffe014  SMBIOS=3D0xdce80000  RN=
G=3D0xdc3cd198
> > efi: seeding entropy pool
> > efi: [Firmware Bug]: Invalid EFI memory map entries:
> > efi: mem47: [Reserved           |   |  |  |  |  |  |  |  |   |  |  |
> > |  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
> > efi: mem48: [Reserved           |   |  |  |  |  |  |  |  |   |  |  |
> > |  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
> > efi: mem49: [Reserved           |   |  |  |  |  |  |  |  |   |  |  |
> > |  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
> > efi: mem50: [Reserved           |   |  |  |  |  |  |  |  |   |  |  |
> > |  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
> > efi: mem51: [Reserved           |   |  |  |  |  |  |  |  |   |  |  |
> > |  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
> > efi: Removing 5 invalid memory map entries.
> >
>
> Thanks for the report.
>
> Can you try booting with efi=3Dno_disable_early_pci_dma passed via the
> kernel command line? [*]
>
Yes, that works!

> If that does not help, can you try to reproduce with this branch?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=3Defi/=
urgent

Should I give that branch a try anyway?

Thanks, J=C3=B6rg
