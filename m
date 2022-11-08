Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B254620CE6
	for <lists+linux-efi@lfdr.de>; Tue,  8 Nov 2022 11:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbiKHKKF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Nov 2022 05:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiKHKKF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Nov 2022 05:10:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEC332BF9;
        Tue,  8 Nov 2022 02:10:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD2AB1FB;
        Tue,  8 Nov 2022 02:10:09 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6706E3F534;
        Tue,  8 Nov 2022 02:10:02 -0800 (PST)
Date:   Tue, 8 Nov 2022 10:09:51 +0000
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Possible BUG] arm64: efi: efi_runtime_fixup_exception() and
 efi_call_virt_check_flags() both taint the kernel
Message-ID: <Y2oq79NaCn6UKkLw@monolith.localdoman>
References: <Y2lAB508TrrjpDPi@monolith.localdoman>
 <CAMj1kXE1jXd_+UAgBvi2kKMMxQErH8EDAHU06mD85Es0OfsYsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE1jXd_+UAgBvi2kKMMxQErH8EDAHU06mD85Es0OfsYsQ@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Nov 07, 2022 at 06:47:48PM +0100, Ard Biesheuvel wrote:
> Hello Alexandru,
> 
> Thanks a lot for the report.
> 
> On Mon, 7 Nov 2022 at 18:27, Alexandru Elisei <alexandru.elisei@arm.com> wrote:
> >
> > I'm going to preface this by saying that I'm extremely unfamiliar with the
> > EFI code.
> >
> > Commit d3549a938b73 ("efi/arm64: libstub: avoid SetVirtualAddressMap() when
> > possible") skipped the call to SetVirtualAddressMap() for certain
> > configurations, and that started causing kernel panics on an Ampere Altra
> > machine due to an EFI synchronous exception.
> >
> > Commit 23715a26c8d8 ("arm64: efi: Recover from synchronous exceptions
> > occurring in firmware") made the EFI exception non-fatal.
> >
> > With a kernel built from v6.1-rc4 (which has both patches), I'm now getting
> > two splats on the same Altra machine (log below). Looks to me like the
> > second splat is caused by efi_call_virt_check_flags() using the
> > PSTATE.{I,F} values from when taking the exception. Shouldn't
> > efi_runtime_fixup_exception() fix up the exception so the error isn't
> > propagated along the call chain?
> >
> 
> No, that is not exactly how I intended this to work.
> 
> The new code will essentially do a pseudo-longjmp() back to the asm
> wrapper if a sync exception occurs during a runtime services call, and
> return EFI_ABORTED to the caller. This return will go via the ordinary
> setup/teardown helpers that check whether interrupts were left in a
> different state by the firmware.
> 
> > I'm asking this because efi_runtime_fixup_exception() has this add_taint()
> > call:
> >
> >         pr_err(FW_BUG "Unable to handle %s in EFI runtime service\n", msg);
> >         add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
> >
> 
> So this one runs first, and sets the taint because we crashed in the
> firmware. There is no shared state between the firmware and the
> kernel, so we should be able to carry on as usual.
> 
> > and then efi_call_virt_check_flags() has this call:
> >
> >         mismatch = flags ^ cur_flags;
> >         if (!WARN_ON_ONCE(mismatch & ARCH_EFI_IRQ_FLAGS_MASK))
> >                 return;
> >
> >         add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_NOW_UNRELIABLE);
> >
> > It looks to me like LOCKDEP_STILL_OK from the first call is at odds with
> > LOCKDEP_NOW_UNRELIABLE from the second add_taint() call.
> >
> 
> This one runs next, and sets the taint because the sync exception
> occurred when the EFI runtime services was running with interrupts
> disabled.
> 
> The latter check was added because when we started running runtime
> services with interrupts enabled (which wasn't the case before), we
> started to see issues with firmware that disabled interrupts but never
> re-enabled them again. So this is really a different issue.
> 
> So the question is whether we can assume that we can carry on as usual
> when we abort a runtime service call that has disabled interrupts,
> while we set the LOCKDEP_NOW_UNRELIABLE flag if the runtime service
> simply returned that way.

efi_handle_runtime_exception() clears the EFI_RUNTIME_SERVICES in
efi.flags, and the comment for the flag suggests that runtime services will
not be available from that point on. If runtime services are disabled, does
it still make sense to set LOCKDEP_NOW_UNRELIABLE?

> 
> So my assumption here was that we cannot, and the double taint is
> simply the result of two different things happening at the same time.
> 
> 
> > Here is the relevant part of the log (I can send the .config, kernel
> > command line and full log, or any other information that might be needed):
> >
> 
> Thanks, this is really useful.
> 
> > [   55.479519] [Firmware Bug]: Unable to handle paging request in EFI runtime service
> > [   55.487122] CPU: 62 PID: 9 Comm: kworker/u320:0 Tainted: G          I        6.1.0-rc4 #60
> > [   55.487128] Hardware name: WIWYNN Mt.Jade Server System B81.03001.0005/Mt.Jade Motherboard, BIOS 1.08.20220218 (SCP: 1.08.20220218) 2022/02/18
> > [   55.487131] Workqueue: efi_rts_wq efi_call_rts
> > [   55.487158] Call trace:
> > [   55.487161]  dump_backtrace.part.0+0xdc/0xf0
> > [   55.487177]  show_stack+0x18/0x40
> > [   55.487180]  dump_stack_lvl+0x68/0x84
> > [   55.487190]  dump_stack+0x18/0x34
> > [   55.487192]  efi_runtime_fixup_exception+0x74/0x88
> > [   55.487199]  __do_kernel_fault+0x108/0x1b0
> > [   55.487204]  do_page_fault+0xd0/0x400
> > [   55.487207]  do_translation_fault+0xac/0xc0
> > [   55.487209]  do_mem_abort+0x44/0x94
> > [   55.487212]  el1_abort+0x40/0x6c
> > [   55.487214]  el1h_64_sync_handler+0xd8/0xe4
> > [   55.487218]  el1h_64_sync+0x64/0x68
> > [   55.487221]  0xb7eb7ae4
> > [   55.487224]  0xb7eb8668
> > [   55.487225]  0xb7eb6e08
> > [   55.487227]  0xb7eb68ec
> > [   55.487228]  0xb7eb3824
> > [   55.487230]  0xb7eb05a8
> > [   55.487231]  0xb7eb12a0
> > [   55.487232]  0xb7e43504
> > [   55.487234]  0xb7e43650
> > [   55.487235]  0xb7e482d0
> > [   55.487237]  0xb7e4907c
> > [   55.487238]  0xb7e49ff4
> > [   55.487239]  0xb7e40888
> > [   55.487241]  0xb7cb3328
> > [   55.487242]  0xb7cb0674
> > [   55.487243]  __efi_rt_asm_wrapper+0x54/0x70
> > [   55.487246]  efi_call_rts+0x28c/0x3d0
> > [   55.487249]  process_one_work+0x1d0/0x320
> > [   55.487258]  worker_thread+0x14c/0x444
> > [   55.487261]  kthread+0x10c/0x110
> > [   55.487264]  ret_from_fork+0x10/0x20
> > [   55.487268] [Firmware Bug]: Synchronous exception occurred in EFI runtime service set_time()
> 
> Interestingly, this occurs on set_time() rather than get_time(), which
> is called first when the efi-rtc driver loads.
> 
> If you blacklist the driver, do the EFI variables still work on this
> machine? This is mostly relevant for the vendor I suppose, but
> interesting nonetheless

Works just fine, tried it with v6.1-rc4, no errors on dmesg,
/sys/firmware/efi/efivars is mounted and looks sane to me (efibootmgr also
seems to be working fine, didn't modify/add entries though).

> 
> Ultimately, we might end up having to revert d3549a938b73 ("efi/arm64:
> libstub: avoid SetVirtualAddressMap() when possible"), but this would
> be rather unfortunate: that puts us in the same situation as x86,
> where some systems need SetVirtualAddressMap() to be called, and some
> crash when you call it (the Snapdragon WoA laptops)

Speaking as an user, I think it would be nice to revert the commit, that's
how I am running v6.1-rcX kernels on the machine, as updating the firmware
is not feasible right now. But I realize that I'm not the one maintaining
the code, so I don't have a strong opinion about it :) And it's better now
than it was at rc3, when the kernel was panicing.

Thanks,
Alex

> 
> > [   55.495735] ------------[ cut here ]------------
> > [   55.495739] WARNING: CPU: 62 PID: 9 at drivers/firmware/efi/runtime-wrappers.c:111 efi_call_virt_check_flags+0x40/0xac
> > [   55.495746] Modules linked in:
> > [   55.495749] CPU: 62 PID: 9 Comm: kworker/u320:0 Tainted: G          I        6.1.0-rc4 #60
> > [   55.495751] Hardware name: WIWYNN Mt.Jade Server System B81.03001.0005/Mt.Jade Motherboard, BIOS 1.08.20220218 (SCP: 1.08.20220218) 2022/02/18
> > [   55.495753] Workqueue: efi_rts_wq efi_call_rts
> > [   55.495757] pstate: 004000c9 (nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [   55.495761] pc : efi_call_virt_check_flags+0x40/0xac
> > [   55.495764] lr : efi_call_rts+0x29c/0x3d0
> > [   55.495767] sp : ffff80000861bd40
> > [   55.495768] x29: ffff80000861bd40 x28: 0000000000000000 x27: 0000000000000000
> > [   55.495772] x26: ffffb251470e9e68 x25: ffff3fff89714805 x24: 0000000000000000
> > [   55.495775] x23: 0000000000000000 x22: 0000000000000000 x21: 00000000000000c0
> > [   55.495778] x20: ffffb25146688de0 x19: 0000000000000000 x18: ffffffffffffffff
> > [   55.495780] x17: 657320656d69746e x16: 757220494645206e x15: 6920646572727563
> > [   55.495784] x14: 636f206e6f697470 x13: ffff403e40540000 x12: 0000000000001c14
> > [   55.495787] x11: 000000000000095c x10: ffff403e40800000 x9 : ffff403e40540000
> > [   55.495790] x8 : 00000000ffff7fff x7 : ffff403e40800000 x6 : 0000000000000000
> > [   55.495792] x5 : ffff083e7fe9aaa0 x4 : 0000000000000000 x3 : 0000000000000000
> > [   55.495796] x2 : 0000000000000000 x1 : ffffb25146688de0 x0 : 00000000000000c0
> > [   55.495799] Call trace:
> > [   55.495800]  efi_call_virt_check_flags+0x40/0xac
> > [   55.495802]  efi_call_rts+0x29c/0x3d0
> > [   55.495805]  process_one_work+0x1d0/0x320
> > [   55.495808]  worker_thread+0x14c/0x444
> > [   55.495811]  kthread+0x10c/0x110
> > [   55.495814]  ret_from_fork+0x10/0x20
> > [   55.495815] ---[ end trace 0000000000000000 ]---
> > [   55.495818] Disabling lock debugging due to kernel taint
> > [   55.495822] efi: [Firmware Bug]: IRQ flags corrupted (0x00000000=>0x000000c0) by EFI set_time
> > [   55.504434] efi: EFI Runtime Services are disabled!
> > [   55.504465] rtc-efi rtc-efi.0: can't read time
> > [   56.479370] efi: EFI Runtime Services are disabled!
> > [   56.479394] rtc-efi rtc-efi.0: can't read time
> > [   57.479574] rtc-efi rtc-efi.0: can't read time
> > [   57.484030] rtc-efi rtc-efi.0: can't read time
> > [   57.488474] rtc-efi rtc-efi.0: can't read time
> > [   58.479692] rtc-efi rtc-efi.0: can't read time
> > [   58.484139] rtc-efi rtc-efi.0: can't read time
> >
> > (rtc-efi error message repeats ad nauseum)
> >
> > Note: this error message from the EFI rtc driver fires over and over and
> > clutters dmesg, will send a different report for this as I don't think it's
> > necessarily related to the two functions.
> >
> 
> Yes, please. That should at least have a rate limit on it, but maybe a
> warn_once is better here.
