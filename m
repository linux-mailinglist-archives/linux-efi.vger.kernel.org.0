Return-Path: <linux-efi+bounces-5831-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E255CB2813
	for <lists+linux-efi@lfdr.de>; Wed, 10 Dec 2025 10:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9DAB30052FD
	for <lists+linux-efi@lfdr.de>; Wed, 10 Dec 2025 09:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5C73064B7;
	Wed, 10 Dec 2025 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftImlrtv"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D917130504A
	for <linux-efi@vger.kernel.org>; Wed, 10 Dec 2025 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765358009; cv=none; b=MbBeK+OxbbV5z7DyRN5qiUmhwXyadbP5qIqxdMrqKh5Y/UgqGwkt1+fHg4XFP3gXCpB2nxhXnP+JUu7TuJ5+/6+tWt6j6VCLZ7WLxWrr7QIi7GgyOZf+cqZoDSDGQAadYdMwDybWAqEYosv88YUZkKATdBSY+C6IaGZToHMY0B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765358009; c=relaxed/simple;
	bh=+qVEJJpusOtj4myBjH3A5S2voGSJawvzql3mlQ+6dkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cumkr1tDAWVizWEJzyW9pCak4qHfGQ8UWhjIwP1C8U+SQFLygEl+4TezqLpQ1Oo3ZnUfJlIfbVUgfQYFO7Fud5fOzok/2VOhcjMMVxrMvwBbJH+knxOk1U5GFEnhuM6jYQTdUE7DL+sUUncOFr9QNZwn6LExtRmDuXZZXXaEv7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftImlrtv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4B4C19422
	for <linux-efi@vger.kernel.org>; Wed, 10 Dec 2025 09:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765358009;
	bh=+qVEJJpusOtj4myBjH3A5S2voGSJawvzql3mlQ+6dkM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ftImlrtvQzs+Nyq04L4pEL0/IkLKY/EsgtOIYbSVkhaJC4qEAQDxNZZiiJlUJluqc
	 UZALqBeYvyzXRQcgAwPJrwvFmT8LwJjR0LVK4A5x4E0QFimxWZPwIPtoQCqqCSoRIs
	 VKTERpu9AQNI1LmYPA3FJlK+BDKd0o6v/n+ntIvDVg7UqfRuaxPjJwNoPj6M9w93xm
	 t+QK8EgmvFTKBA77anmfxXe+HsUrq1F415npkIjMZr+cKrXk7/PIqw6a7+T0HKJo/6
	 OPp7Q9x1YKZ9T1oOVRV1MEiwqBid2kdplwQH4vmpJ9LLmNnDPiZHt9Jw1lScHPpJfj
	 3xdc4Vx/S/Qrw==
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-340bb1cb9ddso5498564a91.2
        for <linux-efi@vger.kernel.org>; Wed, 10 Dec 2025 01:13:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUbS8idO79VXbSoDsXzteWA8Af2lj1Gt2LWJ+P67SaCt1JqyOJVd+cdrUgqDPN5ma+lKKZfQYH3Sv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtUTLHMi3CFGjFT+S1/dw8dv2XJA90Y1KDuUWrVPQnMUm5jFkZ
	cgRxoheairJfWi9/asj8tNMQx/QWOHSFMKjunE4YTV1spejFnnbCCywOs5boRIaudBUB7Gq0FFo
	iXb849/CR6bP+Fr5ln8TSa+WmTrW26ek=
X-Google-Smtp-Source: AGHT+IGTzktv3sxqX8VBR6VL64XK/kGgV8PfmOyq+ZmC6H7dY58aWGllhwS8Q9cNv9Jyhg8BbKY73xyhU7uMpQuMgJI=
X-Received: by 2002:a17:90a:c883:b0:340:ca7d:936a with SMTP id
 98e67ed59e1d1-34a72900fe9mr1780418a91.18.1765358009039; Wed, 10 Dec 2025
 01:13:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203042850.14210-1-val@packett.cool> <202512101632.a94de49b-lkp@intel.com>
