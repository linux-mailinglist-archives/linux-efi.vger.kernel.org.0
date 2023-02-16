Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C0F699A60
	for <lists+linux-efi@lfdr.de>; Thu, 16 Feb 2023 17:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBPQnS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Feb 2023 11:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBPQnR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Feb 2023 11:43:17 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8EE5A5D6;
        Thu, 16 Feb 2023 08:43:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAA381042;
        Thu, 16 Feb 2023 08:43:57 -0800 (PST)
Received: from [10.34.100.128] (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 389A93F881;
        Thu, 16 Feb 2023 08:43:14 -0800 (PST)
Message-ID: <19209817-6451-76de-70a4-1f89808bc82a@arm.com>
Date:   Thu, 16 Feb 2023 17:43:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] arm64: efi: Make efi_rt_lock a raw_spinlock
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230215161047.94803-1-pierre.gondois@arm.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20230215161047.94803-1-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello,
Please ignore this patch for now. While running a kernel with this patch,
the following was triggered once (among multiple reboots). IRQ flags might
need to be saved, along with this present patch.

Regards,
Pierre

random: crng init done
[Firmware Bug]: Unable to handle write to read-only memory in EFI runtime service
------------[ cut here ]------------
WARNING: CPU: 7 PID: 325 at drivers/firmware/efi/runtime-wrappers.c:113 efi_call_virt_check_flags+0x48/0xb0
Modules linked in: btrfs blake2b_generic libcrc32c xor xor_neon raid6_pq crct10dif_ce
CPU: 7 PID: 325 Comm: kworker/u64:1 Tainted: G        W I        6.2.0-rc8-rt1-[...]
Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.0 06/28/2019
Workqueue: efi_rts_wq efi_call_rts
pstate: 00000085 (nzcv daIf -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : efi_call_virt_check_flags+0x48/0xb0
lr : efi_call_rts+0x240/0x4b0
sp : ffff80000def3cf0
x29: ffff80000def3cf0 x28: ffff000801d10b05 x27: ffff80000b16d000
x26: 0000000000000000 x25: ffff80000b17e4a0 x24: ffff80000c84bd48
x23: ffff80000c84bd00 x22: ffff80000c84bd0c x21: 0000000000000080
x20: ffff80000a41d0e0 x19: 0000000000000000 x18: ffff80000a22b3a8
x17: 0000000000000000 x16: ffff80000d2dc000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : ffff80000927cd60
x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff80000a7d1008 x4 : 0000008ffd1d0018 x3 : 0000000000000000
x2 : 0000000000000001 x1 : ffff80000a41d0e0 x0 : 0000000000000080
Call trace:
  efi_call_virt_check_flags+0x48/0xb0
  efi_call_rts+0x240/0x4b0
  process_one_work+0x2c8/0x7a0
  worker_thread+0x54/0x410
  kthread+0x130/0x140
  ret_from_fork+0x10/0x20
irq event stamp: 540538
hardirqs last  enabled at (540537): [<ffff80000927d97c>] efi_virtmap_load+0x28c/0x328
hardirqs last disabled at (540538): [<ffff8000095c8590>] el1_abort+0x28/0x100
softirqs last  enabled at (534078): [<ffff80000819cec8>] __local_bh_enable_ip+0xa8/0x2a8
softirqs last disabled at (534066): [<ffff80000934b408>] neigh_managed_work+0x8/0x100
---[ end trace 0000000000000000 ]---
Disabling lock debugging due to kernel taint
efi: [Firmware Bug]: IRQ flags corrupted (0x00000000=>0x00000080) by EFI set_variable
------------[ cut here ]------------
WARNING: CPU: 0 PID: 14 at drivers/firmware/efi/runtime-wrappers.c:341 virt_efi_set_variable+0x164/0x1c0
Modules linked in: btrfs blake2b_generic libcrc32c xor xor_neon raid6_pq crct10dif_ce
CPU: 0 PID: 14 Comm: kworker/0:1 Tainted: G        W I        6.2.0-rc8-rt1-custom-[...]
Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.0 06/28/2019
Workqueue: events refresh_nv_rng_seed
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : virt_efi_set_variable+0x164/0x1c0
lr : virt_efi_set_variable+0x150/0x1c0
sp : ffff80000c84bcc0
x29: ffff80000c84bcc0 x28: ffff008f35feb905 x27: ffff80000b16d000
x26: ffff80000b16ced0 x25: 0000000000000000 x24: ffff80000c344000
x23: ffff80000a41b2b0 x22: ffff80000c84bd38 x21: 8000000000000015
x20: ffff80000b63ecf8 x19: ffff80000c344480 x18: ffff80000a22b3a8
x17: 000000005a8ae2d0 x16: 0000000000000000 x15: ffff80000b16cfb8
x14: 0000000000000001 x13: 0000000000000030 x12: 0101010101010101
x11: 0000000571f160b9 x10: 0000000000002460 x9 : ffff8000095e2064
x8 : ffff80000a7d1008 x7 : 0000000000000004 x6 : ffff80000c84bb28
x5 : ffff80000c84c000 x4 : ffff80000c848000 x3 : ffff80000c84bc40
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 8000000000000015
Call trace:
  virt_efi_set_variable+0x164/0x1c0
  refresh_nv_rng_seed+0x84/0xb8
  process_one_work+0x2c8/0x7a0
  worker_thread+0x54/0x410
  kthread+0x130/0x140
  ret_from_fork+0x10/0x20
irq event stamp: 35886
hardirqs last  enabled at (35885): [<ffff8000095e2050>] _raw_spin_unlock_irq+0x40/0xb8
hardirqs last disabled at (35886): [<ffff8000095e215c>] _raw_spin_lock_irq+0x94/0x98
softirqs last  enabled at (10754): [<ffff80000819cec8>] __local_bh_enable_ip+0xa8/0x2a8
softirqs last disabled at (10746): [<ffff800008256de0>] srcu_invoke_callbacks+0x100/0x1a8
---[ end trace 0000000000000000 ]---
[...]
In-situ OAM (IOAM) with IPv6
efi: EFI Runtime Services are disabled!
efivars: get_next_variable: status=8000000000000007
[...]
rtc-efi rtc-efi.0: can't read time
rtc-efi rtc-efi.0: can't read time
rtc-efi rtc-efi.0: can't read time
rtc-efi rtc-efi.0: can't read time
rtc-efi rtc-efi.0: can't read time
rtc-efi rtc-efi.0: can't read time
rtc-efi rtc-efi.0: can't read time
rtc-efi rtc-efi.0: can't read time
rtc-efi rtc-efi.0: can't read time
rtc-efi rtc-efi.0: can't read time
rtc-efi rtc-efi.0: can't read time
rtc-efi rtc-efi.0: can't read time
rtc-efi rtc-efi.0: can't read time
[...]


On 2/15/23 17:10, Pierre Gondois wrote:
> Running a rt-kernel base on 6.2.0-rc3-rt1 on an Ampere Altra outputs
> the following:
>    BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
>    in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 9, name: kworker/u320:0
>    preempt_count: 2, expected: 0
>    RCU nest depth: 0, expected: 0
>    3 locks held by kworker/u320:0/9:
>    #0: ffff3fff8c27d128 ((wq_completion)efi_rts_wq){+.+.}-{0:0}, at: process_one_work (./include/linux/atomic/atomic-long.h:41)
>    #1: ffff80000861bdd0 ((work_completion)(&efi_rts_work.work)){+.+.}-{0:0}, at: process_one_work (./include/linux/atomic/atomic-long.h:41)
>    #2: ffffdf7e1ed3e460 (efi_rt_lock){+.+.}-{3:3}, at: efi_call_rts (drivers/firmware/efi/runtime-wrappers.c:101)
>    Preemption disabled at:
>    efi_virtmap_load (./arch/arm64/include/asm/mmu_context.h:248)
>    CPU: 0 PID: 9 Comm: kworker/u320:0 Tainted: G        W          6.2.0-rc3-rt1
>    Hardware name: WIWYNN Mt.Jade Server System B81.03001.0005/Mt.Jade Motherboard, BIOS 1.08.20220218 (SCP: 1.08.20220218) 2022/02/18
>    Workqueue: efi_rts_wq efi_call_rts
>    Call trace:
>    dump_backtrace (arch/arm64/kernel/stacktrace.c:158)
>    show_stack (arch/arm64/kernel/stacktrace.c:165)
>    dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4))
>    dump_stack (lib/dump_stack.c:114)
>    __might_resched (kernel/sched/core.c:10134)
>    rt_spin_lock (kernel/locking/rtmutex.c:1769 (discriminator 4))
>    efi_call_rts (drivers/firmware/efi/runtime-wrappers.c:101)
>    [...]
> 
> This seems to come from commit ff7a167961d1 ("arm64: efi: Execute
> runtime services from a dedicated stack") which adds a spinlock. This
> spinlock is taken through:
> efi_call_rts()
> \-efi_call_virt()
>    \-efi_call_virt_pointer()
>      \-arch_efi_call_virt_setup()
> 
> Make 'efi_rt_lock' a raw_spinlock to avoid being preempted.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>   arch/arm64/include/asm/efi.h | 6 +++---
>   arch/arm64/kernel/efi.c      | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> index 31d13a6001df..37dc2e8c3500 100644
> --- a/arch/arm64/include/asm/efi.h
> +++ b/arch/arm64/include/asm/efi.h
> @@ -33,7 +33,7 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
>   ({									\
>   	efi_virtmap_load();						\
>   	__efi_fpsimd_begin();						\
> -	spin_lock(&efi_rt_lock);					\
> +	raw_spin_lock(&efi_rt_lock);					\
>   })
>   
>   #undef arch_efi_call_virt
> @@ -42,12 +42,12 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
>   
>   #define arch_efi_call_virt_teardown()					\
>   ({									\
> -	spin_unlock(&efi_rt_lock);					\
> +	raw_spin_unlock(&efi_rt_lock);					\
>   	__efi_fpsimd_end();						\
>   	efi_virtmap_unload();						\
>   })
>   
> -extern spinlock_t efi_rt_lock;
> +extern raw_spinlock_t efi_rt_lock;
>   efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
>   
>   #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index fab05de2e12d..216933cf47ee 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -145,7 +145,7 @@ asmlinkage efi_status_t efi_handle_corrupted_x18(efi_status_t s, const char *f)
>   	return s;
>   }
>   
> -DEFINE_SPINLOCK(efi_rt_lock);
> +DEFINE_RAW_SPINLOCK(efi_rt_lock);
>   
>   asmlinkage u64 *efi_rt_stack_top __ro_after_init;
>   
