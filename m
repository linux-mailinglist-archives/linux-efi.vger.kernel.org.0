Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBFF275FBE
	for <lists+linux-efi@lfdr.de>; Wed, 23 Sep 2020 20:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgIWSZB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Sep 2020 14:25:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIWSZB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 23 Sep 2020 14:25:01 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44C0323772;
        Wed, 23 Sep 2020 18:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600885500;
        bh=PQ694416mkyRJSudKeRj8BUutkY/M7TaA4klpl4VyS4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Sp25cRCfXBwQvz8IEVyYDCihyBlbXyN9B/1NISrGs9y+1srSW97VOmUQ/DE41EM0C
         KvIwFSmNAZVLn5+WIb1cgtc1+M9/AGEhma8J+L2VwYv8Zhv5JJSifOvibXDbjv7L/B
         zavBT3QAfrCIoTHAYA6lJ94iYn6voP9ghpnPrRQY=
Received: by mail-ot1-f41.google.com with SMTP id h17so697446otr.1;
        Wed, 23 Sep 2020 11:25:00 -0700 (PDT)
X-Gm-Message-State: AOAM531jwKoa99XqRDfVN3FFGQQQl4Ur4isnYiE3LrvozmVWPq/SRHp/
        Gd0SGQf+8Hb3TWvj3UakWvrXBYXnuumagxhQLSQ=
X-Google-Smtp-Source: ABdhPJy9WdySVafg27Wj/nNe1H0VU72po5OOABeeZP3D0Di8Jb0nGEdDJw+uU/MGCnmXwce3EztKeBoH4saGj0jKFD8=
X-Received: by 2002:a9d:6250:: with SMTP id i16mr677534otk.77.1600885499444;
 Wed, 23 Sep 2020 11:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200904140444.161291-1-Smita.KoralahalliChannabasappa@amd.com>
 <87wo0kiz6y.fsf@kokedama.swc.toshiba.co.jp> <20200923140512.GJ28545@zn.tnic>
 <CAMj1kXH2uWEfAxTf_+6YN-Sp2VNKtaGhqAx4jyvhW3xR=0Jaug@mail.gmail.com> <20200923153941.GK28545@zn.tnic>
In-Reply-To: <20200923153941.GK28545@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 23 Sep 2020 20:24:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE2HR1Yd9rfyXp92WaB2k1YQ5wKskN0tZ1HwC5Ti+V3OA@mail.gmail.com>
Message-ID: <CAMj1kXE2HR1Yd9rfyXp92WaB2k1YQ5wKskN0tZ1HwC5Ti+V3OA@mail.gmail.com>
Subject: Re: [PATCH v4] cper, apei, mce: Pass x86 CPER through the MCA
 handling chain
To:     Borislav Petkov <bp@alien8.de>
Cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devel@acpica.org, Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 23 Sep 2020 at 17:39, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Sep 23, 2020 at 04:52:18PM +0200, Ard Biesheuvel wrote:
> > I think the question is why we are retaining this Reported-by header
> > to begin with. Even though the early feedback is appreciated,
> > crediting the bot for eternity for a version of the patch that never
> > got merged seems a bit excessive. Also, it may suggest that the bot
> > was involved in reporting an issue that the patch aims to fix but that
> > is not the case.
>
> That is supposed to be explained in [] properly so that there's no
> misreading of why that tag's there.
>
> > The last thing we want is Sasha's bot to jump on patches adding new
> > functionality just because it has a reported-by line.
>
> It should jump on patches which have Fixes: tags. But Sasha's bot is
> nuts regardless. :-)
>
> > So I suggest dropping the Reported-by credit as well as the [] context
> > regarding v1
>
> So I don't mind having a Reported-by: tag with an explanation of what
> it reported. We slap all kinds of tags so having some attribution for
> the work the 0day bot does to catch such errors is reasonable. I presume
> they track this way how "useful" it is, by counting the Reported-by's or
> so, as they suggest one should add a Reported-by in their reports.
>
> And without any attribution what the 0day bot reported, it might decide
> not to report anything next time, I'd venture a guess.
>
> And the same argument can be had for Suggested-by: tags: one could
> decide not to add that tag and the person who's doing the suggesting
> might decide not to suggest anymore.
>
> So I think something like:
>
>  [ Fix a build breakage in an earlier version. ]
> Reported-by: 0day bot
>
> is fine as long as it makes it perfectly clear what Reported-by tag
> is for and as long as ts purpose for being present there is clear, I
> don't see an issue...
>

I don't think it adds much value tbh, but I am not going to obsess
about it either.
