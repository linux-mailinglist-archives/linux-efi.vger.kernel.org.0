Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31559248CD8
	for <lists+linux-efi@lfdr.de>; Tue, 18 Aug 2020 19:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgHRRV0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Aug 2020 13:21:26 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:54815 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbgHRRVX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Aug 2020 13:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1597771283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VfmAjtjrR5Ynd62bslgEeAhZ8za/6MtFXClJnwwT3/4=;
  b=bwRYljVIHibor6m9SFQVcB7J/EJWWP5tuEOkqFEOQrMtQt6iZQ1IoCbE
   FgYeojahteQDwWFVWDjwRfRtC778zDnUaz713DB86rbTnWxWyfySpprxt
   w4o0DJCujYIT6R4Up+nKAV/HJYuX5MXv9UJuiz/DnPaX0609EFN7DSmPe
   A=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: zO7pjpdgDyALpNUdQNwaOEZc3lL4eELU/ihYg2Dk/WSBgXSI53yydL07x0s+fGosQacUtfHAO8
 hLVsdsQZE2mHA24h0GXBO69J1XZe/Oz6Ye4QGx0Lxo6XqAVJ3F2h+F2XeKZ1wimMH1ljzlA2XE
 xzihH7RPDcurRln5vKCsLGDyZXQFM1BGUc7syThAvoLDyPKXJYf++tXXehMMeu/176XJOi5pI9
 JaSPzAwyimhC+h8vrg7Zsi3ir4u44HwtUTBeNlEDZiclQ+FOpCld0CaDW8nLJKSBP8uLaS6tS2
 dOM=
X-SBRS: 2.7
X-MesageID: 24808311
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.76,328,1592884800"; 
   d="scan'208";a="24808311"
Date:   Tue, 18 Aug 2020 19:21:14 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
CC:     Ard Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
        <norbert.kaminski@3mdeb.com>, <xen-devel@lists.xenproject.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] efi: discover ESRT table on Xen PV too
