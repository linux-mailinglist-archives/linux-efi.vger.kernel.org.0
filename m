Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB8111685C4
	for <lists+linux-efi@lfdr.de>; Fri, 21 Feb 2020 18:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgBUR7y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Feb 2020 12:59:54 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39581 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgBUR7x (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Feb 2020 12:59:53 -0500
Received: by mail-qt1-f196.google.com with SMTP id p34so1886461qtb.6
        for <linux-efi@vger.kernel.org>; Fri, 21 Feb 2020 09:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xOmEMzvQIA2/VYV5wyxczcLnauOEkrRvZbKmTs+CEZU=;
        b=s+hJRW2eOcnNU/KCAnXm+ueiWyadIoAjxiR70e6NgHSpfS5OJm9y3KOZ+VjBiSiCUl
         AUxymJneQYHZb6/jReJXKuRqvzhyMOlA5AKU2CWPgPdgJfT+7mwG6MMWe4OJ93fdRqOT
         DIjWWaSfXQsdqOi61rDEJLVwjt2NP0BHaEKEkZKPCR2H/Y2cq0w1hdMkntTQe6kKOCui
         +OIxsbS2fiR8Q/kzcvCL1gxBWFi5afXG0fBi+CmEpfJr5xy4ImvUiYkCTU3w89dxviGi
         Uf87Li8REzbQJvwrK6u+SPwl0AGaSDP1gtIgVgWNqMKMwDn6XUzsyxdADZbL97iYb2+X
         FkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xOmEMzvQIA2/VYV5wyxczcLnauOEkrRvZbKmTs+CEZU=;
        b=oJBRQVDWplXTk0R/ikwJNZ1rvpeC/ZMyleXpBh0OY/RMUQug/9Ts8igLc4Yt9S0Nty
         IzD7boKp4xZEAUqS7lR+ClQJCzcLFPRwiqIhC8NA7XUuc7Bp5Qrf1/w51OcfhWkCq0OI
         mYRQv9uzNfotu9lhxP8cjnZ23dCGgURXdUISZ6yQPvurFdBDUPa8uAUhL1A49Wc8iEK9
         qYYcbHfRNLBW3nq+xFfG2rNQgWGDyYMw3qOGx1nk8EEPngqsVLm6W0YXaKJZOinD4i/X
         m5XgCVTCa9yO4zvS2KNS33W5FmmUc+tOWYlvTWj7v+zRkueCgLtmY2MWh84ZsKzUwULO
         1rbA==
X-Gm-Message-State: APjAAAUoto05r4z/lZF6PmF0ot6/U9WHxNzexpy240Dbzh6Xvbtxy24A
        vyOxtVIHv4KJDEWd+OVj1qU=
X-Google-Smtp-Source: APXvYqyeDPGsJk4xdMXlQqVNUSgfJBMF5MfxO0cPqWOFMx7r9zn6Wwwu4E5mlVs1qKjowt3l6n8Qag==
X-Received: by 2002:ac8:540f:: with SMTP id b15mr33669710qtq.237.1582307992191;
        Fri, 21 Feb 2020 09:59:52 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u12sm1871668qke.67.2020.02.21.09.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 09:59:51 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 21 Feb 2020 12:59:50 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Laszlo Ersek <lersek@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 4/5] efi/x86: Implement mixed mode boot without the
 handover protocol
Message-ID: <20200221175949.GA2825100@rani.riverdale.lan>
References: <20200217144822.24616-1-ardb@kernel.org>
 <20200217144822.24616-5-ardb@kernel.org>
 <20200221163915.GA2766905@rani.riverdale.lan>
 <CAKv+Gu8nwcyXqHDs6FowwYQw6xxLC+=Y8OqQkU=fRUsaLY3Fpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8nwcyXqHDs6FowwYQw6xxLC+=Y8OqQkU=fRUsaLY3Fpg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Feb 21, 2020 at 06:12:40PM +0100, Ard Biesheuvel wrote:
> On Fri, 21 Feb 2020 at 17:39, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Mon, Feb 17, 2020 at 03:48:21PM +0100, Ard Biesheuvel wrote:
> > > Add support for booting 64-bit x86 kernels from 32-bit firmware running
> > > on 64-bit capable CPUs without requiring the bootloader to implement
> > > the EFI handover protocol or allocate the setup block, etc etc, all of
> > > which can be done by the stub itself, using code that already exists.
> > >
> > > Instead, create an ordinary EFI application entrypoint but implemented
> > > in 32-bit code [so that it can be invoked by 32-bit firmware], and stash
> > > the address of this 32-bit entrypoint in the .compat section where the
> > > bootloader can find it.
> > >
> > > Note that we use the setup block embedded in the binary to go through
> > > startup_32(), but it gets reallocated and copied in efi_pe_entry(),
> > > using the same code that runs when the x86 kernel is booted in EFI
> > > mode from native firmware. This requires the loaded image protocol to
> > > be installed on the kernel image's EFI handle, and point to the kernel
> > > image itself and not to its loader. This, in turn, requires the
> > > bootloader to use the LoadImage() boot service to load the 64-bit
> > > image from 32-bit firmware, which is in fact supported by firmware
> > > based on EDK2. (Only StartImage() will fail, and instead, the newly
> > > added entrypoint needs to be invoked)
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > I think there's one issue with this. startup_32 is 14KiB from the start
> > of the image because of .setup. This means the code in startup_32 that
> > rounds the load address up to kernel_alignment will likely calculate it
> > as 2MiB from the image address (if the image address was 2MiB-aligned),
> > and the page tables constructed by the 32-bit code will be beyond the
> > space allocated for the image.
> >
> 
> Right. Image address could be any multiple of 4 KB so we'll have to
> deal with that.
> 
> > I think the simplest fix would be to increase SizeOfImage by
> > kernel_alignment to allow enough slop space for the alignment.
> 
> So we basically need at least 2 MB - 14 KB slack at the top, right?
> That's easily done.
> 
> > We should
> > also increase it by text_start, since we need init_size beginning from
> > startup_32, not from the image address.
> 
> So something like the below?

Yup.

You might as well do the text_start bit unconditionally I think? If by
some blind stroke of luck startup_32 ends up at pref_address and so we
don't call efi_relocate_kernel, we'll need the room.

> 
> --- a/arch/x86/boot/tools/build.c
> +++ b/arch/x86/boot/tools/build.c
> @@ -236,14 +236,23 @@
> 
>         pe_header = get_unaligned_le32(&buf[0x3c]);
> 
> +#ifdef CONFIG_EFI_MIXED
> +       /*
> +        * In order for startup_32 to safely execute in place, we need to give
> +        * it a bit of headroom to create its page tables.
> +        */
> +       bss_sz += text_start + CONFIG_PHYSICAL_ALIGN;
> +       init_sz += text_start + CONFIG_PHYSICAL_ALIGN;
> +#endif
> +
>         /*
>          * Size of code: Subtract the size of the first sector (512 bytes)
>          * which includes the header.
>          */
> -       put_unaligned_le32(file_sz - 512, &buf[pe_header + 0x1c]);
> +       put_unaligned_le32(file_sz + bss_sz- 512, &buf[pe_header + 0x1c]);
> 
>         /* Size of uninitialized data */
> -       put_unaligned_le32(bss_sz, &buf[pe_header + 0x24]);
> +       put_unaligned_le32(0, &buf[pe_header + 0x24]);
> 
>         /* Size of image */
>         put_unaligned_le32(init_sz, &buf[pe_header + 0x50]);
