Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5142762B8
	for <lists+linux-efi@lfdr.de>; Wed, 23 Sep 2020 23:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgIWVCw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Sep 2020 17:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgIWVCw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Sep 2020 17:02:52 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C573C0613D1
        for <linux-efi@vger.kernel.org>; Wed, 23 Sep 2020 14:02:52 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f1so358987plo.13
        for <linux-efi@vger.kernel.org>; Wed, 23 Sep 2020 14:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CUC9K3dEL2hB4V0jU6qeK75cHX30YcxDUaS7J9CEnqw=;
        b=ZWKjzla4G0Whff6qOnJmf4q4ZgSR4pu+SYJyHD4rChnqXiftmthkZtMCryFYJ+AgKm
         /P3bITmJAoIv1aDo7J6i59wz2BgytVCxY5BDyZyF5tO12iu5WuxBvdplIhhvXFLmdW6U
         AwikORFojCAMGSwoGpo7cVAgWVvujGTSvdRU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CUC9K3dEL2hB4V0jU6qeK75cHX30YcxDUaS7J9CEnqw=;
        b=K4M8MBkSaZuL4zdjWuLR8pJCI/YN9tqAyWHW9BGvAExbkK9MBlkd79o6COIfjsLezV
         0i9V4xXrrAYxVxXxF3dNG5mF+cXjy59fs6tJ8ZKq/QV6JKx1S26OhlvF6W2NiROylRMY
         M5s7w9iNgvl6gT9azw+aZyGwrNjfJm88PnnH1LuuJ7ajUMrhL+UFOTMS4QC3Hu3Vo7U1
         IxidDprTlan82JChTsgXeXcRE+5dM6XDhbPcdO3khds+iYhB/ZWJd9O3gnffQuE6uPn1
         0gxUucETt9dPBMkCcCO/I5yAl/zElMZLHeaBuypujWARZOyddACBrGPuYkZ+LLhC3foJ
         +YCA==
X-Gm-Message-State: AOAM5324v2yiHMYozEYAe2p+iaRWlDDN8/BJmNQw68XLTNBQwNQP9bV+
        t7mChWBJeRYA6QPF2BjHx5kouQ==
X-Google-Smtp-Source: ABdhPJz6YlD1PTJXLmB5RxC4afNF/67V7gCRw8d5CRd7/y/DXsELp3q9+x7e/mU97/M4umQHW8P3Cg==
X-Received: by 2002:a17:90b:1812:: with SMTP id lw18mr994545pjb.133.1600894971623;
        Wed, 23 Sep 2020 14:02:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u15sm534468pfm.61.2020.09.23.14.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 14:02:50 -0700 (PDT)
Date:   Wed, 23 Sep 2020 14:02:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 1/7] efi: pstore: disentangle from deprecated efivars
 module
Message-ID: <202009231400.E52D1C7E7@keescook>
References: <20200923161404.17811-1-ardb@kernel.org>
 <20200923161404.17811-2-ardb@kernel.org>
 <202009231140.B4648C6@keescook>
 <CAMj1kXFFs2rLMn5kdY9CGsz32ctBshb93iN7yBtZNHYwW2mWnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFFs2rLMn5kdY9CGsz32ctBshb93iN7yBtZNHYwW2mWnw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Sep 23, 2020 at 08:43:21PM +0200, Ard Biesheuvel wrote:
> On Wed, 23 Sep 2020 at 20:41, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Sep 23, 2020 at 06:13:58PM +0200, Ard Biesheuvel wrote:
> > > The EFI pstore implementation relies on the 'efivars' abstraction,
> > > which encapsulates the EFI variable store in a way that can be
> > > overridden by other backing stores, like the Google SMI one.
> > >
> > > On top of that, the EFI pstore implementation also relies on the
> > > efivars.ko module, which is a separate layer built on top of the
> > > 'efivars' abstraction that exposes the [deprecated] sysfs entries
> > > for each variable that exists in the backing store.
> > >
> > > Since the efivars.ko module is deprecated, and all users appear to
> > > have moved to the efivarfs file system instead, let's prepare for
> > > its removal, by removing EFI pstore's dependency on it.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > With this and the other pstore patch, do the pstore self-tests still
> > pass on an EFI system?
> >
> > If so, please consider both:
> >
> > Acked-by: Kees Cook <keescook@chromium.org>
> >
> 
> Selftests? Excellent! Are they documented too?

Not really, but they're pretty simple:

cd tools/testing/selftests/pstore
*double-check "config" against running kernel config*
./pstore_tests
./pstore_crash_test
*wait for system to reboot*
cd tools/testing/selftests/pstore
./pstore_post_reboot_tests

(though please test before/after, just to make sure other deltas haven't
broken things before your series -- I don't test EFI pstore with high
frequency)

-- 
Kees Cook
