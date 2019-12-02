Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A992F10F3BB
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2019 01:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfLCAAy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Dec 2019 19:00:54 -0500
Received: from heinz.dinsnail.net ([81.169.187.250]:38070 "EHLO
        heinz.dinsnail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfLCAAx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Dec 2019 19:00:53 -0500
Received: from heinz.dinsnail.net ([IPv6:0:0:0:0:0:0:0:1])
        by heinz.dinsnail.net (8.15.2/8.15.2) with ESMTP id xB300C2Y016385;
        Tue, 3 Dec 2019 01:00:12 +0100
Received: from eldalonde.UUCP (uucp@localhost)
        by heinz.dinsnail.net (8.15.2/8.15.2/Submit) with bsmtp id xB300BNi016384;
        Tue, 3 Dec 2019 01:00:11 +0100
Received: from eldalonde.weiser.dinsnail.net (localhost [IPv6:0:0:0:0:0:0:0:1])
        by eldalonde.weiser.dinsnail.net (8.15.2/8.15.2) with ESMTP id xB2Njf9K028533;
        Tue, 3 Dec 2019 00:45:41 +0100
Received: (from michael@localhost)
        by eldalonde.weiser.dinsnail.net (8.15.2/8.15.2/Submit) id xB2NjfYU028532;
        Tue, 3 Dec 2019 00:45:41 +0100
Date:   Tue, 3 Dec 2019 00:45:41 +0100
From:   Michael Weiser <michael@weiser.dinsnail.net>
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-efi@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: kexec_file overwrites reserved EFI ESRT memory
Message-ID: <20191202234541.GA27567@weiser.dinsnail.net>
References: <20191122180552.GA32104@weiser.dinsnail.net>
 <87blt3y949.fsf@x220.int.ebiederm.org>
 <20191122210702.GE32104@weiser.dinsnail.net>
 <20191125055201.GA6569@dhcp-128-65.nay.redhat.com>
 <20191129152700.GA8286@weiser.dinsnail.net>
 <20191202085829.GA15808@dhcp-128-65.nay.redhat.com>
 <20191202090520.GA15874@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202090520.GA15874@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-dinsnail-net-MailScanner-Information: Please contact the ISP for more information
X-dinsnail-net-MailScanner-ID: xB300C2Y016385
X-dinsnail-net-MailScanner: Found to be clean
X-dinsnail-net-MailScanner-From: michael@weiser.dinsnail.net
X-Spam-Status: No
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Dave,

On Mon, Dec 02, 2019 at 05:05:20PM +0800, Dave Young wrote:

> > It seems a serious problem, the EFI modified memmap does not get an
> > /proc/iomem resource update, but kexec_file relies on /proc/iomem in
> > X86.
> > 
> > There is an question from Sai about why add_efi_memmap is not enabled by
> > default:
> > https://www.spinics.net/lists/linux-mm/msg185166.html

Incidentally, a data point I did not think to mention: I do boot the
kernel as EFI application directly from the firmware as a boot entry
with compiled in initrd and command line:

$ grep EFI nobak/kernel/linux/.config
CONFIG_EFI=y
CONFIG_EFI_STUB=y
# CONFIG_EFI_MIXED is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# EFI (Extensible Firmware Interface) Support
CONFIG_EFI_VARS=m
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=m
# CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_EFI_RCI2_TABLE is not set
# end of EFI (Extensible Firmware Interface) Support
CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_PARTITION=y
CONFIG_FB_EFI=y
CONFIG_EFIVAR_FS=y
# CONFIG_EFI_PGT_DUMP is not set

$ grep CMDLINE nobak/kernel/linux/.config
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE="root=UUID=97[...]e4 rd.luks.uuid=8a[...]c3 rd.luks.allow-discards=8a[...]c3 mem_sleep_default=deep resume=UUID=97[...]e4 resume_offset=96256 efi=debug memblock=debug"
CONFIG_CMDLINE_OVERRIDE=y
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_CMDLINE_PARTITION is not set
CONFIG_FB_CMDLINE=y

$ efibootmgr -v
BootCurrent: 000A
Timeout: 2 seconds
BootOrder: 000A,0009,0008,0005,0007,0006,0004,0002,0001,0000,0003
[...]
Boot0005* gentoo-5.4.0-next-20191127+-clear
HD(1,GPT,e7[...]f2,0x800,0x64000)/File(\kernel-5.4.0-next-20191127+-clear)
[...]
Boot000A* gentoo-5.4.1-gentoo
HD(1,GPT,e7[...]f2,0x800,0x64000)/File(\kernel-5.4.1-gentoo)

So there's no boot loader that could construct an e820 table for the
kernel to consume. I understand it's then up to the EFI stub to come up
with a e820 table from the EFI memory map.

> > Long time ago the add_efi_memmap is only enabled in case we explict
> > enable it on cmdline, I'm not sure if we can do it by default, maybe we
> > should.   Need opinion from X86 maintainers..
> > Can you try below diff see if it works for you? (not tested, and need
> > explicitly 'add_efi_memmap' in kernel cmdline param)

Neither adding add_efi_memmap nor adding your patch and setting that option
does make the ESRT memory region appear in /proc/iomem. kexec_file still
loads the kernel across the ESRT region.

What occurs to me is that nowhere does the ESRT memory region appear in
any externally provided memory map. Neither e820 nor EFI seem to declare
it. Is that expected or a bug of my particular system?

For example, the e820 map (derived from the EFI map by the EFI stub?)
has these regions:

BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff] reserved
BIOS-e820: [mem 0x0000000000100000-0x00000000763f5fff] usable
BIOS-e820: [mem 0x00000000763f6000-0x0000000079974fff] reserved
BIOS-e820: [mem 0x0000000079975000-0x00000000799f1fff] ACPI data
BIOS-e820: [mem 0x00000000799f2000-0x0000000079aa6fff] ACPI NVS
BIOS-e820: [mem 0x0000000079aa7000-0x000000007a40dfff] reserved
BIOS-e820: [mem 0x000000007a40e000-0x000000007a40efff] usable
BIOS-e820: [mem 0x000000007a40f000-0x000000007fffffff] reserved
BIOS-e820: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
BIOS-e820: [mem 0x0000000100000000-0x000000047dffffff] usable

