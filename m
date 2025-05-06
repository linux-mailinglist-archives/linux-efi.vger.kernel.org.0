Return-Path: <linux-efi+bounces-3613-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E01EAABF63
	for <lists+linux-efi@lfdr.de>; Tue,  6 May 2025 11:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1131897E28
	for <lists+linux-efi@lfdr.de>; Tue,  6 May 2025 09:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3C4266560;
	Tue,  6 May 2025 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZL3/HZ/u"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED26C218ADD;
	Tue,  6 May 2025 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746523522; cv=none; b=G89UuEHYEthqveg2SNA4JehLP1uzrpc3k3iHfGa16OOZMQkfrAgybNjfwXMmSmebkh6GKDsv3a6+bQV1PyhvnAannl/JI60JmkzxnNb46KjrThX0Jh1D+paNgZoW3R3X7hcuAXNawFX9y1xV7e/vqvQjFypK1Jo826284n4mK54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746523522; c=relaxed/simple;
	bh=HGlsEjNvNx96nLSJWxi185X1lP+El2NHmoMGECrTJrA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KBqjJDI9Lky57uLSy7Dt2+dU19Ic8ESzzJGLTTkGC7YMgGlOO0m6xB38H7bVFvaaUztPT5PTtByyVK/trw7qUa/iC8o5JhVnvtb9MMXGs5lSD1MPk2bmcoUf4CYSdBWEaYjdQ1FXIbxMgG4n8efQQjClY3yubkDGOPrSNvkYYsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZL3/HZ/u; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7FC0540E023E;
	Tue,  6 May 2025 09:25:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id B2iVo4jYKFKq; Tue,  6 May 2025 09:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746523510; bh=D3fGVlVgH0xkdZKa6VajFiIuLJ0/AqK9f80Lw0fWGBo=;
	h=Date:From:To:Cc:Subject:From;
	b=ZL3/HZ/uL28Iq3qoqE5Hi4fZNoFzkJGL6DgVZVMllb3JPSZGaQPXLdHTFEHIGcw3+
	 yEEy92QrLU6B1Db2j0XCuxKhAQo/K+vm1xBQhey/c5Yr4N2igFNNZvwFbJbpZMW0Cm
	 uwMOdojFfZ/GJ/EwsQKWO5x+2UAB6rK5U3wof1lPhWD1Zr6lbp2c4nEpiiDOEWoQIP
	 GW2ET4vmOhG6Z55nwIWJkmWZqnqSNSHxfhbEvOzYZ9350BT9k290OK2oSUVxRVNeQ7
	 +I2dWMwGTNngQShw6Kd3W7HfTD3e2FeZUkn8NOjH23ma7HypGC5ouoP6Pkc/GCryUY
	 hXeu4UZ0DLXnU4R4SgXMdPCiTe6nP8whjlCPz3Wf2RnoiPMTWJliow6e/SAcZqP2io
	 5Jvg7mkHJhELH8J0aaJfC/Kj7W2HVBv8A8E7kL9IMCH9XoxW/BgQBCmkD8ZYD9VM97
	 PREqildUTLTgbIRBCRoLY/8wHBvQz7tglM1DdJhsUqS5cksc31CdKYMWtEPytQiayv
	 2Vdlooah9BeGfY6kS6rngPadrd1c+7h47+A2UIQynrGq1FF3rHYzE1hK1xobK27QVq
	 t6XUsyaLA9haZ/woj7fjOsuATmDV6KrIBAMKayHvrDW1tYxP6Wuef1XkwtGHPygT46
	 oVaB76hdoUYC5MQRaQBEQODo=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A459340E0173;
	Tue,  6 May 2025 09:24:52 +0000 (UTC)
Date: Tue, 6 May 2025 11:24:45 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill@shutemov.name>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Len Brown <len.brown@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, linux-efi@vger.kernel.org,
	x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: 4067196a5227 ("mm/page_alloc: fix deadlock on cpu_hotplug_lock in
 __accept_page()") (was: Re: [tip: x86/boot] x86/boot: Provide
 __pti_set_user_pgtbl() to startup code)
