Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02A0A155E1B
	for <lists+linux-efi@lfdr.de>; Fri,  7 Feb 2020 19:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgBGSbs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Feb 2020 13:31:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41973 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgBGSbr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Feb 2020 13:31:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so11504wrw.8
        for <linux-efi@vger.kernel.org>; Fri, 07 Feb 2020 10:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0v34gJothHO3j4Q4wlZmrNzO+MkkL5KtAqTgVsXD5t8=;
        b=c/KE7MDXnr27AuNVH5pVqkgRp1vvz6CmI/2tggk/F4MilQvTzr1FU0WH0WOpDRhYD5
         bU7VomlGH5L02fGbPt1PdZygYZWscxoxuOw+yx19ezD5waJBtQs+FIhHVCln4RKo6n48
         S0Yc9Vo9/SYWnrlXCxq4ViVRY1xk+5cbc6MaAJTWdQoROaCIUwvasoS5H2MqJ/rLl1J5
         5PqiGErFUbIMhdQzKGhkQZyfxn0lHQhyTtNsxRSLLW30pAtk7GKoeMwXg2+y1zH3qXpH
         kr4esO0v+kS58mRzC28aAmPGjfR9IUIyrWrvibSwlQjw8ElhZkRWu1qQNWT1OedDkMI8
         qm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0v34gJothHO3j4Q4wlZmrNzO+MkkL5KtAqTgVsXD5t8=;
        b=k/6bnH2CiiAYMCQPQeUxnYn7lJYDxKwXRoz/7zo0VsfFCLO+5IOd2MdeFPR7UMkXWf
         AvXsOOsRsy0LDrnrfgped8qpDOHahx7Q4FYcdLYM1bYf1TVjTfRQd0Ce9Vf32bb3h/4P
         fDi5PpwwQo/opEkwjxuU4/QyVbSJef/jBfD5GOBOp1bydrIy4ENyoMTQnDlXB3n1FsJ1
         gwuaxM2EICikYHjvWt8SQHTXcPu5OVB6re5mZypYcS08EmZZ8ShBI8nT50M4mRR9Hnfd
         SmX/dM6itgxWC1wlrANZGWzrJtJfzKjMHRKScCe+XKDiz2L6x1B+X3nectr9VzslrU/1
         uPAw==
X-Gm-Message-State: APjAAAX1HyTpBh4C6crmLw3NORGLmeAdM7AfCN+0ioPz1mW44ttw1AFz
        6CC8ZDG4+8Tw91ZljW3CHITnkJ0/YmOZmtZkCM5k2Q==
X-Google-Smtp-Source: APXvYqyVbP4+gSnuDzbO/iK3mOF8OGLPaTetRFZdihOAga1O45m+Zg2UTz4gB3UaPq/25V9fIH2KaNb4aSIPlkv/3Xs=
X-Received: by 2002:a5d:42c6:: with SMTP id t6mr313068wrr.151.1581100304442;
 Fri, 07 Feb 2020 10:31:44 -0800 (PST)
MIME-Version: 1.0
References: <20200206140352.6300-1-ardb@kernel.org> <fa3b3103-e77d-571d-71a4-604fa48368e6@redhat.com>
 <cfb38b38-14f2-c61a-60a0-dfe14667b49c@redhat.com> <CAKv+Gu__fUGyv4eu5oKcsVZYSbKRfYYd_VS8CGEV4jC+GuvqJA@mail.gmail.com>
 <1581092420.7608.15.camel@HansenPartnership.com>
In-Reply-To: <1581092420.7608.15.camel@HansenPartnership.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 7 Feb 2020 18:31:33 +0000
Message-ID: <CAKv+Gu99wxr+OHwqPRjfF136VB3AwPbXXg1tx1=34jF2DU6Z6g@mail.gmail.com>
Subject: Re: [PATCH 0/2] arch-agnostic initrd loading method for EFI systems
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Laszlo Ersek <lersek@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Daniel Kiper <daniel.kiper@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 7 Feb 2020 at 16:20, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Fri, 2020-02-07 at 12:23 +0000, Ard Biesheuvel wrote:
> > On Fri, 7 Feb 2020 at 09:22, Laszlo Ersek <lersek@redhat.com> wrote:
> > >
> > > On 02/07/20 10:09, Laszlo Ersek wrote:
> [...]
> > > > For example, virt-install's "--location" option "can recognize
> > > > certain distribution trees and fetches a bootable kernel/initrd
> > > > pair to launch the install". It would be nice to keep that
> > > > working for older distros.
> > > >
> > > > I think LoadFile[2] can co-exist with SimpleFs.
> > > >
> > > > I also think that the "try SimpleFs first, fall back to
> > > > LoadFile[2] second" requirement applies only to the UEFI boot
> > > > manager, and not to the kernel's EFI stub. IOW in the new
> > > > approach the kernel is free to ignore (abandon) the old approach
> > > > for good.
> > >
> > > ... But that might not be good for compatibility with grub and/or
> > > the platform firmware, from the kernel's own perspective,
> > > perhaps?...
> > >
> > > Who is supposed to produce LoadFile2 with the new VenMedia devpath?
> > >
> >
> > What I am ultimately after is a generic GRUB that uses
> > LoadImage+Startimage for starting the kernel on all architectures,
>
> For most boots, we need to pivot to the MoK.  A long time ago, I
> proposed updating the platform security policy to do an override to
> allow MoK to become the security verifier (actually principally so I
> could get the gummiboot bootloader to work with the MoK method):
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jejb/efitools.git/tree/lib/security_policy.c
>
> And I believe all the pivot bootloaders now do this, but the fear was
> always this looks a bit like hackery that might not work in some UEFI
> implementations.  Since we don't really rely on it (shim link loads
> after signature verification) we don't know whether the assumption does
> break or not.  We'll need to get much more comfortable with the
> security override before we can let grub do a simple load+start.
>

I'd like to do something much simpler: let shim override LoadImage and
StartImage, and in their implementations, fall back to the firmware
ones if necessary.

> > and is able to load the initrd from anywhere in an arch agnostic
> > manner.
>
> I think the use case might not really be grub, it's gummiboot, or
> systemd-boot as its now called:
>

No it is definitely GRUB. GRUB today needs to attach to the shim
protocol, perform the authentication, measure the payload etc etc,
which means it knows far too much about the internals of shim or the
fact that it even exists.

My ideal bootflow would be where the OS installer looks at the
firmware's db/dbx, doesn't bother to install shim if the OS vendor's
cert is there, and uses the exact same GRUB regardless of whether shim
is part of the bootflow or not.

One of the things impeding this is the fact that we cannot load the
initrd from anywhere when using loadimage+startimage.

> https://wiki.archlinux.org/index.php/systemd-boot
>
> The standard way of using grub and EFI is to put grub on the EFI
> parition but have the kernel and the initrd on the root parition (which
> won't be EFI readable).  This means we can keep the EFI partition small
> and only needing modification when grub is updated, meaning it doesn't
> even need mounting at all usually.
>
> Don't get me wrong, I like the gummiboot way of doing the
> LoadImage+StartImage: it's small and clean and doesn't need the shim
> protocol, but people like the sophistication grub provides including
> its ability to read kernel filesystems, so they're unlikely to change
> that.
>
