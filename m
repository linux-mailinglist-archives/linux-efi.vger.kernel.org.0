Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0993F1A96A9
	for <lists+linux-efi@lfdr.de>; Wed, 15 Apr 2020 10:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgDOIft (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Apr 2020 04:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725970AbgDOIfr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Apr 2020 04:35:47 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9B9C061A0C;
        Wed, 15 Apr 2020 01:35:47 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u10so1951305lfo.8;
        Wed, 15 Apr 2020 01:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k1/w3TP0F3mXSc/H4GTFUFzXpay4oNzMjeY5aEbI1a4=;
        b=JXbGT/Cm7B+ndCJZ+ZKxR3FufzVtv6SGGxje1yZjweDGZa1OMOmYRgeKX2uU//CLZq
         xSaprV9p0fjW4cNEmwZGQ3jGI29UQ9ECWsxqCwYB/3PPRITZEIqxiPserXNaTGf0u3MD
         ZttxgGLlwVRKfblDqA0MVxD8eJb4hSj4PU7CnNT5c9RnIH8AkFeIgKiGM5JLgOT6zBNJ
         ZkJwGCFeknax7E+bFHV0tVUxJPfTqLq1Qmo+7EFEGLIVU41pJHY8dl6E7ia6qc3OLNDs
         N9EwR7Kz7CrLR63LJfF/DfjrU43uINu1Kcgq8/ZVRmR2W7/I2aqa38fW/kTn/0PQvN5X
         jlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k1/w3TP0F3mXSc/H4GTFUFzXpay4oNzMjeY5aEbI1a4=;
        b=aCPQFaGkQImDkeairwlfUF/ikgZt3ypYmwYQKPnsPbDpRdj+YI89SCHIk08De5x2tn
         2sYPpYQPgSjWfHukg3y6+wOpleYnHe3lbKO0shPWO2XJdQNruqCLv6VqjmK2QqrdDt8x
         VSZITHDsgxVETzCSHHTuuFD52KdIhgH2403FzHPIsTQYyr0RVwj1CVVp/DiJJeTLVo9o
         NY6NYjwQt49Fg+zSAZFXMWwSiZbzVO12c7EVkg/4UPtVv4kPmI8RITVgF689A+rhplix
         cW2ywIXWWmLbz7al1cQ8Z1K4Yrg4nA4Q2h23IU4wlSuFuXOsGckETZNMLZLzTRivXKVT
         O6hA==
X-Gm-Message-State: AGi0PuZoT1vRGRwhN35pwVkiUiOpb1nvBmchVU+uE0p3VyHWJVuYFTI4
        +VKS4bxJT59TQzdOKW+/pmA27+n6FL5IVJUV2z2z
X-Google-Smtp-Source: APiQypLMYd2W6Hps+Tw5Q0Eu2nK03H0HW0dAfvJDaHZsp7OrdKonQ+OArl4/kj678maqfuFNqbS+QZXRmTlk8h2FJAg=
X-Received: by 2002:ac2:522e:: with SMTP id i14mr2392294lfl.140.1586939745950;
 Wed, 15 Apr 2020 01:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <CADDKRnBdM_T1W=iECrt89hmAmbRRyskGhS4d3ozTz1nWj_i_qQ@mail.gmail.com>
 <CAMj1kXGuMjHi=E6cVGGpwrKF_-KXcj0VRcvAdFS_vmwV7PudCQ@mail.gmail.com>
 <CADDKRnAvC7U6kWdiqmib40cJ7r41COyic4LTdO9utsp4GOJnvA@mail.gmail.com> <CAMj1kXEDJ67oJJjKtDC--VXmr+z8-voPhHnRnaMCEfo5Pc6Sqg@mail.gmail.com>
In-Reply-To: <CAMj1kXEDJ67oJJjKtDC--VXmr+z8-voPhHnRnaMCEfo5Pc6Sqg@mail.gmail.com>
From:   =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Date:   Wed, 15 Apr 2020 10:35:34 +0200
Message-ID: <CADDKRnBzMPw8cj5CQv93rxydx8LcNVyfs4mfrLvqxBEtH_r3zQ@mail.gmail.com>
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

Am Di., 14. Apr. 2020 um 18:35 Uhr schrieb Ard Biesheuvel <ardb@kernel.org>=
:
>
> On Tue, 14 Apr 2020 at 18:32, J=C3=B6rg Otte <jrg.otte@gmail.com> wrote:
> >
> > Am Di., 14. Apr. 2020 um 12:50 Uhr schrieb Ard Biesheuvel <ardb@kernel.=
org>:
> > >
> > > On Tue, 14 Apr 2020 at 12:40, J=C3=B6rg Otte <jrg.otte@gmail.com> wro=
te:
> > > >
> > > > Booting my notebook with kernel V57-rc1 I get following
> > > > display:
> > > >
> > > > exit_boot() failed!
> > > > efi_main() failed!
> > > > StartImage failed: Buffer Too Small
> > > >
> > > > Booting Kernel V5.6 works well.
> > > >
> > > > From dmesg (kernel V5.6):
> > > > efi: EFI v2.31 by Phoenix Technologies Ltd.
> > > > efi:  ACPI=3D0xdcffe000  ACPI 2.0=3D0xdcffe014  SMBIOS=3D0xdce80000=
  RNG=3D0xdc3cd198
> > > > efi: seeding entropy pool
> > > > efi: [Firmware Bug]: Invalid EFI memory map entries:
> > > > efi: mem47: [Reserved           |   |  |  |  |  |  |  |  |   |  |  =
|
> > > > |  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
> > > > efi: mem48: [Reserved           |   |  |  |  |  |  |  |  |   |  |  =
|
> > > > |  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
> > > > efi: mem49: [Reserved           |   |  |  |  |  |  |  |  |   |  |  =
|
> > > > |  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
> > > > efi: mem50: [Reserved           |   |  |  |  |  |  |  |  |   |  |  =
|
> > > > |  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
> > > > efi: mem51: [Reserved           |   |  |  |  |  |  |  |  |   |  |  =
|
> > > > |  ] range=3D[0x0000000000000000-0x0000000000000000] (invalid)
> > > > efi: Removing 5 invalid memory map entries.
> > > >
> > >
> > > Thanks for the report.
> > >
> > > Can you try booting with efi=3Dno_disable_early_pci_dma passed via th=
e
> > > kernel command line? [*]
> > >
> > Yes, that works!
> >
> > > If that does not help, can you try to reproduce with this branch?
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=3D=
efi/urgent
> >
> > Should I give that branch a try anyway?
> >
>
> Your test proves that BSS is not being cleared correctly, so I have
> the answer I was looking for. However, I would appreciate it if you
> could test that branch, just to double check.
>
> Thanks,
> Ard.

The branch works for me too!

Thanks, J=C3=B6rg
