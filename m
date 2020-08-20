Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FB224BDDE
	for <lists+linux-efi@lfdr.de>; Thu, 20 Aug 2020 15:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgHTJgS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Aug 2020 05:36:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728584AbgHTJgN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 20 Aug 2020 05:36:13 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABB9922BEA;
        Thu, 20 Aug 2020 09:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916171;
        bh=GkWr1+rc5Yh7xVse8yY+Hjlc6datZcvkADDYum+4WEc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wJ07HQnvKpZopHGkdobA3KpRgCr1f+IKFlaLeb9zfJ1f1sZPflVzFHoqrIjNUkm50
         tKmefiJlaDXxELfTwS8GWH5fMOlw5dyisDfFhBaxzH0Hk+o8j9NQtC4tJXQ/SWZtL/
         xRDDXZYxukwrpKLFSMikABRHPJvCJH/f5swxldug=
Received: by mail-oi1-f169.google.com with SMTP id h3so1284378oie.11;
        Thu, 20 Aug 2020 02:36:11 -0700 (PDT)
X-Gm-Message-State: AOAM533OydqOKs4ReHCiEC1tPVOMg6f1TKxLKkDLcnGP0gDn9jz43LoV
        tN1DjKQlheO1okgK2v4X6U0PEU5jygTphO2+og4=
X-Google-Smtp-Source: ABdhPJxu0ra0wIlye6km5JoDemKZLgiRAdiKcOOK85ixpPB9RpXW7vfZn/bBagooP9QbE+Mc3+wmYf8gtb7sBCsswbk=
X-Received: by 2002:a05:6808:b37:: with SMTP id t23mr1240704oij.174.1597916170904;
 Thu, 20 Aug 2020 02:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200816001949.595424-1-marmarek@invisiblethingslab.com>
 <20200817090013.GN975@Air-de-Roger> <20200818120135.GK1679@mail-itl>
 <20200818124710.GK828@Air-de-Roger> <20200818150020.GL1679@mail-itl>
 <20200818172114.GO828@Air-de-Roger> <20200818184018.GN1679@mail-itl>
 <20200819081930.GQ828@Air-de-Roger> <3d405b0c-4e2b-0d29-56bb-e315f4c21d03@3mdeb.com>
 <20200820093025.GT828@Air-de-Roger>
In-Reply-To: <20200820093025.GT828@Air-de-Roger>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 20 Aug 2020 11:35:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE9tF+r6zVcoxtmFv4MOtmzTwQ+9bgvyA558eUtNLZo-g@mail.gmail.com>
Message-ID: <CAMj1kXE9tF+r6zVcoxtmFv4MOtmzTwQ+9bgvyA558eUtNLZo-g@mail.gmail.com>
Subject: Re: [PATCH] efi: discover ESRT table on Xen PV too
To:     =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Cc:     Norbert Kaminski <norbert.kaminski@3mdeb.com>,
        =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        xen-devel@lists.xenproject.org,
        open list <linux-kernel@vger.kernel.org>,
        Maciej Pijanowski <maciej.pijanowski@3mdeb.com>,
        piotr.krol@3mdeb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 20 Aug 2020 at 11:30, Roger Pau Monn=C3=A9 <roger.pau@citrix.com> w=
rote:
>
> On Wed, Aug 19, 2020 at 01:33:39PM +0200, Norbert Kaminski wrote:
> >
> > On 19.08.2020 10:19, Roger Pau Monn=C3=A9 wrote:
> > > On Tue, Aug 18, 2020 at 08:40:18PM +0200, Marek Marczykowski-G=C3=B3r=
ecki wrote:
> > > > On Tue, Aug 18, 2020 at 07:21:14PM +0200, Roger Pau Monn=C3=A9 wrot=
e:
> > > > > > Let me draw the picture from the beginning.
> > > > > Thanks, greatly appreciated.
> > > > >
> > > > > > EFI memory map contains various memory regions. Some of them ar=
e marked
> > > > > > as not needed after ExitBootServices() call (done in Xen before
> > > > > > launching dom0). This includes EFI_BOOT_SERVICES_DATA and
> > > > > > EFI_BOOT_SERVICES_CODE.
> > > > > >
> > > > > > EFI SystemTable contains pointers to various ConfigurationTable=
s -
> > > > > > physical addresses (at least in this case). Xen does interpret =
some of
> > > > > > them, but not ESRT. Xen pass the whole (address of) SystemTable=
 to Linux
