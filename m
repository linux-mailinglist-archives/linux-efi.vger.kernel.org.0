Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7235155BA3
	for <lists+linux-efi@lfdr.de>; Fri,  7 Feb 2020 17:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgBGQUX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Feb 2020 11:20:23 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:56502 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726897AbgBGQUX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Feb 2020 11:20:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 804A18EE165;
        Fri,  7 Feb 2020 08:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581092422;
        bh=uvd4rwLEaY2+E2FC+J/+GniOjYoGdBNbZoO4ku6gsSE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=xexRZIhrm9xHJGV2dhfty1luTqCxUvHKzrbknQNwWlcd7xwv0ozKBYwSeIcTb+T7t
         IW12BhgAjugv7gru51mdm4mH/xh6RWRWESsVBOhlqsSkikxkkmXzyFP+Ur0VIINWHe
         8V4yqglOLiSIRibaNCh63o56brr+5K6i3fKwEFbc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CWzZ8kdisAgm; Fri,  7 Feb 2020 08:20:22 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id AAA758EE0E2;
        Fri,  7 Feb 2020 08:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581092422;
        bh=uvd4rwLEaY2+E2FC+J/+GniOjYoGdBNbZoO4ku6gsSE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=xexRZIhrm9xHJGV2dhfty1luTqCxUvHKzrbknQNwWlcd7xwv0ozKBYwSeIcTb+T7t
         IW12BhgAjugv7gru51mdm4mH/xh6RWRWESsVBOhlqsSkikxkkmXzyFP+Ur0VIINWHe
         8V4yqglOLiSIRibaNCh63o56brr+5K6i3fKwEFbc=
Message-ID: <1581092420.7608.15.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/2] arch-agnostic initrd loading method for EFI systems
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Laszlo Ersek <lersek@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Daniel Kiper <daniel.kiper@oracle.com>
Date:   Fri, 07 Feb 2020 08:20:20 -0800
In-Reply-To: <CAKv+Gu__fUGyv4eu5oKcsVZYSbKRfYYd_VS8CGEV4jC+GuvqJA@mail.gmail.com>
References: <20200206140352.6300-1-ardb@kernel.org>
         <fa3b3103-e77d-571d-71a4-604fa48368e6@redhat.com>
         <cfb38b38-14f2-c61a-60a0-dfe14667b49c@redhat.com>
         <CAKv+Gu__fUGyv4eu5oKcsVZYSbKRfYYd_VS8CGEV4jC+GuvqJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 2020-02-07 at 12:23 +0000, Ard Biesheuvel wrote:
> On Fri, 7 Feb 2020 at 09:22, Laszlo Ersek <lersek@redhat.com> wrote:
> > 
> > On 02/07/20 10:09, Laszlo Ersek wrote:
[...]
> > > For example, virt-install's "--location" option "can recognize
> > > certain distribution trees and fetches a bootable kernel/initrd
> > > pair to launch the install". It would be nice to keep that
> > > working for older distros.
> > > 
> > > I think LoadFile[2] can co-exist with SimpleFs.
> > > 
> > > I also think that the "try SimpleFs first, fall back to
> > > LoadFile[2] second" requirement applies only to the UEFI boot
> > > manager, and not to the kernel's EFI stub. IOW in the new
> > > approach the kernel is free to ignore (abandon) the old approach
> > > for good.
> > 
> > ... But that might not be good for compatibility with grub and/or
> > the platform firmware, from the kernel's own perspective,
> > perhaps?...
> > 
> > Who is supposed to produce LoadFile2 with the new VenMedia devpath?
> > 
> 
> What I am ultimately after is a generic GRUB that uses
> LoadImage+Startimage for starting the kernel on all architectures, 

For most boots, we need to pivot to the MoK.  A long time ago, I
proposed updating the platform security policy to do an override to
allow MoK to become the security verifier (actually principally so I
could get the gummiboot bootloader to work with the MoK method):

https://git.kernel.org/pub/scm/linux/kernel/git/jejb/efitools.git/tree/lib/security_policy.c

And I believe all the pivot bootloaders now do this, but the fear was
always this looks a bit like hackery that might not work in some UEFI
implementations.  Since we don't really rely on it (shim link loads
after signature verification) we don't know whether the assumption does
break or not.  We'll need to get much more comfortable with the
security override before we can let grub do a simple load+start.

> and is able to load the initrd from anywhere in an arch agnostic
> manner.

I think the use case might not really be grub, it's gummiboot, or
systemd-boot as its now called:

https://wiki.archlinux.org/index.php/systemd-boot

The standard way of using grub and EFI is to put grub on the EFI
parition but have the kernel and the initrd on the root parition (which
won't be EFI readable).  This means we can keep the EFI partition small
and only needing modification when grub is updated, meaning it doesn't
even need mounting at all usually.

Don't get me wrong, I like the gummiboot way of doing the
LoadImage+StartImage: it's small and clean and doesn't need the shim
protocol, but people like the sophistication grub provides including
its ability to read kernel filesystems, so they're unlikely to change
that.

James

