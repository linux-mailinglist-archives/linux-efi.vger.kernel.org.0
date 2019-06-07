Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1BC3883C
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jun 2019 12:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfFGKtr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jun 2019 06:49:47 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36932 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbfFGKtq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jun 2019 06:49:46 -0400
Received: by mail-it1-f196.google.com with SMTP id x22so2011684itl.2
        for <linux-efi@vger.kernel.org>; Fri, 07 Jun 2019 03:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I/JTLA6/7OOAaaoex5UCu2ynbpUPxwIBhxflP5UrGHU=;
        b=u49dIX3ZJ35qqCXpH5FiFnT3Hb1Xlyrn6gHwsYLpglkAls5Qph1NLtnHEfLxn/Jxap
         CJJfx4obCsXYwteINFYV5l5AY71v64wrirmd5tDWfgrcDA6GAws5LR5WCq/Xcd/79zip
         YOzy7ZbDX3EGVhx7uczLqSI5DJ3dtsFee26XuPPIbZAfcSS2d0r+NgAn5xAhVVmXhmNM
         7Mncz9upQ/ctXMKNKkR6JHjtsfhtxoD1VAbwNs+tXspf78jjUVxq/c0uXS1Gj93POPar
         03dEm3zYrLx4xM6pyo8go72vmFGn1ucwNX9LMF2Vw5uoLg3jNg8rXQ+c0+himx+Wt2zI
         f4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I/JTLA6/7OOAaaoex5UCu2ynbpUPxwIBhxflP5UrGHU=;
        b=Akl9a4Iu38qSsshCw0xM9mi5zITRNeGJecnPe0qbeZftVX2iAvdJnROfnPqvrkXdg2
         nLrPym1XnD4gTBEgte2LJMtQzB9Be709gsjPEqMijD+oF5yP1scPkxvCLzc5ymRA0CJa
         rmshYhhX5Ha4nIRykjEdMX88RaflX1iDm1zw9tNNHeAhrgkLDoLW/ri9FLMZzlv0g+kA
         uwvYR9vTa75C+htfhDbijU7EcmU1sct524MUFRJzcph9ZrBIPC4nJwht+DSyZD6Rp0Er
         afbGjjXPSYJ1TGBXjhn3fd5NBmj9aryGo3HvBKIESoYLKnAV1bMgFpDnnzmR5WFS81gG
         muyg==
X-Gm-Message-State: APjAAAXtkQpyWGFbHVFGZvmbJejty3Y1qwcLgItGfmseUyuw6/Le6IuG
        5J6dcSaWjFAG8uOibt5y+zOq7JQMrTdwK/EMFIWOFQ==
X-Google-Smtp-Source: APXvYqzV83bdDFVyW1WsitiOkR3pNAtqL9y9oVUED5/9AyQP4CR2syRQ/FTgvdFu7BOy4Bp2F9xf8HpsssZ6oTq2vug=
X-Received: by 2002:a24:4f88:: with SMTP id c130mr3417742itb.104.1559904585385;
 Fri, 07 Jun 2019 03:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <d812f073-67b2-ca7a-616c-7c440716885c@broadcom.com>
 <CACi5LpO0Qj7-h-mgdEAwBz+Mfyhuac=MNPERz09KTv1cXYqSLQ@mail.gmail.com> <dd677822-8451-2fdf-79b3-0a3662974080@broadcom.com>
