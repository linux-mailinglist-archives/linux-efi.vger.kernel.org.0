Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8202DA211
	for <lists+linux-efi@lfdr.de>; Mon, 14 Dec 2020 21:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503444AbgLNUyA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Dec 2020 15:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503438AbgLNUxs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Dec 2020 15:53:48 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB35C061794
        for <linux-efi@vger.kernel.org>; Mon, 14 Dec 2020 12:53:08 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id e25so16505806wme.0
        for <linux-efi@vger.kernel.org>; Mon, 14 Dec 2020 12:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1r8mWX3dO5bIXJteVLwnQJfsBR/x5H9vpG4TpnJRsTM=;
        b=emsdinqsft+oUmZgElqgUrxICpGBt4a4re39vhYVYex9X1twjpZUmJDg9YBvHQ20Mz
         mmFLLRkIEAoFzuFaJCqXB7WHsUF3AX1hpvpqq/SgtPwuDGCiCjYGvQaYLo2lQcWZrSb2
         MqVll5pxr+2M/2jUBTK9UkLEcDTC3uABbvqSDp8vurJW1OfIo/SIhmceaJI+Rably4hi
         +FtZCer88GS1OpmfWidseaUNZlHAGL8z5CFr5XlrNgvz2fmbC/ayOMoiKm55aWlBWyVR
         4uq6lJT4MfaRRhLyIoeKz9zPTEklqpBDjgj2Sq/KsUTPz/ROMJYLFmClwGhIzrWZvHiO
         6wyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1r8mWX3dO5bIXJteVLwnQJfsBR/x5H9vpG4TpnJRsTM=;
        b=PtUcj8zbWrEYZ96KNIXzBgbjn42McILgFyqpA5jl2+qs1wzJ8iLHq9XNBRW1VyI1QM
         67ZfnS4SB0bWh2lJcGJQtpLRoAIkGestUPdQ8BNgSLLUWJ1OIz2p6/UZLWsOc5uwuSBU
         R152e7EVLl5FWU8hwA+KP/WpJ5QyqS1TOeCUYIYlD17qaNsfDn3FwOLTq9dc1R5rEfn8
         nB8I9+T2uBuB/yLd1BZ7DF4sk4hcvpypznbk5vEacwGOjIPC2uNE9USxurCaUQEIDNmy
         59tapB6pOtvJpASoalybEDv7IDU3tA9BZuv1aSocyd/NR4YxEOxZ41D563R8uRhRQCL3
         Jh7A==
X-Gm-Message-State: AOAM530dYP1yjrVUi+ZCeajnq8nGs7H4SXEOrsqcLSMI6d1+36uGfkJl
        AcSVuIXZ449H1kMuL5LCdBuvKem5BsN/MvilsSIwmw==
X-Google-Smtp-Source: ABdhPJyvVs4v89b/SyxICWRDRZG8sXVVnHPGF2JCyUroyIb4NQ0+nWAl3nWKfUtOU73TUYtqQv3Orx5/yy2kX9MV8/I=
X-Received: by 2002:a7b:cc12:: with SMTP id f18mr30013651wmh.110.1607979186711;
 Mon, 14 Dec 2020 12:53:06 -0800 (PST)
MIME-Version: 1.0
From:   "Hyunwook (Wooky) Baek" <baekhw@google.com>
Date:   Mon, 14 Dec 2020 12:52:55 -0800
Message-ID: <CABMWKFCCd=DiruUr3W8DGGozexW-gmeFWVEg2OmuJLuTJXFr_g@mail.gmail.com>
Subject: MOK variable config table: Kernel Panic in SEV-enabled VMs
To:     Lenny Szubowicz <lszubowi@redhat.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     pjones@redhat.com, dhowells@redhat.com, prarit@redhat.com,
        Peter Gonda <pgonda@google.com>,
        Rachit Mathur <rachitmathur@google.com>,
        Zach Marano <zmarano@google.com>,
        Jianxiong Gao <jxgao@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        David Rientjes <rientjes@google.com>, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello,

