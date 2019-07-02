Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 572845D984
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jul 2019 02:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfGCAql (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Jul 2019 20:46:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33228 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCAql (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Jul 2019 20:46:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so725832wru.0
        for <linux-efi@vger.kernel.org>; Tue, 02 Jul 2019 17:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F9/H9RAoH6E0au9JZUxTVdK2VUAjq3U7v2tg4NjLm2E=;
        b=SK3VY71b9UfihRePdJGtKBSdbFrEGcoMgA1+oLMpx0UPe6Zi3uDRyGD2EMNmRcqIq+
         l0yxeXPdzy0dawH3rtJ13sku4q+pHqx7YfCt0T/4f0C1De+u9h4Kz7vk989kCRBNZ824
         mTFjAk2XxdC4yvnm3rbUtw188u5UCkTkf8iB9ychSLYnKHzkYHKzxWzg/0qF5Kfv/9Ig
         /GrTrehl6RSlBv6Ck2krL2WRej8+bAHwkMfScnrp4Eezc+lmMKJpg/mT/Sg9laJXC7bT
         NPJ2fF2dt1HcWXS/Ex0YgUuMz0yKlYeezBAJ9Kv3upJ4MbSyUkw1RN7KepizvqV+xWfx
         5AhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F9/H9RAoH6E0au9JZUxTVdK2VUAjq3U7v2tg4NjLm2E=;
        b=iFtzEHIEyofxdWFBaEB+npFpgHtSMPPbBH86f3u9A/KCPIjItN1Ofzibhq2sokzVe5
         jJud9alf+vtpm/mNaZUX32JBfZxRs54Vsg4DRVgpwztG4Xlbibhbz9Z02jLqitKPMwc5
         6oaaqPq3yZQXDIn03Z19zr8/soW0KEdYqkLr3awiCRxpUiNbXbrn40Wfvh01AtA9QK7W
         xZpFFpYls0Grw4f++SR75/Ef9JxB8cX+oFoXCFy5CTFiKaln8NjwHZzM9u+P42dDgyRg
         iB1a3CAluDGct8Il324OIKPu8ZqqlQOROvNufQaToHbGArjvCU1nBVVNFB/1FRyylPyV
         2Cmw==
X-Gm-Message-State: APjAAAXPEGotSfAKQh1/SMp5S4NxkY8ssg9ebGKza6iY1dQvTWVX2q0D
        TJCfHnub/GEpFMNlEiM2C7eF0hcWYtUmv25g+ThFqQ==
X-Google-Smtp-Source: APXvYqwncd3iUgHVxdaYlFV1ID7X2V0/XLGwEniTYBbvfKVWOvdTx6vknWmPXyn5a8WQ1T7hGJ+i80nMqSq/lFM6R0k=
X-Received: by 2002:a5d:6743:: with SMTP id l3mr14273796wrw.241.1562104410996;
 Tue, 02 Jul 2019 14:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190630203614.5290-1-robdclark@gmail.com> <20190630203614.5290-3-robdclark@gmail.com>
 <CAKv+Gu_8BOt+f8RTspHo+se-=igZba1zL0+jWLV2HuuUXCKYpA@mail.gmail.com>
 <CAKv+Gu-KhPJxxJA3+J813OPcnoAD4nHq6MhiRTJSd_5y1dPNnw@mail.gmail.com> <CAF6AEGv+uAXVV6Q78n=jP0YRDjYn9OS=Xec9MU0+_7EBirxF5w@mail.gmail.com>
In-Reply-To: <CAF6AEGv+uAXVV6Q78n=jP0YRDjYn9OS=Xec9MU0+_7EBirxF5w@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 2 Jul 2019 23:53:16 +0200
Message-ID: <CAKv+Gu9pH9=AnNee7B-z0sP3rGJ-0Qnpziyx445M30KWC=Vq+w@mail.gmail.com>
Subject: Re: [PATCH 2/4] efi/libstub: detect panel-id
To:     Rob Clark <robdclark@gmail.com>
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

On Tue, 2 Jul 2019 at 23:02, Rob Clark <robdclark@gmail.com> wrote:
>
> On Tue, Jul 2, 2019 at 1:35 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > On Tue, 2 Jul 2019 at 22:26, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > >
> > > On Sun, 30 Jun 2019 at 22:36, Rob Clark <robdclark@gmail.com> wrote:
> > > >
> > > > From: Rob Clark <robdclark@chromium.org>
> > > >
> > > > On snapdragon aarch64 laptops, a 'UEFIDisplayInfo' variable is provided
> > > > to communicate some information about the display.  Crutially it has the
> > > > panel-id, so the appropriate panel driver can be selected.  Read this
> > > > out and stash in /chosen/panel-id so that display driver can use it to
> > > > pick the appropriate panel.
> > > >
> > > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > >
> > > Hi Rob,
> > >
> > > I understand why you are doing this, but this *really* belongs elsewhere.
> > >
> > > So we are dealing with a platform that violates the UEFI spec, since
> > > it does not bother to implement variable services at runtime (because
> > > MS let the vendor get away with this).
> > >
> >
> > To clarify, the above remark applies to populating the DT from the OS
> > rather than from the firmware.
>
> yeah, it isn't pretty, but there *are* some other similar cases where
> efi-stub is populating DT.. (like update_fdt_memmap() and
> kaslr-seed)..
>

True, but those don't describe the hardware.

> it would be kinda nice to have an early-quirks mechanism where this
> could fit, but I thought that might be equally unpopular ;-)
>

Very :-)

> >
> > > First of all, to pass data between the EFI stub and the OS proper, we
> > > should use a configuration table rather than a DT property, since the
> > > former is ACPI/DT agnostic. Also, I'd like the consumer of the data to
> > > actually interpret it, i.e., just dump the whole opaque thing into a
> > > config table in the stub, and do the parsing in the OS proper.
> > >
> > > However, I am not thrilled at adding code to the stub that
> > > unconditionally looks for some variable with some magic name on all
> > > ARM/arm64 EFI systems, so this will need to live under a Kconfig
> > > option that depends on ARM64 (and does not default to y)
>
> I defn can add this under kconfig.. is it ok if that option is
> select'd by ARCH_QCOM?
>

I guess some mobile SOC/snapdragon symbol would be more appropriate,
but given that qcom left the server business, I guess it hardly
matters, so default y if ARM64 && ARCH_QCOM is fine with me

> (Just trying to minimize the things that can go wrong and the "I get a
> blank screen at boot" bug reports I get ;-))
>

Sure

> > ... but saving variables at boot time for consumption at runtime is
> > something that we will likely see more of in the future.
>
> I think this will be nice, but it also doesn't address the need for a
> quirk to get this into /chosen..  I guess we *could* use a shim or
> something that runs before the kernel to do this.  But that just seems
> like a logistical/support nightmare.  There is one kernel, and there
> are N distro's, so debugging a users "I don't get a screen at boot"
> problem because their distro missed some shim patch really just
> doesn't seem like a headache I want to have.
>

I'd argue that this does not belong in /chosen in the first place,
i.e., it doesn't belong in the DT at all if the OS can access the
config table (and therefore the variable) directly.
