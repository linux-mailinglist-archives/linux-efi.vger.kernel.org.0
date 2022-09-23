Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B588F5E82B6
	for <lists+linux-efi@lfdr.de>; Fri, 23 Sep 2022 21:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiIWTxS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Sep 2022 15:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIWTxR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 23 Sep 2022 15:53:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82CC130703;
        Fri, 23 Sep 2022 12:53:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DEE261213;
        Fri, 23 Sep 2022 19:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B233BC43141;
        Fri, 23 Sep 2022 19:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663962795;
        bh=xhz34ezDsLLB9e/TAmZSV/ZoneLoT8i1oA+ygplKrdU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=laWqnxoJxbYyKJFgCJ29Xa2Tmy0hYQxx6TYy1WOUMLBRSV7IKRH9ENL7otP5Bqp2b
         UkIpdXe0jWHUz9SN3uiCGCtvyyaWVe/GLKn8+hJuxvHPVwoJv/e8CkrFPl7zyaNhfs
         Ywp1JmxNpoiXurd0RE+rGR5QmC3+ShifE6PkWLjhuKiTRzQRk7YqU5p0rS1Lv4Rx1d
         EZSRyQs2Asq8vwnou9De3fXmL4eMRbtQ6sa6zhquREEiXUjeHwDxSi9pm234CijLjX
         62+Iega3GLCVlHBuaredTOnBW3RsNPyKXeb8/HXWMKcjrTAzS1ibh004W9sviaR33i
         2eByOThVgJaUA==
Received: by mail-lf1-f45.google.com with SMTP id a8so1815350lff.13;
        Fri, 23 Sep 2022 12:53:15 -0700 (PDT)
X-Gm-Message-State: ACrzQf3/P2iB8fmmL6r0mjEaFVS36ztkQvm1C2nBh+WdS/g62yGBQ5mX
        V4ld2mJltXmXJGhLzaFkxyMz9Uqm9uSRpsLwBTo=
X-Google-Smtp-Source: AMsMyM5KGef75Ca7n67wpQr6n6oj5ilDKSOH2T9BDnd2LTYP8BYSAov7BsA4SkGCONw8XYd80LpYTDeXNG2hTBCVNQg=
X-Received: by 2002:a05:6512:ba1:b0:498:9890:1bb4 with SMTP id
 b33-20020a0565120ba100b0049898901bb4mr3681074lfv.122.1663962793610; Fri, 23
 Sep 2022 12:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <08906193-246b-c874-8bac-1d98d2313ac4@roeck-us.net>
 <20220922193157.1673623-1-dave.hansen@linux.intel.com> <CAMj1kXHcF_iK_g0OZSkSv56Wmr=eQGQwNstcNjLEfS=mm7a06w@mail.gmail.com>
 <Yy1ZadE6Vnnc2dNf@hirez.programming.kicks-ass.net> <CAMj1kXEvt-TQzO5jO6srkC8jW5fbou95VKu=os3gt_y87ZPJWg@mail.gmail.com>
 <5f443915-b38a-c78d-cccd-876501434cef@roeck-us.net> <CAMj1kXEt1RwYbkBOFa=KsML0KvJ6Zuu9eJ_=jQA7BTW-N2BSeA@mail.gmail.com>
 <202209231126.6855D54@keescook>
In-Reply-To: <202209231126.6855D54@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 23 Sep 2022 21:53:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHckEg6rwBSEc6piu=-JZzyDh7j+pvGSFp1OBUQuofrEQ@mail.gmail.com>
Message-ID: <CAMj1kXHckEg6rwBSEc6piu=-JZzyDh7j+pvGSFp1OBUQuofrEQ@mail.gmail.com>
Subject: Re: [PATCH] x86/mm+efi: Avoid creating W+X mappings
To:     Kees Cook <keescook@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 23 Sept 2022 at 20:31, Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Sep 23, 2022 at 04:26:58PM +0200, Ard Biesheuvel wrote:
> > I was basically making the point that we still support i386 without
> > PAE (which is a prerequisite for supporting non-executable mappings),
> > and if we are going to be pedantic about security on this
> > architecture, we should probably make PAE mandatory as well.
>
> My expectation would be that if someone is running modern kernels on i386,
> they're not using PAE. If they care about PAE, I'd expect them to have
> long since moved to x86_64.
>

Not sure I follow. If they care about PAE, they turn it on. Or do you
mean 'if they care about being able to address lots of physical
memory'? Because the *other* reason you might care about PAE is
because it gives you NX support.

But currently, PAE is not even enabled in the i386_defconfig, and
defaults to off. This means people that are unaware of this won't
enable it, and will be running without NX support.

> > If we are ok with the current state, enabling this permission check on
> > i386 makes no sense.
>
> I'd agree. If it's a choice between "spend a lot of time making sure
> this works correctly on i386" and "don't do this at all on i386", I
> would pick the latter. If someone steps up to do the former, then by
> all means take the patches.
>

OK, so it seems we're all in violent agreement here. And if there is
ever a push for enabling security features on 32-bit, we can add this
to the laundry list of things that need to be looked at.
