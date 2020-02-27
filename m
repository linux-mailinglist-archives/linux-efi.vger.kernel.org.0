Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85954172B22
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2020 23:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbgB0W1A (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Feb 2020 17:27:00 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16841 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbgB0W0y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 27 Feb 2020 17:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582842414; x=1614378414;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vsv6Nzup0wTExC47s/DpNvq8qqmjQ3ZR/b43j5z+eRY=;
  b=qfRZEyVvxlinITlr9+j44hd5MW+ukIRqMzUwAj1tk86KAVXSCBLpFwty
   GzzpI6N7zI0X3EUoP/5eOElvsA7EbJ0Kis5WKE7peApTYcQ3kYKBYf5Yk
   83+HrVhXNKW3spB/tyNn9EUrVBR9JeJq4vnsidAQFv3nvCoqeVPliX2FL
   qBT8XUw/F98c23zkzj4Mrc8Jr9HAjJ6EYCXPOrhVcsV1nQ6GSx3sO8Gm1
   KS4nL3JJPUh2G2yWE/6nVfe5aNotl0GmHDdU5CLSibKP/fxxZYbYwoAQV
   lCfoaRXtjI/xqKArkLAJdLtw5ADOLvzBcZHuWeECDs2iMVOFokCJjOaq8
   g==;
IronPort-SDR: QTrBxUftNgcZvnKAtF3Fj+bOrzF0sOW5IG+NPiCN3gn+Rr0IsqI5gBJZe0YIpkgZMfHUtZhiBC
 /tZIsrTrFi5BSns2NcUWdyWAmESDz6+wVJItTmUL4UqPzQ44y//oyMj6Ldx7KDacJrKCqzQ6MI
 zUHnD6K4AWZjrzMCoqgh4ypW9cH0jMPQK15wbdDZdxiuQILhbf0tbgZSMw5dmYi9aFXIbd/aJw
 de2DLmxUJfzkemzmLPQu5PgYA/OfOnVCVFng/eWrOkmnK0HKiNMfOjFbZQ7PFC9/BrbR2ftey/
 Q6w=
X-IronPort-AV: E=Sophos;i="5.70,493,1574092800"; 
   d="scan'208";a="131459832"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2020 06:26:50 +0800
IronPort-SDR: cnwD4UilVT9sqG1nd+7f1BxJaCBhHlGgxswqcYFk7uNBM2s6rNKFq4HyMSMmr+9HWNSe4gEtxj
 +xESgiZC1QKTOtmg51OfrPeKbYSPi7o6ZjO8ctCIWMv1SmejKvGoNJMGEZn2CukYMVhuCKutGE
 s7kyuKl9cBhGqcDUgUdtlk1UKlFMwNg7kq5VUVTo1YICEEw93TCEfcJtCK/tB7xv5uRRSPGtKl
 UozKPnJzjqHK2ldWrNi5AS86vUNC3PbAGCvGns8rQ/NPVOp5clwNddGOpZEUOKet83kEz3URxq
 JyQ8gUqCgwZbTSjjJzwH6KgL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 14:19:12 -0800
IronPort-SDR: 08iBIQlSuRL6AN/VnM44NHtSuHGB9+QZK26r0PLkXReNle2DoJs8qMvKfgVpjfVUb029R6fk1K
 qA5Wzq2Eh5flfW63vt79Fa5mttJkidGxXWzyf9xIBBKb9FvIOWGEZnyfCHaiI6lOff8Wvs57SM
 uAhH7eOIESjeOzUmeVy7jhj6Wg92ju2a0yJKHNDQuDbdFdFloufq9sfPvim77leSBReSZ/jvxX
 CSTq0bWmDej1uxLsXAJ1Qpw7cJxZ2repEfv3rdynNSZJHdDwy/IO9BUQlMQcCsoCgLZ2acz1AZ
 TKI=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Feb 2020 14:26:48 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mao Han <han_mao@c-sky.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Alexander Graf <agraf@csgraf.de>,
        "leif@nuviainc.com" <leif@nuviainc.com>,
        "Chang, Abner (HPS SW/FW Technologist)" <abner.chang@hpe.com>,
        daniel.schaefer@hpe.com
Subject: [v1 PATCH 0/5] Add UEFI support for RISC-V 
Date:   Thu, 27 Feb 2020 14:26:39 -0800
Message-Id: <20200227222644.9468-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series adds UEFI support for RISC-V. Currently, only boot time
services have been added. Runtime services will be added in a separate
series. This series depends on some core EFI patches
present in current in efi-next and following other patches.

U-Boot: Adds the boot hartid under chosen node.
https://lists.denx.de/pipermail/u-boot/2020-February/401563.html

Linux kernel: SBI v0.2 and HSM extension support. This series is a mandatory
pre-requisite for UEFI support as only single core can boot EFI stub and
Linux via UEFI. All other cores are brought up using SBI HSM extension.
http://lists.infradead.org/pipermail/linux-riscv/2020-February/008560.html

OpenSBI: master (commit: ge3f69fc1e934)

Patch 1 just moves arm-stub code to a generic code so that it can be used
across different architecture.

Patch 3 adds fixmap bindings so that CONFIG_EFI can be compiled and we do not
have create separate config to enable boot time services. 
As runtime services are not enabled at this time, full generic early ioremap
support is also not added in this series.

Patch 4 and 5 adds the PE/COFF header and EFI stub code support for RISC-V
respectively.

The patches can also be found in following git repo.

https://github.com/atishp04/linux/tree/wip_uefi_riscv

The patches have been verified on Qemu using bootefi command in U-Boot.
Here is the boot log.

OpenSBI v0.6-4-ge3f69fc1e934
   ____                    _____ ____ _____
  / __ \                  / ____|  _ \_   _|
 | |  | |_ __   ___ _ __ | (___ | |_) || |
 | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
 | |__| | |_) |  __/ | | |____) | |_) || |_
  \____/| .__/ \___|_| |_|_____/|____/_____|
        | |
        |_|

