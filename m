Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C08D37FFB
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jun 2019 23:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfFFVw5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jun 2019 17:52:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40513 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfFFVw5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Jun 2019 17:52:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id u17so2312470pfn.7
        for <linux-efi@vger.kernel.org>; Thu, 06 Jun 2019 14:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JdC/ZylnCNHIBXqlPx2k8KnmJqBwWs3/veNdB5AYByY=;
        b=Ab/+RRfqu+qRS/+qtVkd9ZlHvzHwj0bBqKOHmUnHwM9FWT9lNZZZpKJSr1Z94JpeV4
         y314BbjWIWlRxmd0Y8oQfbks3oWa1Iv24GsVXE5qEw/WGA8O2CgtoUywkq1ABDm7Z3X4
         UhUynix9VyO5HYicRfg+RqTBjNCMi+jfDFXGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JdC/ZylnCNHIBXqlPx2k8KnmJqBwWs3/veNdB5AYByY=;
        b=OHLQ6kSrRNOccA9IR3f8Z91fkL1mFfrS7fSIApw8u4sjv/wHCBtBVzhqYVrjUXjXlZ
         Ydw8aCURqXFVleAjVBohXRKplnyhbtRWqnMef/T1MuhGOaUloYQPRMl4XcxBO7ZvmNw+
         ywt5+egxLj/LLBu6jjFbuAzokkjPiBZUkWUiT+G0sgaFnWmQ56Tfznv5I4Bf+puUYelG
         cihyciIW3P7i2jYkNvrICPTk/msOWUuaQk3sjxrF2r7mpBjr6wOxizkUBxcGsjcELua9
         lwQTB0FxfWK+IGwbDYQhH0aBUmmVqXWaeKV3kUl6ERkvgt0W1mtyvfhDWnipukTB23Ga
         0x1Q==
X-Gm-Message-State: APjAAAW5093qRlT3Bmvcf6zCzLn91yHycGGDBsc5C91z9yt1n+lGp0Ks
        XJmYheLS2maP4s6JuYylEaQouQ==
X-Google-Smtp-Source: APXvYqwiHMY3Wes0XmepEaI+5JSNszPJSbFWyAx2u62lhEeXr7DD+hJ+6by1g/UOnzbbbU8+U69q2A==
X-Received: by 2002:a17:90a:b104:: with SMTP id z4mr2021066pjq.102.1559857973937;
        Thu, 06 Jun 2019 14:52:53 -0700 (PDT)
Received: from [10.0.2.15] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id d132sm123791pfd.61.2019.06.06.14.52.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 14:52:53 -0700 (PDT)
Subject: Re: gicv3-its driver crashes in crash dump kernel
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     linux-efi@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        ray.jui@broadcom.com, Marc Zyngier <marc.zyngier@arm.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <d812f073-67b2-ca7a-616c-7c440716885c@broadcom.com>
 <CACi5LpO0Qj7-h-mgdEAwBz+Mfyhuac=MNPERz09KTv1cXYqSLQ@mail.gmail.com>
