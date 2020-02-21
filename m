Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C56F168709
	for <lists+linux-efi@lfdr.de>; Fri, 21 Feb 2020 19:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgBUSyR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Feb 2020 13:54:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgBUSyR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 21 Feb 2020 13:54:17 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7729C24676
        for <linux-efi@vger.kernel.org>; Fri, 21 Feb 2020 18:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582311256;
        bh=De75B74dVVWAYyS4B+Jp2OvDkZjR53PXmkIdVfCOcSs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tkUgwgSeyxm7HsaaK/RJ7GTwJCE+gngkSMGIMClCch4Tpek4uLPKSmQNJMb5QpEq1
         0b02bKjCaiVcbohbxRUb6Hi5luN8XFbYLLu0R85acgO2WzmcKh7Sb5CuLbEukViA3A
         LaZHMtqPmJPqYh5OGrsWTnqs45bPcMeHBrexuO34=
Received: by mail-wm1-f53.google.com with SMTP id m10so5813190wmc.0
        for <linux-efi@vger.kernel.org>; Fri, 21 Feb 2020 10:54:16 -0800 (PST)
X-Gm-Message-State: APjAAAU466mJVx61og98Iu69+CFBDR+s/kRnd125Lu0yijD5KUubIe/H
        exWFKMmw/7ayjg4KEHUS3ATwpIVb53eRDQ9EV68R6g==
X-Google-Smtp-Source: APXvYqz3uUYXXMBKRJRTt3ao2yMpHyALTJh8QnglZGdfV2wsHzBWz38Z6cyoGo+6G8dLz3GMLtv01ZxhrjkleFGeGDU=
X-Received: by 2002:a1c:282:: with SMTP id 124mr5082854wmc.62.1582311254824;
 Fri, 21 Feb 2020 10:54:14 -0800 (PST)
MIME-Version: 1.0
References: <20200217144822.24616-1-ardb@kernel.org> <20200217144822.24616-5-ardb@kernel.org>
 <20200221163915.GA2766905@rani.riverdale.lan> <CAKv+Gu8nwcyXqHDs6FowwYQw6xxLC+=Y8OqQkU=fRUsaLY3Fpg@mail.gmail.com>
 <20200221175949.GA2825100@rani.riverdale.lan>
In-Reply-To: <20200221175949.GA2825100@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 21 Feb 2020 19:54:02 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu-Q6SjVYoAqmAE-JZguFd5PsG6hkZWLj_nnA91+C2ZA6g@mail.gmail.com>
Message-ID: <CAKv+Gu-Q6SjVYoAqmAE-JZguFd5PsG6hkZWLj_nnA91+C2ZA6g@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] efi/x86: Implement mixed mode boot without the
 handover protocol
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Laszlo Ersek <lersek@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 21 Feb 2020 at 18:59, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Fri, Feb 21, 2020 at 06:12:40PM +0100, Ard Biesheuvel wrote:
> > On Fri, 21 Feb 2020 at 17:39, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Mon, Feb 17, 2020 at 03:48:21PM +0100, Ard Biesheuvel wrote:
> > > > Add support for booting 64-bit x86 kernels from 32-bit firmware running
> > > > on 64-bit capable CPUs without requiring the bootloader to implement
> > > > the EFI handover protocol or allocate the setup block, etc etc, all of
> > > > which can be done by the stub itself, using code that already exists.
> > > >
> > > > Instead, create an ordinary EFI application entrypoint but implemented
> > > > in 32-bit code [so that it can be invoked by 32-bit firmware], and stash
> > > > the address of this 32-bit entrypoint in the .compat section where the
> > > > bootloader can find it.
> > > >
> > > > Note that we use the setup block embedded in the binary to go through
> > > > startup_32(), but it gets reallocated and copied in efi_pe_entry(),
> > > > using the same code that runs when the x86 kernel is booted in EFI
> > > > mode from native firmware. This requires the loaded image protocol to
> > > > be installed on the kernel image's EFI handle, and point to the kernel
> > > > image itself and not to its loader. This, in turn, requires the
> > > > bootloader to use the LoadImage() boot service to load the 64-bit
> > > > image from 32-bit firmware, which is in fact supported by firmware
> > > > based on EDK2. (Only StartImage() will fail, and instead, the newly
> > > > added entrypoint needs to be invoked)
> > > >
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > I think there's one issue with this. startup_32 is 14KiB from the start
> > > of the image because of .setup. This means the code in startup_32 that
> > > rounds the load address up to kernel_alignment will likely calculate it
> > > as 2MiB from the image address (if the image address was 2MiB-aligned),
> > > and the page tables constructed by the 32-bit code will be beyond the
> > > space allocated for the image.
> > >
> >
> > Right. Image address could be any multiple of 4 KB so we'll have to
> > deal with that.
> >
> > > I think the simplest fix would be to increase SizeOfImage by
> > > kernel_alignment to allow enough slop space for the alignment.
> >
> > So we basically need at least 2 MB - 14 KB slack at the top, right?
> > That's easily done.
> >
> > > We should
> > > also increase it by text_start, since we need init_size beginning from
> > > startup_32, not from the image address.
> >
> > So something like the below?
>
> Yup.
>
> You might as well do the text_start bit unconditionally I think? If by
> some blind stroke of luck startup_32 ends up at pref_address and so we
> don't call efi_relocate_kernel, we'll need the room.
>

Yeah, so this could already be an issue today ...