Platform Name          : QEMU Virt Machine
Platform HART Features : RV64ACDFIMSU
Platform Max HARTs     : 8
Current Hart           : 0
Firmware Base          : 0x80000000
Firmware Size          : 124 KB
Runtime SBI Version    : 0.2

MIDELEG : 0x0000000000000222
MEDELEG : 0x000000000000b109
PMP0    : 0x0000000080000000-0x000000008001ffff (A)
PMP1    : 0x0000000000000000-0xffffffffffffffff (A,R,W,X)


U-Boot 2020.04-rc2-00059-ge5028497e1f9 (Feb 24 2020 - 17:03:04 -0800)

CPU:   rv64imafdcsu
Model: riscv-virtio,qemu
DRAM:  4 GiB
In:    uart@10000000
Out:   uart@10000000
Err:   uart@10000000
Net:
Warning: virtio-net#1 using MAC address from ROM
eth0: virtio-net#1
Hit any key to stop autoboot:  0 
=> setenv bootargs "root=/dev/vda rw console=ttyS0 earlycon=sbi early_ioremap_debug"
=> setenv filesize 0x900000
=> cp.l $fdtcontroladdr $fdt_addr_r 0x10000
=> bootefi $kernel_addr_r $fdt_addr_r
Found 0 disks                                                                                                                                                                                                      
EFI stub: Booting Linux Kernel...                                                                                                                                                                                  
EFI stub: Using DTB from configuration table                                                                                                                                                                       
EFI stub: Loaded initrd from command line option                                                                                                                                                                   
EFI stub: Exiting boot services and installing virtual address map...                                                                                                                                              
[    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80200000
[    0.000000] Linux version 5.6.0-rc1-00017-g5eadec0fc196 (atish@jedi-01) (gcc version 8.2.0 (Buildroot 2018.11-rc2-00003-ga0787e9)) #289 SMP Tue Feb 25 15:53:03 PST 2020
[    0.000000] earlycon: sbi0 at I/O port 0x0 (options '')
[    0.000000] printk: bootconsole [sbi0] enabled
[    0.000000] Initial ramdisk at: 0x(____ptrval____) (28214784 bytes)
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000080200000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000017fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080200000-0x000000017fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080200000-0x000000017fffffff]
[    0.000000] software IO TLB: mapped [mem 0xf9bd0000-0xfdbd0000] (64MB)
[    0.000000] SBI specification v0.2 detected
[    0.000000] SBI implementation ID=0x1 Version=0x6
[    0.000000] SBI v0.2 TIME extension detected
[    0.000000] SBI v0.2 IPI extension detected
[    0.000000] SBI v0.2 RFENCE extension detected
[    0.000000] SBI v0.2 HSM extension detected
[    0.000000] elf_hwcap is 0x112d
[    0.000000] percpu: Embedded 17 pages/cpu s31784 r8192 d29656 u69632
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1033735
[    0.000000] Kernel command line: root=/dev/vda rw console=ttyS0 earlycon=sbi early_ioremap_debug
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.000000] Sorting __ex_table...
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 4025172K/4192256K available (6312K kernel code, 467K rwdata, 2119K rodata, 287K init, 311K bss, 167084K reserved, 0K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]       fixmap : 0xffffffcefee00000 - 0xffffffceff000000   (2048 kB)
[    0.000000]       pci io : 0xffffffceff000000 - 0xffffffcf00000000   (  16 MB)
[    0.000000]      vmemmap : 0xffffffcf00000000 - 0xffffffcfffffffff   (4095 MB)
[    0.000000]      vmalloc : 0xffffffd000000000 - 0xffffffdfffffffff   (65535 MB)
[    0.000000]       lowmem : 0xffffffe000000000 - 0xffffffe0ffe00000   (4094 MB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU debug extended QS entry/exit.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] NR_IRQS: 0, nr_irqs: 0, preallocated irqs: 0
[    0.000000] plic: mapped 53 interrupts with 8 handlers for 16 contexts.
[    0.000000] riscv_timer_init_dt: Registering clocksource cpuid [0] hartid [2]
[    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff max_cycles: 0x24e6a1710, max_idle_ns: 440795202120 ns
[    0.000354] sched_clock: 64 bits at 10MHz, resolution 100ns, wraps every 4398046511100ns
[    0.024642] Console: colour dummy device 80x25
[    0.029641] Calibrating delay loop (skipped), value calculated using timer frequency.. 20.00 BogoMIPS (lpj=40000)
[    0.038813] pid_max: default: 32768 minimum: 301
[    0.043401] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.052641] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.113037] rcu: Hierarchical SRCU implementation.
[    0.128662] smp: Bringing up secondary CPUs ...
[    0.196884] smp: Brought up 1 node, 8 CPUs
[    0.227397] devtmpfs: initialized
[    0.243392] random: get_random_u32 called from bucket_table_alloc.isra.25+0x4e/0x160 with crng_init=0
[    0.260148] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.273062] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.296694] NET: Registered protocol family 16
[    0.411010] vgaarb: loaded
[    0.417550] SCSI subsystem initialized
[    0.428103] usbcore: registered new interface driver usbfs
[    0.435392] usbcore: registered new interface driver hub
[    0.444026] usbcore: registered new device driver usb
[    0.470256] clocksource: Switched to clocksource riscv_clocksource
[    0.570385] NET: Registered protocol family 2
.....
.....
[    2.468252] Freeing unused kernel memory: 284K
[    2.470508] This architecture does not have kernel memory protection.
[    2.473123] Run /init as init process
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Saving random seed: OK
Starting network: OK
Starting dhcpcd...
no interfaces have a carrier
forked to background, child pid 142
ssh-keygen: generating new host keys: RSA DSA ECDSA ED25519
Starting sshd: Privilege separation user sshd does not exist
OK

