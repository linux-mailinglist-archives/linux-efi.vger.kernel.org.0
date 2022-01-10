Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639C7489DB7
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jan 2022 17:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237564AbiAJQiO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Jan 2022 11:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237552AbiAJQiN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 10 Jan 2022 11:38:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4E1C06173F;
        Mon, 10 Jan 2022 08:38:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEB79B816ED;
        Mon, 10 Jan 2022 16:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5584C36AE3;
        Mon, 10 Jan 2022 16:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641832690;
        bh=cJK7EpVCPGt1/Ax6wVPF/b0WeLje0bMc0HnxDb/Z9eo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=toWvs/SAlHa1M+zENhsFKRwqRzlTtqxldE15qo7skLG7+B5D2uUWLbBTGFYwXO8jX
         GfQpfrQXIQG8p3yd+Ig9lAqvmWPB/02VwVXdJ5bJBbH9tHMrE2nTR0ypm7FkmHYy48
         wlqlbrDS5tbA/YfvJXn+wehO9Z29ChfJiv21DJ1FSwd+61EYZDFDkUsCyWuKDH0tT5
         aV2DRamlyXhH3JnovFFa8xx8bsr/VgdGen1P1mp4vHDG6XuCN5E8IqaREPUb4Uzf2j
         sH2iEcvDuMJWbzxz3ocAh2DBVufAGcAPv8rZ9cCulCbYLuzEJsANKT0KSwuZeeL2dW
         /ea6+ZASPbtKA==
Received: by mail-wm1-f48.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso10098173wmc.3;
        Mon, 10 Jan 2022 08:38:10 -0800 (PST)
X-Gm-Message-State: AOAM530IRCYT5or93BVYMghDZLpWWt3sKASDMxQ6pJmJDaD3RrIw1XVS
        8HVykvXm77fjy9bx51zRU/T345DnbfrzUFh42YI=
X-Google-Smtp-Source: ABdhPJyEPMgbjybWI2XBKABrfgMkth3MB9/f52zAgU2nVWQiFANd8qZvID153NkO1Hxh7uUimznWzPjpshF+YB8oe8s=
X-Received: by 2002:a05:600c:1991:: with SMTP id t17mr242340wmq.25.1641832688965;
 Mon, 10 Jan 2022 08:38:08 -0800 (PST)
MIME-Version: 1.0
References: <6D757C75-65B1-468B-842D-10410081A8E4@live.com>
 <CAMj1kXETPO9iJoFm26v5gof2xpakHkvz3YV4ahet7BLjX5m5FQ@mail.gmail.com> <D3B9962F-F6F0-4622-9E0F-A3EABACAD471@live.com>
In-Reply-To: <D3B9962F-F6F0-4622-9E0F-A3EABACAD471@live.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 10 Jan 2022 17:37:57 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGem3QB0rj-b57xrcDYkCv6Moi=RX1OUspj3s4vMtsdug@mail.gmail.com>
Message-ID: <CAMj1kXGem3QB0rj-b57xrcDYkCv6Moi=RX1OUspj3s4vMtsdug@mail.gmail.com>
Subject: Re: [BUG][SEVERE] Enabling EFI runtime services causes panics in the
 T2 security chip on Macs equipped with it.
To:     Aditya Garg <gargaditya08@live.com>
Cc:     "matthew.garrett@nebula.com" <matthew.garrett@nebula.com>,
        "jk@ozlabs.org" <jk@ozlabs.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        Aun-Ali Zaidi <admin@kodeit.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 10 Jan 2022 at 17:28, Aditya Garg <gargaditya08@live.com> wrote:
>
>
> > As far as I can tell, what we need here is a DMI quirk that just
> > disables EFI runtime support on these platforms.
>
> If that=E2=80=99s the last option, please propose a patch for the same.
>

As the EFI maintainer for Linux, I'd be happy to merge a patch that
implements this. But I don't have time to write it, nor do I have
access to a recent Intel Mac, so I wouldn't be able to test it either.

So I suggest that you escalate this issue to whoever is providing
support for running Linux on your hardware, and I'm sure they will be
happy to employ someone to fix this problem for you.



