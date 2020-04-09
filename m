Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 771651A318F
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 11:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgDIJKL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 05:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgDIJKK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Apr 2020 05:10:10 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 925482137B;
        Thu,  9 Apr 2020 09:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586423410;
        bh=Uviqfimv67NG+X74+yP1MK+0TUFuwrubxbBGo2wzZaQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i3BDDgL/ruQ7rZAZmGWl3u2L0gp5eyBYnsm53fJd2AaPgshO8B9/Km33GsvbHJpR/
         J9+vn5f4mPEhfpOy5JdYSLwb3KzxMC+dolkeTKrO+8bfOM3Wc2pe5yOQPnk/yBzcAD
         WSKVJ6AyeP22pc/yTsRr1x2tntducu2tL01htMFY=
Received: by mail-il1-f175.google.com with SMTP id o11so5319680ilq.7;
        Thu, 09 Apr 2020 02:10:10 -0700 (PDT)
X-Gm-Message-State: AGi0PuY8uR/I0s2Qh6UYE8K4yzvJp/0qGetFYYRTSvAb98E5nFodXYds
        AsSkvop6et2i6N9o8+eJTyJ64k0uBSJUrODhjuY=
X-Google-Smtp-Source: APiQypKljZ6WyUnHqOA1idl4JWds6dEGHGcOLlF21cv12dl5CWyCoAenNhQpoBHx1XNzjo6qtSWv1/3/bss3lPZ7/1Q=
X-Received: by 2002:a92:443:: with SMTP id 64mr4270679ile.258.1586423409864;
 Thu, 09 Apr 2020 02:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200113172245.27925-1-ardb@kernel.org> <20200113172245.27925-6-ardb@kernel.org>
 <63b125a4-6c62-fcdf-de22-d3bebe2dcbf5@suse.cz> <CAMj1kXGiT_zYjc6X-msRXVozhpDAY0UesEW3_4fOgiH4FyMgDw@mail.gmail.com>
 <972b66a9-92c7-9a15-1aa1-e3236abe90df@suse.cz> <CAMj1kXFGkOM9fbqr44_TbdxqFjH1i3d8dkO64C1mQmH=AqrUSQ@mail.gmail.com>
 <20200409080626.GV5951@GaryWorkstation> <984a2b3c-a9d4-e733-6372-4abf0f99be1f@suse.cz>
 <CAMj1kXFHUusU9dDgqhU_qswDVgYWx_kpaDEroj4ZSt3hr-AFsA@mail.gmail.com> <d38fd829-b944-da10-58c0-180f80e8264d@suse.cz>
In-Reply-To: <d38fd829-b944-da10-58c0-180f80e8264d@suse.cz>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 9 Apr 2020 11:09:58 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG4F+WzJX8_FyRAxQmDwqvbQMzh3Ji1KcpH_eO3Zt3-WQ@mail.gmail.com>
Message-ID: <CAMj1kXG4F+WzJX8_FyRAxQmDwqvbQMzh3Ji1KcpH_eO3Zt3-WQ@mail.gmail.com>
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

On Thu, 9 Apr 2020 at 10:36, Jiri Slaby <jslaby@suse.cz> wrote:
>
> On 09. 04. 20, 10:19, Ard Biesheuvel wrote:
> >>>> $ rpm -qlp ~/Downloads/ovmf-202002-1.1.i586.rpm
> >>>> warning: /home/ardbie01/Downloads/ovmf-202002-1.1.i586.rpm: Header V3
> >>>> RSA/SHA256 Signature, key ID 3dbdc284: NOKEY
> >>>> /usr/share/doc/packages/ovmf
> >>>> /usr/share/doc/packages/ovmf/README
> >>>
> >>> Hmmm, it's weird that OBS doesn't list all derived files.
> >>> Anyway, the ia32 ovmf is available in
> >>> http://download.opensuse.org/tumbleweed/repo/oss/noarch/qemu-ovmf-ia32-202002-1.1.noarch.rpm
> >>
> >> It indeed does:
> >> https://build.opensuse.org/package/binaries/openSUSE:Factory/ovmf/standard
> >>
> >> Note that the ia32 version is noarch, built on i586.
> >>
> >
> > I am not able to reproduce this issue using the linked firmware image
> > and a 5.6 x86_64_defconfig with efivarfs built in.
>
> Yeah, I had to use the distro config too. Not sure what the trigger is.
> Maybe some NUMA configs or something.
>
> > Could anyone share the full log, please, along with the kernel config
> > that was used?
>
> Both uploaded:
> http://decibel.fi.muni.cz/~xslaby/err/
>

With the same config, I am still not seeing the issue.


> Note that I switched the for-me-necessary =m configs to =y. So that it
> is enough to build bzImage, w/o modules...
>

Could you please try running it again with CONFIG_EFI_PGT_DUMP=y enabled?

In the mean time, I will try to install Tumbleweed from scratch. Do
you have any steps I could follow to reproduce your setup?


