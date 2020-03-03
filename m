Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60225177C14
	for <lists+linux-efi@lfdr.de>; Tue,  3 Mar 2020 17:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgCCQj5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Mar 2020 11:39:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:48958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729414AbgCCQj4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Mar 2020 11:39:56 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B959421739
        for <linux-efi@vger.kernel.org>; Tue,  3 Mar 2020 16:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583253596;
        bh=zhaz8a1PzXVqJb9FuQ3w7HBH+VPURj1yIscuvDbYu+0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kPQa1/p3XwXvjfOHz8UPbUkwjOnBMbPI7fviNZJ+lUqL8kZH0ASN37vgy7iS7aNYY
         pe1e9oRbQOiLcuRNkKY11bYAhaRvpnv7V1d1HmxbLQ4VDnzHAT76isGbvPCj159wvj
         EzgpY0vHLJ1ZYtVRHaLgwRVA/w0S4EEZndvayeOc=
Received: by mail-wr1-f41.google.com with SMTP id z15so5240301wrl.1
        for <linux-efi@vger.kernel.org>; Tue, 03 Mar 2020 08:39:55 -0800 (PST)
X-Gm-Message-State: ANhLgQ0cZm0JN6DK1JT1Q2OWqYf9wIueZIkHuL+D6hyIRVWXrc0Wlk6Z
        zE+xLxmBF86KaXh2SVxWOb767J7IoZhSuGGKpDoSMQ==
X-Google-Smtp-Source: ADFU+vt4EfLydKMEgMYMNgyv3Ag29X1i9U4pWNpNDke5qphoNlBNkLBHVSaINpPY6XjJKVoZ3ER6Xr3q/f5Ge3cr+Ok=
X-Received: by 2002:a5d:6051:: with SMTP id j17mr6185289wrt.151.1583253594066;
 Tue, 03 Mar 2020 08:39:54 -0800 (PST)
MIME-Version: 1.0
References: <20200216182334.8121-1-ardb@kernel.org> <20200216182334.8121-17-ardb@kernel.org>
 <20200303160353.GA20372@roeck-us.net>
