Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D74711A30C1
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 10:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgDIITe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 04:19:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgDIITe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Apr 2020 04:19:34 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5E7D206F5;
        Thu,  9 Apr 2020 08:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586420373;
        bh=W/nixM4Oi/VzLBVtTFDmUh394dSfQ8nzuUewfPJ+Vxg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u/2lFNtOcX6OMxFuWpdDUKnk5wGSi7l9l8TJq/RNU7ut6gHeiryipE7e2YO21Va3j
         OS059n/fdTPV+YgmTXg0YCjDbDAk1o0dY7Y7oUlGF1/FT0nLfvZlVbLkZJ26SBDwdn
         WeVS2LjqQZxveiUu9uz2NiRv0rebEmmPzbgwVm1E=
Received: by mail-io1-f50.google.com with SMTP id f3so3020301ioj.1;
        Thu, 09 Apr 2020 01:19:33 -0700 (PDT)
X-Gm-Message-State: AGi0PubcwfMRu3dyQTugUAykS97KIdQhNrX75VBrW3uDd0nsaNmmC++r
        TcSdKoQzXDrLae+opXQ1NcNWjynSwL2RxkLNuWM=
X-Google-Smtp-Source: APiQypJ8sS5bP8UnFCC5IOTIE/mcXrrclkovcihKSJMmmXBhGgZaVJIahO+oMpxhKurh8GQ2C6WvD6l+YFBUqa/FaxU=
X-Received: by 2002:a6b:f413:: with SMTP id i19mr10971407iog.203.1586420373143;
 Thu, 09 Apr 2020 01:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200113172245.27925-1-ardb@kernel.org> <20200113172245.27925-6-ardb@kernel.org>
 <63b125a4-6c62-fcdf-de22-d3bebe2dcbf5@suse.cz> <CAMj1kXGiT_zYjc6X-msRXVozhpDAY0UesEW3_4fOgiH4FyMgDw@mail.gmail.com>
 <972b66a9-92c7-9a15-1aa1-e3236abe90df@suse.cz> <CAMj1kXFGkOM9fbqr44_TbdxqFjH1i3d8dkO64C1mQmH=AqrUSQ@mail.gmail.com>
 <20200409080626.GV5951@GaryWorkstation> <984a2b3c-a9d4-e733-6372-4abf0f99be1f@suse.cz>
