Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBF8C1A4752
	for <lists+linux-efi@lfdr.de>; Fri, 10 Apr 2020 16:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgDJOXA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Apr 2020 10:23:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgDJOXA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Apr 2020 10:23:00 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82D062137B
        for <linux-efi@vger.kernel.org>; Fri, 10 Apr 2020 14:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586528580;
        bh=vTTp+WgQaua5C56D3LueZpY4WHMSGkM6V6Izo/WPmLA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JrKhsOUVqty77Ddo2Zr872HiXb/2Ith/dnW6UqYZxRx1UAfuJUBubRHAxbRZWpTLU
         TuyFSQZ2DMzSL64e3Cf6w/VPqNNLPYejQqjcHh7K4UDQKBshdte7z9u/p8IlAI9l57
         a367DDYmrpxt03aYW0XNzPDOOk4s7mtssxxg9B8Q=
Received: by mail-io1-f51.google.com with SMTP id o127so1920420iof.0
        for <linux-efi@vger.kernel.org>; Fri, 10 Apr 2020 07:23:00 -0700 (PDT)
X-Gm-Message-State: AGi0PuavVLCVlL0j5ZGvyT1e0fcu+AqLuxdus3K7QD4LBibmz0CJQTRT
        o2JW12lR3c4J7VvPKHOTHZY/zwyqmnpqXRY1nu8=
X-Google-Smtp-Source: APiQypLZJznMn2PppYfugNCcfb0yXiIHON5424ppKEzhU1TTpW/Zpi+M9tz4bRd0qpmXyEJ1unFrhSbefetASK9v1tI=
X-Received: by 2002:a5e:8b47:: with SMTP id z7mr4501341iom.16.1586528579875;
 Fri, 10 Apr 2020 07:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200410074320.16589-1-ardb@kernel.org> <20200410135644.GB6772@dhcp-128-65.nay.redhat.com>
 <20200410140151.GC6772@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20200410140151.GC6772@dhcp-128-65.nay.redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Apr 2020 16:22:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEM13Y5FCh8GvJGTueen3fa0u_JX66j0X10KPf4Z0c4Jg@mail.gmail.com>
Message-ID: <CAMj1kXEM13Y5FCh8GvJGTueen3fa0u_JX66j0X10KPf4Z0c4Jg@mail.gmail.com>
Subject: Re: [PATCH] efi/x86: Revert struct layout change to fix kexec boot regression
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 10 Apr 2020 at 16:02, Dave Young <dyoung@redhat.com> wrote:
>
> On 04/10/20 at 09:56pm, Dave Young wrote:
> > On 04/10/20 at 09:43am, Ard Biesheuvel wrote:
> > > Commit
> > >
> > >   0a67361dcdaa29 ("efi/x86: Remove runtime table address from kexec EFI setup data")
> > >
> > > removed the code that retrieves the non-remapped UEFI runtime services
> > > pointer from the data structure provided by kexec, as it was never really
> > > needed on the kexec boot path: mapping the runtime services table at its
> > > non-remapped address is only needed when calling SetVirtualAddressMap(),
> > > which never happens during a kexec boot in the first place.
> > >
> > > However, dropping the 'runtime' member from struct efi_setup_data was a
> > > mistake. That struct is shared ABI between the kernel and the kexec tooling
> > > for x86, and so we cannot simply change its layout. So let's put back the
> > > removed field, but call it 'unused' to reflect the fact that we never look
> > > at its contents. While at it, add a comment to remind our future selves
> > > that the layout is external ABI.
> > >
> > > Reported-by: Theodore Ts'o <tytso@mit.edu>
> > > Tested-by: Theodore Ts'o <tytso@mit.edu>
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >
> > > Ingo, Thomas, Boris: I sent out my efi-urgent pull request just yesterday,
> > > so please take this directly into tip:efi/urgent - no need to wait for the
> > > next batch.
> > >
> > >  arch/x86/include/asm/efi.h | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> > > index 781170d36f50..96044c8d8600 100644
> > > --- a/arch/x86/include/asm/efi.h
> > > +++ b/arch/x86/include/asm/efi.h
> > > @@ -178,8 +178,10 @@ extern void efi_free_boot_services(void);
> > >  extern pgd_t * __init efi_uv1_memmap_phys_prolog(void);
> > >  extern void __init efi_uv1_memmap_phys_epilog(pgd_t *save_pgd);
> > >
> > > +/* kexec external ABI */
> > >  struct efi_setup_data {
> > >     u64 fw_vendor;
> > > +   u64 unused;
> > >     u64 tables;
> > >     u64 smbios;
> > >     u64 reserved[8];
> > > --
> > > 2.17.1
> > >
> >
> > Ah, replied too quick in another mail.  I just cced kexec list again.
> >
> > Thanks for the fix:
> >
> > Reviewed-by: Dave Young <dyoung@redhat.com>
> >
>

Thanks Dave

> BTW, a fixes tag is good to have..
>

I usually omit those for patches that fix bugs that were introduced in
the current cycle.