Message-ID: <20250506092445.GBaBnVXXyvnazly6iF@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Yah,

leaving the rest below untouched for background info how we ended up here.

So tglx and I did some tracing just now:

...
[    1.156432] smpboot: x86: Booting SMP configuration:
[    1.157267] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23 #24 #25 #26 #27 #28 #29 #30 #31
[    1.274198] smp: Brought up 1 node, 32 CPUs
[    1.277842] smpboot: Total of 32 processors activated (191999.87 BogoMIPS)
[    1.289879] ------------[ cut here ]------------
[    1.290682] v: -1

The key is -1 and the code *actually* already says what happens:

                /*
                 * Warn about the '-1' case though; since that means a
                 * decrement is concurrent with a first (0->1) increment. IOW
                 * people are trying to disable something that wasn't yet fully
                 * enabled. This suggests an ordering problem on the user side.
                 */

Keep on reading...

[    1.290688] WARNING: CPU: 0 PID: 10 at kernel/jump_label.c:276 __static_key_slow_dec_cpuslocked+0x8e/0xa0
[    1.293850] Modules linked in:
[    1.294428] CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted 6.15.0-rc5+ #8 PREEMPT(voluntary) 
[    1.296050] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
[    1.297841] Workqueue: events unaccepted_cleanup_work
[    1.298766] RIP: 0010:__static_key_slow_dec_cpuslocked+0x8e/0xa0
[    1.299866] Code: 48 c7 c7 a0 52 54 82 5b e9 8f 42 8c 00 0f 0b 5b e9 f7 ba 8c 00 89 c6 48 c7 c7 19 63 2e 82 c6 05 8c 19 19 01 01 e8 22 54 e5 ff <0f> 0b eb a1 0f 0b eb b9 0f 0b eb b5 66 0f 1f 44 00 00 90 90 90 90
[    1.301840] RSP: 0018:ffffc90000067e30 EFLAGS: 00010282
[    1.302787] RAX: 0000000000000000 RBX: ffffffff82f12d00 RCX: 0000000000000000
[    1.305838] RDX: 0000000000000002 RSI: ffffc90000067cc8 RDI: 00000000ffffffff
[    1.307144] RBP: ffff88827b7d4d98 R08: 00000000fff7ffff R09: ffff88827e3fdfa8
[    1.308449] R10: ffff88827b8035f0 R11: 0000000000000001 R12: ffff888272e2e740
[    1.309838] R13: ffff8881008e1940 R14: ffff888100308a05 R15: ffff888100308a00
[    1.311144] FS:  0000000000000000(0000) GS:ffff8882effbe000(0000) knlGS:0000000000000000
[    1.312613] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.313838] CR2: ffff88827fe00000 CR3: 0008000002c22000 CR4: 00000000003506f0
[    1.315146] Call Trace:
[    1.315608]  <TASK>
[    1.316012]  static_key_slow_dec+0x1f/0x40
[    1.316792]  ? unaccepted_cleanup_work+0x1a/0x50
[    1.317691]  unaccepted_cleanup_work+0x2e/0x50
[    1.317839]  process_one_work+0x171/0x330
[    1.318587]  worker_thread+0x247/0x390
[    1.319282]  ? _raw_spin_lock_irqsave+0x23/0x50
[    1.320136]  ? srso_return_thunk+0x5/0x5f
[    1.320924]  ? __pfx_worker_thread+0x10/0x10
[    1.321838]  kthread+0x107/0x240
[    1.322514]  ? __pfx_kthread+0x10/0x10
[    1.323212]  ? __pfx_kthread+0x10/0x10
[    1.322040] node 0 deferred pages initialised in 40ms
[    1.323867]  ret_from_fork+0x87/0xf0
[    1.323872]  ? __pfx_kthread+0x10/0x10
[    1.326505]  ret_from_fork_asm+0x1a/0x30
[    1.327211]  </TASK>
[    1.327613] Kernel panic - not syncing: kernel: panic_on_warn set ...
[    1.328772] CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted 6.15.0-rc5+ #8 PREEMPT(voluntary) 
[    1.329836] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
[    1.329836] Workqueue: events unaccepted_cleanup_work
[    1.329836] Call Trace:
[    1.329836]  <TASK>
[    1.329836]  dump_stack_lvl+0x56/0x80
[    1.329836]  panic+0x106/0x2c9
[    1.329836]  ? __static_key_slow_dec_cpuslocked+0x8e/0xa0
[    1.329836]  check_panic_on_warn.cold+0xf/0x1e
[    1.329836]  __warn.cold+0x9f/0xf8
[    1.329836]  ? __static_key_slow_dec_cpuslocked+0x8e/0xa0
[    1.329836]  report_bug+0xe6/0x170
[    1.329836]  ? prb_read_valid+0x17/0x20
[    1.329836]  ? __static_key_slow_dec_cpuslocked+0x8e/0xa0
[    1.329836]  handle_bug+0x199/0x260
[    1.329836]  exc_invalid_op+0x13/0x60
[    1.329836]  asm_exc_invalid_op+0x16/0x20
[    1.329836] RIP: 0010:__static_key_slow_dec_cpuslocked+0x8e/0xa0
[    1.329836] Code: 48 c7 c7 a0 52 54 82 5b e9 8f 42 8c 00 0f 0b 5b e9 f7 ba 8c 00 89 c6 48 c7 c7 19 63 2e 82 c6 05 8c 19 19 01 01 e8 22 54 e5 ff <0f> 0b eb a1 0f 0b eb b9 0f 0b eb b5 66 0f 1f 44 00 00 90 90 90 90
[    1.329836] RSP: 0018:ffffc90000067e30 EFLAGS: 00010282
[    1.329836] RAX: 0000000000000000 RBX: ffffffff82f12d00 RCX: 0000000000000000
[    1.329836] RDX: 0000000000000002 RSI: ffffc90000067cc8 RDI: 00000000ffffffff
[    1.329836] RBP: ffff88827b7d4d98 R08: 00000000fff7ffff R09: ffff88827e3fdfa8
[    1.329836] R10: ffff88827b8035f0 R11: 0000000000000001 R12: ffff888272e2e740
[    1.329836] R13: ffff8881008e1940 R14: ffff888100308a05 R15: ffff888100308a00
[    1.329836]  static_key_slow_dec+0x1f/0x40
[    1.329836]  ? unaccepted_cleanup_work+0x1a/0x50
[    1.329836]  unaccepted_cleanup_work+0x2e/0x50
[    1.329836]  process_one_work+0x171/0x330
[    1.329836]  worker_thread+0x247/0x390
[    1.329836]  ? _raw_spin_lock_irqsave+0x23/0x50
[    1.329836]  ? srso_return_thunk+0x5/0x5f
[    1.329836]  ? __pfx_worker_thread+0x10/0x10
[    1.329836]  kthread+0x107/0x240
[    1.329836]  ? __pfx_kthread+0x10/0x10
[    1.329836]  ? __pfx_kthread+0x10/0x10
[    1.329836]  ret_from_fork+0x87/0xf0
[    1.329836]  ? __pfx_kthread+0x10/0x10
[    1.329836]  ret_from_fork_asm+0x1a/0x30
[    1.329836]  </TASK>
[    1.329836] Dumping ftrace buffer:
[    1.329836] ---------------------------------
[    1.329836] pgdatini-180      29..... 1546876us : __free_pages_core: will INC: increment branch key, key: 0

