Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9662669A6E3
	for <lists+linux-efi@lfdr.de>; Fri, 17 Feb 2023 09:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjBQI1y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Feb 2023 03:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBQI1y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Feb 2023 03:27:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF93C59F8;
        Fri, 17 Feb 2023 00:27:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 881CCB82B42;
        Fri, 17 Feb 2023 08:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18663C4339B;
        Fri, 17 Feb 2023 08:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676622468;
        bh=WS/gWhAn/WNDmPQUKNU/yPbMM9qwmm4oMXb1J5YXeP4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hRWQzkVMPUnmt0KzILE0w4yYCGyH+cU9XmXuR+WLCTRhsC0SwkV/oOs0CRj817t+I
         pBRBh9n8qKAlp6jhdc5+lRsz9ZfY4HoG75JTY0KE06EM97AMQJi2gVsTv+Dt0OOOm4
         a0TwwA6gSH2/p0P/qk1VHalJD6NiDUB3+xYpi3/vtTzOFG3+SiyHijEA05+RbjpFw0
         Pc5tl1B0H2ZkC9ezl/HxJxIHvWkUS/xBWNPdtPyADSZqsZQkNcAiTTzCheYZwdKlNX
         FFXdK7B+Kqop4TLtwoWr9XvAdM838J1K6MXX57WuvS0BLSedAhkOGHMAaJwtcjGSzG
         6/P5MGMvoSYaw==
Received: by mail-lj1-f178.google.com with SMTP id y20so464720ljc.0;
        Fri, 17 Feb 2023 00:27:47 -0800 (PST)
X-Gm-Message-State: AO0yUKVRAX0vMjeGPWgW4F58YdqkoxDtdMOcQwJy5T4hlURSmBP9G72M
        p34U+EacqLAXkwKZj1+0A1GjSK0vNAPZXKmZQoI=
X-Google-Smtp-Source: AK7set8ZCCXWXz3kvR0yFKwhqX9pPna9/Cvymyo20x61Mh5If2BA4Leh0+lHnB9+fMezLgDOEtXyKVJ2aV9TZEFRLbk=
X-Received: by 2002:a05:651c:1a2c:b0:293:4da7:669a with SMTP id
 by44-20020a05651c1a2c00b002934da7669amr2136399ljb.2.1676622466025; Fri, 17
 Feb 2023 00:27:46 -0800 (PST)
MIME-Version: 1.0
References: <20230215161047.94803-1-pierre.gondois@arm.com>
 <19209817-6451-76de-70a4-1f89808bc82a@arm.com> <CAMj1kXGspdwT95LX2-2aBFSe_LfDGcWNZQfsiMVRKREkBS+W_Q@mail.gmail.com>
 <1db35c72-c925-f33e-1cf3-2068658893b9@arm.com>
