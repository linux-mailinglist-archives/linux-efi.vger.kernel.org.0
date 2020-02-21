Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8BB167EB9
	for <lists+linux-efi@lfdr.de>; Fri, 21 Feb 2020 14:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgBUNfi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Feb 2020 08:35:38 -0500
Received: from foss.arm.com ([217.140.110.172]:39478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbgBUNfi (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 21 Feb 2020 08:35:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C24030E;
        Fri, 21 Feb 2020 05:35:36 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1ABC73F703;
        Fri, 21 Feb 2020 05:35:34 -0800 (PST)
Subject: Re: [PATCH v2 0/4] ARM: decompressor: use by-VA cache maintenance for
 v7 cores
To:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20200219094340.16597-1-ardb@kernel.org>
 <CAKv+Gu_aL_=W7qMuLwu+427=DSgj5Kmg7Qm0ujooxS9s=zDT2g@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <fa6aa783-0b01-9d29-03be-3ec8d352f373@arm.com>
Date:   Fri, 21 Feb 2020 13:35:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_aL_=W7qMuLwu+427=DSgj5Kmg7Qm0ujooxS9s=zDT2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 20/02/2020 6:08 pm, Ard Biesheuvel wrote:
> (+ Arnd)
> 
> On Wed, 19 Feb 2020 at 10:43, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> While making changes to the EFI stub startup code, I noticed that we are
>> still doing set/way maintenance on the caches when booting on v7 cores.
>> This works today on VMs by virtue of the fact that KVM traps set/way ops
>> and cleans the whole address space by VA on behalf of the guest, and on
>> most v7 hardware, the set/way ops are in fact sufficient when only one
>> core is running, as there usually is no system cache. But on systems
>> like SynQuacer, for which 32-bit firmware is available, the current cache
>> maintenance only pushes the data out to the L3 system cache, where it
>> is not visible to the CPU once it turns the MMU and caches off.
>>
>> So instead, switch to the by-VA cache maintenance that the architecture
>> requires for v7 and later (and ARM1176, as a side effect).
>>
>> Changes since v1:
>> - include the EFI patch that was sent out separately before (#1)
>> - split the preparatory work to pass the region to clean in r0/r1 in a EFI
>>    specific one and one for the decompressor - this way, the first two patches
>>    can go on a stable branch that is shared between the ARM tree and the EFI
>>    tree
>> - document the meaning of the values in r0/r1 upon entry to cache_clean_flush
>> - take care to treat the region end address as exclusive
>> - switch to clean+invalidate to align with the other implementations
>> - drop some code that manages the stack pointer value before calling
>>    cache_clean_flush(), which is no longer necessary
>> - take care to clean the entire region that is covered by the relocated zImage
>>    if it needs to relocate itself before decompressing
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=arm32-efi-cache-ops
>>
> 
> Adding my own data point here: with these patches, I can reproducibly
> boot on the SynQuacer platform (24x Cortex-A53 + GICv3 + L3 system
> cache) until the point where /init is loaded, after which it hangs
> (see below), whereas without them, it always crashes early with weird,
> unreproducible errors, if it even makes it far enough through the
> decompressor to produce any earlycon output.
> 
> There is some other weird stuff going on, but this is unlikely to be
> related to cache maintenance:
> - multiple occurrences of
>     OF: translation of DMA address(0) to CPU address failed node(...)

FWIW that implies a "dma-ranges" property in the wrong place in the DT - 
if you copied the now-gone Juno example of placing one directly in the 
root node, that was bogus, sorry.

> - /cpus/cpu@0: unsupported enable-method property: psci

Missing CONFIG_ARM_PSCI_CPUIDLE? That's caught me out on more than one 
occasion since 5.4.

Robin.

> Then, there is not enough vmalloc space to map the config space of
> both PCIe RCs.
> 
> Also, due to the fact that this platform sadly honours the ARM
> recommendation on memory maps, it seems there is no way to make useful
> use of any memory beyond 2 GB, given that the hole between the lower 2
> GB and the upper <30 GB eats up all the lowmem by being covered by the
> memmap[] array. (Note that this platform supports up to 64 GB, in
> which case another hole of 480 GB is created, so there is no way we
> can even boot with that much memory reported to the kernel)
> 
> 
> Shell> initrd initrd.gz
> Shell> zImage
> EFI stub: Booting Linux Kernel...
> EFI stub: Using DTB from configuration table
> EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
> EFI stub: Exiting boot services and installing virtual address map...
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 5.6.0-rc1-00084-g8602a0ff0200-dirty
> (ardbie01@e123331-lin) (gcc version 7.4.0 (Ubuntu/Linaro
> 7.4.0-1ubuntu1~18.04.1)) #286 SMP Thu Feb 20 17:49:59 CET 2020
> [    0.000000] CPU: ARMv7 Processor [410fd034] revision 4 (ARMv7), cr=70c5383d
> [    0.000000] CPU: div instructions available: patching division code
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
> instruction cache
> [    0.000000] OF: fdt: Machine model: Socionext Developer Box
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] efi: EFI v2.70 by EDK II
> [    0.000000] efi:  SMBIOS 3.0=0xffa1c000  MEMATTR=0xfd0b4010
> ESRT=0xfdfbb910  MEMRESERVE=0xf8f2d010
> [    0.000000] OF: fdt: Ignoring memory block 0x880000000 - 0x1000000000
> [    0.000000] esrt: Reserving ESRT space from 0x00000000fdfbb910 to
> 0x00000000fdfbb948.
> [    0.000000] cma: Reserved 64 MiB at 0x00000000f9000000
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] psci: PSCIv1.1 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: MIGRATE_INFO_TYPE not supported.
> [    0.000000] psci: SMC Calling Convention v1.0
> [    0.000000] percpu: Embedded 20 pages/cpu s49356 r8192 d24372 u81920
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 522368
> [    0.000000] Kernel command line: zImage
> [    0.000000] printk: log_buf_len individual max cpu contribution: 4096 bytes
> [    0.000000] printk: log_buf_len total cpu_extra contributions: 94208 bytes
> [    0.000000] printk: log_buf_len min size: 131072 bytes
> [    0.000000] printk: log_buf_len: 262144 bytes
> [    0.000000] printk: early log buf free: 128828(98%)
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7,
> 524288 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144
> bytes, linear)
> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.000000] software IO TLB: mapped [mem 0xaa90c000-0xae90c000] (64MB)
> [    0.000000] Memory: 1886672K/2097152K available (10240K kernel
> code, 1811K rwdata, 5392K rodata, 2048K init, 414K bss, 144944K
> reserved, 65536K cma-reserved, 1233168K highmem)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=24, Nodes=1
> [    0.000000] rcu: Hierarchical RCU implementation.
> [    0.000000] rcu:     RCU event tracing is enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
> is 10 jiffies.
> [    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
> [    0.000000] GICv3: 640 SPIs implemented
> [    0.000000] GICv3: 0 Extended SPIs implemented
> [    0.000000] GICv3: Distributor has no Range Selector support
> [    0.000000] GICv3: 16 PPIs implemented
> [    0.000000] GICv3: no VLPI support, no direct LPI support, no RVPEID support
> [    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000000030400000
> [    0.000000] ITS [mem 0x30020000-0x3003ffff]
> [    0.000000] GIC: enabling workaround for ITS: Socionext Synquacer pre-ITS
> [    0.000000] ITS@0x0000000030020000: allocated 524288 Devices
> @aa400000 (flat, esz 8, psz 64K, shr 0)
> [    0.000000] ITS: using cache flushing for cmd queue
> [    0.000000] GICv3: using LPI property table @0x00000000aa080000
> [    0.000000] GIC: using cache flushing for LPI property table
> [    0.000000] GICv3: CPU0: using allocated LPI pending table
> @0x00000000aa090000
> [    0.000000] random: get_random_bytes called from
> start_kernel+0x469/0x5ca with crng_init=0
> [    0.000000] arch_timer: cp15 and mmio timer(s) running at 100.00MHz
> (virt/phys).
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
> max_cycles: 0x171024e7e0, max_idle_ns: 440795205315 ns
> [    0.000004] sched_clock: 56 bits at 100MHz, resolution 10ns, wraps
> every 4398046511100ns
> [    0.000013] Switching to timer-based delay loop, resolution 10ns
> [    0.000890] Console: colour dummy device 80x30
> [    0.001344] printk: console [tty0] enabled
> [    0.001389] Calibrating delay loop (skipped), value calculated
> using timer frequency.. 200.00 BogoMIPS (lpj=1000000)
> [    0.001410] pid_max: default: 32768 minimum: 301
> [    0.001561] Mount-cache hash table entries: 2048 (order: 1, 8192
> bytes, linear)
> [    0.001581] Mountpoint-cache hash table entries: 2048 (order: 1,
> 8192 bytes, linear)
> [    0.002112] CPU: Testing write buffer coherency: ok
> [    0.002637] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.002926] Setting up static identity map for 0x80400000 - 0x80400160
> [    0.003448] rcu: Hierarchical SRCU implementation.
> [    0.003601] Platform MSI: gic-its@30020000 domain created
> [    0.003669] PCI/MSI:
> /interrupt-controller@30000000/gic-its@30020000 domain created
> [    0.004751] Remapping and enabling EFI services.
> [    0.005305] smp: Bringing up secondary CPUs ...
> [    0.005895] GICv3: CPU1: found redistributor 1 region 0:0x0000000030420000
> [    0.005919] GICv3: CPU1: using allocated LPI pending table
> @0x00000000aa0a0000
> [    0.005940] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> [    0.011149] GICv3: CPU2: found redistributor 100 region 0:0x0000000030440000
> [    0.011179] GICv3: CPU2: using allocated LPI pending table
> @0x00000000aa0b0000
> [    0.011203] CPU2: thread -1, cpu 0, socket 1, mpidr 80000100
> [    0.014242] GICv3: CPU3: found redistributor 101 region 0:0x0000000030460000
> [    0.014264] GICv3: CPU3: using allocated LPI pending table
> @0x00000000aa0c0000
> [    0.014284] CPU3: thread -1, cpu 1, socket 1, mpidr 80000101
> [    0.019622] GICv3: CPU4: found redistributor 200 region 0:0x0000000030480000
> [    0.019650] GICv3: CPU4: using allocated LPI pending table
> @0x00000000aa0d0000
> [    0.019675] CPU4: thread -1, cpu 0, socket 2, mpidr 80000200
> [    0.022737] GICv3: CPU5: found redistributor 201 region 0:0x00000000304a0000
> [    0.022759] GICv3: CPU5: using allocated LPI pending table
> @0x00000000aa0e0000
> [    0.022777] CPU5: thread -1, cpu 1, socket 2, mpidr 80000201
> [    0.028146] GICv3: CPU6: found redistributor 300 region 0:0x00000000304c0000
> [    0.028174] GICv3: CPU6: using allocated LPI pending table
> @0x00000000aa0f0000
> [    0.028196] CPU6: thread -1, cpu 0, socket 3, mpidr 80000300
> [    0.031213] GICv3: CPU7: found redistributor 301 region 0:0x00000000304e0000
> [    0.031239] GICv3: CPU7: using allocated LPI pending table
> @0x00000000aa100000
> [    0.031256] CPU7: thread -1, cpu 1, socket 3, mpidr 80000301
> [    0.036606] GICv3: CPU8: found redistributor 400 region 0:0x0000000030500000
> [    0.036634] GICv3: CPU8: using allocated LPI pending table
> @0x00000000aa110000
> [    0.036657] CPU8: thread -1, cpu 0, socket 4, mpidr 80000400
> [    0.039719] GICv3: CPU9: found redistributor 401 region 0:0x0000000030520000
> [    0.039740] GICv3: CPU9: using allocated LPI pending table
> @0x00000000aa120000
> [    0.039757] CPU9: thread -1, cpu 1, socket 4, mpidr 80000401
> [    0.045156] GICv3: CPU10: found redistributor 500 region 0:0x0000000030540000
> [    0.045187] GICv3: CPU10: using allocated LPI pending table
> @0x00000000aa130000
> [    0.045210] CPU10: thread -1, cpu 0, socket 5, mpidr 80000500
> [    0.048241] GICv3: CPU11: found redistributor 501 region 0:0x0000000030560000
> [    0.048263] GICv3: CPU11: using allocated LPI pending table
> @0x00000000aa140000
> [    0.048282] CPU11: thread -1, cpu 1, socket 5, mpidr 80000501
> [    0.053651] GICv3: CPU12: found redistributor 600 region 0:0x0000000030580000
> [    0.053681] GICv3: CPU12: using allocated LPI pending table
> @0x00000000aa150000
> [    0.053706] CPU12: thread -1, cpu 0, socket 6, mpidr 80000600
> [    0.056742] GICv3: CPU13: found redistributor 601 region 0:0x00000000305a0000
> [    0.056765] GICv3: CPU13: using allocated LPI pending table
> @0x00000000aa160000
> [    0.056785] CPU13: thread -1, cpu 1, socket 6, mpidr 80000601
> [    0.062113] GICv3: CPU14: found redistributor 700 region 0:0x00000000305c0000
> [    0.062144] GICv3: CPU14: using allocated LPI pending table
> @0x00000000aa170000
> [    0.062166] CPU14: thread -1, cpu 0, socket 7, mpidr 80000700
> [    0.065238] GICv3: CPU15: found redistributor 701 region 0:0x00000000305e0000
> [    0.065263] GICv3: CPU15: using allocated LPI pending table
> @0x00000000aa180000
> [    0.065282] CPU15: thread -1, cpu 1, socket 7, mpidr 80000701
> [    0.070661] GICv3: CPU16: found redistributor 800 region 0:0x0000000030600000
> [    0.070691] GICv3: CPU16: using allocated LPI pending table
> @0x00000000aa190000
> [    0.070716] CPU16: thread -1, cpu 0, socket 8, mpidr 80000800
> [    0.073748] GICv3: CPU17: found redistributor 801 region 0:0x0000000030620000
> [    0.073774] GICv3: CPU17: using allocated LPI pending table
> @0x00000000aa1a0000
> [    0.073794] CPU17: thread -1, cpu 1, socket 8, mpidr 80000801
> [    0.079132] GICv3: CPU18: found redistributor 900 region 0:0x0000000030640000
> [    0.079163] GICv3: CPU18: using allocated LPI pending table
> @0x00000000aa1b0000
> [    0.079187] CPU18: thread -1, cpu 0, socket 9, mpidr 80000900
> [    0.082216] GICv3: CPU19: found redistributor 901 region 0:0x0000000030660000
> [    0.082239] GICv3: CPU19: using allocated LPI pending table
> @0x00000000aa1c0000
> [    0.082257] CPU19: thread -1, cpu 1, socket 9, mpidr 80000901
> [    0.087755] GICv3: CPU20: found redistributor a00 region 0:0x0000000030680000
> [    0.087788] GICv3: CPU20: using allocated LPI pending table
> @0x00000000aa1d0000
> [    0.087811] CPU20: thread -1, cpu 0, socket 10, mpidr 80000a00
> [    0.090897] GICv3: CPU21: found redistributor a01 region 0:0x00000000306a0000
> [    0.090922] GICv3: CPU21: using allocated LPI pending table
> @0x00000000aa1e0000
> [    0.090939] CPU21: thread -1, cpu 1, socket 10, mpidr 80000a01
> [    0.096296] GICv3: CPU22: found redistributor b00 region 0:0x00000000306c0000
> [    0.096329] GICv3: CPU22: using allocated LPI pending table
> @0x00000000aa1f0000
> [    0.096353] CPU22: thread -1, cpu 0, socket 11, mpidr 80000b00
> [    0.099356] GICv3: CPU23: found redistributor b01 region 0:0x00000000306e0000
> [    0.099381] GICv3: CPU23: using allocated LPI pending table
> @0x00000000aa200000
> [    0.099400] CPU23: thread -1, cpu 1, socket 11, mpidr 80000b01
> [    0.099506] smp: Brought up 1 node, 24 CPUs
> [    0.100163] SMP: Total of 24 processors activated (4800.00 BogoMIPS).
> [    0.100175] CPU: All CPU(s) started in SVC mode.
> [    0.101193] devtmpfs: initialized
> [    0.103698] VFP support v0.3: implementor 41 architecture 3 part 40
> variant 3 rev 4
> [    0.103980] clocksource: jiffies: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 19112604462750000 ns
> [    0.104009] futex hash table entries: 8192 (order: 7, 524288 bytes, linear)
> [    0.106670] pinctrl core: initialized pinctrl subsystem
> [    0.107566] thermal_sys: Registered thermal governor 'step_wise'
> [    0.107754] SMBIOS 3.3.0 present.
> [    0.107788] DMI: Socionext SynQuacer E-series DeveloperBox, BIOS
> build #1 Feb 20 2020
> [    0.108185] NET: Registered protocol family 16
> [    0.109556] DMA: preallocated 256 KiB pool for atomic coherent allocations
> [    0.110957] cpuidle: using governor menu
> [    0.111063] No ATAGs?
> [    0.111467] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4
> watchpoint registers.
> [    0.111490] hw-breakpoint: maximum watchpoint size is 8 bytes.
> [    0.112874] Serial: AMBA PL011 UART driver
> [    0.114349] OF: translation of DMA address(0) to CPU address failed
> node(/uart@2a400000)
> [    0.114421] 2a400000.uart: ttyAMA0 at MMIO 0x2a400000 (irq = 22,
> base_baud = 0) is a PL011 rev3
> [    1.117194] printk: console [ttyAMA0] enabled
> [    1.135592] AT91: Could not find identification node
> [    1.136261] iommu: Default domain type: Translated
> [    1.146225] vgaarb: loaded
> [    1.149407] SCSI subsystem initialized
> [    1.153506] usbcore: registered new interface driver usbfs
> [    1.159042] usbcore: registered new interface driver hub
> [    1.164477] usbcore: registered new device driver usb
> [    1.169950] pps_core: LinuxPPS API ver. 1 registered
> [    1.174911] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
> Rodolfo Giometti <giometti@linux.it>
> [    1.184062] PTP clock support registered
> [    1.188042] EDAC MC: Ver: 3.0.0
> [    1.191660] Registered efivars operations
> [    1.196838] clocksource: Switched to clocksource arch_sys_counter
> [    2.103835] NET: Registered protocol family 2
> [    2.108658] tcp_listen_portaddr_hash hash table entries: 512
> (order: 0, 6144 bytes, linear)
> [    2.117044] TCP established hash table entries: 8192 (order: 3,
> 32768 bytes, linear)
> [    2.124854] TCP bind hash table entries: 8192 (order: 4, 65536 bytes, linear)
> [    2.132103] TCP: Hash tables configured (established 8192 bind 8192)
> [    2.138585] UDP hash table entries: 512 (order: 2, 16384 bytes, linear)
> [    2.145223] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes, linear)
> [    2.152446] NET: Registered protocol family 1
> [    2.157108] RPC: Registered named UNIX socket transport module.
> [    2.163026] RPC: Registered udp transport module.
> [    2.167746] RPC: Registered tcp transport module.
> [    2.172445] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    2.178897] PCI: CLS 0 bytes, default 64
> [    2.183052] Trying to unpack rootfs image as initramfs...
> [    3.413006] Freeing initrd memory: 22816K
> [    3.418665] Initialise system trusted keyrings
> [    3.423276] workingset: timestamp_bits=30 max_order=19 bucket_order=0
> [    3.434628] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [    3.441097] NFS: Registering the id_resolver key type
> [    3.446175] Key type id_resolver registered
> [    3.450375] Key type id_legacy registered
> [    3.454388] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
> [    3.461111] ntfs: driver 2.1.32 [Flags: R/O].
> [    3.465747] Key type asymmetric registered
> [    3.469857] Asymmetric key parser 'x509' registered
> [    3.474765] bounce: pool size: 64 pages
> [    3.478629] Block layer SCSI generic (bsg) driver version 0.4
> loaded (major 247)
> [    3.486027] io scheduler mq-deadline registered
> [    3.490564] io scheduler kyber registered
> [    3.500170] OF: translation of DMA address(0) to CPU address failed
> node(/pcie@60000000)
> [    3.508318] pci-host-generic 60000000.pcie: host bridge
> /pcie@60000000 ranges:
> [    3.515556] pci-host-generic 60000000.pcie:       IO
> 0x0067f00000..0x0067f0ffff -> 0x0000000000
> [    3.524276] pci-host-generic 60000000.pcie:      MEM
> 0x0068000000..0x006fffffff -> 0x0068000000
> [    3.532987] pci-host-generic 60000000.pcie:      MEM
> 0x3e00000000..0x3effffffff -> 0x3e00000000
> [    3.543045] pci-host-generic 60000000.pcie: ECAM at [mem
> 0x60000000-0x67efffff] for [bus 00-7e]
> [    3.551873] pci-host-generic 60000000.pcie: PCI host bridge to bus 0000:00
> [    3.558764] pci_bus 0000:00: root bus resource [bus 00-7e]
> [    3.564250] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> [    3.570438] pci_bus 0000:00: root bus resource [mem 0x68000000-0x6fffffff]
> [    3.577322] pci_bus 0000:00: root bus resource [mem
> 0x3e00000000-0x3effffffff]
> [    3.584574] pci 0000:00:00.0: [1b21:1184] type 01 class 0x060400
> [    3.590646] pci 0000:00:00.0: enabling Extended Tags
> [    3.595677] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
> [    3.602874] PCI: bus0: Fast back to back transfers disabled
> [    3.608585] pci 0000:01:01.0: [1b21:1184] type 01 class 0x060400
> [    3.614645] pci 0000:01:01.0: enabling Extended Tags
> [    3.619672] pci 0000:01:01.0: PME# supported from D0 D3hot D3cold
> [    3.625969] pci 0000:01:03.0: [1b21:1184] type 01 class 0x060400
> [    3.632040] pci 0000:01:03.0: enabling Extended Tags
> [    3.637066] pci 0000:01:03.0: PME# supported from D0 D3hot D3cold
> [    3.643363] pci 0000:01:05.0: [1b21:1184] type 01 class 0x060400
> [    3.649431] pci 0000:01:05.0: enabling Extended Tags
> [    3.654449] pci 0000:01:05.0: PME# supported from D0 D3hot D3cold
> [    3.660753] pci 0000:01:07.0: [1b21:1184] type 01 class 0x060400
> [    3.666822] pci 0000:01:07.0: enabling Extended Tags
> [    3.671844] pci 0000:01:07.0: PME# supported from D0 D3hot D3cold
> [    3.678832] PCI: bus1: Fast back to back transfers disabled
> [    3.684517] pci 0000:02:00.0: [1b21:0612] type 00 class 0x010601
> [    3.690564] pci 0000:02:00.0: reg 0x10: [io  0x0028-0x002f]
> [    3.696147] pci 0000:02:00.0: reg 0x14: [io  0x0034-0x0037]
> [    3.701738] pci 0000:02:00.0: reg 0x18: [io  0x0020-0x0027]
> [    3.707329] pci 0000:02:00.0: reg 0x1c: [io  0x0030-0x0033]
> [    3.712912] pci 0000:02:00.0: reg 0x20: [io  0x0000-0x001f]
> [    3.718503] pci 0000:02:00.0: reg 0x24: [mem 0x68100000-0x681001ff]
> [    3.724781] pci 0000:02:00.0: reg 0x30: [mem 0xffff0000-0xffffffff pref]
> [    3.732590] PCI: bus2: Fast back to back transfers disabled
> [    3.738174] pci_bus 0000:02: busn_res: [bus 02-7e] end is updated to 02
> [    3.745751] PCI: bus3: Fast back to back transfers enabled
> [    3.751247] pci_bus 0000:03: busn_res: [bus 03-7e] end is updated to 03
> [    3.757969] pci 0000:04:00.0: [1912:0014] type 00 class 0x0c0330
> [    3.764012] pci 0000:04:00.0: reg 0x10: [mem 0x68000000-0x68001fff 64bit]
> [    3.770943] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
> [    3.807778] PCI: bus4: Fast back to back transfers disabled
> [    3.813353] pci_bus 0000:04: busn_res: [bus 04-7e] end is updated to 04
> [    3.820943] PCI: bus5: Fast back to back transfers enabled
> [    3.826430] pci_bus 0000:05: busn_res: [bus 05-7e] end is updated to 05
> [    3.833058] pci_bus 0000:01: busn_res: [bus 01-7e] end is updated to 05
> [    3.839709] pci 0000:00:00.0: BAR 8: assigned [mem 0x68000000-0x681fffff]
> [    3.846498] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
> [    3.852603] pci 0000:01:01.0: BAR 8: assigned [mem 0x68000000-0x680fffff]
> [    3.859402] pci 0000:01:05.0: BAR 8: assigned [mem 0x68100000-0x681fffff]
> [    3.866190] pci 0000:01:01.0: BAR 7: assigned [io  0x1000-0x1fff]
> [    3.872294] pci 0000:02:00.0: BAR 6: assigned [mem
> 0x68000000-0x6800ffff pref]
> [    3.879529] pci 0000:02:00.0: BAR 5: assigned [mem 0x68010000-0x680101ff]
> [    3.886321] pci 0000:02:00.0: BAR 4: assigned [io  0x1000-0x101f]
> [    3.892425] pci 0000:02:00.0: BAR 0: assigned [io  0x1020-0x1027]
> [    3.898529] pci 0000:02:00.0: BAR 2: assigned [io  0x1028-0x102f]
> [    3.904627] pci 0000:02:00.0: BAR 1: assigned [io  0x1030-0x1033]
> [    3.910730] pci 0000:02:00.0: BAR 3: assigned [io  0x1034-0x1037]
> [    3.916834] pci 0000:01:01.0: PCI bridge to [bus 02]
> [    3.921799] pci 0000:01:01.0:   bridge window [io  0x1000-0x1fff]
> [    3.927903] pci 0000:01:01.0:   bridge window [mem 0x68000000-0x680fffff]
> [    3.934697] pci 0000:01:03.0: PCI bridge to [bus 03]
> [    3.939682] pci 0000:04:00.0: BAR 0: assigned [mem
> 0x68100000-0x68101fff 64bit]
> [    3.947012] pci 0000:01:05.0: PCI bridge to [bus 04]
> [    3.951979] pci 0000:01:05.0:   bridge window [mem 0x68100000-0x681fffff]
> [    3.958780] pci 0000:01:07.0: PCI bridge to [bus 05]
> [    3.963754] pci 0000:00:00.0: PCI bridge to [bus 01-05]
> [    3.968985] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
> [    3.975081] pci 0000:00:00.0:   bridge window [mem 0x68000000-0x681fffff]
> [    3.981914] OF: translation of DMA address(0) to CPU address failed
> node(/pcie@60000000)
> [    3.990313] OF: translation of DMA address(0) to CPU address failed
> node(/pcie@60000000)
> [    3.998662] OF: translation of DMA address(0) to CPU address failed
> node(/pcie@60000000)
> [    4.007005] OF: translation of DMA address(0) to CPU address failed
> node(/pcie@60000000)
> [    4.015339] OF: translation of DMA address(0) to CPU address failed
> node(/pcie@60000000)
> [    4.023694] pci 0000:04:00.0: enabling device (0140 -> 0142)
> [    4.029447] OF: translation of DMA address(0) to CPU address failed
> node(/pcie@70000000)
> [    4.037570] pci-host-generic 70000000.pcie: host bridge
> /pcie@70000000 ranges:
> [    4.044805] pci-host-generic 70000000.pcie:       IO
> 0x0077f00000..0x0077f0ffff -> 0x0000000000
> [    4.053523] pci-host-generic 70000000.pcie:      MEM
> 0x0078000000..0x007fffffff -> 0x0078000000
> [    4.062236] pci-host-generic 70000000.pcie:      MEM
> 0x3f00000000..0x3fffffffff -> 0x3f00000000
> [    4.071308] vmap allocation for size 1052672 failed: use
> vmalloc=<size> to increase size
> [    4.079411] pci-host-generic 70000000.pcie: ECAM ioremap failed
> [    4.085525] pci-host-generic: probe of 70000000.pcie failed with error -12
> [    4.126494] Serial: 8250/16550 driver, 5 ports, IRQ sharing enabled
> [    4.134170] OF: translation of DMA address(0) to CPU address failed
> node(/uart@51040000)
> [    4.142748] 51040000.uart: ttyS1 at MMIO 0x51040000 (irq = 23,
> base_baud = 3906250) is a 16550A
> [    4.152099] SuperH (H)SCI(F) driver initialized
> [    4.156953] msm_serial: driver initialized
> [    4.161103] STMicroelectronics ASC driver initialized
> [    4.166594] STM32 USART driver initialized
> [    4.178363] brd: module loaded
> [    4.192943] loop: module loaded
> [    4.197009] OF: translation of DMA address(0) to CPU address failed
> node(/pcie@60000000)
> [    4.205330] ahci 0000:02:00.0: SSS flag set, parallel bus scan disabled
> [    4.212015] ahci 0000:02:00.0: AHCI 0001.0200 32 slots 2 ports 6
> Gbps 0x3 impl SATA mode
> [    4.220122] ahci 0000:02:00.0: flags: 64bit ncq sntf stag led clo
> pmp pio slum part ccc sxs
> [    4.229431] scsi host0: ahci
> [    4.232675] scsi host1: ahci
> [    4.235694] ata1: SATA max UDMA/133 abar m512@0x68010000 port
> 0x68010100 irq 35
> [    4.243033] ata2: SATA max UDMA/133 abar m512@0x68010000 port
> 0x68010180 irq 35
> [    4.253906] libphy: Fixed MDIO Bus: probed
> [    4.258796] CAN device driver interface
> [    4.262933] bgmac_bcma: Broadcom 47xx GBit MAC driver loaded
> [    4.268942] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> [    4.274772] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [    4.280739] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.6.0-k
> [    4.287707] igb: Copyright (c) 2007-2014 Intel Corporation.
> [    4.294603] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB
> Ethernet driver
> [    4.302042] usbcore: registered new interface driver pegasus
> [    4.307736] usbcore: registered new interface driver asix
> [    4.313150] usbcore: registered new interface driver ax88179_178a
> [    4.319267] usbcore: registered new interface driver cdc_ether
> [    4.325122] usbcore: registered new interface driver smsc75xx
> [    4.330901] usbcore: registered new interface driver smsc95xx
> [    4.336663] usbcore: registered new interface driver net1080
> [    4.342350] usbcore: registered new interface driver cdc_subset
> [    4.348295] usbcore: registered new interface driver zaurus
> [    4.353894] usbcore: registered new interface driver cdc_ncm
> [    4.360347] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    4.366891] ehci-pci: EHCI PCI platform driver
> [    4.371359] ehci-platform: EHCI generic platform driver
> [    4.376646] ehci-orion: EHCI orion driver
> [    4.380714] SPEAr-ehci: EHCI SPEAr driver
> [    4.384767] ehci-st: EHCI STMicroelectronics driver
> [    4.389704] ehci-exynos: EHCI Exynos driver
> [    4.393931] ehci-atmel: EHCI Atmel driver
> [    4.397991] tegra-ehci: Tegra EHCI driver
> [    4.402048] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    4.408245] ohci-pci: OHCI PCI platform driver
> [    4.412714] ohci-platform: OHCI generic platform driver
> [    4.418003] SPEAr-ohci: OHCI SPEAr driver
> [    4.422057] ohci-st: OHCI STMicroelectronics driver
> [    4.426995] ohci-atmel: OHCI Atmel driver
> [    4.431085] OF: translation of DMA address(0) to CPU address failed
> node(/pcie@60000000)
> [    4.439259] xhci_hcd 0000:04:00.0: xHCI Host Controller
> [    4.444497] xhci_hcd 0000:04:00.0: new USB bus registered, assigned
> bus number 1
> [    4.457324] xhci_hcd 0000:04:00.0: hcc params 0x014051cf hci
> version 0x100 quirks 0x0000000100000410
> [    4.467671] hub 1-0:1.0: USB hub found
> [    4.471449] hub 1-0:1.0: 4 ports detected
> [    4.475927] xhci_hcd 0000:04:00.0: xHCI Host Controller
> [    4.481175] xhci_hcd 0000:04:00.0: new USB bus registered, assigned
> bus number 2
> [    4.488585] xhci_hcd 0000:04:00.0: Host supports USB 3.0 SuperSpeed
> [    4.494924] usb usb2: We don't know the algorithms for LPM for this
> host, disabling LPM.
> [    4.503372] hub 2-0:1.0: USB hub found
> [    4.507155] hub 2-0:1.0: 4 ports detected
> [    4.511847] usbcore: registered new interface driver usb-storage
> [    4.519900] i2c /dev entries driver
> [    4.528493] /cpus/cpu@0: unsupported enable-method property: psci
> [    4.537114] sdhci: Secure Digital Host Controller Interface driver
> [    4.543297] sdhci: Copyright(c) Pierre Ossman
> [    4.548328] Synopsys Designware Multimedia Card Interface Driver
> [    4.554829] sdhci-pltfm: SDHCI platform and OF driver helper
> [    4.562104] ledtrig-cpu: registered to indicate activity on CPUs
> [    4.568594] usbcore: registered new interface driver usbhid
> [    4.574168] usbhid: USB HID core driver
> [    4.579546] drop_monitor: Initializing network drop monitor service
> [    4.586552] NET: Registered protocol family 10
> [    4.591887] Segment Routing with IPv6
> [    4.595614] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> [    4.602085] NET: Registered protocol family 17
> [    4.606537] can: controller area network core (rev 20170425 abi 9)
> [    4.612780] NET: Registered protocol family 29
> [    4.617248] can: raw protocol (rev 20170425)
> [    4.621524] can: broadcast manager protocol (rev 20170425 t)
> [    4.627198] can: netlink gateway (rev 20190810) max_hops=1
> [    4.632967] Key type dns_resolver registered
> [    4.637328] Registering SWP/SWPB emulation handler
> [    4.642410] Loading compiled-in X.509 certificates
> [    4.688987] OF: translation of DMA address(0) to CPU address failed
> node(/gpio-keys)
> [    4.696780] irq: no irq domain found for interrupt-controller@510c0000 !
> [    4.703556] gpio-keys gpio-keys: Found button without gpio or irq
> [    4.709673] gpio-keys: probe of gpio-keys failed with error -22
> [    4.715621] hctosys: unable to open rtc device (rtc0)
> [    4.721044] uart-pl011 2a400000.uart: no DMA platform data
> [    4.746912] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    4.754022] ata1.00: ATA-10: WDC WD10EZEX-22MFCA0, 01.01A01, max UDMA/133
> [    4.760826] ata1.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32), AA
> [    4.768960] ata1.00: configured for UDMA/133
> [    4.773637] scsi 0:0:0:0: Direct-Access     ATA      WDC
> WD10EZEX-22M 1A01 PQ: 0 ANSI: 5
> [    4.782675] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks:
> (1.00 TB/932 GiB)
> [    4.790362] sd 0:0:0:0: [sda] 4096-byte physical blocks
> [    4.795635] sd 0:0:0:0: [sda] Write Protect is off
> [    4.800505] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [    4.846916] usb 1-3: new high-speed USB device number 2 using xhci_hcd
> [    4.865348]  sda: sda1 sda2 sda3 sda4
> [    4.871475] sd 0:0:0:0: [sda] Attached SCSI disk
> [    4.887962] usb-storage 1-3:1.0: USB Mass Storage device detected
> [    4.894715] scsi host2: usb-storage 1-3:1.0
> [    5.109059] ata2: SATA link down (SStatus 0 SControl 300)
> [    5.117814] Freeing unused kernel memory: 2048K
> [    5.122861] Run /init as init process
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
