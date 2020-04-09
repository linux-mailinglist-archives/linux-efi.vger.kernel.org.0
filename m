Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8D421A3103
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 10:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgDIIeu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 04:34:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:55176 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgDIIet (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Apr 2020 04:34:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 693F2ACBA;
        Thu,  9 Apr 2020 08:34:47 +0000 (UTC)
Subject: Re: [PATCH 05/13] efi/x86: don't map the entire kernel text RW for
 mixed mode
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Gary Lin <glin@suse.com>, linux-efi <linux-efi@vger.kernel.org>,
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
 <984a2b3c-a9d4-e733-6372-4abf0f99be1f@suse.cz>
 <CAMj1kXFHUusU9dDgqhU_qswDVgYWx_kpaDEroj4ZSt3hr-AFsA@mail.gmail.com>
From:   Jiri Slaby <jslaby@suse.cz>
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d38fd829-b944-da10-58c0-180f80e8264d@suse.cz>
Date:   Thu, 9 Apr 2020 10:34:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXFHUusU9dDgqhU_qswDVgYWx_kpaDEroj4ZSt3hr-AFsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 09. 04. 20, 10:19, Ard Biesheuvel wrote:
>>>> $ rpm -qlp ~/Downloads/ovmf-202002-1.1.i586.rpm
>>>> warning: /home/ardbie01/Downloads/ovmf-202002-1.1.i586.rpm: Header V3
>>>> RSA/SHA256 Signature, key ID 3dbdc284: NOKEY
>>>> /usr/share/doc/packages/ovmf
>>>> /usr/share/doc/packages/ovmf/README
>>>
>>> Hmmm, it's weird that OBS doesn't list all derived files.
>>> Anyway, the ia32 ovmf is available in
>>> http://download.opensuse.org/tumbleweed/repo/oss/noarch/qemu-ovmf-ia32-202002-1.1.noarch.rpm
>>
>> It indeed does:
>> https://build.opensuse.org/package/binaries/openSUSE:Factory/ovmf/standard
>>
>> Note that the ia32 version is noarch, built on i586.
>>
> 
> I am not able to reproduce this issue using the linked firmware image
> and a 5.6 x86_64_defconfig with efivarfs built in.

Yeah, I had to use the distro config too. Not sure what the trigger is.
Maybe some NUMA configs or something.

> Could anyone share the full log, please, along with the kernel config
> that was used?

Both uploaded:
http://decibel.fi.muni.cz/~xslaby/err/

Note that I switched the for-me-necessary =m configs to =y. So that it
is enough to build bzImage, w/o modules...

> Also, it would be good to know if it is reproducible
> using a kernel built from upstream.

Sure, I was bisecting the upstream kernel:
git bisect start
# bad: [7111951b8d4973bda27ff663f2cf18b663d15b48] Linux 5.6
git bisect bad 7111951b8d4973bda27ff663f2cf18b663d15b48
# good: [d5226fa6dbae0569ee43ecfc08bdcd6770fc4755] Linux 5.5
git bisect good d5226fa6dbae0569ee43ecfc08bdcd6770fc4755
# skip: [9f68e3655aae6d49d6ba05dd263f99f33c2567af] Merge tag
'drm-next-2020-01-30' of git://anongit.freedesktop.org/drm/drm
git bisect skip 9f68e3655aae6d49d6ba05dd263f99f33c2567af
# good: [b4a4bd0f2629ec2ece7690de1b4721529da29871] irqchip/gic-v4.1: Add
VPE INVALL callback
git bisect good b4a4bd0f2629ec2ece7690de1b4721529da29871
# good: [c130d2dc93cd03323494d82dbe7b5fb0d101ab62] rcu: Rename some
instance of CONFIG_PREEMPTION to CONFIG_PREEMPT_RCU
git bisect good c130d2dc93cd03323494d82dbe7b5fb0d101ab62
# good: [0aee99a1ea53de1aedcf96a4d52d6161ffba011a] iio: gyro: adis16136:
rework locks using ADIS library's state lock
git bisect good 0aee99a1ea53de1aedcf96a4d52d6161ffba011a
# bad: [83576e32a71717d1912b7dcb247a0f15613272da] Merge branch
'macb-TSO-bug-fixes'
git bisect bad 83576e32a71717d1912b7dcb247a0f15613272da
# bad: [7ba31c3f2f1ee095d8126f4d3757fc3b2bc3c838] Merge tag
'staging-5.6-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect bad 7ba31c3f2f1ee095d8126f4d3757fc3b2bc3c838
# good: [f76e4c167ea2212e23c15ee7e601a865e822c291] net: phy: add default
ARCH_BCM_IPROC for MDIO_BCM_IPROC
git bisect good f76e4c167ea2212e23c15ee7e601a865e822c291
# bad: [bd2463ac7d7ec51d432f23bf0e893fb371a908cd] Merge
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
git bisect bad bd2463ac7d7ec51d432f23bf0e893fb371a908cd
# good: [e279160f491392f1345f6eb4b0eeec5a6a2ecdd7] Merge tag
'timers-core-2020-01-27' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good e279160f491392f1345f6eb4b0eeec5a6a2ecdd7
# bad: [511fdb78442229ac11057b4a55c3f03c253c062f] Merge branch
'x86-mtrr-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 511fdb78442229ac11057b4a55c3f03c253c062f
# bad: [2180f214f4a5d8e2d8b7138d9a59246ee05753b9] Merge branch
'locking-core-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 2180f214f4a5d8e2d8b7138d9a59246ee05753b9
# good: [d99391ec2b42d827d92003dcdcb96fadac9d862b] Merge branch
'core-rcu-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good d99391ec2b42d827d92003dcdcb96fadac9d862b
# good: [57ad87ddce79b6d54f8e442d0ecf4b5bbe8c5a9e] Merge branch 'x86/mm'
into efi/core, to pick up dependencies
git bisect good 57ad87ddce79b6d54f8e442d0ecf4b5bbe8c5a9e
# good: [ac3c76cc6d6deef573dd8c14232f20c6aa744f83] efi/libstub/x86: Use
mandatory 16-byte stack alignment in mixed mode
git bisect good ac3c76cc6d6deef573dd8c14232f20c6aa744f83
# bad: [484a418d075488c6999528247cc711d12c373447] efi: Fix handling of
multiple efi_fake_mem= entries
git bisect bad 484a418d075488c6999528247cc711d12c373447
# bad: [1f299fad1e312947c974c6a1d8a3a484f27a6111] efi/x86: Limit EFI old
memory map to SGI UV machines
git bisect bad 1f299fad1e312947c974c6a1d8a3a484f27a6111
# good: [75fbef0a8b6b4bb19b9a91b5214f846c2dc5139e] x86/mm: Fix NX bit
clearing issue in kernel_map_pages_in_pgd
git bisect good 75fbef0a8b6b4bb19b9a91b5214f846c2dc5139e
# bad: [97bb9cdc32108036170d9d0d208257168f80d9e9] efi/x86: Avoid RWX
mappings for all of DRAM
git bisect bad 97bb9cdc32108036170d9d0d208257168f80d9e9
# bad: [d9e3d2c4f103200d87f2c243a84c1fd3b3bfea8c] efi/x86: Don't map the
entire kernel text RW for mixed mode
git bisect bad d9e3d2c4f103200d87f2c243a84c1fd3b3bfea8c
# first bad commit: [d9e3d2c4f103200d87f2c243a84c1fd3b3bfea8c] efi/x86:
Don't map the entire kernel text RW for mixed mode

thanks,
-- 
js
suse labs
