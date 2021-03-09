Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FA2332E80
	for <lists+linux-efi@lfdr.de>; Tue,  9 Mar 2021 19:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhCISr6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Mar 2021 13:47:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:44618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230084AbhCISri (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 9 Mar 2021 13:47:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9CE265235;
        Tue,  9 Mar 2021 18:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615315657;
        bh=7H+tcSHJt3q+GbterfsgeBgpXEyQMLgO9zuQ1i9IlhE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V4PEmBzOwuNAY/KxXD4tj23iEknwrTeoRzkviNUYRVbUK/xmAtDMxHhMz3BH5SLY6
         flCNifGAk9AmOoTRpRZXdFxvvAJG7s0uriWeLfXEqN9NxJUcXhI9GgkogK4eHte/0W
         u563Xp49TrQoclaxXu/g3UWX2ditQM0Q4BVYwjIZkLl4EJYITDgxSPsBSc87XL9NG9
         q5GcJs2aVvHmUZS/aYURTHH3IDuxNSe1aE87xBc2J1Sg5QbTmkoX3g1y2gNWvrHWNc
         2W0tTv8HBP2OKbn/kZCAoUk/9VEJt/C1qg0hdsHra1mV1W+1XhgUxv+Q9C8njViFZc
         58US7bHuzw1cw==
Received: by mail-oi1-f182.google.com with SMTP id w65so16058194oie.7;
        Tue, 09 Mar 2021 10:47:37 -0800 (PST)
X-Gm-Message-State: AOAM530FPf33Wpa7I6t5GUpXRqcHWCEKsGOqDwT7BNH/Obb8WhZOyfhN
        +9yz09V8/OppwNoRZ/2V+hFe3KbwEqhoUEM0zrI=
X-Google-Smtp-Source: ABdhPJyip5I6fdAzo99YAoAxZ1dTa4R18w6uJecoBQybDwAUcwhTG3sg9NcyVBwtaD6nrv541UbhkTTZXGRd2LxUtMI=
X-Received: by 2002:a05:6808:10ca:: with SMTP id s10mr4021041ois.33.1615315657244;
 Tue, 09 Mar 2021 10:47:37 -0800 (PST)
MIME-Version: 1.0
References: <20210306113519.294287-1-ardb@kernel.org> <20210307110228.GP17424@dragon>
 <CAMj1kXFiqXwCqJE9Wxu-tc3HYSh1qCqPLL_Csc=gW6SOYrweWw@mail.gmail.com>
 <20210309032248.GR17424@dragon> <CAF6AEGu6ZpfFK5FnQjtE33kkYL_t63J=yJLeK70_46FaLPq7eQ@mail.gmail.com>
In-Reply-To: <CAF6AEGu6ZpfFK5FnQjtE33kkYL_t63J=yJLeK70_46FaLPq7eQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 9 Mar 2021 19:47:25 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGwhx9Z-JCw2NvWBYtHbzVb=EmJn_Jfd97wGzDYNQG2Lw@mail.gmail.com>
Message-ID: <CAMj1kXGwhx9Z-JCw2NvWBYtHbzVb=EmJn_Jfd97wGzDYNQG2Lw@mail.gmail.com>
Subject: Re: [PATCH] efi: stub: override RT_PROP table supported mask based on
 EFI variable
To:     Rob Clark <robdclark@gmail.com>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leif Lindholm <leif@nuviainc.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 9 Mar 2021 at 19:10, Rob Clark <robdclark@gmail.com> wrote:
>
> On Mon, Mar 8, 2021 at 7:22 PM Shawn Guo <shawn.guo@linaro.org> wrote:
> >
> > On Mon, Mar 08, 2021 at 02:34:48PM +0100, Ard Biesheuvel wrote:
> > > On Sun, 7 Mar 2021 at 12:02, Shawn Guo <shawn.guo@linaro.org> wrote:
> > > >
> > > > On Sat, Mar 06, 2021 at 12:35:19PM +0100, Ard Biesheuvel wrote:
> > > > > Allow EFI systems to override the set of supported runtime services
> > > > > declared via the RT_PROP table, by checking for the existence of a
> > > > > 'OverrideSupported' EFI variable of the appropriate size under the
> > > > > RT_PROP table GUID, and if it does, combine the supported mask using
> > > > > logical AND. (This means the override can only remove support, not
> > > > > add it back).
> > > > >
> > > > > Cc: Jeffrey Hugo <jhugo@codeaurora.org>,
> > > > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > > Cc: Shawn Guo <shawn.guo@linaro.org>
> > > > > Cc: Rob Clark <robdclark@gmail.com>
> > > > > Cc: Leif Lindholm <leif@nuviainc.com>
> > > > > Cc: linux-arm-msm@vger.kernel.org
> > > > >
> > > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > >
> > > > Awesome, Ard!  On both Lenovo Yoga C630 and Flex 5G latops:
> > > >
> > > > Tested-by: Shawn Guo <shawn.guo@linaro.org>
> > > >
> > > > With 'OverrideSupported' EFI variable added from UEFI Shell, we can drop
> > > > 'efi=novamap' kernel cmdline and get around the broken poweroff runtime
> > > > services nicely.  Thanks!
> > > >
> > >
> > > Thanks for confirming.
> > >
> > > However, I am not going to merge this without some justification, and
> > > hopefully some input from other folks (Leif?)
> > >
> > > RTPROP already provides what we need on all platforms that use
> > > DtbLoader, and the patch for that is queued up for v5.12-rcX, with a
> > > cc:stable to v5.10. This allows any RT service to be marked as
> > > disabled, including SetVirtualAddressMap().
> > >
> > > So afaict, that means that this patch would be a special case for
> > > Flex5G, right?
> >
> > It's for all Snapdragon based laptops, as we need to disable
> > SetVirtualAddressMap runtime services on all of them.
> >
> > > So how are platforms such as this one going to load the
> > > DTB? If some loader will be involved (or even just GRUB),
> >
> > Yes, GRUB.
> >
> > > shouldn't it
> > > be that component that sets RTPROP like DtbLoader will, not the kernel
> > > itself.
> > >
> > > Btw I don't think ACPI boot is a use case here. I don't see a software
> > > framebuffer with no wifi support as a usage mode that justifies
> > > carrying EFI stub hacks for everyone.
> >
> > Okay.  I'm fine to carry it as an out-of-tree patch until someday you
> > consider ACPI boot is useful for everyone.  But I do boot these laptops
> > with ACPI at daily basis right now as arm64 native build machine, with
> > USB Ethernet adapter.
>
> fwiw, the valid use-case for ACPI boot on these things is for distro
> installer.. it might not be the shiny accelerated experience, but you
> want to be able to get thru the installer and then install updates to
> get latest kernel/dtb/etc
>
> it is a small use-case, but kinda an important step ;-)
>

That is a fair point. However, as I understand it, we need this to work around
- the need to pass efi=novamap
- broken poweroff on Flex5g

So an installer either needs to set the EFI variable, or pass
efi=novamap on the first boot. Note that there are no arm64 EFI
systems known where efi=novamap causes problems. In fact, I would
prefer to stop using SetVirtualAddressMap() altogether, as it does not
provide any benefit whatsoever. So perhaps we should make efi=novamap
the default and be done with it.

Broken poweroff is hardly a showstopper for an installer, given that
we cannot even install GRUB correctly.

In summary, I am more than happy to collaborate constructively on this
(which is why I wrote the patch), but I don't think we're at a point
yet where this is the only thing standing in our way when it comes to
a smooth out-of-the-box Linux installation experience.
