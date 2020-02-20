Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74A701664E7
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2020 18:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgBTRcy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Feb 2020 12:32:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:35848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbgBTRcy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 20 Feb 2020 12:32:54 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3C5024682
        for <linux-efi@vger.kernel.org>; Thu, 20 Feb 2020 17:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582219972;
        bh=NTn2Tumpu1LwyQKfzz9q3wYYoSbq5Yoixz+ouT3t0+Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wU6GgDAiO3uiM8sn7QcktLAIC4k39Iq1jRRnCQyMdNJy86vSmqZXeN+ct4FwXt0pg
         5lvT8gY2ZRlIpY9tTuOQknItcOsJbb0X1CF2I2OgaGU6vSyIFAAwklapexHzTJg0GO
         eIzLOM7+1Mz/pP3/BhrPZRNNSwInRy5G4J7PiKxk=
Received: by mail-wr1-f53.google.com with SMTP id e8so5580590wrm.5
        for <linux-efi@vger.kernel.org>; Thu, 20 Feb 2020 09:32:52 -0800 (PST)
X-Gm-Message-State: APjAAAW8mcItTr7RXWAlwwmvIQciCGFHGQAEMM2c7vJppuVV1whhiTvz
        9agpAGr5g9qd5/LyaOc9iXZ0unXC52m/Vlwk8GEO1g==
X-Google-Smtp-Source: APXvYqw6kufsOwh+FzngwHdEUlJTeFByeIEceh1cvjyhAy5OIIfSjiTiMQ5UOx6E5HFI9xPYXvwlPleReJz66SjYo/o=
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr42686507wrw.126.1582219970761;
 Thu, 20 Feb 2020 09:32:50 -0800 (PST)
MIME-Version: 1.0
References: <20200220110649.1303-1-ardb@kernel.org> <20200220110649.1303-2-ardb@kernel.org>
 <20200220172831.GA2417225@rani.riverdale.lan>
In-Reply-To: <20200220172831.GA2417225@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 20 Feb 2020 18:32:39 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_QiXsJyR0X4au+r75DFoQmSUp38+J7BuD3HAH+rJ9gHQ@mail.gmail.com>
Message-ID: <CAKv+Gu_QiXsJyR0X4au+r75DFoQmSUp38+J7BuD3HAH+rJ9gHQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] efi/x86: Use symbolic constants in PE header
 instead of bare numbers
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Laszlo Ersek <lersek@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 20 Feb 2020 at 18:28, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Feb 20, 2020 at 12:06:47PM +0100, Ard Biesheuvel wrote:
> > Replace bare numbers in the PE/COFF header structure with symbolic
> > constants so they become self documenting.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/header.S | 60 ++++++++++----------
> >  1 file changed, 31 insertions(+), 29 deletions(-)
> >
> > diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> > index 44aeb63ca6ae..9110b58aa2ec 100644
> > --- a/arch/x86/boot/header.S
> > +++ b/arch/x86/boot/header.S
> > @@ -210,7 +200,10 @@ section_table:
> >       .long   0                               # PointerToLineNumbers
> >       .word   0                               # NumberOfRelocations
> >       .word   0                               # NumberOfLineNumbers
> > -     .long   0x60500020                      # Characteristics (section flags)
> > +     .long   IMAGE_SCN_CNT_CODE              | \
> > +             IMAGE_SCN_MEM_READ              | \
> > +             IMAGE_SCN_MEM_EXECUTE           | \
> > +             IMAGE_SCN_ALIGN_16BYTES         # Characteristics
>
> The IMAGE_SCN_ALIGN bits are marked as "valid only for object files".
> Can they be removed?
>

Yes, they probably should. I just didn't want to do it in the same patch.

> >
> >       #
> >       # The EFI application loader requires a relocation section
> > @@ -228,7 +221,10 @@ section_table:
> >       .long   0                               # PointerToLineNumbers
> >       .word   0                               # NumberOfRelocations
> >       .word   0                               # NumberOfLineNumbers
> > -     .long   0x42100040                      # Characteristics (section flags)
> > +     .long   IMAGE_SCN_CNT_INITIALIZED_DATA  | \
> > +             IMAGE_SCN_MEM_READ              | \
> > +             IMAGE_SCN_MEM_DISCARDABLE       | \
> > +             IMAGE_SCN_ALIGN_1BYTES          # Characteristics
> >
> >  #ifdef CONFIG_EFI_MIXED
> >       #
> > @@ -244,7 +240,10 @@ section_table:
> >       .long   0                               # PointerToLineNumbers
> >       .word   0                               # NumberOfRelocations
> >       .word   0                               # NumberOfLineNumbers
> > -     .long   0x42100040                      # Characteristics (section flags)
> > +     .long   IMAGE_SCN_CNT_INITIALIZED_DATA  | \
> > +             IMAGE_SCN_MEM_READ              | \
> > +             IMAGE_SCN_MEM_DISCARDABLE       | \
> > +             IMAGE_SCN_ALIGN_1BYTES          # Characteristics
> >  #endif
> >
> >       #
> > @@ -263,7 +262,10 @@ section_table:
> >       .long   0                               # PointerToLineNumbers
> >       .word   0                               # NumberOfRelocations
> >       .word   0                               # NumberOfLineNumbers
> > -     .long   0x60500020                      # Characteristics (section flags)
> > +     .long   IMAGE_SCN_CNT_CODE              | \
> > +             IMAGE_SCN_MEM_READ              | \
> > +             IMAGE_SCN_MEM_EXECUTE           | \
> > +             IMAGE_SCN_ALIGN_16BYTES         # Characteristics
>
> The .text section contains data as well. Shouldn't it be marked
> IMAGE_SCN_MEM_WRITE also?
>

Another good point. For ARM and arm64, I actually changed this into
split R-X and RW- sections, in case the loader decides to honour these
attributes (which it should imo)

So yes, we should either add IMAGE_SCN_MEM_WRITE, or add a .data
section (although we probably don't have the space for that).

Another thing I wondered was whether we really need the .reloc
section. We don't have one on ARM, and it works fine with the existing
EDK2 loader.
Peter: any idea whether the issue with .reloc you pointed out to me
the other day still exists in EDK2 today?