CPU29 comes in and decides to INC the key.

[    1.329836] pgdatini-180      29..... 1546896us : <stack trace>
[    1.329836]  => padata_mt_helper
[    1.329836]  => padata_do_multithreaded
[    1.329836]  => deferred_init_memmap
[    1.329836]  => kthread
[    1.329836]  => ret_from_fork
[    1.329836]  => ret_from_fork_asm
[    1.329836] kthreadd-2         0.N... 1552367us : __accept_page: schedule unaccepted_cleanup_work()
[    1.329836] kthreadd-2         0.N... 1552385us : <stack trace>

CPU0 gets in-between and schedules work...

[    1.329836]  => alloc_pages_bulk_noprof
[    1.329836]  => __vmalloc_node_range_noprof
[    1.329836]  => __vmalloc_node_noprof
[    1.329836]  => copy_process
[    1.329836]  => kernel_clone
[    1.329836]  => kernel_thread
[    1.329836]  => kthreadd
[    1.329836]  => ret_from_fork
[    1.329836]  => ret_from_fork_asm
[    1.329836] kworker/-10        0..... 1552395us : unaccepted_cleanup_work: will DEC: unaccepted_cleanup_work(), key: -1

... and wants to decrement *while* the increment is in progress. Without
holding the jump label mutex.

