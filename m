Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E5D2313A6
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jul 2020 22:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgG1UMd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jul 2020 16:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgG1UM2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jul 2020 16:12:28 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C5FC0619D7
        for <linux-efi@vger.kernel.org>; Tue, 28 Jul 2020 13:12:28 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id c6so539096pje.1
        for <linux-efi@vger.kernel.org>; Tue, 28 Jul 2020 13:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lGODvQAyFgiIakAvcuOrB55CdYdcOaQbABBPHmSlK8A=;
        b=KXX8Mkn7MNftP6mJ42ju7ovK7oMAAX0wGRB0ry7w+mD/hsCbKEyPUIfLQgdll+U1Hq
         4xQS018nhgkGgLPtgROQlYsblo5NoExjDQhzJknpZmFPr1lJDow/rdW50/9T5e1TGb0u
         4gJoD0vzQnv64fwnh0m/ejgnfnf0ndm6GA1nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lGODvQAyFgiIakAvcuOrB55CdYdcOaQbABBPHmSlK8A=;
        b=DLHZtkNmJ8acxojZ/zJj+gPWVl0bOC1Yh5jYIfYZDVg5j7UCFh0TczZQjH0DHPVCpT
         im2WJSaQOt+4iqUUUMkCkiiV1nOsMwawHOH778FhCXXj1HDZDdCKVsarm1OFXLBjmxsu
         2UEOjZ5r5jgx4G3COfG9mWJWdblfLeuS/mKM8bE2OnK+25+2ZujXTJmSgSorWJ3wmK3o
         Rm3Rp2d1TmeF/6a1L5WFbM+X1D3u+j5o+uznWntKJejW7Flv7OzNJ3T7hvUBkbj2Gca0
         uheNfbiYpK92CmW/l80j+CX88Tbe1yBbqL1ybv24TGT41B5jGAy7gnxNYsIutacJNLhk
         jGxg==
X-Gm-Message-State: AOAM533r61sbIM12ef/BILaqbczO7omuihTEGj+5CM6F9Nu2GtASTePy
        lIuQuoonyLB2BjOch5EdOQRzRg==
X-Google-Smtp-Source: ABdhPJyFIgRmVJfBhFlzPKJj5terbzmemlEZoh3fyIw7tCG0VwJkPldmQbeJoogxX3pMzlVW5vctfw==
X-Received: by 2002:a17:90a:2207:: with SMTP id c7mr6611771pje.206.1595967148091;
        Tue, 28 Jul 2020 13:12:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q17sm22220199pfk.0.2020.07.28.13.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 13:12:27 -0700 (PDT)
Date:   Tue, 28 Jul 2020 13:12:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mimi Zohar <zohar@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 15/19] IMA: Add support for file reads without contents
Message-ID: <202007281311.F2F5A7ED5@keescook>
References: <20200724213640.389191-1-keescook@chromium.org>
 <20200724213640.389191-16-keescook@chromium.org>
 <1595856214.4841.86.camel@kernel.org>
 <202007281244.2F2681AE9@keescook>
 <20200728195640.GA342741@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728195640.GA342741@kroah.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jul 28, 2020 at 09:56:40PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jul 28, 2020 at 12:44:50PM -0700, Kees Cook wrote:
> > On Mon, Jul 27, 2020 at 09:23:34AM -0400, Mimi Zohar wrote:
> > > On Fri, 2020-07-24 at 14:36 -0700, Kees Cook wrote:
> > > > From: Scott Branden <scott.branden@broadcom.com>
> > > > 
> > > > When the kernel_read_file LSM hook is called with contents=false, IMA
> > > > can appraise the file directly, without requiring a filled buffer. When
> > > > such a buffer is available, though, IMA can continue to use it instead
> > > > of forcing a double read here.
> > > > 
> > > > Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> > > > Link: https://lore.kernel.org/lkml/20200706232309.12010-10-scott.branden@broadcom.com/
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > 
> > > After adjusting the comment below.
> > > 
> > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > 
> > Sure!
> > 
> > Greg, shall I send a v4 with added Reviews and the comment change or is
> > that minor enough that you're able to do it?
> 
> v4 is needed, as this series is a mess of reviewes and you will have to
> redo at least one patch and drop some others, right?

Well, I wasn't sure what your desire was, given the weirdness of taking
some and reverting others. I will do a v4 based on driver-core-next.

Thanks!

-- 
Kees Cook
