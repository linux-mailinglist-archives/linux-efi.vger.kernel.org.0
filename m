Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3315E33D637
	for <lists+linux-efi@lfdr.de>; Tue, 16 Mar 2021 15:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbhCPOz3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Mar 2021 10:55:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229703AbhCPOzY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 16 Mar 2021 10:55:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6E5165091;
        Tue, 16 Mar 2021 14:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615906523;
        bh=8L6bNhJb3B7m18m3W0DRQOFDmpKaqkrfNncZ41MRqTc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LiiQhZgliTsW+cEKrSJWj4U8EUyyNwSne5fi0wX4/CPa2GuyKfSM4B1yKqI4XyPrb
         52FiqFznKj7lv+r56gb9KmAZMaPSUM9M0S7g85exaYH3hC2xQ3HLVqVyhuL7LWe6T7
         CKhXk8yXXmCDI47ud6IA8ObcRqe4ZtNUbe5TP6SbiZ0hUcarsdhQblzeu2kw1fLBYm
         7bWy9Hnu9k81bZySYSL+nyeDWUe9qMbSBezx0ZQ+xUqlLovvAVTQCOS2mn9bjc7dnn
         AEQhxa6Rd7JAgyVSYAWL7YO7+F06CKuGJQ3LokqE+qqHQ2/vZSIwZCPZwvwQ3SHc2a
         ehCgCGGGRUbnA==
Received: by mail-ot1-f46.google.com with SMTP id f8so8692474otp.8;
        Tue, 16 Mar 2021 07:55:23 -0700 (PDT)
X-Gm-Message-State: AOAM530qOU3U8KUbmNJb5eqsZnsbG8Md3wgJHJ6BjFYBuZCJ7Au4AAkZ
        IR3+Dn/3v7AhZKMouMNDcWF2fnuY5WoP7Tx819U=
X-Google-Smtp-Source: ABdhPJynGzc4MTljw2oclY0PsDVVeWK1cL4WLBqmHmEjfX/iSzOUYqjUz3aZ7oA6MOTnNBCs1jPaRF54KH0X0zsVubo=
X-Received: by 2002:a9d:7512:: with SMTP id r18mr4122853otk.90.1615906522937;
 Tue, 16 Mar 2021 07:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210307110228.GP17424@dragon> <CAMj1kXFiqXwCqJE9Wxu-tc3HYSh1qCqPLL_Csc=gW6SOYrweWw@mail.gmail.com>
 <20210309032248.GR17424@dragon> <CAF6AEGu6ZpfFK5FnQjtE33kkYL_t63J=yJLeK70_46FaLPq7eQ@mail.gmail.com>
 <CAMj1kXGwhx9Z-JCw2NvWBYtHbzVb=EmJn_Jfd97wGzDYNQG2Lw@mail.gmail.com>
 <20210315031119.GY17424@dragon> <CAMj1kXE1mZm2jYwv80FNVh0m6wHEWqq14+jQWnJSUThnX4Eedw@mail.gmail.com>
 <20210316075214.GA32651@dragon> <CAMj1kXHfo9AMZEw9btOPCzso85AS+gQdV5ycmyk8wcqfLaRn8Q@mail.gmail.com>
 <20210316090609.GB32651@dragon> <YFB7Y0FSSXmPEByF@enceladus>
 <d3d25724-6777-3c9e-5dbe-0e1570544376@gmx.de> <CAMj1kXGGdVYVxaz6+P=Ao_ZnzAOQ15eq3USzq3td-hYpbGe+vQ@mail.gmail.com>
 <a0383983-9845-24ea-4f78-dec390206c6c@gmx.de>
In-Reply-To: <a0383983-9845-24ea-4f78-dec390206c6c@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 16 Mar 2021 15:55:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE7xQ3D2-VG5hUuwaautQt5VT2d9OtAO4QFQQStpOMEJg@mail.gmail.com>
Message-ID: <CAMj1kXE7xQ3D2-VG5hUuwaautQt5VT2d9OtAO4QFQQStpOMEJg@mail.gmail.com>
Subject: Re: [PATCH] efi: stub: override RT_PROP table supported mask based on
 EFI variable
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Atish Patra <atish.patra@wdc.com>,
        Steve McIntyre <steve@einval.com>,
        Rob Clark <robdclark@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leif Lindholm <leif@nuviainc.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 16 Mar 2021 at 15:45, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 16.03.21 15:06, Ard Biesheuvel wrote:
> > On Tue, 16 Mar 2021 at 14:25, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 16.03.21 10:33, Ilias Apalodimas wrote:
> >>> Hi Shawn,
> >>>
> >>>>>>>>> So an installer either needs to set the EFI variable, or pass
> >>>>>>>>> efi=novamap on the first boot. Note that there are no arm64 EFI
> >>>>>>>>> systems known where efi=novamap causes problems. In fact, I would
> >>>>>>>>> prefer to stop using SetVirtualAddressMap() altogether, as it does not
> >>>>>>>>> provide any benefit whatsoever. So perhaps we should make efi=novamap
> >>>>>>>>> the default and be done with it.
> >>>>>>>>>
> >>>>>>>>> Broken poweroff is hardly a showstopper for an installer, given that
> >>>>>>>>> we cannot even install GRUB correctly.
> >>>>>>>>>
> >>>>>>>>> In summary, I am more than happy to collaborate constructively on this
> >>>>>>>>> (which is why I wrote the patch), but I don't think we're at a point
> >>>>>>>>> yet where this is the only thing standing in our way when it comes to
> >>>>>>>>> a smooth out-of-the-box Linux installation experience.
> >>>>>>>>
> >>>>>>>> There might be more to be done for getting a smooth Linux installation
> >>>>>>>> experience.  But IMHO, this `OverrideSupported` thing is definitely
> >>>>>>>> a big step to that.
> >>>>>>>>
> >>>>>>>
> >>>>>>> So the problem here seems to be that grub-install (or efibootmgr)
> >>>>>>> tolerates efivarfs being absent entirely, but bails out if it exists
> >>>>>>> but gives an error when trying to access it, right?
> >>>>>>
> >>>>>> Yes, with EFI variables runtime service marked as unsupported,
> >>>>>> efibootmgr will just exit on efi_variables_supported() check [1] in
> >>>>>> a way that its parent process, i.e. grub-install, doesn't take as an
> >>>>>> error.  But otherwise, efibootmgr will go much further and exit with
> >>>>>> a real error when trying to access efivars.
> >>>>>>
> >>>>>
> >>>>> OK, so I suggest we fix efibootmgr, by extending the
> >>>>> efi_variables_supported() check to perform a GetVariable() call on an
> >>>>> arbitrary variable (e.g., BootOrder),
> >>>>
> >>>> Hmm, I'm not sure we should ask more from user space, as it's already
> >>>> been doing the right thing, and efi_variables_supported() is proved to
> >>>> work properly with any sane low-level software (kernel + firmware),
> >>>> either EFI variables service is supported or not.  That said, IMHO,
> >>
> >> No, there is not one but there are three EFI variable services.
> >>
> >> GetVariable() available after ExitBootServices() and SetVariable() not
> >> available() is completely legal according to the current UEFI specification.
> >>
> >
> > This is a valid point. efibootmgr may be able to read the Boot####
> > variables, but may be unable to change them.
> >
> >>>> right now the low-level software on Snapdragon laptops is insane, i.e.
> >>>> the unsupported/broken EFI runtime services are not communicated to
> >>>> user space properly in established way.
> >>
> >> Please, describe:
> >>
> >> * Which UEFI version is reported by your Snapdragon laptop?
> >> * What is the observed behavior?
> >>
> >
> > These laptops have the EFI varstore in a eMMC partition. This is
> > basically the same problem that many uboot based platforms have as
> > well, i.e., that it is not possible for the OS and the firmware to
> > share the MMC because the ownership of the MMC controller cannot be
> > shared.
> >
> >>>
> >>> But the EFI_UNSUPPORTED is an error that's allowed from the spec.
> >>> Yes the sane thing to do is not expose it at all, but it's not violating
> >>> any spec by doing so.
> >>> So why shouldn't a userspace application be able to handle all return codes
> >>> explicitly and instead treat them as a single error? And when that happens why
> >>> shouldut  the kernel mask that error out for it?
> >>
> >> The runtime services must always be callable even they can only report
> >> EFI_UNSUPPORTED.
> >>
> >> Only since UEFI specification 2.8 errata B do we have the
> >> EFI_RT_PROPERTIES_TABLE which tells us which runtime services are
> >> implemented.
> >>
> >> UEFI 2.8 B makes it clear that any runtime service may be reported as
> >> unsupported. EFI applications are expected to cope with a service being
> >> unavailable.
> >>
> >
> > Indeed. The firmware on these machines predates the UEFI 2.8B
> > specification, but given the fact that EFI_UNSUPPORTED is a valid
> > return code now for these services, we should deal with them
> > gracefully anyway. And apparently, doing so would also remove the need
> > for special hacks to support installing GRUB on these platforms.
> >
>
> Hello Ard,
>
> it is still unclear to why you would need the patch. Why should a user
> provide a UEFI variable telling which service is not working correctly?
>

Why would it be the user setting this variable?

> Is the firmware correctly returning EFI_UNSUPPORTED for unsupported
> services?

Yes

> For which services?
>

All runtime services except SetVirtualAddressMap() and ResetSystem()

> In which software is the bug that cannot gracefully deal with
> unsupported services?
>

The debian installer gives up if it cannot set the boot path for GRUB.

> GRUB never gave me a problem on boards with U-Boot which only provides
> GetVariable() and not SetVariable(). GRUB spits out warnings but works
> as expected.
>
> Best regards
>
> Heinrich