From:   Jonathan Richardson <jonathan.richardson@broadcom.com>
Message-ID: <dd677822-8451-2fdf-79b3-0a3662974080@broadcom.com>
Date:   Thu, 6 Jun 2019 14:52:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CACi5LpO0Qj7-h-mgdEAwBz+Mfyhuac=MNPERz09KTv1cXYqSLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 06/06/2019 02:07 PM, Bhupesh Sharma wrote:
> Hi,
> 
> On Thu, Jun 6, 2019 at 3:45 AM Jonathan Richardson
> <jonathan.richardson@broadcom.com> wrote:
>>
>> Hi,
>>
>> As of the 5.0 kernel we're seeing the crash dump kernel crash when the gicv3-its driver calls gic_reserve_range():
>>
>> root@bcm958804a8040c:~# echo c > /proc/sysrq-trigger
>> [ 2285.405357] sysrq: SysRq : Trigger a crash
>> [ 2285.409592] Kernel panic - not syncing: sysrq triggered crash
>> [ 2285.415521] CPU: 0 PID: 4064 Comm: sh Kdump: loaded Tainted: G O 5.0.0 #1
>> [ 2285.423867] Hardware name: BRCM BRCM-SR/BRCM-SR, BIOS 0.1 Apr 26 2019
>> [ 2285.430510] Call trace:
>> [ 2285.433041] dump_backtrace+0x0/0x1a0
>> [ 2285.436818] show_stack+0x14/0x20
>> [ 2285.440237] dump_stack+0x90/0xb4
>> [ 2285.443657] panic+0x13c/0x2ec
>> [ 2285.446807] sysrq_handle_crash+0x14/0x18
>> [ 2285.450942] __handle_sysrq+0xa4/0x190
>> [ 2285.454808] write_sysrq_trigger+0x64/0x80
>> [ 2285.459034] proc_reg_write+0x60/0xa8
>> [ 2285.462812] __vfs_write+0x30/0x180
>> [ 2285.466409] vfs_write+0xa4/0x1b8
>> [ 2285.469827] ksys_write+0x60/0xd8
>> [ 2285.473246] __arm64_sys_write+0x14/0x20
>> [ 2285.477292] el0_svc_common+0x60/0x100
>> [ 2285.481158] el0_svc_handler+0x2c/0x88
>> [ 2285.485025] el0_svc+0x8/0xc
>> [ 2285.488001] SMP: stopping secondary CPUs
>> [ 2285.492349] Starting crashdump kernel...
>> [ 2285.496395] Bye!
>> [ 0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd083]
>> [ 0.000000] Linux version 5.0.0 (oe-user@oe-host) (gcc version 7.3.0 (GCC)) #1 SMP Fri Apr 26 03:06:15 UTC9
>> [ 0.000000] Machine model: Stingray PS1100R (BCM958804A8040)
>> [ 0.000000] earlycon: uart8250_log0 at MMIO32 0x0000000068a10000 (options '')
>> [ 0.000000] printk: bootconsole [uart8250_log0] enabled
>> [ 0.000000] Malformed early option 'loglevel'
>> [ 0.000000] efi: Getting EFI parameters from FDT:
>> [ 0.000000] efi: EFI v2.70 by EDK II
>> [ 0.000000] efi: SMBIOS=0x85cd0000 SMBIOS 3.0=0x85a20000 ACPI 2.0=0x85d90000 MEMATTR=0x89352018 MEMRE
>> [ 0.000000] cannot allocate crashkernel (size:0x20000000)
>> [ 0.000000] Reserving 2KB of memory at 0xffdff000 for elfcorehdr
>> [ 0.000000] cma: Failed to reserve 1024 MiB
>> [ 0.000000] psci: probing for conduit method from DT.
>> I: GICv3 without legacy support detected. ARM GICV3 driver initialized in EL3
>> 0.000000] psci: PSCIv1.1 detected in firmware.
>> [ 0.000000] psci: Using standard PSCI v0.2 function IDs
>> [ 0.000000] psci: MIGRATE_INFO_TYPE not supported.
>> [ 0.000000] psci: SMC Calling Convention v1.1
>> [ 0.000000] random: get_random_bytes called from start_kernel+0xa8/0x3ec with crng_init=0
>> [ 0.000000] percpu: Embedded 23 pages/cpu @(____ptrval____) s53784 r8192 d32232 u94208
>> [ 0.000000] Detected PIPT I-cache on CPU0
>> [ 0.000000] CPU features: detected: EL2 vector hardening
>> [ 0.000000] Speculative Store Bypass Disable mitigation not required
>> [ 0.000000] Built 1 zonelists, mobility grouping on. Total pages: 130974
>> [ 0.000000] Kernel command line: FS2:\Image.1 root=/dev/mmcblk0p3 rw rootwait earlycon=uart8250_log,mmio1
>> [ 0.000000] Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
>> [ 0.000000] Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
>> [ 0.000000] Memory: 472776K/532212K available (9340K kernel code, 734K rwdata, 3412K rodata, 832K init, 35)
>> [ 0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
>> [ 0.000000] rcu: Hierarchical RCU implementation.
>> [ 0.000000] rcu: RCU event tracing is enabled.
>> [ 0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
>> [ 0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
>> [ 0.000000] GICv3: GIC: Using split EOI/Deactivate mode
>> [ 0.000000] GICv3: Distributor has no Range Selector support
>> [ 0.000000] GICv3: no VLPI support, no direct LPI support
>> [ 0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000000063e00000
>> [ 0.000000] ITS [mem 0x63c20000-0x63c2ffff]
>> [ 0.000000] ITS@0x0000000063c20000: allocated 65536 Devices @fd480000 (flat, esz 8, psz 64K, shr 0)
>> [ 0.000000] ITS: using cache flushing for cmd queue
>> [ 0.000000] Unable to handle kernel paging request at virtual address ffff800975c36004
>> [ 0.000000] Mem abort info:
>> [ 0.000000] ESR = 0x96000005
>> [ 0.000000] Exception class = DABT (current EL), IL = 32 bits
>> [ 0.000000] SET = 0, FnV = 0
>> [ 0.000000] EA = 0, S1PTW = 0
>> [ 0.000000] Data abort info:
>> [ 0.000000] ISV = 0, ISS = 0x00000005
>> [ 0.000000] CM = 0, WnR = 0
>> [ 0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
>> [ 0.000000] [ffff800975c36004] pgd=00000000ffdf8003, pud=0000000000000000
>> [ 0.000000] Internal error: Oops: 96000005 [#1] SMP
>> [ 0.000000] Modules linked in:
>> [ 0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.0.0 #1
>> [ 0.000000] Hardware name: Stingray PS1100R (BCM958804A8040) (DT)
>> [ 0.000000] pstate: 60000085 (nZCv daIf -PAN -UAO)
>> [ 0.000000] pc : efi_mem_reserve_persistent+0x60/0x1b8
>> [ 0.000000] lr : efi_mem_reserve_persistent+0x1a0/0x1b8
>> [ 0.000000] sp : ffff000010dd3c30
>> [ 0.000000] x29: ffff000010dd3c30 x28: ffff80007d409200
>> [ 0.000000] x27: ffff000010eca000 x26: 0000000000000008
>> [ 0.000000] x25: ffff000010060000 x24: 0000000000000000
>> [ 0.000000] x23: 0000000000010000 x22: ffff000010c96000
>> [ 0.000000] x21: 00000000fd450000 x20: 0000000000010000
>> [ 0.000000] x19: ffff000010eca000 x18: ffffffffffffffff
>> [ 0.000000] x17: 0000000000000000 x16: 0000000000000000
>> [ 0.000000] x15: ffff000010ddc688 x14: ffff80007d4334b5
>> [ 0.000000] x13: ffff000010c96000 x12: ffff000010005fff
>> [ 0.000000] x11: ffff000010005000 x10: 0000000085f84000
>> [ 0.000000] x9 : 0000000000000000 x8 : 0040000000000001
>> [ 0.000000] x7 : ffff000010005000 x6 : ffff000010c96000
>> [ 0.000000] x5 : ffff80007fdfd408 x4 : ffff000010005fff
>> [ 0.000000] x3 : ffff800975c36000 x2 : 0000000080000000
>> [ 0.000000] x1 : ffff000010005018 x0 : 0000000000000000
>> [ 0.000000] Process swapper/0 (pid: 0, stack limit = 0x(____ptrval____))
>> [ 0.000000] Call trace:
>> [ 0.000000] efi_mem_reserve_persistent+0x60/0x1b8
>> [ 0.000000] its_init+0xa58/0xe98
>> [ 0.000000] gic_of_init+0x478/0x4d4
>> [ 0.000000] of_irq_init+0x19c/0x2f4
>> [ 0.000000] irqchip_init+0x14/0x1c
>> [ 0.000000] init_IRQ+0xe4/0x118
>> [ 0.000000] start_kernel+0x274/0x3ec
>> [ 0.000000] Code: b40002c3 f940b8c2 cb020063 b2514063 (b9400461)
>> [ 0.000000] ---[ end trace b6cc692d2bc7d1fd ]---
>> [ 0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
>> [ 0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
>>
>> This commit changes to efi_mem_reserve_peristent() which causes the problem we're seeing:
>>
>> commit 80424b02d42bb22f8ff8839cb93a84ade53b39c0
>>
>> Author: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Date:   Thu Nov 29 18:12:29 2018 +0100
>>
>>     efi: Reduce the amount of memblock reservations for persistent allocations
>>
>>     The current implementation of efi_mem_reserve_persistent() is rather
>>     naive, in the sense that for each invocation, it creates a separate
>>     linked list entry to describe the reservation. Since the linked list
>>     entries themselves need to persist across subsequent kexec reboots,
>>     every reservation created this way results in two memblock_reserve()
>>     calls at the next boot.
>>
>> On first boot, a physical address from DT gets added to the mem_reserve list, 0xc3836000.
>>
>> [    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
>> [    0.000000] GICv3: Distributor has no Range Selector support
>> [    0.000000] GICv3: no VLPI support, no direct LPI support
>> [    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000000063e00000
>> [    0.000000] ITS [mem 0x63c20000-0x63c2ffff]
>> [    0.000000] ITS@0x0000000063c20000: allocated 32768 Devices @a3c3880000 (flat, esz 8, psz 64K, shr 0)
>> [    0.000000] ITS: using cache flushing for cmd queue
>> [    0.000000] GICv3: using LPI property table @0x000000a3c3850000
>> [    0.000000] iter: prsv = 0xc3836000
>> [    0.000000] rsv = 0x43836000
>> [    0.000000] GIC: using cache flushing for LPI property table
>> [    0.000000] GICv3: CPU0: using allocated LPI pending table @0x000000a3c3860000
>> <clip>
>>
>> On crash dump boot, gic calls the same function, efi_mem_reserve_persistent, finds the entry that was on initial boot (0xc3836000), converts it to a va, and then crashes when it's used on this line:
>> atomic_fetch_add_unless(&rsv->count
>>
>> In the previous revision of this file, kmalloc was called and this worked fine.
>>
>> [    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
>> [    0.000000] GICv3: Distributor has no Range Selector support
>> [    0.000000] GICv3: no VLPI support, no direct LPI support
>> [    0.000000] GICv3: CPU0: found redistributor 1 region 0:0x0000000063e20000
>> [    0.000000] ITS [mem 0x63c20000-0x63c2ffff]
>> [    0.000000] ITS@0x0000000063c20000: allocated 32768 Devices @fd480000 (flat, esz 8, psz 64K, shr 0)
>> [    0.000000] ITS: using cache flushing for cmd queue
>> [    0.000000] iter: prsv = 0xc3836000
>> [    0.000000] rsv = 0x43836000
>> [    0.000000] Unable to handle kernel paging request at virtual address ffff80a343836004
>> [    0.000000] Mem abort info:
>> [    0.000000]   ESR = 0x96000004
>> [    0.000000]   Exception class = DABT (current EL), IL = 32 bits
>>
>> int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
>> {
>> <clip>
>>     for (prsv = efi_memreserve_root->next; prsv; prsv = rsv->next) {
>>         printk("iter: prsv = 0x%x\n", prsv);
>>         rsv = __va(prsv);
>>         printk("rsv = 0x%x\n", rsv);
>>         index = atomic_fetch_add_unless(&rsv->count, 1, rsv->size);
>>         if (index < rsv->size) {
>>             rsv->entry[index].base = addr;
>>             rsv->entry[index].size = size;
>> <clip>
>>
>> It looks like the change has broken crash dump kernel, but I'm not sure what it should be doing instead. Has anyone used gicv3-its with crash dump kernel after this change?
> 
> I tried reproducing this on my local arm64 machine which has a GICv3
> ITS controller with Linux  5.0.0 and at my end kdump/crashkernel works
> just fine (some GICv3 related logs from the kdump kernel below):
> 
> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
> [    0.000000] GICv3: Distributor has no Range Selector support
> [    0.000000] GICv3: no VLPI support, no direct LPI support
> [    0.000000] GICv3: CPU0: found redistributor c01 region 0:0x0000000078720000
> [    0.000000] ACPI: SRAT not present
> [    0.000000] ITS [mem 0x78020000-0x7803ffff]
> [    0.000000] ITS@0x0000000078020000: allocated 1048576 Devices
> @d2000000 (flat, esz 8, psz 64K, shr 0)
> [    0.000000] ITS: using cache flushing for cmd queue
> [    0.000000] GICv3: Using preallocated redistributor tables
> [    0.000000] GICv3: using LPI property table @0x0000009fc0480000
> [    0.000000] GICv3: CPU0: using reserved LPI pending table @0x0000009fc0630000
> ..
> 
> So, in order to better help you with this, would you mind sharing the following:
> 
> - kdump kernel bootargs that you use. If you boot your kdump kernel in
> SMP mode, may I suggest that you first try booting it with 'nr_cpus=1'
> in the bootargs and see if that makes a difference.
> 
> - Also, I find the following message unusual in the kdump kernel boot logs:
> 
>> [ 0.000000] cannot allocate crashkernel (size:0x20000000)
> 
> Do you pass crashkernel=xx in the kdump kernel bootatgs as well (in
> addition to the primary kernel). If yes, why? Because normally
> reserve_crashkernel() already reserves memory area given in
> "crashkernel=" kernel command line parameter to the primary kernel.
> The memory reserved is used by dump capture kernel when primary kernel
> is crashing.
> 
> - I would suspect the cma allocation failure message as well, but that
> in general may indicate that the crashkernel has been allocate
> insufficient memory or placed in a weird region below 4G of RAM:
>> [ 0.000000] cma: Failed to reserve 1024 MiB
> 
> To better debug the same, I would also suggest that you share the
> primary kernel boot logs for comparison.
> 
> Thanks,
> Bhupesh
> 

Thanks for the feedback. Here is the full primary boot log, 
/proc/iomem, and the crash dump log with the suggested changes:

bootcmd=FS2:\Image.1  root=/dev/mmcblk0p4 rw rootwait  earlycon=uart8250_log,mmio32,0x68A10000 early
log=0x8f110000,0x10000 console=ttyS0,115200n8 hugepages=0 cma=1G crashkernel=512M pci=pcie_bus_safe
pciehp.pciehp_poll_mode=1 pciehp.pciehp_poll_time=5 pcie_ports=native maxcpus=8  bgmac_platform.etha
ddr=00:0A:F7:95:62:82 ip=10.136.13.31:10.136.4.151:10.136.13.1:255.255.255.0:::off  loglevel=7
Kernel slot 1, dtb slot 2, rootfs slot 2
 --- STARTING KERNEL
EFI stub: Booting Linux Kernel...
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services and installing virtual address map...
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd083]
[    0.000000] Linux version 5.1.0 (oe-user@oe-host) (gcc version 7.3.0 (GCC)) #1 SMP Thu Jun 6 21:06:41 UTC 2019
[    0.000000] Machine model: Stingray Combo SVK w/PAXB IOMMU (BCM958742K)
[    0.000000] earlycon: uart8250_log0 at MMIO32 0x0000000068a10000 (options '')
[    0.000000] printk: bootconsole [uart8250_log0] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.70 by EDK II
[    0.000000] efi:  SMBIOS=0x85cd0000  SMBIOS 3.0=0x85a20000  ACPI 2.0=0x85d90000  MEMATTR=0x893b3118  MEMRESERVE=0x85f83018
[    0.000000] crashkernel reserved: 0x00000000dfe00000 - 0x00000000ffe00000 (512 MB)
[    0.000000] cma: Reserved 1024 MiB at 0x000000009fc00000
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] random: get_random_bytes called from start_kernel+0xa4/0x448 with crng_init=0
[    0.000000] percpu: Embedded 23 pages/cpu s53848 r8192 d32168 u94208
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: EL2 vector hardening
[    0.000000] Speculative Store Bypass Disable mitigation not required
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 12376560
[    0.000000] Kernel command line: FS2:\Image.1  root=/dev/mmcblk0p4 rw rootwait  earlycon=uart8250_log,mmio32,0x68A10000 earlylog=0x8f110000,0x10000 console=ttyS0,115200n8 hugepages=0 cma=1G crashkernel=512M pci=pcie_bus_safe pciehp.pciehp_poll_mode=1 pciehp.pciehp_poll_time=5 pcie_ports=native maxcpus=8  bgmac_platform.ethaddr=00:0A:F7:95:62:82 ip=10.136.13.31:10.136.4.151:10.136.13.1:255.255.255.0:::off  loglevel=7
[    0.000000] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes)
[    0.000000] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.000000] software IO TLB: mapped [mem 0x9bc00000-0x9fc00000] (64MB)
[    0.000000] Memory: 47645616K/50292608K available (9532K kernel code, 748K rwdata, 3488K rodata, 960K init, 364K bss, 1598416K reserved, 1048576K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] GICv3: no VLPI support, no direct LPI support
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000000063e00000
[    0.000000] ITS [mem 0x63c20000-0x63c2ffff]
[    0.000000] ITS@0x0000000063c20000: allocated 32768 Devices @a3c3880000 (flat, esz 8, psz 64K, shr 0)
[    0.000000] ITS: using cache flushing for cmd queue
[    0.000000] GICv3: using LPI property table @0x000000a3c3850000
[    0.000000] GIC: using cache flushing for LPI property table
[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x000000a3c3860000
[    0.000000] arch_timer: cp15 timer(s) running at 125.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x39a85c4118, max_idle_ns: 881590405314 ns
[    0.000001] sched_clock: 56 bits at 125MHz, resolution 8ns, wraps every 4398046511100ns
[    0.008475] clocksource: arm,sp804: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 152900835740 ns
[    0.018603] Console: colour dummy device 80x25
[    0.023286] Calibrating delay loop (skipped), value calculated using timer frequency.. 250.00 BogoMIPS (lpj=500000)
[    0.034273] pid_max: default: 32768 minimum: 301
[    0.039145] LSM: Security Framework initializing
[    0.044189] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.051787] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.059804] *** VALIDATE proc ***
[    0.063341] *** VALIDATE cgroup1 ***
[    0.067100] *** VALIDATE cgroup2 ***
[    0.071044] ASID allocator initialised with 32768 entries
[    0.076745] rcu: Hierarchical SRCU implementation.
[    0.082224] Platform MSI: gic-its@63c20000 domain created
[    0.087934] PCI/MSI: /scr/interrupt-controller@2c00000/gic-its@63c20000 domain created
[    0.096313] Remapping and enabling EFI services.
[    0.101546] smp: Bringing up secondary CPUs ...
I: Cluster #1 entering to snoop/dvm domain
I: Cluster #2 entering to snoop/dvm domain
I: Cluster #3 entering to snoop/dvm domain
[    0.106472] Detected PIPT I-cache on CPU1
[    0.106485] GICv3: CPU1: found redistributor 1 region 0:0x0000000063e20000
[    0.106490] GICv3: CPU1: using allocated LPI pending table @0x000000a3c3870000
[    0.106501] CPU1: Booted secondary processor 0x0000000001 [0x410fd083]
[    0.106897] Detected PIPT I-cache on CPU2
[    0.106909] GICv3: CPU2: found redistributor 100 region 0:0x0000000063e40000
[    0.106915] GICv3: CPU2: using allocated LPI pending table @0x000000a3c38c0000
[    0.106928] CPU2: Booted secondary processor 0x0000000100 [0x410fd083]
[    0.107113] Detected PIPT I-cache on CPU3
[    0.107118] GICv3: CPU3: found redistributor 101 region 0:0x0000000063e60000
[    0.107123] GICv3: CPU3: using allocated LPI pending table @0x000000a3c38d0000
[    0.107131] CPU3: Booted secondary processor 0x0000000101 [0x410fd083]
[    0.108777] Detected PIPT I-cache on CPU4
[    0.108786] GICv3: CPU4: found redistributor 200 region 0:0x0000000063e80000
[    0.108792] GICv3: CPU4: using allocated LPI pending table @0x000000a3c38e0000
[    0.108803] CPU4: Booted secondary processor 0x0000000200 [0x410fd083]
[    0.108983] Detected PIPT I-cache on CPU5
[    0.108989] GICv3: CPU5: found redistributor 201 region 0:0x0000000063ea0000
[    0.108994] GICv3: CPU5: using allocated LPI pending table @0x000000a3c38f0000
[    0.109003] CPU5: Booted secondary processor 0x0000000201 [0x410fd083]
[    0.112436] Detected PIPT I-cache on CPU6
[    0.112446] GICv3: CPU6: found redistributor 300 region 0:0x0000000063ec0000
[    0.112452] GICv3: CPU6: using allocated LPI pending table @0x000000a3c3900000
[    0.112463] CPU6: Booted secondary processor 0x0000000300 [0x410fd083]
[    0.112642] Detected PIPT I-cache on CPU7
[    0.112648] GICv3: CPU7: found redistributor 301 region 0:0x0000000063ee0000
[    0.112652] GICv3: CPU7: using allocated LPI pending table @0x000000a3c3910000
[    0.112661] CPU7: Booted secondary processor 0x0000000301 [0x410fd083]
[    0.112689] smp: Brought up 1 node, 8 CPUs
[    0.304567] SMP: Total of 8 processors activated.
[    0.309513] CPU features: detected: 32-bit EL0 Support
[    0.314916] CPU features: detected: CRC32 instructions
[    0.320834] CPU: All CPU(s) started at EL2
[    0.325156] alternatives: patching kernel code
[    0.330182] devtmpfs: initialized
[    0.335123] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.345387] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    0.358884] xor: measuring software checksum speed
[    0.403948]    8regs     :  9089.000 MB/sec
[    0.448358]    32regs    :  9449.000 MB/sec
[    0.492767]    arm64_neon:  9022.000 MB/sec
[    0.497163] xor: using function: 32regs (9449.000 MB/sec)
[    0.502845] pinctrl core: initialized pinctrl subsystem
[    0.508693] SMBIOS 3.2.0 present.
[    0.512175] DMI: BRCM BRCM-SR/BRCM-SR, BIOS 0.1 May 31 2019
[    0.518135] NET: Registered protocol family 16
[    0.522972] audit: initializing netlink subsys (disabled)
[    0.528684] audit: type=2000 audit(0.368:1): state=initialized audit_enabled=0 res=1
[    0.536852] cpuidle: using governor menu
[    0.541052] vdso: 2 pages (1 code @ (____ptrval____), 1 data @ (____ptrval____))
[    0.548838] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.556287] DMA: preallocated 256 KiB pool for atomic allocations
[    0.564830] brcm,iproc-mailbox 66424024.mailbox: Initializing iproc mailbox controller
[    0.575421] gpiochip_add_data_with_key: GPIOs 355..505 (689d0000.gpio) failed to register, -517
[    0.584618] iproc-gpio 689d0000.gpio: unable to add GPIO chip
[    0.597332] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.604422] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[    0.611502] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.618583] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    0.625799] cryptd: max_cpu_qlen set to 1000
[    0.698337] raid6: neonx8   gen()  6793 MB/s
[    0.770874] raid6: neonx8   xor()  5860 MB/s
[    0.843418] raid6: neonx4   gen()  6702 MB/s
[    0.915958] raid6: neonx4   xor()  5162 MB/s
[    0.988498] raid6: neonx2   gen()  5495 MB/s
[    1.061036] raid6: neonx2   xor()  5271 MB/s
[    1.133582] raid6: neonx1   gen()  3581 MB/s
[    1.206124] raid6: neonx1   xor()  3531 MB/s
[    1.278670] raid6: int64x8  gen()  3807 MB/s
[    1.351221] raid6: int64x8  xor()  2518 MB/s
[    1.423776] raid6: int64x4  gen()  3802 MB/s
[    1.496326] raid6: int64x4  xor()  2679 MB/s
[    1.568880] raid6: int64x2  gen()  2821 MB/s
[    1.641424] raid6: int64x2  xor()  2507 MB/s
[    1.713989] raid6: int64x1  gen()  1812 MB/s
[    1.786541] raid6: int64x1  xor()  1556 MB/s
[    1.791050] raid6: using algorithm neonx8 gen() 6793 MB/s
[    1.796754] raid6: .... xor() 5860 MB/s, rmw enabled
[    1.801999] raid6: using neon recovery algorithm
[    1.807133] vgaarb: loaded
[    1.810068] SCSI subsystem initialized
[    1.814116] ssp-pl022 68a80000.spi: ARM PL022 driver, device ID: 0x00241022
[    1.821513] ssp-pl022 68a90000.spi: ARM PL022 driver, device ID: 0x00241022
[    1.829045] usbcore: registered new interface driver usbfs
[    1.834869] usbcore: registered new interface driver hub
[    1.840511] usbcore: registered new device driver usb
[    1.845885] pps_core: LinuxPPS API ver. 1 registered
[    1.851131] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.860792] PTP clock support registered
[    1.865021] Registered efivars operations
[    1.869525] clocksource: Switched to clocksource arch_sys_counter
[    1.876017] VFS: Disk quotas dquot_6.6.0
[    1.880180] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.887465] *** VALIDATE hugetlbfs ***
[    1.893317] NET: Registered protocol family 2
[    1.898047] tcp_listen_portaddr_hash hash table entries: 32768 (order: 7, 524288 bytes)
[    1.906726] TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
[    1.915696] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.923057] TCP: Hash tables configured (established 524288 bind 65536)
[    1.930104] UDP hash table entries: 32768 (order: 8, 1048576 bytes)
[    1.937129] UDP-Lite hash table entries: 32768 (order: 8, 1048576 bytes)
[    1.944648] NET: Registered protocol family 1
[    1.949382] RPC: Registered named UNIX socket transport module.
[    1.955643] RPC: Registered udp transport module.
[    1.960613] RPC: Registered tcp transport module.
[    1.965585] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.972737] hw perfevents: enabled with armv8_pmuv3 PMU driver, 7 counters available
[    1.981063] kvm [1]: IPA Size Limit: 44bits
[    1.985656] kvm [1]: GICv3: no GICV resource entry
[    1.990720] kvm [1]: disabling GICv2 emulation
[    1.995425] kvm [1]: GIC system register CPU interface enabled
[    2.001648] kvm [1]: vgic interrupt IRQ1
[    2.005862] kvm [1]: Hyp mode initialized successfully
[    2.020060] workingset: timestamp_bits=46 max_order=24 bucket_order=0
[    2.028844] NFS: Registering the id_resolver key type
[    2.034193] Key type id_resolver registered
[    2.038611] Key type id_legacy registered
[    2.042849] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    2.049975] 9p: Installing v9fs 9p2000 file system support
[    2.059900] alg: No test for lzo-rle (lzo-rle-generic)
[    2.065406] alg: No test for lzo-rle (lzo-rle-scomp)
[    2.074508] NET: Registered protocol family 38
[    2.079208] async_tx: api initialized (async)
[    2.083828] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[    2.091652] io scheduler mq-deadline registered
[    2.096442] io scheduler kyber registered
[    2.101224] brcm-sata-phy 67d02100.sata_phy: registered 1 port(s)
[    2.107716] brcm-sata-phy 67d12100.sata_phy: registered 1 port(s)
[    2.114238] brcm-sata-phy 67d22100.sata_phy: registered 1 port(s)
[    2.120731] brcm-sata-phy 67d32100.sata_phy: registered 1 port(s)
[    2.127220] brcm-sata-phy 67e02100.sata_phy: registered 1 port(s)
[    2.133713] brcm-sata-phy 67e12100.sata_phy: registered 1 port(s)
[    2.140203] brcm-sata-phy 67e22100.sata_phy: registered 1 port(s)
[    2.146699] brcm-sata-phy 67e32100.sata_phy: registered 1 port(s)
[    2.153328] sr-pcie-phy 40000000.phy: Stingray PCIe PHY driver initialized
[    2.160682] pinctrl-single 68a40000.pinconf: please update dts to use #pinctrl-cells = <1>
[    2.169487] pinctrl-single 68a40000.pinconf: 148 pins, size 592
[    2.175779] pinctrl-single 68a4029c.pinmux: please update dts to use #pinctrl-cells = <1>
[    2.184491] pinctrl-single 68a4029c.pinmux: 148 pins, size 592
[    2.190880] iproc-pcie 48000000.pcie: host bridge /pcie@48000000 ranges:
[    2.197974] iproc-pcie 48000000.pcie:   MEM 0x400000000..0x46fffffff -> 0x400000000
[    2.206072] iproc-pcie 48000000.pcie:   MEM 0x470000000..0x47fffffff -> 0x40000000
[    2.214076] iproc-pcie 48000000.pcie: reads of config registers that contain 0xffff0001 return incorrect data
[    2.329560] iproc-pcie 48000000.pcie: link UP @ Speed Gen-3 and width-x4
[    2.336666] iproc-pcie 48000000.pcie: not using iProc MSI
[    2.342401] iproc-pcie 48000000.pcie: PCI host bridge to bus 0000:00
[    2.349120] pci_bus 0000:00: root bus resource [bus 00-ff]
[    2.354919] pci_bus 0000:00: root bus resource [mem 0x400000000-0x46fffffff pref]
[    2.362834] pci_bus 0000:00: root bus resource [mem 0x470000000-0x47fffffff] (bus address [0x40000000-0x4fffffff])
[    2.374456] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    2.394027] pci 0000:00:00.0: BAR 14: assigned [mem 0x470000000-0x4700fffff]
[    2.401487] pci 0000:01:00.0: BAR 0: assigned [mem 0x470000000-0x470003fff 64bit]
[    2.409421] pci 0000:00:00.0: PCI bridge to [bus 01]
[    2.414672] pci 0000:00:00.0:   bridge window [mem 0x470000000-0x4700fffff]
[    2.422043] pci 0000:00:00.0: Max Payload Size set to  256/ 512 (was  128), Max Read Rq  512
[    2.430980] pci 0000:01:00.0: Max Payload Size set to  256/ 256 (was  128), Max Read Rq  512
[    2.439966] iproc-pcie 48004000.pcie: host bridge /pcie@48004000 ranges:
[    2.447059] iproc-pcie 48004000.pcie:   MEM 0x480000000..0x4efffffff -> 0x480000000
[    2.455159] iproc-pcie 48004000.pcie:   MEM 0x4f0000000..0x4ffffffff -> 0x40000000
[    2.463166] iproc-pcie 48004000.pcie: reads of config registers that contain 0xffff0001 return incorrect data
[    2.581558] iproc-pcie 48004000.pcie: link UP @ Speed Gen-3 and width-x4
[    2.588657] iproc-pcie 48004000.pcie: not using iProc MSI
[    2.594387] iproc-pcie 48004000.pcie: PCI host bridge to bus 0001:00
[    2.601107] pci_bus 0001:00: root bus resource [bus 00-ff]
[    2.606905] pci_bus 0001:00: root bus resource [mem 0x480000000-0x4efffffff pref]
[    2.614818] pci_bus 0001:00: root bus resource [mem 0x4f0000000-0x4ffffffff] (bus address [0x40000000-0x4fffffff])
[    2.626399] pci 0001:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    2.646018] pci 0001:00:00.0: BAR 14: assigned [mem 0x4f0000000-0x4f00fffff]
[    2.653476] pci 0001:01:00.0: BAR 0: assigned [mem 0x4f0000000-0x4f0003fff 64bit]
[    2.661410] pci 0001:00:00.0: PCI bridge to [bus 01]
[    2.666660] pci 0001:00:00.0:   bridge window [mem 0x4f0000000-0x4f00fffff]
[    2.674027] pci 0001:00:00.0: Max Payload Size set to  256/ 512 (was  128), Max Read Rq  512
[    2.682965] pci 0001:01:00.0: Max Payload Size set to  256/ 256 (was  128), Max Read Rq  512
[    2.691947] iproc-pcie 48008000.pcie: host bridge /pcie@48008000 ranges:
[    2.699040] iproc-pcie 48008000.pcie:   MEM 0x500000000..0x56fffffff -> 0x500000000
[    2.707136] iproc-pcie 48008000.pcie:   MEM 0x570000000..0x57fffffff -> 0x40000000
[    2.715142] iproc-pcie 48008000.pcie: reads of config registers that contain 0xffff0001 return incorrect data
[    2.725636] phy phy-40000000.phy.15: phy init failed --> -19
[    2.731619] iproc-pcie 48008000.pcie: unable to initialize PCIe PHY
[    2.738245] iproc-pcie 48008000.pcie: PCIe controller setup failed
[    2.744805] iproc-pcie 4800c000.pcie: host bridge /pcie@4800c000 ranges:
[    2.751897] iproc-pcie 4800c000.pcie:   MEM 0x580000000..0x5efffffff -> 0x580000000
[    2.759995] iproc-pcie 4800c000.pcie:   MEM 0x5f0000000..0x5ffffffff -> 0x40000000
[    2.768003] iproc-pcie 4800c000.pcie: reads of config registers that contain 0xffff0001 return incorrect data
[    2.778490] phy phy-40000000.phy.16: phy init failed --> -19
[    2.784472] iproc-pcie 4800c000.pcie: unable to initialize PCIe PHY
[    2.791096] iproc-pcie 4800c000.pcie: PCIe controller setup failed
[    2.797652] iproc-pcie 48010000.pcie: host bridge /pcie@48010000 ranges:
[    2.804742] iproc-pcie 48010000.pcie:   MEM 0x600000000..0x66fffffff -> 0x600000000
[    2.812840] iproc-pcie 48010000.pcie:   MEM 0x670000000..0x67fffffff -> 0x40000000
[    2.820843] iproc-pcie 48010000.pcie: reads of config registers that contain 0xffff0001 return incorrect data
[    2.831336] phy phy-40000000.phy.17: phy init failed --> -19
[    2.837318] iproc-pcie 48010000.pcie: unable to initialize PCIe PHY
[    2.843943] iproc-pcie 48010000.pcie: PCIe controller setup failed
[    2.850499] iproc-pcie 48014000.pcie: host bridge /pcie@48014000 ranges:
[    2.857589] iproc-pcie 48014000.pcie:   MEM 0x680000000..0x6efffffff -> 0x680000000
[    2.865686] iproc-pcie 48014000.pcie:   MEM 0x6f0000000..0x6ffffffff -> 0x40000000
[    2.873691] iproc-pcie 48014000.pcie: reads of config registers that contain 0xffff0001 return incorrect data
[    2.884183] phy phy-40000000.phy.18: phy init failed --> -19
[    2.890167] iproc-pcie 48014000.pcie: unable to initialize PCIe PHY
[    2.896792] iproc-pcie 48014000.pcie: PCIe controller setup failed
[    2.903346] iproc-pcie 48018000.pcie: host bridge /pcie@48018000 ranges:
[    2.910437] iproc-pcie 48018000.pcie:   MEM 0x700000000..0x76fffffff -> 0x700000000
[    2.918534] iproc-pcie 48018000.pcie:   MEM 0x770000000..0x77fffffff -> 0x40000000
[    2.926540] iproc-pcie 48018000.pcie: reads of config registers that contain 0xffff0001 return incorrect data
[    3.041565] iproc-pcie 48018000.pcie: link UP @ Speed Gen-3 and width-x4
[    3.048663] iproc-pcie 48018000.pcie: not using iProc MSI
[    3.054394] iproc-pcie 48018000.pcie: PCI host bridge to bus 0006:00
[    3.061114] pci_bus 0006:00: root bus resource [bus 00-ff]
[    3.066913] pci_bus 0006:00: root bus resource [mem 0x700000000-0x76fffffff pref]
[    3.074826] pci_bus 0006:00: root bus resource [mem 0x770000000-0x77fffffff] (bus address [0x40000000-0x4fffffff])
[    3.086407] pci 0006:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    3.106018] pci 0006:00:00.0: BAR 14: assigned [mem 0x770000000-0x7700fffff]
[    3.113474] pci 0006:01:00.0: BAR 6: assigned [mem 0x770000000-0x77000ffff pref]
[    3.121301] pci 0006:01:00.0: BAR 0: assigned [mem 0x770010000-0x770013fff 64bit]
[    3.129232] pci 0006:01:00.0: BAR 2: no space for [io  size 0x0100]
[    3.135862] pci 0006:01:00.0: BAR 2: failed to assign [io  size 0x0100]
[    3.142854] pci 0006:00:00.0: PCI bridge to [bus 01]
[    3.148104] pci 0006:00:00.0:   bridge window [mem 0x770000000-0x7700fffff]
[    3.155473] pci 0006:00:00.0: Max Payload Size set to  128/ 512 (was  128), Max Read Rq  512
[    3.164411] pci 0006:01:00.0: Max Payload Size set to  128/ 128 (was  128), Max Read Rq  512
[    3.173388] iproc-pcie 4801c000.pcie: host bridge /pcie@4801c000 ranges:
[    3.180482] iproc-pcie 4801c000.pcie:   MEM 0x780000000..0x7dfffffff -> 0x780000000
[    3.188580] iproc-pcie 4801c000.pcie:   MEM 0x7e0000000..0x7efffffff -> 0x7d0000000
[    3.196679] iproc-pcie 4801c000.pcie:   MEM 0x7f0000000..0x7ffffffff -> 0x40000000
[    3.204684] iproc-pcie 4801c000.pcie: reads of config registers that contain 0xffff0001 return incorrect data
[    3.321559] iproc-pcie 4801c000.pcie: link UP @ Speed Gen-3 and width-x4
[    3.328661] iproc-pcie 4801c000.pcie: not using iProc MSI
[    3.334391] iproc-pcie 4801c000.pcie: PCI host bridge to bus 0007:00
[    3.341107] pci_bus 0007:00: root bus resource [bus 00-ff]
[    3.346907] pci_bus 0007:00: root bus resource [mem 0x780000000-0x7dfffffff pref]
[    3.354817] pci_bus 0007:00: root bus resource [mem 0x7e0000000-0x7efffffff pref] (bus address [0x7d0000000-0x7dfffffff])
[    3.366413] pci_bus 0007:00: root bus resource [mem 0x7f0000000-0x7ffffffff] (bus address [0x40000000-0x4fffffff])
[    3.377992] pci 0007:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    3.398020] pci 0007:00:00.0: BAR 14: assigned [mem 0x7f0000000-0x7f00fffff]
[    3.405477] pci 0007:01:00.0: BAR 6: assigned [mem 0x7f0000000-0x7f000ffff pref]
[    3.413306] pci 0007:01:00.0: BAR 0: assigned [mem 0x7f0010000-0x7f0013fff 64bit]
[    3.421235] pci 0007:01:00.0: BAR 2: no space for [io  size 0x0100]
[    3.427861] pci 0007:01:00.0: BAR 2: failed to assign [io  size 0x0100]
[    3.434855] pci 0007:00:00.0: PCI bridge to [bus 01]
[    3.440103] pci 0007:00:00.0:   bridge window [mem 0x7f0000000-0x7f00fffff]
[    3.447471] pci 0007:00:00.0: Max Payload Size set to  128/ 512 (was  128), Max Read Rq  512
[    3.456405] pci 0007:01:00.0: Max Payload Size set to  128/ 128 (was  128), Max Read Rq  512
[    3.465365] iproc-pcie 60400000.pcie: host bridge /pcie@60400000 ranges:
[    3.472454] iproc-pcie 60400000.pcie:   MEM 0x10000000..0x2fffffff -> 0x10000000
[    3.480284] iproc-pcie 60400000.pcie: not using iProc MSI
[    3.486011] iproc-pcie 60400000.pcie: PCI host bridge to bus 0008:00
[    3.492731] pci_bus 0008:00: root bus resource [bus 00-01]
[    3.498529] pci_bus 0008:00: root bus resource [mem 0x10000000-0x2fffffff]
[    3.505878] OF: /pcie@60400000: Invalid msi-map translation - no match for rid 0x0 on           (null)
[    3.517024] pci 0008:00:00.0: BAR 14: assigned [mem 0x10000000-0x100fffff]
[    3.524298] pci 0008:00:00.0: BAR 15: assigned [mem 0x10100000-0x103fffff 64bit pref]
[    3.532580] pci 0008:01:00.0: BAR 2: assigned [mem 0x10100000-0x101fffff 64bit pref]
[    3.540775] pci 0008:01:00.1: BAR 2: assigned [mem 0x10200000-0x102fffff 64bit pref]
[    3.548971] pci 0008:01:00.0: BAR 0: assigned [mem 0x10000000-0x1000ffff 64bit]
[    3.556705] pci 0008:01:00.1: BAR 0: assigned [mem 0x10010000-0x1001ffff 64bit]
[    3.564441] pci 0008:01:00.0: BAR 4: assigned [mem 0x10300000-0x10300fff 64bit pref]
[    3.572635] pci 0008:01:00.1: BAR 4: assigned [mem 0x10301000-0x10301fff 64bit pref]
[    3.580831] pci 0008:00:00.0: PCI bridge to [bus 01]
[    3.586077] pci 0008:00:00.0:   bridge window [mem 0x10000000-0x100fffff]
[    3.593257] pci 0008:00:00.0:   bridge window [mem 0x10100000-0x103fffff 64bit pref]
[    3.601452] pci 0008:00:00.0: Max Payload Size set to  512/ 512 (was  128), Max Read Rq  512
[    3.610381] pci 0008:01:00.0: Max Payload Size set to  512/ 512 (was  128), Max Read Rq  512
[    3.619306] pci 0008:01:00.1: Max Payload Size set to  512/ 512 (was  128), Max Read Rq  512
[    3.629504] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    3.636552] printk: console [ttyS0] disabled
[    3.641070] 68a10000.uart: ttyS0 at MMIO 0x68a10000 (irq = 96, base_baud = 1562500) is a 16550A
[    3.650276] printk: console [ttyS0] enabled
[    3.650276] printk: console [ttyS0] enabled
[    3.659340] printk: bootconsole [uart8250_log0] disabled
[    3.659340] printk: bootconsole [uart8250_log0] disabled
[    3.670959] 68a20000.uart: ttyS2 at MMIO 0x68a20000 (irq = 97, base_baud = 1562500) is a 16550A
[    3.680041] 68a30000.uart: ttyS3 at MMIO 0x68a30000 (irq = 98, base_baud = 1562500) is a 16550A
[    3.689446] iproc-rng200 68b20000.hwrng: hwrng registered
[    3.695330] arm-smmu 64000000.mmu: probing hardware configuration...
[    3.701890] arm-smmu 64000000.mmu: SMMUv2 with:
[    3.706565] arm-smmu 64000000.mmu: 	stage 1 translation
[    3.711956] arm-smmu 64000000.mmu: 	stage 2 translation
[    3.717347] arm-smmu 64000000.mmu: 	nested translation
[    3.722648] arm-smmu 64000000.mmu: 	stream matching with 55 register groups
[    3.729831] arm-smmu 64000000.mmu: 	62 context banks (0 stage-2 only)
[    3.736478] arm-smmu 64000000.mmu: 	Supported page sizes: 0x61311000
[    3.743033] arm-smmu 64000000.mmu: 	Stage-1: 48-bit VA -> 48-bit IPA
[    3.749590] arm-smmu 64000000.mmu: 	Stage-2: 48-bit IPA -> 48-bit PA
[    3.759009] loop: module loaded
[    3.762457] Loading iSCSI transport class v2.0-870.
[    3.767612] iscsi: registered transport (tcp)
[    3.772109] mpt3sas version 27.102.00.00 loaded
[    3.777057] nvme 0000:01:00.0: Adding to iommu group 0
[    3.782555] nvme nvme0: pci function 0000:01:00.0
[    3.787432] nvme 0000:01:00.0: enabling device (0000 -> 0002)
[    3.787446] nvme 0001:01:00.0: Adding to iommu group 1
[    3.798796] nvme nvme1: pci function 0001:01:00.0
[    3.803677] nvme 0001:01:00.0: enabling device (0000 -> 0002)
[    3.803688] nvme 0006:01:00.0: Adding to iommu group 2
[    3.815043] nvme nvme2: pci function 0006:01:00.0
[    3.819916] nvme 0006:01:00.0: enabling device (0000 -> 0002)
[    3.819933] nvme 0007:01:00.0: Adding to iommu group 3
[    3.831284] nvme nvme3: pci function 0007:01:00.0
[    3.836234] nvme 0007:01:00.0: enabling device (0000 -> 0002)
[    3.836345] ahci 67d00000.ahci: masking port_map 0x1 -> 0x1
[    3.847920] ahci 67d00000.ahci: SSS flag set, parallel bus scan disabled
[    3.864899] ahci 67d00000.ahci: AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl platform mode
[    3.873697] ahci 67d00000.ahci: flags: 64bit ncq sntf stag clo pmp fbs slum part
[    3.881660] scsi host0: ahci
[    3.884733] ata1: SATA max UDMA/133 mmio [mem 0x67d00000-0x67d00fff] port 0x100 irq 80
[    3.893015] ahci 67d10000.ahci: masking port_map 0x1 -> 0x1
[    3.898771] ahci 67d10000.ahci: SSS flag set, parallel bus scan disabled
[    3.913291] nvme nvme0: 7/0/0 default/read/poll queues
[    3.915748] ahci 67d10000.ahci: AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl platform mode
[    3.927392] ahci 67d10000.ahci: flags: 64bit ncq sntf stag clo pmp fbs slum part
[    3.929341] nvme nvme1: 7/0/0 default/read/poll queues
[    3.935336] scsi host1: ahci
[    3.939278] nvme nvme2: 8/0/0 default/read/poll queues
[    3.948794] ata2: SATA max UDMA/133 mmio [mem 0x67d10000-0x67d10fff] port 0x100 irq 81
[    3.955337] nvme nvme3: 8/0/0 default/read/poll queues
[    3.957150] ahci 67d20000.ahci: masking port_map 0x1 -> 0x1
[    3.968018] ahci 67d20000.ahci: SSS flag set, parallel bus scan disabled
[    3.984996] ahci 67d20000.ahci: AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl platform mode
[    3.993794] ahci 67d20000.ahci: flags: 64bit ncq sntf stag clo pmp fbs slum part
[    4.001844] scsi host2: ahci
[    4.004895] ata3: SATA max UDMA/133 mmio [mem 0x67d20000-0x67d20fff] port 0x100 irq 82
[    4.013179] ahci 67d30000.ahci: masking port_map 0x1 -> 0x1
[    4.018935] ahci 67d30000.ahci: SSS flag set, parallel bus scan disabled
[    4.035911] ahci 67d30000.ahci: AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl platform mode
[    4.044709] ahci 67d30000.ahci: flags: 64bit ncq sntf stag clo pmp fbs slum part
[    4.052638] scsi host3: ahci
[    4.055679] ata4: SATA max UDMA/133 mmio [mem 0x67d30000-0x67d30fff] port 0x100 irq 83
[    4.063958] ahci 67e00000.ahci: masking port_map 0x1 -> 0x1
[    4.069714] ahci 67e00000.ahci: SSS flag set, parallel bus scan disabled
[    4.086690] ahci 67e00000.ahci: AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl platform mode
[    4.095487] ahci 67e00000.ahci: flags: 64bit ncq sntf stag clo pmp fbs slum part
[    4.103428] scsi host4: ahci
[    4.106472] ata5: SATA max UDMA/133 mmio [mem 0x67e00000-0x67e00fff] port 0x100 irq 84
[    4.114747] ahci 67e10000.ahci: masking port_map 0x1 -> 0x1
[    4.120503] ahci 67e10000.ahci: SSS flag set, parallel bus scan disabled
[    4.137479] ahci 67e10000.ahci: AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl platform mode
[    4.146276] ahci 67e10000.ahci: flags: 64bit ncq sntf stag clo pmp fbs slum part
[    4.154223] scsi host5: ahci
[    4.157264] ata6: SATA max UDMA/133 mmio [mem 0x67e10000-0x67e10fff] port 0x100 irq 85
[    4.165547] ahci 67e20000.ahci: masking port_map 0x1 -> 0x1
[    4.171301] ahci 67e20000.ahci: SSS flag set, parallel bus scan disabled
[    4.188278] ahci 67e20000.ahci: AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl platform mode
[    4.197078] ahci 67e20000.ahci: flags: 64bit ncq sntf stag clo pmp fbs slum part
[    4.205064] scsi host6: ahci
[    4.208111] ata7: SATA max UDMA/133 mmio [mem 0x67e20000-0x67e20fff] port 0x100 irq 86
[    4.211645] ata1: SATA link down (SStatus 0 SControl 300)
[    4.216393] ahci 67e30000.ahci: masking port_map 0x1 -> 0x1
[    4.227607] ahci 67e30000.ahci: SSS flag set, parallel bus scan disabled
[    4.244583] ahci 67e30000.ahci: AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl platform mode
[    4.253380] ahci 67e30000.ahci: flags: 64bit ncq sntf stag clo pmp fbs slum part
[    4.261319] scsi host7: ahci
[    4.264363] ata8: SATA max UDMA/133 mmio [mem 0x67e30000-0x67e30fff] port 0x100 irq 87
[    4.271642] ata2: SATA link down (SStatus 0 SControl 300)
[    4.272988] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xc3
[    4.284656] nand: Micron MT29F8G16ABACAWP
[    4.288792] nand: 1024 MiB, SLC, erase size: 256 KiB, page size: 4096, OOB size: 224
[    4.296786] iproc_nand 68c60000.nand: detected 1024MiB total, 256KiB blocks, 4KiB pages, 16B OOB, 16-bit, BCH-8
[    4.307198] Scanning device for bad blocks
[    4.322603] random: fast init done
[    4.327979] ata3: SATA link down (SStatus 0 SControl 300)
[    4.383645] ata4: SATA link down (SStatus 0 SControl 300)
[    4.429564] ata5: SATA link down (SStatus 0 SControl 300)
[    4.480177] ata6: SATA link down (SStatus 0 SControl 300)
[    4.531646] ata7: SATA link down (SStatus 0 SControl 300)
[    4.587759] ata8: SATA link down (SStatus 0 SControl 300)
[    5.059663] random: crng init done
[    6.156656] libphy: iProc MDIO mux bus: probed
[    6.161259] libphy: mdio_mux: probed
[    6.164963] libphy: mdio_mux: probed
[    6.172752] mdio-mux-iproc 68920000.mdio-mux: iProc mdiomux registered
[    6.179654] libphy: Fixed MDIO Bus: probed
[    6.183882] tun: Universal TUN/TAP device driver, 1.6
[    6.215548] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    6.221568] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    6.227714] usbcore: registered new interface driver r8152
[    6.233384] usbcore: registered new interface driver asix
[    6.238972] usbcore: registered new interface driver ax88179_178a
[    6.245266] usbcore: registered new interface driver cdc_ether
[    6.251291] usbcore: registered new interface driver net1080
[    6.257137] usbcore: registered new interface driver cdc_subset
[    6.263252] usbcore: registered new interface driver zaurus
[    6.269013] usbcore: registered new interface driver cdc_ncm
[    6.274940] VFIO - User Level meta-driver version: 0.3
[    6.280325] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    6.287066] ehci-pci: EHCI PCI platform driver
[    6.291661] ehci-platform: EHCI generic platform driver
[    6.297102] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    6.303480] ohci-pci: OHCI PCI platform driver
[    6.308076] ohci-platform: OHCI generic platform driver
[    6.461533] xhci-hcd 68501000.usb: xHCI Host Controller
[    6.466930] xhci-hcd 68501000.usb: new USB bus registered, assigned bus number 1
[    6.474758] xhci-hcd 68501000.usb: hcc params 0x0250f16d hci version 0x100 quirks 0x0000001000010010
[    6.484195] xhci-hcd 68501000.usb: irq 88, io mem 0x68501000
[    6.490253] hub 1-0:1.0: USB hub found
[    6.494129] hub 1-0:1.0: 2 ports detected
[    6.498354] xhci-hcd 68501000.usb: xHCI Host Controller
[    6.503748] xhci-hcd 68501000.usb: new USB bus registered, assigned bus number 2
[    6.511381] xhci-hcd 68501000.usb: Host supports USB 3.0  SuperSpeed
[    6.517951] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    6.526401] hub 2-0:1.0: USB hub found
[    6.530275] hub 2-0:1.0: 1 port detected
[    6.789529] xhci-hcd 68511000.usb: xHCI Host Controller
[    6.794924] xhci-hcd 68511000.usb: new USB bus registered, assigned bus number 3
[    6.802730] xhci-hcd 68511000.usb: hcc params 0x0250f16d hci version 0x100 quirks 0x0000001000010010
[    6.812162] xhci-hcd 68511000.usb: irq 90, io mem 0x68511000
[    6.818162] hub 3-0:1.0: USB hub found
[    6.822038] hub 3-0:1.0: 2 ports detected
[    6.826250] xhci-hcd 68511000.usb: xHCI Host Controller
[    6.831644] xhci-hcd 68511000.usb: new USB bus registered, assigned bus number 4
[    6.839277] xhci-hcd 68511000.usb: Host supports USB 3.0  SuperSpeed
[    6.845843] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    6.854293] hub 4-0:1.0: USB hub found
[    6.858168] hub 4-0:1.0: 1 port detected
[    6.862337] usbcore: registered new interface driver cdc_acm
[    6.868177] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
[    6.876454] usbcore: registered new interface driver usb-storage
[    6.882674] usbcore: registered new interface driver ftdi_sio
[    6.888609] usbserial: USB Serial support registered for FTDI USB Serial Device
[    6.896176] usbcore: registered new interface driver pl2303
[    6.901931] usbserial: USB Serial support registered for pl2303
[    6.908196] bdc 68502000.usb: Clock not found in Device Tree
[    6.914046] bdc 68502000.usb: Using 2 phy(s)
[    6.918569] bdc 68521000.usb: Clock not found in Device Tree
[    6.924420] bdc 68521000.usb: Using 1 phy(s)
[    6.928997] iproc-rtc rtc: bbl is not powered up:-1
[    6.934071] i2c /dev entries driver
[    6.937828] bcm-iproc-i2c 689b0000.i2c: bus set to 100000 Hz
[    6.943891] bcm-iproc-i2c 689e0000.i2c: bus set to 100000 Hz
[    6.950069] pcf857x 1-0027: probed
[    6.954001] sp805-wdt 689c0000.watchdog: registration successful
[    6.960343] device-mapper: ioctl: 4.40.0-ioctl (2019-01-18) initialised: dm-devel@redhat.com
[    6.969161] sdhci: Secure Digital Host Controller Interface driver
[    6.975539] sdhci: Copyright(c) Pierre Ossman
[    6.980033] sdhci-pltfm: SDHCI platform and OF driver helper
[    6.985942] sdhci-iproc 68cf1000.sdhci: Adding to iommu group 4
[    6.992181] sdhci-iproc 68cf2000.sdhci: Adding to iommu group 5
[    6.998394] EFI Variables Facility v0.08 2004-May-17
[    7.006058] usbcore: registered new interface driver usbhid
[    7.011810] usbhid: USB HID core driver
[    7.015849] NET: Registered protocol family 40
[    7.020694] arm-ccn 61000000.ccn: No access to interrupts, using timer.
[    7.027767] GACT probability on
[    7.031013] Mirror/redirect action on
[    7.034797] Simple TC action Loaded
[    7.038404] u32 classifier
[    7.041193]     Performance counters on
[    7.045149]     input device check on
[    7.048928]     Actions configured
[    7.052482] NET: Registered protocol family 17
[    7.057113] 9pnet: Installing 9P2000 support
[    7.061537] Key type dns_resolver registered
[    7.066164] registered taskstats version 1
[    7.071669] ssp-pl022 68a80000.spi: ARM PL022 driver, device ID: 0x00241022
[    7.078877] ssp-pl022 68a80000.spi: mapped registers from 0x0000000068a80000 to 00000000e6f70134
[    7.087960] ssp-pl022 68a80000.spi: Failed to work in dma mode, work without dma!
[    7.095845] ssp-pl022 68a90000.spi: ARM PL022 driver, device ID: 0x00241022
[    7.103044] ssp-pl022 68a90000.spi: mapped registers from 0x0000000068a90000 to 000000006ead738a
[    7.112127] ssp-pl022 68a90000.spi: Failed to work in dma mode, work without dma!
[    7.120054] pcieport 0000:00:00.0: Adding to iommu group 6
[    7.125835] pcieport 0000:00:00.0: Signaling PME with IRQ 115
[    7.131835] aer 0000:00:00.0:pcie002: AER enabled with IRQ 115
[    7.137947] pcieport 0001:00:00.0: Adding to iommu group 7
[    7.143707] pcieport 0001:00:00.0: Signaling PME with IRQ 117
[    7.149705] aer 0001:00:00.0:pcie002: AER enabled with IRQ 117
[    7.155814] pcieport 0006:00:00.0: Adding to iommu group 8
[    7.161576] pcieport 0006:00:00.0: Signaling PME with IRQ 119
[    7.167570] aer 0006:00:00.0:pcie002: AER enabled with IRQ 119
[    7.173682] pcieport 0007:00:00.0: Adding to iommu group 9
[    7.179440] pcieport 0007:00:00.0: Signaling PME with IRQ 121
[    7.185434] aer 0007:00:00.0:pcie002: AER enabled with IRQ 121
[    7.191539] dma-pl330 68c10000.dma: Adding to iommu group 10
[    7.197913] dma-pl330 68c10000.dma: Loaded driver for PL330 DMAC-241330
[    7.204739] dma-pl330 68c10000.dma: 	DBUFF-1024x8bytes Num_Chans-8 Num_Peri-32 Num_Events-32
[    7.213496] pca953x 0-0020: 0-0020 supply vcc not found, using dummy regulator
[    7.223805] pca953x 0-0020: interrupt support not compiled in
[    7.262798] mmc0: SDHCI controller on 68cf1000.sdhci [68cf1000.sdhci] using ADMA
[    7.299811] mmc1: SDHCI controller on 68cf2000.sdhci [68cf2000.sdhci] using ADMA
[    7.307529] hctosys: unable to open rtc device (rtc0)
[    7.345262] bgmac-enet 68c40000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
[    7.347676] mmc0: new DDR MMC card at address 0001
[    7.359139] mmcblk0: mmc0:0001 MMC16G 14.6 GiB
[    7.364039] mmcblk0boot0: mmc0:0001 MMC16G partition 1 4.00 MiB
[    7.370383] mmcblk0boot1: mmc0:0001 MMC16G partition 2 4.00 MiB
[    7.373529] IP-Config: Complete:
[    7.379821]      device=eth0, hwaddr=00:0a:f7:95:62:82, ipaddr=10.136.13.31, mask=255.255.255.0, gw=10.136.13.1
[    7.385554] mmcblk0rpmb: mmc0:0001 MMC16G partition 3 128 KiB, chardev (243:0)
[    7.390230]      host=10.136.13.31, domain=, nis-domain=(none)
[    7.390232]      bootserver=10.136.4.151, rootserver=10.136.4.151, rootpath=
[    7.407033]  mmcblk0: p1 p2 p3 p4 p5
[    7.414832] ttyS0 - failed to request DMA
[    7.418991] md: Waiting for all devices to be available before autodetect
[    7.425994] md: If you don't use raid, use raid=noautodetect
[    7.431982] md: Autodetecting RAID arrays.
[    7.436211] md: autorun ...
[    7.439100] md: ... autorun DONE.
[    7.554110] EXT4-fs (mmcblk0p4): recovery complete
[    8.182668] EXT4-fs (mmcblk0p4): mounted filesystem with ordered data mode. Opts: (null)
[    8.191034] VFS: Mounted root (ext4 filesystem) on device 179:4.
[    8.205797] devtmpfs: mounted
[    8.209102] Freeing unused kernel memory: 960K
[    8.213745] Run /sbin/init as init process
[    8.440141] systemd[1]: System time before build time, advancing clock.
[    8.487204] NET: Registered protocol family 10
[    8.492071] Segment Routing with IPv6
[    8.535583] systemd[1]: systemd 237 running in system mode. (-PAM -AUDIT -SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP -LIBCRYPTSETUP -GCRYPT -GNUTLS +ACL +XZ -LZ4 -SECCOMP +BLKID -ELFUTILS +KMOD -IDN2 -IDN -PCRE2 default-hierarchy=hybrid)
[    8.557661] systemd[1]: Detected architecture arm64.


