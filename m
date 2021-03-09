Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48713330BA
	for <lists+linux-efi@lfdr.de>; Tue,  9 Mar 2021 22:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhCIVQW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Mar 2021 16:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbhCIVQO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 9 Mar 2021 16:16:14 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE2FC06174A;
        Tue,  9 Mar 2021 13:16:14 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v15so18623738wrx.4;
        Tue, 09 Mar 2021 13:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7lQjUAuZrBubvY73c7vHN9cBJdm4pKkA1MVN2AKU/c4=;
        b=PeWH6MgI5dt1Wjua3ckKta6G/BQEtJ+7XweOAFy6C2ytpCVjIhRTs/Tz2ipwSde4jJ
         LnKG6S2Url+XraMAaT3a608l6JvEtid2v91Y4iEHbD4HkVWV/obcJH8jQq3bLfuIUolL
         ybWUUQDpq9dj0Bfp4810QUgTuBUqSQBb2zXi4rGbY+hu4hC9sy3bbW3g8jFN+Loh1P9C
         vYV85gsI0/hsbyQLcBS5+FYO6/3YkLQLSbM/fNCnymmzB5/aSwi8HWxSwD8NPfIHBP+M
         3iQYSwTcgGq4wG67YiMb7UiV6bz5F/pdpzm42/y0wSu9/hmsVtYIIwFbyEEOGP/6TWYq
         aDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7lQjUAuZrBubvY73c7vHN9cBJdm4pKkA1MVN2AKU/c4=;
        b=ist9evG0pFVwcNna435j5OeTVxwHpfhyFN5kgLyB2bEaP431NzGw4Z/FPenduIxVvw
         S21vhVtDRQ71tBztI2lUAWV7vXjsnlmSflX8XPp4EUNwOrKL3hEZUQtb7Jg5gmf1Vba/
         PRAPIVh0f8uFvc4JBPYULrT80H7py5PUMtDjHj1buJctnvPQ9eZqi0+HVgSQkP38E9UQ
         vk4ajUFIxV19irPA78LqRjMPhnwNdwyfasgOfhqdiqAfMa+40f9u3vafTD1V6/vEJmHA
         ej6Xtbtf4B34Qqp73OvE10AV9cXOjjyqFZg1ryDZz0H2bIzVAi/JzXkZwDuGxmjwrRnN
         CIRA==
X-Gm-Message-State: AOAM533Xv6cvo7sErqtkTTuU6CcqvBHpTNOBLEX6R5kjVCGFvn/MYo6t
        zFp84QA1A9zNZo/EiaYqEKPqWaxBiJxhKzXoM4Z/W3kU2II=
X-Google-Smtp-Source: ABdhPJwEeJvrulxRpS9Lj9xsUhlNElSBzee6JYuQMFp6z/lclGE93Jf2ZHUTtLNRh7VniOfS7DLP+AEGUic2do6RUto=
X-Received: by 2002:a5d:4e52:: with SMTP id r18mr32055260wrt.28.1615324572875;
 Tue, 09 Mar 2021 13:16:12 -0800 (PST)
MIME-Version: 1.0
References: <20210306113519.294287-1-ardb@kernel.org> <20210307110228.GP17424@dragon>
 <CAMj1kXFiqXwCqJE9Wxu-tc3HYSh1qCqPLL_Csc=gW6SOYrweWw@mail.gmail.com>
 <20210309032248.GR17424@dragon> <CAF6AEGu6ZpfFK5FnQjtE33kkYL_t63J=yJLeK70_46FaLPq7eQ@mail.gmail.com>
 <CAMj1kXGwhx9Z-JCw2NvWBYtHbzVb=EmJn_Jfd97wGzDYNQG2Lw@mail.gmail.com>
In-Reply-To: <CAMj1kXGwhx9Z-JCw2NvWBYtHbzVb=EmJn_Jfd97wGzDYNQG2Lw@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 9 Mar 2021 13:19:20 -0800
Message-ID: <CAF6AEGur_68YTQ4Op8i3kRsNmv=BVHCk8brOvDNq-zAUcw1zoQ@mail.gmail.com>
Subject: Re: [PATCH] efi: stub: override RT_PROP table supported mask based on
 EFI variable
To:     Ard Biesheuvel <ardb@kernel.org>
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

