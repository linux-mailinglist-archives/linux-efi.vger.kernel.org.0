Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10B3298281
	for <lists+linux-efi@lfdr.de>; Sun, 25 Oct 2020 17:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417129AbgJYQ2T (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 25 Oct 2020 12:28:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732908AbgJYQ2S (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 25 Oct 2020 12:28:18 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E90B20874;
        Sun, 25 Oct 2020 16:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603643298;
        bh=kAIRJCpvGZzJmCIhoEXrGyLVMoR7rlmxTUqkG1s9TrY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=adyffskIMu+9uckZSB7F611oooP9jVLNkLknNBUrRZyXerhSUimmhCn4R7h9Ft7k1
         isZ3a0k5lYIVzy6NPKmsiqVf43AAUVrNKt0mQ7EsrRLjZVmB4+Xqwom2KUy8Ib1RCB
         yZDeWTwNRNNIVCwHUF4sdf2RQ0XJPVs8rg/R4hkk=
Received: by mail-ot1-f50.google.com with SMTP id e20so5927263otj.11;
        Sun, 25 Oct 2020 09:28:18 -0700 (PDT)
X-Gm-Message-State: AOAM530g3/Yeuig4GjoRd2JA0JtkoORdYdXrePy1KhV0aIzXKqnKVg5H
        xxrIvHtFMDC2XNHy1IfCGsSqdTZyRzCzFXpn+Vk=
X-Google-Smtp-Source: ABdhPJwhcGb0O8JWVmRXt70So+5rhhkM5x9z5qOkcomWz4jLdOelRmuUVZ0lVQZrhvRVhxHKQIIYNSvod5nIjjqkN44=
X-Received: by 2002:a05:6830:4028:: with SMTP id i8mr8343361ots.90.1603643297927;
 Sun, 25 Oct 2020 09:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201011142012.96493-1-nivedita@alum.mit.edu> <20201025161931.GA1119983@rani.riverdale.lan>
In-Reply-To: <20201025161931.GA1119983@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 25 Oct 2020 17:28:06 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGBybyTOADr+PvC+ZVohw+aRZbEnfweHTECKKdX9JHXTw@mail.gmail.com>
Message-ID: <CAMj1kXGBybyTOADr+PvC+ZVohw+aRZbEnfweHTECKKdX9JHXTw@mail.gmail.com>
Subject: Re: [PATCH] efi/x86: Only copy the compressed kernel image in efi_relocate_kernel()
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 25 Oct 2020 at 17:19, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Sun, Oct 11, 2020 at 10:20:12AM -0400, Arvind Sankar wrote:
> > The image_size argument to efi_relocate_kernel() is currently specified
> > as init_size, but this is unnecessarily large. The compressed kernel is
> > much smaller, in fact, its image only extends up to the start of _bss,
> > since at this point, the .bss section is still uninitialized.
> >
> > Depending on compression level, this can reduce the amount of data
> > copied by 4-5x.
> >
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
>
> Ping
>

I'll pick this up as a fix once the merge window closes.

> > ---
> >  drivers/firmware/efi/libstub/x86-stub.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> > index 3672539cb96e..f14c4ff5839f 100644
> > --- a/drivers/firmware/efi/libstub/x86-stub.c
> > +++ b/drivers/firmware/efi/libstub/x86-stub.c
> > @@ -715,8 +715,11 @@ unsigned long efi_main(efi_handle_t handle,
> >           (IS_ENABLED(CONFIG_X86_32) && buffer_end > KERNEL_IMAGE_SIZE)    ||
> >           (IS_ENABLED(CONFIG_X86_64) && buffer_end > MAXMEM_X86_64_4LEVEL) ||
> >           (image_offset == 0)) {
> > +             extern char _bss[];
> > +
> >               status = efi_relocate_kernel(&bzimage_addr,
> > -                                          hdr->init_size, hdr->init_size,
> > +                                          (unsigned long)_bss - bzimage_addr,
> > +                                          hdr->init_size,
> >                                            hdr->pref_address,
> >                                            hdr->kernel_alignment,
> >                                            LOAD_PHYSICAL_ADDR);
> > --
> > 2.26.2
> >