root@bcm958742k:~# cat /proc/iomem
10000000-2fffffff : pcie@60400000
  10000000-100fffff : PCI Bus 0008:01
    10000000-1000ffff : 0008:01:00.0
      10000000-1000ffff : bnxt_en
    10010000-1001ffff : 0008:01:00.1
      10010000-1001ffff : bnxt_en
  10100000-103fffff : PCI Bus 0008:01
    10100000-101fffff : 0008:01:00.0
      10100000-101fffff : bnxt_en
    10200000-102fffff : 0008:01:00.1
      10200000-102fffff : bnxt_en
    10300000-10300fff : 0008:01:00.0
      10300000-10300fff : bnxt_en
    10301000-10301fff : 0008:01:00.1
      10301000-10301fff : bnxt_en
40000000-400001ff : 40000000.phy
61000000-618fffff : 61000000.ccn
64000000-6407ffff : 64000000.mmu
6641c400-6641c467 : 6641c400.otp
66424024-6642402b : 66424024.mailbox
66424800-6642484b : 66424800.gpio
67d00000-67d00fff : 67d00000.ahci
67d02100-67d030ff : 67d02100.sata_phy
67d10000-67d10fff : 67d10000.ahci
67d12100-67d130ff : 67d12100.sata_phy
67d20000-67d20fff : 67d20000.ahci
67d22100-67d230ff : 67d22100.sata_phy
67d30000-67d30fff : 67d30000.ahci
67d32100-67d330ff : 67d32100.sata_phy
67e00000-67e00fff : 67e00000.ahci
67e02100-67e030ff : 67e02100.sata_phy
67e10000-67e10fff : 67e10000.ahci
67e12100-67e130ff : 67e12100.sata_phy
67e20000-67e20fff : 67e20000.ahci
67e22100-67e230ff : 67e22100.sata_phy
67e30000-67e30fff : 67e30000.ahci
67e32100-67e330ff : 67e32100.sata_phy
68500000-685000ff : 68500000.usb-phy
68501000-68501fff : 68501000.usb
68502000-68502fff : 68502000.usb
68510000-685100ff : 68510000.usb-phy
68511000-68511fff : 68511000.usb
68520000-685200ff : 68520000.usb-phy
68521000-68521fff : 68521000.usb
68910000-68910fff : 68910000.pwm
68920000-6892024f : 68920000.mdio-mux
68940000-68940fff : timer@40000
689b0000-689b00ff : 689b0000.i2c
689c0000-689c0fff : watchdog@c0000
  689c0000-689c0fff : 689c0000.watchdog
