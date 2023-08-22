Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD7C7837BC
	for <lists+linux-efi@lfdr.de>; Tue, 22 Aug 2023 04:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjHVCBt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 21 Aug 2023 22:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjHVCBs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 21 Aug 2023 22:01:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E01A13E
        for <linux-efi@vger.kernel.org>; Mon, 21 Aug 2023 19:01:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9214F64676
        for <linux-efi@vger.kernel.org>; Tue, 22 Aug 2023 02:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325D0C433C8;
        Tue, 22 Aug 2023 02:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692669701;
        bh=er4mScGQ382NWEi5nga9I08LX3ItSXn2c2yauqpxuEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VEq/FtH2i5ufTPPQyAXv2CpEUxEQwWcGw1e+B/cNc9844lO+Ehp6T1Q/98cS4MB8j
         k4kdx6S6wNcbIygo+Xqj5hDot7LV+SLLeDMeXDdm+5JBsmqVDu13Zw4dgW21fgUuVz
         x5uCV62U9r4/yYFhX76ghDderwShWa3C8A52XAjpoUKnoMmhvUn6qtKr3sYNKkYmnH
         LolfnZtGqEP8kSZwZ9Wi8lrPZvUpeLHlIvccUypPS2KDfGzapCY7KJRD+C5hdmhXJV
         rxXYYIjeyzagOHrEBb95DP2kFmy/uAm21GQLnZGk6lL6swnPGnL5xBAT3Jw1PPHILD
         MIM0i/+uhKJ8Q==
Date:   Mon, 21 Aug 2023 19:01:38 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 00/11] efi: Clean up runtime wrapper and wire it up
 for PRM
Message-ID: <20230822020138.GA2027761@dev-arch.thelio-3990X>
References: <20230818113724.368492-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818113724.368492-1-ardb@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Fri, Aug 18, 2023 at 01:37:13PM +0200, Ard Biesheuvel wrote:

<snip>

> Ard Biesheuvel (11):
>   efi/x86: Move EFI runtime call setup/teardown helpers out of line
>   efi/arm64: Move EFI runtime call setup/teardown helpers out of line
>   efi/riscv: Move EFI runtime call setup/teardown helpers out of line
>   efi/runtime-wrappers: Use type safe encapsulation of call arguments
>   efi/runtime-wrapper: Move workqueue manipulation out of line
>   efi/runtime-wrappers: Remove duplicated macro for service returning
>     void
>   efi/runtime-wrappers: Don't duplicate setup/teardown code
>   acpi/prmt: Use EFI runtime sandbox to invoke PRM handlers
>   efi/runtime-wrappers: Clean up white space and add __init annotation
>   efi/x86: Realign EFI runtime stack
>   efi/x86: Rely on compiler to emit MS ABI calls

I took this series for a spin on my arm64 and x86_64 systems that boot
under EFI. I noticed two issues for x86_64, none for arm64. I was hoping
to have a little more information by this point but I had some personal
stuff to deal with today but I figured I would report this initially
and if you want to continue on the ClangBuiltLinux issue tracker, we
certainly can.

