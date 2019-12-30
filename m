Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3B5B12CC23
	for <lists+linux-efi@lfdr.de>; Mon, 30 Dec 2019 04:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfL3DcV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 29 Dec 2019 22:32:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25887 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727065AbfL3DcV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 29 Dec 2019 22:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577676739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ryqWC8mpD+pR4oHYEz5rVYuu+1PZIXiZX9bX+UuXzyI=;
        b=CFSQsAfuuhz8Eb26sN7Ja+HgL5DbMP1KggSWGmhIk4cx56sDwpufI+02k7QB83OueKA0nk
        msB/rsHHfNspRg1VeDq9ZPclc/BwIu3kTA71uLsuWchJ2ft/Y7G2mRAwHtdGsWO7RUlyEc
        4Rxpe6VD4T6+WmCfCY/zefsOH8lP9Ow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-MN27yAllMjSFgikbiOWLMQ-1; Sun, 29 Dec 2019 22:32:15 -0500
X-MC-Unique: MN27yAllMjSFgikbiOWLMQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D62B107ACC4;
        Mon, 30 Dec 2019 03:32:13 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-231.pek2.redhat.com [10.72.12.231])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C2B45D9E1;
        Mon, 30 Dec 2019 03:32:07 +0000 (UTC)
Date:   Mon, 30 Dec 2019 11:32:04 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dan Williams <dan.j.williams.korg@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Weiser <michael@weiser.dinsnail.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kexec@lists.infradead.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/efi: update e820 about reserved EFI boot services
 data to fix kexec breakage
Message-ID: <20191230033204.GA17257@dhcp-128-65.nay.redhat.com>
References: <20191204075233.GA10520@dhcp-128-65.nay.redhat.com>
 <CANTgghnsdijH90qnm24qat70T7FA5qOwmnXXt+NYVxHYa4SLJA@mail.gmail.com>
 <CAPcyv4iRdJO6xrCaN=vrSvYFLZanLazmJLArT5YMfdJ6rc-PEQ@mail.gmail.com>
 <20191229142453.GA18486@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191229142453.GA18486@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/29/19 at 10:24pm, Dave Young wrote:
