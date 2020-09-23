Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91461275C20
	for <lists+linux-efi@lfdr.de>; Wed, 23 Sep 2020 17:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgIWPjv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Sep 2020 11:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgIWPjv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Sep 2020 11:39:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143DFC0613CE;
        Wed, 23 Sep 2020 08:39:51 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d130017aaf728a0fb4ec3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1300:17aa:f728:a0fb:4ec3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AE2171EC0409;
        Wed, 23 Sep 2020 17:39:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600875587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=w4olCSb8jT2RNv8xHUN26fhLNxYdkyB61t9MEo7mTLE=;
        b=bq4WYVndAySAoDrcXMKE2j/v4xOD2eIjmidsATkH23MZkCe6wd2xyNQlmxzWR5LCLSl9D2
        7+gK6lYDLVIOlVELUR2Kx24fmSYSDQkLBiJhOWpiel/I6b7WF2aS4IakPs4v0eqXCO8eRf
        nTXxR4HWsYWYb1zVhkQi2nKk2Pw4EfY=
Date:   Wed, 23 Sep 2020 17:39:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
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
Subject: Re: [PATCH v4] cper, apei, mce: Pass x86 CPER through the MCA
 handling chain
Message-ID: <20200923153941.GK28545@zn.tnic>
References: <20200904140444.161291-1-Smita.KoralahalliChannabasappa@amd.com>
 <87wo0kiz6y.fsf@kokedama.swc.toshiba.co.jp>
 <20200923140512.GJ28545@zn.tnic>
 <CAMj1kXH2uWEfAxTf_+6YN-Sp2VNKtaGhqAx4jyvhW3xR=0Jaug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXH2uWEfAxTf_+6YN-Sp2VNKtaGhqAx4jyvhW3xR=0Jaug@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Sep 23, 2020 at 04:52:18PM +0200, Ard Biesheuvel wrote:
> I think the question is why we are retaining this Reported-by header
> to begin with. Even though the early feedback is appreciated,
> crediting the bot for eternity for a version of the patch that never
> got merged seems a bit excessive. Also, it may suggest that the bot
> was involved in reporting an issue that the patch aims to fix but that
> is not the case.

That is supposed to be explained in [] properly so that there's no
misreading of why that tag's there.

> The last thing we want is Sasha's bot to jump on patches adding new
> functionality just because it has a reported-by line.

It should jump on patches which have Fixes: tags. But Sasha's bot is
nuts regardless. :-)

> So I suggest dropping the Reported-by credit as well as the [] context
> regarding v1

So I don't mind having a Reported-by: tag with an explanation of what
it reported. We slap all kinds of tags so having some attribution for
the work the 0day bot does to catch such errors is reasonable. I presume
they track this way how "useful" it is, by counting the Reported-by's or
so, as they suggest one should add a Reported-by in their reports.

And without any attribution what the 0day bot reported, it might decide
not to report anything next time, I'd venture a guess.

And the same argument can be had for Suggested-by: tags: one could
decide not to add that tag and the person who's doing the suggesting
might decide not to suggest anymore.

So I think something like:

 [ Fix a build breakage in an earlier version. ]
Reported-by: 0day bot

is fine as long as it makes it perfectly clear what Reported-by tag
is for and as long as ts purpose for being present there is clear, I
don't see an issue...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