The ESRT region sits smack in the middle of a large system RAM region:

BIOS-e820: [mem 0x0000000000100000-0x00000000763f5fff] usable

Consequently, the relevant part of /proc/iomem looks like this:

00000000-00000fff : Reserved
00001000-0009efff : System RAM
0009f000-000fffff : Reserved
  000a0000-000bffff : PCI Bus 0000:00
  000e0000-000e3fff : PCI Bus 0000:00
  000e4000-000e7fff : PCI Bus 0000:00
  000e8000-000ebfff : PCI Bus 0000:00
  000ec000-000effff : PCI Bus 0000:00
  000f0000-000fffff : PCI Bus 0000:00
    000f0000-000fffff : System ROM
00100000-763f5fff : System RAM
  65000000-6affffff : Crash kernel
763f6000-79974fff : Reserved
79975000-799f1fff : ACPI Tables
799f2000-79aa6fff : ACPI Non-volatile Storage
  79a17000-79a17fff : USBC000:00

What it would need to look like for kexec to leave ESRT alone, I guess, is:

00000000-00000fff : Reserved
00001000-0009efff : System RAM
0009f000-000fffff : Reserved
  000a0000-000bffff : PCI Bus 0000:00
  000e0000-000e3fff : PCI Bus 0000:00
  000e4000-000e7fff : PCI Bus 0000:00
  000e8000-000ebfff : PCI Bus 0000:00
  000ec000-000effff : PCI Bus 0000:00
  000f0000-000fffff : PCI Bus 0000:00
    000f0000-000fffff : System ROM
00100000-74dd1fff : System RAM         <---- split System RAM
  65000000-6affffff : Crash kernel
74dd2000-74dd2fff : Reserved           <---- ESRT
74dd3000-763f5fff : System RAM         <---- split System RAM
763f6000-79974fff : Reserved
79975000-799f1fff : ACPI Tables
799f2000-79aa6fff : ACPI Non-volatile Storage
  79a17000-79a17fff : USBC000:00

But since System RAM is set up from the e820 table very early on, the
e820 table would need to be patched before that or the already present
System RAM root resource split into three individual System
RAM/Reserved/System RAM root resources later. Correct?

I've played some more with the resource API and can now make /proc/iomem
look like this, with "EFI runtime" marked reserved:

00000000-00000fff : Reserved
00001000-0009efff : System RAM
0009f000-000fffff : Reserved
  000a0000-000bffff : PCI Bus 0000:00
  000e0000-000e3fff : PCI Bus 0000:00
  000e4000-000e7fff : PCI Bus 0000:00
  000e8000-000ebfff : PCI Bus 0000:00
  000ec000-000effff : PCI Bus 0000:00
  000f0000-000fffff : PCI Bus 0000:00
    000f0000-000fffff : System ROM
00100000-763f5fff : System RAM
  65000000-6affffff : Crash kernel
  74dd2000-74dd2fff : EFI runtime
763f6000-79974fff : Reserved
79975000-799f1fff : ACPI Tables
799f2000-79aa6fff : ACPI Non-volatile Storage
  79a17000-79a17fff : USBC000:00

But kexec_file seems to only look at the 00100000-763f5fff System RAM
root resource and still loads the kernel right across the ESRT region.
Or should it walk down the hierarchy and exclude reserved child nodes?

arm64 seems to have run into similar issues and solved them wholesale:
https://lkml.org/lkml/2018/6/19/131
https://elixir.bootlin.com/linux/v5.4.1/source/arch/arm64/kernel/setup.c#L249

I tried to apply that to x86:

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 3b9fd679cea9..458731f49484 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -295,6 +295,48 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 	efi_memmap_install(new_phys, num_entries);
 }
 