In-Reply-To: <1db35c72-c925-f33e-1cf3-2068658893b9@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 17 Feb 2023 09:27:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH+RfFV1JEnH6obKG65TFRtjx4u2bc9jFvP1=XafoZgtg@mail.gmail.com>
Message-ID: <CAMj1kXH+RfFV1JEnH6obKG65TFRtjx4u2bc9jFvP1=XafoZgtg@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: efi: Make efi_rt_lock a raw_spinlock
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 17 Feb 2023 at 09:23, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> Hello Ard,
>
> On 2/16/23 18:23, Ard Biesheuvel wrote:
> > On Thu, 16 Feb 2023 at 17:43, Pierre Gondois <pierre.gondois@arm.com> wrote:
> >>
> >> Hello,
> >> Please ignore this patch for now. While running a kernel with this patch,
> >> the following was triggered once (among multiple reboots). IRQ flags might
> >> need to be saved, along with this present patch.
> >>
> >
> > Hello Pierre,
> >
> > This is probably related to the Altra firmware bug that we are trying
> > to narrow down and work around.
> >
> > So when the firmware crashes, it is not entirely unexpected that it
> > might do so with the IRQ flags left in a different state, so this we
> > should be able to ignore. (Perhaps we should silence that diagnostic
> > in this case)
> >
> > Could you share the output of dmidecode on this platform?
>
> I forgot to mention, this was tested on an Ampere eMAG. I saw that
> commit 550b33cfd445 ("arm64: efi: Force the use of SetVirtualAddressMap()
> on Altra machines") was solving a similar issue, but this should not impact
> this machine.

That shouldn't but this one should:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=190233164cd77115f8dea718cbac561f557092c6

> I ll try to reproduce it and get more information.
>
> # dmidecode 3.2
> Getting SMBIOS data from sysfs.
> SMBIOS 3.1.1 present.
> Table at 0x8FFCAC0000.
>
> Handle 0x0000, DMI type 0, 26 bytes
> BIOS Information
>          Vendor: Ampere(TM)
>          Version: 1.0
>          Release Date: 06/28/2019
>          Address: 0xF0000
>          Runtime Size: 64 kB
>          ROM Size: 8192 kB
>          Characteristics:
>                  PCI is supported
>                  BIOS is upgradeable
>                  Boot from CD is supported
>                  Selectable boot is supported
>                  ACPI is supported
>                  UEFI is supported
>          BIOS Revision: 5.13
>          Firmware Revision: 1.0
>
> Handle 0x0001, DMI type 1, 27 bytes
> System Information
>          Manufacturer: MiTAC
>          Product Name: RAPTOR EV-883832-X3-0001
>          Version: PR010
>          Serial Number: 2AC2-B91602C
>          UUID: dfa0f1d6-835d-11e8-adb0-0cc47ad8d1fc
>          Wake-up Type: Power Switch
>          SKU Number: EV-883832-X3-OBX-1
>          Family: eMAG
>
> Handle 0x0002, DMI type 2, 15 bytes
> Base Board Information
>          Manufacturer: MiTAC
>          Product Name: RAPTOR
>          Version: EV-883832-X3-ED0-1
>          Serial Number: 2AC2-B91602C
>          Asset Tag: AMPX3A1-A000-0000000000022
>          Features:
>                  Board is a hosting board
>          Location In Chassis: Part Component
>          Chassis Handle: 0x0003
>          Type: Motherboard
>          Contained Object Handles: 0
>
> Handle 0x0003, DMI type 3, 22 bytes
> Chassis Information
>          Manufacturer: MiTAC
>          Type: Rack Mount Chassis
>          Lock: Not Present
>          Version: RAPTOR-00000000
>          Serial Number: A1A1-A000-0000000000022
>          Asset Tag: AMPX3A1-A000-0000000000022
>          Boot-up State: Safe
>          Power Supply State: Safe
>          Thermal State: Safe
>          Security Status: None
>          OEM Information: 0x00000000
>          Height: Unspecified
>          Number Of Power Cords: 1
>          Contained Elements: 0
>          SKU Number: EV-883832-X3-OBX-1
>
> Handle 0x0004, DMI type 4, 48 bytes
> Processor Information
>          Socket Designation: CPU 1
>          Type: Central Processor
>          Family: ARMv8
>          Manufacturer: Ampere(TM)
>          ID: 00 00 00 00 02 00 3F 50
>          Version: eMAG
>          Voltage: 0.9 V
>          External Clock: 3000 MHz
>          Max Speed: 3300 MHz
>          Current Speed: 3000 MHz
>          Status: Populated, Enabled
>          Upgrade: None
>          L1 Cache Handle: 0x0005
>          L2 Cache Handle: 0x0006
>          L3 Cache Handle: 0x0007
>          Serial Number: 00000000000000005011060302FB0988
>          Asset Tag: 00000000
>          Part Number: 00000000
>          Core Count: 32
>          Core Enabled: 32
>          Thread Count: 32
>          Characteristics:
>                  64-bit capable
>                  Multi-Core
>                  Hardware Thread
>                  Execute Protection
>                  Enhanced Virtualization
>
> [...]
>
>
>
>
> >
> > Obviously, there is a related issue where some process keeps hitting
> > on the RTC. Mind testing the below to see if the system is usable
> > beyond the EFI problems, and perhaps have a stab at figuring out which
> > process keeps hitting on the RTC like that?
> >
> > diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
> > index 1e8bc6cc1e12d855..cc4edb85841e8f67 100644
> > --- a/drivers/rtc/rtc-efi.c
> > +++ b/drivers/rtc/rtc-efi.c
> > @@ -164,7 +164,7 @@ static int efi_read_time(struct device *dev,
> > struct rtc_time *tm)
> >
> >          if (status != EFI_SUCCESS) {
> >                  /* should never happen */
> > -               dev_err(dev, "can't read time\n");
> > +               dev_err_ratelimited(dev, "can't read time\n");
> >                  return -EINVAL;
> >          }
> >
> >
> >
> >>
> >> random: crng init done
> >> [Firmware Bug]: Unable to handle write to read-only memory in EFI runtime service
> >> ------------[ cut here ]------------
> >> WARNING: CPU: 7 PID: 325 at drivers/firmware/efi/runtime-wrappers.c:113 efi_call_virt_check_flags+0x48/0xb0
> >> Modules linked in: btrfs blake2b_generic libcrc32c xor xor_neon raid6_pq crct10dif_ce
> >> CPU: 7 PID: 325 Comm: kworker/u64:1 Tainted: G        W I        6.2.0-rc8-rt1-[...]
> >> Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.0 06/28/2019
> >> Workqueue: efi_rts_wq efi_call_rts
> >> pstate: 00000085 (nzcv daIf -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >> pc : efi_call_virt_check_flags+0x48/0xb0
> >> lr : efi_call_rts+0x240/0x4b0
> >> sp : ffff80000def3cf0
> >> x29: ffff80000def3cf0 x28: ffff000801d10b05 x27: ffff80000b16d000
> >> x26: 0000000000000000 x25: ffff80000b17e4a0 x24: ffff80000c84bd48
> >> x23: ffff80000c84bd00 x22: ffff80000c84bd0c x21: 0000000000000080
> >> x20: ffff80000a41d0e0 x19: 0000000000000000 x18: ffff80000a22b3a8
> >> x17: 0000000000000000 x16: ffff80000d2dc000 x15: 0000000000000000
> >> x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> >> x11: 0000000000000000 x10: 0000000000000000 x9 : ffff80000927cd60
> >> x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> >> x5 : ffff80000a7d1008 x4 : 0000008ffd1d0018 x3 : 0000000000000000
> >> x2 : 0000000000000001 x1 : ffff80000a41d0e0 x0 : 0000000000000080
> >> Call trace:
> >>    efi_call_virt_check_flags+0x48/0xb0
> >>    efi_call_rts+0x240/0x4b0
> >>    process_one_work+0x2c8/0x7a0
> >>    worker_thread+0x54/0x410
> >>    kthread+0x130/0x140
> >>    ret_from_fork+0x10/0x20
> >> irq event stamp: 540538
> >> hardirqs last  enabled at (540537): [<ffff80000927d97c>] efi_virtmap_load+0x28c/0x328
> >> hardirqs last disabled at (540538): [<ffff8000095c8590>] el1_abort+0x28/0x100
> >> softirqs last  enabled at (534078): [<ffff80000819cec8>] __local_bh_enable_ip+0xa8/0x2a8
> >> softirqs last disabled at (534066): [<ffff80000934b408>] neigh_managed_work+0x8/0x100
> >> ---[ end trace 0000000000000000 ]---
> >> Disabling lock debugging due to kernel taint
> >> efi: [Firmware Bug]: IRQ flags corrupted (0x00000000=>0x00000080) by EFI set_variable
> >> ------------[ cut here ]------------
> >> WARNING: CPU: 0 PID: 14 at drivers/firmware/efi/runtime-wrappers.c:341 virt_efi_set_variable+0x164/0x1c0
> >> Modules linked in: btrfs blake2b_generic libcrc32c xor xor_neon raid6_pq crct10dif_ce
> >> CPU: 0 PID: 14 Comm: kworker/0:1 Tainted: G        W I        6.2.0-rc8-rt1-custom-[...]
> >> Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.0 06/28/2019
> >> Workqueue: events refresh_nv_rng_seed
> >> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >> pc : virt_efi_set_variable+0x164/0x1c0
> >> lr : virt_efi_set_variable+0x150/0x1c0
> >> sp : ffff80000c84bcc0
> >> x29: ffff80000c84bcc0 x28: ffff008f35feb905 x27: ffff80000b16d000
> >> x26: ffff80000b16ced0 x25: 0000000000000000 x24: ffff80000c344000
> >> x23: ffff80000a41b2b0 x22: ffff80000c84bd38 x21: 8000000000000015
> >> x20: ffff80000b63ecf8 x19: ffff80000c344480 x18: ffff80000a22b3a8
> >> x17: 000000005a8ae2d0 x16: 0000000000000000 x15: ffff80000b16cfb8
> >> x14: 0000000000000001 x13: 0000000000000030 x12: 0101010101010101
> >> x11: 0000000571f160b9 x10: 0000000000002460 x9 : ffff8000095e2064
> >> x8 : ffff80000a7d1008 x7 : 0000000000000004 x6 : ffff80000c84bb28
> >> x5 : ffff80000c84c000 x4 : ffff80000c848000 x3 : ffff80000c84bc40
> >> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 8000000000000015
> >> Call trace:
> >>    virt_efi_set_variable+0x164/0x1c0
> >>    refresh_nv_rng_seed+0x84/0xb8
> >>    process_one_work+0x2c8/0x7a0
> >>    worker_thread+0x54/0x410
> >>    kthread+0x130/0x140
> >>    ret_from_fork+0x10/0x20
> >> irq event stamp: 35886
> >> hardirqs last  enabled at (35885): [<ffff8000095e2050>] _raw_spin_unlock_irq+0x40/0xb8
> >> hardirqs last disabled at (35886): [<ffff8000095e215c>] _raw_spin_lock_irq+0x94/0x98
> >> softirqs last  enabled at (10754): [<ffff80000819cec8>] __local_bh_enable_ip+0xa8/0x2a8
> >> softirqs last disabled at (10746): [<ffff800008256de0>] srcu_invoke_callbacks+0x100/0x1a8
> >> ---[ end trace 0000000000000000 ]---
> >> [...]
> >> In-situ OAM (IOAM) with IPv6
> >> efi: EFI Runtime Services are disabled!
> >> efivars: get_next_variable: status=8000000000000007
> >> [...]
> >> rtc-efi rtc-efi.0: can't read time
> >> rtc-efi rtc-efi.0: can't read time
> >> rtc-efi rtc-efi.0: can't read time
> >> rtc-efi rtc-efi.0: can't read time
> >> rtc-efi rtc-efi.0: can't read time
> >> rtc-efi rtc-efi.0: can't read time
> >> rtc-efi rtc-efi.0: can't read time
> >> rtc-efi rtc-efi.0: can't read time
> >> rtc-efi rtc-efi.0: can't read time
> >> rtc-efi rtc-efi.0: can't read time
> >> rtc-efi rtc-efi.0: can't read time
> >> rtc-efi rtc-efi.0: can't read time
> >> rtc-efi rtc-efi.0: can't read time
> >> [...]
> >>
> >>
> >> On 2/15/23 17:10, Pierre Gondois wrote:
> >>> Running a rt-kernel base on 6.2.0-rc3-rt1 on an Ampere Altra outputs
> >>> the following:
> >>>     BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
> >>>     in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 9, name: kworker/u320:0
> >>>     preempt_count: 2, expected: 0
> >>>     RCU nest depth: 0, expected: 0
> >>>     3 locks held by kworker/u320:0/9:
> >>>     #0: ffff3fff8c27d128 ((wq_completion)efi_rts_wq){+.+.}-{0:0}, at: process_one_work (./include/linux/atomic/atomic-long.h:41)
> >>>     #1: ffff80000861bdd0 ((work_completion)(&efi_rts_work.work)){+.+.}-{0:0}, at: process_one_work (./include/linux/atomic/atomic-long.h:41)
> >>>     #2: ffffdf7e1ed3e460 (efi_rt_lock){+.+.}-{3:3}, at: efi_call_rts (drivers/firmware/efi/runtime-wrappers.c:101)
> >>>     Preemption disabled at:
> >>>     efi_virtmap_load (./arch/arm64/include/asm/mmu_context.h:248)
> >>>     CPU: 0 PID: 9 Comm: kworker/u320:0 Tainted: G        W          6.2.0-rc3-rt1
> >>>     Hardware name: WIWYNN Mt.Jade Server System B81.03001.0005/Mt.Jade Motherboard, BIOS 1.08.20220218 (SCP: 1.08.20220218) 2022/02/18
> >>>     Workqueue: efi_rts_wq efi_call_rts
> >>>     Call trace:
> >>>     dump_backtrace (arch/arm64/kernel/stacktrace.c:158)
> >>>     show_stack (arch/arm64/kernel/stacktrace.c:165)
> >>>     dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4))
> >>>     dump_stack (lib/dump_stack.c:114)
> >>>     __might_resched (kernel/sched/core.c:10134)
> >>>     rt_spin_lock (kernel/locking/rtmutex.c:1769 (discriminator 4))
> >>>     efi_call_rts (drivers/firmware/efi/runtime-wrappers.c:101)
> >>>     [...]
> >>>
> >>> This seems to come from commit ff7a167961d1 ("arm64: efi: Execute
> >>> runtime services from a dedicated stack") which adds a spinlock. This
> >>> spinlock is taken through:
> >>> efi_call_rts()
> >>> \-efi_call_virt()
> >>>     \-efi_call_virt_pointer()
> >>>       \-arch_efi_call_virt_setup()
> >>>
> >>> Make 'efi_rt_lock' a raw_spinlock to avoid being preempted.
> >>>
> >>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> >>> ---
> >>>    arch/arm64/include/asm/efi.h | 6 +++---
> >>>    arch/arm64/kernel/efi.c      | 2 +-
> >>>    2 files changed, 4 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> >>> index 31d13a6001df..37dc2e8c3500 100644
> >>> --- a/arch/arm64/include/asm/efi.h
> >>> +++ b/arch/arm64/include/asm/efi.h
> >>> @@ -33,7 +33,7 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
> >>>    ({                                                                  \
> >>>        efi_virtmap_load();                                             \
> >>>        __efi_fpsimd_begin();                                           \
> >>> -     spin_lock(&efi_rt_lock);                                        \
> >>> +     raw_spin_lock(&efi_rt_lock);                                    \
> >>>    })
> >>>
> >>>    #undef arch_efi_call_virt
> >>> @@ -42,12 +42,12 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
> >>>
> >>>    #define arch_efi_call_virt_teardown()                                       \
> >>>    ({                                                                  \
> >>> -     spin_unlock(&efi_rt_lock);                                      \
> >>> +     raw_spin_unlock(&efi_rt_lock);                                  \
> >>>        __efi_fpsimd_end();                                             \
> >>>        efi_virtmap_unload();                                           \
> >>>    })
> >>>
> >>> -extern spinlock_t efi_rt_lock;
> >>> +extern raw_spinlock_t efi_rt_lock;
> >>>    efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
> >>>
> >>>    #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
> >>> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> >>> index fab05de2e12d..216933cf47ee 100644
> >>> --- a/arch/arm64/kernel/efi.c
> >>> +++ b/arch/arm64/kernel/efi.c
> >>> @@ -145,7 +145,7 @@ asmlinkage efi_status_t efi_handle_corrupted_x18(efi_status_t s, const char *f)
> >>>        return s;
> >>>    }
> >>>
> >>> -DEFINE_SPINLOCK(efi_rt_lock);
> >>> +DEFINE_RAW_SPINLOCK(efi_rt_lock);
> >>>
> >>>    asmlinkage u64 *efi_rt_stack_top __ro_after_init;
> >>>
