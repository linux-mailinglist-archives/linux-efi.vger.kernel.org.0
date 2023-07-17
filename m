Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A3375658E
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jul 2023 15:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjGQNyo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Jul 2023 09:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjGQNyg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Jul 2023 09:54:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90584D1
        for <linux-efi@vger.kernel.org>; Mon, 17 Jul 2023 06:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689602025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p3i0dSGbiKzogmKY6ARysqp2LATdfX4bwkE/7izR20w=;
        b=Cf6+Ejj592qojCtRDl/f9iO9JlzG9P6QyRYoWEKLs9KD0k2aZD05s/nulmCkKLv/Xvn23V
        SRVa0XxkKUNClDqWnBB/ip/pfNEGsazRnUM0eIAyUy+dPlvXYOsTsOeMjzNgR09FP4XCSo
        +13gU/6lwPG1USin+Cujeqn4ftpWrNg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-OJLHtV7sOeWlCJtnpFBDuQ-1; Mon, 17 Jul 2023 09:53:44 -0400
X-MC-Unique: OJLHtV7sOeWlCJtnpFBDuQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-50bf847b267so3403667a12.3
        for <linux-efi@vger.kernel.org>; Mon, 17 Jul 2023 06:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689602023; x=1692194023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3i0dSGbiKzogmKY6ARysqp2LATdfX4bwkE/7izR20w=;
        b=YmWH1zQ+lPOcVWSpABEYgfOuNHrDcC3X5bmsH06kHI5PnQRd70D8zCYcVcKMrxrU6j
         zrkxRzObN+PyUVJOELqu5IYLhG+9EqAWtXtwV7uZs15NjgKkfD0zBTAIxaeVguR17CVy
         QQhWAdJFPATVuCPhhQ3DLuUzSNrmv1e0jqn8+HdHdXYTkIMTP9aSQZeKZQSAulqAJ4Ix
         fl1e2f2e6mCFCbZosS9Yrd6rTuYaD088pacgOSC4CXdyS+nm++8ITmqN3S2KOd2luENC
         xgXLUN2hz8NnqGrCB7bFbXU0CpGNmkKWLC+L2uXF6QfSmkoig7uBLFv51FSXbf4ahmph
         mgrQ==
X-Gm-Message-State: ABy/qLYeCmaKdotNSSK9r62cd709Ak0BhS7Ijodf7BZalKMyW2DoAA3I
        MCkhnT2goBzG7/QT+vR69pLSA1/AmvRZEEo506Eqq09q5sOTkdQFeTRXsGLvDordfj8p7vW8ryV
        NXyU7XpnniHbdCPws6F/KFkYKH4vXgyC0gkry
X-Received: by 2002:a05:6402:326:b0:51d:f3a6:5eef with SMTP id q6-20020a056402032600b0051df3a65eefmr13096094edw.36.1689602023280;
        Mon, 17 Jul 2023 06:53:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHGz4rBrEnd9IS/HVmXnkyPKZ7qRRL8cSbgYCYpRD+9niQxj00ALtefX18LBOoVRrYOv2Fy4I9zvOk7zeO28uo=
X-Received: by 2002:a05:6402:326:b0:51d:f3a6:5eef with SMTP id
 q6-20020a056402032600b0051df3a65eefmr13096075edw.36.1689602022907; Mon, 17
 Jul 2023 06:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072043.24439-1-ltao@redhat.com> <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
In-Reply-To: <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
From:   Tao Liu <ltao@redhat.com>
Date:   Mon, 17 Jul 2023 21:53:06 +0800
Message-ID: <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, bhe@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Borislav,

