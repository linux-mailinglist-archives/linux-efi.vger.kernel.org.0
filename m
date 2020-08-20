Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3686524BF01
	for <lists+linux-efi@lfdr.de>; Thu, 20 Aug 2020 15:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgHTNjH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Aug 2020 09:39:07 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:23530 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgHTJah (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Aug 2020 05:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1597915837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JOFJLG4ZbV1ni53LmoKfc6kfjJleIkSwPdTnr2L6gIo=;
  b=eWiFc/PLttUJbXLJpjWdbL62jmtAsVK83K5Dt451lwPSQdhYpK4zcpAL
   VUK/ljlU5yXc2W2YnevFjj3a5gnddGrqZ3b5UWTAMg91joFG0Tzj6XEhS
   Buv9ZxnWY8HFWlVXt5MfUBPsj+gZMIlrzaFXdL92lJsAA2POojhzu6xtN
   o=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: WvUXriqLGuvGCXAu5fnip2siz+RQmU0ppvt5rYOy+5ZvVIaKpmB3VtaYY2lR1wics2GzPM2k0o
 dcsc6SZ8zNggPrdeB5soBDeSVch5SJaO3Oi0i/aJygLYmw8fw2KcMsd9ZsjdT8gorf4VHsxENy
 GderqLJbJZKtygIfV6yeJKru+VJ9jWsNbgYbEjgobFtlVohqfoOyw6pjeO0OUjj4awi3e7MMaL
 WHYTSPYnqa0EZksh8CzO7qJ1CX3UHr/gnOBFFI5nQX88NA6HjW0GEwPr9GZsSs0uI2ACdgi2c8
 A48=
X-SBRS: 2.7
X-MesageID: 24915090
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.76,332,1592884800"; 
   d="scan'208";a="24915090"
Date:   Thu, 20 Aug 2020 11:30:25 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Norbert Kaminski <norbert.kaminski@3mdeb.com>
CC:     Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        Ard Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>,
        open list <linux-kernel@vger.kernel.org>,
        Maciej Pijanowski <maciej.pijanowski@3mdeb.com>,
        <piotr.krol@3mdeb.com>
Subject: Re: [PATCH] efi: discover ESRT table on Xen PV too
Message-ID: <20200820093025.GT828@Air-de-Roger>
References: <20200816001949.595424-1-marmarek@invisiblethingslab.com>
 <20200817090013.GN975@Air-de-Roger>
 <20200818120135.GK1679@mail-itl>
 <20200818124710.GK828@Air-de-Roger>
 <20200818150020.GL1679@mail-itl>
 <20200818172114.GO828@Air-de-Roger>
 <20200818184018.GN1679@mail-itl>
 <20200819081930.GQ828@Air-de-Roger>
 <3d405b0c-4e2b-0d29-56bb-e315f4c21d03@3mdeb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d405b0c-4e2b-0d29-56bb-e315f4c21d03@3mdeb.com>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 19, 2020 at 01:33:39PM +0200, Norbert Kaminski wrote:
> 
> On 19.08.2020 10:19, Roger Pau Monné wrote:
> > On Tue, Aug 18, 2020 at 08:40:18PM +0200, Marek Marczykowski-Górecki wrote:
> > > On Tue, Aug 18, 2020 at 07:21:14PM +0200, Roger Pau Monné wrote:
> > > > > Let me draw the picture from the beginning.
> > > > Thanks, greatly appreciated.
> > > > 
> > > > > EFI memory map contains various memory regions. Some of them are marked
> > > > > as not needed after ExitBootServices() call (done in Xen before
> > > > > launching dom0). This includes EFI_BOOT_SERVICES_DATA and
> > > > > EFI_BOOT_SERVICES_CODE.
> > > > > 
> > > > > EFI SystemTable contains pointers to various ConfigurationTables -
> > > > > physical addresses (at least in this case). Xen does interpret some of
> > > > > them, but not ESRT. Xen pass the whole (address of) SystemTable to Linux
> > > > > dom0 (at least in PV case). Xen doesn't do anything about tables it
> > > > > doesn't understand.
> > > > > 
> > > > > Now, the code in Linux takes the (ESRT) table address early and checks
> > > > > the memory map for it. We have 3 cases:
> > > > >   - it points at area marked as neither EFI_*_SERVICES_DATA, nor with
> > > > >     EFI_MEMORY_RUNTIME attribute -> Linux refuse to use it
> > > > >   - it points to EFI_RUNTIME_SERVICES_DATA or with EFI_MEMORY_RUNTIME
> > > > >     attribute - Linux uses the table; memory map already says the area
> > > > >     belongs to EFI and the OS should not use it for something else
> > > > >   - it points to EFI_BOOT_SERVICES_DATA - Linux mark the area as reserved
> > > > >     to not release it after calling ExitBootServices()
> > > > > 
> > > > > The problematic is the third case - at the time when Linux dom0 is run,
> > > > > ExitBootServices() was already called and EFI_BOOT_SERVICES_* memory was
> > > > > already released. It could be already used for something else (for
> > > > > example Xen could overwrite it while loading dom0).
> > > > > 
> > > > > Note the problematic case should be the most common - UEFI specification
> > > > > says "The ESRT shall be stored in memory of type EfiBootServicesData"
> > > > > (chapter 22.3 of UEFI Spec v2.6).
> > > > > 
> > > > > For this reason, to use ESRT in dom0, Xen should do something about it
> > > > > before ExitBootServices() call. While analyzing all the EFI tables is
> > > > > probably not a viable option, it can do some simple action:
> > > > >   - retains all the EFI_BOOT_SERVICES_* areas - there is already code
> > > > >     for that, controlled with /mapbs boot switch (to xen.efi, would need
> > > > >     another option for multiboot2+efi)
> > > > >   - have a list of tables to retain - since Xen already do analyze some
> > > > >     of the ConfigurationTables, it can also have a list of those to
> > > > >     preserve even if they live in EFI_BOOT_SERVICES_DATA. In this case,
> > > > >     while Xen doesn't need to parse the whole table, it need to parse it's
> > > > >     header to get the table size - to reserve that memory and not reuse
> > > > >     it after ExitBootServices().
> > > > Xen seems to already contain skeleton
> > > > XEN_EFI_query_capsule_capabilities and XEN_EFI_update_capsule
> > > > hypercalls which is what should be used in order to perform the
> > > > updates?
> > > I think those covers only runtime service calls similarly named. But you
> > > need also ESRT table to collect info about devices that you can even
> > > attempt to update.
> > Right, the ESRT must be available so that dom0 can discover the
> > resources.
> > 
> > > TBH, I'm not sure if those runtime services are really needed. I think
> > > Norbert succeeded UEFI update from within Xen PV dom0 with just access
> > > to the ESRT table, but without those services.
> > > 
> Marek is right here. I was able to successfully update and downgrade
> UFEI when the ESRT table was provided to the Xen PV dom0. I didn't
> need any extra services to make the UEFI capsule update work.

OK, I think that's using the method described in 8.5.5 of delivery of
Capsules via file on Mass Storage, which doesn't use the
UpdateCapsule() runtime API?

Using such method doesn't require QueryCapsuleCapabilities(), as
that's used to know whether a certain capsule can be updated via
UpdateCapsule().

> > OK, by reading the UEFI spec I assumed that you needed access to
> > QueryCapsuleCapabilities and UpdateCapsule in order to perform the
> > updates, and those should be proxied using hyopercalls. Maybe this is
> > not mandatory and there's a side-band mechanism of doing this?
> > 
> > I think we need more info here.
> > 
> > > > So yes, I agree Xen should make sure the region of the table is not
> > > > freed when exiting boot services, and that dom0 can access it. I
> > > > guess we should move the checks done by Linux to Xen, and then only
> > > > provide the ESRT table to dom0 if the checks (now done by Xen) pass.
> > > Yes, something like this. But note currently in the (PV) dom0 case, Xen
> > > provides dom0 with a pointer to the whole SystemTable, not individual
> > > ConfigurationTables. Making it filter what dom0 gets would require Xen
> > > to re-construct the whole thing with just those elements that are
> > > desired. Not exactly sure if worth the effort given the privilege dom0
> > > has.
> > We already do this for ACPI in PVH dom0, where Xen rebuilds the RSDT
> > in order to filter out tables that shouldn't be exposed to dom0. If
> > possible using something similar for UEFI would be my preference, but
> > I certainly haven't investigated at all whether this is feasible.
> > 
> > > BTW How does it look in PVH dom0 case? Does it also get unmodified host
> > > EFI SystemTable? In that case, it would be more tricky, because (IIUC)
> > > physical addresses (like the one for ESRT table) are not meaningful to
> > > PVH dom0.
> > For PVH dom0 we should make sure the ESRT is identity mapped into the
> > physmap, so that dom0 has access to it. PVH dom0 gets a physical
> > memory map that's basically the native one with the RAM regions
> > adjusted to match the assigned memory.
> > 
> > We already identity map a bunch of stuff there, so identity mapping
> > the ESRT would be likely fine.
> > 
> > > > It might be helpful to see the whole picture here with the hooks to
> > > > perform the updates also implemented, as those are missing in Xen (and
> > > > Linux?). That would give a clearer view of what you are trying to
> > > > achieve IMO.
> > > Norbert, can you shed some light on this process?
> > > 
> > > While those two runtime services seems relevant, I see also an update
> > > process involving simply dropping some file into ESP (/boot/efi). I'm
> > > not sure if some runtime services were involved.
> > So then the update is done when rebooting? If we expose the ESRT we
> > should also make sure the run-time services related to it are
> > available.
> 
> Fwupd uses system firmware GUID to recognize its type. UEFI GUID is
> provided in the ESRT. Then fwupd checks if the updates/downgrades are
> available. In the next step the tool downloads and extracts cabinet
> archives in the EFI capsule file format and the capsule updates firmware
> after the OS reboot.

Right, so you only need access to the ESRT table, that's all. Then I
think we need to make sure Xen doesn't use this memory for anything
else, which will require some changes in Xen (or at least some
checks?).

We also need to decide what to do if the table turns out to be placed
in a wrong region. How are we going to prevent dom0 from using it
then? My preference would be to completely hide it from dom0 in that
case, such that it believes there's no ESRT at all if possible.

Thanks, Roger.