> > Also, it would be good to know if it is reproducible
> > using a kernel built from upstream.
>
> Sure, I was bisecting the upstream kernel:
> git bisect start
> # bad: [7111951b8d4973bda27ff663f2cf18b663d15b48] Linux 5.6
> git bisect bad 7111951b8d4973bda27ff663f2cf18b663d15b48
> # good: [d5226fa6dbae0569ee43ecfc08bdcd6770fc4755] Linux 5.5
> git bisect good d5226fa6dbae0569ee43ecfc08bdcd6770fc4755
> # skip: [9f68e3655aae6d49d6ba05dd263f99f33c2567af] Merge tag
> 'drm-next-2020-01-30' of git://anongit.freedesktop.org/drm/drm
> git bisect skip 9f68e3655aae6d49d6ba05dd263f99f33c2567af
> # good: [b4a4bd0f2629ec2ece7690de1b4721529da29871] irqchip/gic-v4.1: Add
> VPE INVALL callback
> git bisect good b4a4bd0f2629ec2ece7690de1b4721529da29871
> # good: [c130d2dc93cd03323494d82dbe7b5fb0d101ab62] rcu: Rename some
> instance of CONFIG_PREEMPTION to CONFIG_PREEMPT_RCU
> git bisect good c130d2dc93cd03323494d82dbe7b5fb0d101ab62
> # good: [0aee99a1ea53de1aedcf96a4d52d6161ffba011a] iio: gyro: adis16136:
> rework locks using ADIS library's state lock
> git bisect good 0aee99a1ea53de1aedcf96a4d52d6161ffba011a
> # bad: [83576e32a71717d1912b7dcb247a0f15613272da] Merge branch
> 'macb-TSO-bug-fixes'
> git bisect bad 83576e32a71717d1912b7dcb247a0f15613272da
> # bad: [7ba31c3f2f1ee095d8126f4d3757fc3b2bc3c838] Merge tag
> 'staging-5.6-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
> git bisect bad 7ba31c3f2f1ee095d8126f4d3757fc3b2bc3c838
> # good: [f76e4c167ea2212e23c15ee7e601a865e822c291] net: phy: add default
> ARCH_BCM_IPROC for MDIO_BCM_IPROC
> git bisect good f76e4c167ea2212e23c15ee7e601a865e822c291
> # bad: [bd2463ac7d7ec51d432f23bf0e893fb371a908cd] Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
> git bisect bad bd2463ac7d7ec51d432f23bf0e893fb371a908cd
> # good: [e279160f491392f1345f6eb4b0eeec5a6a2ecdd7] Merge tag
> 'timers-core-2020-01-27' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good e279160f491392f1345f6eb4b0eeec5a6a2ecdd7
> # bad: [511fdb78442229ac11057b4a55c3f03c253c062f] Merge branch
> 'x86-mtrr-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad 511fdb78442229ac11057b4a55c3f03c253c062f
> # bad: [2180f214f4a5d8e2d8b7138d9a59246ee05753b9] Merge branch
> 'locking-core-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad 2180f214f4a5d8e2d8b7138d9a59246ee05753b9
> # good: [d99391ec2b42d827d92003dcdcb96fadac9d862b] Merge branch
> 'core-rcu-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good d99391ec2b42d827d92003dcdcb96fadac9d862b
> # good: [57ad87ddce79b6d54f8e442d0ecf4b5bbe8c5a9e] Merge branch 'x86/mm'
> into efi/core, to pick up dependencies
> git bisect good 57ad87ddce79b6d54f8e442d0ecf4b5bbe8c5a9e
> # good: [ac3c76cc6d6deef573dd8c14232f20c6aa744f83] efi/libstub/x86: Use
> mandatory 16-byte stack alignment in mixed mode
> git bisect good ac3c76cc6d6deef573dd8c14232f20c6aa744f83
> # bad: [484a418d075488c6999528247cc711d12c373447] efi: Fix handling of
> multiple efi_fake_mem= entries
> git bisect bad 484a418d075488c6999528247cc711d12c373447
> # bad: [1f299fad1e312947c974c6a1d8a3a484f27a6111] efi/x86: Limit EFI old
> memory map to SGI UV machines
> git bisect bad 1f299fad1e312947c974c6a1d8a3a484f27a6111
> # good: [75fbef0a8b6b4bb19b9a91b5214f846c2dc5139e] x86/mm: Fix NX bit
> clearing issue in kernel_map_pages_in_pgd
> git bisect good 75fbef0a8b6b4bb19b9a91b5214f846c2dc5139e
> # bad: [97bb9cdc32108036170d9d0d208257168f80d9e9] efi/x86: Avoid RWX
> mappings for all of DRAM
> git bisect bad 97bb9cdc32108036170d9d0d208257168f80d9e9
> # bad: [d9e3d2c4f103200d87f2c243a84c1fd3b3bfea8c] efi/x86: Don't map the
> entire kernel text RW for mixed mode
> git bisect bad d9e3d2c4f103200d87f2c243a84c1fd3b3bfea8c
> # first bad commit: [d9e3d2c4f103200d87f2c243a84c1fd3b3bfea8c] efi/x86:
> Don't map the entire kernel text RW for mixed mode
>
> thanks,
> --
> js
> suse labs