We found SEV-enabled VMs crash with the latest CentOS and Rhel images in Google
Cloud (centos-8-v20201112 and rhel-8-v20201112), because the MOK var table patch
(https://lkml.org/lkml/2020/8/25/1344) is making a #GP with SEV-enabled VMs,
but the patch is backported to those images. It looks like the patch
is also included in
the v5.10 release candidate.

The SEV-enabled VMs work fine with the previous Rhel-8 and Centos-8 images
(centos-8-v20201014 and rhel-8-v20201014).

The following is the kernel log messages that show the VM crashes while
running efi_mokvar_sysfs_init() with the rhel image (the centos kernel log is
almost identical):

[    1.720049] EFI Variables Facility v0.08 2004-May-17
[    1.943612] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input2
[    2.480607] general protection fault: 0000 [#1] SMP NOPTI
[    2.481549] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
4.18.0-193.28.1.el8_2.x86_64 #1
[    2.481549] Hardware name: Google Google Compute Engine/Google
Compute Engine, BIOS Google 01/01/2011
[    2.481549] RIP: 0010:efi_mokvar_sysfs_init+0xa9/0x19d
[    2.481549] Code: 4b 00 48 85 c0 0f 85 be 00 00 00 48 c7 c7 d8 a8
12 9b bd f4 ff ff ff e8 a4 ba 73 fe e9 f0 00 00 00 48 85 d2 0f 85 b1
00 00 00 <41> 80 3c 24 00 0f 84 bf 00 00 00 4d 85 e4 0f 84 b6 00 00 00
48 8b
[    2.481549] RSP: 0018:ffffa6d7c0c67df8 EFLAGS: 00010282
[    2.481549] RAX: 0df68117d0b79f0b RBX: ffff96fe32837720 RCX: 0000000000000000
[    2.481549] RDX: ffffa6d7c0c81000 RSI: ffffffff9b3934c0 RDI: ffff96fe32837758
[    2.481549] RBP: ffffffff9b3934c0 R08: ffffffff9b3934c0 R09: 0000000000000228
[    2.481549] R10: 0000000000000007 R11: 0000000000000008 R12: 0df627ef917fb013
[    2.481549] R13: ffffffff9b3934c0 R14: ffffffff9a6b3da0 R15: ffff96fe32837758
[    2.481549] FS:  0000000000000000(0000) GS:ffff96fe37b00000(0000)
knlGS:0000000000000000
[    2.481549] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.481549] CR2: 00007f0508d7c000 CR3: 0000800232ff8000 CR4: 0000000000340ee0
[    2.481549] Call Trace:
[    2.481549]  ? efi_rci2_sysfs_init+0x26d/0x26d
[    2.481549]  ? do_early_param+0x91/0x91
[    2.481549]  do_one_initcall+0x46/0x1c3
[    2.481549]  ? do_early_param+0x91/0x91
[    2.481549]  kernel_init_freeable+0x1af/0x258
[    2.481549]  ? rest_init+0xaa/0xaa
[    2.481549]  kernel_init+0xa/0xff
[    2.481549]  ret_from_fork+0x22/0x40
[    2.481549] Modules linked in:
[    2.511520] ---[ end trace 24709f23c20e9cd9 ]---
[    2.512376] RIP: 0010:efi_mokvar_sysfs_init+0xa9/0x19d
[    2.513249] Code: 4b 00 48 85 c0 0f 85 be 00 00 00 48 c7 c7 d8 a8
12 9b bd f4 ff ff ff e8 a4 ba 73 fe e9 f0 00 00 00 48 85 d2 0f 85 b1
00 00 00 <41> 80 3c 24 00 0f 84 bf 00 00 00 4d 85 e4 0f 84 b6 00 00 00
48 8b
[    2.516876] RSP: 0018:ffffa6d7c0c67df8 EFLAGS: 00010282
[    2.517844] RAX: 0df68117d0b79f0b RBX: ffff96fe32837720 RCX: 0000000000000000
[    2.519128] RDX: ffffa6d7c0c81000 RSI: ffffffff9b3934c0 RDI: ffff96fe32837758
[    2.520328] RBP: ffffffff9b3934c0 R08: ffffffff9b3934c0 R09: 0000000000000228
[    2.521771] R10: 0000000000000007 R11: 0000000000000008 R12: 0df627ef917fb013
[    2.523025] R13: ffffffff9b3934c0 R14: ffffffff9a6b3da0 R15: ffff96fe32837758
[    2.524218] FS:  0000000000000000(0000) GS:ffff96fe37b00000(0000)
knlGS:0000000000000000
[    2.525591] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.528401] CR2: 00007f0508d7c000 CR3: 0000800232ff8000 CR4: 0000000000340ee0
[    2.530155] Kernel panic - not syncing: Fatal exception
[    2.531145] Kernel Offset: 0x19000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[    2.531145] ---[ end Kernel panic - not syncing: Fatal exception ]---

Regards,
Wooky
