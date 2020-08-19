Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B0C24982C
	for <lists+linux-efi@lfdr.de>; Wed, 19 Aug 2020 10:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgHSIWF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Aug 2020 04:22:05 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:64593 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgHSIWD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Aug 2020 04:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1597825322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NbDCPX8l8+q2q+LowO/6gJERcsTsVOGR5x7RxsNOXjw=;
  b=TbBP/80eWsGL77Y3SDvU6lSJIlguTaes3rcx2U/Y+Olm3BDCgO5c0Apo
   kY4es8cu0cjMumHeiKLNj8JShxQ7dn91zbOsjzjec3pRJyfQNY4mx1X/I
   qORDHZPNnUjtF2k5l6etkn5gBYjLafW9XmFMppsm0wlF5IIEVQvuIEyS+
   E=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: agsEOeT7Ii+Yn9+iBSJaj/IiN2LpsOmiJvAi8kTZ3+K62CFAxviiXkivGAcvk/4MyW6nmaI54S
 pQnpkmC9pPbMH6FXDLnGuZ/1tiurvlw4c96QBDdcxVqwuEz31FG1w0RZLK243f9luYYflE7Aus
 8mI2mSNGUgrQbV0irh3aMXEHKvoX8yJ3F9MVJqggUP4DNjK1kAJ9jjgSHHaykWTjtf9uotpQLI
 3SEQISu8Rf/8EPakDKys5vBwBXOfSOcVMcvNhBiFVxh6KshnUbX80FS4oEO7nfTy0R4AO6ylVJ
 JhM=
X-SBRS: 2.7
X-MesageID: 24991947
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.76,330,1592884800"; 
   d="scan'208";a="24991947"
Date:   Wed, 19 Aug 2020 10:19:30 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
CC:     Ard Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
        <norbert.kaminski@3mdeb.com>, <xen-devel@lists.xenproject.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] efi: discover ESRT table on Xen PV too
Message-ID: <20200819081930.GQ828@Air-de-Roger>
References: <20200816001949.595424-1-marmarek@invisiblethingslab.com>
 <20200817090013.GN975@Air-de-Roger>
 <20200818120135.GK1679@mail-itl>
 <20200818124710.GK828@Air-de-Roger>
 <20200818150020.GL1679@mail-itl>
 <20200818172114.GO828@Air-de-Roger>
 <20200818184018.GN1679@mail-itl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200818184018.GN1679@mail-itl>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 18, 2020 at 08:40:18PM +0200, Marek Marczykowski-Górecki wrote:
