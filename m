Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB1F2C2958
	for <lists+linux-efi@lfdr.de>; Tue, 24 Nov 2020 15:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388477AbgKXOWU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Tue, 24 Nov 2020 09:22:20 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:22080 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726663AbgKXOWU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 24 Nov 2020 09:22:20 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-254-hA5XXtmjPeW6Yg81jUCPrg-1; Tue, 24 Nov 2020 14:22:16 +0000
X-MC-Unique: hA5XXtmjPeW6Yg81jUCPrg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 24 Nov 2020 14:22:15 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 24 Nov 2020 14:22:15 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     linux-efi <linux-efi@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
CC:     "'matthew.garrett@nebula.com'" <matthew.garrett@nebula.com>,
        "'jk@ozlabs.org'" <jk@ozlabs.org>,
        'Ard Biesheuvel' <ardb@kernel.org>
Subject: Oops (probably) unmounting /oldroot/firmware/efi/efivars.
Thread-Topic: Oops (probably) unmounting /oldroot/firmware/efi/efivars.
Thread-Index: AdbCbM2Q6wdSIj4dRX6VFD+iYFiXew==
Date:   Tue, 24 Nov 2020 14:22:15 +0000
Message-ID: <5f31cde519b941308412b3849197ee7c@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

I've just updated to the head of Linus's tree (5.10-rc5) and got the following
'splat' during shutdown.

Userspace is Ubuntu 20.04.

rc4 rebooted fine.

I'll try to bisect - but it isn't quick.

	David

[   49.612436] kernel BUG at mm/slub.c:304!
[   49.616407] invalid opcode: 0000 [#1] SMP PTI
[   49.620806] CPU: 4 PID: 2044 Comm: (sd-umount) Not tainted 5.10.0-rc5+ #104
[   49.627816] Hardware name: Supermicro A1SAi/A1SRi, BIOS 1.1a 08/27/2015
[   49.634484] RIP: 0010:__slab_free+0x1c9/0x380
[   49.638874] Code: 41 5e 41 5f 5d c3 41 f7 46 08 00 0d 21 00 0f 85 f0 fe ff ff 4d 85 ed 0f 85 e7 fe ff ff 80 4c 24 5b 80 45 31 c0 e9 2a ff ff ff <0f> 0b 49 3b 5c 24 28 75 97 4c 89 c0 41 89 f0 44 89 fe 49 89 4c 24
[   49.659081] RSP: 0018:ffffa69740d17ce0 EFLAGS: 00010246
[   49.665694] RAX: ffff98444d492800 RBX: 0000000000080005 RCX: ffff98444d492000
[   49.674227] RDX: ffff98444d492000 RSI: fffff4a184352400 RDI: ffff984440043300
[   49.682735] RBP: ffffa69740d17d78 R08: 0000000000000001 R09: ffffffffb8a66024
[   49.691253] R10: ffff98444d492000 R11: 0000000000000001 R12: fffff4a184352400
[   49.699753] R13: ffff98444d492000 R14: ffff984440043300 R15: ffff98444d492000
[   49.708230] FS:  00007f353813d980(0000) GS:ffff9847afd00000(0000) knlGS:0000000000000000
[   49.717695] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   49.724823] CR2: 00007f3538f2f760 CR3: 000000010f6dc000 CR4: 00000000001006e0
[   49.733369] Call Trace:
[   49.737236]  ? xas_store+0x59/0x630
[   49.742141]  kfree+0x3af/0x400
[   49.746609]  ? up+0x37/0x70
[   49.750817]  ? efivarfs_destroy+0x24/0x30
[   49.756220]  efivarfs_destroy+0x24/0x30
[   49.761435]  ? efivarfs_kill_sb+0x30/0x30
[   49.766811]  __efivar_entry_iter+0xed/0x130
[   49.772355]  efivarfs_kill_sb+0x25/0x30
[   49.777540]  deactivate_locked_super+0x3b/0x80
[   49.783360]  deactivate_super+0x3e/0x50
[   49.788554]  cleanup_mnt+0x109/0x160
[   49.793471]  __cleanup_mnt+0x12/0x20
[   49.798388]  task_work_run+0x70/0xb0
[   49.803298]  exit_to_user_mode_prepare+0x14b/0x170
[   49.809450]  syscall_exit_to_user_mode+0x2d/0x150
[   49.815522]  do_syscall_64+0x45/0x90
[   49.820471]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   49.826912] RIP: 0033:0x7f3538ff32cb
[   49.831880] Code: 8b 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 95 8b 0c 00 f7 d8 64 89 01 48
[   49.853650] RSP: 002b:00007ffffcd5efc8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
[   49.862792] RAX: 0000000000000000 RBX: 0000557eb1ea4c00 RCX: 00007f3538ff32cb
[   49.871520] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000557eb1ea4c40
[   49.880260] RBP: 0000000000000000 R08: 0000000000008000 R09: 00007ffffcd5e3c0
[   49.889013] R10: 00007f353813d900 R11: 0000000000000206 R12: 0000000000000000
[   49.897778] R13: 0000000000000000 R14: 0000000000000001 R15: 0000557eb1e9fb60
[   49.906560] Modules linked in: nls_iso8859_1 dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua ipmi_ssif intel_powerclamp coretemp kvm_intel kvm joydev input_leds ipmi_si intel_cstate ipmi_devintf ipmi_msghandler mac_hid sch_fq_codel parport_pc ppdev lp parport ip_tables x_tables autofs4 btrfs blake2b_generic zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx libcrc32c xor raid6_pq raid1 raid0 multipath linear ast drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm drm gpio_ich ahci igb crct10dif_pclmul hid_generic crc32_pclmul i2c_i801 ghash_clmulni_intel aesni_intel libahci glue_helper crypto_simd i2c_ismt cryptd lpc_ich dca i2c_smbus usbhid i2c_algo_bit hid
[   49.983763] ---[ end trace b39f2c043c8d157b ]---

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

