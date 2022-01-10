Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5533489D03
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jan 2022 17:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbiAJQC1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Jan 2022 11:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiAJQC1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 10 Jan 2022 11:02:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3DDC06173F;
        Mon, 10 Jan 2022 08:02:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C19ABB8168C;
        Mon, 10 Jan 2022 16:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97757C36AE5;
        Mon, 10 Jan 2022 16:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641830544;
        bh=6wB5YbnNRiBGiEWLPxOB+jJGVHeGCX8UkaFmOHwDOxU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lRXBcIuWvWfI9qlywBoZnODVQkmeaNdoLBwuRk+EMwqd+xtPtq27acCf3K/+AS+uZ
         uOpzu/e5CzsYdAWWC6WJIFPe/1H9/C0v0RoXekn34u2SfH2H2dJwAld5G1lYbU/73j
         BYq9zFp9F2gzj0S13ZGZ5VbfsbIlsUvGS3oWbxfBidwAx/Ps96N/jahk+zsau65KIS
         J2pPJ/FTpDEbWXy9jEkEY5uKEr5ftR6xsUH6dPceJHC+FGsvTgYWfPdnJjnS/mIsDc
         SaCOTmLoKvuur8+U4P9g4M36szVNoQ78rrNnKZv9XkJuw1uMzlgtjEjuNRnFlfTbiy
         uVBLeCu9ToiBw==
Received: by mail-wm1-f52.google.com with SMTP id p18so2316838wmg.4;
        Mon, 10 Jan 2022 08:02:24 -0800 (PST)
X-Gm-Message-State: AOAM532bSyseITriZ15mSyHlDvkGmo2zgS+5yqg0qkX1RuRSq9CtUJJ1
        skT8x/VCMtSk0v2UR/lsk+54HwWvcXn8a5hNmu4=
X-Google-Smtp-Source: ABdhPJzMtlF7nhYWHxOpOE2s57xJ1kklQVe2pgO1HMHseMIyyqHhWmIL+FtcWJHKHECYmbsIhi9gUXoLFejHMeHps64=
X-Received: by 2002:a7b:c34b:: with SMTP id l11mr137167wmj.56.1641830542822;
 Mon, 10 Jan 2022 08:02:22 -0800 (PST)
MIME-Version: 1.0
References: <6D757C75-65B1-468B-842D-10410081A8E4@live.com>
In-Reply-To: <6D757C75-65B1-468B-842D-10410081A8E4@live.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 10 Jan 2022 17:02:10 +0100
X-Gmail-Original-Message-ID: <CAMj1kXETPO9iJoFm26v5gof2xpakHkvz3YV4ahet7BLjX5m5FQ@mail.gmail.com>
Message-ID: <CAMj1kXETPO9iJoFm26v5gof2xpakHkvz3YV4ahet7BLjX5m5FQ@mail.gmail.com>
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
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 10 Jan 2022 at 16:37, Aditya Garg <gargaditya08@live.com> wrote:
>
> On 10th of December, I had reported this bug but still haven't got any response from the maintainers. As a result I am sending it again. Consider the fact that is is a severe bug as it causes kernels to not boot at all and results in panics on T2 Macs.
>
> On enabling EFI runtime services on Macs with the T2 security chip, kernel fails to boot due panics in the T2 security chip.

I don't see how panics in the T2 security chip could be blamed on the
EFI runtime services layer in Linux.

As far as I can tell, what we need here is a DMI quirk that just
disables EFI runtime support on these platforms.

