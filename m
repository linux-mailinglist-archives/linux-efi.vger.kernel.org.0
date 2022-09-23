Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480715E84C4
	for <lists+linux-efi@lfdr.de>; Fri, 23 Sep 2022 23:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiIWVTt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Sep 2022 17:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiIWVTr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 23 Sep 2022 17:19:47 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C339286D1
        for <linux-efi@vger.kernel.org>; Fri, 23 Sep 2022 14:19:45 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id w10so1242892pll.11
        for <linux-efi@vger.kernel.org>; Fri, 23 Sep 2022 14:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ZnB23LLp/vlB+ryCWR3RfzNeLIOvdyceafUVjogXEh8=;
        b=Y0ehwZOs+7K7MVGIhod7Oz82juhcilJsd4wl7E7yhwCNzs0m2pNmp9XEEfoPUh6mNC
         rOHJpV9AYYiNrGQgNITm72gcxDBIDDUvag8cZ/PJV24RhHG7n7IWH65/OiySYH0R6YLB
         LMZVh3V1mGG6AIVleW4VIPVY6lhqB3r4vbsz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZnB23LLp/vlB+ryCWR3RfzNeLIOvdyceafUVjogXEh8=;
        b=ie8PNdg+tyKvS4OWpBfhfmKM/6Ce1YxNkor5zfI/vgORS3fzvPeUyjxTidl1SApuiS
         HJJvk21SOEnVNQ0PS+aLseVeDWl14cVl4DxTRp2iwLgcZjakwMLzdCfr5zqu+TrX4136
         7JkbrDrXDZg5+vW3918b8m3rnIiQUg6CDkeR9Oa/zf1aWkVFwcIgIaz68WTduhW5R9dI
         d5dWEajRzD5KrfRv7CJ8cu/UAdEFkXQEnTN9rgGjut3rxfvjNg34XD2j0du1Sa7cDIhH
         2f9gq6mqb8HmdVxYv2bMMy/HuayTRmBu0L+OvMne0Mxm5lt480E5yLlaijdsM5QZnGFa
         EHww==
X-Gm-Message-State: ACrzQf0KwMuIb/SfrwaSei9QHZ0FwvPkZZDLfjCzTH8TUNCsCVycem5B
        v0iEvXNBIzTZ0YW6nbD3jP114A==
X-Google-Smtp-Source: AMsMyM7aSk+mgvNkxhO3PAF0I3gXdX+yml32CiH6ECVZxXMsQdqv44K9s+DqCiaekrj/oHbACSgxpw==
X-Received: by 2002:a17:90b:1bc3:b0:203:84d:59b1 with SMTP id oa3-20020a17090b1bc300b00203084d59b1mr23683457pjb.37.1663967984643;
        Fri, 23 Sep 2022 14:19:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902eb8c00b0016dbe37cebdsm6230493plg.246.2022.09.23.14.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 14:19:43 -0700 (PDT)
Date:   Fri, 23 Sep 2022 14:19:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/mm+efi: Avoid creating W+X mappings
Message-ID: <202209231417.F73F40060@keescook>
References: <08906193-246b-c874-8bac-1d98d2313ac4@roeck-us.net>
 <20220922193157.1673623-1-dave.hansen@linux.intel.com>
 <CAMj1kXHcF_iK_g0OZSkSv56Wmr=eQGQwNstcNjLEfS=mm7a06w@mail.gmail.com>
 <Yy1ZadE6Vnnc2dNf@hirez.programming.kicks-ass.net>
 <CAMj1kXEvt-TQzO5jO6srkC8jW5fbou95VKu=os3gt_y87ZPJWg@mail.gmail.com>
 <5f443915-b38a-c78d-cccd-876501434cef@roeck-us.net>
 <CAMj1kXEt1RwYbkBOFa=KsML0KvJ6Zuu9eJ_=jQA7BTW-N2BSeA@mail.gmail.com>
 <202209231126.6855D54@keescook>
 <CAMj1kXHckEg6rwBSEc6piu=-JZzyDh7j+pvGSFp1OBUQuofrEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHckEg6rwBSEc6piu=-JZzyDh7j+pvGSFp1OBUQuofrEQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Sep 23, 2022 at 09:53:02PM +0200, Ard Biesheuvel wrote:
> On Fri, 23 Sept 2022 at 20:31, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Sep 23, 2022 at 04:26:58PM +0200, Ard Biesheuvel wrote:
> > > I was basically making the point that we still support i386 without
> > > PAE (which is a prerequisite for supporting non-executable mappings),
> > > and if we are going to be pedantic about security on this
> > > architecture, we should probably make PAE mandatory as well.
> >
> > My expectation would be that if someone is running modern kernels on i386,
> > they're not using PAE. If they care about PAE, I'd expect them to have
> > long since moved to x86_64.
> >
> 
> Not sure I follow. If they care about PAE, they turn it on. Or do you
> mean 'if they care about being able to address lots of physical
> memory'? Because the *other* reason you might care about PAE is
> because it gives you NX support.

Right, I meant if they care about NX (and the topic of this thread)
they want PAE, and if they want PAE, they likely moved to x86_64 long
long ago for new kernels.

> But currently, PAE is not even enabled in the i386_defconfig, and
> defaults to off. This means people that are unaware of this won't
> enable it, and will be running without NX support.

And they all make me cry. ;)

> > > If we are ok with the current state, enabling this permission check on
> > > i386 makes no sense.
> >
> > I'd agree. If it's a choice between "spend a lot of time making sure
> > this works correctly on i386" and "don't do this at all on i386", I
> > would pick the latter. If someone steps up to do the former, then by
> > all means take the patches.
> >
> 
> OK, so it seems we're all in violent agreement here. And if there is
> ever a push for enabling security features on 32-bit, we can add this
> to the laundry list of things that need to be looked at.

Yup.

-- 
Kees Cook
