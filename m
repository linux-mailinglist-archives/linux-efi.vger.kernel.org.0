Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD3F1A30A5
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 10:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgDIIKa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 04:10:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:43286 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgDIIK3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Apr 2020 04:10:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 849C7ACF2;
        Thu,  9 Apr 2020 08:10:26 +0000 (UTC)
Subject: Re: [PATCH 05/13] efi/x86: don't map the entire kernel text RW for
 mixed mode
To:     Gary Lin <glin@suse.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Young <dyoung@redhat.com>,
        Saravana Kannan <saravanak@google.com>
References: <20200113172245.27925-1-ardb@kernel.org>
 <20200113172245.27925-6-ardb@kernel.org>
 <63b125a4-6c62-fcdf-de22-d3bebe2dcbf5@suse.cz>
 <CAMj1kXGiT_zYjc6X-msRXVozhpDAY0UesEW3_4fOgiH4FyMgDw@mail.gmail.com>
 <972b66a9-92c7-9a15-1aa1-e3236abe90df@suse.cz>
 <CAMj1kXFGkOM9fbqr44_TbdxqFjH1i3d8dkO64C1mQmH=AqrUSQ@mail.gmail.com>
 <20200409080626.GV5951@GaryWorkstation>
From:   Jiri Slaby <jslaby@suse.cz>
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <984a2b3c-a9d4-e733-6372-4abf0f99be1f@suse.cz>
Date:   Thu, 9 Apr 2020 10:10:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200409080626.GV5951@GaryWorkstation>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 09. 04. 20, 10:06, Gary Lin wrote:
> On Thu, Apr 09, 2020 at 09:51:20AM +0200, Ard Biesheuvel wrote:
>> On Wed, 8 Apr 2020 at 12:51, Jiri Slaby <jslaby@suse.cz> wrote:
>>>
>>> Ccing Gary.
>>>
>>> On 08. 04. 20, 12:47, Ard Biesheuvel wrote:
>>>> On Wed, 8 Apr 2020 at 12:42, Jiri Slaby <jslaby@suse.cz> wrote:
>>>>>
>>>>> On 13. 01. 20, 18:22, Ard Biesheuvel wrote:
>>>>>> The mixed mode thunking routine requires a part of it to be
>>>>>> mapped 1:1, and for this reason, we currently map the entire
>>>>>> kernel .text read/write in the EFI page tables, which is bad.
>>>>>>
>>>>>> In fact, the kernel_map_pages_in_pgd() invocation that installs
>>>>>> this mapping is entirely redundant, since all of DRAM is already
>>>>>> 1:1 mapped read/write in the EFI page tables when we reach this
>>>>>> point, which means that .rodata is mapped read-write as well.
>>>>>>
>>>>>> So let's remap both .text and .rodata read-only in the EFI
>>>>>> page tables.
>>>>>
>>>>> This patch causes unhandled page faults in mixed mode:
>>>>>
>>>>>> BUG: unable to handle page fault for address: 000000001557ee88
>>>>>> #PF: supervisor write access in kernel mode
>>>>>> #PF: error_code(0x0003) - permissions violation
>>>>>> PGD fd52063 P4D fd52063 PUD fd53063 PMD 154000e1
>>>>>> Oops: 0003 [#1] SMP PTI
>>>>>> CPU: 1 PID: 191 Comm: systemd-escape Not tainted
>>>>> 5.6.2-20.gb22bc26-default #1 openSUSE Tumbleweed (unreleased)
>>>>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0
>>>>> 02/06/2015
>>>>>> RIP: 0008:0x3d2eed95
>>>>>> Code: 8b 45 d4 8b 4d 10 8b 40 04 89 01 89 3b 50 6a 00 8b 55 0c 6a 00
>>>>> 8b 45 08 0f b6 4d e4 6a 01 31 f6 e8 ee c5 fc ff 83 c4 10 eb 07 <89> 03
>>>>> be 05 00 00 80 a1 74 63 31 3d 83 c0 48 e8 44 d2 ff ff eb 05
>>>>>> RSP: 0018:000000000fd66fa0 EFLAGS: 00010002
>>>>>> RAX: 0000000000000001 RBX: 000000001557ee88 RCX: 000000003d1f1120
>>>>>> RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000001
>>>>>> RBP: 000000000fd66fd8 R08: 000000001557ee88 R09: 0000000000000000
>>>>>> R10: 0000000000000055 R11: 0000000000000000 R12: 0000000015bcf000
>>>>>> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>>>>>> FS:  00007f36ee9dc940(0000) GS:ffff9b903d700000(0000)
>>>>> knlGS:0000000000000000
>>>>>> CS:  0008 DS: 0018 ES: 0018 CR0: 0000000080050033
>>>>>> CR2: 000000001557ee88 CR3: 000000000fd5e000 CR4: 00000000000006e0
>>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>>> Call Trace:
>>>>>> Modules linked in: efivarfs
>>>>>> CR2: 000000001557ee88
>>>>>
>>>>> EFI apparently tries to write to now read-only memory.
>>>>>
>>>>> See:
>>>>> https://bugzilla.suse.com/show_bug.cgi?id=1168645
>>>>>
>>>>> Reverting it on the top of 5.6 fixes the issue.
>>>>>
>>>>> I am using
>>>>> /usr/share/qemu/ovmf-ia32-code.bin
>>>>> /usr/share/qemu/ovmf-ia32-vars.bin
>>>>> from qemu-ovmf-ia32-202002-1.1.noarch rpm.
>>>>>
>>>>
>>>> Do you have a git tree for Suse's OVMF fork? I did a lot of testing
>>>> with upstream OVMF, and never ran into this issue.
>>>
>>> Not really a git tree, but the sources are here:
>>> https://build.opensuse.org/package/show/openSUSE:Factory/ovmf
>>>
>>
>>
>> Anywhere I can get an actual build? The src rpm only has the sources,
>> and the i586 rpm has nothing except
>>
>> $ rpm -qlp ~/Downloads/ovmf-202002-1.1.i586.rpm
>> warning: /home/ardbie01/Downloads/ovmf-202002-1.1.i586.rpm: Header V3
>> RSA/SHA256 Signature, key ID 3dbdc284: NOKEY
>> /usr/share/doc/packages/ovmf
>> /usr/share/doc/packages/ovmf/README
> 
> Hmmm, it's weird that OBS doesn't list all derived files.
> Anyway, the ia32 ovmf is available in
> http://download.opensuse.org/tumbleweed/repo/oss/noarch/qemu-ovmf-ia32-202002-1.1.noarch.rpm

It indeed does:
https://build.opensuse.org/package/binaries/openSUSE:Factory/ovmf/standard

Note that the ia32 version is noarch, built on i586.

thanks,
-- 
js
suse labs