> > > > > > dom0 (at least in PV case). Xen doesn't do anything about table=
s it
> > > > > > doesn't understand.
> > > > > >
> > > > > > Now, the code in Linux takes the (ESRT) table address early and=
 checks
> > > > > > the memory map for it. We have 3 cases:
> > > > > >   - it points at area marked as neither EFI_*_SERVICES_DATA, no=
r with
> > > > > >     EFI_MEMORY_RUNTIME attribute -> Linux refuse to use it
> > > > > >   - it points to EFI_RUNTIME_SERVICES_DATA or with EFI_MEMORY_R=
UNTIME
> > > > > >     attribute - Linux uses the table; memory map already says t=
he area
> > > > > >     belongs to EFI and the OS should not use it for something e=
lse
> > > > > >   - it points to EFI_BOOT_SERVICES_DATA - Linux mark the area a=
s reserved
> > > > > >     to not release it after calling ExitBootServices()
> > > > > >
> > > > > > The problematic is the third case - at the time when Linux dom0=
 is run,
> > > > > > ExitBootServices() was already called and EFI_BOOT_SERVICES_* m=
emory was
> > > > > > already released. It could be already used for something else (=
for
> > > > > > example Xen could overwrite it while loading dom0).
> > > > > >
> > > > > > Note the problematic case should be the most common - UEFI spec=
ification
> > > > > > says "The ESRT shall be stored in memory of type EfiBootService=
sData"
> > > > > > (chapter 22.3 of UEFI Spec v2.6).
> > > > > >
> > > > > > For this reason, to use ESRT in dom0, Xen should do something a=
bout it
> > > > > > before ExitBootServices() call. While analyzing all the EFI tab=
les is
> > > > > > probably not a viable option, it can do some simple action:
> > > > > >   - retains all the EFI_BOOT_SERVICES_* areas - there is alread=
y code
> > > > > >     for that, controlled with /mapbs boot switch (to xen.efi, w=
ould need
> > > > > >     another option for multiboot2+efi)
> > > > > >   - have a list of tables to retain - since Xen already do anal=
yze some
> > > > > >     of the ConfigurationTables, it can also have a list of thos=
e to
> > > > > >     preserve even if they live in EFI_BOOT_SERVICES_DATA. In th=
is case,
> > > > > >     while Xen doesn't need to parse the whole table, it need to=
 parse it's
> > > > > >     header to get the table size - to reserve that memory and n=
ot reuse
> > > > > >     it after ExitBootServices().
> > > > > Xen seems to already contain skeleton
> > > > > XEN_EFI_query_capsule_capabilities and XEN_EFI_update_capsule
> > > > > hypercalls which is what should be used in order to perform the
> > > > > updates?
> > > > I think those covers only runtime service calls similarly named. Bu=
t you
> > > > need also ESRT table to collect info about devices that you can eve=
n
> > > > attempt to update.
> > > Right, the ESRT must be available so that dom0 can discover the
> > > resources.
> > >
> > > > TBH, I'm not sure if those runtime services are really needed. I th=
ink
> > > > Norbert succeeded UEFI update from within Xen PV dom0 with just acc=
ess
> > > > to the ESRT table, but without those services.
> > > >
> > Marek is right here. I was able to successfully update and downgrade
> > UFEI when the ESRT table was provided to the Xen PV dom0. I didn't
> > need any extra services to make the UEFI capsule update work.
>
> OK, I think that's using the method described in 8.5.5 of delivery of
> Capsules via file on Mass Storage, which doesn't use the
> UpdateCapsule() runtime API?
>

No, it doesn't even do that. It uses its own .efi binary to invoke
UpdateCapsule() after a reboot, by setting up the BootNext variable to
override the boot target for the next boot only.

