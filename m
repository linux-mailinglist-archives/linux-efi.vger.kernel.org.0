Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F65F5D8EC
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jul 2019 02:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfGCAax (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Jul 2019 20:30:53 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42467 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfGCAaw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Jul 2019 20:30:52 -0400
Received: by mail-ed1-f65.google.com with SMTP id z25so289911edq.9;
        Tue, 02 Jul 2019 17:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SUMBHjqHxfFISJ4tsGh6gHnVJafzY5uBObk9/M1SI6Y=;
        b=p4QfsUpxZBUPSNbm9a2ya6+yOVBLb06CncvEKO0qxtLknZ9dc5s45n/yCCCk8pVAGr
         kTtuJCFsVLSmNXI13tt/3c+qkzMeuAESDbdCbiFxU8ZGu73hjgvAB7S/EKz0qJg50PM0
         mggd9oJOp7fMPe31Y0DXLnsbQg44FXj8SGYjCyvHT1W/uN6YXAprbpsjvRGAUJjnYqRY
         UbDxAZ046ar2qRfBKMqC0yk+pCMu82zzkmqLwb0ooQKB2mTZVaIkovBFit3MwyXI7wOa
         w8KYcr5NOXHJ2fqa9bjhrPr+UG3CdQ92BH7V+3eVd900MzHNSuuuaZW55wl9e7h6e4PB
         vpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SUMBHjqHxfFISJ4tsGh6gHnVJafzY5uBObk9/M1SI6Y=;
        b=aVNjQ3aZKn5OZO6na5MU7plZ2bIrRI4uKGXUdogHKc83QwSguIIWojeTQ6a98RJsoY
         seUCji2cu6dDrRoai6omiLtnJNGl9aCP8lokwtBo0iHvcEfeNNaiMRwxbf55M1jjmjZ/
         wKrZ6vd7qOi5YS9fXauI1ZGNUoypzd5cKYVawj1/qa79TGAndm5st5RctIA83j4tKex6
         +MCqM1iFMMjZAkvGK1dUYUsmZMJVbMMK4xsR5ToS6E9fcO5s1uYN7YjgOj+SkJwI1gi8
         mRqrLXCigMVnFiSPCjeyNPoc4qB7TUtCz/AuF7TFimruNZhHteLUdS7r1yW5KT6uKT7G
         sR0Q==
X-Gm-Message-State: APjAAAUEb3xclV+iEMHuPIodvsXJzHwrFrAskdb9Mv29M+8tmv8+1g1g
        TVlQIbeBrkovOrG7/E0htTtfVmNDeORQGsqLuL+4aToXaVs=
X-Google-Smtp-Source: APXvYqx4j4OCiYpTjzpwx7oNckBn+SqKRP14iTHp1P6MaiYoDQDLUnA3ecoEITujxJ6YGjIOt/liDhVugoLpxJ8Knu0=
X-Received: by 2002:a50:9468:: with SMTP id q37mr38323779eda.163.1562107743736;
 Tue, 02 Jul 2019 15:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190630203614.5290-1-robdclark@gmail.com> <20190630203614.5290-3-robdclark@gmail.com>
 <CAKv+Gu_8BOt+f8RTspHo+se-=igZba1zL0+jWLV2HuuUXCKYpA@mail.gmail.com>
 <CAKv+Gu-KhPJxxJA3+J813OPcnoAD4nHq6MhiRTJSd_5y1dPNnw@mail.gmail.com>
 <CAF6AEGv+uAXVV6Q78n=jP0YRDjYn9OS=Xec9MU0+_7EBirxF5w@mail.gmail.com> <20190702215953.wdqges66hx3ge4jr@bivouac.eciton.net>
In-Reply-To: <20190702215953.wdqges66hx3ge4jr@bivouac.eciton.net>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 2 Jul 2019 15:48:48 -0700
Message-ID: <CAF6AEGvm62rcm4Lp4a+QmqFweVQ0QWXLDoN2CP8=40BdwiiVbQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] efi/libstub: detect panel-id
To:     Leif Lindholm <leif.lindholm@linaro.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        aarch64-laptops@lists.linaro.org,
        Rob Clark <robdclark@chromium.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
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

On Tue, Jul 2, 2019 at 2:59 PM Leif Lindholm <leif.lindholm@linaro.org> wrote:
>
> On Tue, Jul 02, 2019 at 02:01:49PM -0700, Rob Clark wrote:
> > > > So we are dealing with a platform that violates the UEFI spec, since
> > > > it does not bother to implement variable services at runtime (because
> > > > MS let the vendor get away with this).
> > >
> > > To clarify, the above remark applies to populating the DT from the OS
> > > rather than from the firmware.
> >
> > yeah, it isn't pretty, but there *are* some other similar cases where
> > efi-stub is populating DT.. (like update_fdt_memmap() and
> > kaslr-seed)..
>
> The problem isn't with the stub updating the DT, the problem is what
> it updates it with.
>
> update_fdt_memmap() is the stub filling in the information it
> communicates to the main kernel.
>
> kaslr-seed sets a standard property using a standard interface if that
> interface is available to it at the point of execution.
>
> Since what we're doing here is dressing up an ACPI platform to make it
> look like it was a DT platform, and since we have the ability to tweak
> the DT before ever passing it to the kernel, let's just do that.
>
> Yes, I know I said I'd rather not, but it's way nicer than sticking
> platform-specific hacks into the EFI stub.
>
> (If adding it as a DT property is indeed the thing to do.)
>
> > > ... but saving variables at boot time for consumption at runtime is
> > > something that we will likely see more of in the future.
> >
> > I think this will be nice, but it also doesn't address the need for a
> > quirk to get this into /chosen..  I guess we *could* use a shim or
> > something that runs before the kernel to do this.  But that just seems
> > like a logistical/support nightmare.
> >
> > There is one kernel, and there
> > are N distro's, so debugging a users "I don't get a screen at boot"
> > problem because their distro missed some shim patch really just
> > doesn't seem like a headache I want to have.
>
> The distros should not need to be aware *at all* of the hacks required
> to disguise these platforms as DT platforms.
>
> If they do, they're already device-specific installers and have
> already accepted the logistical/support nightmare.
>

I guess I'm not *against* a DT loader shim populating the panel-id
over into /chosen.. I had it in mind as a backup plan.  Ofc still need
to get dt folks to buy into /chosen/panel-id but for DT boot I think
that is the best option.  (At least the /chosen/panel-id approach
doesn't require the shim to be aware of how the panel is wired up to
dsi controller and whether their is a bridge in between, and that
short of thing, so the panel-id approach seems more maintainable that
other options.)

I am a bit fearful of problems arising from different distros and
users using different versions of shim, and how to manage that.  I
guess if somehow "shim thing" was part of the kernel, there would by
one less moving part... I'd know if user had kernel vX.Y.Z they'd be
good to go vs not.  But *also* depending on a new-enough version of a
shim, where the version # is probably not easily apparent to the end
user, sounds a bit scary from the "all the things that can go wrong"
point of view.  Maybe I'm paranoid, but I'm a bit worried about how to
manage that.

BR,
-R