689d0000-689d0863 : 689d0000.gpio
689e0000-689e00ff : 689e0000.i2c
68a10000-68a1001f : serial
68a20000-68a2001f : serial
68a30000-68a3001f : serial
68a40000-68a4024f : pinctrl-single
68a4029c-68a404eb : pinctrl-single
68a80000-68a80fff : spi@180000
  68a80000-68a80fff : ssp-pl022
68a90000-68a90fff : spi@190000
  68a90000-68a90fff : ssp-pl022
68b20000-68b20027 : 68b20000.hwrng
68c10000-68c10fff : dma@310000
  68c10000-68c10fff : 68c10000.dma
68c40000-68c40fff : 68c40000.ethernet
68c60000-68c605ff : 68c60000.nand
68c60f00-68c60f1f : 68c60000.nand
68cf1000-68cf10ff : 68cf1000.sdhci
68cf2000-68cf20ff : 68cf2000.sdhci
68e0a408-68e0aa07 : 68c60000.nand
80000000-8569ffff : System RAM
  80280000-80f3ffff : Kernel code
  80f40000-8102ffff : reserved
  81030000-81149fff : Kernel data
856a0000-8573ffff : reserved
85740000-85839fff : System RAM
8583a000-858cffff : reserved
858d0000-858fffff : System RAM
85900000-8597ffff : reserved
85980000-85a0ffff : System RAM
  85980000-85a0ffff : reserved
