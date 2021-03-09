Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE927332158
	for <lists+linux-efi@lfdr.de>; Tue,  9 Mar 2021 09:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCIIv7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Mar 2021 03:51:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:44138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhCIIv6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 9 Mar 2021 03:51:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9438964F7B;
        Tue,  9 Mar 2021 08:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615279917;
        bh=ZYYnr3Cmr7TOrxLpDIHWTJIA79pc9tjrobHFUSEsnZY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W8apGc3Df08EZ07jmLqRvlVG4IvU80LAlUTldjanvReTP+Wf49omtDoZw4oGa4S9P
         cIMpQUVw7DdGhXw2YAs99BXLul9Bi2R5RxNCdcM/b/we8d8f0reTL3gUX/PZFB9/q1
         vm5vBb7cqSzw8b0fX63FGFIjpOTaz3uGF2LKLR6LZsW4h6gdzrkwIhtfJ39eqERBqU
         u9uxszm2UdfkasBUjEsTDrxYpQb4YpqOP9fM9RYmkcc0t2UcZdvScvuZ/056DdlSlW
         mgh5WCiMfZoyd8C1F4hUTUIDrCfN2z7PAdPCflEWbGJS1ReQ666wqZrJVtJKmVXaHl
         CbrcQnEWBFb1g==
Received: by mail-ot1-f53.google.com with SMTP id b8so12097377oti.7;
        Tue, 09 Mar 2021 00:51:57 -0800 (PST)
X-Gm-Message-State: AOAM530lT0h6oqSc3RP7bxFwV+eDqt1ZcCuijdTD4obmcFqr9UxuAtO1
        D1S0mm87p+QJWY07pWWQPxu0dnKB+WF9kE4BeXY=
X-Google-Smtp-Source: ABdhPJzwZJmhOvgT7DkPaIt4rQ2ClU7KgTkZiH0U7c7E7O3oOs/kGC6Gsh5TmNxKDeN0O7uk5nrbvzLS2sKzNjB9mtU=
X-Received: by 2002:a9d:503:: with SMTP id 3mr13660036otw.77.1615279916897;
 Tue, 09 Mar 2021 00:51:56 -0800 (PST)
MIME-Version: 1.0
References: <20210306113519.294287-1-ardb@kernel.org> <20210307110228.GP17424@dragon>
 <CAMj1kXFiqXwCqJE9Wxu-tc3HYSh1qCqPLL_Csc=gW6SOYrweWw@mail.gmail.com> <20210309032248.GR17424@dragon>
In-Reply-To: <20210309032248.GR17424@dragon>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 9 Mar 2021 09:51:45 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHetQqzUa97oaMS2XxgrOR4W_Z1i47fSjL-p0XA_3rJQw@mail.gmail.com>
Message-ID: <CAMj1kXHetQqzUa97oaMS2XxgrOR4W_Z1i47fSjL-p0XA_3rJQw@mail.gmail.com>
Subject: Re: [PATCH] efi: stub: override RT_PROP table supported mask based on
 EFI variable
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Leif Lindholm <leif@nuviainc.com>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 9 Mar 2021 at 04:22, Shawn Guo <shawn.guo@linaro.org> wrote:
>
> On Mon, Mar 08, 2021 at 02:34:48PM +0100, Ard Biesheuvel wrote:
> > On Sun, 7 Mar 2021 at 12:02, Shawn Guo <shawn.guo@linaro.org> wrote:
> > >
> > > On Sat, Mar 06, 2021 at 12:35:19PM +0100, Ard Biesheuvel wrote:
> > > > Allow EFI systems to override the set of supported runtime services
> > > > declared via the RT_PROP table, by checking for the existence of a
> > > > 'OverrideSupported' EFI variable of the appropriate size under the
> > > > RT_PROP table GUID, and if it does, combine the supported mask using
> > > > logical AND. (This means the override can only remove support, not
> > > > add it back).
> > > >
> > > > Cc: Jeffrey Hugo <jhugo@codeaurora.org>,
> > > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > Cc: Shawn Guo <shawn.guo@linaro.org>
> > > > Cc: Rob Clark <robdclark@gmail.com>
> > > > Cc: Leif Lindholm <leif@nuviainc.com>
> > > > Cc: linux-arm-msm@vger.kernel.org
> > > >
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Awesome, Ard!  On both Lenovo Yoga C630 and Flex 5G latops:
> > >
> > > Tested-by: Shawn Guo <shawn.guo@linaro.org>
> > >
> > > With 'OverrideSupported' EFI variable added from UEFI Shell, we can drop
> > > 'efi=novamap' kernel cmdline and get around the broken poweroff runtime
> > > services nicely.  Thanks!
> > >
> >
> > Thanks for confirming.
> >
> > However, I am not going to merge this without some justification, and
> > hopefully some input from other folks (Leif?)
> >
> > RTPROP already provides what we need on all platforms that use
> > DtbLoader, and the patch for that is queued up for v5.12-rcX, with a
> > cc:stable to v5.10. This allows any RT service to be marked as
> > disabled, including SetVirtualAddressMap().
> >
> > So afaict, that means that this patch would be a special case for
> > Flex5G, right?
>
> It's for all Snapdragon based laptops, as we need to disable
> SetVirtualAddressMap runtime services on all of them.
>
> > So how are platforms such as this one going to load the
> > DTB? If some loader will be involved (or even just GRUB),
>
> Yes, GRUB.
>
> > shouldn't it
> > be that component that sets RTPROP like DtbLoader will, not the kernel
> > itself.
> >
> > Btw I don't think ACPI boot is a use case here. I don't see a software
> > framebuffer with no wifi support as a usage mode that justifies
> > carrying EFI stub hacks for everyone.
>
> Okay.  I'm fine to carry it as an out-of-tree patch until someday you
> consider ACPI boot is useful for everyone.  But I do boot these laptops
> with ACPI at daily basis right now as arm64 native build machine, with
> USB Ethernet adapter.
>

There may be several reasons why this patch might become worthwhile
for upstream, but until that moment, I'd rather not merge it, as it
will affect all users, including ones that boot with EFI secure boot
enabled. (I haven't quite convinced myself that disabling runtime
services arbitrarily using a EFI variable is not something that can be
abused)