Pooof.

[    1.329836] kworker/-10        0..... 1552398us : <stack trace>
[    1.329836]  => kthread
[    1.329836]  => ret_from_fork
[    1.329836]  => ret_from_fork_asm
[    1.329836] pgdatini-180      29.N... 1553206us : __free_pages_core: done INC: increment branch key, key: 1

CPU29 gets to increment the key finally.

[    1.329836] pgdatini-180      29.N... 1553213us : <stack trace>
[    1.329836]  => padata_do_multithreaded
[    1.329836]  => deferred_init_memmap
[    1.329836]  => kthread
[    1.329836]  => ret_from_fork
[    1.329836]  => ret_from_fork_asm
[    1.329836] pgdatini-180      29..... 1553227us : __free_pages_core: will INC: increment branch key, key: 1
[    1.329836] pgdatini-180      29..... 1553232us : <stack trace>
[    1.329836]  => padata_mt_helper
[    1.329836]  => padata_do_multithreaded
[    1.329836]  => deferred_init_memmap
[    1.329836]  => kthread
[    1.329836]  => ret_from_fork
[    1.329836]  => ret_from_fork_asm
[    1.329836] pgdatini-180      29..... 1553234us : __free_pages_core: done INC: increment branch key, key: 2
[    1.329836] pgdatini-180      29..... 1553238us : <stack trace>
[    1.329836]  => padata_do_multithreaded
[    1.329836]  => deferred_init_memmap
[    1.329836]  => kthread
[    1.329836]  => ret_from_fork
[    1.329836]  => ret_from_fork_asm
[    1.329836] ---------------------------------
[    1.329836] ---[ end Kernel panic - not syncing: kernel: panic_on_warn set ... ]---

Fun stuff.