85a10000-85d7ffff : reserved
85d80000-85d9ffff : System RAM
  85d80000-85d9ffff : reserved
85da0000-85f7ffff : reserved
85f80000-8af4ffff : System RAM
  85f80000-85f80fff : reserved
  85f83000-85f83fff : reserved
  893b3000-893b3fff : reserved
8af50000-8af8ffff : reserved
8af90000-8af9ffff : System RAM
8afa0000-8afeffff : reserved
8aff0000-8cffffff : System RAM
8f220000-ffffffff : System RAM
  9bc00000-dfbfffff : reserved
  dfe00000-ffdfffff : Crash kernel
400000000-46fffffff : pcie@48000000
470000000-47fffffff : pcie@48000000
  470000000-4700fffff : PCI Bus 0000:01
    470000000-470003fff : 0000:01:00.0
      470000000-470003fff : nvme
480000000-4efffffff : pcie@48004000
4f0000000-4ffffffff : pcie@48004000
  4f0000000-4f00fffff : PCI Bus 0001:01
    4f0000000-4f0003fff : 0001:01:00.0
      4f0000000-4f0003fff : nvme
700000000-76fffffff : pcie@48018000
770000000-77fffffff : pcie@48018000
  770000000-7700fffff : PCI Bus 0006:01
    770000000-77000ffff : 0006:01:00.0
    770010000-770013fff : 0006:01:00.0
      770010000-770013fff : nvme
