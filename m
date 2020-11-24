Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C9B2C2967
	for <lists+linux-efi@lfdr.de>; Tue, 24 Nov 2020 15:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388889AbgKXOX4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Nov 2020 09:23:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:52910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732297AbgKXOX4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Nov 2020 09:23:56 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6C0D20674;
        Tue, 24 Nov 2020 14:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606227835;
        bh=K0ChhgcqjvZk4pLbJHn6/T2mDks1alGpUxBsPiZ4Q5U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xGatQUCLZNBkpcBs19hgP9KqDWD4L9/pnPszQOAwVeT8nrkhQK2KCd71/aRbF098t
         zxMAwzVwDb1pubWDcXS7xlDBuyoCTiTnwvBUaEcyAxPGQNPay6xNcsye42SV/slAyr
         yN6lqa/cf2AN6n3W+grYHtvBKzBNyj+PA5g5AxjI=
Received: by mail-oi1-f177.google.com with SMTP id s18so22795067oih.1;
        Tue, 24 Nov 2020 06:23:54 -0800 (PST)
X-Gm-Message-State: AOAM5315ppXYAr+uoPV3fQ5fo2LFmzVeFLHP+LU96T0Ob6+shjcVdpx0
        a24M3HszIRgqFDyIjhoANm/kx1kXmf8wubXC8/U=
X-Google-Smtp-Source: ABdhPJxSBpIJMspg/q9xENVVeIt3Fns8O1rxX3MfjMZuamohTwJxvJZD3hOod4E0DTuf8RwTfk95Sx2lIYedws9rOzg=
X-Received: by 2002:aca:5c82:: with SMTP id q124mr2876043oib.33.1606227834136;
 Tue, 24 Nov 2020 06:23:54 -0800 (PST)
MIME-Version: 1.0
References: <5f31cde519b941308412b3849197ee7c@AcuMS.aculab.com>
In-Reply-To: <5f31cde519b941308412b3849197ee7c@AcuMS.aculab.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 24 Nov 2020 15:23:43 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHhetomAx4Kd5McnvZQev9j1d-C1Og7h+J7V009WTiwxA@mail.gmail.com>
Message-ID: <CAMj1kXHhetomAx4Kd5McnvZQev9j1d-C1Og7h+J7V009WTiwxA@mail.gmail.com>
Subject: Re: Oops (probably) unmounting /oldroot/firmware/efi/efivars.
To:     David Laight <David.Laight@aculab.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "matthew.garrett@nebula.com" <matthew.garrett@nebula.com>,
        "jk@ozlabs.org" <jk@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 24 Nov 2020 at 15:22, David Laight <David.Laight@aculab.com> wrote:
>
> I've just updated to the head of Linus's tree (5.10-rc5) and got the foll=
owing
> 'splat' during shutdown.
>
> Userspace is Ubuntu 20.04.
>
> rc4 rebooted fine.
>
> I'll try to bisect - but it isn't quick.
>

Surely caused by

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/f=
s/efivarfs?id=3Dfe5186cf12e30facfe261e9be6c7904a170bd822



