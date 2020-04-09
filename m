Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6121A3071
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 09:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgDIHvd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 03:51:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgDIHvc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Apr 2020 03:51:32 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 913B82082D;
        Thu,  9 Apr 2020 07:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586418692;
        bh=SttG6HiBtvSMedkK2H7xZTLf5No9PN+aJtrQbBH6Nhc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=agXTuHhD/YCD603fUVDGzhcEATxdRue+5w+2i0G8fSZHF2MGmhEhBtBLON+n+dl31
         /6Lr9wox1fE9aZHhhkqMhRlpoBt2yj46L52SyssUHsWEybRwW5kTL+MqGOlIJcB4rn
         7Jwk31OzCoUvsNJQJNrwLxYJmqMd2vSAN8OI6yd4=
Received: by mail-il1-f175.google.com with SMTP id k29so9387900ilg.0;
        Thu, 09 Apr 2020 00:51:32 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ5FwCRYec9D/iMttw9aqVtotmctfqJo9bApu6v2ChDsk5xStGF
        34L9IncwvVYoYcGnWsrq4lQEVG6ZSNlBtcATX1A=
X-Google-Smtp-Source: APiQypJnt7QCvckQDVsZl8+eLb3PzG4uDQYlm7wmZ+7BQZxNfuNp3KZE2cMie/BZ3Hfa3QgG7VGRtb6r9ME6JulUqps=
X-Received: by 2002:a05:6e02:551:: with SMTP id i17mr3552543ils.218.1586418691873;
 Thu, 09 Apr 2020 00:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200113172245.27925-1-ardb@kernel.org> <20200113172245.27925-6-ardb@kernel.org>
 <63b125a4-6c62-fcdf-de22-d3bebe2dcbf5@suse.cz> <CAMj1kXGiT_zYjc6X-msRXVozhpDAY0UesEW3_4fOgiH4FyMgDw@mail.gmail.com>
 <972b66a9-92c7-9a15-1aa1-e3236abe90df@suse.cz>
In-Reply-To: <972b66a9-92c7-9a15-1aa1-e3236abe90df@suse.cz>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 9 Apr 2020 09:51:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFGkOM9fbqr44_TbdxqFjH1i3d8dkO64C1mQmH=AqrUSQ@mail.gmail.com>
Message-ID: <CAMj1kXFGkOM9fbqr44_TbdxqFjH1i3d8dkO64C1mQmH=AqrUSQ@mail.gmail.com>
Subject: Re: [PATCH 05/13] efi/x86: don't map the entire kernel text RW for
 mixed mode
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Young <dyoung@redhat.com>,
        Saravana Kannan <saravanak@google.com>,
        Gary Lin <GLin@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 8 Apr 2020 at 12:51, Jiri Slaby <jslaby@suse.cz> wrote:
>
> Ccing Gary.
>
> On 08. 04. 20, 12:47, Ard Biesheuvel wrote:
> > On Wed, 8 Apr 2020 at 12:42, Jiri Slaby <jslaby@suse.cz> wrote:
> >>
> >> On 13. 01. 20, 18:22, Ard Biesheuvel wrote:
> >>> The mixed mode thunking routine requires a part of it to be
> >>> mapped 1:1, and for this reason, we currently map the entire
> >>> kernel .text read/write in the EFI page tables, which is bad.
> >>>
> >>> In fact, the kernel_map_pages_in_pgd() invocation that installs
> >>> this mapping is entirely redundant, since all of DRAM is already
> >>> 1:1 mapped read/write in the EFI page tables when we reach this
> >>> point, which means that .rodata is mapped read-write as well.
> >>>
> >>> So let's remap both .text and .rodata read-only in the EFI
> >>> page tables.
> >>
> >> This patch causes unhandled page faults in mixed mode:
> >>
> >>> BUG: unable to handle page fault for address: 000000001557ee88
> >>> #PF: supervisor write access in kernel mode
> >>> #PF: error_code(0x0003) - permissions violation
> >>> PGD fd52063 P4D fd52063 PUD fd53063 PMD 154000e1
> >>> Oops: 0003 [#1] SMP PTI
> >>> CPU: 1 PID: 191 Comm: systemd-escape Not tainted
> >> 5.6.2-20.gb22bc26-default #1 openSUSE Tumbleweed (unreleased)
> >>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0
> >> 02/06/2015
> >>> RIP: 0008:0x3d2eed95
> >>> Code: 8b 45 d4 8b 4d 10 8b 40 04 89 01 89 3b 50 6a 00 8b 55 0c 6a 00
> >> 8b 45 08 0f b6 4d e4 6a 01 31 f6 e8 ee c5 fc ff 83 c4 10 eb 07 <89> 03
> >> be 05 00 00 80 a1 74 63 31 3d 83 c0 48 e8 44 d2 ff ff eb 05
> >>> RSP: 0018:000000000fd66fa0 EFLAGS: 00010002
> >>> RAX: 0000000000000001 RBX: 000000001557ee88 RCX: 000000003d1f1120
> >>> RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000001
> >>> RBP: 000000000fd66fd8 R08: 000000001557ee88 R09: 0000000000000000
> >>> R10: 0000000000000055 R11: 0000000000000000 R12: 0000000015bcf000
> >>> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> >>> FS:  00007f36ee9dc940(0000) GS:ffff9b903d700000(0000)
> >> knlGS:0000000000000000
> >>> CS:  0008 DS: 0018 ES: 0018 CR0: 0000000080050033
> >>> CR2: 000000001557ee88 CR3: 000000000fd5e000 CR4: 00000000000006e0
> >>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >>> Call Trace:
> >>> Modules linked in: efivarfs
> >>> CR2: 000000001557ee88
> >>
> >> EFI apparently tries to write to now read-only memory.
> >>
> >> See:
> >> https://bugzilla.suse.com/show_bug.cgi?id=1168645
> >>
> >> Reverting it on the top of 5.6 fixes the issue.
> >>
> >> I am using
> >> /usr/share/qemu/ovmf-ia32-code.bin
> >> /usr/share/qemu/ovmf-ia32-vars.bin
> >> from qemu-ovmf-ia32-202002-1.1.noarch rpm.
> >>
> >
> > Do you have a git tree for Suse's OVMF fork? I did a lot of testing
> > with upstream OVMF, and never ran into this issue.
>
> Not really a git tree, but the sources are here:
> https://build.opensuse.org/package/show/openSUSE:Factory/ovmf
>


Anywhere I can get an actual build? The src rpm only has the sources,
and the i586 rpm has nothing except

$ rpm -qlp ~/Downloads/ovmf-202002-1.1.i586.rpm
warning: /home/ardbie01/Downloads/ovmf-202002-1.1.i586.rpm: Header V3
RSA/SHA256 Signature, key ID 3dbdc284: NOKEY
/usr/share/doc/packages/ovmf
/usr/share/doc/packages/ovmf/README