780000000-7dfffffff : pcie@4801c000
7e0000000-7efffffff : pcie@4801c000
7f0000000-7ffffffff : pcie@4801c000
  7f0000000-7f00fffff : PCI Bus 0007:01
    7f0000000-7f000ffff : 0007:01:00.0
    7f0010000-7f0013fff : 0007:01:00.0
      7f0010000-7f0013fff : nvme
880400000-bffffffff : System RAM
9000000000-93ffffffff : System RAM
a000000000-a3ffffffff : System RAM
  a3bfc00000-a3bfc28fff : reserved
  a3c3c00000-a3c9dfffff : reserved
  a3c9fad000-a3f9dfffff : reserved
  a3f9e96000-a3f9ef5fff : reserved
  a3f9ef6000-a3f9ef6fff : reserved
  a3f9ef7000-a3f9faefff : reserved
  a3f9fb1000-a3f9fb1fff : reserved
  a3f9fb2000-a3f9fb9fff : reserved
  a3f9fba000-a3f9fdffff : reserved
  a3f9fe0000-a3ffffffff : reserved

kdump.conf was setting crashkernel out of laziness I assume. It didn't
override the default boot parameter. It did set maxcpus to 1.
KDUMP_CMDLINE="`cat /proc/cmdline` maxcpus=1"

