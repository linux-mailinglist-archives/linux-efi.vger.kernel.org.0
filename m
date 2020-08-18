Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40CB24856F
	for <lists+linux-efi@lfdr.de>; Tue, 18 Aug 2020 14:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgHRMy2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Aug 2020 08:54:28 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:54774 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgHRMy2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Aug 2020 08:54:28 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Aug 2020 08:54:27 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1597755267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=30nedNabKIl2ONo0gOi3dKQIA20CDBWllkqmCPSHJQE=;
  b=cf0qBtaOIRuWmQknnohxhyV1+veoxcnWaHKJR3dh0KFgC3DAMUxZT+hU
   OdoRPwteWGwSAHZFB0FFX4AQvwwMYKbZW7+k3oMSRE42NhpwXowBncPvh
   67h02wa1Sj44onseeIoBsntUbAkbd4lqWkOO8JgdiSTgvFUSyxMzrudS1
   k=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: dSa65gImyo2iPr/x4jx1ac6nBLkXBjB+3bhzo7yCsGsutshy6SyHRC1/mvirRj8xwTSf8HyP28
 RrcpF4aWlO5hBNwDOqVsxTTYwSAKprYd2wAksJgMSqhsWMx3PqigSW3AQZE6DyfLEkT30Tc7MS
 FbaT5U2wEV32R2uVGjyUq9Afv2n63ehmFsFawimfJ08+6N14gHlT//+oDkhM4wS7tglHHTTlsr
 ES+04Ng9m5JFNjSS09sCzsjRu7eNejVzZ5z20jceaWbqZBPmINdZh63qh8jv5o3dPdRuVgBzud
 HdM=
X-SBRS: 2.7
X-MesageID: 24920909
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.76,327,1592884800"; 
   d="scan'208";a="24920909"
Date:   Tue, 18 Aug 2020 14:47:10 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
CC:     Ard Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
        <norbert.kaminski@3mdeb.com>, <xen-devel@lists.xenproject.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] efi: discover ESRT table on Xen PV too
Message-ID: <20200818124710.GK828@Air-de-Roger>
References: <20200816001949.595424-1-marmarek@invisiblethingslab.com>
 <20200817090013.GN975@Air-de-Roger>
 <20200818120135.GK1679@mail-itl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200818120135.GK1679@mail-itl>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 18, 2020 at 02:01:35PM +0200, Marek Marczykowski-Górecki wrote:
> On Mon, Aug 17, 2020 at 11:00:13AM +0200, Roger Pau Monné wrote:
> > On Sun, Aug 16, 2020 at 02:19:49AM +0200, Marek Marczykowski-Górecki wrote:
> > > In case of Xen PV dom0, Xen passes along info about system tables (see
> > > arch/x86/xen/efi.c), but not the memory map from EFI.
> > 
> > I think that's because the memory map returned by
> > XENMEM_machine_memory_map is in e820 form, and doesn't contain the
> > required information about the EFI regions due to the translation done
> > by efi_arch_process_memory_map in Xen?
> 
> Yes, I think so.
> 
> > > This makes sense
> > > as it is Xen responsible for managing physical memory address space.
> > > In this case, it doesn't make sense to condition using ESRT table on
> > > availability of EFI memory map, as it isn't Linux kernel responsible for
> > > it.
> > 
> > PV dom0 is kind of special in that regard as it can create mappings to
> > (almost) any MMIO regions, and hence can change it's memory map
> > substantially.
> 
> Do you mean PV dom0 should receive full EFI memory map? Jan already
> objected this as it would be a layering violation.

dom0 is already capable of getting the native e820 memory map using
XENMEM_machine_memory_map, I'm not sure why allowing to return the
memory map in EFI form would be any different (or a layering
violation in the PV dom0 case).

Do you have a reference to that thread? I certainly missed it.

For PVH dom0 we could consider something different, since in that case
there's a guest memory map which could likely be returned in EFI
format and with the EFI regions if required.

> > > Skip this part on Xen PV (let Xen do the right thing if it deems
> > > necessary) and use ESRT table normally.
> > 
> > Maybe it would be better to introduce a new hypercall (or add a
> > parameter to XENMEM_machine_memory_map) in order to be able to fetch
> > the EFI memory map?
> >
> > That should allow a PV dom0 to check the ESRT is correct and thus not
> > diverge from bate metal.
> 
> Note the EFI memory map there is used not just to check things, but to
> actually modify it to reserve the region. I think that's rather Xen
> responsibility, not dom0. See the comment from Ard.

But that would modify Linux copy of the memory map, which is fine? My
understanding of EFI is limited, but I don't think such changes are
feed back into EFI, so Linux is completely free to do whatever it
wants with it's copy of the EFI memory map.

> > > 
> > > This is a requirement for using fwupd in PV dom0 to update UEFI using
> > > capsules.
> > > 
> > > Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> > > ---
> > >  drivers/firmware/efi/esrt.c | 47 ++++++++++++++++++++-----------------
> > >  1 file changed, 25 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
> > > index d5915272141f..5c49f2aaa4b1 100644
> > > --- a/drivers/firmware/efi/esrt.c
> > > +++ b/drivers/firmware/efi/esrt.c
> > > @@ -245,36 +245,38 @@ void __init efi_esrt_init(void)
> > >  	int rc;
> > >  	phys_addr_t end;
> > >  
> > > -	if (!efi_enabled(EFI_MEMMAP))
> > > +	if (!efi_enabled(EFI_MEMMAP) && !efi_enabled(EFI_PARAVIRT))
> > >  		return;
> > >  
> > >  	pr_debug("esrt-init: loading.\n");
> > >  	if (!esrt_table_exists())
> > >  		return;
> > >  
> > > -	rc = efi_mem_desc_lookup(efi.esrt, &md);
> > > -	if (rc < 0 ||
> > > -	    (!(md.attribute & EFI_MEMORY_RUNTIME) &&
> > > -	     md.type != EFI_BOOT_SERVICES_DATA &&
> > > -	     md.type != EFI_RUNTIME_SERVICES_DATA)) {
> > > -		pr_warn("ESRT header is not in the memory map.\n");
> > > -		return;
> > > -	}
> > > +	if (efi_enabled(EFI_MEMMAP)) {
> > > +		rc = efi_mem_desc_lookup(efi.esrt, &md);
> > > +		if (rc < 0 ||
> > > +		    (!(md.attribute & EFI_MEMORY_RUNTIME) &&
> > > +		     md.type != EFI_BOOT_SERVICES_DATA &&
> > > +		     md.type != EFI_RUNTIME_SERVICES_DATA)) {
> > > +			pr_warn("ESRT header is not in the memory map.\n");
> > > +			return;
> > > +		}
> > 
> > Here you blindly trust the data in the ESRT in the PV case, without
> > checking it matches the regions on the memory map, which could lead to
> > errors if ESRT turns to be wrong.
> 
> I don't think checking merely if ESRT lives somewhere in
> EFI_{BOOT,RUNTIME}_SERVICES_DATA area guarantees its correctness.
> 
> On the other hand, this seems to be done to prevent overwriting that
> memory with something else (see that in case of EFI_BOOT_SERVICES_DATA
> it is later marked as reserved. I think it should be rather done by Xen,
> not dom0.

Forcing Xen to do all those checks seems quite a tedious work, and in
fact the memory map that dom0 has might be more complete than the one
Xen is able to construct, as Xen doesn't have an AML parser so it's
not able to get all the possible info from ACPI.

Thanks, Roger.
