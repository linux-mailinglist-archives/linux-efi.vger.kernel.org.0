Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 018C81A333E
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 13:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgDILcS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 07:32:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgDILcS (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Apr 2020 07:32:18 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B27621556;
        Thu,  9 Apr 2020 11:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586431938;
        bh=DuAq5EnRhkQ6xi+bOGjEhSy0kbZf8rN6OuFlXEoMBgY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iD4YmuDGLBgwZDKwtqkm1MO+LVmIzIv8BhkmSsRrtdQn8h09zrwiee9Ll8KXj+HP5
         3MJ41Jp1NNJ0oYPapCgk5VpPBhnBlRKtSaHJ57VgyCN88WvD572C5JMnaUr6NwB9q9
         eLKVMz49JSrPMo7MjPQhLMBsCY0s1GfFZGqM+YDc=
Received: by mail-il1-f181.google.com with SMTP id k29so9889642ilg.0;
        Thu, 09 Apr 2020 04:32:18 -0700 (PDT)
X-Gm-Message-State: AGi0PuZmjv/NSl0JQ6R1HU4K665ZkOHz4aychkyS2XcnFWNO4+ZiM6pv
        oKIe7OuAjon0b8/nqXFfKQ8lBh0ZwhkenktkS/Q=
X-Google-Smtp-Source: APiQypJU3k9rXFuaHohmsJMOtzpIICFJEFbpJgUdVKAZb6yalsYgeOG0VYQkmasX2vmWncBsgK5boX8FPbGhfECmt0U=
X-Received: by 2002:a05:6e02:551:: with SMTP id i17mr4197308ils.218.1586431937628;
 Thu, 09 Apr 2020 04:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200113172245.27925-1-ardb@kernel.org> <20200113172245.27925-6-ardb@kernel.org>
 <63b125a4-6c62-fcdf-de22-d3bebe2dcbf5@suse.cz> <CAMj1kXGiT_zYjc6X-msRXVozhpDAY0UesEW3_4fOgiH4FyMgDw@mail.gmail.com>
 <972b66a9-92c7-9a15-1aa1-e3236abe90df@suse.cz> <CAMj1kXFGkOM9fbqr44_TbdxqFjH1i3d8dkO64C1mQmH=AqrUSQ@mail.gmail.com>
 <20200409080626.GV5951@GaryWorkstation> <984a2b3c-a9d4-e733-6372-4abf0f99be1f@suse.cz>
 <CAMj1kXFHUusU9dDgqhU_qswDVgYWx_kpaDEroj4ZSt3hr-AFsA@mail.gmail.com>
 <d38fd829-b944-da10-58c0-180f80e8264d@suse.cz> <CAMj1kXG4F+WzJX8_FyRAxQmDwqvbQMzh3Ji1KcpH_eO3Zt3-WQ@mail.gmail.com>
 <b6006dd7-2ce0-0776-9a61-52377b8eef63@suse.cz> <CAMj1kXFsaoUoWbwRVFJX_ze+gJHOKRLyTL5kEecYJRPr84wWqw@mail.gmail.com>
 <CAMj1kXEhLjh4NENkzfKmO=eLxEXmgU7MDyJsL51Ctas5XW40Sw@mail.gmail.com> <CAMj1kXFJ3WvtTKejKFwY-JKsTBjANdM8+Mae8+Yvfsu15ke+zg@mail.gmail.com>
In-Reply-To: <CAMj1kXFJ3WvtTKejKFwY-JKsTBjANdM8+Mae8+Yvfsu15ke+zg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 9 Apr 2020 13:32:06 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEAhTzuEGZr+SBt0T2PCmM=ADK1-8iTPjReZfVUi4b-kQ@mail.gmail.com>
Message-ID: <CAMj1kXEAhTzuEGZr+SBt0T2PCmM=ADK1-8iTPjReZfVUi4b-kQ@mail.gmail.com>
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

On Thu, 9 Apr 2020 at 13:25, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 9 Apr 2020 at 13:08, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 9 Apr 2020 at 12:45, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Thu, 9 Apr 2020 at 12:09, Jiri Slaby <jslaby@suse.cz> wrote:
> > > >
> > > > On 09. 04. 20, 11:09, Ard Biesheuvel wrote:
> > > > > On Thu, 9 Apr 2020 at 10:36, Jiri Slaby <jslaby@suse.cz> wrote:
> > > > >>
> > > > >> On 09. 04. 20, 10:19, Ard Biesheuvel wrote:
> > > > >>>>>> $ rpm -qlp ~/Downloads/ovmf-202002-1.1.i586.rpm
> > > > >>>>>> warning: /home/ardbie01/Downloads/ovmf-202002-1.1.i586.rpm: Header V3
> > > > >>>>>> RSA/SHA256 Signature, key ID 3dbdc284: NOKEY
> > > > >>>>>> /usr/share/doc/packages/ovmf
> > > > >>>>>> /usr/share/doc/packages/ovmf/README
> > > > >>>>>
> > > > >>>>> Hmmm, it's weird that OBS doesn't list all derived files.
> > > > >>>>> Anyway, the ia32 ovmf is available in
> > > > >>>>> http://download.opensuse.org/tumbleweed/repo/oss/noarch/qemu-ovmf-ia32-202002-1.1.noarch.rpm
> > > > >>>>
> > > > >>>> It indeed does:
> > > > >>>> https://build.opensuse.org/package/binaries/openSUSE:Factory/ovmf/standard
> > > > >>>>
> > > > >>>> Note that the ia32 version is noarch, built on i586.
> > > > >>>>
> > > > >>>
> > > > >>> I am not able to reproduce this issue using the linked firmware image
> > > > >>> and a 5.6 x86_64_defconfig with efivarfs built in.
> > > > >>
> > > > >> Yeah, I had to use the distro config too. Not sure what the trigger is.
> > > > >> Maybe some NUMA configs or something.
> > > > >>
> > > > >>> Could anyone share the full log, please, along with the kernel config
> > > > >>> that was used?
> > > > >>
> > > > >> Both uploaded:
> > > > >> http://decibel.fi.muni.cz/~xslaby/err/
> > > > >>
> > > > >
> > > > > With the same config, I am still not seeing the issue.
> > > > >
> > > > >
> > > > >> Note that I switched the for-me-necessary =m configs to =y. So that it
> > > > >> is enough to build bzImage, w/o modules...
> > > > >>
> > > > >
> > > > > Could you please try running it again with CONFIG_EFI_PGT_DUMP=y enabled?
> > > >
> > > > No problem:
> > > > http://decibel.fi.muni.cz/~xslaby/err/dmesg2.txt
> > > >
> > > > > In the mean time, I will try to install Tumbleweed from scratch. Do
> > > > > you have any steps I could follow to reproduce your setup?
> > > >
> > > > Not really, just installed TW 64-bit and used efi and grub 32 bit.
> > > >
> > >
> > > OK, so you installed using a 64-bit EFI, and then switched to a 32-bit
> > > one? Or is there a special mixed-mode capable installer?
> > >
> > > (The ones I found are x86_64 only)
> >
> > OK, I have managed to install tumbleweed into a 64-bit VM with 64-bit GRUB.
> >
> > Could you give any instructions how to convert to 32-bit GRUB please?
>
> Never mind - I managed to switch. I still don't see the issue though :-(

Success!!

[    2.416076] BUG: unable to handle page fault for address: 0000000028348e88
[    2.417698] #PF: supervisor write access in kernel mode
[    2.418697] #PF: error_code(0x0003) - permissions violation
[    2.419927] PGD fd61063 P4D fd61063 PUD fd62063 PMD 282000e1
[    2.421131] Oops: 0003 [#1] SMP PTI
[    2.421857] CPU: 3 PID: 254 Comm: systemd-system- Not tainted
5.6.0-rc4-default+ #19
[    2.423364] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 0.0.0 02/06/2015
[    2.424814] RIP: 0008:0x3eaeed95
[    2.425376] Code: 8b 45 d4 8b 4d 10 8b 40 04 89 01 89 3b 50 6a 00
8b 55 0c 6a 00 8b 45 08 0f b6 4d e4 6a 01 31 f6 e8 ee c5 fc ff 83 c4
10 eb 07 <89> 03 be 05 00 00 80 a1 74 63 b1 3e 83 c0 48 e8 44 d2 ff ff
eb 05
[    2.428159] RSP: 0018:000000000fd73fa0 EFLAGS: 00010002
[    2.429012] RAX: 0000000000000001 RBX: 0000000028348e88 RCX: 000000003e9f1120
[    2.430063] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000001
[    2.431459] RBP: 000000000fd73fd8 R08: 0000000028348e88 R09: 0000000000000000
[    2.433037] R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000000
[    2.433386] usb 1-2: New USB device found, idVendor=0627,
idProduct=0001, bcdDevice= 0.00
[    2.434484] R13: ffffa02f80220000 R14: 0000000000000000 R15: 0000000000000000
[    2.436404] usb 1-2: New USB device strings: Mfr=1, Product=3, SerialNumber=5
[    2.437438] FS:  00007f121439c940(0000) GS:ffff8accbd580000(0000)
knlGS:0000000000000000
[    2.438872] usb 1-2: Product: QEMU USB Tablet
[    2.439986] CS:  0008 DS: 0018 ES: 0018 CR0: 0000000080050033
[    2.439987] CR2: 0000000028348e88 CR3: 000000000fd6c005 CR4: 00000000003606e0
[    2.440878] usb 1-2: Manufacturer: QEMU
[    2.441686] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    2.442979] usb 1-2: SerialNumber: 42
[    2.443559] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    2.443561] Call Trace:
[    2.447302] Modules linked in:
[    2.447830] CR2: 0000000028348e88
[    2.448459] ---[ end trace 604ea22c03fc4e28 ]---