I've changed it to this which gets rid of the crash dump allocation
failure and cma allocation failure (reduced cma from 1G to 128M):

KDUMP_CMDLINE="`cat /proc/cmdline` maxcpus=1 crashkernel=0 cma=128M"

But the result is the same:

  root@bcm958742k:~# echo c > /proc/sysrq-trigger
[  547.274248] sysrq: Trigger a crash
[  547.277759] Kernel panic - not syncing: sysrq triggered crash
[  547.283688] CPU: 7 PID: 3821 Comm: sh Kdump: loaded Tainted: G           O      5.1.0 #1
[  547.292034] Hardware name: BRCM BRCM-SR/BRCM-SR, BIOS 0.1 May 31 2019
[  547.298677] Call trace:
[  547.301207]  dump_backtrace+0x0/0x170
[  547.304984]  show_stack+0x14/0x20
[  547.308404]  dump_stack+0xa8/0xcc
[  547.311823]  panic+0x140/0x2f4
[  547.314973]  sysrq_handle_crash+0x14/0x18
[  547.319108]  __handle_sysrq+0x98/0x188
[  547.322974]  write_sysrq_trigger+0x64/0x80
[  547.327200]  proc_reg_write+0x60/0xa8
[  547.330977]  __vfs_write+0x18/0x38
[  547.334484]  vfs_write+0xa4/0x1b8
[  547.337901]  ksys_write+0x64/0xe8
[  547.341319]  __arm64_sys_write+0x14/0x20
[  547.345365]  el0_svc_common.constprop.0+0x58/0xf0
[  547.350217]  el0_svc_handler+0x28/0x78
[  547.354083]  el0_svc+0x8/0xc
[  547.357060] SMP: stopping secondary CPUs
[  547.362272] Starting crashdump kernel...
[  547.366319] Bye!
[    0.000000] Booting Linux on physical CPU 0x0000000301 [0x410fd083]
[    0.000000] Linux version 5.1.0 (oe-user@oe-host) (gcc version 7.3.0 (GCC)) #1 SMP Thu Jun 6 21:06:41 UTC 2019
[    0.000000] Machine model: Stingray Combo SVK w/PAXB IOMMU (BCM958742K)
[    0.000000] earlycon: uart8250_log0 at MMIO32 0x0000000068a10000 (options '')
[    0.000000] printk: bootconsole [uart8250_log0] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.70 by EDK II
[    0.000000] efi:  SMBIOS=0x85cd0000  SMBIOS 3.0=0x85a20000  ACPI 2.0=0x85d90000  MEMATTR=0x893b3118  MEMRESERVE=0x85f83018
[    0.000000] Reserving 2KB of memory at 0xffdff000 for elfcorehdr
[    0.000000] cma: Reserved 128 MiB at 0x00000000f7c00000
[    0.000000] psci: probing for conduit method from DT.
I: GICv3 without legacy support detected. ARM GICV3 driver initialized in EL3
    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] random: get_random_bytes called from start_kernel+0xa4/0x448 with crng_init=0
