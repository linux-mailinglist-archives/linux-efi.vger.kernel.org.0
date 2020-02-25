Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B009116EEF9
	for <lists+linux-efi@lfdr.de>; Tue, 25 Feb 2020 20:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbgBYT2n (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Feb 2020 14:28:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:33572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731425AbgBYT2k (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 25 Feb 2020 14:28:40 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 603F524653
        for <linux-efi@vger.kernel.org>; Tue, 25 Feb 2020 19:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582658919;
        bh=No7bnjFMpZoG5H+BKpwiXz76L973BCgC/d2751ecwag=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AgkksRlijt51Q9tKY9iKGj+8UK0aw/qCD8zKaWMaH1HYuNrKTBq1GMeWJK8Fcylju
         YZIl8g2rCaS5CGhIdVSMKqYb1U3wwp0C7rwPuV1xiMhrstdqvhmmQAcSWnmIRuZmge
         ALwW9HV03ej2w12NvYlIi+bF+f/g7snhhaJRr3FI=
Received: by mail-wr1-f46.google.com with SMTP id r11so16181768wrq.10
        for <linux-efi@vger.kernel.org>; Tue, 25 Feb 2020 11:28:39 -0800 (PST)
X-Gm-Message-State: APjAAAXSr6iSgxie7UGBPRDqaEUW8XTn6fZ2r8c9IxP8nZkuPAwxDiaL
        Fut+lCyE99fPDoUQqVHbfIS7G/I7mqW+zkHYP+8bVg==
X-Google-Smtp-Source: APXvYqxiLow7+4oE/PJEkKz/tPa/dH2bB7gxC7MALajKR8VVqXXA4rfmpFYIQhg2vIXh479srq127AzGLjfx1DBezbc=
X-Received: by 2002:adf:e742:: with SMTP id c2mr671445wrn.262.1582658917548;
 Tue, 25 Feb 2020 11:28:37 -0800 (PST)
MIME-Version: 1.0
References: <261ea8108c6290e95962be2638bd204f90787c1c.1582652466.git.thomas.lendacky@amd.com>
 <CAKv+Gu_FJeiaY5yw9=ER4XyBZrDFZ5L4igrqxP6hhJ7Z8easpw@mail.gmail.com>
 <9e16fed9-4399-5c78-cbfb-6be75c295f31@amd.com> <CAKv+Gu_0LUY67DwSLU1tyijuF+0mKPpvq1j3RSMy5HBxYE-3qw@mail.gmail.com>
 <96417897-8bf0-e60c-6285-7286673ecd01@amd.com> <CAKv+Gu-5=5bKBdO_r=Z3bAqCM36vfH=vLcCcaFtKcwYpe=AP7g@mail.gmail.com>
 <b2374776-6499-0b99-9df0-b17a4d84b0e4@amd.com>
In-Reply-To: <b2374776-6499-0b99-9df0-b17a4d84b0e4@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 25 Feb 2020 20:28:26 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu8M5LMjA+JnJ57+BU4jmpgz0OqLyt1W9LXj_UDH=5DgjQ@mail.gmail.com>
Message-ID: <CAKv+Gu8M5LMjA+JnJ57+BU4jmpgz0OqLyt1W9LXj_UDH=5DgjQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/efi: Add additional efi tables for unencrypted
 mapping checks
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 25 Feb 2020 at 20:21, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 2/25/20 12:12 PM, Ard Biesheuvel wrote:
> > On Tue, 25 Feb 2020 at 19:10, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >>
> >> On 2/25/20 11:58 AM, Ard Biesheuvel wrote:
> >>> On Tue, 25 Feb 2020 at 18:54, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >>>>
> >>>> On 2/25/20 11:45 AM, Ard Biesheuvel wrote:
> >>>>> On Tue, 25 Feb 2020 at 18:41, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >>>>>>
> >>>>>> When booting with SME active, EFI tables must be mapped unencrypted since
> >>>>>> they were built by UEFI in unencrypted memory. Update the list of tables
> >>>>>> to be checked during early_memremap() processing to account for new EFI
> >>>>>> tables.
> >>>>>>
> >>>>>> This fixes a bug where an EFI TPM log table has been created by UEFI, but
> >>>>>> it lives in memory that has been marked as usable rather than reserved.
> >>>>>>
> >>>>>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> >>>>>>
> >>>>>> ---
> >>>>>> Changes since v1:
> >>>>>> - Re-spun against EFI tree
> >>>>>
> >>>>> Which one? Surely not the one in the link I included?
> >>>>
> >>>> I did a git clone of
> >>>>
> >>>>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
> >>>>
> >>>> and checked out branch next. Not sure what I missed...
> >>>>
> >>>
> >>> Weird. Do you see commit 5d288dbd88606d8f215c7138b10649115d79cadd on
> >>> that branch? It removes rng_seed from struct efi, hence my request to
> >>> rebase your patch.
> >>
> >> I had just assumed you wanted a cleaner version and didn't realize that
> >> rng_seed was removed from struct efi. My bad for not building.
> >>
> >>>
> >>> IMO, best is to simply drop the 'static' from rng_seed, rename it to
> >>> efi_rng_seed, and drop an extern declaration in linux/efi.h so it is
> >>> accessible from your code. I'm reluctant to put it back in struct efi.
> >>
> >> Ok, I'll re-work the patch.
> >>
> >
> > OK
> >
> > Btw if you want the TPM part of the fix to go to -stable, better to
> > split them in two (and I'll put a cc:stable on the tpm one)
>
> I had thought about stable, but the fix gets tricky since the two tables
> were added at different times (4.16 and 5.3) and the efi_tables array was
> moved from drivers/firmware/efi/efi.c to arch/x86/platform/efi/efi.c in 5.4.
>
> I could do the two TPM tables each as their own patch and add an
> appropriate Cc: stable # v4.16.x-, etc., if you don't think that's
> overkill. The array move shouldn't be too hard to adjust for in stable.
> Thoughts?
>

So v5.4/v5.5 seems straight-forward then, no? Once that one is in, we
can do one specially for v4.19