On Thu, Jul 13, 2023 at 6:05=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Thu, Jun 01, 2023 at 03:20:44PM +0800, Tao Liu wrote:
> >  arch/x86/kernel/machine_kexec_64.c | 35 ++++++++++++++++++++++++++----
> >  1 file changed, 31 insertions(+), 4 deletions(-)
>
> Ok, pls try this totally untested thing.
>
> Thx.
>
> ---
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/se=
v.c
> index 09dc8c187b3c..fefe27b2af85 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -404,13 +404,20 @@ void sev_enable(struct boot_params *bp)
>         if (bp)
>                 bp->cc_blob_address =3D 0;
>
> +       /* Check for the SME/SEV support leaf */
> +       eax =3D 0x80000000;
> +       ecx =3D 0;
> +       native_cpuid(&eax, &ebx, &ecx, &edx);
> +       if (eax < 0x8000001f)
> +               return;
> +
>         /*
>          * Setup/preliminary detection of SNP. This will be sanity-checke=
d
>          * against CPUID/MSR values later.
>          */
>         snp =3D snp_init(bp);
>
> -       /* Check for the SME/SEV support leaf */
> +       /* Recheck the SME/SEV support leaf */
>         eax =3D 0x80000000;
>         ecx =3D 0;
>         native_cpuid(&eax, &ebx, &ecx, &edx);
>
Thanks a lot for the patch above! Sorry for the late response. I have
compiled and tested it locally against 6.5.0-rc1, though it can pass
the early stage of kexec kernel bootup , however the kernel will panic
occasionally later. The test machine is the one with Intel Atom
x6425RE cpu which encountered the page fault issue of missing efi
config table.

