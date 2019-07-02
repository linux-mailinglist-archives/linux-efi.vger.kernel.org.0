Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33D4F5D997
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jul 2019 02:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfGCAsm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Jul 2019 20:48:42 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44313 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfGCAsm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Jul 2019 20:48:42 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so309249edr.11;
        Tue, 02 Jul 2019 17:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HvMK1U3mSSIhGP7RCajA7JG3xXgs2w4egMaNm/sjjUA=;
        b=MW9ZpERJUQAII+y5hHpAXfKIB35FrQAFXdgIxpVSE/K3dtOZ8jbYpV1hW8xe8FJz+K
         0ClnaWJEzQWyez0nkZgKubQEdncxmmkvd1669rbTlj4+KDro37xffkFpMQXDtHEIP+24
         r1uc0v219ClLkICFhc894IOs6ubynozVJb6CSJ4oDFDRC9UpNgxOK+XECgubHiq0YIhB
         mqqT0cpFlxHgIwN48d/VhgHnBZ3n5bc0Wrw5Dv8PDmdGmtIyfB26KN/RYZqONoFXgl1q
         BSnW6MiWfFcbGg+YtjIVlwwFaW1zO5MIjD0vaXqVIdv1aIED6+KqqZhe5S/cGilU/WLV
         z8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HvMK1U3mSSIhGP7RCajA7JG3xXgs2w4egMaNm/sjjUA=;
        b=DIusMBw91GJIARtzGU708+dTRWlv3O2CyDX5u7IssiR8DP20+C+tUK2PzpA6fQLKI1
         i7vhotdF62c1fJ1rKrPONR3ll/i1N2YkkbKjLjcOS8JQIlI+YlOdOgBpNaQAYGgqgkdg
         LEKiyAgY3BkejAU18COrQKPDatL93vT1B4AS7FPMlJ2Ol7jfce2/cxsyA8e2AVJ3conY
         CiqBSnuTB4JeT5REBMBYr1gL+qBFLh/lP+H8uV07X1zuMjX5OiVyN9YSkGsWWpug3P6q
         kPuoZMxzN1sqxS0ifQhRgVKA7rmaIBBm8q124nsrDasrWiizxiVGr2dABmaZcVqRJS+t
         W6UQ==
X-Gm-Message-State: APjAAAWhJqc9Sc5EacTrsC4ZrluwdIoD7rBsVwubRKXZLuZCoriYosiJ
        ni+q5gA66anRhsuKlKJiJyHwQ6D3au+Bb0bEC/N3FS8esZf+IA==
X-Google-Smtp-Source: APXvYqwEwOLS0R67S4CWtviQf6gj1WsabSLC1YiBzuE0hxTXO8rI+xmH/s+9mAXwppDwa/sfJAdp+Bb1LMYRy544aRI=
X-Received: by 2002:a50:9203:: with SMTP id i3mr38838506eda.302.1562101325167;
 Tue, 02 Jul 2019 14:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190630203614.5290-1-robdclark@gmail.com> <20190630203614.5290-3-robdclark@gmail.com>
 <CAKv+Gu_8BOt+f8RTspHo+se-=igZba1zL0+jWLV2HuuUXCKYpA@mail.gmail.com> <CAKv+Gu-KhPJxxJA3+J813OPcnoAD4nHq6MhiRTJSd_5y1dPNnw@mail.gmail.com>
In-Reply-To: <CAKv+Gu-KhPJxxJA3+J813OPcnoAD4nHq6MhiRTJSd_5y1dPNnw@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 2 Jul 2019 14:01:49 -0700
Message-ID: <CAF6AEGv+uAXVV6Q78n=jP0YRDjYn9OS=Xec9MU0+_7EBirxF5w@mail.gmail.com>
Subject: Re: [PATCH 2/4] efi/libstub: detect panel-id
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        aarch64-laptops@lists.linaro.org,
        Rob Clark <robdclark@chromium.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Alexander Graf <agraf@suse.de>,
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

On Tue, Jul 2, 2019 at 1:35 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Tue, 2 Jul 2019 at 22:26, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > On Sun, 30 Jun 2019 at 22:36, Rob Clark <robdclark@gmail.com> wrote:
> > >
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > On snapdragon aarch64 laptops, a 'UEFIDisplayInfo' variable is provided
> > > to communicate some information about the display.  Crutially it has the
> > > panel-id, so the appropriate panel driver can be selected.  Read this
> > > out and stash in /chosen/panel-id so that display driver can use it to
> > > pick the appropriate panel.
> > >
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> >
> > Hi Rob,
> >
> > I understand why you are doing this, but this *really* belongs elsewhere.
> >
> > So we are dealing with a platform that violates the UEFI spec, since
> > it does not bother to implement variable services at runtime (because
> > MS let the vendor get away with this).
> >
>
> To clarify, the above remark applies to populating the DT from the OS
> rather than from the firmware.

yeah, it isn't pretty, but there *are* some other similar cases where
efi-stub is populating DT.. (like update_fdt_memmap() and
kaslr-seed)..

it would be kinda nice to have an early-quirks mechanism where this
could fit, but I thought that might be equally unpopular ;-)

>
> > First of all, to pass data between the EFI stub and the OS proper, we
> > should use a configuration table rather than a DT property, since the
> > former is ACPI/DT agnostic. Also, I'd like the consumer of the data to
> > actually interpret it, i.e., just dump the whole opaque thing into a
> > config table in the stub, and do the parsing in the OS proper.
> >
> > However, I am not thrilled at adding code to the stub that
> > unconditionally looks for some variable with some magic name on all
> > ARM/arm64 EFI systems, so this will need to live under a Kconfig
> > option that depends on ARM64 (and does not default to y)

I defn can add this under kconfig.. is it ok if that option is
select'd by ARCH_QCOM?

(Just trying to minimize the things that can go wrong and the "I get a
blank screen at boot" bug reports I get ;-))

> ... but saving variables at boot time for consumption at runtime is
> something that we will likely see more of in the future.

I think this will be nice, but it also doesn't address the need for a
quirk to get this into /chosen..  I guess we *could* use a shim or
something that runs before the kernel to do this.  But that just seems
like a logistical/support nightmare.  There is one kernel, and there
are N distro's, so debugging a users "I don't get a screen at boot"
problem because their distro missed some shim patch really just
doesn't seem like a headache I want to have.

BR,
-R
