Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1852DA281
	for <lists+linux-efi@lfdr.de>; Mon, 14 Dec 2020 22:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503589AbgLNVUo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Dec 2020 16:20:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42282 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2503582AbgLNVUk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Dec 2020 16:20:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607980753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kCwhYTgPmmce18TYeNVDm64FKjEsl3Uj/IWWxXne59A=;
        b=UWh9N0c8zrqsh4ITac2p7KZQim7AiMCQKuyMIu1iptNCqxAgp5/QVuLBU1XY0creN+yapK
        ioE/ngriZY5o4vsI/5Fj3nQXwpOHFprsT0hz3B5/gf4Nxj0gwfv/NtHStfRK6+V8sMY/BI
        xSJ/MC6aCDndsIjsoUfvG+76sK3GBAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-sPOru02hPbG18SVrLnASRw-1; Mon, 14 Dec 2020 16:19:08 -0500
X-MC-Unique: sPOru02hPbG18SVrLnASRw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E44D459;
        Mon, 14 Dec 2020 21:19:06 +0000 (UTC)
Received: from [10.10.64.194] (ovpn-64-194.rdu2.redhat.com [10.10.64.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A55E6A8E4;
        Mon, 14 Dec 2020 21:19:05 +0000 (UTC)
Subject: Re: MOK variable config table: Kernel Panic in SEV-enabled VMs
To:     "Hyunwook (Wooky) Baek" <baekhw@google.com>,
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
References: <CABMWKFCCd=DiruUr3W8DGGozexW-gmeFWVEg2OmuJLuTJXFr_g@mail.gmail.com>
From:   Lenny Szubowicz <lszubowi@redhat.com>
Message-ID: <e4fec86d-204b-9ea9-f48e-8b918f4159d3@redhat.com>
Date:   Mon, 14 Dec 2020 16:19:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CABMWKFCCd=DiruUr3W8DGGozexW-gmeFWVEg2OmuJLuTJXFr_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/14/20 3:52 PM, Hyunwook (Wooky) Baek wrote:
> Hello,
> 
> We found SEV-enabled VMs crash with the latest CentOS and Rhel images in Google
> Cloud (centos-8-v20201112 and rhel-8-v20201112), because the MOK var table patch
> (https://lkml.org/lkml/2020/8/25/1344) is making a #GP with SEV-enabled VMs,
> but the patch is backported to those images. It looks like the patch
> is also included in
> the v5.10 release candidate.
> 
> The SEV-enabled VMs work fine with the previous Rhel-8 and Centos-8 images
> (centos-8-v20201014 and rhel-8-v20201014).
> 
> The following is the kernel log messages that show the VM crashes while
> running efi_mokvar_sysfs_init() with the rhel image (the centos kernel log is
> almost identical):
> 
> [    1.720049] EFI Variables Facility v0.08 2004-May-17
> [    1.943612] input: AT Translated Set 2 keyboard as
> /devices/platform/i8042/serio0/input/input2
> [    2.480607] general protection fault: 0000 [#1] SMP NOPTI
> [    2.481549] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
> 4.18.0-193.28.1.el8_2.x86_64 #1
> [    2.481549] Hardware name: Google Google Compute Engine/Google
> Compute Engine, BIOS Google 01/01/2011
> [    2.481549] RIP: 0010:efi_mokvar_sysfs_init+0xa9/0x19d
> [    2.481549] Code: 4b 00 48 85 c0 0f 85 be 00 00 00 48 c7 c7 d8 a8
> 12 9b bd f4 ff ff ff e8 a4 ba 73 fe e9 f0 00 00 00 48 85 d2 0f 85 b1
> 00 00 00 <41> 80 3c 24 00 0f 84 bf 00 00 00 4d 85 e4 0f 84 b6 00 00 00
> 48 8b
> [    2.481549] RSP: 0018:ffffa6d7c0c67df8 EFLAGS: 00010282
> [    2.481549] RAX: 0df68117d0b79f0b RBX: ffff96fe32837720 RCX: 0000000000000000
> [    2.481549] RDX: ffffa6d7c0c81000 RSI: ffffffff9b3934c0 RDI: ffff96fe32837758
> [    2.481549] RBP: ffffffff9b3934c0 R08: ffffffff9b3934c0 R09: 0000000000000228
> [    2.481549] R10: 0000000000000007 R11: 0000000000000008 R12: 0df627ef917fb013
> [    2.481549] R13: ffffffff9b3934c0 R14: ffffffff9a6b3da0 R15: ffff96fe32837758
> [    2.481549] FS:  0000000000000000(0000) GS:ffff96fe37b00000(0000)
> knlGS:0000000000000000
> [    2.481549] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.481549] CR2: 00007f0508d7c000 CR3: 0000800232ff8000 CR4: 0000000000340ee0
> [    2.481549] Call Trace:
> [    2.481549]  ? efi_rci2_sysfs_init+0x26d/0x26d
> [    2.481549]  ? do_early_param+0x91/0x91
> [    2.481549]  do_one_initcall+0x46/0x1c3
> [    2.481549]  ? do_early_param+0x91/0x91
> [    2.481549]  kernel_init_freeable+0x1af/0x258
> [    2.481549]  ? rest_init+0xaa/0xaa
> [    2.481549]  kernel_init+0xa/0xff
> [    2.481549]  ret_from_fork+0x22/0x40
> [    2.481549] Modules linked in:
> [    2.511520] ---[ end trace 24709f23c20e9cd9 ]---
> [    2.512376] RIP: 0010:efi_mokvar_sysfs_init+0xa9/0x19d
> [    2.513249] Code: 4b 00 48 85 c0 0f 85 be 00 00 00 48 c7 c7 d8 a8
> 12 9b bd f4 ff ff ff e8 a4 ba 73 fe e9 f0 00 00 00 48 85 d2 0f 85 b1
> 00 00 00 <41> 80 3c 24 00 0f 84 bf 00 00 00 4d 85 e4 0f 84 b6 00 00 00
> 48 8b
> [    2.516876] RSP: 0018:ffffa6d7c0c67df8 EFLAGS: 00010282
> [    2.517844] RAX: 0df68117d0b79f0b RBX: ffff96fe32837720 RCX: 0000000000000000
> [    2.519128] RDX: ffffa6d7c0c81000 RSI: ffffffff9b3934c0 RDI: ffff96fe32837758
> [    2.520328] RBP: ffffffff9b3934c0 R08: ffffffff9b3934c0 R09: 0000000000000228
> [    2.521771] R10: 0000000000000007 R11: 0000000000000008 R12: 0df627ef917fb013
> [    2.523025] R13: ffffffff9b3934c0 R14: ffffffff9a6b3da0 R15: ffff96fe32837758
> [    2.524218] FS:  0000000000000000(0000) GS:ffff96fe37b00000(0000)
> knlGS:0000000000000000
> [    2.525591] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.528401] CR2: 00007f0508d7c000 CR3: 0000800232ff8000 CR4: 0000000000340ee0
> [    2.530155] Kernel panic - not syncing: Fatal exception
> [    2.531145] Kernel Offset: 0x19000000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [    2.531145] ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> Regards,
> Wooky
> 

First off, this problem does not exist in the upstream kernel because of
the prior commit:

985e537a4082 x86/ioremap: Map EFI runtime services data as encrypted for SEV

Unfortunately, that upstream commit is not included in the RHEL 8.3 kernel.
We did not detect the necessity of this commit in time to include it in RHEL 8.3.
However, I expect that it will be included a future bug fix release.

                                -Lenny.