1. I see some kCFI failures with this series on x86_64. The fact that
the target is not a symbol makes me think that a function defined in a
.S file is being called indirectly? The following stacktrace is repeated
over and over on all my machines.

  [ 3520.654794] CFI failure at efi_call_rts+0x314/0x3f0 (target: 0xfffffffeee9db7a4; expected type: 0x747b9986)
  [ 3520.654797] WARNING: CPU: 5 PID: 1870 at efi_call_rts+0x314/0x3f0
  [ 3520.654798] Modules linked in: ...
  [ 3520.654828] CPU: 5 PID: 1870 Comm: kworker/u32:0 Tainted: P                   6.5.0-rc6-next-20230818-debug-11225-g78f833901b02 #1 ab5bcd9a29b4227ebb5977a738a805cb7c6c7fff
  [ 3520.654829] Hardware name: ASUS System Product Name/PRIME Z590M-PLUS, BIOS 1203 10/27/2021
  [ 3520.654829] Workqueue: efi_rts_wq efi_call_rts
  [ 3520.654830] RIP: 0010:efi_call_rts+0x314/0x3f0
  [ 3520.654831] Code: 4e 01 4c 8b 58 48 49 8b 0e 49 8b 56 08 4d 8b 46 10 4d 8b 4e 18 49 8b 46 20 48 89 44 24 20 41 ba 7a 66 84 8b 45 03 53 f1 74 02 <0f> 0b 41 ff d3 0f 1f 00 eb 78 0f b6 3d 13 c3 d5 00 e8 36 6f 54 ff
  [ 3520.654832] RSP: 0018:ffffc90004e37e00 EFLAGS: 00010296
  [ 3520.654832] RAX: ffff88814a618004 RBX: 0000000000000206 RCX: ffff8881017da000
  [ 3520.654833] RDX: ffff8881017da400 RSI: ffffffff94d865c0 RDI: 0000000000000000
  [ 3520.654833] RBP: ffffc90004e37e48 R08: ffffc90004eafe04 R09: ffffc90004eafe08
  [ 3520.654834] R10: 000000008b846759 R11: fffffffeee9db7a4 R12: ffffffff95679990
  [ 3520.654834] R13: ffff888100059000 R14: ffffc90004eafd70 R15: ffff8881024c7800
  [ 3520.654835] FS:  0000000000000000(0000) GS:ffff88883f540000(0000) knlGS:0000000000000000
  [ 3520.654835] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [ 3520.654836] CR2: 00007f3f5814e008 CR3: 000000010020c001 CR4: 0000000000770ee0
  [ 3520.654836] PKRU: 55555554
  [ 3520.654837] Call Trace:
  [ 3520.654837]  <TASK>
  [ 3520.654837]  ? __warn+0xc8/0x1c0
  [ 3520.654838]  ? efi_call_rts+0x314/0x3f0
  [ 3520.654839]  ? report_cfi_failure+0x4e/0x60
  [ 3520.654841]  ? handle_cfi_failure+0x14c/0x1e0
  [ 3520.654842]  ? handle_bug+0x4f/0x90
  [ 3520.654843]  ? exc_invalid_op+0x1a/0x60
  [ 3520.654844]  ? asm_exc_invalid_op+0x1a/0x20
  [ 3520.654845]  ? efi_call_rts+0x314/0x3f0
  [ 3520.654847]  process_scheduled_works+0x25f/0x470
  [ 3520.654848]  worker_thread+0x21c/0x2e0
  [ 3520.654849]  ? __cfi_worker_thread+0x10/0x10
  [ 3520.654851]  kthread+0xf6/0x110
  [ 3520.654852]  ? __cfi_kthread+0x10/0x10
  [ 3520.654853]  ret_from_fork+0x45/0x60
  [ 3520.654854]  ? __cfi_kthread+0x10/0x10
  [ 3520.654856]  ret_from_fork_asm+0x1b/0x30
  [ 3520.654858]  </TASK>
  [ 3520.654858] ---[ end trace 0000000000000000 ]---

2. I see a link failure when building with LTO, presumably due to the
final two patches of the series. I see it with my distribution's
configuration [1] and allmodconfig with CONFIG_LTO_CLANG_THIN=y, I did
not try full LTO. Unfortunately, the message does not seem to make it
obvious what is going on here, I will try to debug this more unless you
beat me to it.

  ld.lld: error: Function Import: link error: linking module flags 'override-stack-alignment': IDs have conflicting values in 'vmlinux.a(efi.o at 1059858)' and 'vmlinux.a(efi_64.o at 1059918)'
  ld.lld: error: Function Import: link error: linking module flags 'override-stack-alignment': IDs have conflicting values in 'vmlinux.a(efi_64.o at 1059918)' and 'vmlinux.a(efi.o at 1059858)'
  ld.lld: error: Function Import: link error: linking module flags 'override-stack-alignment': IDs have conflicting values in 'vmlinux.a(runtime-wrappers.o at 1181838)' and 'vmlinux.a(quirks.o at 1059798)'
  ld.lld: error: Function Import: link error: linking module flags 'override-stack-alignment': IDs have conflicting values in 'vmlinux.a(efi.o at 1181178)' and 'vmlinux.a(runtime-wrappers.o at 1181838)'
  ld.lld: error: Function Import: link error: linking module flags 'override-stack-alignment': IDs have conflicting values in 'vmlinux.a(efi_64.o at 1059918)' and 'vmlinux.a(setup.o at 1048218)'

[1]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/raw/main/config

Cheers,
Nathan