In-Reply-To: <20200303160353.GA20372@roeck-us.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 3 Mar 2020 17:39:43 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_dG2dsrNBWG3fV5S40y6iRGSj7MO2gbtZhqEUg5mXgyQ@mail.gmail.com>
Message-ID: <CAKv+Gu_dG2dsrNBWG3fV5S40y6iRGSj7MO2gbtZhqEUg5mXgyQ@mail.gmail.com>
Subject: Re: [PATCH 16/18] efi: add 'runtime' pointer to struct efi
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 3 Mar 2020 at 17:03, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Sun, Feb 16, 2020 at 07:23:32PM +0100, Ard Biesheuvel wrote:
> > Instead of going through the EFI system table each time, just copy the
> > runtime services table pointer into struct efi directly. This is the
> > last use of the system table pointer in struct efi, allowing us to
> > drop it in a future patch, along with a fair amount of quirky handling
> > of the translated address.
> >
> > Note that usually, the runtime services pointer changes value during
> > the call to SetVirtualAddressMap(), so grab the updated value as soon
> > as that call returns. (Mixed mode uses a 1:1 mapping, and kexec boot
> > enters with the updated address in the system table, so in those cases,
> > we don't need to do anything here)
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> This patch results in a crash with i386 efi boots if PAE (CONFIG_HIGHMEM64G=y)
> is enabled. Bisect and crash logs attached. There is also a warning which
> I don't recall seeing before, but it may not be caused by this patch
> (I didn' bisect the warning). The warning is seen with all i386:efi boots,
> not only when PAE is enabled. The warning log is also attached.
>
> Guenter
>
> ---
> Qemu command line:
>
> qemu-system-i386 -kernel arch/x86/boot/bzImage -M pc -cpu Westmere \
>         -no-reboot -m 256 -snapshot \
>         -bios OVMF-pure-efi-32.fd \
>         -usb -device usb-storage,drive=d0 \
>         -drive file=rootfs.ext2,if=none,id=d0,format=raw \
>         --append 'earlycon=uart8250,io,0x3f8,9600n8 panic=-1 slub_debug=FZPUA root=/dev/sda rootwait mem=256M console=ttyS0' \
>         -nographic
>

I am failing to reproduce this. Do you have a .config and a copy of
OVMF-pure-efi-32.fd anywhere?


> ---
> # bad: [e78aa714e3261e23c7413fd6e719820e271ff128] Add linux-next specific files for 20200303
> # good: [98d54f81e36ba3bf92172791eba5ca5bd813989b] Linux 5.6-rc4
> git bisect start 'HEAD' 'v5.6-rc4'
> # good: [a2a09dd01b6aa08d10393c8d917de75787e3132e] Merge remote-tracking branch 'crypto/master'
> git bisect good a2a09dd01b6aa08d10393c8d917de75787e3132e
> # good: [5a8e63833f9ef8c26c42220a839bbb9687bfe71b] Merge remote-tracking branch 'spi/for-next'
> git bisect good 5a8e63833f9ef8c26c42220a839bbb9687bfe71b
> # bad: [e02ce27a4ed5d49b92cc5269c15a1acdd9bacd9b] Merge remote-tracking branch 'thunderbolt/next'
> git bisect bad e02ce27a4ed5d49b92cc5269c15a1acdd9bacd9b
> # bad: [943cba4a99fe46ebca32b66bedb867fddeff9a7b] Merge remote-tracking branch 'edac/edac-for-next'
> git bisect bad 943cba4a99fe46ebca32b66bedb867fddeff9a7b
> # good: [a47d8a0913d007555df3cde040091305878b45b1] Merge branch 'locking/kcsan'
> git bisect good a47d8a0913d007555df3cde040091305878b45b1
> # bad: [fe4db90a80cd12ebe4efe385d40d6636330149ed] efi: Add support for EFI_RT_PROPERTIES table
> git bisect bad fe4db90a80cd12ebe4efe385d40d6636330149ed
> # good: [0255973bd6e471e1c34284328098bfab89840df3] efi/libstub: Describe efi_relocate_kernel()
> git bisect good 0255973bd6e471e1c34284328098bfab89840df3
> # good: [686312927b13fc30b23b0e0f9be097c292343048] efi/ia64: Switch to efi_config_parse_tables()
> git bisect good 686312927b13fc30b23b0e0f9be097c292343048
> # bad: [223e3ee56f77570157aba8cc550208af430a869b] efi/x86: add headroom to decompressor BSS to account for setup block
> git bisect bad 223e3ee56f77570157aba8cc550208af430a869b
> # good: [9cd437ac0ef4f324a92e2579784b03bb487ae7fb] efi/x86: Make fw_vendor, config_table and runtime sysfs nodes x86 specific
> git bisect good 9cd437ac0ef4f324a92e2579784b03bb487ae7fb
> # bad: [59f2a619a2db86111e8bb30f349aebff6eb75baa] efi: Add 'runtime' pointer to struct efi
> git bisect bad 59f2a619a2db86111e8bb30f349aebff6eb75baa
> # good: [09308012d8546dda75e96c02bed19e2ba1e875fd] efi/x86: Merge assignments of efi.runtime_version
> git bisect good 09308012d8546dda75e96c02bed19e2ba1e875fd
> # first bad commit: [59f2a619a2db86111e8bb30f349aebff6eb75baa] efi: Add 'runtime' pointer to struct efi
>
> ---
> Crash:
>
> [    1.022602] ------------[ cut here ]------------
> [    1.022602] kernel BUG at arch/x86/mm/pat/set_memory.c:348!
> [    1.022602] invalid opcode: 0000 [#1] SMP PTI
> [    1.022602] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.6.0-rc4-next-20200303 #1
> [    1.022602] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> [    1.022602] EIP: change_page_attr_set_clr+0x26c/0x280
> [    1.022602] Code: c1 eb 05 c1 e8 03 83 e0 03 09 c3 0f b6 9b 40 89 83 c8 85 db 0f 95 45 a3 e9 b1 fe ff ff 80 3d 88 ef 93 c8 00 0f 85 b7 fe ff ff <0f> 0b e8 6d 8b 00 00 8d b4 26 00 00 00 00 8d b6 00 00 00 00 55 89
> [    1.022602] EAX: 00000046 EBX: 00000000 ECX: 00000000 EDX: 00000000
> [    1.022602] ESI: 00000000 EDI: 00000000 EBP: c880fef4 ESP: c880fe94
> [    1.022602] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00000046
> [    1.022602] CR0: 80050033 CR2: ffbff000 CR3: 08a36000 CR4: 000006b0
> [    1.022602] Call Trace:
> [    1.022602]  ? memremap+0x1d/0x1b0
> [    1.022602]  set_memory_x+0x39/0x40
> [    1.022602]  efi_set_executable+0x5a/0x68
> [    1.022602]  runtime_code_page_mkexec+0x2e/0x39
> [    1.022602]  efi_runtime_update_mappings+0x11/0x14
> [    1.022602]  efi_enter_virtual_mode+0x36c/0x388
> [    1.022602]  start_kernel+0x3b7/0x443
> [    1.022602]  i386_start_kernel+0x43/0x45
> [    1.022602]  startup_32_smp+0x164/0x168
> [    1.022602] Modules linked in:
> [    1.022602] ---[ end trace 9d84af499f5da089 ]---
> [    1.022602] EIP: change_page_attr_set_clr+0x26c/0x280
> [    1.022602] Code: c1 eb 05 c1 e8 03 83 e0 03 09 c3 0f b6 9b 40 89 83 c8 85 db 0f 95 45 a3 e9 b1 fe ff ff 80 3d 88 ef 93 c8 00 0f 85 b7 fe ff ff <0f> 0b e8 6d 8b 00 00 8d b4 26 00 00 00 00 8d b6 00 00 00 00 55 89
> [    1.022602] EAX: 00000046 EBX: 00000000 ECX: 00000000 EDX: 00000000
> [    1.022602] ESI: 00000000 EDI: 00000000 EBP: c880fef4 ESP: c880fe94
> [    1.022602] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00000046
> [    1.022602] CR0: 80050033 CR2: ffbff000 CR3: 08a36000 CR4: 000006b0
> [    1.022602] Kernel panic - not syncing: Attempted to kill the idle task!
>
> ---
> Warning:
>
> [    0.645996] ------------[ cut here ]------------
> [    0.645996] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/traps.c:811 do_debug+0x161/0x1e0
> [    0.645996] Modules linked in:
> [    0.645996] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.0-rc4-next-20200303 #1
> [    0.645996] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> [    0.645996] EIP: do_debug+0x161/0x1e0
> [    0.645996] Code: 84 2b ff ff ff eb da 66 90 e8 cb 89 0c 00 e9 35 ff ff ff 8d b6 00 00 00 00 0f b7 53 34 83 e2 03 66 83 fa 03 0f 84 79 ff ff ff <0f> 0b 80 e4 bf 89 86 3c 0d 00 00 f0 80 0e 10 81 63 38 ff fe ff ff
> [    0.645996] EAX: 00004000 EBX: cd3f9ec8 ECX: 00000000 EDX: 00000000
> [    0.645996] ESI: cd408e80 EDI: 00004000 EBP: cd3f9ec0 ESP: cd3f9ea4
> [    0.645996] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00000093
> [    0.645996] CR0: 80050033 CR2: ffd19000 CR3: 0d615000 CR4: 00000690
> [    0.645996] Call Trace:
> [    0.645996]  ? do_error_trap+0xd0/0xd0
> [    0.645996]  common_exception+0x147/0x162
> [    0.645996] EIP: trace_hardirqs_off+0x0/0x100
> [    0.645996] Code: e8 85 3b f9 ff 8b 55 ec b8 60 34 43 cd e8 68 a1 f8 ff 64 ff 0d e4 47 5f cd 8b 5d 04 e9 49 ff ff ff 0f 0b eb 91 8d 74 26 00 90 <55> 89 e5 57 56 53 83 ec 08 64 a1 70 6e 60 cd 85 c0 0f 85 95 00 00
> [    0.645996] EAX: 00000000 EBX: 000001e0 ECX: d0863f10 EDX: 80050033
> [    0.645996] ESI: 00000000 EDI: 00000030 EBP: cd3f9f48 ESP: cd3f9f24
> [    0.645996] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 000001c2
> [    0.645996]  ? do_error_trap+0xd0/0xd0
> [    0.645996]  ? trace_hardirqs_on_caller+0x100/0x100
> [    0.645996]  ? efi_set_virtual_address_map+0x7d/0xb8
> [    0.645996]  efi_enter_virtual_mode+0x340/0x380
> [    0.645996]  start_kernel+0x3a6/0x432
> [    0.645996]  i386_start_kernel+0x43/0x45
> [    0.645996]  startup_32_smp+0x164/0x168
> [    0.645996] irq event stamp: 3346
> [    0.645996] hardirqs last  enabled at (3345): [<cc3e6ba5>] __slab_alloc.constprop.99+0x45/0x60
> [    0.645996] hardirqs last disabled at (3346): [<cd568df9>] efi_set_virtual_address_map+0x51/0xb8
> [    0.645996] softirqs last  enabled at (3298): [<ccf3c155>] __do_softirq+0x2c5/0x3bb
> [    0.645996] softirqs last disabled at (3291): [<cc21fafd>] call_on_stack+0xd/0x50
> [    0.645996] ---[ end trace 4d4ba9fe34c1e861 ]---
>
