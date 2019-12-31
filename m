Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56FA912D596
	for <lists+linux-efi@lfdr.de>; Tue, 31 Dec 2019 02:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfLaBqp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Dec 2019 20:46:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23911 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725379AbfLaBqp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 30 Dec 2019 20:46:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577756804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e+sYUmxa1TEn5zB6sAfjfPZV3UlhzBXcIAfNapo+jHs=;
        b=i3bvXU0nLyGbj0J9Tjw1OKMfPkt8jWCDyjLX3SGDuLKH5c2R8D7gp3gZBVnmsngYcD2Qhr
        n+AS0bj9ZU7AdBMFvkaKsYsRwPn1cFvU/UT4NFlvuqjW6Wl2RIxMw46ufALvug/XZzdX+l
        911jWE71Uhb+DrjP/0b/dvRO3Llf5Mk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-ebqUWcewNfe0-FTDGYcsNw-1; Mon, 30 Dec 2019 20:46:40 -0500
X-MC-Unique: ebqUWcewNfe0-FTDGYcsNw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F9D68017DF;
        Tue, 31 Dec 2019 01:46:38 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-141.pek2.redhat.com [10.72.12.141])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3424410001BD;
        Tue, 31 Dec 2019 01:46:33 +0000 (UTC)
Date:   Tue, 31 Dec 2019 09:46:30 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     mingo@redhat.com, Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Michael Weiser <michael@weiser.dinsnail.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] efi: Fix handling of multiple contiguous efi_fake_mem=
 entries
Message-ID: <20191231014630.GA24942@dhcp-128-65.nay.redhat.com>
References: <157773590338.4153451.5898675419563883883.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157773590338.4153451.5898675419563883883.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Dan,
On 12/30/19 at 11:58am, Dan Williams wrote:
> A recent test of efi_fake_mem=4G@9G:0x40000,4G@13G:0x40000 crashed with
> a signature of:
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
> efi_memmap_insert() is attempting to insert entries past the end of the
> new map. This condition is setup by efi_fake_mem() leaking empty entries
> to the end of memory map, and then efi_arch_mem_reserve() trips over the
> bad entry when attempting an additional efi_memmap_insert(). The empty
> entry causes efi_memmap_insert() to attempt more memmap splits / copies
> than efi_memmap_split_count() accounted for when sizing the new map.
> 
> Update efi_fake_memmap() to cleanup lagging empty entries.
> 
> This change is related to commit af1648984828 "x86/efi: Update e820 with
> reserved EFI boot services data to fix kexec breakage" since that
> introduces more occurrences where efi_memmap_insert() is invoked after
> an efi_fake_mem= configuration has been parsed. Previously the side
> effects of vestigial empty entries were benign, but with commit
> af1648984828 that follow-on efi_memmap_insert() invocation triggers the
> above crash signature.
> 
> Fixes: 0f96a99dab36 ("efi: Add 'efi_fake_mem' boot option")
> Fixes: af1648984828 ("x86/efi: Update e820 with reserved EFI boot services...")
> Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
> Cc: Michael Weiser <michael@weiser.dinsnail.net>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/firmware/efi/fake_mem.c |   22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
> index bb9fc70d0cfa..6df51ba93ae8 100644
> --- a/drivers/firmware/efi/fake_mem.c
> +++ b/drivers/firmware/efi/fake_mem.c
> @@ -67,13 +67,33 @@ void __init efi_fake_memmap(void)
>  		return;
>  	}
>  
> +	memset(new_memmap, 0, efi.memmap.desc_size * new_nr_map);
>  	for (i = 0; i < nr_fake_mem; i++)
>  		efi_memmap_insert(&efi.memmap, new_memmap, &efi_fake_mems[i]);
>  
> +	/*
> +	 * efi_memmap_split_count() may over count the number of
> +	 * required splits in the case when contiguous fake entries are
> +	 * specified. Check that all new_nr_map entries were consumed.
> +	 */
> +	for (i = new_nr_map; i > 0; i--) {
> +		efi_memory_desc_t *md;
> +		u64 start, end;
> +
> +		md = new_memmap + efi.memmap.desc_size * (new_nr_map - i - 1);
> +		end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - 1;
> +		start = md->phys_addr;
> +
> +		if (start == 0 && end + 1 == 0)
> +			continue;
> +		break;
> +	}
> +
>  	/* swap into new EFI memmap */
>  	early_memunmap(new_memmap, efi.memmap.desc_size * new_nr_map);
>  
> -	efi_memmap_install(new_memmap_phy, new_nr_map);
> +	/* install only the valid entries */
> +	efi_memmap_install(new_memmap_phy, i);
>  
>  	/* print new EFI memmap */
>  	efi_print_memmap();
> 

