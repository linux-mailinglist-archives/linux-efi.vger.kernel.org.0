Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 200D9155F04
	for <lists+linux-efi@lfdr.de>; Fri,  7 Feb 2020 21:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgBGUEN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Feb 2020 15:04:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35585 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgBGUEN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Feb 2020 15:04:13 -0500
Received: by mail-wr1-f66.google.com with SMTP id w12so374782wrt.2
        for <linux-efi@vger.kernel.org>; Fri, 07 Feb 2020 12:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/cjJttADTR7x5y7X61oHSqiTQWNdM2U/1/pLmsbVFWU=;
        b=a3PmSRlKqq4EAlnePg2rU+Axgzwomz+8WnRMjfMiIUW/y17gkQfunczIzbphyL49Wa
         5Wf5Lw4PFfhqHI/rlQdk9Bbf/jccwc/RhqxO9K4iLWjYbKzqzLmxD4GRE5QuXvJb/q/A
         t3rrtrxVIjNLiWkE47/FTr0NydZ7y68Jtz3m6jcoEzd0XLE1GeazCnjLaOG3O9QT0IAM
         bnnV8Wl0KBnwF+S4IpBgX4hLHthHfrKwe8/4WIh9wW9SFrSCvsJH3L2HoYks4+BX8FU6
         MUGdKqFR6R0CTlN55qqIMObX/Vt2fQ1Cr8v3l+Ywh1JF2VjGA79F7XCslSCTW82WtHpa
         YiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/cjJttADTR7x5y7X61oHSqiTQWNdM2U/1/pLmsbVFWU=;
        b=p72usqpa6nw7rhcVM7P3UKgS0tJ/xtzBB11HtBu2Q3T+s3xHyka0M00vN0HXuoItwW
         cZKvHvg6aYZfBOwssg+vjuuuWyyBXNKnMBtgYNRqxZK6fd0xaMGdYybtm1nVTjNpAHUH
         XjdtZ7Ui69yxHIPUATJZjui5me9t9vR/51+rpx8Tqnug8jkcCR880m/LCUpsVn54yI4K
         +a9RolTvv/qgoa5BIzMv1YGg3wfTcvOXXaAMdrjgmLWmu2uzJyq2WyYbj9PORv3FTX8K
         Kie70fvHft5t+ghCgKmgP0+l+A48ZmK4a4KM0hKcSXLsSWhaRDDfBAQw7uJ2NYQ/vIOi
         MHMg==
X-Gm-Message-State: APjAAAU5EJwpxQX9UQ4FwScmtUXqnISN3aH8eQW0G/XZ5WPxZd8+JxdW
        8MjNY7G/qBzRk4bHSnBuhSWBA+MixllNLPBMdUtliQ==
X-Google-Smtp-Source: APXvYqyg6dkIv/QUnbUXe3idvlG17jt8sE48s/mLAN3GYbGD9MMYafQMqdY++pqS+LvnoZ12K6+DF2lEhSZdTMHOod4=
X-Received: by 2002:adf:fd8d:: with SMTP id d13mr706184wrr.208.1581105850562;
 Fri, 07 Feb 2020 12:04:10 -0800 (PST)
MIME-Version: 1.0
References: <20200206140352.6300-1-ardb@kernel.org> <fa3b3103-e77d-571d-71a4-604fa48368e6@redhat.com>
 <cfb38b38-14f2-c61a-60a0-dfe14667b49c@redhat.com> <CAKv+Gu__fUGyv4eu5oKcsVZYSbKRfYYd_VS8CGEV4jC+GuvqJA@mail.gmail.com>
 <1581092420.7608.15.camel@HansenPartnership.com> <CAKv+Gu99wxr+OHwqPRjfF136VB3AwPbXXg1tx1=34jF2DU6Z6g@mail.gmail.com>
 <1581105265.4545.17.camel@HansenPartnership.com>
In-Reply-To: <1581105265.4545.17.camel@HansenPartnership.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 7 Feb 2020 20:03:59 +0000
Message-ID: <CAKv+Gu9fO1aB2wmVjLyGPJ0LjbZeBTtCW_pdmR2cAyHgTR4++w@mail.gmail.com>
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