In-Reply-To: <202512101632.a94de49b-lkp@intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 10 Dec 2025 18:13:17 +0900
X-Gmail-Original-Message-ID: <CAMj1kXGfTNQcX-hoAy63PNU_-eb03LJLYmQGXvBB3SsGM+e1hA@mail.gmail.com>
X-Gm-Features: AQt7F2pOPEpJdRzpWEKE_Dh28a7CDmmSGz4-lW6nxrGzHX5-9RhHfneLyoij6mg
Message-ID: <CAMj1kXGfTNQcX-hoAy63PNU_-eb03LJLYmQGXvBB3SsGM+e1hA@mail.gmail.com>
Subject: Re: [PATCH] efi: pstore: Support late setup with TEE-backed efivars ops
To: Kees Cook <kees@kernel.org>
Cc: Val Packett <val@packett.cool>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-hardening@vger.kernel.org, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Dec 2025 at 17:41, kernel test robot <oliver.sang@intel.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "WARNING:at_kernel/locking/rwsem.c:#__down_write_trylock" on:
>
> commit: 6f473fefec79a8ba24013a5676a93934ee5ac922 ("[PATCH] efi: pstore: Support late setup with TEE-backed efivars ops")
> url: https://github.com/intel-lab-lkp/linux/commits/Val-Packett/efi-pstore-Support-late-setup-with-TEE-backed-efivars-ops/20251203-123406
> base: https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git for-next/pstore
> patch link: https://lore.kernel.org/all/20251203042850.14210-1-val@packett.cool/
> patch subject: [PATCH] efi: pstore: Support late setup with TEE-backed efivars ops
>
> in testcase: boot
>
> config: i386-randconfig-015-20251207
> compiler: clang-20
> test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> +---------------------------------------------------------+------------+------------+
> |                                                         | b692553573 | 6f473fefec |
> +---------------------------------------------------------+------------+------------+
> | WARNING:at_kernel/locking/rwsem.c:#__down_write_trylock | 0          | 18         |
> | EIP:__down_write_trylock                                | 0          | 18         |
> | WARNING:at_kernel/locking/rwsem.c:#up_write             | 0          | 18         |
> | EIP:up_write                                            | 0          | 18         |
> +---------------------------------------------------------+------------+------------+
>

This seems to be a non-EFI boot, in which case the notifier chain is
never initialized.

Kees, can you drop this from your branch so we can get it fixed? I
also had some review feedback that hasn't been taken into account yet.



