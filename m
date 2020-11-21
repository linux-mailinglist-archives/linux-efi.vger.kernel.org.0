Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FA82BBE82
	for <lists+linux-efi@lfdr.de>; Sat, 21 Nov 2020 11:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgKUKiO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 21 Nov 2020 05:38:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:54326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbgKUKiO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 21 Nov 2020 05:38:14 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5C7021741;
        Sat, 21 Nov 2020 10:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605955093;
        bh=LHRsop7oL9qOLL86mHb7DatSFnA4DzmekgBDuuyKNKo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WKfOHv0/nFrQQj0q/33DOdysWLFdvdWezS1dfmvuU1zdb99PMh5utmREMyhOTWXf6
         rW9rb2pjaHpGF9p5wHImU6fWJFGIjTFGIeMYgrMmkhnH858cM3bJnnUvWjaYZhyKWr
         tJpDvlw1R9AS8gr3n2rcEZUnS9NAIlZFUGHBmtpQ=
Received: by mail-ot1-f43.google.com with SMTP id g19so11245896otp.13;
        Sat, 21 Nov 2020 02:38:13 -0800 (PST)
X-Gm-Message-State: AOAM5315q8RJCOjoO2GXgnFh7Jg9RBrGQ8QpYZ993tnn4qyp7MPzvRNI
        4ffoWyCoa75ObSpOWyogDnSWydxMkncH3F3rWkQ=
X-Google-Smtp-Source: ABdhPJwMEHPir/Iujn+sDlWqqSLoUPQqAVaDWMOZkEb1IBezOi33sj/6l3Pl3EE3XXpemRcat3+VBI+4c0QCpeeQOLg=
X-Received: by 2002:a05:6830:3099:: with SMTP id f25mr4290781ots.77.1605955093050;
 Sat, 21 Nov 2020 02:38:13 -0800 (PST)
MIME-Version: 1.0
References: <20201119182938.151155-1-Smita.KoralahalliChannabasappa@amd.com> <20201121101511.GA24020@zn.tnic>
In-Reply-To: <20201121101511.GA24020@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 21 Nov 2020 11:38:02 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEAkmKCSwKAnvWhZyo7=HdQNYFLQOzX0R+qN=WVHYd+OQ@mail.gmail.com>
Message-ID: <CAMj1kXEAkmKCSwKAnvWhZyo7=HdQNYFLQOzX0R+qN=WVHYd+OQ@mail.gmail.com>
Subject: Re: [PATCH v6] cper, apei, mce: Pass x86 CPER through the MCA
 handling chain
To:     Borislav Petkov <bp@alien8.de>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devel@acpica.org, Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 21 Nov 2020 at 11:15, Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Nov 19, 2020 at 12:29:38PM -0600, Smita Koralahalli wrote:
> > diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
> > index 2531de49f56c..438ed9eff6d0 100644
> > --- a/drivers/firmware/efi/cper-x86.c
> > +++ b/drivers/firmware/efi/cper-x86.c
> > @@ -2,6 +2,7 @@
> >  // Copyright (C) 2018, Advanced Micro Devices, Inc.
> >
> >  #include <linux/cper.h>
> > +#include <linux/acpi.h>
> >
> >  /*
> >   * We don't need a "CPER_IA" prefix since these are all locally defined.
> > @@ -347,9 +348,13 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
> >                              ctx_info->mm_reg_addr);
> >               }
> >
> > -             printk("%sRegister Array:\n", newpfx);
> > -             print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, groupsize,
> > -                            (ctx_info + 1), ctx_info->reg_arr_size, 0);
> > +             if (ctx_info->reg_ctx_type != CTX_TYPE_MSR ||
> > +                 arch_apei_report_x86_error(ctx_info, proc->lapic_id)) {
> > +                     printk("%sRegister Array:\n", newpfx);
> > +                     print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16,
> > +                                    groupsize, (ctx_info + 1),
> > +                                    ctx_info->reg_arr_size, 0);
> > +             }
> >
> >               ctx_info = (struct cper_ia_proc_ctx *)((long)ctx_info + size);
> >       }
> > --
>
> Ard, ack?
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>