Message-ID: <20200818172114.GO828@Air-de-Roger>
References: <20200816001949.595424-1-marmarek@invisiblethingslab.com>
 <20200817090013.GN975@Air-de-Roger>
 <20200818120135.GK1679@mail-itl>
 <20200818124710.GK828@Air-de-Roger>
 <20200818150020.GL1679@mail-itl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200818150020.GL1679@mail-itl>
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 18, 2020 at 05:00:20PM +0200, Marek Marczykowski-Górecki wrote:
> On Tue, Aug 18, 2020 at 02:47:10PM +0200, Roger Pau Monné wrote:
> > On Tue, Aug 18, 2020 at 02:01:35PM +0200, Marek Marczykowski-Górecki wrote:
> > > Do you mean PV dom0 should receive full EFI memory map? Jan already
> > > objected this as it would be a layering violation.
> > 
> > dom0 is already capable of getting the native e820 memory map using
> > XENMEM_machine_memory_map, I'm not sure why allowing to return the
> > memory map in EFI form would be any different (or a layering
> > violation in the PV dom0 case).
> >
> > Do you have a reference to that thread? I certainly missed it.
> 
> See this thread: http://markmail.org/message/nrrvuau5whebksy2
> 
> > For PVH dom0 we could consider something different, since in that case
> > there's a guest memory map which could likely be returned in EFI
> > format and with the EFI regions if required.
> > 
> > > > > Skip this part on Xen PV (let Xen do the right thing if it deems
> > > > > necessary) and use ESRT table normally.
> > > > 
> > > > Maybe it would be better to introduce a new hypercall (or add a
> > > > parameter to XENMEM_machine_memory_map) in order to be able to fetch
> > > > the EFI memory map?
> > > >
> > > > That should allow a PV dom0 to check the ESRT is correct and thus not
> > > > diverge from bate metal.
> > > 
> > > Note the EFI memory map there is used not just to check things, but to
> > > actually modify it to reserve the region. I think that's rather Xen
> > > responsibility, not dom0. See the comment from Ard.
> > 
> > But that would modify Linux copy of the memory map, which is fine? My
> > understanding of EFI is limited, but I don't think such changes are
> > feed back into EFI, so Linux is completely free to do whatever it
> > wants with it's copy of the EFI memory map.
> 
> Yes, but the thing is to make sure Xen doesn't use that memory, not only
> dom0. See below.
> 
> > > > > +	if (efi_enabled(EFI_MEMMAP)) {
> > > > > +		rc = efi_mem_desc_lookup(efi.esrt, &md);
> > > > > +		if (rc < 0 ||
> > > > > +		    (!(md.attribute & EFI_MEMORY_RUNTIME) &&
> > > > > +		     md.type != EFI_BOOT_SERVICES_DATA &&
> > > > > +		     md.type != EFI_RUNTIME_SERVICES_DATA)) {
> > > > > +			pr_warn("ESRT header is not in the memory map.\n");
> > > > > +			return;
> > > > > +		}
> > > > 
> > > > Here you blindly trust the data in the ESRT in the PV case, without
> > > > checking it matches the regions on the memory map, which could lead to
> > > > errors if ESRT turns to be wrong.
> > > 
> > > I don't think checking merely if ESRT lives somewhere in
> > > EFI_{BOOT,RUNTIME}_SERVICES_DATA area guarantees its correctness.
> > > 
> > > On the other hand, this seems to be done to prevent overwriting that
> > > memory with something else (see that in case of EFI_BOOT_SERVICES_DATA
> > > it is later marked as reserved. I think it should be rather done by Xen,
> > > not dom0.
> > 
> > Forcing Xen to do all those checks seems quite a tedious work, and in
> > fact the memory map that dom0 has might be more complete than the one
> > Xen is able to construct, as Xen doesn't have an AML parser so it's
> > not able to get all the possible info from ACPI.
> 
> Let me draw the picture from the beginning.

Thanks, greatly appreciated.

> EFI memory map contains various memory regions. Some of them are marked
> as not needed after ExitBootServices() call (done in Xen before
> launching dom0). This includes EFI_BOOT_SERVICES_DATA and
> EFI_BOOT_SERVICES_CODE.
> 
> EFI SystemTable contains pointers to various ConfigurationTables -
> physical addresses (at least in this case). Xen does interpret some of
> them, but not ESRT. Xen pass the whole (address of) SystemTable to Linux
> dom0 (at least in PV case). Xen doesn't do anything about tables it
> doesn't understand.
> 
> Now, the code in Linux takes the (ESRT) table address early and checks
> the memory map for it. We have 3 cases:
>  - it points at area marked as neither EFI_*_SERVICES_DATA, nor with
>    EFI_MEMORY_RUNTIME attribute -> Linux refuse to use it
>  - it points to EFI_RUNTIME_SERVICES_DATA or with EFI_MEMORY_RUNTIME
>    attribute - Linux uses the table; memory map already says the area
>    belongs to EFI and the OS should not use it for something else
>  - it points to EFI_BOOT_SERVICES_DATA - Linux mark the area as reserved
>    to not release it after calling ExitBootServices()
> 
> The problematic is the third case - at the time when Linux dom0 is run,
> ExitBootServices() was already called and EFI_BOOT_SERVICES_* memory was
> already released. It could be already used for something else (for
> example Xen could overwrite it while loading dom0).
> 
> Note the problematic case should be the most common - UEFI specification
> says "The ESRT shall be stored in memory of type EfiBootServicesData"
> (chapter 22.3 of UEFI Spec v2.6).
> 
> For this reason, to use ESRT in dom0, Xen should do something about it
> before ExitBootServices() call. While analyzing all the EFI tables is
> probably not a viable option, it can do some simple action:
>  - retains all the EFI_BOOT_SERVICES_* areas - there is already code
>    for that, controlled with /mapbs boot switch (to xen.efi, would need
>    another option for multiboot2+efi)
>  - have a list of tables to retain - since Xen already do analyze some
>    of the ConfigurationTables, it can also have a list of those to
>    preserve even if they live in EFI_BOOT_SERVICES_DATA. In this case,
>    while Xen doesn't need to parse the whole table, it need to parse it's
>    header to get the table size - to reserve that memory and not reuse
>    it after ExitBootServices().

Xen seems to already contain skeleton
XEN_EFI_query_capsule_capabilities and XEN_EFI_update_capsule
hypercalls which is what should be used in order to perform the
updates?

So yes, I agree Xen should make sure the region of the table is not
freed when exiting boot services, and that dom0 can access it. I
guess we should move the checks done by Linux to Xen, and then only
provide the ESRT table to dom0 if the checks (now done by Xen) pass.

It might be helpful to see the whole picture here with the hooks to
perform the updates also implemented, as those are missing in Xen (and
Linux?). That would give a clearer view of what you are trying to
achieve IMO.

Thanks, Roger.
