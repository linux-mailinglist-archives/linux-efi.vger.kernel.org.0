Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3673946E311
	for <lists+linux-efi@lfdr.de>; Thu,  9 Dec 2021 08:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbhLIHXW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Dec 2021 02:23:22 -0500
Received: from mail-4325.protonmail.ch ([185.70.43.25]:46373 "EHLO
        mail-4325.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbhLIHXW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Dec 2021 02:23:22 -0500
Date:   Thu, 09 Dec 2021 07:19:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1639034387;
        bh=ylG/kDOZ8xUJwFkV+j+MTR5/1hNMGnn5X+gVJt2Eg7o=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=W9VPUvTslasBIQlfqO9EpuseZOpL4g/fHWByft8WWXJY012wDomaw3F/V7xIkqK6C
         H+qsQkkzxwj6Rz576uXp6zzbwpgAkkCgPyozuFLlLqgxniq2+9Vi2wxVDnCjViW97D
         eCjB7WDG09BfEx1C0IGQuZ4h4Ve0S5n9nySmqcLDvgISb9aohY6AN5dltr7W3jc9r4
         g1XN9rB8POWxxHST8YsNjDMSHqjc/uxxDkKeVkXvTHrNKAahSkp4iFpK09Yz7RPpUi
         kqYUKjYbXPEKPUGXKvEuPMHqCrouXMmS1VZ/uPmpRvjfRrzL32qv+29j5UwmAHbbw5
         kB2rsrL6jvOSQ==
To:     Aditya Garg <gargaditya08@live.com>
From:   Orlando Chamberlain <redecorating@protonmail.com>
Cc:     "matthew.garrett@nebula.com" <matthew.garrett@nebula.com>,
        "jk@ozlabs.org" <jk@ozlabs.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: Orlando Chamberlain <redecorating@protonmail.com>
Subject: Re: [BUG] Enabling EFI runtime services causes panics in the T2 security chip on Macs equipped with it.
Message-ID: <20211209071935.13996bb1@localhost>
In-Reply-To: <74ACDCF3-6996-4CB4-8899-A625D154FB0C@live.com>
References: <74ACDCF3-6996-4CB4-8899-A625D154FB0C@live.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 09 Dec 2021 18:05:35 +1100
"Aditya Garg" <gargaditya08@live.com> wrote:

> On enabling EFI runtime services on Macs with the T2 security chip,
> kernel fails to boot due panics in the T2 security chip. Using

I think it only fails to boot if something is set up to write to nvram
at boot, I can boot fine on a MacBookPro16,1 as long as I don't have
anything writing to nvram (deleting and reading variables is fine).

> efi=3Dnoruntine (or noefi) as a kernel parameter seems to fix the
> issue. Also, making NVRAM read-only makes kernels boot. A fix for
> that would be appreciated.
>=20
> Link :- https://bugzilla.kernel.org/show_bug.cgi?id=3D215277

The t2 security chip handles nvram and loading bootloaders on these
macs. Its bridgeOS had an update that was bundled with macOS Catalina
(this can't be downgraded, and some computers shipped with macOS
Catalina), that made writing to nvram from Linux cause an invalid
opcode error and a frozen system:

invalid opcode: 0000 [#1] PREEMPT SMP PTI
CPU: 9 PID: 135 Comm: kworker/u24:2 Tainted: G S   U   C        5.16.0-rc4-=
00054-g6c3ecb47bb75-dirty #72
Hardware name: Apple Inc. MacBookPro16,1/Mac-E1008331FDC96864, BIOS 1715.40=
.15.0.0 (iBridge: 19.16.10548.0.0,0) 10/03/2021
Workqueue: efi_rts_wq efi_call_rts
RIP: 0010:0xfffffffeefc46877
Code: 8b 58 18 0f b6 0d e1 09 00 00 48 c1 e1 04 e8 30 03 00 00 48 89 05 d9 =
09 00 00 80 3d a2 09 00 00 01 75 09 48 c7 07 00 10 00 00 <0f> 0b 48 8b 05 a=
8 07 00 00 8b 40 08 48 83 c0 f0 48 89 07 48 c7 06
RSP: 0018:ffff998d40513dd0 EFLAGS: 00010246
RAX: ffff998d40513eb0 RBX: ffff998d43f17dd8 RCX: 0000000000000007
RDX: ffff998d43f17dc8 RSI: ffff998d43f17dd8 RDI: ffff998d43f17dc8
RBP: ffff998d40513e00 R08: ffff998d43f17dd0 R09: ffff998d43f17dd8
R10: ffff998d40513c80 R11: ffffffff9b4cabe8 R12: ffff998d43f17dc8
R13: ffff998d43f17dd0 R14: 0000000000000246 R15: 0000000000000048
FS:  0000000000000000(0000) GS:ffff8cf8bec40000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9133594374 CR3: 0000000100200005 CR4: 00000000003706e0
Call Trace:
 <TASK>
 ? _printk+0x58/0x6f
 __efi_call+0x28/0x30
 efi_call_rts.cold+0x83/0x104
 process_one_work+0x219/0x3f0
 worker_thread+0x4d/0x3d0
 ? rescuer_thread+0x390/0x390
 kthread+0x15c/0x180
 ? set_kthread_struct+0x40/0x40
 ret_from_fork+0x22/0x30
 </TASK>
Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_rej=
ect_ipv4 xt_tcpudp nft_compat amdgpu nft_chain_nat nf_nat nf_conntrack nf_d=
efrag_ipv6 nf_defrag_ipv4 nft_counter nf_tables n
 sysimgblt fb_sys_fops cec crc16 intel_pch_thermal sbs ecdh_generic ecc rfk=
ill apple_bl video acpi_tad mac_hid sbshc pkcs8_key_parser drm fuse crypto_=
user bpf_preload ip_tables x_tables crct10dif_pcl
---[ end trace 22f8aad91761cc4a ]---
RIP: 0010:0xfffffffeefc46877
Code: 8b 58 18 0f b6 0d e1 09 00 00 48 c1 e1 04 e8 30 03 00 00 48 89 05 d9 =
09 00 00 80 3d a2 09 00 00 01 75 09 48 c7 07 00 10 00 00 <0f> 0b 48 8b 05 a=
8 07 00 00 8b 40 08 48 83 c0 f0 48 89 07 48 c7 06
RSP: 0018:ffff998d40513dd0 EFLAGS: 00010246
RAX: ffff998d40513eb0 RBX: ffff998d43f17dd8 RCX: 0000000000000007
RDX: ffff998d43f17dc8 RSI: ffff998d43f17dd8 RDI: ffff998d43f17dc8
RBP: ffff998d40513e00 R08: ffff998d43f17dd0 R09: ffff998d43f17dd8
R10: ffff998d40513c80 R11: ffffffff9b4cabe8 R12: ffff998d43f17dc8
R13: ffff998d43f17dd0 R14: 0000000000000246 R15: 0000000000000048
FS:  0000000000000000(0000) GS:ffff8cf8bec40000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9133594374 CR3: 0000000100200005 CR4: 00000000003706e0
BUG: kernel NULL pointer dereference, address: 0000000000000008
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page

This seems to be triggered by EFI_QUERY_VARIABLE_INFO here
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/firmware/efi/runtime-wrappers.c#n220
and within that section, the invalid opcode seems to be occurring in
this bit of assembly:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/x86/platform/efi/efi_stub_64.S

printing efi_call_virt's arguments with
pr_err("1: %d, 2: %d, 3: %d, 4: %d", *(u32 *)arg1, (u64 *)arg2, (u64 *)arg3=
, (u64 *)arg4);
gets me "1: 7, 2: -2079343160, 3: -2079343152, 4: -2079343144"


--=20

