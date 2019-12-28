Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53C2B12BF43
	for <lists+linux-efi@lfdr.de>; Sat, 28 Dec 2019 21:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfL1UyX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 Dec 2019 15:54:23 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37325 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfL1UyX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 28 Dec 2019 15:54:23 -0500
Received: by mail-io1-f66.google.com with SMTP id k24so19789434ioc.4;
        Sat, 28 Dec 2019 12:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E76VhA6+/ZrBIyRCsnWyOQg6YbJeoiHUNcjR94zQd3I=;
        b=E5DDVujOnEp57q7i/BSeK3GVw5XBqaB5InXyuR9+JC9MoAnOW/YC/lPcWcxr0mGQGh
         L5n6q5e89ePMOLn8nUeTJoy2ECnr4q6Z3dWtqFPrRp8KGmGTZgC8p+Pp5SL+aU/T9EyB
         TTyzbB+Zq2CWFvPj/SUjqzZ7DT7uejeP/BrtT64i7dFInZRLL3CaSXcTJ1YN6K/0WU4d
         bnYG9KAOWHyqm0h5MJZrSDAAvpxqSUxo5scFV+/D4LuokGSEooJqHUx19Z5/ilPzwomP
         EK3oGUGTdJCoNZSfgkYX/d0A7mO47CMqCeqrS/yMv4vnzBzoJX9wjZDHiCBAhLwtEbtY
         jYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E76VhA6+/ZrBIyRCsnWyOQg6YbJeoiHUNcjR94zQd3I=;
        b=tAGXaUv5RvJ8EczQsa6C8yeCKAfktYpsZEpo7oCbehTwWgAWNFEBLqjmppcxk8VDkW
         jVia8O61jXypi9Zk/py03l3iXckToCsixoMzXWceQOGJeha+REb3M62vl1axgdMu1fVh
         K64H8QC90x1AY9UqPhjZBMkF2DpdT0sfwNyWitHGaitjbDIrXsA4nMB7Ve/9w6G0UuQ1
         i7Z1EiijSJxHRibnEJMa3nQxSy1GmYohdaPkA6xMyqei3KB1UCrPBU0IQS2MeVtKSz7f
         lOSw0py+7W/UczyUm5v/6zD7M/Va9RVciWfd1hAC8/0mgZ6F8MSfDKAGaCrxjhpz2v/W
         BuRA==
X-Gm-Message-State: APjAAAXj2LaDjNjNfBG4tQT67iVrbbtu+K2teXykL/082FV5cPk8HLkc
        RE/dvWdcaBHst9e+2ltg9MmCZG40kRs1LAaCTvU=
X-Google-Smtp-Source: APXvYqxQVMMkZRR9L3by6JE1ApXMMCe9ngnyrh6hZRYHV7R0mSIR3UoEtpISeD0e1Po99FUkul6VtibYqggIVtNDLBI=
X-Received: by 2002:a6b:d219:: with SMTP id q25mr26334114iob.49.1577566462461;
 Sat, 28 Dec 2019 12:54:22 -0800 (PST)
