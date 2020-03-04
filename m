Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A39CE179684
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 18:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgCDRRQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 12:17:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgCDRRQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Mar 2020 12:17:16 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F88621775
        for <linux-efi@vger.kernel.org>; Wed,  4 Mar 2020 17:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583342235;
        bh=60Hthqwh6sX1rMRbhpF7hEm6WhIldYxSv93SLcy7YoU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zS8RXpEyabIxvqTWNXVANhb0U1RojvJYNKIKeaI20RrGkNcnpPFuoUAdvLO4zrwuX
         RY3lZEQEC4VLXAe7MnTaj48ky0vYcbJoIVS57dVCtutavRAlK+VDVQCst/R7l4wpBP
         ruFbDrLVcxmp6mkjqAtL3DPfeFxZxTtAKRsyTgt4=
Received: by mail-wr1-f52.google.com with SMTP id y17so3386257wrn.6
        for <linux-efi@vger.kernel.org>; Wed, 04 Mar 2020 09:17:14 -0800 (PST)
X-Gm-Message-State: ANhLgQ23KjX75tF74qrq5V8/I6zaQ88g9BaXIISr1Vii0BsBzgGD8NXg
        kiSNEL+hanK+aJagBRgeTU6lYI0W1kVuDz4AiMFr8A==
X-Google-Smtp-Source: ADFU+vva1vWZhn2fq+ePYEILSzs72rV+jcRDOb2zaI/AXwTUTluZKWLyZxbQedPs8O1L6aMqjIq2/T0eEP9lmb/h4Ck=
X-Received: by 2002:adf:e742:: with SMTP id c2mr4997903wrn.262.1583342233575;
 Wed, 04 Mar 2020 09:17:13 -0800 (PST)
MIME-Version: 1.0
References: <20200304165917.5893-1-ardb@kernel.org> <20200304171537.GA1449349@rani.riverdale.lan>
In-Reply-To: <20200304171537.GA1449349@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 4 Mar 2020 18:17:02 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu-VM9Hr_bFaNPOBkaHhYuKNnXoMrHx+MZY5t6_PKCYH3w@mail.gmail.com>
Message-ID: <CAKv+Gu-VM9Hr_bFaNPOBkaHhYuKNnXoMrHx+MZY5t6_PKCYH3w@mail.gmail.com>
Subject: Re: [PATCH efi-next] efi/x86: ignore memory attributes table on i386
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 4 Mar 2020 at 18:15, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Mar 04, 2020 at 05:59:17PM +0100, Ard Biesheuvel wrote:
> > Commit 3a6b6c6fb23667fa ("efi: Make EFI_MEMORY_ATTRIBUTES_TABLE
> > initialization common across all architectures") moved the call to
> > efi_memattr_init() from ARM specific to generic EFI init code, in
> > order to be able to apply the restricted permissions described in
> > that table on x86 as well.
> >
> > We never enabled this feature fully on i386, and so mapping and
> > reserving this table is pointless. However, due to the early call to
> > memblock_reserve(), the memory bookkeeping gets confused to the point
> > where it produces the splat below when we try to map the memory later
> > on:
> >
> >   ------------[ cut here ]------------
> >   ioremap on RAM at 0x3f251000 - 0x3fa1afff
> >   WARNING: CPU: 0 PID: 0 at arch/x86/mm/ioremap.c:166 __ioremap_caller ...
> >   Modules linked in:
> >   CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.20.0 #48
> >   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> >   EIP: __ioremap_caller.constprop.0+0x249/0x260
> >   Code: 90 0f b7 05 4e 38 40 de 09 45 e0 e9 09 ff ff ff 90 8d 45 ec c6 05 ...
> >   EAX: 00000029 EBX: 00000000 ECX: de59c228 EDX: 00000001
> >   ESI: 3f250fff EDI: 00000000 EBP: de3edf20 ESP: de3edee0
> >   DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00200296
> >   CR0: 80050033 CR2: ffd17000 CR3: 1e58c000 CR4: 00040690
> >   Call Trace:
> >    ioremap_cache+0xd/0x10
> >    ? old_map_region+0x72/0x9d
> >    old_map_region+0x72/0x9d
> >    efi_map_region+0x8/0xa
> >    efi_enter_virtual_mode+0x260/0x43b
> >    start_kernel+0x329/0x3aa
> >    i386_start_kernel+0xa7/0xab
> >    startup_32_smp+0x164/0x168
> >   ---[ end trace e15ccf6b9f356833 ]---
> >
> > Let's work around this by disregarding the memory attributes table
> > altogether on i386, which does not result in a loss of functionality
> > or protection, given that we never consumed the contents.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Thanks!
>
> Tested-by: Arvind Sankar <nivedita@alum.mit.edu>
>

Thanks. I guess nobody noticed because nobody enabled this feature on
production i386 hardware.
