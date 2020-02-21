Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35B1D16848F
	for <lists+linux-efi@lfdr.de>; Fri, 21 Feb 2020 18:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgBURMy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Feb 2020 12:12:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:33418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgBURMy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 21 Feb 2020 12:12:54 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6C9F2467B
        for <linux-efi@vger.kernel.org>; Fri, 21 Feb 2020 17:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582305173;
        bh=WS2XzXY4EpdDBi3H3rPKmUOormw7TrfZRFHvWYAADzs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XCVo/9dOTu4oDmh9/Ii4gsP3jHQL48ZcSczUWi+l69ECoEFFiMsNl8vwzcoQlUSmL
         30aimy54oomQrdvVvn4TsiBqCp+KlIWhtMoNj0MMhKJ0aBA9K09DafgMnHkv4VdqHp
         XO/unKM8uxv2KUyeSyKVfPrHLirjXICzYYCvaVGI=
Received: by mail-wm1-f50.google.com with SMTP id p9so2550807wmc.2
        for <linux-efi@vger.kernel.org>; Fri, 21 Feb 2020 09:12:52 -0800 (PST)
X-Gm-Message-State: APjAAAUIAagYyFbmoY6Ho++XKh0Xg6UUH7dF208lXNke6gztEPx4YzNy
        Ii3nOPA/KfukCwe7V9Mls1b71DHV1UnbRAuEI+3vSA==
X-Google-Smtp-Source: APXvYqxVLsG6RhV+IKNXrE6zlGlBCVRugSALpAIsBTb3vl2WoV83uhu7LO1+sJwgl5u+GdcWeXJm0dMgyMR/cxF+zSI=
X-Received: by 2002:a1c:b603:: with SMTP id g3mr5127993wmf.133.1582305171215;
 Fri, 21 Feb 2020 09:12:51 -0800 (PST)
MIME-Version: 1.0
References: <20200217144822.24616-1-ardb@kernel.org> <20200217144822.24616-5-ardb@kernel.org>
 <20200221163915.GA2766905@rani.riverdale.lan>
In-Reply-To: <20200221163915.GA2766905@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 21 Feb 2020 18:12:40 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu8nwcyXqHDs6FowwYQw6xxLC+=Y8OqQkU=fRUsaLY3Fpg@mail.gmail.com>
Message-ID: <CAKv+Gu8nwcyXqHDs6FowwYQw6xxLC+=Y8OqQkU=fRUsaLY3Fpg@mail.gmail.com>
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

On Fri, 21 Feb 2020 at 17:39, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Mon, Feb 17, 2020 at 03:48:21PM +0100, Ard Biesheuvel wrote:
> > Add support for booting 64-bit x86 kernels from 32-bit firmware running
> > on 64-bit capable CPUs without requiring the bootloader to implement
> > the EFI handover protocol or allocate the setup block, etc etc, all of
> > which can be done by the stub itself, using code that already exists.
> >
> > Instead, create an ordinary EFI application entrypoint but implemented
> > in 32-bit code [so that it can be invoked by 32-bit firmware], and stash
> > the address of this 32-bit entrypoint in the .compat section where the
> > bootloader can find it.
> >
> > Note that we use the setup block embedded in the binary to go through
> > startup_32(), but it gets reallocated and copied in efi_pe_entry(),
> > using the same code that runs when the x86 kernel is booted in EFI
> > mode from native firmware. This requires the loaded image protocol to
> > be installed on the kernel image's EFI handle, and point to the kernel
> > image itself and not to its loader. This, in turn, requires the
> > bootloader to use the LoadImage() boot service to load the 64-bit
> > image from 32-bit firmware, which is in fact supported by firmware
> > based on EDK2. (Only StartImage() will fail, and instead, the newly
> > added entrypoint needs to be invoked)
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> I think there's one issue with this. startup_32 is 14KiB from the start
> of the image because of .setup. This means the code in startup_32 that
> rounds the load address up to kernel_alignment will likely calculate it
> as 2MiB from the image address (if the image address was 2MiB-aligned),
> and the page tables constructed by the 32-bit code will be beyond the
> space allocated for the image.
>

Right. Image address could be any multiple of 4 KB so we'll have to
deal with that.

> I think the simplest fix would be to increase SizeOfImage by
> kernel_alignment to allow enough slop space for the alignment.

So we basically need at least 2 MB - 14 KB slack at the top, right?
That's easily done.

> We should
> also increase it by text_start, since we need init_size beginning from
> startup_32, not from the image address.

So something like the below?

--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -236,14 +236,23 @@

        pe_header = get_unaligned_le32(&buf[0x3c]);

+#ifdef CONFIG_EFI_MIXED
+       /*
+        * In order for startup_32 to safely execute in place, we need to give
+        * it a bit of headroom to create its page tables.
+        */
+       bss_sz += text_start + CONFIG_PHYSICAL_ALIGN;
+       init_sz += text_start + CONFIG_PHYSICAL_ALIGN;
+#endif
+
        /*
         * Size of code: Subtract the size of the first sector (512 bytes)
         * which includes the header.
         */
-       put_unaligned_le32(file_sz - 512, &buf[pe_header + 0x1c]);
+       put_unaligned_le32(file_sz + bss_sz- 512, &buf[pe_header + 0x1c]);

        /* Size of uninitialized data */
-       put_unaligned_le32(bss_sz, &buf[pe_header + 0x24]);
+       put_unaligned_le32(0, &buf[pe_header + 0x24]);

        /* Size of image */
        put_unaligned_le32(init_sz, &buf[pe_header + 0x50]);
