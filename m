Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0EF9178B1C
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 08:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgCDHKV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 02:10:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgCDHKV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Mar 2020 02:10:21 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60BE2215A4
        for <linux-efi@vger.kernel.org>; Wed,  4 Mar 2020 07:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583305820;
        bh=dWmYIVVUIMCH4lNsxir6uUNJwZacuRxV0YyJTgfISXo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wNfQH4VkdCyJrR8T6zFj2sZ9o5CAwu2lyCNtFPQUsV+ZCBET/azWeRjUMkgCV8NBa
         uhG1PBTM6f+MkUFaF7oUjfI1BbsX2CmWd6GuPal3Ls6kXkPFr2egDwPNKsaSqf9hbh
         jyGUUTy/p3dE0nJO7heA7YB1DtZjdKndBedTgT1s=
Received: by mail-wr1-f46.google.com with SMTP id j7so955954wrp.13
        for <linux-efi@vger.kernel.org>; Tue, 03 Mar 2020 23:10:20 -0800 (PST)
X-Gm-Message-State: ANhLgQ3aGN6pXll0IV8srmIhoR6gOWPW6krNNFMdA29ISbK8cGw6Wgwr
        Ej5bNkbT64m8fIN4zEyrDVeZhsSTBZmbduOwBwHHUg==
X-Google-Smtp-Source: ADFU+vs2XnaCt3tUEBIRIjxfHNtXDaMti58gvkI+S/it356fmHy9AQiPzJpA2p80PZDTwdQrhwz0QpfbLC7zK425xKM=
X-Received: by 2002:adf:e742:: with SMTP id c2mr2482808wrn.262.1583305818733;
 Tue, 03 Mar 2020 23:10:18 -0800 (PST)
MIME-Version: 1.0
References: <20200303234018.GB154112@rani.riverdale.lan>
In-Reply-To: <20200303234018.GB154112@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 4 Mar 2020 08:10:07 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_AFPEh_DuJ9rHaa6hUgd2hd+7x3UKrbNUyT-ttp2naPA@mail.gmail.com>
Message-ID: <CAKv+Gu_AFPEh_DuJ9rHaa6hUgd2hd+7x3UKrbNUyT-ttp2naPA@mail.gmail.com>
Subject: Re: ioremap WARN on 32-bit kernel
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 4 Mar 2020 at 00:40, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> I consistently get this splat when booting 32-bit kernel on QEMU+OVMF,
> with at least 1024Mb. Seems to have been there for quite a while (before
> v5.0). Any ideas/can you repro?

Yes, I have seen it too. Won't have time to look at it for a while though.

>
> [    0.227718] ------------[ cut here ]------------
> [    0.227998] ioremap on RAM at 0x3f251000 - 0x3fa1afff
> [    0.228421] WARNING: CPU: 0 PID: 0 at arch/x86/mm/ioremap.c:166 __ioremap_caller.constprop.0+0x249/0x260
> [    0.228570] Modules linked in:
> [    0.228570] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.20.0 #48
> [    0.228570] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> [    0.228570] EIP: __ioremap_caller.constprop.0+0x249/0x260
> [    0.228570] Code: 90 0f b7 05 4e 38 40 de 09 45 e0 e9 09 ff ff ff 90 8d 45 ec c6 05 a1 52 4a de 01 50 8d 45 e4 50 68 b4 7b 2d de e8 3e bb 00 00 <0f> 0b 31 ff 83 c4 0c e9 66 ff ff ff 8d b4 26 00 00 00 00 8d 74 26
> [    0.228570] EAX: 00000029 EBX: 00000000 ECX: de59c228 EDX: 00000001
> [    0.228570] ESI: 3f250fff EDI: 00000000 EBP: de3edf20 ESP: de3edee0
> [    0.228570] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00200296
> [    0.228570] CR0: 80050033 CR2: ffd17000 CR3: 1e58c000 CR4: 00040690
> [    0.228570] Call Trace:
> [    0.228570]  ioremap_cache+0xd/0x10
> [    0.228570]  ? old_map_region+0x72/0x9d
> [    0.228570]  old_map_region+0x72/0x9d
> [    0.228570]  efi_map_region+0x8/0xa
> [    0.228570]  efi_enter_virtual_mode+0x260/0x43b
> [    0.228570]  start_kernel+0x329/0x3aa
> [    0.228570]  i386_start_kernel+0xa7/0xab
> [    0.228570]  startup_32_smp+0x164/0x168
> [    0.228570] ---[ end trace e15ccf6b9f356833 ]---
