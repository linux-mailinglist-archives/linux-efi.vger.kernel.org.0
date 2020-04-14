Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55841A73D8
	for <lists+linux-efi@lfdr.de>; Tue, 14 Apr 2020 08:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406087AbgDNGqO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Apr 2020 02:46:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728133AbgDNGqO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 14 Apr 2020 02:46:14 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16BBA20735;
        Tue, 14 Apr 2020 06:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586846773;
        bh=8fu2EomF01hOlRt2drZ0LQQl7yyoInoWnDvbfw4tvQM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NClJpw+CgSR3IQKEpEheu2mjiO2H2WzZbKqPe57LT6UIk8K7FBxcPlwarnEfKzVDn
         8gAWXDJho7TGDI5LaaaF7F6gMQeB7bHjRAx5ujPe2tY8yy/sdR1FqKnfzf92NNlXpm
         zSDJ+ib5oZ9aFB04jqO6l+nUUrpvQ5NYX3SRRdWE=
Received: by mail-io1-f44.google.com with SMTP id s18so8736620ioe.10;
        Mon, 13 Apr 2020 23:46:13 -0700 (PDT)
X-Gm-Message-State: AGi0Puas06QcmQbZCKh4ttdAxSAlo/hcFESxvgP8gfNibv8j4WVyT3o/
        SfNxprF+7NbiZ7EmM1sJv0j1h7dWscWmm8y+i4I=
X-Google-Smtp-Source: APiQypJMSxKebGAKJDBtfpNpe+EDZUxDmYFCwE0U/ExcsDR517mslTv+CttnMfcd482NZ3+ACciJ8UYpt1LR+NzsFP4=
X-Received: by 2002:a05:6602:1550:: with SMTP id h16mr20064740iow.171.1586846772506;
 Mon, 13 Apr 2020 23:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <1586468669-21456-1-git-send-email-victor.erminpour@oracle.com>
 <CAMj1kXGgYYx=9rq-Ficw3vS6FX_0nb-hRStXijh7H4zdD=+Gaw@mail.gmail.com>
 <aee6c7cc-24c7-2822-47d5-1e05413a8024@oracle.com> <CAMj1kXFF3gR+LyE1VbLuwnRA3CzQtF90mv7rpw9x2RcyugO1JA@mail.gmail.com>
 <95f421ad-6ba7-b968-d605-c464bc1df4e2@oracle.com>
In-Reply-To: <95f421ad-6ba7-b968-d605-c464bc1df4e2@oracle.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 14 Apr 2020 08:46:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEg5YmoRg9e0T1PV43v8Fm6+88czV+bp=6XToK7PJ_qwg@mail.gmail.com>
Message-ID: <CAMj1kXEg5YmoRg9e0T1PV43v8Fm6+88czV+bp=6XToK7PJ_qwg@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub/arm64: Enable __efistub_global define in
 .data section
To:     Victor Erminpour <victor.erminpour@oracle.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 14 Apr 2020 at 00:57, Victor Erminpour
<victor.erminpour@oracle.com> wrote:
>
>
>
> On 4/10/20 11:39 PM, Ard Biesheuvel wrote:
> > On Sat, 11 Apr 2020 at 00:12, Victor Erminpour
> > <victor.erminpour@oracle.com> wrote:
> >>
> >>
> >>
> >> On 4/10/20 1:09 AM, Ard Biesheuvel wrote:
> >>> On Thu, 9 Apr 2020 at 23:44, Victor Erminpour
> >>> <victor.erminpour@oracle.com> wrote:
> >>>>
> >>>> Enable the __efistub_global define to place variables in the
> >>>> .data section for both CONFIG_ARM and CONFIG_ARM64.
> >>>>
> >>>> This places the EFIstub sys_table variable and other EFIstub
> >>>> static variables in the .data section for both CONFIG_ARM and
> >>>> CONFIG_ARM64.
> >>>>
> >>>
> >>> What does that achieve?
> >>
> >> Hi Ard,
> >>
> >> Without placing these global variables in .data, I get the
> >> following errors when booting an ARM64 EFI system:
> >>
> >> EFI stub: ERROR: Exit boot services failed.
> >> EFI stub: ERROR: Failed to update FDT and exit boot services
> >>
> >
> > Which boot loader are you using? Does this involve shim?
> >
>
> grub2-efi-aa64-2.02-0.80.0.4.el7.aarch64
> shim-aa64-15-1.0.4.el7.aarch64
>

Does your system give access to the UEFI shell? If so, could you
please try booting the [uncompressed] Image file from the command
prompt? Which hardware are you booting?

> > Also, does it help if you add 'efi=no_disable_early_pci_dma'?
> >
>
> Tried this boot time option, but to no effect.
>
> >
> >>
> >> I know that the ARM64 linker script is supposed to put the
> >> .init.bss into the .init.data section, but I don't think this
> >> is happening for all systems.
> >>
> >> Having it explicitly enabled for CONFIG_ARM64 worked for me.
> >>
> >
> > OK, thanks for the report. However, we will be removing
> > __efistub_global entirely during the next cycle, so this is not the
> > right fix.
>
> Thanks Ard, this sounds promising!
>

Quite the opposite, unfortunately. It means the feature you are using
to fix your boot issue is going away.

This really looks like a bootloader issue to me, so let's narrow this
down first. If there is a real kernel issue here that needs
__efistub_global to be fixed, we obviously won't be removing it.
