Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4C6620DE1
	for <lists+linux-efi@lfdr.de>; Tue,  8 Nov 2022 11:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbiKHKzn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Nov 2022 05:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbiKHKza (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Nov 2022 05:55:30 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C7E048776;
        Tue,  8 Nov 2022 02:55:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F078523A;
        Tue,  8 Nov 2022 02:55:33 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 472ED3F534;
        Tue,  8 Nov 2022 02:55:26 -0800 (PST)
Date:   Tue, 8 Nov 2022 10:55:15 +0000
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ardb@kernel.org, linux-efi@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [BUG] rtc-efi: Error in efi.get_time() spams dmesg with error message
Message-ID: <Y2o1hdZK9GGDVJsS@monolith.localdoman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

Commit d3549a938b73 ("efi/arm64: libstub: avoid SetVirtualAddressMap() when
possible") exposed a firmware error on an Ampere Altra machine that was
causing the machine to panic. Then commit 23715a26c8d8 ("arm64: efi:
Recover from synchronous exceptions occurring in firmware") made the EFI
exception non-fatal, and disabled runtime services when the exception
happens. The interaction between those two patches are being discussed in a
separate thread [1], but that should be orthogonal to this.

Now efi.get_time() fails and each time an error message is printed to
dmesg, which happens several times a second and clutters dmesg
unnecessarily, to the point it becomes unusable.

I was wondering if it would be possible to turn dev_err() into a
dev_WARN_ONCE() or do something to avoid this issue. Tried to replace
dev_err() with dev_err_ratelimited(), and the error message was displayed
less often (about once per second), but dmesg was still being cluttered.

Here's a log with what is happening (the boot part of the log has been
removed for brevity, I've kept the kernel splats for context, can provide
full logs, kernel config, command line, etc, to reproduce it; goes without
saying that I am willing to test the fix myself):

[   55.479519] [Firmware Bug]: Unable to handle paging request in EFI runtime service
[   55.487122] CPU: 62 PID: 9 Comm: kworker/u320:0 Tainted: G          I        6.1.0-rc4 #60
[   55.487128] Hardware name: WIWYNN Mt.Jade Server System B81.03001.0005/Mt.Jade Motherboard, BIOS 1.08.20220218 (SCP: 1.08.20220218) 2022/02/18
[   55.487131] Workqueue: efi_rts_wq efi_call_rts
[   55.487158] Call trace:
[   55.487161]  dump_backtrace.part.0+0xdc/0xf0
[   55.487177]  show_stack+0x18/0x40
[   55.487180]  dump_stack_lvl+0x68/0x84
[   55.487190]  dump_stack+0x18/0x34
[   55.487192]  efi_runtime_fixup_exception+0x74/0x88
[   55.487199]  __do_kernel_fault+0x108/0x1b0
[   55.487204]  do_page_fault+0xd0/0x400
[   55.487207]  do_translation_fault+0xac/0xc0
[   55.487209]  do_mem_abort+0x44/0x94
[   55.487212]  el1_abort+0x40/0x6c
[   55.487214]  el1h_64_sync_handler+0xd8/0xe4
[   55.487218]  el1h_64_sync+0x64/0x68
[   55.487221]  0xb7eb7ae4
[   55.487224]  0xb7eb8668
[   55.487225]  0xb7eb6e08
[   55.487227]  0xb7eb68ec
[   55.487228]  0xb7eb3824
[   55.487230]  0xb7eb05a8
[   55.487231]  0xb7eb12a0
[   55.487232]  0xb7e43504
[   55.487234]  0xb7e43650
[   55.487235]  0xb7e482d0
[   55.487237]  0xb7e4907c
[   55.487238]  0xb7e49ff4
[   55.487239]  0xb7e40888
[   55.487241]  0xb7cb3328
[   55.487242]  0xb7cb0674
[   55.487243]  __efi_rt_asm_wrapper+0x54/0x70
[   55.487246]  efi_call_rts+0x28c/0x3d0
[   55.487249]  process_one_work+0x1d0/0x320
[   55.487258]  worker_thread+0x14c/0x444
[   55.487261]  kthread+0x10c/0x110
[   55.487264]  ret_from_fork+0x10/0x20
[   55.487268] [Firmware Bug]: Synchronous exception occurred in EFI runtime service set_time()
[   55.495735] ------------[ cut here ]------------
[   55.495739] WARNING: CPU: 62 PID: 9 at drivers/firmware/efi/runtime-wrappers.c:111 efi_call_virt_check_flags+0x40/0xac
[   55.495746] Modules linked in:
[   55.495749] CPU: 62 PID: 9 Comm: kworker/u320:0 Tainted: G          I        6.1.0-rc4 #60
[   55.495751] Hardware name: WIWYNN Mt.Jade Server System B81.03001.0005/Mt.Jade Motherboard, BIOS 1.08.20220218 (SCP: 1.08.20220218) 2022/02/18
[   55.495753] Workqueue: efi_rts_wq efi_call_rts
[   55.495757] pstate: 004000c9 (nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   55.495761] pc : efi_call_virt_check_flags+0x40/0xac
[   55.495764] lr : efi_call_rts+0x29c/0x3d0
[   55.495767] sp : ffff80000861bd40
[   55.495768] x29: ffff80000861bd40 x28: 0000000000000000 x27: 0000000000000000
[   55.495772] x26: ffffb251470e9e68 x25: ffff3fff89714805 x24: 0000000000000000
[   55.495775] x23: 0000000000000000 x22: 0000000000000000 x21: 00000000000000c0
[   55.495778] x20: ffffb25146688de0 x19: 0000000000000000 x18: ffffffffffffffff
[   55.495780] x17: 657320656d69746e x16: 757220494645206e x15: 6920646572727563
[   55.495784] x14: 636f206e6f697470 x13: ffff403e40540000 x12: 0000000000001c14
[   55.495787] x11: 000000000000095c x10: ffff403e40800000 x9 : ffff403e40540000
[   55.495790] x8 : 00000000ffff7fff x7 : ffff403e40800000 x6 : 0000000000000000
[   55.495792] x5 : ffff083e7fe9aaa0 x4 : 0000000000000000 x3 : 0000000000000000
[   55.495796] x2 : 0000000000000000 x1 : ffffb25146688de0 x0 : 00000000000000c0
[   55.495799] Call trace:
[   55.495800]  efi_call_virt_check_flags+0x40/0xac
[   55.495802]  efi_call_rts+0x29c/0x3d0
[   55.495805]  process_one_work+0x1d0/0x320
[   55.495808]  worker_thread+0x14c/0x444
[   55.495811]  kthread+0x10c/0x110
[   55.495814]  ret_from_fork+0x10/0x20
[   55.495815] ---[ end trace 0000000000000000 ]---
[   55.495818] Disabling lock debugging due to kernel taint
[   55.495822] efi: [Firmware Bug]: IRQ flags corrupted (0x00000000=>0x000000c0) by EFI set_time
[   55.504434] efi: EFI Runtime Services are disabled!
[   55.504465] rtc-efi rtc-efi.0: can't read time
[   56.479370] efi: EFI Runtime Services are disabled!
[   56.479394] rtc-efi rtc-efi.0: can't read time
[   56.483855] rtc-efi rtc-efi.0: can't read time
[   56.488306] rtc-efi rtc-efi.0: can't read time
[   57.479574] rtc-efi rtc-efi.0: can't read time
[   57.484030] rtc-efi rtc-efi.0: can't read time
[   57.488474] rtc-efi rtc-efi.0: can't read time
[   58.479692] rtc-efi rtc-efi.0: can't read time
[   58.484139] rtc-efi rtc-efi.0: can't read time
[   58.488582] rtc-efi rtc-efi.0: can't read time
[   59.479691] rtc-efi rtc-efi.0: can't read time
... on, and on, on ...

[1] https://lore.kernel.org/linux-arm-kernel/Y2lAB508TrrjpDPi@monolith.localdoman/

Thanks,
Alex
