Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E675AF250
	for <lists+linux-efi@lfdr.de>; Tue,  6 Sep 2022 19:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbiIFRV3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Sep 2022 13:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiIFRVN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Sep 2022 13:21:13 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A6383F39
        for <linux-efi@vger.kernel.org>; Tue,  6 Sep 2022 10:10:02 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1278624b7c4so11514324fac.5
        for <linux-efi@vger.kernel.org>; Tue, 06 Sep 2022 10:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=RzrA7ZBqVYMtFibz+PW8VCdXaj2t3XdsPwt06YL85hI=;
        b=UTjgO6GvV4ki/VbfOVVNw+OD38IBtEz+scRoNXxg6ENaDmVLP3vZfH3zrGpDwMTEIu
         0bv1+umxmtvjSnBXt0EdHZFt0HmjdceNXvwcPXIlqw1fkEQdfyc/76126TBXM9xIcMu9
         jg41E2FJzPGWvYAp8eumaYKQxMEW/E9GAOOy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=RzrA7ZBqVYMtFibz+PW8VCdXaj2t3XdsPwt06YL85hI=;
        b=i1jpxvOdkUQiqT/GkUzElpZFnCcj/a/dsJd5Bd1bVUGeicNus6TdYJON2+PzdEm0Dh
         StOqubC0B+emKif7VS9y79eiE+cLUq4OV0cU3Ww7lhIKcgNzFLXJrH4C6DMhq9OaLhlJ
         h9UmX+E85E4mDV0bsA+f2nFk4y0D/MGvqj9wpNjOINVv+FbCP1xnDIKLnqHktsMtD7L0
         q67uzoTn6TzvnalWM0KLkx/52hGE1pv7sCcjCDoCoAHBbP3hrz3i3eGZFR+3blEusEDI
         5N0NGWjWwWsnLsIUVhgY3ydb3s4jLkBXpOD/SntmvjMMwsOFB1n9Eg2AnWaD8q0kNiGW
         g67A==
X-Gm-Message-State: ACgBeo0r66m2YNzV+D6f7APFzEmcag7sW9gTL1/NubL/mK62aFlvX50M
        YTFGgxpavghcdQouf+tdkPb5+fMj2a9qUA==
X-Google-Smtp-Source: AA6agR6ZYowqYaZNVnWl0XHPDqJobbP4/m7quLOGY1HuQ+I9j0HitGqi6pATbfsr93nK4VsM8k4FtA==
X-Received: by 2002:a05:6870:5820:b0:11c:b6d0:b84c with SMTP id r32-20020a056870582000b0011cb6d0b84cmr11940636oap.236.1662484201195;
        Tue, 06 Sep 2022 10:10:01 -0700 (PDT)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com. [209.85.160.54])
        by smtp.gmail.com with ESMTPSA id x14-20020a056870a78e00b0011bde9f5745sm6644958oao.23.2022.09.06.10.10.00
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 10:10:00 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-11eab59db71so29667749fac.11
        for <linux-efi@vger.kernel.org>; Tue, 06 Sep 2022 10:10:00 -0700 (PDT)
X-Received: by 2002:a05:6871:7a4:b0:11e:b321:c396 with SMTP id
 o36-20020a05687107a400b0011eb321c396mr11686290oap.241.1662484200169; Tue, 06
 Sep 2022 10:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220819155059.451674-1-gpiccoli@igalia.com> <YxDVPqVkdgQbAIvY@kroah.com>
 <f89cd87c-7d1c-d8e6-ed95-6876f0201872@igalia.com> <YxDX9+p+58q2sip2@kroah.com>
 <6bc5dbc3-2cdd-5cb8-1632-11de2008a85a@igalia.com> <YxDhiSDs4YcUrqV5@kroah.com>
 <85683284-db85-7e3a-57bd-750e1c204e3e@igalia.com> <YxD56RTI9v/P2QOL@kroah.com>
 <b050f00b-6c3a-a0d9-a3c1-175a724faf1c@igalia.com> <YxEBCVRgWE8VTZaf@kroah.com>
 <794efe45-2fef-0d3f-b6d0-f2f451be850c@igalia.com> <20220901151320.3cff1767f88cfb33f394e9cb@linux-foundation.org>
In-Reply-To: <20220901151320.3cff1767f88cfb33f394e9cb@linux-foundation.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 6 Sep 2022 10:09:24 -0700
X-Gmail-Original-Message-ID: <CAE=gft7bZ0DaX3YuVq4BgruC3JFSBvO=NQsak=K1cM3qh1qJww@mail.gmail.com>
Message-ID: <CAE=gft7bZ0DaX3YuVq4BgruC3JFSBvO=NQsak=K1cM3qh1qJww@mail.gmail.com>
Subject: Re: [PATCH V3] firmware: google: Test spinlock on panic path to avoid lockups
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel@gpiccoli.net, Ard Biesheuvel <ardb@kernel.org>,
        David Gow <davidgow@google.com>,
        Julius Werner <jwerner@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 1, 2022 at 3:13 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 1 Sep 2022 16:02:08 -0300 "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:
>
> > On 01/09/2022 15:59, Greg KH wrote:
> > > [...]
> > > Ick, I don't know, this all feels odd.  I want someone else to review
> > > this and give their ack on the patch before I'll take it so someone else
> > > can share in the blame :)
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > LOL, that's OK for me! Evan seems to be fine with it BTW.
> >
> > Let's see if Petr can jump in, also adding Andrew here since he's
> > usually merging stuff for panic.
>
> Are the usual gsmi developers not operational?

I'm unsure who that is, I sort of Mr. Beaned my way in here having
touched the file recently. A lot of the people who historically
touched this file have gone.

>
> Patch seems sensible to me, although the deadlock sounds pretty
> theoretical.  A better code comment might be simply
>
>         /*
>          * Panic callbacks are executed with all other CPUs stopped, so we must
>          * not attempt to spin waiting for gsmi_dev.lock to be released.
>          */
>
> ?

I basically came to the same conclusion as Andrew. It seems like this
patch does fix a problem, which is a panic coming in on another CPU
and NMIing on top of a CPU doing a normal operation holding this lock.
The problem seems pretty theoretical, but I suppose I don't have
numbers one way or another since any attempt to gather numbers would
be reliant on this very mechanism. My Reviewed-by tag is already on
there.
-Evan
