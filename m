Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E1B664D9D
	for <lists+linux-efi@lfdr.de>; Tue, 10 Jan 2023 21:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjAJUsK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Jan 2023 15:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjAJUsJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 Jan 2023 15:48:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9551121
        for <linux-efi@vger.kernel.org>; Tue, 10 Jan 2023 12:48:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5C1C618FE
        for <linux-efi@vger.kernel.org>; Tue, 10 Jan 2023 20:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82A5C433F1;
        Tue, 10 Jan 2023 20:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673383684;
        bh=cBJV3QQaTEEmdyCylROo0p2s2IJ0dW50dGfJK9XrdjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qEPPdqpfdY6h+zBJWMlLPzF5iVhwpmls++xmFyXL3D+1DKYVgYaHNGa35vhx+1RJI
         XVDChQeLOf8cRiBmVsqxxoksBTVmEs+eb7ix22z0JAyoQHaJ+P0fNqasoLhRSjmMOy
         RhB31CiHzNlMCd+bH8kQo99KWliZuff51NHsAQ5ShvCDWak1/QXwPUUUjgGKVizpO/
         l0eSdxb3QSm4HqD4SsrxngzVP0r6xf1iyKi8dSNpoxkI8lyyfU1KFV+z5ZYt2sHJZ1
         2eNKXwHnb3bqzDUPP6EGv4orBjqEV4FhB1pGFy5ajixJHWyS/dPZ+BFOd7ZsEbhA04
         tI8sOipUmU6lA==
Date:   Tue, 10 Jan 2023 13:48:02 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, catalin.marinas@arm.com,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee@kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v3 2/2] arm64: efi: Account for the EFI runtime stack in
 stack unwinder
Message-ID: <Y73PAtm6FPuT+1cM@dev-arch.thelio-3990X>
References: <20230106174703.1883495-1-ardb@kernel.org>
 <20230106174703.1883495-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106174703.1883495-3-ardb@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Fri, Jan 06, 2023 at 06:47:03PM +0100, Ard Biesheuvel wrote:
> The EFI runtime services run from a dedicated stack now, and so the
> stack unwinder needs to be informed about this.
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Apologies if this has been reported and/or fixed already, I searched
lore and did not find anything but I just bisected a QEMU boot hang [1]
that we see in the ClangBuiltLinux CI with Fedora's configuration [2] to
this change in next-20220110 as commit a7334dc70496 ("arm64: efi:
Account for the EFI runtime stack in stack unwinder").

I do not think our QEMU command is very exotic but we are not booting
via EFI (although I do see it even if we do boot via EFI):

$ qemu-system-aarch64 \
-cpu max,pauth-impdef=true \
-machine virt,gic-version=max,virtualization=true \
-kernel arch/arm64/boot/Image.gz
-append "console=ttyAMA0 earlycon" \
-display none \
-initrd images/arm64/rootfs.cpio
-m 512m \
-nodefaults \
-no-reboot \
-serial mon:stdio
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
[    0.000000] Linux version 6.2.0-rc2+ (tuxmake@tuxmake) (aarch64-linux-gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.39) #1 SMP PREEMPT_DYNAMIC @1673275520
[    0.000000] random: crng init done
[    0.000000] Machine model: linux,dummy-virt
[    0.000000] efi: UEFI not found.
[    0.000000] earlycon: pl11 at MMIO 0x0000000009000000 (options '')
[    0.000000] printk: bootconsole [pl11] enabled
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000040000000-0x000000005fffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x5fe9e3c0-0x5feb4fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000040000000-0x000000005fffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x000000005fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x000000005fffffff]
[    0.000000] cma: Reserved 64 MiB at 0x000000005b600000
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] psci: SMC Calling Convention v1.0
[    0.000000] percpu: Embedded 32 pages/cpu s90408 r8192 d32472 u131072
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: detected: Address authentication (IMP DEF algorithm)
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: Virtualization Host Extensions
[    0.000000] CPU features: detected: Hardware dirty bit management
[    0.000000] CPU features: detected: Spectre-v4
[    0.000000] alternatives: applying boot alternatives
[    0.000000] Fallback order for Node 0: 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 129024
[    0.000000] Policy zone: DMA
[    0.000000] Kernel command line: console=ttyAMA0 earlycon
[    0.000000] Dentry cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.000000] Inode-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
[    0.000000] Memory: 384052K/524288K available (17088K kernel code, 4208K rwdata, 15032K rodata, 9536K init, 10717K bss, 74700K reserved, 65536K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] ftrace: allocating 58614 entries in 229 pages
[    0.000000] ftrace: allocated 229 pages with 5 groups
[    0.000000] trace event string verifier disabled
[    0.000000] Dynamic Preempt: voluntary
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=4096 to nr_cpu_ids=1.
[    0.000000]  Trampoline variant of Tasks RCU enabled.
[    0.000000]  Rude variant of Tasks RCU enabled.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 256 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: GICv3 features: 16 PPIs
[    0.000000] GICv3: GICv4 features:
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x00000000080a0000
[    0.000000] ITS [mem 0x08080000-0x0809ffff]
[    0.000000] ITS@0x0000000008080000: Single VMOVP capable
[    0.000000] ITS@0x0000000008080000: allocated 8192 Devices @43de0000 (indirect, esz 8, psz 64K, shr 1)
[    0.000000] ITS@0x0000000008080000: allocated 8192 Interrupt Collections @43df0000 (flat, esz 8, psz 64K, shr 1)
[    0.000000] ITS@0x0000000008080000: allocated 8192 Virtual CPUs @43e00000 (indirect, esz 8, psz 64K, shr 1)
[    0.000000] GICv3: using LPI property table @0x0000000043e10000
[    0.000000] ITS: Allocated DevID ffff as GICv4 proxy device (2 slots)
[    0.000000] ITS: Enabling GICv4 support
[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000000043e20000
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] arch_timer: cp15 timer(s) running at 62.50MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0x1ffffffffffffff max_cycles: 0x1cd42e208c, max_idle_ns: 881590405314 ns
[    0.000069] sched_clock: 57 bits at 63MHz, resolution 16ns, wraps every 4398046511096ns
[    0.002785] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
[    0.014680] Console: colour dummy device 80x25
[    0.022555] Calibrating delay loop (skipped), value calculated using timer frequency.. 125.00 BogoMIPS (lpj=625000)
[    0.023292] pid_max: default: 32768 minimum: 301
[    0.025346] LSM: initializing lsm=lockdown,capability,yama,integrity,selinux,bpf,landlock
[    0.026087] Yama: becoming mindful.
[    0.027053] SELinux:  Initializing.
[    0.027935] LSM support for eBPF active
[    0.028089] landlock: Up and running.
[    0.030514] Mount-cache hash table entries: 1024 (order: 1, 8192 bytes, linear)
[    0.030706] Mountpoint-cache hash table entries: 1024 (order: 1, 8192 bytes, linear)
qemu-system-aarch64: terminating on signal 15 from pid 4112158 (timeout)