Welcome to Buildroot
buildroot login:

Changes from previous version:
1. Renamed to the generic efi stub macro.
2. Address all redundant comments.
3. Supported EFI kernel image with normal booti command.
4. Removed runtime service related macro defines.

Atish Patra (5):
efi: Move arm-stub to a common file
include: pe.h: Add RISC-V related PE definition
RISC-V: Define fixmap bindings for generic early ioremap support
RISC-V: Add PE/COFF header for EFI stub
RISC-V: Add EFI stub support.

arch/arm/Kconfig                              |   2 +-
arch/arm64/Kconfig                            |   2 +-
arch/riscv/Kconfig                            |  21 +++
arch/riscv/Makefile                           |   1 +
arch/riscv/configs/defconfig                  |   1 +
arch/riscv/include/asm/Kbuild                 |   2 +-
arch/riscv/include/asm/efi.h                  |  59 ++++++++
arch/riscv/include/asm/fixmap.h               |  21 ++-
arch/riscv/include/asm/io.h                   |   1 +
arch/riscv/include/asm/sections.h             |  13 ++
arch/riscv/kernel/Makefile                    |   4 +
arch/riscv/kernel/efi-header.S                |  99 +++++++++++++
arch/riscv/kernel/head.S                      |  16 +++
arch/riscv/kernel/image-vars.h                |  53 +++++++
arch/riscv/kernel/vmlinux.lds.S               |  27 +++-
drivers/firmware/efi/Kconfig                  |   4 +-
drivers/firmware/efi/libstub/Makefile         |  20 ++-
.../efi/libstub/{arm-stub.c => efi-stub.c}    |   0
drivers/firmware/efi/libstub/riscv-stub.c     | 131 ++++++++++++++++++
include/linux/pe.h                            |   3 +
20 files changed, 462 insertions(+), 18 deletions(-)
create mode 100644 arch/riscv/include/asm/efi.h
create mode 100644 arch/riscv/include/asm/sections.h
create mode 100644 arch/riscv/kernel/efi-header.S
create mode 100644 arch/riscv/kernel/image-vars.h
rename drivers/firmware/efi/libstub/{arm-stub.c => efi-stub.c} (100%)
create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c

--
2.24.0