>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202512101632.a94de49b-lkp@intel.com
>
>
> [    7.731121][    T1] ------------[ cut here ]------------
> [    7.731800][    T1] DEBUG_RWSEMS_WARN_ON(sem->magic != sem): count = 0x0, magic = 0x0, owner = 0x0, curr 0xc0288000, list not empty
> [    7.733282][    T1] WARNING: CPU: 0 PID: 1 at kernel/locking/rwsem.c:1339 __down_write_trylock (kernel/locking/rwsem.c:1339)
> [    7.734420][    T1] Modules linked in:
> [    7.734903][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.18.0-rc2-00002-g6f473fefec79 #1 PREEMPT(none)
> [    7.736185][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [    7.737529][    T1] EIP: __down_write_trylock (kernel/locking/rwsem.c:1339)
> [    7.738173][    T1] Code: c1 92 28 c2 bf 39 3e 26 c2 0f 44 fa 57 50 ff 71 04 56 ff 31 68 dc f4 35 c2 68 fe 5b 35 c2 89 cf e8 81 d1 e8 ff 89 f9 83 c4 1c <0f> 0b 39 ce 0f 85 4b ff ff ff e9 4f ff ff ff 0f 0b eb 8b 90 90 90
> All code
> ========
>    0:   c1 92 28 c2 bf 39 3e    rcll   $0x3e,0x39bfc228(%rdx)
>    7:   26 c2 0f 44             es ret $0x440f
>    b:   fa                      cli
>    c:   57                      push   %rdi
>    d:   50                      push   %rax
>    e:   ff 71 04                push   0x4(%rcx)
>   11:   56                      push   %rsi
>   12:   ff 31                   push   (%rcx)
>   14:   68 dc f4 35 c2          push   $0xffffffffc235f4dc
>   19:   68 fe 5b 35 c2          push   $0xffffffffc2355bfe
>   1e:   89 cf                   mov    %ecx,%edi
>   20:   e8 81 d1 e8 ff          call   0xffffffffffe8d1a6
>   25:   89 f9                   mov    %edi,%ecx
>   27:   83 c4 1c                add    $0x1c,%esp
>   2a:*  0f 0b                   ud2             <-- trapping instruction
>   2c:   39 ce                   cmp    %ecx,%esi
>   2e:   0f 85 4b ff ff ff       jne    0xffffffffffffff7f
>   34:   e9 4f ff ff ff          jmp    0xffffffffffffff88
>   39:   0f 0b                   ud2
>   3b:   eb 8b                   jmp    0xffffffffffffffc8
>   3d:   90                      nop
>   3e:   90                      nop
>   3f:   90                      nop
>
> Code starting with the faulting instruction
> ===========================================
>    0:   0f 0b                   ud2
>    2:   39 ce                   cmp    %ecx,%esi
>    4:   0f 85 4b ff ff ff       jne    0xffffffffffffff55
>    a:   e9 4f ff ff ff          jmp    0xffffffffffffff5e
>    f:   0f 0b                   ud2
>   11:   eb 8b                   jmp    0xffffffffffffff9e
>   13:   90                      nop
>   14:   90                      nop
>   15:   90                      nop
> [    7.740468][    T1] EAX: 58e1ae7d EBX: c33977c0 ECX: c33977c0 EDX: 00000000
> [    7.741422][    T1] ESI: 00000000 EDI: c33977c0 EBP: c0293bf0 ESP: c0293be8
> [    7.742277][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010296
> [    7.743199][    T1] CR0: 80050033 CR2: ffd38000 CR3: 02b87000 CR4: 000406d0
> [    7.744043][    T1] Call Trace:
> [    7.744429][    T1]  ? blocking_notifier_chain_register (kernel/notifier.c:264)
> [    7.745251][    T1]  down_write (kernel/locking/rwsem.c:1591)
> [    7.745755][    T1]  blocking_notifier_chain_register (kernel/notifier.c:264)
> [    7.746473][    T1]  efivars_pstore_init (drivers/firmware/efi/efi-pstore.c:258 drivers/firmware/efi/efi-pstore.c:306)
> [    7.747059][    T1]  do_one_initcall (init/main.c:1283)
> [    7.747623][    T1]  ? last_attempt_status_show (drivers/firmware/efi/efi-pstore.c:299)
> [    7.748291][    T1]  ? local_clock (arch/x86/include/asm/preempt.h:95 kernel/sched/clock.c:319)
> [    7.748949][    T1]  ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91)
> [    7.749590][    T1]  ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91)
> [    7.750218][    T1]  ? sched_clock_noinstr (arch/x86/kernel/tsc.c:271)
> [    7.750828][    T1]  ? local_clock_noinstr (kernel/sched/clock.c:272 kernel/sched/clock.c:309)
> [    7.751477][    T1]  ? local_clock (arch/x86/include/asm/preempt.h:95 kernel/sched/clock.c:319)
> [    7.752042][    T1]  ? ktime_get (include/linux/seqlock.h:226)
> [    7.752565][    T1]  ? kvm_clock_get_cycles (arch/x86/include/asm/preempt.h:95 arch/x86/kernel/kvmclock.c:80 arch/x86/kernel/kvmclock.c:86)
> [    7.753268][    T1]  ? ktime_get (kernel/time/timekeeping.c:295 kernel/time/timekeeping.c:404 kernel/time/timekeeping.c:826)
> [    7.753775][    T1]  ? local_clock_noinstr (kernel/sched/clock.c:272 kernel/sched/clock.c:309)
> [    7.754393][    T1]  ? clockevents_program_event (kernel/time/clockevents.c:336)
> [    7.755098][    T1]  ? tick_program_event (kernel/time/tick-oneshot.c:44)
> [    7.755720][    T1]  ? hrtimer_interrupt (kernel/time/hrtimer.c:1916)
> [    7.756331][    T1]  ? irqentry_exit (kernel/entry/common.c:?)
> [    7.756993][    T1]  ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1052)
> [    7.757704][    T1]  ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:80)
> [    7.758306][    T1]  ? irqentry_exit (kernel/entry/common.c:?)
> [    7.758860][    T1]  ? sysvec_call_function_single (arch/x86/kernel/apic/apic.c:1052)
> [    7.759562][    T1]  ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1052)
> [    7.760261][    T1]  ? handle_exception (arch/x86/entry/entry_32.S:1048)
> [    7.760967][    T1]  ? __get_immptr (arch/x86/lib/insn.c:632)
> [    7.761517][    T1]  ? parameq (kernel/params.c:81 kernel/params.c:91 kernel/params.c:99)
> [    7.762011][    T1]  ? __get_immptr (arch/x86/lib/insn.c:632)
> [    7.762540][    T1]  ? next_arg (lib/cmdline.c:273)
> [    7.763050][    T1]  ? parameq (kernel/params.c:90 kernel/params.c:99)
> [    7.763551][    T1]  ? parse_args (kernel/params.c:153)
> [    7.764127][    T1]  do_initcall_level (init/main.c:1344)
> [    7.764819][    T1]  do_initcalls (init/main.c:1358)
> [    7.765347][    T1]  ? kernel_init (init/main.c:1485)
> [    7.765895][    T1]  do_basic_setup (init/main.c:1381)
> [    7.766432][    T1]  kernel_init_freeable (init/main.c:1597)
> [    7.767049][    T1]  ? rest_init (init/main.c:1475)
> [    7.767587][    T1]  ? rest_init (init/main.c:1475)
> [    7.768125][    T1]  kernel_init (init/main.c:1485)
> [    7.768686][    T1]  ret_from_fork (arch/x86/kernel/process.c:164)
> [    7.769276][    T1]  ? __switch_to_asm (arch/x86/entry/entry_32.S:704)
> [    7.769852][    T1]  ? __switch_to_asm (arch/x86/entry/entry_32.S:704)
> [    7.770427][    T1]  ? __switch_to_asm (arch/x86/entry/entry_32.S:704)
> [    7.771001][    T1]  ? rest_init (init/main.c:1475)
> [    7.771535][    T1]  ret_from_fork_asm (arch/x86/entry/entry_32.S:737)
> [    7.771957][    T1]  entry_INT80_32 (arch/x86/entry/entry_32.S:945)
> [    7.772338][    T1] irq event stamp: 108765
> [    7.772712][    T1] hardirqs last  enabled at (108773): __console_unlock (arch/x86/include/asm/irqflags.h:19 arch/x86/include/asm/irqflags.h:109 arch/x86/include/asm/irqflags.h:151 kernel/printk/printk.c:345 kernel/printk/printk.c:2858)
> [    7.773432][    T1] hardirqs last disabled at (108782): __console_unlock (kernel/printk/printk.c:343)
> [    7.774123][    T1] softirqs last  enabled at (108714): __do_softirq (kernel/softirq.c:657)
> [    7.774782][    T1] softirqs last disabled at (108699): __do_softirq (kernel/softirq.c:657)
> [    7.775441][    T1] ---[ end trace 0000000000000000 ]---
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20251210/202512101632.a94de49b-lkp@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