Although kernel bootup works with this patch, it still does not fix the
issue I noticed, you can see:
[root@localhost ~]# cat /proc/cmdline
BOOT_IMAGE=/bzImage root=/dev/vda3 ro audit=0 selinux=0 crashkernel=160M efi=debug console=ttyS0 console=tty0 3 efi_fake_mem=200M@5G:0x40000,300M@5600M:0x40000 earlyprintk=serial
[root@localhost ~]# dmesg|grep fake_mem
[    0.000000] Command line: BOOT_IMAGE=/bzImage root=/dev/vda3 ro audit=0 selinux=0 crashkernel=160M efi=debug console=ttyS0 console=tty0 3 efi_fake_mem=200M@5G:0x40000,300M@5600M:0x40000 earlyprintk=serial
[    0.000000] efi_fake_mem: add attr=0x0000000000040000 to [mem 0x0000000140000000-0x000000014c7fffff]
[    0.000000] efi_fake_mem: add attr=0x0000000000040000 to [mem 0x000000015e000000-0x0000000170bfffff]
[root@localhost ~]# dmesg|grep SP
[    0.085762] efi: mem48: [Conventional Memory|   |  |SP|  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000015e000000-0x0000000170bfffff] (300MB)


With this patch applied, there is still only one md set "SP" attr.  That
means only the last insert worked.

void __init efi_memmap_insert(struct efi_memory_map *old_memmap, void *buf,
                              struct efi_mem_range *mem)

The above function will use the old_memmap as the base for each
inserting.  the old_memmap == &efi.memmap, so when you do below:
        for (i = 0; i < nr_fake_mem; i++)
                efi_memmap_insert(&efi.memmap, new_memmap, &efi_fake_mems[i]);

Only the last inserting will take effect.  Below debug patch worked for
me, but I thought you have found same bug so I did not add it in the
reply, here it is, only for debugging purpose, not graceful:

diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
index bb9fc70d0cfa..097eaf7deb6a 100644
--- a/drivers/firmware/efi/fake_mem.c
+++ b/drivers/firmware/efi/fake_mem.c
@@ -36,44 +36,48 @@ static int __init cmp_fake_mem(const void *x1, const void *x2)
 
 void __init efi_fake_memmap(void)
 {
-	int new_nr_map = efi.memmap.nr_map;
-	efi_memory_desc_t *md;
-	phys_addr_t new_memmap_phy;
-	void *new_memmap;
 	int i;
 
+	pr_info("nr fake mem %d\n", nr_fake_mem);
 	if (!efi_enabled(EFI_MEMMAP) || !nr_fake_mem)
 		return;
 
 	/* count up the number of EFI memory descriptor */
 	for (i = 0; i < nr_fake_mem; i++) {
-		for_each_efi_memory_desc(md) {
-			struct range *r = &efi_fake_mems[i].range;
-
-			new_nr_map += efi_memmap_split_count(md, r);
+		int new_nr_map = efi.memmap.nr_map;
+		efi_memory_desc_t md0;
+		efi_memory_desc_t *md = &md0;
+		phys_addr_t new_memmap_phy;
+		void *new_memmap;
+
+		if (efi_mem_desc_lookup(efi_fake_mems[i].range.start, md)) {
+			pr_err("Failed to lookup EFI memory descriptor for %pa\n", &efi_fake_mems[i].range.start);
+			return;
+ 		}
+
+		new_nr_map += efi_memmap_split_count(md, &efi_fake_mems[i].range);
+
+		pr_info("new nr %d\n", new_nr_map);
+		/* allocate memory for new EFI memmap */
+		new_memmap_phy = efi_memmap_alloc(new_nr_map);
+		if (!new_memmap_phy){
+			pr_info("alloc new map failed\n");
+			return;}
+ 
+		/* create new EFI memmap */
+		new_memmap = early_memremap(new_memmap_phy,
+ 				    efi.memmap.desc_size * new_nr_map);
+		if (!new_memmap) {
+			pr_info("map new map failed\n");
+			memblock_free(new_memmap_phy, efi.memmap.desc_size * new_nr_map);
+			return;
 		}
-	}
-
-	/* allocate memory for new EFI memmap */
-	new_memmap_phy = efi_memmap_alloc(new_nr_map);
-	if (!new_memmap_phy)
-		return;
-
-	/* create new EFI memmap */
-	new_memmap = early_memremap(new_memmap_phy,
-				    efi.memmap.desc_size * new_nr_map);
-	if (!new_memmap) {
-		memblock_free(new_memmap_phy, efi.memmap.desc_size * new_nr_map);
-		return;
-	}
-
-	for (i = 0; i < nr_fake_mem; i++)
 		efi_memmap_insert(&efi.memmap, new_memmap, &efi_fake_mems[i]);
-
-	/* swap into new EFI memmap */
-	early_memunmap(new_memmap, efi.memmap.desc_size * new_nr_map);
-
-	efi_memmap_install(new_memmap_phy, new_nr_map);
+		/* swap into new EFI memmap */
+		early_memunmap(new_memmap, efi.memmap.desc_size * new_nr_map);
+		efi_memmap_install(new_memmap_phy, new_nr_map);
+		pr_info("inserted new map\n");
+	}
 
 	/* print new EFI memmap */
 	efi_print_memmap();

Thanks
Dave

