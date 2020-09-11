Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244CE266838
	for <lists+linux-efi@lfdr.de>; Fri, 11 Sep 2020 20:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgIKSXW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Sep 2020 14:23:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgIKSXS (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 11 Sep 2020 14:23:18 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB92821D40;
        Fri, 11 Sep 2020 18:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599848597;
        bh=YY2vBU2Yo4rqMxD/qeQ8+2/9DSz2T2a0UG6lbEEq3G8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q4ZuwCgX7Z+2ZOJ+NeU4ULnNdUzb+Xbc21jw35Xfapk2cL99q9nlvKuFcGO/dP4tW
         5pc+giXQQDPB/5B3farttH5r0q1GtXJY6F0mWYOOhoe7AmAWDsWGf+qLwG1n6ac/Xe
         yoK0gX0Jkou6UnrlnX9slwVTm6nQVGvp9Nb+A+3M=
Received: by mail-ot1-f44.google.com with SMTP id h17so9161084otr.1;
        Fri, 11 Sep 2020 11:23:17 -0700 (PDT)
X-Gm-Message-State: AOAM532y/PQ+iL4g+Y+Uou8ZhS8ACsMF5vxcfRBO60aj5GECeR3IVK/z
        QtUJsNg2+sinOhOrewm3uksHXPCF/QlW33VMrxM=
X-Google-Smtp-Source: ABdhPJxBcPAsLveygKkrrNoxlgHdpRQY+vCwFDpMuEgOBUXrCiwKgj/V2tpmS4Nlr8qpxhjVTweRYEeB0rXov2e7QIw=
X-Received: by 2002:a9d:6193:: with SMTP id g19mr1931544otk.108.1599848596998;
 Fri, 11 Sep 2020 11:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200828203332.11129-1-Smita.KoralahalliChannabasappa@amd.com>
 <20200828203332.11129-2-Smita.KoralahalliChannabasappa@amd.com>
 <878sdvv20h.fsf@kokedama.swc.toshiba.co.jp> <102d0c75-d642-8f8b-68c7-792499c2a62a@amd.com>
 <87a6y7qshg.fsf@kokedama.swc.toshiba.co.jp>
In-Reply-To: <87a6y7qshg.fsf@kokedama.swc.toshiba.co.jp>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 11 Sep 2020 21:23:05 +0300
X-Gmail-Original-Message-ID: <CAMj1kXGd8KgP6_-Ebec1wpxpCnjjOe4_uovcYW3GD1BA5au=3Q@mail.gmail.com>
Message-ID: <CAMj1kXGd8KgP6_-Ebec1wpxpCnjjOe4_uovcYW3GD1BA5au=3Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cper, apei, mce: Pass x86 CPER through the MCA
 handling chain
To:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Cc:     Smita Koralahalli Channabasappa <skoralah@amd.com>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devel@acpica.org, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 3 Sep 2020 at 09:34, Punit Agrawal <punit1.agrawal@toshiba.co.jp> wrote:
>
> Hi Smita,
>
> Smita Koralahalli Channabasappa <skoralah@amd.com> writes:
>
> > On 8/31/20 12:05 AM, Punit Agrawal wrote:
> >
> >> Hi Smita,
> >>
> >> A couple of comments below -
> >>
> >> Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> writes:
> >>
> >> [...]
> >>
> >>
> >>> diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
> >>> index 2531de49f56c..374b8e18552a 100644
> >>> --- a/drivers/firmware/efi/cper-x86.c
> >>> +++ b/drivers/firmware/efi/cper-x86.c
> >>> @@ -1,7 +1,7 @@
> >>>   // SPDX-License-Identifier: GPL-2.0
> >>>   // Copyright (C) 2018, Advanced Micro Devices, Inc.
> >>>   -#include <linux/cper.h>
> >> Why is the include dropped? AFAICT, the definitions from there are still
> >> being used after this patch.
> >
> > Dropped because <acpi/apei.h> already includes <linux/cper.h>
>
> Generally, you want to follow the rule that if a declaration from a
> header file is being used, it should show up in the includes. The same
> applies to both source as well as header files.
>
> It doesn't matter if another include in the source file in turn ends up
> including the same header again; the #ifdef guards are there to prevent
> duplicate declarations.
>
> The rationale is that if future changes remove the usage of
> <acpi/apei.h>, the C file can still be compiled after dropping the
> include; there should be no need to then re-introduce <linux/cper.h> at
> that point.
>
> Hope that makes sense.
>

Agreed. If the code still uses declarations from linux/cper.h after
the patch, the #include should remain.