> On Tue, Aug 18, 2020 at 07:21:14PM +0200, Roger Pau Monné wrote:
> > > Let me draw the picture from the beginning.
> > 
> > Thanks, greatly appreciated.
> > 
> > > EFI memory map contains various memory regions. Some of them are marked
> > > as not needed after ExitBootServices() call (done in Xen before
> > > launching dom0). This includes EFI_BOOT_SERVICES_DATA and
> > > EFI_BOOT_SERVICES_CODE.
> > > 
> > > EFI SystemTable contains pointers to various ConfigurationTables -
> > > physical addresses (at least in this case). Xen does interpret some of
> > > them, but not ESRT. Xen pass the whole (address of) SystemTable to Linux
> > > dom0 (at least in PV case). Xen doesn't do anything about tables it
> > > doesn't understand.
> > > 
> > > Now, the code in Linux takes the (ESRT) table address early and checks
> > > the memory map for it. We have 3 cases:
> > >  - it points at area marked as neither EFI_*_SERVICES_DATA, nor with
> > >    EFI_MEMORY_RUNTIME attribute -> Linux refuse to use it
> > >  - it points to EFI_RUNTIME_SERVICES_DATA or with EFI_MEMORY_RUNTIME
> > >    attribute - Linux uses the table; memory map already says the area
> > >    belongs to EFI and the OS should not use it for something else
> > >  - it points to EFI_BOOT_SERVICES_DATA - Linux mark the area as reserved
> > >    to not release it after calling ExitBootServices()
> > > 
> > > The problematic is the third case - at the time when Linux dom0 is run,
> > > ExitBootServices() was already called and EFI_BOOT_SERVICES_* memory was
> > > already released. It could be already used for something else (for
> > > example Xen could overwrite it while loading dom0).
> > > 
> > > Note the problematic case should be the most common - UEFI specification
> > > says "The ESRT shall be stored in memory of type EfiBootServicesData"
> > > (chapter 22.3 of UEFI Spec v2.6).
> > > 
> > > For this reason, to use ESRT in dom0, Xen should do something about it
> > > before ExitBootServices() call. While analyzing all the EFI tables is
> > > probably not a viable option, it can do some simple action:
> > >  - retains all the EFI_BOOT_SERVICES_* areas - there is already code
> > >    for that, controlled with /mapbs boot switch (to xen.efi, would need
> > >    another option for multiboot2+efi)
> > >  - have a list of tables to retain - since Xen already do analyze some
> > >    of the ConfigurationTables, it can also have a list of those to
> > >    preserve even if they live in EFI_BOOT_SERVICES_DATA. In this case,
> > >    while Xen doesn't need to parse the whole table, it need to parse it's
> > >    header to get the table size - to reserve that memory and not reuse
> > >    it after ExitBootServices().
> > 
> > Xen seems to already contain skeleton
> > XEN_EFI_query_capsule_capabilities and XEN_EFI_update_capsule
> > hypercalls which is what should be used in order to perform the
> > updates?
> 
> I think those covers only runtime service calls similarly named. But you
> need also ESRT table to collect info about devices that you can even
> attempt to update.

Right, the ESRT must be available so that dom0 can discover the
resources.

> TBH, I'm not sure if those runtime services are really needed. I think
> Norbert succeeded UEFI update from within Xen PV dom0 with just access
> to the ESRT table, but without those services.

OK, by reading the UEFI spec I assumed that you needed access to
QueryCapsuleCapabilities and UpdateCapsule in order to perform the
updates, and those should be proxied using hyopercalls. Maybe this is
not mandatory and there's a side-band mechanism of doing this?

I think we need more info here.

> > So yes, I agree Xen should make sure the region of the table is not
> > freed when exiting boot services, and that dom0 can access it. I
> > guess we should move the checks done by Linux to Xen, and then only
> > provide the ESRT table to dom0 if the checks (now done by Xen) pass.
> 
> Yes, something like this. But note currently in the (PV) dom0 case, Xen
> provides dom0 with a pointer to the whole SystemTable, not individual
> ConfigurationTables. Making it filter what dom0 gets would require Xen
> to re-construct the whole thing with just those elements that are
> desired. Not exactly sure if worth the effort given the privilege dom0
> has.

We already do this for ACPI in PVH dom0, where Xen rebuilds the RSDT
in order to filter out tables that shouldn't be exposed to dom0. If
possible using something similar for UEFI would be my preference, but
I certainly haven't investigated at all whether this is feasible.

> BTW How does it look in PVH dom0 case? Does it also get unmodified host
> EFI SystemTable? In that case, it would be more tricky, because (IIUC)
> physical addresses (like the one for ESRT table) are not meaningful to
> PVH dom0.

For PVH dom0 we should make sure the ESRT is identity mapped into the
physmap, so that dom0 has access to it. PVH dom0 gets a physical
memory map that's basically the native one with the RAM regions
adjusted to match the assigned memory.

We already identity map a bunch of stuff there, so identity mapping
the ESRT would be likely fine.

> > It might be helpful to see the whole picture here with the hooks to
> > perform the updates also implemented, as those are missing in Xen (and
> > Linux?). That would give a clearer view of what you are trying to
> > achieve IMO.
> 
> Norbert, can you shed some light on this process?
> 
> While those two runtime services seems relevant, I see also an update
> process involving simply dropping some file into ESP (/boot/efi). I'm
> not sure if some runtime services were involved.

So then the update is done when rebooting? If we expose the ESRT we
should also make sure the run-time services related to it are
available.

Thanks, Roger.
