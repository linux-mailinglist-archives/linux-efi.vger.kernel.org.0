Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A58E812DD9E
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jan 2020 05:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgAAEv5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Dec 2019 23:51:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48105 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727133AbgAAEv5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Dec 2019 23:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577854316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jNvAEKxX6esQ/hFCmJclrrUl53XOCEqp6qr78VvgHks=;
        b=E55wUGHJIxngbYYZOAcRwifsXzCdhEEPlaAO6oM7Y1NyhLNhD1f83I/kZ3I0Wfdhk8ZGeP
        2bPtcMcSJuKBDlmmfoJDl5UZnu3M8a6vsDNfeMNiAww6lpLS5YBZ7kaZRkxWZx1SvRkMEB
        6D6V4Wy+StHUTo1OSMixLS+1LG1B0w0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-AhUNZXtEM16TvLbJMgacGQ-1; Tue, 31 Dec 2019 23:51:52 -0500
X-MC-Unique: AhUNZXtEM16TvLbJMgacGQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8C0D107ACC4;
        Wed,  1 Jan 2020 04:51:50 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-60.pek2.redhat.com [10.72.12.60])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F06D9A84;
        Wed,  1 Jan 2020 04:51:45 +0000 (UTC)
Date:   Wed, 1 Jan 2020 12:51:41 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     mingo@redhat.com, Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Michael Weiser <michael@weiser.dinsnail.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v2 4/4] efi: Fix handling of multiple efi_fake_mem=
 entries
Message-ID: <20200101045141.GA15155@dhcp-128-65.nay.redhat.com>
References: <157782985777.367056.14741265874314204783.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157782987865.367056.15199592105978588123.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157782987865.367056.15199592105978588123.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Dan,
On 12/31/19 at 02:04pm, Dan Williams wrote:
> Dave noticed that when specifying multiple efi_fake_mem= entries only
> the last entry was successfully being reflected in the efi memory map.
> This is due to the fact that the efi_memmap_insert() is being called
> multiple times, but on successive invocations the insertion should be
> applied to the last new memmap rather than the original map at
> efi_fake_memmap() entry.
> 
> Rework efi_fake_memmap() to install the new memory map after each
> efi_fake_mem= entry is parsed.
> 
> This also fixes an issue in efi_fake_memmap() that caused it to litter
> emtpy entries into the end of the efi memory map. The empty entry causes
> efi_memmap_insert() to attempt more memmap splits / copies than
> efi_memmap_split_count() accounted for when sizing the new map.
> 
>     BUG: unable to handle page fault for address: ffffffffff281000
>     [..]
>     RIP: 0010:efi_memmap_insert+0x11d/0x191
>     [..]
>     Call Trace:
>      ? bgrt_init+0xbe/0xbe
>      ? efi_arch_mem_reserve+0x1cb/0x228
>      ? acpi_parse_bgrt+0xa/0xd
>      ? acpi_table_parse+0x86/0xb8
>      ? acpi_boot_init+0x494/0x4e3
>      ? acpi_parse_x2apic+0x87/0x87
>      ? setup_acpi_sci+0xa2/0xa2
>      ? setup_arch+0x8db/0x9e1
>      ? start_kernel+0x6a/0x547
>      ? secondary_startup_64+0xb6/0xc0
> 
> Commit af1648984828 "x86/efi: Update e820 with reserved EFI boot
> services data to fix kexec breakage" is listed in Fixes: since it
> introduces more occurrences where efi_memmap_insert() is invoked after
> an efi_fake_mem= configuration has been parsed. Previously the side
> effects of vestigial empty entries were benign, but with commit
> af1648984828 that follow-on efi_memmap_insert() invocation triggers the
> above crash signature.
> 
> Fixes: 0f96a99dab36 ("efi: Add 'efi_fake_mem' boot option")
> Fixes: af1648984828 ("x86/efi: Update e820 with reserved EFI boot services...")
> Link: https://lore.kernel.org/r/20191231014630.GA24942@dhcp-128-65.nay.redhat.com
> Reported-by: Dave Young <dyoung@redhat.com>
> Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
> Cc: Michael Weiser <michael@weiser.dinsnail.net>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/firmware/efi/fake_mem.c |   32 +++++++++++++++++---------------
>  drivers/firmware/efi/memmap.c   |    2 +-
>  include/linux/efi.h             |    2 ++
>  3 files changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
> index 7e53e5520548..68d752d8af21 100644
> --- a/drivers/firmware/efi/fake_mem.c
> +++ b/drivers/firmware/efi/fake_mem.c
> @@ -34,26 +34,17 @@ static int __init cmp_fake_mem(const void *x1, const void *x2)
>  	return 0;
>  }
>  
> -void __init efi_fake_memmap(void)
> +static void __init efi_fake_range(struct efi_mem_range *efi_range)
>  {
>  	int new_nr_map = efi.memmap.nr_map;
>  	efi_memory_desc_t *md;
>  	phys_addr_t new_memmap_phy;
>  	unsigned long flags = 0;
>  	void *new_memmap;
> -	int i;
> -
> -	if (!efi_enabled(EFI_MEMMAP) || !nr_fake_mem)
> -		return;
>  
>  	/* count up the number of EFI memory descriptor */
> -	for (i = 0; i < nr_fake_mem; i++) {
> -		for_each_efi_memory_desc(md) {
> -			struct range *r = &efi_fake_mems[i].range;
> -
> -			new_nr_map += efi_memmap_split_count(md, r);
> -		}
> -	}
> +	for_each_efi_memory_desc(md)
> +		new_nr_map += efi_memmap_split_count(md, &efi_range->range);

I have another concern here :(

THe efi_memmap_split_count mean to only split for a specific md, and you
can see arch/x86/platform/efi/quirks.c about the use:
        if (addr + size > md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT)) {
                pr_err("Region spans EFI memory descriptors, %pa\n", &addr);
                return;
        }

Any memory region to be inserted but spans different md will be
rejected.  So the memmap insert logic seems does not support the
spanned ranges.  I did not find a case two contiguous same type ranges
eg. two "Conventional memory", if have they should have been merged. 

So maybe just use same way as the quirks.c here to find the valid md first
then get the split count?

Otherwise I tested the series bootup test passed.

BTW, another issue about fakemem,  currently it only works with normal
physical boot,  in case of kexec reboot the kernel only aware of EFI
runtime memory ranges, we do not pass other types in memmap.  But maybe
we can live with it considering fake mem is only for debugging purpose.

Thanks
Dave