> Using efi=noruntine (or noefi) as a kernel parameter seems to fix the issue. Also, making NVRAM read-only makes kernels boot. A fix for that would be appreciated.
>
> Link :- https://bugzilla.kernel.org/show_bug.cgi?id=215277
>
> We believe kernel only fails to boot if something is set up to write to nvram at boot, it can boot fine on a MacBookPro16,1 as long as I don't have anything writing to nvram (deleting and reading variables is fine).
>
> The t2 security chip handles nvram and loading bootloaders on these
> macs. Its bridgeOS had an update that was bundled with macOS Catalina
> (this can't be downgraded, and some computers shipped with macOS
> Catalina), that made writing to nvram from Linux cause an invalid
> opcode error and a frozen system:
>
> invalid opcode: 0000 [#1] PREEMPT SMP PTI
> CPU: 9 PID: 135 Comm: kworker/u24:2 Tainted: G S   U   C        5.16.0-rc4-00054-g6c3ecb47bb75-dirty #72
> Hardware name: Apple Inc. MacBookPro16,1/Mac-E1008331FDC96864, BIOS 1715.40.15.0.0 (iBridge: 19.16.10548.0.0,0) 10/03/2021
> Workqueue: efi_rts_wq efi_call_rts
> RIP: 0010:0xfffffffeefc46877
> Code: 8b 58 18 0f b6 0d e1 09 00 00 48 c1 e1 04 e8 30 03 00 00 48 89 05 d9 09 00 00 80 3d a2 09 00 00 01 75 09 48 c7 07 00 10 00 00 <0f> 0b 48 8b 05 a8 07 00 00 8b 40 08 48 83 c0 f0 48 89 07 48 c7 06
> RSP: 0018:ffff998d40513dd0 EFLAGS: 00010246
> RAX: ffff998d40513eb0 RBX: ffff998d43f17dd8 RCX: 0000000000000007
> RDX: ffff998d43f17dc8 RSI: ffff998d43f17dd8 RDI: ffff998d43f17dc8
> RBP: ffff998d40513e00 R08: ffff998d43f17dd0 R09: ffff998d43f17dd8
> R10: ffff998d40513c80 R11: ffffffff9b4cabe8 R12: ffff998d43f17dc8
> R13: ffff998d43f17dd0 R14: 0000000000000246 R15: 0000000000000048
> FS:  0000000000000000(0000) GS:ffff8cf8bec40000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f9133594374 CR3: 0000000100200005 CR4: 00000000003706e0
> Call Trace:
> <TASK>
> ? _printk+0x58/0x6f
> __efi_call+0x28/0x30
> efi_call_rts.cold+0x83/0x104
> process_one_work+0x219/0x3f0
> worker_thread+0x4d/0x3d0
> ? rescuer_thread+0x390/0x390
> kthread+0x15c/0x180
> ? set_kthread_struct+0x40/0x40
> ret_from_fork+0x22/0x30
> </TASK>
> Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp nft_compat amdgpu nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_counter nf_tables n
> sysimgblt fb_sys_fops cec crc16 intel_pch_thermal sbs ecdh_generic ecc rfkill apple_bl video acpi_tad mac_hid sbshc pkcs8_key_parser drm fuse crypto_user bpf_preload ip_tables x_tables crct10dif_pcl
> ---[ end trace 22f8aad91761cc4a ]---
> RIP: 0010:0xfffffffeefc46877
> Code: 8b 58 18 0f b6 0d e1 09 00 00 48 c1 e1 04 e8 30 03 00 00 48 89 05 d9 09 00 00 80 3d a2 09 00 00 01 75 09 48 c7 07 00 10 00 00 <0f> 0b 48 8b 05 a8 07 00 00 8b 40 08 48 83 c0 f0 48 89 07 48 c7 06
> RSP: 0018:ffff998d40513dd0 EFLAGS: 00010246
> RAX: ffff998d40513eb0 RBX: ffff998d43f17dd8 RCX: 0000000000000007
> RDX: ffff998d43f17dc8 RSI: ffff998d43f17dd8 RDI: ffff998d43f17dc8
> RBP: ffff998d40513e00 R08: ffff998d43f17dd0 R09: ffff998d43f17dd8
> R10: ffff998d40513c80 R11: ffffffff9b4cabe8 R12: ffff998d43f17dc8
> R13: ffff998d43f17dd0 R14: 0000000000000246 R15: 0000000000000048
> FS:  0000000000000000(0000) GS:ffff8cf8bec40000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f9133594374 CR3: 0000000100200005 CR4: 00000000003706e0
> BUG: kernel NULL pointer dereference, address: 0000000000000008
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0002) - not-present page
>
> This seems to be triggered by EFI_QUERY_VARIABLE_INFO here
>

This is interesting. QueryVariableInfo() was introduced in EFI 2.00,
and for a very long time, Intel MACs would claim to implement EFI 1.10
only. This means Linux would never attempt to use QueryVariableInfo()
on such platforms.

Can you please check your boot log which revision it claims to implement now?

Mine says

efi: EFI v1.10 by Apple

near the start of the kernel log.


 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/firmware/efi/runtime-wrappers.c#n220
> and within that section, the invalid opcode seems to be occurring in
> this bit of assembly:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/platform/efi/efi_stub_64.S
>

Ehm no. __efi_call() is just a trampoline to call into the firmware,
and the opcodes in question are firmware code not Linux code.