> Using such method doesn't require QueryCapsuleCapabilities(), as
> that's used to know whether a certain capsule can be updated via
> UpdateCapsule().
>

That is a bit of a downside here. But the reason this approach was
chosen is because that is how Windows applies capsule updates as well,
and given that many x86 vendors only care about the Windows Logo
sticker, and not about UEFI compliance, calling UpdateCapsule() from
the OS is poorly tested, and therefore broken on many platforms.

> > > OK, by reading the UEFI spec I assumed that you needed access to
> > > QueryCapsuleCapabilities and UpdateCapsule in order to perform the
> > > updates, and those should be proxied using hyopercalls. Maybe this is
> > > not mandatory and there's a side-band mechanism of doing this?
> > >
> > > I think we need more info here.
> > >
> > > > > So yes, I agree Xen should make sure the region of the table is n=
ot
> > > > > freed when exiting boot services, and that dom0 can access it. I
> > > > > guess we should move the checks done by Linux to Xen, and then on=
ly
> > > > > provide the ESRT table to dom0 if the checks (now done by Xen) pa=
ss.
> > > > Yes, something like this. But note currently in the (PV) dom0 case,=
 Xen
> > > > provides dom0 with a pointer to the whole SystemTable, not individu=
al
> > > > ConfigurationTables. Making it filter what dom0 gets would require =
Xen
> > > > to re-construct the whole thing with just those elements that are
> > > > desired. Not exactly sure if worth the effort given the privilege d=
om0
> > > > has.
> > > We already do this for ACPI in PVH dom0, where Xen rebuilds the RSDT
> > > in order to filter out tables that shouldn't be exposed to dom0. If
> > > possible using something similar for UEFI would be my preference, but
> > > I certainly haven't investigated at all whether this is feasible.
> > >
> > > > BTW How does it look in PVH dom0 case? Does it also get unmodified =
host
> > > > EFI SystemTable? In that case, it would be more tricky, because (II=
UC)
> > > > physical addresses (like the one for ESRT table) are not meaningful=
 to
> > > > PVH dom0.
> > > For PVH dom0 we should make sure the ESRT is identity mapped into the
> > > physmap, so that dom0 has access to it. PVH dom0 gets a physical
> > > memory map that's basically the native one with the RAM regions
> > > adjusted to match the assigned memory.
> > >
> > > We already identity map a bunch of stuff there, so identity mapping
> > > the ESRT would be likely fine.
> > >
> > > > > It might be helpful to see the whole picture here with the hooks =
to
> > > > > perform the updates also implemented, as those are missing in Xen=
 (and
> > > > > Linux?). That would give a clearer view of what you are trying to
> > > > > achieve IMO.
> > > > Norbert, can you shed some light on this process?
> > > >
> > > > While those two runtime services seems relevant, I see also an upda=
te
> > > > process involving simply dropping some file into ESP (/boot/efi). I=
'm
> > > > not sure if some runtime services were involved.
> > > So then the update is done when rebooting? If we expose the ESRT we
> > > should also make sure the run-time services related to it are
> > > available.
> >
> > Fwupd uses system firmware GUID to recognize its type. UEFI GUID is
> > provided in the ESRT. Then fwupd checks if the updates/downgrades are
> > available. In the next step the tool downloads and extracts cabinet
> > archives in the EFI capsule file format and the capsule updates firmwar=
e
> > after the OS reboot.
>
> Right, so you only need access to the ESRT table, that's all. Then I
> think we need to make sure Xen doesn't use this memory for anything
> else, which will require some changes in Xen (or at least some
> checks?).
>

Indeed. As long as the fwupdate tooling can access the ESRT, install
its .efi binary in /boot/efi and can manipulate the BootNext EFI
variable to to invoke it, it should work fine under Xen as well.

> We also need to decide what to do if the table turns out to be placed
> in a wrong region. How are we going to prevent dom0 from using it
> then? My preference would be to completely hide it from dom0 in that
> case, such that it believes there's no ESRT at all if possible.
>

The ESRT must be placed in memory that the OS may take ownership of,
and that is why we have this check. I think it is perfectly fine to
put the ESRT in memory that the OS will never touch in the first
place, which is much more straight-forward.