This does not appear to be clang specific, as I can reproduce it with
the same configuration using kernel.org's GCC 12.2.0 (as you'll see
above). I unfortunately do not have time to bisect configurations to see
if there is a more trivial reproducer on top of defconfig, so just this
report.

If there is any additional information I can provide, please let me
know.

Cheers,
Nathan

[1]: https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/3883388450/jobs/6628748170
[2]: https://src.fedoraproject.org/rpms/kernel/raw/rawhide/f/kernel-aarch64-fedora.config

# bad: [435bf71af3a0aa8067f3b87ff9febf68b564dbb6] Add linux-next specific files for 20230110
# good: [1fe4fd6f5cad346e598593af36caeadc4f5d4fa9] Merge tag 'xfs-6.2-fixes-2' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
git bisect start '435bf71af3a0aa8067f3b87ff9febf68b564dbb6' '1fe4fd6f5cad346e598593af36caeadc4f5d4fa9'
# bad: [57aac56e8af1628ef96055820f88ca547233b310] Merge branch 'drm-next' of git://git.freedesktop.org/git/drm/drm.git
git bisect bad 57aac56e8af1628ef96055820f88ca547233b310
# bad: [68efa45676e8f0b73c896ee4f82996ac396455af] Merge branch 'riscv-soc-for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git
git bisect bad 68efa45676e8f0b73c896ee4f82996ac396455af
# bad: [154e09c58f5dcd853bd54ac8b725132126d0b640] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git
git bisect bad 154e09c58f5dcd853bd54ac8b725132126d0b640
# good: [0680aa5d9dee0e17d169c022f29c53ec6ad3f69d] Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
git bisect good 0680aa5d9dee0e17d169c022f29c53ec6ad3f69d
# good: [76c76819b36d2433e2637c91dbdc4ec345bf7d92] ARM: remove CONFIG_UNUSED_BOARD_FILES
git bisect good 76c76819b36d2433e2637c91dbdc4ec345bf7d92
# bad: [d08fc57162414439a50e36eb5c4554a56eb8e121] Merge branch 'for-next' of git://git.armlinux.org.uk/~rmk/linux-arm.git
git bisect bad d08fc57162414439a50e36eb5c4554a56eb8e121
# bad: [3145d9dfed323d5a82d40670e333de58fb1a9e65] Merge branch 'for-linux-next-fixes' of git://anongit.freedesktop.org/drm/drm-misc
git bisect bad 3145d9dfed323d5a82d40670e333de58fb1a9e65
# good: [3b3d45c3b305edeb93053c05993bd7c58b9ceb94] Merge branch 'for-rc' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
git bisect good 3b3d45c3b305edeb93053c05993bd7c58b9ceb94
# bad: [33b73800589ae5a93e3b2faf2fbac7c30d6fdd1a] Merge branch 'urgent' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
git bisect bad 33b73800589ae5a93e3b2faf2fbac7c30d6fdd1a
# good: [18bba1843fc7f264f58c9345d00827d082f9c558] efi: rt-wrapper: Add missing include
git bisect good 18bba1843fc7f264f58c9345d00827d082f9c558
# bad: [a7334dc70496bb0cec7f1d3b1f148855951f41c5] arm64: efi: Account for the EFI runtime stack in stack unwinder
git bisect bad a7334dc70496bb0cec7f1d3b1f148855951f41c5
# good: [4a70773264fd7f00b8401b5f9addb72b58678fdf] arm64: efi: Avoid workqueue to check whether EFI runtime is live
git bisect good 4a70773264fd7f00b8401b5f9addb72b58678fdf
# first bad commit: [a7334dc70496bb0cec7f1d3b1f148855951f41c5] arm64: efi: Account for the EFI runtime stack in stack unwinder