On Tue, Mar 9, 2021 at 10:47 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 9 Mar 2021 at 19:10, Rob Clark <robdclark@gmail.com> wrote:
> >
> > On Mon, Mar 8, 2021 at 7:22 PM Shawn Guo <shawn.guo@linaro.org> wrote:
> > >
> > > On Mon, Mar 08, 2021 at 02:34:48PM +0100, Ard Biesheuvel wrote:
> > > > On Sun, 7 Mar 2021 at 12:02, Shawn Guo <shawn.guo@linaro.org> wrote:
> > > > >
> > > > > On Sat, Mar 06, 2021 at 12:35:19PM +0100, Ard Biesheuvel wrote:
> > > > > > Allow EFI systems to override the set of supported runtime services
> > > > > > declared via the RT_PROP table, by checking for the existence of a
> > > > > > 'OverrideSupported' EFI variable of the appropriate size under the
> > > > > > RT_PROP table GUID, and if it does, combine the supported mask using
> > > > > > logical AND. (This means the override can only remove support, not
> > > > > > add it back).
> > > > > >
> > > > > > Cc: Jeffrey Hugo <jhugo@codeaurora.org>,
> > > > > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > > > Cc: Shawn Guo <shawn.guo@linaro.org>
> > > > > > Cc: Rob Clark <robdclark@gmail.com>
> > > > > > Cc: Leif Lindholm <leif@nuviainc.com>
> > > > > > Cc: linux-arm-msm@vger.kernel.org
> > > > > >
> > > > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > >
> > > > > Awesome, Ard!  On both Lenovo Yoga C630 and Flex 5G latops:
> > > > >
> > > > > Tested-by: Shawn Guo <shawn.guo@linaro.org>
> > > > >
> > > > > With 'OverrideSupported' EFI variable added from UEFI Shell, we can drop
> > > > > 'efi=novamap' kernel cmdline and get around the broken poweroff runtime
> > > > > services nicely.  Thanks!
> > > > >
> > > >
> > > > Thanks for confirming.
> > > >
> > > > However, I am not going to merge this without some justification, and
> > > > hopefully some input from other folks (Leif?)
> > > >
> > > > RTPROP already provides what we need on all platforms that use
> > > > DtbLoader, and the patch for that is queued up for v5.12-rcX, with a
> > > > cc:stable to v5.10. This allows any RT service to be marked as
> > > > disabled, including SetVirtualAddressMap().
> > > >
> > > > So afaict, that means that this patch would be a special case for
> > > > Flex5G, right?
> > >
> > > It's for all Snapdragon based laptops, as we need to disable
> > > SetVirtualAddressMap runtime services on all of them.
> > >
> > > > So how are platforms such as this one going to load the
> > > > DTB? If some loader will be involved (or even just GRUB),
> > >
> > > Yes, GRUB.
> > >
> > > > shouldn't it
> > > > be that component that sets RTPROP like DtbLoader will, not the kernel
> > > > itself.
> > > >
> > > > Btw I don't think ACPI boot is a use case here. I don't see a software
> > > > framebuffer with no wifi support as a usage mode that justifies
> > > > carrying EFI stub hacks for everyone.
> > >
> > > Okay.  I'm fine to carry it as an out-of-tree patch until someday you
> > > consider ACPI boot is useful for everyone.  But I do boot these laptops
> > > with ACPI at daily basis right now as arm64 native build machine, with
> > > USB Ethernet adapter.
> >
> > fwiw, the valid use-case for ACPI boot on these things is for distro
> > installer.. it might not be the shiny accelerated experience, but you
> > want to be able to get thru the installer and then install updates to
> > get latest kernel/dtb/etc
> >
> > it is a small use-case, but kinda an important step ;-)
> >
>
> That is a fair point. However, as I understand it, we need this to work around
> - the need to pass efi=novamap
> - broken poweroff on Flex5g
>
> So an installer either needs to set the EFI variable, or pass
> efi=novamap on the first boot. Note that there are no arm64 EFI
> systems known where efi=novamap causes problems. In fact, I would
> prefer to stop using SetVirtualAddressMap() altogether, as it does not
> provide any benefit whatsoever. So perhaps we should make efi=novamap
> the default and be done with it.
>
> Broken poweroff is hardly a showstopper for an installer, given that
> we cannot even install GRUB correctly.
>
> In summary, I am more than happy to collaborate constructively on this
> (which is why I wrote the patch), but I don't think we're at a point
> yet where this is the only thing standing in our way when it comes to
> a smooth out-of-the-box Linux installation experience.

Fair, it was less of an argument for/against the patch, and more just
reminding folks that there is an ACPI boot use case ;-)

BR,
-R