> Hi Dan,
> On 12/28/19 at 10:13pm, Dan Williams wrote:
> > On Sat, Dec 28, 2019 at 12:54 PM Dan Williams
> > <dan.j.williams.korg@gmail.com> wrote:
> > >
> > > On Tue, Dec 3, 2019 at 11:53 PM Dave Young <dyoung@redhat.com> wrote:
> > > >
> > > > Michael Weiser reported he got below error during a kexec rebooting:
> > > > esrt: Unsupported ESRT version 2904149718861218184.
> > > >
> > > > The ESRT memory stays in EFI boot services data, and it was reserved
> > > > in kernel via efi_mem_reserve().  The initial purpose of the reservation
> > > > is to reuse the EFI boot services data across kexec reboot. For example
> > > > the BGRT image data and some ESRT memory like Michael reported.
> > > >
> > > > But although the memory is reserved it is not updated in X86 e820 table.
> > > > And kexec_file_load iterate system ram in io resource list to find places
> > > > for kernel, initramfs and other stuff. In Michael's case the kexec loaded
> > > > initramfs overwritten the ESRT memory and then the failure happened.
> > > >
> > > > Since kexec_file_load depends on the e820 to be updated, just fix this
> > > > by updating the reserved EFI boot services memory as reserved type in e820.
> > > >
> > > > Originally any memory descriptors with EFI_MEMORY_RUNTIME attribute are
> > > > bypassed in the reservation code path because they are assumed as reserved.
> > > > But the reservation is still needed for multiple kexec reboot.
> > > > And it is the only possible case we come here thus just drop the code
> > > > chunk then everything works without side effects.
> > > >
> > > > On my machine the ESRT memory sits in an EFI runtime data range, it does
> > > > not trigger the problem, but I successfully tested with BGRT instead.
> > > > both kexec_load and kexec_file_load work and kdump works as well.
> > > >
> > > > Signed-off-by: Dave Young <dyoung@redhat.com>
> > > > ---
> > > >  arch/x86/platform/efi/quirks.c |    6 ++----
> > > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > >
> > > > --- linux-x86.orig/arch/x86/platform/efi/quirks.c
> > > > +++ linux-x86/arch/x86/platform/efi/quirks.c
> > > > @@ -260,10 +260,6 @@ void __init efi_arch_mem_reserve(phys_ad
> > > >                 return;
> > > >         }
> > > >
> > > > -       /* No need to reserve regions that will never be freed. */
> > > > -       if (md.attribute & EFI_MEMORY_RUNTIME)
> > > > -               return;
> > > > -
> > > >         size += addr % EFI_PAGE_SIZE;
> > > >         size = round_up(size, EFI_PAGE_SIZE);
> > > >         addr = round_down(addr, EFI_PAGE_SIZE);
> > > > @@ -293,6 +289,8 @@ void __init efi_arch_mem_reserve(phys_ad
> > > >         early_memunmap(new, new_size);
> > > >
> > > >         efi_memmap_install(new_phys, num_entries);
> > > > +       e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > > > +       e820__update_table(e820_table);
> > > >  }
> > > >
> > > >  /*
> > > >
> > >
> > > Bisect says this change (commit af1648984828) is triggering a
> > > regression, likely not urgent, in my testing of the new efi_fake_mem=
> > > facility to allow memory to be marked "soft reserved" via the kernel
> > > command line (commit 199c84717612 x86/efi: Add efi_fake_mem support
> > > for EFI_MEMORY_SP). The following command line triggers the crash
> > > signature below:
> > >
> > >     efi_fake_mem=4G@9G:0x40000,4G@13G:0x40000
> > >
> > > However, this command line works ok:
> > >
> > >     efi_fake_mem=8G@9G:0x40000
> > >
> > > So, something about multiple efi_fake_mem statements interacts badly
> > > with this change. Nothing obvious occurs to me at the moment, I'll
> > > keep debugging, but wanted to highlight this in the meantime in case
> > > someone else sees a deeper issue or the root cause.
> > 
> > Still looking, but this failure does not seem to be specific to the
> > "soft reservation" changes. Any update to the efi memmap that pushes
> > it over a page boundary triggers this failure. I.e. I can fix the
> > problem by over-allocating the efi memmap and then page aligning the
> > result. __early_ioremap "should" be handling this case, but it appears
> > something else is messing this up.
> 
> I seems can not reproduce the bug, but maybe my vm setup is different.
> Can you do some debugging about the efi_memmap_insert function see if
> something wrong happened, maybe happens when memcpy to some new allocated buffer via
> memblock_alloc, just some guess.

I reproduced some other panics with or without my fix about the efi boot
mem,  but not 100% reproducible although high likely.  I'm using params
below:
efi_fake_mem=200M@5G:0x40000,300M@5600M:0x40000

I suspect efi_fake_mem needs more careful sanity checks about the memory
user provided, but I'm not very familiar with the details though..

The issues I notices are two different ones:

First one is a panic during booting:
[    0.210239] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.215983] BUG: kernel NULL pointer dereference, address: 0000000000000008
[    0.216835] #PF: supervisor write access in kernel mode
[    0.217384] #PF: error_code(0x0002) - not-present page
[    0.217976] PGD 0 P4D 0 
[    0.218248] Oops: 0002 [#1] SMP PTI
[    0.218668] CPU: 0 PID: 0 Comm: swapper Not tainted 5.5.0-rc3+ #3
[    0.219315] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[    0.220191] RIP: 0010:__free_pages_ok+0x2de/0x5c0
[    0.220690] Code: 00 00 4b 8d 04 a4 48 c1 e5 04 48 c1 e0 08 48 89 c1 48 01 c5 4b 8d 04 c0 48 c1 e0 03 48 01 c5 48 01 c8 49 8b b4 2e c0 00 00 00 <48> 89 7e 08 48 89 73 08 48 89 53 10 48 89 3a 49 83 84 06 00 01 00
[    0.222843] RSP: 0000:ffffffff97e03e60 EFLAGS: 00010002
[    0.223400] RAX: 00000000000007d0 RBX: ffffda4d00050000 RCX: 0000000000000500
[    0.224200] RDX: ffffa2a9bd3fe900 RSI: 0000000000000000 RDI: ffffda4d00050008
[    0.224984] RBP: 0000000000000840 R08: 000000000000000a R09: 0000000000000400
[    0.225825] R10: dead000000000100 R11: 0000000000000039 R12: 0000000000000001
[    0.226793] R13: ffffa2a9bd3fe500 R14: ffffa2a9bd3fe000 R15: 000000000000000a
[    0.227764] FS:  0000000000000000(0000) GS:ffffa2a9b7600000(0000) knlGS:0000000000000000
[    0.228799] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.229511] CR2: 0000000000000008 CR3: 00000001cf80a001 CR4: 00000000000606b0
[    0.230323] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.231399] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.232219] Call Trace:
[    0.232524]  memblock_free_all+0x127/0x195
[    0.233090]  mem_init+0x15/0x9d
[    0.233450]  start_kernel+0x215/0x4e0
[    0.233875]  ? load_ucode_bsp+0x3e/0x11b
[    0.234325]  secondary_startup_64+0xa4/0xb0
[    0.234833] Modules linked in:
[    0.235197] CR2: 0000000000000008
[    0.235610] random: get_random_bytes called from print_oops_end_marker+0x26/0x40 with crng_init=0
[    0.237389] ---[ end trace 58f36740c65a5535 ]---
[    0.238111] RIP: 0010:__free_pages_ok+0x2de/0x5c0
[    0.238747] Code: 00 00 4b 8d 04 a4 48 c1 e5 04 48 c1 e0 08 48 89 c1 48 01 c5 4b 8d 04 c0 48 c1 e0 03 48 01 c5 48 01 c8 49 8b b4 2e c0 00 00 00 <48> 89 7e 08 48 89 73 08 48 89 53 10 48 89 3a 49 83 84 06 00 01 00
[    0.241001] RSP: 0000:ffffffff97e03e60 EFLAGS: 00010002
[    0.241618] RAX: 00000000000007d0 RBX: ffffda4d00050000 RCX: 0000000000000500
[    0.242461] RDX: ffffa2a9bd3fe900 RSI: 0000000000000000 RDI: ffffda4d00050008
[    0.243308] RBP: 0000000000000840 R08: 000000000000000a R09: 0000000000000400
[    0.244161] R10: dead000000000100 R11: 0000000000000039 R12: 0000000000000001
[    0.245093] R13: ffffa2a9bd3fe500 R14: ffffa2a9bd3fe000 R15: 000000000000000a
[    0.245995] FS:  0000000000000000(0000) GS:ffffa2a9b7600000(0000) knlGS:0000000000000000
[    0.246972] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.247863] CR2: 0000000000000008 CR3: 00000001cf80a001 CR4: 00000000000606b0
[    0.248950] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.249978] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.250976] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.251915] Rebooting in 10 seconds..

The second one is when reading some files after login, eg. cat
/proc/iomem:

[   51.732899] BUG: unable to handle page fault for address: 000000007cfa9028
[   51.736351] #PF: supervisor read access in kernel mode
[   51.737549] #PF: error_code(0x0000) - not-present page
[   51.738645] PGD 0 P4D 0 
[   51.738929] Oops: 0000 [#1] SMP PTI
[   51.739290] CPU: 1 PID: 467 Comm: cat Not tainted 5.5.0-rc3+ #3
[   51.740040] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[   51.741084] RIP: 0010:r_show+0x33/0xc0
[   51.741591] Code: fd 41 54 55 53 48 8b 47 70 48 89 f3 48 8b 78 20 e8 c2 1f 1d 00 48 89 da 48 81 78 08 00 00 01 00 19 ed 31 c9 83 e5 fc 83 c5 08 <48> 8b 52 28 48 39 c2 74 73 83 c1 01 83 f9 05 75 ef 41 bc 0a 00 00
[   51.743884] RSP: 0018:ffff9a983145be30 EFLAGS: 00010202
[   51.744538] RAX: ffffffff94632c00 RBX: 000000007cfa9000 RCX: 0000000000000000
[   51.745359] RDX: 000000007cfa9000 RSI: 000000007cfa9000 RDI: ffff9a9828138048
[   51.746363] RBP: 0000000000000008 R08: 0000000000000039 R09: 0000000000000005
[   51.750059] R10: ffff9a9834cde000 R11: ffff9a9934cdd032 R12: ffff9a9834c95700
[   51.750917] R13: ffff9a982d25f800 R14: ffff9a982d25f828 R15: ffff9a982d25f840
[   51.751759] FS:  00007ff33164f580(0000) GS:ffff9a9837680000(0000) knlGS:0000000000000000
[   51.752678] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   51.753336] CR2: 000000007cfa9028 CR3: 00000001f3eae001 CR4: 0000000000160ee0
[   51.754172] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   51.755076] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   51.756199] Call Trace:
[   51.756653]  seq_read+0x2f7/0x410
[   51.757284]  proc_reg_read+0x3c/0x60
[   51.757752]  vfs_read+0x9d/0x120
[   51.758247]  ksys_read+0x5f/0xe0
[   51.758871]  do_syscall_64+0x6b/0x260
[   51.759345]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   51.759976] RIP: 0033:0x7ff331577232
[   51.760419] Code: c0 e9 c2 fe ff ff 50 48 8d 3d 0a 16 0a 00 e8 05 f1 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
[   51.763124] RSP: 002b:00007ffdaae3e8b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   51.764430] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007ff331577232
[   51.765690] RDX: 0000000000020000 RSI: 00007ff32447e000 RDI: 0000000000000003
[   51.766937] RBP: 00007ff32447e000 R08: 00007ff32447d010 R09: 0000000000000000
[   51.769215] R10: 0000000000000022 R11: 0000000000000246 R12: 00005632bd03d1f0
[   51.770531] R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000020000
[   51.771816] Modules linked in:
[   51.772637] CR2: 000000007cfa9028
[   51.773462] ---[ end trace 0eb61054f7dfd62d ]---
[   52.021257] RIP: 0010:r_show+0x33/0xc0
[   52.022625] Code: fd 41 54 55 53 48 8b 47 70 48 89 f3 48 8b 78 20 e8 c2 1f 1d 00 48 89 da 48 81 78 08 00 00 01 00 19 ed 31 c9 83 e5 fc 83 c5 08 <48> 8b 52 28 48 39 c2 74 73 83 c1 01 83 f9 05 75 ef 41 bc 0a 00 00
[   52.025914] RSP: 0018:ffff9a983145be30 EFLAGS: 00010202
[   52.027027] RAX: ffffffff94632c00 RBX: 000000007cfa9000 RCX: 0000000000000000
[   52.028429] RDX: 000000007cfa9000 RSI: 000000007cfa9000 RDI: ffff9a9828138048
[   52.029986] RBP: 0000000000000008 R08: 0000000000000039 R09: 0000000000000005
[   52.031495] R10: ffff9a9834cde000 R11: ffff9a9934cdd032 R12: ffff9a9834c95700
[   52.033053] R13: ffff9a982d25f800 R14: ffff9a982d25f828 R15: ffff9a982d25f840
[   52.035086] FS:  00007ff33164f580(0000) GS:ffff9a9837680000(0000) knlGS:0000000000000000
[   52.036945] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   52.039737] CR2: 000000007cfa9028 CR3: 00000001f3eae001 CR4: 0000000000160ee0
[   52.041116] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   52.042322] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Thanks
Dave