+static int __init efi_arch_mem_reserve_runtime(void)
+{
+	efi_memory_desc_t *md;
+	struct resource *res, *mem;
+	resource_size_t start, end;
+
+	for_each_efi_memory_desc(md) {
+		if (!(md->attribute & EFI_MEMORY_RUNTIME) &&
+		    (md->type == EFI_BOOT_SERVICES_CODE ||
+		     md->type == EFI_BOOT_SERVICES_DATA))
+			continue;
+
+		res = kzalloc(sizeof(*res), GFP_ATOMIC);
+		if (WARN_ON(!res))
+			return -ENOMEM;
+
+		start	= md->phys_addr;
+		end	= md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - 1;
+		res->start	= start;
+		res->end	= end;
+		res->name	= "EFI runtime";
+		res->flags	= IORESOURCE_MEM;
+
+		mem = request_resource_conflict(&iomem_resource, res);
+		/* all is well if there's no conflict */
+		if (!mem) {
+			pr_debug("Reserved io resource for runtime region 0x%llx-0x%llx\n",
+					start, end);
+			continue;
+		}
+		kfree(res);
+
+		/* otherwise go on to split up the conflicting region */
+		pr_debug("Splitting 0x%llx-0x%llx to reserve 0x%llx-0x%llx\n",
+				mem->start, mem->end, start, end);
+		reserve_region_with_split(mem, start, end, "EFI Runtime");
+	}
+
+	return 0;
+}
+arch_initcall(efi_arch_mem_reserve_runtime);
+
 /*
  * Helper function for efi_reserve_boot_services() to figure out if we
  * can free regions in efi_free_boot_services().

That comes back with these in dmesg:

[    0.190280] efi: Reserved io resource for runtime region 0xff000000-0xffffffff
[    0.190280] efi: Reserved io resource for runtime region 0xfee00000-0xfee00fff
[    0.190280] efi: Reserved io resource for runtime region 0xfed00000-0xfed03fff
[    0.190280] efi: Reserved io resource for runtime region 0xfec00000-0xfec00fff
[    0.190280] efi: Reserved io resource for runtime region 0xfe000000-0xfe010fff
[    0.190280] efi: Reserved io resource for runtime region 0xf0000000-0xf7ffffff
[    0.190280] efi: Reserved io resource for runtime region 0x7a317000-0x7a40dfff
[    0.190280] efi: Reserved io resource for runtime region 0x79aa7000-0x7a316fff
[    0.190280] efi: Splitting 0x100000-0x763f5fff to reserve 0x74dd2000-0x74dd2fff

... but still only end up with new child resources and kexec_file
still overwriting ESRT:

00000000-00000fff : Reserved
00001000-0009efff : System RAM
0009f000-000fffff : Reserved
  000a0000-000bffff : PCI Bus 0000:00
  000e0000-000e3fff : PCI Bus 0000:00
  000e4000-000e7fff : PCI Bus 0000:00
  000e8000-000ebfff : PCI Bus 0000:00
  000ec000-000effff : PCI Bus 0000:00
  000f0000-000fffff : PCI Bus 0000:00
    000f0000-000fffff : System ROM
00100000-763f5fff : System RAM
  65000000-6affffff : Crash kernel
  74dd2000-74dd2fff : EFI Runtime
763f6000-79974fff : Reserved
79975000-799f1fff : ACPI Tables
799f2000-79aa6fff : ACPI Non-volatile Storage
  79a17000-79a17fff : USBC000:00
79aa7000-7a40dfff : Reserved
  79aa7000-7a316fff : EFI runtime
  7a317000-7a40dfff : EFI runtime
7a40e000-7a40efff : System RAM

My kexec_file debugging currently looks like this:

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 79f252af7dee..3913129a6e22 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -542,6 +542,8 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
        if (end < kbuf->buf_min || start > kbuf->buf_max)
                return 0;
 
+       pr_debug("Considering 0x%llx-0x%llx\n", start, end);
+
        /*
         * Allocate memory top down with-in ram range. Otherwise bottom up
         * allocation.

... and outputs:

[ 1103.941425] kexec-bzImage64: Loaded purgatory at 0x98000
[ 1103.941428] kexec_file: Considering 0x1000-0x9efff
[ 1103.941428] kexec-bzImage64: Loaded boot_param, command line and misc at 0x96000 bufsz=0x1240 memsz=0x1240
[ 1103.941429] kexec_file: Considering 0x100000-0x763f5fff
[ 1103.941430] kexec-bzImage64: Loaded 64bit kernel at 0x73000000 bufsz=0x1140888 memsz=0x24b7000
[ 1103.941430] kexec-bzImage64: Final command line is: 
[ 1104.017909] kexec_file: Loading segment 0: buf=0x00000000d7398bfe bufsz=0x5000 mem=0x98000 memsz=0x6000
[ 1104.017936] kexec_file: Loading segment 1: buf=0x000000007238663b bufsz=0x1240 mem=0x96000 memsz=0x2000
[ 1104.017938] kexec_file: Loading segment 2: buf=0x00000000bb108eb1 bufsz=0x1140888 mem=0x73000000 memsz=0x24b7000
-- 
Thank you for your patience,
Michael