MIME-Version: 1.0
References: <20191204075233.GA10520@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20191204075233.GA10520@dhcp-128-65.nay.redhat.com>
From:   Dan Williams <dan.j.williams.korg@gmail.com>
Date:   Sat, 28 Dec 2019 12:54:11 -0800
Message-ID: <CANTgghnsdijH90qnm24qat70T7FA5qOwmnXXt+NYVxHYa4SLJA@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: update e820 about reserved EFI boot services
 data to fix kexec breakage
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Weiser <michael@weiser.dinsnail.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kexec@lists.infradead.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, dan.j.williams@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Dec 3, 2019 at 11:53 PM Dave Young <dyoung@redhat.com> wrote:
>
> Michael Weiser reported he got below error during a kexec rebooting:
> esrt: Unsupported ESRT version 2904149718861218184.
>
> The ESRT memory stays in EFI boot services data, and it was reserved
> in kernel via efi_mem_reserve().  The initial purpose of the reservation
> is to reuse the EFI boot services data across kexec reboot. For example
> the BGRT image data and some ESRT memory like Michael reported.
>
> But although the memory is reserved it is not updated in X86 e820 table.
> And kexec_file_load iterate system ram in io resource list to find places
> for kernel, initramfs and other stuff. In Michael's case the kexec loaded
> initramfs overwritten the ESRT memory and then the failure happened.
>
> Since kexec_file_load depends on the e820 to be updated, just fix this
> by updating the reserved EFI boot services memory as reserved type in e820.
>
> Originally any memory descriptors with EFI_MEMORY_RUNTIME attribute are
> bypassed in the reservation code path because they are assumed as reserved.
> But the reservation is still needed for multiple kexec reboot.
> And it is the only possible case we come here thus just drop the code
> chunk then everything works without side effects.
>
> On my machine the ESRT memory sits in an EFI runtime data range, it does
> not trigger the problem, but I successfully tested with BGRT instead.
> both kexec_load and kexec_file_load work and kdump works as well.
>
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  arch/x86/platform/efi/quirks.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> --- linux-x86.orig/arch/x86/platform/efi/quirks.c
> +++ linux-x86/arch/x86/platform/efi/quirks.c
> @@ -260,10 +260,6 @@ void __init efi_arch_mem_reserve(phys_ad
>                 return;
>         }
>
> -       /* No need to reserve regions that will never be freed. */
> -       if (md.attribute & EFI_MEMORY_RUNTIME)
> -               return;
> -
>         size += addr % EFI_PAGE_SIZE;
>         size = round_up(size, EFI_PAGE_SIZE);
>         addr = round_down(addr, EFI_PAGE_SIZE);
> @@ -293,6 +289,8 @@ void __init efi_arch_mem_reserve(phys_ad
>         early_memunmap(new, new_size);
>
>         efi_memmap_install(new_phys, num_entries);
> +       e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> +       e820__update_table(e820_table);
>  }
>
>  /*
>

Bisect says this change (commit af1648984828) is triggering a
regression, likely not urgent, in my testing of the new efi_fake_mem=
facility to allow memory to be marked "soft reserved" via the kernel
command line (commit 199c84717612 x86/efi: Add efi_fake_mem support
for EFI_MEMORY_SP). The following command line triggers the crash
signature below:

    efi_fake_mem=4G@9G:0x40000,4G@13G:0x40000

However, this command line works ok:

    efi_fake_mem=8G@9G:0x40000

So, something about multiple efi_fake_mem statements interacts badly
with this change. Nothing obvious occurs to me at the moment, I'll
keep debugging, but wanted to highlight this in the meantime in case
someone else sees a deeper issue or the root cause.

BUG: unable to handle page fault for address: ffffffffff281000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 188615067 P4D 188615067 PUD 188617067 PMD 188e4d067 PTE 0
Oops: 0002 [#1] SMP PTI
CPU: 0 PID: 0 Comm: swapper Not tainted 5.4.0+ #154
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
RIP: 0010:efi_memmap_insert+0xed/0x14b
Code: 48 89 48 18 49 39 d9 76 67 49 39 d1 73 62 4c 89 c9 48 2b 48 08
4c 89 c6 48 c1 e9 0c 48 89 48 18 49 8b 4a 28 48 01 c8 48 89 c7 <f3> a4
49 39 d3 73 2c 4c 89 48 08 4c 29 da 4c 89 c6 4c 89 68 18 48
RSP: 0000:ffffffffb7603d70 EFLAGS: 00010086
RAX: ffffffffff280ff0 RBX: 0000000000000000 RCX: 0000000000000020
RDX: ffffffffffffffff RSI: ffffffffff200fe0 RDI: ffffffffff281000
RBP: 00000000bea2d000 R08: ffffffffff200fd0 R09: 00000000bea06000
R10: ffffffffb77e1718 R11: 00000000bea2cfff R12: 800000000000000f
R13: 0000000000000027 R14: ffffffff415fa001 R15: 0000000000000ab0
FS:  0000000000000000(0000) GS:ffffffffb7c31000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff281000 CR3: 0000000188610000 CR4: 00000000000606b0
Call Trace:
 ? efi_arch_mem_reserve+0x149/0x1a6
 ? bgrt_init+0xbe/0xbe
 ? bgrt_init+0xbe/0xbe
 ? acpi_parse_bgrt+0xa/0xd
 ? acpi_table_parse+0x86/0xb8
 ? acpi_boot_init+0x494/0x4e3
 ? acpi_parse_x2apic+0x87/0x87
 ? setup_acpi_sci+0xa2/0xa2
 ? setup_arch+0x8db/0x9e1
 ? start_kernel+0x6a/0x547
 ? secondary_startup_64+0xb6/0xc0
Modules linked in:
CR2: ffffffffff281000
random: get_random_bytes called from print_oops_end_marker+0x26/0x40
with crng_init=0
---[ end trace 2acc14aa0990ee9d ]---
RIP: 0010:efi_memmap_insert+0xed/0x14b
Code: 48 89 48 18 49 39 d9 76 67 49 39 d1 73 62 4c 89 c9 48 2b 48 08
4c 89 c6 48 c1 e9 0c 48 89 48 18 49 8b 4a 28 48 01 c8 48 89 c7 <f3> a4
49 39 d3 73 2c 4c 89 48 08 4c 29 da 4c 89 c6 4c 89 68 18 48
RSP: 0000:ffffffffb7603d70 EFLAGS: 00010086
RAX: ffffffffff280ff0 RBX: 0000000000000000 RCX: 0000000000000020
RDX: ffffffffffffffff RSI: ffffffffff200fe0 RDI: ffffffffff281000
RBP: 00000000bea2d000 R08: ffffffffff200fd0 R09: 00000000bea06000
R10: ffffffffb77e1718 R11: 00000000bea2cfff R12: 800000000000000f
R13: 0000000000000027 R14: ffffffff415fa001 R15: 0000000000000ab0
FS:  0000000000000000(0000) GS:ffffffffb7c31000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff281000 CR3: 0000000188610000 CR4: 00000000000606b0
Kernel panic - not syncing: Fatal exception
---[ end Kernel panic - not syncing: Fatal exception ]---