[    0.000000] percpu: Embedded 23 pages/cpu s53848 r8192 d32168 u94208
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: EL2 vector hardening
[    0.000000] Speculative Store Bypass Disable mitigation not required
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 130935
[    0.000000] Kernel command line: FS2:\Image.1  root=/dev/mmcblk0p4 rw rootwait  earlycon=uart8250_log,mmio32,0x68A10000 earlylog=0x8f110000,0x10000 console=ttyS0,115200n8 hugepages=0 cma=1G crashkernel=512M pci=pcie_bus_safe pciehp.pciehp_poll_mode=1 pciehp.pciehp_poll_time=5 pcie_ports=native maxcpus=8  bgmac_platform.ethaddr=00:0A:F7:95:62:82 ip=10.136.13.31:10.136.4.151:10.136.13.1:255.255.255.0:::off  loglevel=7 maxcpus=1 crashkernel=0 cma=128M
[    0.000000] Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.000000] Memory: 342428K/532056K available (9532K kernel code, 748K rwdata, 3488K rodata, 960K init, 364K bss, 58556K reserved, 131072K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] GICv3: no VLPI support, no direct LPI support
[    0.000000] GICv3: CPU0: found redistributor 301 region 0:0x0000000063ee0000
[    0.000000] ITS [mem 0x63c20000-0x63c2ffff]
[    0.000000] ITS@0x0000000063c20000: allocated 32768 Devices @f5480000 (flat, esz 8, psz 64K, shr 0)
[    0.000000] ITS: using cache flushing for cmd queue
[    0.000000] Unable to handle kernel paging request at virtual address ffff80a343836004
[    0.000000] Mem abort info:
[    0.000000]   ESR = 0x96000004
[    0.000000]   Exception class = DABT (current EL), IL = 32 bits
[    0.000000]   SET = 0, FnV = 0
[    0.000000]   EA = 0, S1PTW = 0
[    0.000000] Data abort info:
[    0.000000]   ISV = 0, ISS = 0x00000004
[    0.000000]   CM = 0, WnR = 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
[    0.000000] [ffff80a343836004] pgd=0000000000000000
[    0.000000] Internal error: Oops: 96000004 [#1] SMP
[    0.000000] Modules linked in:
[    0.000000] Process swapper/0 (pid: 0, stack limit = 0x(____ptrval____))
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.1.0 #1
[    0.000000] Hardware name: Stingray Combo SVK w/PAXB IOMMU (BCM958742K) (DT)
[    0.000000] pstate: 60000085 (nZCv daIf -PAN -UAO)
[    0.000000] pc : efi_mem_reserve_persistent+0x60/0x1b8
[    0.000000] lr : efi_mem_reserve_persistent+0x1a0/0x1b8
[    0.000000] sp : ffff000010e33c40
[    0.000000] x29: ffff000010e33c40 x28: ffff800075409200
[    0.000000] x27: ffff000010f2e000 x26: 0000000000000000
[    0.000000] x25: ffff000010060000 x24: 0000000000000008
[    0.000000] x23: 0000000000010000 x22: ffff000010cd6000
[    0.000000] x21: 00000000f5450000 x20: 0000000000010000
[    0.000000] x19: ffff000010f2e000 x18: ffffffffffffffff
[    0.000000] x17: 0000000000000000 x16: 0000000000000000
[    0.000000] x15: ffff000010e3c688 x14: ffff8000754334b5
[    0.000000] x13: ffff000010cd6000 x12: ffff000010005fff
[    0.000000] x11: ffff000010005000 x10: 0000000085f84000
[    0.000000] x9 : 0000000000000000 x8 : 0040000000000001
[    0.000000] x7 : ffff000010005000 x6 : ffff000010cd6000
[    0.000000] x5 : ffff80007fdfd408 x4 : ffff000010005fff
[    0.000000] x3 : ffff80a343836000 x2 : 0000000080000000
[    0.000000] x1 : ffff000010005018 x0 : 0000000000000000
[    0.000000] Call trace:
[    0.000000]  efi_mem_reserve_persistent+0x60/0x1b8
[    0.000000]  its_init+0xa44/0xe80
[    0.000000]  gic_of_init+0x474/0x4d0
[    0.000000]  of_irq_init+0x194/0x2ec
[    0.000000]  irqchip_init+0x14/0x1c
[    0.000000]  init_IRQ+0xe4/0x118
[    0.000000]  start_kernel+0x2b0/0x448
[    0.000000] Code: b40002c3 f94044c2 cb020063 b2514063 (b9400461)
[    0.000000] ---[ end trace 201d7d1205871a19 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