> >
> >> Using efi=3Dnoruntine (or noefi) as a kernel parameter seems to fix th=
e issue. Also, making NVRAM read-only makes kernels boot. A fix for that wo=
uld be appreciated.
> >>
> >> Link :- https://bugzilla.kernel.org/show_bug.cgi?id=3D215277
> >>
> >> We believe kernel only fails to boot if something is set up to write t=
o nvram at boot, it can boot fine on a MacBookPro16,1 as long as I don't ha=
ve anything writing to nvram (deleting and reading variables is fine).
> >>
> >> The t2 security chip handles nvram and loading bootloaders on these
> >> macs. Its bridgeOS had an update that was bundled with macOS Catalina
> >> (this can't be downgraded, and some computers shipped with macOS
> >> Catalina), that made writing to nvram from Linux cause an invalid
> >> opcode error and a frozen system:
> >>
> >> invalid opcode: 0000 [#1] PREEMPT SMP PTI
> >> CPU: 9 PID: 135 Comm: kworker/u24:2 Tainted: G S   U   C        5.16.0=
-rc4-00054-g6c3ecb47bb75-dirty #72
> >> Hardware name: Apple Inc. MacBookPro16,1/Mac-E1008331FDC96864, BIOS 17=
15.40.15.0.0 (iBridge: 19.16.10548.0.0,0) 10/03/2021
> >> Workqueue: efi_rts_wq efi_call_rts
> >> RIP: 0010:0xfffffffeefc46877
> >> Code: 8b 58 18 0f b6 0d e1 09 00 00 48 c1 e1 04 e8 30 03 00 00 48 89 0=
5 d9 09 00 00 80 3d a2 09 00 00 01 75 09 48 c7 07 00 10 00 00 <0f> 0b 48 8b=
 05 a8 07 00 00 8b 40 08 48 83 c0 f0 48 89 07 48 c7 06
> >> RSP: 0018:ffff998d40513dd0 EFLAGS: 00010246
> >> RAX: ffff998d40513eb0 RBX: ffff998d43f17dd8 RCX: 0000000000000007
> >> RDX: ffff998d43f17dc8 RSI: ffff998d43f17dd8 RDI: ffff998d43f17dc8
> >> RBP: ffff998d40513e00 R08: ffff998d43f17dd0 R09: ffff998d43f17dd8
> >> R10: ffff998d40513c80 R11: ffffffff9b4cabe8 R12: ffff998d43f17dc8
> >> R13: ffff998d43f17dd0 R14: 0000000000000246 R15: 0000000000000048
> >> FS:  0000000000000000(0000) GS:ffff8cf8bec40000(0000) knlGS:0000000000=
000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 00007f9133594374 CR3: 0000000100200005 CR4: 00000000003706e0
> >> Call Trace:
> >> <TASK>
> >> ? _printk+0x58/0x6f
> >> __efi_call+0x28/0x30
> >> efi_call_rts.cold+0x83/0x104
> >> process_one_work+0x219/0x3f0
> >> worker_thread+0x4d/0x3d0
> >> ? rescuer_thread+0x390/0x390
> >> kthread+0x15c/0x180
> >> ? set_kthread_struct+0x40/0x40
> >> ret_from_fork+0x22/0x30
> >> </TASK>
> >> Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT n=
f_reject_ipv4 xt_tcpudp nft_compat amdgpu nft_chain_nat nf_nat nf_conntrack=
 nf_defrag_ipv6 nf_defrag_ipv4 nft_counter nf_tables n
> >> sysimgblt fb_sys_fops cec crc16 intel_pch_thermal sbs ecdh_generic ecc=
 rfkill apple_bl video acpi_tad mac_hid sbshc pkcs8_key_parser drm fuse cry=
pto_user bpf_preload ip_tables x_tables crct10dif_pcl
> >> ---[ end trace 22f8aad91761cc4a ]---
> >> RIP: 0010:0xfffffffeefc46877
> >> Code: 8b 58 18 0f b6 0d e1 09 00 00 48 c1 e1 04 e8 30 03 00 00 48 89 0=
5 d9 09 00 00 80 3d a2 09 00 00 01 75 09 48 c7 07 00 10 00 00 <0f> 0b 48 8b=
 05 a8 07 00 00 8b 40 08 48 83 c0 f0 48 89 07 48 c7 06
> >> RSP: 0018:ffff998d40513dd0 EFLAGS: 00010246
> >> RAX: ffff998d40513eb0 RBX: ffff998d43f17dd8 RCX: 0000000000000007
> >> RDX: ffff998d43f17dc8 RSI: ffff998d43f17dd8 RDI: ffff998d43f17dc8
> >> RBP: ffff998d40513e00 R08: ffff998d43f17dd0 R09: ffff998d43f17dd8
> >> R10: ffff998d40513c80 R11: ffffffff9b4cabe8 R12: ffff998d43f17dc8
> >> R13: ffff998d43f17dd0 R14: 0000000000000246 R15: 0000000000000048
> >> FS:  0000000000000000(0000) GS:ffff8cf8bec40000(0000) knlGS:0000000000=
000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 00007f9133594374 CR3: 0000000100200005 CR4: 00000000003706e0
> >> BUG: kernel NULL pointer dereference, address: 0000000000000008
> >> #PF: supervisor write access in kernel mode
> >> #PF: error_code(0x0002) - not-present page
> >>
> >> This seems to be triggered by EFI_QUERY_VARIABLE_INFO here
> >>
> >
> > This is interesting. QueryVariableInfo() was introduced in EFI 2.00,
> > and for a very long time, Intel MACs would claim to implement EFI 1.10
> > only. This means Linux would never attempt to use QueryVariableInfo()
> > on such platforms.
> >
> > Can you please check your boot log which revision it claims to implemen=
t now?
> >
> > Mine says
> >
> > efi: EFI v1.10 by Apple
>
> Mine says
>
> efi: EFI v2.40 by Apple
>
> >
> > near the start of the kernel log.
> >
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/firmware/efi/runtime-wrappers.c#n220
> >> and within that section, the invalid opcode seems to be occurring in
> >> this bit of assembly:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/arch/x86/platform/efi/efi_stub_64.S
> >>
> >
> > Ehm no. __efi_call() is just a trampoline to call into the firmware,
> > and the opcodes in question are firmware code not Linux code.
>
