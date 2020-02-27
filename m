Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 158D31723DF
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2020 17:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbgB0Qre (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Feb 2020 11:47:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730194AbgB0Qre (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 27 Feb 2020 11:47:34 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E878246A8
        for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2020 16:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582822053;
        bh=zFCtdq9lDibBY2R4Cfy+kdhBHuov31lyU99yd4eTIfQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=v32/0eP7CbEqQtuvt4rIkWhqyV8S9iTjwqJAYahDI7YyBOdnMB5YpKzDE1M6tZmoa
         CDdJV+PAsiLDwgwTQaYbE0c0u6ZNxLo27z5POKwkbyhpEJsqdaG8GzbYhHQjUO460r
         jRSJHlkqDcSl+/ldouHrCVgfjT8EDuiPrVA7wezw=
Received: by mail-wr1-f48.google.com with SMTP id z15so4310167wrl.1
        for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2020 08:47:33 -0800 (PST)
X-Gm-Message-State: APjAAAXclcB4VqAaQYg24+Zgnqpt/Y7LArQxCvCJbqSz2qTblMYNosfE
        mR3ADJViafMRPz2Y/lcJwW+R7UvDGiX7boyFeiHgbQ==
X-Google-Smtp-Source: APXvYqx3QudW1fMdO5KKlDSTNX1DTAxJpNB/3A3sJsXk14ObnAF1HGulI/nnOXQXMxmx8Jv8aP9tPPXYpnzDZEZlfHI=
X-Received: by 2002:adf:e742:: with SMTP id c2mr5654064wrn.262.1582822051488;
 Thu, 27 Feb 2020 08:47:31 -0800 (PST)
MIME-Version: 1.0
References: <20200226165738.11201-1-ardb@kernel.org> <CACRpkdZ9WR7wEjgscAF=Pwy0=YwbNPjtH6BQWa5wfXW74Md4xQ@mail.gmail.com>
 <91023d8f118440439cf55847a6bc43c2@kernel.org>
In-Reply-To: <91023d8f118440439cf55847a6bc43c2@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 27 Feb 2020 17:47:19 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_smwr3RDW=B8BQ8AG1+aOibFHwvoTSR=F2TxDguV2ELQ@mail.gmail.com>
Message-ID: <CAKv+Gu_smwr3RDW=B8BQ8AG1+aOibFHwvoTSR=F2TxDguV2ELQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] ARM: decompressor: use by-VA cache maintenance for
 v7 cores
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 27 Feb 2020 at 17:01, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-02-27 10:11, Linus Walleij wrote:
> > On Wed, Feb 26, 2020 at 5:57 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> >> So instead, switch to the by-VA cache maintenance that the
> >> architecture
> >> requires for v7 and later (and ARM1176, as a side effect).
> >>
> >> Changes since v3:
> >> - ensure that the region that is cleaned after self-relocation of the
> >> zImage
> >>   covers the appended DTB, if present
> >>
> >> Apologies to Linus, but due to this change, I decided not to take your
> >> Tested-by into account, and I would appreciate it if you could retest
> >> this version of the series? Thanks.
> >
> > No problem, I have tested it on the following:
> >
> > - ARMv7 Cortex A9 x 2 Qualcomm APQ8060 DragonBoard
> > - ARM PB11MPCore (4 x 1176)
>
> <pedant>
>
> The ARM11MPCore isn't a bunch of 1176s glued together. It is actually a
> very
> different CPU, designed by a different team.
>
> </pedant>
>

It still takes the same code path in the cache routines, afaict:
- the architecture field in the main id register == 0xf, so it uses
__armv7_mmu_cache_flush
- ID_MMFR1[19:16] == 0x2, so it does not take the 'hierarchical' code
path which is modified by these patches





> > - ARMv7 Ux500 Cortex A9 x 2
> >
> > The PB11MPCore is again the crucial board, if it work on that
> > board it works on anything, most of the time :D
>
> That I can only agree with! ;-)
>
>          M.
> --
> Jazz is not dead. It just smells funny...