...snip...
[   21.360763]  nvme0n1: p1 p2 p3
[   21.364207] igc 0000:03:00.0: PTM enabled, 4ns granularity
[   21.421097] pps pps1: new PPS source ptp1
[   21.425396] igc 0000:03:00.0 (unnamed net_device) (uninitialized): PHC a=
dded
[   21.457005] igc 0000:03:00.0: 4.000 Gb/s available PCIe bandwidth
(5.0 GT/s PCIe x1 link)
[   21.465210] igc 0000:03:00.0 eth1: MAC: ...snip...
[   21.473424] igc 0000:03:00.0 enp3s0: renamed from eth1
[   21.479446] BUG: kernel NULL pointer dereference, address: 0000000000000=
008
[   21.486405] #PF: supervisor read access in kernel mode
[   21.491519] mmc1: Failed to initialize a non-removable card
[   21.491538] #PF: error_code(0x0000) - not-present page
[   21.502229] PGD 0 P4D 0
[   21.504773] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   21.509133] CPU: 3 PID: 402 Comm: systemd-udevd Not tainted 6.5.0-rc1+ #=
1
[   21.515905] Hardware name: ...snip...
[   21.522851] RIP: 0010:kernfs_dop_revalidate+0x2b/0x120
[   21.527995] Code: 1f 44 00 00 83 e6 40 0f 85 07 01 00 00 41 55 41
54 55 53 48 8b 47 30 48 89 fb 48 85 c0 0f 84 a2 00 00 00 48 8b a87
[   21.546680] RSP: 0018:ffffb656405abbf0 EFLAGS: 00010282
[   21.551898] RAX: ffff921c761a5d40 RBX: ffff921c76164000 RCX: 00000000000=
00001
[   21.559018] RDX: ffff921c76164038 RSI: 0000000000000000 RDI: ffff921c761=
64000
[   21.566137] RBP: 0000000000000000 R08: 0000000000000006 R09: ffff921c022=
72d80
[   21.573254] R10: ffff8d909b919a89 R11: 0000000000000000 R12: ffff921c022=
72d80
[   21.580367] R13: ffffb656405abca0 R14: 0000000000000000 R15: 00000000000=
00000
[   21.587489] FS:  00007f75796bf540(0000) GS:ffff922360580000(0000)
knlGS:0000000000000000
[   21.595557] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   21.601291] CR2: 0000000000000008 CR3: 000000011615c000 CR4: 00000000003=
50ee0
[   21.608405] Call Trace:
[   21.610864]  <TASK>
[   21.612983]  ? __die+0x1f/0x70
[   21.616053]  ? page_fault_oops+0x75/0x170
[   21.620062]  ? xa_load+0x87/0xe0
[   21.623299]  ? exc_page_fault+0x67/0x140
[   21.627225]  ? asm_exc_page_fault+0x22/0x30
[   21.631415]  ? kernfs_dop_revalidate+0x2b/0x120
[   21.635962]  lookup_fast+0x75/0xf0
[   21.639367]  walk_component+0x1f/0x150
[   21.643125]  path_lookupat+0x6a/0x1a0
[   21.646789]  filename_lookup+0xd0/0x1d0
[   21.650630]  ? __check_object_size.part.0+0x5e/0x130
[   21.655595]  ? __check_object_size.part.0+0x5e/0x130
[   21.660552]  vfs_statx+0x8c/0x160
[   21.663880]  vfs_fstatat+0x51/0x70
[   21.667286]  __do_sys_newfstatat+0x26/0x60
[   21.671388]  ? syscall_trace_enter.isra.0+0x9a/0x1a0
[   21.676349]  do_syscall_64+0x59/0x90
[   21.679926]  ? exit_to_user_mode_prepare+0xbb/0xd0
[   21.684719]  ? syscall_exit_to_user_mode+0x12/0x30
[   21.689507]  ? do_syscall_64+0x68/0x90
[   21.693262]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   21.698310] RIP: 0033:0x7f757a2ce12e
[   21.701893] Code: 48 89 f2 b9 00 01 00 00 48 89 fe bf 9c ff ff ff
e9 07 00 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 41 89 ca b8 06 019
[   21.720570] RSP: 002b:00007ffc38e4ae98 EFLAGS: 00000202 ORIG_RAX:
0000000000000106
[   21.728123] RAX: ffffffffffffffda RBX: 00007ffc38e4b250 RCX: 00007f757a2=
ce12e
[   21.735242] RDX: 00007ffc38e4aef0 RSI: 00005566acdd2c20 RDI: 00000000fff=
fff9c
[   21.742363] RBP: 00007ffc38e4afc0 R08: 0000000000000000 R09: 00000000000=
00000
[   21.749484] R10: 0000000000000100 R11: 0000000000000202 R12: 00000000000=
00000
[   21.756600] R13: 00007ffc38e4b038 R14: 00005566acdd2c20 R15: 00007ffc38e=
4b250
[   21.763721]  </TASK>
[   21.765920] Modules linked in: i2c_algo_bit drm_buddy ttm intel_gtt
drm_display_helper drm_kms_helper nvme igc drm sdhci_pci crct10e
[   21.799743] CR2: 0000000000000008
[   21.803061] ---[ end trace 0000000000000000 ]---
[   21.807679] RIP: 0010:kernfs_dop_revalidate+0x2b/0x120
[   21.812819] Code: 1f 44 00 00 83 e6 40 0f 85 07 01 00 00 41 55 41
54 55 53 48 8b 47 30 48 89 fb 48 85 c0 0f 84 a2 00 00 00 48 8b a87
[   21.831505] RSP: 0018:ffffb656405abbf0 EFLAGS: 00010282
[   21.836724] RAX: ffff921c761a5d40 RBX: ffff921c76164000 RCX: 00000000000=
00001
[   21.843844] RDX: ffff921c76164038 RSI: 0000000000000000 RDI: ffff921c761=
64000
[   21.850963] RBP: 0000000000000000 R08: 0000000000000006 R09: ffff921c022=
72d80
[   21.858082] R10: ffff8d909b919a89 R11: 0000000000000000 R12: ffff921c022=
72d80
[   21.865201] R13: ffffb656405abca0 R14: 0000000000000000 R15: 00000000000=
00000
[   21.872321] FS:  00007f75796bf540(0000) GS:ffff922360580000(0000)
knlGS:0000000000000000
[   21.880390] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   21.886123] CR2: 0000000000000008 CR3: 000000011615c000 CR4: 00000000003=
50ee0
[   21.893233] Kernel panic - not syncing: Fatal exception
[   21.898486] Kernel Offset: 0x19e00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   21.909231] ---[ end Kernel panic - not syncing: Fatal exception ]---

The stack trace may not be the same all the time, I didn't dive deep
into the root cause, but it looks to me the patch will cause an
unknown issue. Also I tested the patch on kernel-5.14.0-318.el9, it
will encounter a similar issue, because the timing for every panic is
nearly the same.