>
> [   49.612436] kernel BUG at mm/slub.c:304!
> [   49.616407] invalid opcode: 0000 [#1] SMP PTI
> [   49.620806] CPU: 4 PID: 2044 Comm: (sd-umount) Not tainted 5.10.0-rc5+=
 #104
> [   49.627816] Hardware name: Supermicro A1SAi/A1SRi, BIOS 1.1a 08/27/201=
5
> [   49.634484] RIP: 0010:__slab_free+0x1c9/0x380
> [   49.638874] Code: 41 5e 41 5f 5d c3 41 f7 46 08 00 0d 21 00 0f 85 f0 f=
e ff ff 4d 85 ed 0f 85 e7 fe ff ff 80 4c 24 5b 80 45 31 c0 e9 2a ff ff ff <=
0f> 0b 49 3b 5c 24 28 75 97 4c 89 c0 41 89 f0 44 89 fe 49 89 4c 24
> [   49.659081] RSP: 0018:ffffa69740d17ce0 EFLAGS: 00010246
> [   49.665694] RAX: ffff98444d492800 RBX: 0000000000080005 RCX: ffff98444=
d492000
> [   49.674227] RDX: ffff98444d492000 RSI: fffff4a184352400 RDI: ffff98444=
0043300
> [   49.682735] RBP: ffffa69740d17d78 R08: 0000000000000001 R09: ffffffffb=
8a66024
> [   49.691253] R10: ffff98444d492000 R11: 0000000000000001 R12: fffff4a18=
4352400
> [   49.699753] R13: ffff98444d492000 R14: ffff984440043300 R15: ffff98444=
d492000
> [   49.708230] FS:  00007f353813d980(0000) GS:ffff9847afd00000(0000) knlG=
S:0000000000000000
> [   49.717695] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   49.724823] CR2: 00007f3538f2f760 CR3: 000000010f6dc000 CR4: 000000000=
01006e0
> [   49.733369] Call Trace:
> [   49.737236]  ? xas_store+0x59/0x630
> [   49.742141]  kfree+0x3af/0x400
> [   49.746609]  ? up+0x37/0x70
> [   49.750817]  ? efivarfs_destroy+0x24/0x30
> [   49.756220]  efivarfs_destroy+0x24/0x30
> [   49.761435]  ? efivarfs_kill_sb+0x30/0x30
> [   49.766811]  __efivar_entry_iter+0xed/0x130
> [   49.772355]  efivarfs_kill_sb+0x25/0x30
> [   49.777540]  deactivate_locked_super+0x3b/0x80
> [   49.783360]  deactivate_super+0x3e/0x50
> [   49.788554]  cleanup_mnt+0x109/0x160
> [   49.793471]  __cleanup_mnt+0x12/0x20
> [   49.798388]  task_work_run+0x70/0xb0
> [   49.803298]  exit_to_user_mode_prepare+0x14b/0x170
> [   49.809450]  syscall_exit_to_user_mode+0x2d/0x150
> [   49.815522]  do_syscall_64+0x45/0x90
> [   49.820471]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   49.826912] RIP: 0033:0x7f3538ff32cb
> [   49.831880] Code: 8b 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1=
e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 95 8b 0c 00 f7 d8 64 89 01 48
> [   49.853650] RSP: 002b:00007ffffcd5efc8 EFLAGS: 00000206 ORIG_RAX: 0000=
0000000000a6
> [   49.862792] RAX: 0000000000000000 RBX: 0000557eb1ea4c00 RCX: 00007f353=
8ff32cb
> [   49.871520] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000557eb=
1ea4c40
> [   49.880260] RBP: 0000000000000000 R08: 0000000000008000 R09: 00007ffff=
cd5e3c0
> [   49.889013] R10: 00007f353813d900 R11: 0000000000000206 R12: 000000000=
0000000
> [   49.897778] R13: 0000000000000000 R14: 0000000000000001 R15: 0000557eb=
1e9fb60
> [   49.906560] Modules linked in: nls_iso8859_1 dm_multipath scsi_dh_rdac=
 scsi_dh_emc scsi_dh_alua ipmi_ssif intel_powerclamp coretemp kvm_intel kvm=
 joydev input_leds ipmi_si intel_cstate ipmi_devintf ipmi_msghandler mac_hi=
d sch_fq_codel parport_pc ppdev lp parport ip_tables x_tables autofs4 btrfs=
 blake2b_generic zstd_compress raid10 raid456 async_raid6_recov async_memcp=
y async_pq async_xor async_tx libcrc32c xor raid6_pq raid1 raid0 multipath =
linear ast drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt=
 fb_sys_fops cec drm_ttm_helper ttm drm gpio_ich ahci igb crct10dif_pclmul =
hid_generic crc32_pclmul i2c_i801 ghash_clmulni_intel aesni_intel libahci g=
lue_helper crypto_simd i2c_ismt cryptd lpc_ich dca i2c_smbus usbhid i2c_alg=
o_bit hid
> [   49.983763] ---[ end trace b39f2c043c8d157b ]---
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)
>
