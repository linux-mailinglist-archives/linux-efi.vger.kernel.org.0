Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 363C75D89E
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jul 2019 02:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfGCA0h (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Jul 2019 20:26:37 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36364 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGCA0h (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Jul 2019 20:26:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id k21so309917edq.3;
        Tue, 02 Jul 2019 17:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VZAFhtlOp5m5IcdkT0M3zeWqXJjIkrtR0IvKZYA1K+M=;
        b=RNTyqH/ceLcT+PerwCHJqQxAqAbl3I/4n9nfUD1rbqCMHjkJ1yjJKXPlhHVTm0/3PL
         GDDdjZpqLUCcBNL0fbqRqFHVIBYL3dg1iPSRIVfMivH59l0C4Q43EWRjv5swOEkCWxS7
         XBg2EvsYn6GdfkIr52RA4wislpKD0gWQuqT/z8u/oke+PwuozA88rKogHM4x6rQexUei
         WKtlhaufWxo2iOfuPZrxA9BpY2Qsok8UP2uyDobE4mWGuCvZ2WsoIuHu1XKm7EQY/iJ5
         uXdpSBj4pA4vd+0E6GyUmy4q45LBnFnFvioaja3bL7wS1Tf6iliwK6NKn2Jk9aBRGqS2
         FuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VZAFhtlOp5m5IcdkT0M3zeWqXJjIkrtR0IvKZYA1K+M=;
        b=j6E6dtJF/+f/sISn+FIJEubMaOBOc6J/fM1q6n2pLmFjGyYerweb4eKO9ZP9w0tyNY
         boxY9YrH2TbtgkItY6oZ1KSahSVpkfxasDMmVfqPHMPbZi3eSROOE4V9EhPRmOkcr+Hx
         t08GB6C3LXOJgjF3sUSiJIbjNlJLOZ1XccA3jdajcfMNoY6hrnsmrMfDDnTPmYxxIull
         xTLU12C1uhUe2lAhr14oKP/eTyqh4MW1R+nx8JrVQGAtBQJdaoV8rQdYT1/DY+UR8tP2
         IOVo9U1+6eBtIqeA/VSMzW+lVNMjIcjIJF1J2DBFcXgfAQw2GF9t2okrNGgTYydgdiBF
         VpWA==
X-Gm-Message-State: APjAAAVgl93QGe+Jv9q8IGB1kgFOAkgnDmgBuXPLExBPIPnfzI4Rk8fL
        va3HGQ5ykzqYzwyV/PSweYVV1AF5pUPyeM9YrG3eayTFv3M=
X-Google-Smtp-Source: APXvYqwCaZ62YgXGr6Wefiah678BTMIgXWNniNpMylBAQqop4o300YsLoRAst/FDjF5RPt9iVWwNrtIHGTFPlYJxpS4=
X-Received: by 2002:a17:906:6802:: with SMTP id k2mr5942794ejr.174.1562107010010;
 Tue, 02 Jul 2019 15:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190630203614.5290-1-robdclark@gmail.com> <20190630203614.5290-3-robdclark@gmail.com>
 <CAKv+Gu_8BOt+f8RTspHo+se-=igZba1zL0+jWLV2HuuUXCKYpA@mail.gmail.com>
 <CAKv+Gu-KhPJxxJA3+J813OPcnoAD4nHq6MhiRTJSd_5y1dPNnw@mail.gmail.com>
 <CAF6AEGv+uAXVV6Q78n=jP0YRDjYn9OS=Xec9MU0+_7EBirxF5w@mail.gmail.com> <CAKv+Gu9pH9=AnNee7B-z0sP3rGJ-0Qnpziyx445M30KWC=Vq+w@mail.gmail.com>
In-Reply-To: <CAKv+Gu9pH9=AnNee7B-z0sP3rGJ-0Qnpziyx445M30KWC=Vq+w@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 2 Jul 2019 15:36:34 -0700
Message-ID: <CAF6AEGtN0LXY9wBkh+JVPgUgBMUU1NPrtn1F4y78w3z-gXspvQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] efi/libstub: detect panel-id
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        aarch64-laptops@lists.linaro.org,
        Rob Clark <robdclark@chromium.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Steve Capper <steve.capper@arm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Julien Thierry <julien.thierry@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jul 2, 2019 at 2:53 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Tue, 2 Jul 2019 at 23:02, Rob Clark <robdclark@gmail.com> wrote:
> >
> > On Tue, Jul 2, 2019 at 1:35 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > >
> > > On Tue, 2 Jul 2019 at 22:26, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > > >
> > > > On Sun, 30 Jun 2019 at 22:36, Rob Clark <robdclark@gmail.com> wrote:
> > > > >
> > > > > From: Rob Clark <robdclark@chromium.org>
> > > > >
> > > > > On snapdragon aarch64 laptops, a 'UEFIDisplayInfo' variable is provided
> > > > > to communicate some information about the display.  Crutially it has the
> > > > > panel-id, so the appropriate panel driver can be selected.  Read this
> > > > > out and stash in /chosen/panel-id so that display driver can use it to
> > > > > pick the appropriate panel.
> > > > >
> > > > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > >
> > > > Hi Rob,
> > > >
> > > > I understand why you are doing this, but this *really* belongs elsewhere.
> > > >
> > > > So we are dealing with a platform that violates the UEFI spec, since
> > > > it does not bother to implement variable services at runtime (because
> > > > MS let the vendor get away with this).
> > > >
> > >
> > > To clarify, the above remark applies to populating the DT from the OS
> > > rather than from the firmware.
> >
> > yeah, it isn't pretty, but there *are* some other similar cases where
> > efi-stub is populating DT.. (like update_fdt_memmap() and
> > kaslr-seed)..
> >
>
> True, but those don't describe the hardware.
>
> > it would be kinda nice to have an early-quirks mechanism where this
> > could fit, but I thought that might be equally unpopular ;-)
> >
>
> Very :-)
>
> > >
> > > > First of all, to pass data between the EFI stub and the OS proper, we
> > > > should use a configuration table rather than a DT property, since the
> > > > former is ACPI/DT agnostic. Also, I'd like the consumer of the data to
> > > > actually interpret it, i.e., just dump the whole opaque thing into a
> > > > config table in the stub, and do the parsing in the OS proper.
> > > >
> > > > However, I am not thrilled at adding code to the stub that
> > > > unconditionally looks for some variable with some magic name on all
> > > > ARM/arm64 EFI systems, so this will need to live under a Kconfig
> > > > option that depends on ARM64 (and does not default to y)
> >
> > I defn can add this under kconfig.. is it ok if that option is
> > select'd by ARCH_QCOM?
> >
>
> I guess some mobile SOC/snapdragon symbol would be more appropriate,
> but given that qcom left the server business, I guess it hardly
> matters, so default y if ARM64 && ARCH_QCOM is fine with me
>
> > (Just trying to minimize the things that can go wrong and the "I get a
> > blank screen at boot" bug reports I get ;-))
> >
>
> Sure
>
> > > ... but saving variables at boot time for consumption at runtime is
> > > something that we will likely see more of in the future.
> >
> > I think this will be nice, but it also doesn't address the need for a
> > quirk to get this into /chosen..  I guess we *could* use a shim or
> > something that runs before the kernel to do this.  But that just seems
> > like a logistical/support nightmare.  There is one kernel, and there
> > are N distro's, so debugging a users "I don't get a screen at boot"
> > problem because their distro missed some shim patch really just
> > doesn't seem like a headache I want to have.
> >
>
> I'd argue that this does not belong in /chosen in the first place,
> i.e., it doesn't belong in the DT at all if the OS can access the
> config table (and therefore the variable) directly.

admittedly I'm trying to solve two different problems here.. we also
have the problem of knowing which panel is installed for the "pure DT"
case.. where /chosen is (IMO) the right thing (alternatives involve a
shim that knows far too much about the device)..

I guess for ACPI boot case, we do anyways want some sort of
configuration table.  I suppose the drm code could look for both
/chosen/panel-id and configuration table and use either.  Although it
would be nice if somehow the config table info ended up in /chosen
when we are not using ACPI, since then at least code paths are more
similar to how we want future android devices to solve this without a
pile of downstream hacks..

BR,
-R