On Fri, 7 Feb 2020 at 19:54, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Fri, 2020-02-07 at 18:31 +0000, Ard Biesheuvel wrote:
> > On Fri, 7 Feb 2020 at 16:20, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > On Fri, 2020-02-07 at 12:23 +0000, Ard Biesheuvel wrote:
> > > > On Fri, 7 Feb 2020 at 09:22, Laszlo Ersek <lersek@redhat.com>
> > > > wrote:
> > > > >
> > > > > On 02/07/20 10:09, Laszlo Ersek wrote:
> > >
> > > [...]
> > > > > > For example, virt-install's "--location" option "can
> > > > > > recognize certain distribution trees and fetches a bootable
> > > > > > kernel/initrd pair to launch the install". It would be nice
> > > > > > to keep that working for older distros.
> > > > > >
> > > > > > I think LoadFile[2] can co-exist with SimpleFs.
> > > > > >
> > > > > > I also think that the "try SimpleFs first, fall back to
> > > > > > LoadFile[2] second" requirement applies only to the UEFI boot
> > > > > > manager, and not to the kernel's EFI stub. IOW in the new
> > > > > > approach the kernel is free to ignore (abandon) the old
> > > > > > approach for good.
> > > > >
> > > > > ... But that might not be good for compatibility with grub
> > > > > and/or the platform firmware, from the kernel's own
> > > > > perspective, perhaps?...
> > > > >
> > > > > Who is supposed to produce LoadFile2 with the new VenMedia
> > > > > devpath?
> > > > >
> > > >
> > > > What I am ultimately after is a generic GRUB that uses
> > > > LoadImage+Startimage for starting the kernel on all
> > > > architectures,
> > >
> > > For most boots, we need to pivot to the MoK.  A long time ago, I
> > > proposed updating the platform security policy to do an override to
> > > allow MoK to become the security verifier (actually principally so
> > > I could get the gummiboot bootloader to work with the MoK method):
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/jejb/efitools.git/t
> > > ree/lib/security_policy.c
> > >
> > > And I believe all the pivot bootloaders now do this, but the fear
> > > was always this looks a bit like hackery that might not work in
> > > some UEFI implementations.  Since we don't really rely on it (shim
> > > link loads after signature verification) we don't know whether the
> > > assumption does break or not.  We'll need to get much more
> > > comfortable with the security override before we can let grub do a
> > > simple load+start.
> > >
> >
> > I'd like to do something much simpler: let shim override LoadImage
> > and StartImage,
>
> Actually, the non-shim bootloaders really don't want to do that: the
> whole point of being able to use LoadImage is that you don't need to
> know how to load a PECOFF binary or check its signature.  Overriding
> the security protocol allows updating the signature check, but if you
> look at the current efitools implementation it uses the pkcs7 protocol
> to avoid having to include crypto code.
>
> I've got the pecoff code they'd need in my uefi library:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jejb/efitools.git/tree/lib/pecoff.c
>
> But it's a lot of code for things that pride themselves on being tiny.
>

I think you are missing the point. GRUB will only use
loadimage+startimage, no matter what is backing it (the firmware or
shim). The same applies to gummiboot or even the uefi shell if you
wanted to. So all loaders use LoadImage/StartImage as usual, but shim
inserts itself into the call chain if it was loaded first.


> >  and in their implementations, fall back to the firmware
> > ones if necessary.
> >
> > > > and is able to load the initrd from anywhere in an arch agnostic
> > > > manner.
> > >
> > > I think the use case might not really be grub, it's gummiboot, or
> > > systemd-boot as its now called:
> > >
> >
> > No it is definitely GRUB. GRUB today needs to attach to the shim
> > protocol, perform the authentication, measure the payload etc etc,
> > which means it knows far too much about the internals of shim or the
> > fact that it even exists.
>
> The shim protocol and shim are fairly separate.  I agree it means grub
> has to load and know the two entry points for context and verify but
> they're very far removed for the inner workings of shim.  Obviously, my
> non-shim loader has to supply them for grub, so this is the
> implementation:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jejb/efitools.git/tree/lib/shim_protocol.c
>
> It's only 50 lines.
>
> The other thing to consider is that crypto code is huge.  Shim
> currently includes it (although it could avoid this by using the pkcs7
> verifier protocol trick I use ... I should push that harder) and it
> adds about 1M of static code.  Grub does not have this code, so either
> grub uses shim and its code to do the signature verification or grub
> will have to include the additional 1M as well ... I think using shim
> via the protocol is preferable.
>

No. GRUB will call loadimage+startimage, and will end up hitting the
implementation exposed by shim.

> > My ideal bootflow would be where the OS installer looks at the
> > firmware's db/dbx, doesn't bother to install shim if the OS vendor's
> > cert is there, and uses the exact same GRUB regardless of whether
> > shim is part of the bootflow or not.
>
> That's not enough.  The whole point of MoK is that the user may have
> done their own key addition, so you could be in the situation where the
> vendor cert is present in db but the user has a MoK override for boot
> and if you assume presence of the vendor cert means you can use
> loadimage, this will fail because the MoK cert isn't in db ... unless
> you've added the MoK key via the security protocol override.
>

No. The LoadImage you are hitting is shim's loadimage not the
firmware's loadimage in this case.

> > One of the things impeding this is the fact that we cannot load the
> > initrd from anywhere when using loadimage+startimage.
>
> unless initrd becomes a PECOFF binary, it can never be loaded by
> loadimage ... I thought you were still letting the kernel load it via
> LoadFile2?  (assuming you are and that the above is just a typo).
>

No it is not a typo.

If you load the kernel vis LoadImage, you need to use initrd= to load
the initrd, which required that file to be hosted on a file system
that EFI understands. The alternative is to load the initrd into
memory, store the address and size into a bootparams structure or DT,
and invoke the kernel via some other entry point that allows you to
carry this metadata.

I want to get rid of the latter, which means I need a way to load the
initrd that is not limited to loading from the same [EFI supported]
file system as the kernel. *That* is what this series is about.