In-Reply-To: <dd677822-8451-2fdf-79b3-0a3662974080@broadcom.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 7 Jun 2019 12:49:34 +0200
Message-ID: <CAKv+Gu8KJ+shcnXiwBbPDzEFFTw9JhRGz8806o5mQkOX+wPcdA@mail.gmail.com>
Subject: Re: gicv3-its driver crashes in crash dump kernel
To:     Jonathan Richardson <jonathan.richardson@broadcom.com>
Cc:     Bhupesh Sharma <bhsharma@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ray Jui <ray.jui@broadcom.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 6 Jun 2019 at 23:52, Jonathan Richardson
<jonathan.richardson@broadcom.com> wrote:
>
> On 06/06/2019 02:07 PM, Bhupesh Sharma wrote:
> > Hi,
> >
> > On Thu, Jun 6, 2019 at 3:45 AM Jonathan Richardson
> > <jonathan.richardson@broadcom.com> wrote:
> >>
> >> Hi,
> >>
> >> As of the 5.0 kernel we're seeing the crash dump kernel crash when the gicv3-its driver calls gic_reserve_range():
> >>
> >> root@bcm958804a8040c:~# echo c > /proc/sysrq-trigger
> >> [ 2285.405357] sysrq: SysRq : Trigger a crash
> >> [ 2285.409592] Kernel panic - not syncing: sysrq triggered crash
> >> [ 2285.415521] CPU: 0 PID: 4064 Comm: sh Kdump: loaded Tainted: G O 5.0.0 #1
> >> [ 2285.423867] Hardware name: BRCM BRCM-SR/BRCM-SR, BIOS 0.1 Apr 26 2019
> >> [ 2285.430510] Call trace:
> >> [ 2285.433041] dump_backtrace+0x0/0x1a0
> >> [ 2285.436818] show_stack+0x14/0x20
> >> [ 2285.440237] dump_stack+0x90/0xb4
> >> [ 2285.443657] panic+0x13c/0x2ec
> >> [ 2285.446807] sysrq_handle_crash+0x14/0x18
> >> [ 2285.450942] __handle_sysrq+0xa4/0x190
> >> [ 2285.454808] write_sysrq_trigger+0x64/0x80
> >> [ 2285.459034] proc_reg_write+0x60/0xa8
> >> [ 2285.462812] __vfs_write+0x30/0x180
> >> [ 2285.466409] vfs_write+0xa4/0x1b8
> >> [ 2285.469827] ksys_write+0x60/0xd8
> >> [ 2285.473246] __arm64_sys_write+0x14/0x20
> >> [ 2285.477292] el0_svc_common+0x60/0x100
> >> [ 2285.481158] el0_svc_handler+0x2c/0x88
> >> [ 2285.485025] el0_svc+0x8/0xc
> >> [ 2285.488001] SMP: stopping secondary CPUs
> >> [ 2285.492349] Starting crashdump kernel...
> >> [ 2285.496395] Bye!
> >> [ 0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd083]
> >> [ 0.000000] Linux version 5.0.0 (oe-user@oe-host) (gcc version 7.3.0 (GCC)) #1 SMP Fri Apr 26 03:06:15 UTC9
> >> [ 0.000000] Machine model: Stingray PS1100R (BCM958804A8040)
> >> [ 0.000000] earlycon: uart8250_log0 at MMIO32 0x0000000068a10000 (options '')
> >> [ 0.000000] printk: bootconsole [uart8250_log0] enabled
> >> [ 0.000000] Malformed early option 'loglevel'
> >> [ 0.000000] efi: Getting EFI parameters from FDT:
> >> [ 0.000000] efi: EFI v2.70 by EDK II
> >> [ 0.000000] efi: SMBIOS=0x85cd0000 SMBIOS 3.0=0x85a20000 ACPI 2.0=0x85d90000 MEMATTR=0x89352018 MEMRE
> >> [ 0.000000] cannot allocate crashkernel (size:0x20000000)
> >> [ 0.000000] Reserving 2KB of memory at 0xffdff000 for elfcorehdr
> >> [ 0.000000] cma: Failed to reserve 1024 MiB
> >> [ 0.000000] psci: probing for conduit method from DT.
> >> I: GICv3 without legacy support detected. ARM GICV3 driver initialized in EL3
> >> 0.000000] psci: PSCIv1.1 detected in firmware.
> >> [ 0.000000] psci: Using standard PSCI v0.2 function IDs
> >> [ 0.000000] psci: MIGRATE_INFO_TYPE not supported.
> >> [ 0.000000] psci: SMC Calling Convention v1.1
> >> [ 0.000000] random: get_random_bytes called from start_kernel+0xa8/0x3ec with crng_init=0
> >> [ 0.000000] percpu: Embedded 23 pages/cpu @(____ptrval____) s53784 r8192 d32232 u94208
> >> [ 0.000000] Detected PIPT I-cache on CPU0
> >> [ 0.000000] CPU features: detected: EL2 vector hardening
> >> [ 0.000000] Speculative Store Bypass Disable mitigation not required
> >> [ 0.000000] Built 1 zonelists, mobility grouping on. Total pages: 130974
> >> [ 0.000000] Kernel command line: FS2:\Image.1 root=/dev/mmcblk0p3 rw rootwait earlycon=uart8250_log,mmio1
> >> [ 0.000000] Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
> >> [ 0.000000] Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
> >> [ 0.000000] Memory: 472776K/532212K available (9340K kernel code, 734K rwdata, 3412K rodata, 832K init, 35)
> >> [ 0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
> >> [ 0.000000] rcu: Hierarchical RCU implementation.
> >> [ 0.000000] rcu: RCU event tracing is enabled.
> >> [ 0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> >> [ 0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> >> [ 0.000000] GICv3: GIC: Using split EOI/Deactivate mode
> >> [ 0.000000] GICv3: Distributor has no Range Selector support
> >> [ 0.000000] GICv3: no VLPI support, no direct LPI support
> >> [ 0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000000063e00000
> >> [ 0.000000] ITS [mem 0x63c20000-0x63c2ffff]
> >> [ 0.000000] ITS@0x0000000063c20000: allocated 65536 Devices @fd480000 (flat, esz 8, psz 64K, shr 0)
> >> [ 0.000000] ITS: using cache flushing for cmd queue
> >> [ 0.000000] Unable to handle kernel paging request at virtual address ffff800975c36004
> >> [ 0.000000] Mem abort info:
> >> [ 0.000000] ESR = 0x96000005
> >> [ 0.000000] Exception class = DABT (current EL), IL = 32 bits
> >> [ 0.000000] SET = 0, FnV = 0
> >> [ 0.000000] EA = 0, S1PTW = 0
> >> [ 0.000000] Data abort info:
> >> [ 0.000000] ISV = 0, ISS = 0x00000005
> >> [ 0.000000] CM = 0, WnR = 0
> >> [ 0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
> >> [ 0.000000] [ffff800975c36004] pgd=00000000ffdf8003, pud=0000000000000000
> >> [ 0.000000] Internal error: Oops: 96000005 [#1] SMP
> >> [ 0.000000] Modules linked in:
> >> [ 0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.0.0 #1
> >> [ 0.000000] Hardware name: Stingray PS1100R (BCM958804A8040) (DT)
> >> [ 0.000000] pstate: 60000085 (nZCv daIf -PAN -UAO)
> >> [ 0.000000] pc : efi_mem_reserve_persistent+0x60/0x1b8
> >> [ 0.000000] lr : efi_mem_reserve_persistent+0x1a0/0x1b8
> >> [ 0.000000] sp : ffff000010dd3c30
> >> [ 0.000000] x29: ffff000010dd3c30 x28: ffff80007d409200
> >> [ 0.000000] x27: ffff000010eca000 x26: 0000000000000008
> >> [ 0.000000] x25: ffff000010060000 x24: 0000000000000000
> >> [ 0.000000] x23: 0000000000010000 x22: ffff000010c96000
> >> [ 0.000000] x21: 00000000fd450000 x20: 0000000000010000
> >> [ 0.000000] x19: ffff000010eca000 x18: ffffffffffffffff
> >> [ 0.000000] x17: 0000000000000000 x16: 0000000000000000
> >> [ 0.000000] x15: ffff000010ddc688 x14: ffff80007d4334b5
> >> [ 0.000000] x13: ffff000010c96000 x12: ffff000010005fff
> >> [ 0.000000] x11: ffff000010005000 x10: 0000000085f84000
> >> [ 0.000000] x9 : 0000000000000000 x8 : 0040000000000001
> >> [ 0.000000] x7 : ffff000010005000 x6 : ffff000010c96000
> >> [ 0.000000] x5 : ffff80007fdfd408 x4 : ffff000010005fff
> >> [ 0.000000] x3 : ffff800975c36000 x2 : 0000000080000000
> >> [ 0.000000] x1 : ffff000010005018 x0 : 0000000000000000
> >> [ 0.000000] Process swapper/0 (pid: 0, stack limit = 0x(____ptrval____))
> >> [ 0.000000] Call trace:
> >> [ 0.000000] efi_mem_reserve_persistent+0x60/0x1b8
> >> [ 0.000000] its_init+0xa58/0xe98
> >> [ 0.000000] gic_of_init+0x478/0x4d4
> >> [ 0.000000] of_irq_init+0x19c/0x2f4
> >> [ 0.000000] irqchip_init+0x14/0x1c
> >> [ 0.000000] init_IRQ+0xe4/0x118
> >> [ 0.000000] start_kernel+0x274/0x3ec
> >> [ 0.000000] Code: b40002c3 f940b8c2 cb020063 b2514063 (b9400461)
> >> [ 0.000000] ---[ end trace b6cc692d2bc7d1fd ]---
> >> [ 0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> >> [ 0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
> >>
> >> This commit changes to efi_mem_reserve_peristent() which causes the problem we're seeing:
> >>
> >> commit 80424b02d42bb22f8ff8839cb93a84ade53b39c0
> >>
> >> Author: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> Date:   Thu Nov 29 18:12:29 2018 +0100
> >>
> >>     efi: Reduce the amount of memblock reservations for persistent allocations
> >>
> >>     The current implementation of efi_mem_reserve_persistent() is rather
> >>     naive, in the sense that for each invocation, it creates a separate
> >>     linked list entry to describe the reservation. Since the linked list
> >>     entries themselves need to persist across subsequent kexec reboots,
> >>     every reservation created this way results in two memblock_reserve()
> >>     calls at the next boot.
> >>
> >> On first boot, a physical address from DT gets added to the mem_reserve list, 0xc3836000.
> >>
> >> [    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
> >> [    0.000000] GICv3: Distributor has no Range Selector support
> >> [    0.000000] GICv3: no VLPI support, no direct LPI support
> >> [    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000000063e00000
> >> [    0.000000] ITS [mem 0x63c20000-0x63c2ffff]
> >> [    0.000000] ITS@0x0000000063c20000: allocated 32768 Devices @a3c3880000 (flat, esz 8, psz 64K, shr 0)
> >> [    0.000000] ITS: using cache flushing for cmd queue
> >> [    0.000000] GICv3: using LPI property table @0x000000a3c3850000
> >> [    0.000000] iter: prsv = 0xc3836000
> >> [    0.000000] rsv = 0x43836000
> >> [    0.000000] GIC: using cache flushing for LPI property table
> >> [    0.000000] GICv3: CPU0: using allocated LPI pending table @0x000000a3c3860000
> >> <clip>
> >>
> >> On crash dump boot, gic calls the same function, efi_mem_reserve_persistent, finds the entry that was on initial boot (0xc3836000), converts it to a va, and then crashes when it's used on this line:
> >> atomic_fetch_add_unless(&rsv->count
> >>
> >> In the previous revision of this file, kmalloc was called and this worked fine.
> >>
> >> [    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
> >> [    0.000000] GICv3: Distributor has no Range Selector support
> >> [    0.000000] GICv3: no VLPI support, no direct LPI support
> >> [    0.000000] GICv3: CPU0: found redistributor 1 region 0:0x0000000063e20000
> >> [    0.000000] ITS [mem 0x63c20000-0x63c2ffff]
> >> [    0.000000] ITS@0x0000000063c20000: allocated 32768 Devices @fd480000 (flat, esz 8, psz 64K, shr 0)
> >> [    0.000000] ITS: using cache flushing for cmd queue
> >> [    0.000000] iter: prsv = 0xc3836000
> >> [    0.000000] rsv = 0x43836000
> >> [    0.000000] Unable to handle kernel paging request at virtual address ffff80a343836004
> >> [    0.000000] Mem abort info:
> >> [    0.000000]   ESR = 0x96000004
> >> [    0.000000]   Exception class = DABT (current EL), IL = 32 bits
> >>
> >> int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
> >> {
> >> <clip>
> >>     for (prsv = efi_memreserve_root->next; prsv; prsv = rsv->next) {
> >>         printk("iter: prsv = 0x%x\n", prsv);
> >>         rsv = __va(prsv);
> >>         printk("rsv = 0x%x\n", rsv);
> >>         index = atomic_fetch_add_unless(&rsv->count, 1, rsv->size);
> >>         if (index < rsv->size) {
> >>             rsv->entry[index].base = addr;
> >>             rsv->entry[index].size = size;
> >> <clip>
> >>
> >> It looks like the change has broken crash dump kernel, but I'm not sure what it should be doing instead. Has anyone used gicv3-its with crash dump kernel after this change?

Does the below make any difference at all?

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 55b77c576c42..7eaa3559d266 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -1007,14 +1007,16 @@ int __ref
efi_mem_reserve_persistent(phys_addr_t addr, u64 size)

        /* first try to find a slot in an existing linked list entry */
        for (prsv = efi_memreserve_root->next; prsv; prsv = rsv->next) {
-               rsv = __va(prsv);
+               rsv = memremap(prsv, sizeof(*rsv), MEMREMAP_WB);
                index = atomic_fetch_add_unless(&rsv->count, 1, rsv->size);
                if (index < rsv->size) {
                        rsv->entry[index].base = addr;
                        rsv->entry[index].size = size;

+                       memunmap(rsv);
                        return 0;
                }
+               memunmap(rsv);
        }

        /* no slot found - allocate a new linked list entry */