On Tue, May 06, 2025 at 09:18:00AM +0200, Borislav Petkov wrote:
> + Kirill.
> 
> This looks like this unaccepted_cleanup_work() thing being unsynchronized...
> 
> On Mon, May 05, 2025 at 06:47:59PM +0200, Borislav Petkov wrote:
> > On Mon, May 05, 2025 at 06:19:49PM +0200, Ard Biesheuvel wrote:
> > > This patch by itself does nothing. The symbol is __weak for the time
> > > being, and given that this code does not have its __pi_ prefixes yet,
> > > this function will be superseded by the existing one. (If you remove
> > > the __weak you will get a linker error)
> > > 
> > > Are you sure this patch is causing the issue?
> > 
> > My by-foot bisection of x86/boot is below.
> > 
> > I don't know if this patch uncovers something or maybe changes placement...
> > 
> > Tom also pointed to
> > 
> > 4067196a5227 ("mm/page_alloc: fix deadlock on cpu_hotplug_lock in __accept_page()")
> > 
> > as potentially related.
> > 
> > And now I went and tried to reproduce the warning and it fired ontop of:
> > 
> > 419cbaf6a56a ("x86/boot: Add a bunch of PIC aliases")
> > 
> > which is the previous patch.
> > 
> > Ufff, this is one of those which don't reproduce reliably because it was fine
> > on that commit in the previous run. Nasty.
> > 
> > Lemme go dig more.
> > 
> > ---
> > 
> > ed4d95d033e3 (HEAD, refs/remotes/tip/x86/boot) x86/sev: Disentangle #VC handling code from startup code
> > 
> > <--- NOT
> > 
> > [    1.227968] smp: Brought up 1 node, 32 CPUs
> > [    1.231576] smpboot: Total of 32 processors activated (191999.61 BogoMIPS)
> > [    1.247644] ------------[ cut here ]------------
> > [    1.248697] WARNING: CPU: 17 PID: 104 at kernel/jump_label.c:276 __static_key_slow_dec_cpuslocked+0x2a/0x80
> > [    1.251592] Modules linked in:
> > [    1.252370] CPU: 17 UID: 0 PID: 104 Comm: kworker/17:0 Not tainted 6.15.0-rc4+ #2 PREEMPT(voluntary) 
> > [    1.253173] node 0 deferred pages initialised in 12ms
> > [    1.254539] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
> > [    1.257490] Workqueue: events unaccepted_cleanup_work
> > [    1.258698] RIP: 0010:__static_key_slow_dec_cpuslocked+0x2a/0x80
> > [    1.259574] Code: 0f 1f 44 00 00 53 48 89 fb e8 82 66 e5 ff 8b 03 85 c0 78 16 74 54 83 f8 01 74 11 8d 50 ff f0 0f b1 13 75 ec 5b e9 66 bf 8c 00 <0f> 0b 48 c7 c7 00 44 54 82 e8 a8 5f 8c 00 8b 03 83 f8 ff 74 33 85
> > [    1.266446] Memory: 7574396K/8381588K available (13737K kernel code, 2487K rwdata, 6056K rodata, 3916K init, 3592K bss, 791248K reserved, 0K cma-reserved)
> > [    1.263574] RSP: 0018:ffffc9000048fe40 EFLAGS: 00010286
> > [    1.267573] RAX: 00000000ffffffff RBX: ffffffff82f10d00 RCX: 0000000000000000
> > [    1.269388] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffffff82f10d00
> > [    1.275578] RBP: ffff88827b7d4d98 R08: 8080808080808080 R09: ffff888100b59100
> > [    1.277441] R10: ffff888100050cc0 R11: fefefefefefefeff R12: ffff88827326e300
> > [    1.279574] R13: ffff888100bc1940 R14: ffff8881000e2405 R15: ffff8881000e2400
> > [    1.281460] FS:  0000000000000000(0000) GS:ffff8882f0400000(0000) knlGS:0000000000000000
> > [    1.281460] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    1.281460] CR2: 0000000000000000 CR3: 0008000002c22000 CR4: 00000000003506f0
> > [    1.287576] Call Trace:
> > [    1.288381]  <TASK>
> > [    1.289015]  static_key_slow_dec+0x1f/0x40
> > [    1.289980]  process_one_work+0x171/0x330
> > [    1.290988]  worker_thread+0x247/0x390
> > [    1.291576]  ? __pfx_worker_thread+0x10/0x10
> > [    1.292773]  kthread+0x107/0x240
> > [    1.293536]  ? __pfx_kthread+0x10/0x10
> > [    1.295573]  ret_from_fork+0x30/0x50
> > [    1.295575]  ? __pfx_kthread+0x10/0x10
> > [    1.296580]  ret_from_fork_asm+0x1a/0x30
> > [    1.297507]  </TASK>
> > [    1.298085] ---[ end trace 0000000000000000 ]---
> > 
> > 5297886f0cc4 x86/boot: Provide __pti_set_user_pgtbl() to startup code
> > 
> > <--- OK
> > 
> > 419cbaf6a56a x86/boot: Add a bunch of PIC aliases
> > f932adcc8650 x86/linkage: Add SYM_PIC_ALIAS() macro helper to emit symbol aliases
> > 
> > <--- OK
> > 
> > ae862964cbc5 x86/sev: Move instruction decoder into separate source file
> > fae89bbfdd9d x86/sev: Make sev_snp_enabled() a static function
> > b3464a36f7f2 x86/boot: Disregard __supported_pte_mask in __startup_64()
> > bd4a58beaaf1 x86/boot: Move early_setup_gdt() back into head64.c
> > 
> > <--- OK
> > 
> > 
> > -- 
> > Regards/Gruss,
> >     Boris.
> > 
> > https://people.kernel.org/tglx/notes-about-netiquette
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