In-Reply-To: <984a2b3c-a9d4-e733-6372-4abf0f99be1f@suse.cz>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 9 Apr 2020 10:19:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFHUusU9dDgqhU_qswDVgYWx_kpaDEroj4ZSt3hr-AFsA@mail.gmail.com>
Message-ID: <CAMj1kXFHUusU9dDgqhU_qswDVgYWx_kpaDEroj4ZSt3hr-AFsA@mail.gmail.com>
Subject: Re: [PATCH 05/13] efi/x86: don't map the entire kernel text RW for
 mixed mode
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Gary Lin <glin@suse.com>, linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Young <dyoung@redhat.com>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 9 Apr 2020 at 10:10, Jiri Slaby <jslaby@suse.cz> wrote:
>
> On 09. 04. 20, 10:06, Gary Lin wrote:
> > On Thu, Apr 09, 2020 at 09:51:20AM +0200, Ard Biesheuvel wrote:
> >> On Wed, 8 Apr 2020 at 12:51, Jiri Slaby <jslaby@suse.cz> wrote:
> >>>
> >>> Ccing Gary.
> >>>
> >>> On 08. 04. 20, 12:47, Ard Biesheuvel wrote:
> >>>> On Wed, 8 Apr 2020 at 12:42, Jiri Slaby <jslaby@suse.cz> wrote:
> >>>>>
> >>>>> On 13. 01. 20, 18:22, Ard Biesheuvel wrote:
> >>>>>> The mixed mode thunking routine requires a part of it to be
> >>>>>> mapped 1:1, and for this reason, we currently map the entire
> >>>>>> kernel .text read/write in the EFI page tables, which is bad.
> >>>>>>
> >>>>>> In fact, the kernel_map_pages_in_pgd() invocation that installs
> >>>>>> this mapping is entirely redundant, since all of DRAM is already
> >>>>>> 1:1 mapped read/write in the EFI page tables when we reach this
> >>>>>> point, which means that .rodata is mapped read-write as well.
> >>>>>>
> >>>>>> So let's remap both .text and .rodata read-only in the EFI
> >>>>>> page tables.
> >>>>>
> >>>>> This patch causes unhandled page faults in mixed mode:
> >>>>>
> >>>>>> BUG: unable to handle page fault for address: 000000001557ee88
> >>>>>> #PF: supervisor write access in kernel mode
> >>>>>> #PF: error_code(0x0003) - permissions violation
> >>>>>> PGD fd52063 P4D fd52063 PUD fd53063 PMD 154000e1
> >>>>>> Oops: 0003 [#1] SMP PTI
> >>>>>> CPU: 1 PID: 191 Comm: systemd-escape Not tainted
> >>>>> 5.6.2-20.gb22bc26-default #1 openSUSE Tumbleweed (unreleased)
> >>>>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0
> >>>>> 02/06/2015
> >>>>>> RIP: 0008:0x3d2eed95
> >>>>>> Code: 8b 45 d4 8b 4d 10 8b 40 04 89 01 89 3b 50 6a 00 8b 55 0c 6a 00
> >>>>> 8b 45 08 0f b6 4d e4 6a 01 31 f6 e8 ee c5 fc ff 83 c4 10 eb 07 <89> 03
> >>>>> be 05 00 00 80 a1 74 63 31 3d 83 c0 48 e8 44 d2 ff ff eb 05
> >>>>>> RSP: 0018:000000000fd66fa0 EFLAGS: 00010002
> >>>>>> RAX: 0000000000000001 RBX: 000000001557ee88 RCX: 000000003d1f1120
> >>>>>> RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000001
> >>>>>> RBP: 000000000fd66fd8 R08: 000000001557ee88 R09: 0000000000000000
> >>>>>> R10: 0000000000000055 R11: 0000000000000000 R12: 0000000015bcf000
> >>>>>> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> >>>>>> FS:  00007f36ee9dc940(0000) GS:ffff9b903d700000(0000)
> >>>>> knlGS:0000000000000000
> >>>>>> CS:  0008 DS: 0018 ES: 0018 CR0: 0000000080050033
> >>>>>> CR2: 000000001557ee88 CR3: 000000000fd5e000 CR4: 00000000000006e0
> >>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >>>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >>>>>> Call Trace:
> >>>>>> Modules linked in: efivarfs
> >>>>>> CR2: 000000001557ee88
> >>>>>
> >>>>> EFI apparently tries to write to now read-only memory.
> >>>>>
> >>>>> See:
> >>>>> https://bugzilla.suse.com/show_bug.cgi?id=1168645
> >>>>>
> >>>>> Reverting it on the top of 5.6 fixes the issue.
> >>>>>
> >>>>> I am using
> >>>>> /usr/share/qemu/ovmf-ia32-code.bin
> >>>>> /usr/share/qemu/ovmf-ia32-vars.bin
> >>>>> from qemu-ovmf-ia32-202002-1.1.noarch rpm.
> >>>>>
> >>>>
> >>>> Do you have a git tree for Suse's OVMF fork? I did a lot of testing
> >>>> with upstream OVMF, and never ran into this issue.
> >>>
> >>> Not really a git tree, but the sources are here:
> >>> https://build.opensuse.org/package/show/openSUSE:Factory/ovmf
> >>>
> >>
> >>
> >> Anywhere I can get an actual build? The src rpm only has the sources,
> >> and the i586 rpm has nothing except
> >>
> >> $ rpm -qlp ~/Downloads/ovmf-202002-1.1.i586.rpm
> >> warning: /home/ardbie01/Downloads/ovmf-202002-1.1.i586.rpm: Header V3
> >> RSA/SHA256 Signature, key ID 3dbdc284: NOKEY
> >> /usr/share/doc/packages/ovmf
> >> /usr/share/doc/packages/ovmf/README
> >
> > Hmmm, it's weird that OBS doesn't list all derived files.
> > Anyway, the ia32 ovmf is available in
> > http://download.opensuse.org/tumbleweed/repo/oss/noarch/qemu-ovmf-ia32-202002-1.1.noarch.rpm
>
> It indeed does:
> https://build.opensuse.org/package/binaries/openSUSE:Factory/ovmf/standard
>
> Note that the ia32 version is noarch, built on i586.
>

I am not able to reproduce this issue using the linked firmware image
and a 5.6 x86_64_defconfig with efivarfs built in.

Could anyone share the full log, please, along with the kernel config
that was used? Also, it would be good to know if it is reproducible
using a kernel built from upstream.
