Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC1F33A9CE
	for <lists+linux-efi@lfdr.de>; Mon, 15 Mar 2021 04:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhCODLo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 14 Mar 2021 23:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhCODL0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 14 Mar 2021 23:11:26 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D255C06175F
        for <linux-efi@vger.kernel.org>; Sun, 14 Mar 2021 20:11:26 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id g4so19636833pgj.0
        for <linux-efi@vger.kernel.org>; Sun, 14 Mar 2021 20:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Bt99tj/N3eDjWBiir4ht9YpU27QxmIKuYPd5FFn+AU=;
        b=WzpLpc5dVQUIFRnmTTbiK324+TNUk68pdDqAP1k2L1CX4JE7S0QCYnSgNZ58YuiOp+
         Z4+ZkfzaYqeJZf3H0XvOIw0ELChRugpel0DZVuORypfPnMH4+rqgTGSqOqoX39QU7EHp
         bEy3v48Ch4sIAZ+3t/c8iYvg/BSbCVXU8jhnhcCgYGS/WaCGlV5qSOMHbZdzoygS7ObD
         nzBde7yQQk4X1FGkhnop+RmZA9GIVHDmgTQwMtMyEg2fnRMg+1CB7B1h1OGSe0ibo5pQ
         dPdUKQ+HHyCurS+LGfIWW1mesOCNSZttdhdt1s8n8G+p4uh7sLdBEsjZp6DqPAkCqROW
         sN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Bt99tj/N3eDjWBiir4ht9YpU27QxmIKuYPd5FFn+AU=;
        b=CV52M0AvVVLiimCp20Js9CZtkBqIF1jP4CSYU6ddhfBbHoRoGWLgBytPFtStK7bC9N
         xL6NnSTL64UD0jsUpEbh7zNQKjG34+9GFpamQH9dkSFnQEFa9i5fDIt29gJy4qeiOech
         DKLuqFbO6bctrRr0a+UUWLpQ8fdH95XEvJwaAMiDld0F4P2pZhOsRNxfQ603lOP0raTz
         THqv2Xjy8bzwqwkxtCGZBrJKDBp5MmP8+jOs31GaFAf/aRsFM1mFDg8UBBqP7AW5HdS/
         VxAlfipzu8LNa2BZWulrmt23E+5/vJBof9a+I4LTt/Jo6efpOGh4D1mfaF4SCLbJVB4w
         9QRw==
X-Gm-Message-State: AOAM530umOb4baKRmthsfA+zWdiu4hXr/raocamXSAH6R3WStmXKJ1Gh
        gHfncUacKye1c/YNG2bKkPQq4g==
X-Google-Smtp-Source: ABdhPJx5WIgYFkRCN97yHAyDkpMvugKGPrl8et8ihthtKspSKYBOeah55d9KchYqCDT9bNh5rKdJXg==
X-Received: by 2002:aa7:991a:0:b029:201:b736:c556 with SMTP id z26-20020aa7991a0000b0290201b736c556mr8397757pff.8.1615777885718;
        Sun, 14 Mar 2021 20:11:25 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id g26sm11568634pge.67.2021.03.14.20.11.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Mar 2021 20:11:25 -0700 (PDT)
Date:   Mon, 15 Mar 2021 11:11:19 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leif Lindholm <leif@nuviainc.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] efi: stub: override RT_PROP table supported mask based
 on EFI variable
Message-ID: <20210315031119.GY17424@dragon>
References: <20210306113519.294287-1-ardb@kernel.org>
 <20210307110228.GP17424@dragon>
 <CAMj1kXFiqXwCqJE9Wxu-tc3HYSh1qCqPLL_Csc=gW6SOYrweWw@mail.gmail.com>
 <20210309032248.GR17424@dragon>
 <CAF6AEGu6ZpfFK5FnQjtE33kkYL_t63J=yJLeK70_46FaLPq7eQ@mail.gmail.com>
 <CAMj1kXGwhx9Z-JCw2NvWBYtHbzVb=EmJn_Jfd97wGzDYNQG2Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGwhx9Z-JCw2NvWBYtHbzVb=EmJn_Jfd97wGzDYNQG2Lw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Mar 09, 2021 at 07:47:25PM +0100, Ard Biesheuvel wrote:
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

One more: broken EFI variable runtime services on all Snapdragon laptops

It's been another pain of running debian-installer (d-i) on these
laptops, where EFI NV variables are just stored on UFS disk.  So after
Linux takes over the control of UFS, EFI NV variable runtime services
then become out of service.  Currently, we have to apply a hack [1] on
d-i grub-installer to get around the issue,  and it's been the only
remaining out-of-tree patch we have to carry for d-i.  With this nice
`OverrideSupported` support, we will be able to drop that hack
completely.

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

There might be more to be done for getting a smooth Linux installation
experience.  But IMHO, this `OverrideSupported` thing is definitely
a big step to that.

Shawn

[1] https://salsa.debian.org/installer-team/grub-installer/-/merge_requests/5
