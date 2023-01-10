Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EAC664341
	for <lists+linux-efi@lfdr.de>; Tue, 10 Jan 2023 15:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjAJOan (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Jan 2023 09:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjAJOam (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 Jan 2023 09:30:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BABB2FF;
        Tue, 10 Jan 2023 06:30:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5CBA6172F;
        Tue, 10 Jan 2023 14:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F164C433A7;
        Tue, 10 Jan 2023 14:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673361041;
        bh=Ft5hewhBhdYXUka/gOOBMULEVYdfXdVyhTlVravny7Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Vangzlq864OD1GjPZkelYA+gGrWvzCPKLSrgEETBuZ2fSF6GhARIqGxkHbWgaE6+4
         wXau/2qn8+CuWDTAbfyEWJ0q+/wa6OyzyQUgnXMIIQsVLNhjvqXdpD3cZ5F2c9ntnz
         XscRQYPet/Jexkxaj/TN4vWWdtv5aBsWhmI7WHPp8iIXmuhNlrgeO8hJdcFRNdQGEB
         18stxLunFmH42SKYmBV3zVlCQ+TdifHdl/4EyIIf+J8KLrRq4sBLldK719okyN0/C/
         dKNkVUFnhhlv6yzxGS+xFEn530oDwN/eE7qN7yQZ3V/eghnDH+F2EYXNnwLcqAwabr
         8WkHMuPzJYmRg==
Received: by mail-lf1-f53.google.com with SMTP id v25so18677924lfe.12;
        Tue, 10 Jan 2023 06:30:41 -0800 (PST)
X-Gm-Message-State: AFqh2koSSA/5QWHUns+uzDNzUStRYzeKJg8ZJ9Ygp3HPeOuOgu4Okeg5
        t3p+/1pBTskh4YKTtt2uxnn7harzjF7Vgaa+V8Q=
X-Google-Smtp-Source: AMrXdXsGCXl5imR+5Ag+UULiUqPiN2NPwCkctr1I4ZqlLYeykxjkAncZBtoJoiKqIgfFw96YRojd4uts4JLGGCzJdSA=
X-Received: by 2002:a05:6512:3d93:b0:4b8:9001:a694 with SMTP id
 k19-20020a0565123d9300b004b89001a694mr3292555lfv.426.1673361038907; Tue, 10
 Jan 2023 06:30:38 -0800 (PST)
MIME-Version: 1.0
References: <20221221105402.6598-1-markuss.broks@gmail.com>
 <CAMj1kXGUC7dsSwVEUsAMeAoqDYtbqrM7SDOJTXbPfi-LrcSk9g@mail.gmail.com> <Y6xMnuMqpThmFn1q@smile.fi.intel.com>
In-Reply-To: <Y6xMnuMqpThmFn1q@smile.fi.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 10 Jan 2023 15:30:27 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFtmK0jOt1Boeb6t=DoyVg6xWgCMVEB59jCm8zz7XcNAA@mail.gmail.com>
Message-ID: <CAMj1kXFtmK0jOt1Boeb6t=DoyVg6xWgCMVEB59jCm8zz7XcNAA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add generic framebuffer support to EFI earlycon driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org,
        Jami Kettunen <jami.kettunen@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Helge Deller <deller@gmx.de>, Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Muchun Song <muchun.song@linux.dev>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 28 Dec 2022 at 15:04, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Dec 23, 2022 at 03:42:33PM +0100, Ard Biesheuvel wrote:
> > (cc Andy)
>
> I believe there are two reasons I'm Cc'ed now:
> - the Cc was forgotten. because I remember reviewing some parts
>   of this contribution
> - this conflicts (to some extent) with my patch that speeds up
>   the scrolling
>
> For the first it's obvious what to do, I think Markuss can include me
> in his v4.
>
> For the second I don't see the functional clash. The scrolling in this
> series is not anyhow optimized. I think my patch should go first as
> - it is less intrusive
> - it has been tested, or can be tested easily
>
> Tell me if I'm missing something here.
>

Thanks for your input.