...snip...
[   19.521883] nvme 0000:04:00.0: platform quirk: setting simple suspend
[   19.522030] nvme nvme0: pci function 0000:04:00.0
[   19.526540] pps pps0: new PPS source ptp0
[   19.526641] igc 0000:02:00.0 (unnamed net_device) (uninitialized): PHC a=
dded
[   19.550702] usbcore: registered new interface driver cdc_ncm
[   19.551424] igc 0000:02:00.0: 4.000 Gb/s available PCIe bandwidth
(5.0 GT/s PCIe x1 link)
[   19.551429] igc 0000:02:00.0 eth0: MAC: ...snip...
[   19.551660] igc 0000:03:00.0: PTM enabled, 4ns granularity
[   19.571901] BUG: unable to handle page fault for address: ffff90e3b676ac=
38
[   19.571906] #PF: supervisor read access in kernel mode
[   19.571907] #PF: error_code(0x0000) - not-present page
[   19.571910] PGD 3f401067 P4D 3f401067 PUD 3f40c067 PMD 176711063
[   19.571915] BAD
[   19.571917] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   19.571920] CPU: 1 PID: 447 Comm: gzip Not tainted 5.14.0+ #2
[   19.571923] Hardware name: ...snip...
[   19.571924] RIP: 0010:vma_interval_tree_remove+0x16a/0x2c0
[   19.571933] Code: e0 fc 48 83 fa 03 76 43 48 8b 48 10 48 8b 70 08
48 8b 50 b0 4c 8b 40 40 48 2b 50 a8 48 c1 ea 0c 4a 8d 54 02 ff 489
[   19.571935] RSP: 0018:ffffb05d40a2bd20 EFLAGS: 00010282
[   19.571938] RAX: ffff90e3550f2d08 RBX: ffff90e34bcc46e0 RCX: ffff90e3b67=
6ac20
[   19.571940] RDX: 0000000000000027 RSI: ffff90e355293df0 RDI: 00000000000=
00000
[   19.571941] RBP: ffff90e35528a3a0 R08: 0000000000000000 R09: 00000000000=
00000
[   19.571943] R10: ffffb05d40a2bd00 R11: 00007fffec14c000 R12: ffff90e3552=
8a3f8
[   19.571944] R13: ffffb05d40a2bda0 R14: 0000000000000000 R15: ffff90e3552=
93000
[   19.571946] FS:  0000000000000000(0000) GS:ffff90eaa0480000(0000)
knlGS:0000000000000000
[   19.571949] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.571951] CR2: ffff90e3b6711b50 CR3: 0000000113ed8000 CR4: 00000000003=
50ee0
[   19.571953] Call Trace:
[   19.571956]  <TASK>
[   19.571959]  unlink_file_vma+0x41/0x60
[   19.571963]  free_pgtables+0xa0/0xe0
[   19.571966]  exit_mmap+0xb3/0x1e0
[   19.571972]  mmput+0x58/0x140
[   19.571976]  exit_mm+0xb2/0x110
[   19.571980]  do_exit+0x210/0x4c0
[   19.571982]  do_group_exit+0x2d/0x90
[   19.571985]  __x64_sys_exit_group+0x14/0x20
[   19.571988]  do_syscall_64+0x59/0x90
[   19.571993]  ? exc_page_fault+0x64/0x140
[   19.571996]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   19.572000] RIP: 0033:0x7fac2abd3a4d
[   19.572003] Code: Unable to access opcode bytes at RIP 0x7fac2abd3a23.
[   19.572004] RSP: 002b:00007fffec0e5808 EFLAGS: 00000246 ORIG_RAX:
00000000000000e7
[   19.572006] RAX: ffffffffffffffda RBX: 00007fac2acb19e0 RCX: 00007fac2ab=
d3a4d
[   19.572008] RDX: 00000000000000e7 RSI: ffffffffffffff80 RDI: 00000000000=
00000
[   19.572009] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00020
[   19.572011] R10: 00007fffec0e56b0 R11: 0000000000000246 R12: 00007fac2ac=
b19e0
[   19.572012] R13: 00007fac2acb6f00 R14: 0000000000000001 R15: 00007fac2ac=
b6ee8
[   19.572015]  </TASK>
[   19.572016] Modules linked in: cdc_ncm nvme cqhci cdc_ether usbnet
nvme_core sdhci uas nvme_common ghash_clmulni_intel usb_storage e
[   19.572040] CR2: ffff90e3b676ac38
[   19.572043] ---[ end trace 4abd4ff8e3f54f71 ]---
[   19.572044] RIP: 0010:vma_interval_tree_remove+0x16a/0x2c0
[   19.572048] Code: e0 fc 48 83 fa 03 76 43 48 8b 48 10 48 8b 70 08
48 8b 50 b0 4c 8b 40 40 48 2b 50 a8 48 c1 ea 0c 4a 8d 54 02 ff 489
[   19.572050] RSP: 0018:ffffb05d40a2bd20 EFLAGS: 00010282
[   19.572052] RAX: ffff90e3550f2d08 RBX: ffff90e34bcc46e0 RCX: ffff90e3b67=
6ac20
[   19.572053] RDX: 0000000000000027 RSI: ffff90e355293df0 RDI: 00000000000=
00000
[   19.572054] RBP: ffff90e35528a3a0 R08: 0000000000000000 R09: 00000000000=
00000
[   19.572056] R10: ffffb05d40a2bd00 R11: 00007fffec14c000 R12: ffff90e3552=
8a3f8
[   19.572057] R13: ffffb05d40a2bda0 R14: 0000000000000000 R15: ffff90e3552=
93000
[   19.572058] FS:  0000000000000000(0000) GS:ffff90eaa0480000(0000)
knlGS:0000000000000000
[   19.572060] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.572062] CR2: ffff90e3b6711b50 CR3: 0000000113ed8000 CR4: 00000000003=
50ee0
[   19.572064] Kernel panic - not syncing: Fatal exception
[   19.572840] BUG: unable to handle page fault for address: ffff90e3b6767b=
48
[   19.971622] #PF: supervisor read access in kernel mode
[   19.971624] #PF: error_code(0x0000) - not-present page
[   19.971626] PGD 3f401067 P4D 3f401067 PUD 3f40c067 PMD 176711063
[   19.971631] BAD
[   19.971632] Oops: 0000 [#2] PREEMPT SMP NOPTI
[   19.971634] CPU: 0 PID: 445 Comm: systemd-vconsol Tainted: G      D
          -------  ---  5.14.0+ #2
[   19.971638] Hardware name: ...snip...
[   19.971639] RIP: 0010:__rb_insert_augmented+0x77/0x1b0
[   19.971645] Code: 89 63 10 48 89 5f 08 4d 85 e4 74 0b 48 89 d8 48
83 c8 01 49 89 04 24 48 8b 03 48 89 07 48 89 3b 48 83 f8 03 76 5d8
[   19.971648] RSP: 0018:ffffb05d408e7c50 EFLAGS: 00010282
[   19.971650] RAX: ffff90e3b6767b38 RBX: ffff90e3550f1798 RCX: 00000000000=
00019
[   19.971652] RDX: ffffffffad5180f0 RSI: ffff90e35527eb38 RDI: ffff90e3552=
7eb38
[   19.971653] RBP: ffff90e35527eb38 R08: ffff90e35527eae0 R09: 00000000000=
000e8
[   19.971655] R10: 0000000008000075 R11: 0000000000000000 R12: 00000000000=
00000
[   19.971656] R13: ffff90e34bcc6310 R14: ffff90e35527e750 R15: ffff90e3552=
7eae0
[   19.971658] FS:  00007fc4586d1380(0000) GS:ffff90eaa0400000(0000)
knlGS:0000000000000000
[   19.971660] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.971662] CR2: ffff90e3b6711b38 CR3: 0000000115054000 CR4: 00000000003=
50ef0
[   19.971664] Call Trace:
[   19.971666]  <TASK>
[   19.971667]  ? vmacache_find+0xb0/0xb0
[   19.971672]  dup_mmap+0x23d/0x520
[   19.971677]  dup_mm+0x60/0x100
[   19.971680]  copy_process+0xc09/0x1680
[   19.971684]  kernel_clone+0x98/0x3f0
[   19.971688]  __do_sys_clone+0x72/0xa0
[   19.971692]  do_syscall_64+0x59/0x90
[   19.971695]  ? syscall_exit_to_user_mode+0x12/0x30
[   19.971698]  ? do_syscall_64+0x68/0x90
[   19.971701]  ? syscall_exit_to_user_mode+0x12/0x30
[   19.971703]  ? do_syscall_64+0x68/0x90
[   19.971706]  ? do_syscall_64+0x68/0x90
[   19.971708]  ? exc_page_fault+0x64/0x140
[   19.971710]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   19.971714] RIP: 0033:0x7fc45930d9d7
[   19.971716] Code: 00 00 00 f3 0f 1e fa 64 48 8b 04 25 10 00 00 00
45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 000
[   19.971718] RSP: 002b:00007ffca4fb03d8 EFLAGS: 00000246 ORIG_RAX:
0000000000000038
[   19.971721] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fc4593=
0d9d7
[   19.971723] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000012=
00011
[   19.971724] RBP: 0000000000000000 R08: 0000000000000000 R09: fffffffffff=
ffe88
[   19.971725] R10: 00007fc4586d1650 R11: 0000000000000246 R12: 00000000000=
00003
[   19.971727] R13: 00007ffca4fb0590 R14: 0000000000000040 R15: 00007ffca4f=
b0510
[   19.971730]  </TASK>
[   19.971731] Modules linked in: cdc_ncm nvme cqhci cdc_ether usbnet
nvme_core sdhci uas nvme_common ghash_clmulni_intel usb_storage e
[   19.971749] CR2: ffff90e3b6767b48
[   19.971750] ---[ end trace 4abd4ff8e3f54f72 ]---
[   19.971751] BUG: unable to handle page fault for address: ffff90e3b674ee=
f0
[   19.971752] RIP: 0010:vma_interval_tree_remove+0x16a/0x2c0
[   19.971753] #PF: supervisor read access in kernel mode
[   19.971755] #PF: error_code(0x0000) - not-present page
[   19.971756] Code: e0 fc 48 83 fa 03 76 43 48 8b 48 10 48 8b 70 08
48 8b 50 b0 4c 8b 40 40 48 2b 50 a8 48 c1 ea 0c 4a 8d 54 02 ff 489
[   19.971757] PGD 3f401067 P4D 3f401067
[   19.971758] RSP: 0018:ffffb05d40a2bd20 EFLAGS: 00010282
[   19.971759] PUD 3f40c067
[   19.971760]
[   19.971761] PMD 176711063
[   19.971761] RAX: ffff90e3550f2d08 RBX: ffff90e34bcc46e0 RCX: ffff90e3b67=
6ac20
[   19.971763] BAD
[   19.971763] RDX: 0000000000000027 RSI: ffff90e355293df0 RDI: 00000000000=
00000
[   19.971764] RBP: ffff90e35528a3a0 R08: 0000000000000000 R09: 00000000000=
00000
[   19.971764] Oops: 0000 [#3] PREEMPT SMP NOPTI
[   19.971766] R10: ffffb05d40a2bd00 R11: 00007fffec14c000 R12: ffff90e3552=
8a3f8
[   19.971768] R13: ffffb05d40a2bda0 R14: 0000000000000000 R15: ffff90e3552=
93000
[   19.971767] CPU: 2 PID: 409 Comm: systemd-udevd Tainted: G      D
        -------  ---  5.14.0+ #2
[   19.971769] FS:  00007fc4586d1380(0000) GS:ffff90eaa0400000(0000)
knlGS:0000000000000000
[   19.971770] Hardware name: ...snip...
[   19.971772] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.971774] CR2: ffff90e3b6711b38 CR3: 0000000115054000 CR4: 00000000003=
50ef0
[   19.971772] RIP: 0010:inode_has_perm+0x33/0x50
[   19.971778] Code: 89 c9 f6 46 0d 02 75 37 48 63 05 08 99 04 01 48
8b 57 78 8b 7c 02 04 48 8b 46 38 48 85 c0 74 0a 48 63 15 f8 98 041
[   19.971780] RSP: 0018:ffffb05d4086fd08 EFLAGS: 00010282
[   19.971782] RAX: ffff90e3b674eed0 RBX: ffff90e3b674eed0 RCX: ffffb05d408=
6fd10
[   19.971784] RDX: 0000000000000010 RSI: ffff90e34be230b0 RDI: 00000000000=
00001
[   19.971786] RBP: ffffb05d4086fd58 R08: 0000000000000010 R09: ffffb05d408=
6fd10
[   19.971787] R10: 000000000000000c R11: 0000000000000000 R12: ffff90e34be=
230b0
[   19.971789] R13: ffff90e34357b0c0 R14: ffff90e354e47cc0 R15: 00000000000=
00000
[   19.971790] FS:  00007fd768238540(0000) GS:ffff90eaa0500000(0000)
knlGS:0000000000000000
[   19.971793] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.971795] CR2: ffff90e3b6711a70 CR3: 0000000115064000 CR4: 00000000003=
50ee0
[   19.971797] Call Trace:
[   19.971798]  <TASK>
[   19.971799]  selinux_inode_getattr+0x99/0xc0
[   19.971805]  security_inode_getattr+0x37/0x60
[   19.971808]  vfs_statx+0x9a/0x160
[   19.971813]  vfs_fstatat+0x51/0x70
[   19.971816]  __do_sys_newfstatat+0x26/0x60
[   19.971819]  ? __seccomp_filter+0x45/0x360
[   19.971823]  ? syscall_trace_enter.isra.0+0x9e/0x1d0
[   19.971828]  do_syscall_64+0x59/0x90
[   19.971831]  ? syscall_exit_to_user_mode+0x12/0x30
[   19.971833]  ? do_syscall_64+0x68/0x90
[   19.971836]  ? exit_to_user_mode_loop+0xb9/0x110
[   19.971839]  ? exit_to_user_mode_prepare+0xac/0xf0
[   19.971842]  ? syscall_exit_to_user_mode+0x12/0x30
[   19.971844]  ? do_syscall_64+0x68/0x90
[   19.971847]  ? do_syscall_64+0x68/0x90
[   19.971849]  ? sysvec_apic_timer_interrupt+0x3a/0x90
[   19.971852]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   19.971855] RIP: 0033:0x7fd768e4712e
[   19.971857] Code: 48 89 f2 b9 00 01 00 00 48 89 fe bf 9c ff ff ff
e9 07 00 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 41 89 ca b8 06 019
[   19.971859] RSP: 002b:00007ffdb9f648a8 EFLAGS: 00000206 ORIG_RAX:
0000000000000106
[   19.971862] RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007fd768e=
4712e
[   19.971863] RDX: 00007ffdb9f649c0 RSI: 00007fd768ec0f35 RDI: 00000000000=
0000c
[   19.971865] RBP: 00007ffdb9f64a90 R08: 000000000000ffff R09: 00000000000=
01001
[   19.971866] R10: 0000000000001000 R11: 0000000000000206 R12: 00000000000=
00007
[   19.971868] R13: 0000000000000000 R14: 0000000000000006 R15: 0000557c0e1=
ef200
[   19.971871]  </TASK>
[   19.971871] Modules linked in: cdc_ncm nvme cqhci cdc_ether usbnet
nvme_core sdhci uas nvme_common ghash_clmulni_intel usb_storage e
[   19.971887] CR2: ffff90e3b674eef0
[   19.971889] ---[ end trace 4abd4ff8e3f54f73 ]---
[   19.971889] BUG: unable to handle page fault for address: ffff90e3b677f4=
00
[   19.971892] #PF: supervisor read access in kernel mode
[   19.971890] RIP: 0010:vma_interval_tree_remove+0x16a/0x2c0
[   19.971893] #PF: error_code(0x0000) - not-present page
[   19.971895] PGD 3f401067
[   19.971895] Code: e0 fc 48 83 fa 03 76 43 48 8b 48 10 48 8b 70 08
48 8b 50 b0 4c 8b 40 40 48 2b 50 a8 48 c1 ea 0c 4a 8d 54 02 ff 489
[   19.971897] P4D 3f401067
[   19.971897] RSP: 0018:ffffb05d40a2bd20 EFLAGS: 00010282
[   19.971898] PUD 3f40c067 PMD 176711063
[   19.971899]
[   19.971900] RAX: ffff90e3550f2d08 RBX: ffff90e34bcc46e0 RCX: ffff90e3b67=
6ac20
[   19.971901] BAD
[   19.971902] RDX: 0000000000000027 RSI: ffff90e355293df0 RDI: 00000000000=
00000
[   19.971902] Oops: 0000 [#4] PREEMPT SMP NOPTI
[   19.971904] RBP: ffff90e35528a3a0 R08: 0000000000000000 R09: 00000000000=
00000
[   19.971905] R10: ffffb05d40a2bd00 R11: 00007fffec14c000 R12: ffff90e3552=
8a3f8
[   19.971905] CPU: 3 PID: 37 Comm: ksoftirqd/3 Tainted: G      D
     -------  ---  5.14.0+ #2
[   19.971906] R13: ffffb05d40a2bda0 R14: 0000000000000000 R15: ffff90e3552=
93000
[   19.971908] Hardware name: ...snip...
[   19.971908] FS:  00007fd768238540(0000) GS:ffff90eaa0500000(0000)
knlGS:0000000000000000
[   19.971911] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.971912] CR2: ffff90e3b6711a70 CR3: 0000000115064000 CR4: 00000000003=
50ee0
[   19.971910] RIP: 0010:rcu_segcblist_accelerate+0xed/0x130
[   19.971916] Code: 89 48 18 48 89 50 38 b8 01 00 00 00 c3 cc cc cc
cc 31 c0 c3 cc cc cc cc be 01 00 00 00 eb ae 0f 0b e9 2f ff ff ff4
[   19.971918] RSP: 0018:ffffb05d40233e38 EFLAGS: 00010097
[   19.971921] RAX: ffff90eaa05b1d58 RBX: ffff90eaa05b1cc0 RCX: ffff90e3b67=
7f400
[   19.971923] RDX: 00000000000002c4 RSI: 00000000000002c4 RDI: ffff90eaa05=
b1d58
[   19.971924] RBP: ffffffffaf1e97c0 R08: 0000000000000002 R09: 00000000440=
6f74b
[   19.971926] R10: 00000000ad580200 R11: ffffffffaee060c0 R12: 00000000000=
002c4
[   19.971927] R13: ffff90eaa05b1d58 R14: 0000000000000246 R15: 00000000000=
00008
[   19.971929] FS:  0000000000000000(0000) GS:ffff90eaa0580000(0000)
knlGS:0000000000000000
[   19.971932] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.971933] CR2: ffff90e3b6711bf8 CR3: 0000000102e74000 CR4: 00000000003=
50ee0
[   19.971935] Call Trace:
[   19.971937]  <TASK>
[   19.971937]  rcu_accelerate_cbs+0x56/0x80
[   19.971942]  rcu_core+0x319/0x460
[   19.971945]  ? sched_clock_cpu+0x9/0xb0
[   19.971949]  __do_softirq+0xc7/0x2b3
[   19.971954]  ? find_next_bit+0x10/0x10
[   19.971956]  run_ksoftirqd+0x1e/0x30
[   19.971959]  smpboot_thread_fn+0xd5/0x1d0
[   19.971962]  kthread+0xd7/0x100
[   19.971965]  ? kthread_complete_and_exit+0x20/0x20
[   19.971968]  ret_from_fork+0x1f/0x30
[   19.971973]  </TASK>
[   19.971974] Modules linked in: cdc_ncm nvme cqhci cdc_ether usbnet
nvme_core sdhci uas nvme_common ghash_clmulni_intel usb_storage e
[   19.971990] CR2: ffff90e3b677f400
[   19.971991] ---[ end trace 4abd4ff8e3f54f74 ]---
[   19.971992] RIP: 0010:vma_interval_tree_remove+0x16a/0x2c0
[   19.971996] Code: e0 fc 48 83 fa 03 76 43 48 8b 48 10 48 8b 70 08
48 8b 50 b0 4c 8b 40 40 48 2b 50 a8 48 c1 ea 0c 4a 8d 54 02 ff 489
[   19.971998] RSP: 0018:ffffb05d40a2bd20 EFLAGS: 00010282
[   19.972000] RAX: ffff90e3550f2d08 RBX: ffff90e34bcc46e0 RCX: ffff90e3b67=
6ac20
[   19.972001] RDX: 0000000000000027 RSI: ffff90e355293df0 RDI: 00000000000=
00000
[   19.972003] RBP: ffff90e35528a3a0 R08: 0000000000000000 R09: 00000000000=
00000
[   19.972004] R10: ffffb05d40a2bd00 R11: 00007fffec14c000 R12: ffff90e3552=
8a3f8
[   19.972005] R13: ffffb05d40a2bda0 R14: 0000000000000000 R15: ffff90e3552=
93000
[   19.972007] FS:  0000000000000000(0000) GS:ffff90eaa0580000(0000)
knlGS:0000000000000000
[   19.972009] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.972010] CR2: ffff90e3b6711bf8 CR3: 0000000102e74000 CR4: 00000000003=
50ee0
[   22.110997] Shutting down cpus with NMI
[   22.114849] Kernel Offset: 0x2c200000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   22.125603] ---[ end Kernel panic - not syncing: Fatal exception ]---

Thanks,
Tao Liu


>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>

