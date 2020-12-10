Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF96E2D64AD
	for <lists+linux-efi@lfdr.de>; Thu, 10 Dec 2020 19:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404038AbgLJSPQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Dec 2020 13:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404008AbgLJSPH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Dec 2020 13:15:07 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02994C061793;
        Thu, 10 Dec 2020 10:14:26 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id j26so4257403qtq.8;
        Thu, 10 Dec 2020 10:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6lQX2FldVB+bLmR42AkAT2yi0jmfQ4FehMvr0nrqseU=;
        b=N/BIxXFngYt4QguTVZ2jczepx9fgn6T3GV3BWcRl0HanPxq6M7+SGjJJjOP10itcYb
         RxBgomfvlhCMGihlPZwWQzorjVLpUaAx3Zu3+G6VTNc6IAsTMulq84j8L8pvdOhIZpRs
         2y0/ZXGi0fFmvXmr6QQcgFLaf7zOvtK4QfVxbuvCWLUTxwM9IHdsQzieIyLF327th+Ee
         +3YWM38Wo5mVyH3OpqQmM0K9PNaSXHguhx5MlGGMtl37lKdBi0nRv27VuOgcwHeh38Il
         4zicXIO27pWBMnhNSgyBn48p/FS4W/c1zTLxNVVHQ06gP5vb65zQpkd9jcXP9nP6fJKK
         6LaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=6lQX2FldVB+bLmR42AkAT2yi0jmfQ4FehMvr0nrqseU=;
        b=DoZeIUtKxXN82C55JKGGYgICLPX98Xtfa8aJqASDOaNYcUMc3JLtkunzeo6BwYzGgo
         MAibf65RcR4Ns0JH6AECK8in4LQOYroBPJ54NvPPaeHJpCwQYS2CVnk+wczaxcW70mZb
         jCgddvIdNcuNHEVpaS3iCQWpL0G4pXHWBIrfDBhHeI0m2dgsUlXA9eNE9Ce/401FvXKR
         JZuFqsO0OkYtXHjQfbV+rXfWVQaHoe6VZ4Gg1Yv2fznl1p5w2cCB35VlN+T6Z6mqFw2f
         5baq8TAKf8G1LhWftfZMbA2Sl15ZE/4k5hq1yQnlfahinLBhYSvTCp1opVuqF7wpcm3P
         fCgg==
X-Gm-Message-State: AOAM530volqHrkL9G10U0U0Il3IGVTOIJEeNXa497MedZxUDjZ1Y0fcH
        Q10RpSY20TBtDeOTksSW8s4=
X-Google-Smtp-Source: ABdhPJw3DHAqyZDvYkdICh5kJLDy8H+C/LiLc1aDsg0kMLtEks+IDsxdsk3RId6f9u2VaL/7LZkICQ==
X-Received: by 2002:ac8:6e8b:: with SMTP id c11mr10913048qtv.314.1607624065094;
        Thu, 10 Dec 2020 10:14:25 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p23sm3302515qtu.53.2020.12.10.10.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 10:14:24 -0800 (PST)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 10 Dec 2020 13:14:22 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        laniel_francis@privacyrequired.com,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 07/12] efi: Replace strstarts() by
 str_has_prefix().
Message-ID: <X9Jlfqiu/vCOAm3U@rani.riverdale.lan>
References: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
 <20201204170319.20383-8-laniel_francis@privacyrequired.com>
 <CAMj1kXEQhT_LF5FDBO3-S7pBn55wG59bQUVr2q58A4FhqodY8Q@mail.gmail.com>
 <ab769a5188394cd3379cc627d14a0222050a1367.camel@HansenPartnership.com>
 <CAMj1kXFvCZKH-Bbvu-V5-GxcTun8yz98igeFxRc1tTswbttM0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFvCZKH-Bbvu-V5-GxcTun8yz98igeFxRc1tTswbttM0w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Dec 05, 2020 at 08:36:02PM +0100, Ard Biesheuvel wrote:
> On Fri, 4 Dec 2020 at 19:02, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> >
> > On Fri, 2020-12-04 at 18:07 +0100, Ard Biesheuvel wrote:
> > > On Fri, 4 Dec 2020 at 18:06, <laniel_francis@privacyrequired.com>
> > > wrote:
> > > > From: Francis Laniel <laniel_francis@privacyrequired.com>
> > > >
> > > > The two functions indicates if a string begins with a given prefix.
> > > > The only difference is that strstarts() returns a bool while
> > > > str_has_prefix()
> > > > returns the length of the prefix if the string begins with it or 0
> > > > otherwise.
> > > >
> > >
> > > Why?
> >
> > I think I can answer that.  If the conversion were done properly (which
> > it's not) you could get rid of the double strings in the code which are
> > error prone if you update one and forget another.  This gives a good
> > example: 3d739c1f6156 ("tracing: Use the return of str_has_prefix() to
> > remove open coded numbers"). so in your code you'd replace things like
> >
> >     if (strstarts(option, "rgb")) {
> >         option += strlen("rgb");
> >         ...
> >
> > with
> >
> >     len = str_has_prefix(option, "rgb");
> >     if (len) {
> >         option += len
> >         ...
> >
> > Obviously you also have cases where strstart is used as a boolean with
> > no need to know the length ... I think there's no value to converting
> > those.
> >
> 
> This will lead to worse code being generated. strlen() is evaluated at
> build time by the compiler if the argument is a string literal, so
> your 'before' version gets turned into 'option += 3', whereas the
> latter needs to use a runtime variable.

The EFI stub is -ffreestanding, so you actually get multiple calls to
strlen() in any case. I could have used strncmp() directly with sizeof()
to avoid that, but the strstarts()/strlen() was slightly more readable
and the performance of this code doesn't really matter.

I wasn't aware of str_has_prefix() at the time. It does seem useful to
eliminate the duplication of the string literal, I like the
skip_prefix() API suggestion, maybe even

	bool str_skip_prefix(const char **s, const char *pfx)
	{
		size_t len = str_has_prefix(*s, pfx);
		*s += len;
		return !!len;
	}
	...
	if (str_skip_prefix(&option, prefix)) { ... }

to avoid the intermediate variable.

> 
> So I don't object to using str_has_prefix() in new code in this way,
> but I really don't see the point of touching existing code.
