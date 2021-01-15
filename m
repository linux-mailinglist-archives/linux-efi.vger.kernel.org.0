Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F0D2F86BE
	for <lists+linux-efi@lfdr.de>; Fri, 15 Jan 2021 21:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbhAOUcv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Jan 2021 15:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbhAOUcu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Jan 2021 15:32:50 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46D7C061757;
        Fri, 15 Jan 2021 12:32:09 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id c1so6998453qtc.1;
        Fri, 15 Jan 2021 12:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BVIgSjuV976cGlpOjqUg4jAiYaTKabic/p9h6hRPsiU=;
        b=XjSJapW79gC5VBIO3wCG7Te5A95WeoBeaPgoQmIiDvhayH8pCfmJlyK3s/C5g6CPXk
         kH9E2Hjfwe3tL5pUBUAyW9gACVfifGuAJLYTYm7l83WOkwr0CDBL4JWxJV+G6XX/KYMP
         FZ2s7A0FddkEdNgRjkvXGEHPxN9+yP3t5bdYbtcH1bpfVr+/E+Z/FGvLtnPslDIrOycs
         1UMsCHUlrGOQK+3j9HjX/47X+7Osj8vMXSho7euePLrF9CMRVSfgclyv9UWoowMeOALO
         JIr98GsN80UnhoXz21d4qSz9blnkfCX1VTNdGc/eF+MTYNho5feODwtiP7ayS7lTa4JN
         0r9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=BVIgSjuV976cGlpOjqUg4jAiYaTKabic/p9h6hRPsiU=;
        b=kEA+m3rnmdZNzmPdq+SX639HG8asimNiNwh3WHlYXGSnYAeZo9nuto6IxOnm0l9epD
         wsnkoHuwhzDQjzDehW70cgLKSfBfMjGCHPXmatRdsATWu6PqMLTU9vIr2N/uQxAODegj
         gW/rah5zEBwdJyZ0T5AxO5OjdMb7gaxR3WkhUipG4NMps8LhG/IxZbTQWuMFGcCcSE58
         YY3N7ZNlMgFiXcocwvuKA6QYIlMFpfU3kmm/NNK1GAsXdPjGKRt2WtKS1Wx68/ONJ9fF
         qCi2wsVdw/Q0YoWTRe0m9hTDiRJzbcpL+t1/EzJteUxAloDCNhh6aBSFYKNGXnKjkqV7
         cDLA==
X-Gm-Message-State: AOAM532CjAfwE9kLaHVhDf0IHbfOE9HUN5gKOuYDVR9+O6AN7vnByQlO
        vj26w1jbLUagSOUopoiCMcY=
X-Google-Smtp-Source: ABdhPJwaoV9e5of1oPbEIjlm/kN/Wkir46+iQh6aBIMe3yyvJ4EPDguKtg4d/vQX8KjkGPPch5/bFw==
X-Received: by 2002:ac8:6c36:: with SMTP id k22mr13626091qtu.62.1610742728990;
        Fri, 15 Jan 2021 12:32:08 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c62sm5599633qkf.34.2021.01.15.12.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 12:32:08 -0800 (PST)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 15 Jan 2021 15:32:06 -0500
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] x86: efi: avoid BUILD_BUG_ON() for non-constant p4d_index
Message-ID: <YAH7xlaHZN8i8ORK@rani.riverdale.lan>
References: <20210107223424.4135538-1-arnd@kernel.org>
 <20210115182300.GD9138@zn.tnic>
 <20210115183203.GA1991122@ubuntu-m3-large-x86>
 <20210115190729.GE9138@zn.tnic>
 <YAHo3ZEMu+6mESZA@rani.riverdale.lan>
 <20210115191833.GF9138@zn.tnic>
 <CAK8P3a39vtF8GvRVQtEYssc+GvX-75j9-4pwXj4qhc7LK2RgNw@mail.gmail.com>
 <YAH3KY0I2AWudkc9@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAH3KY0I2AWudkc9@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 15, 2021 at 03:12:25PM -0500, Arvind Sankar wrote:
> On Fri, Jan 15, 2021 at 08:54:18PM +0100, Arnd Bergmann wrote:
> > On Fri, Jan 15, 2021 at 8:18 PM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > On Fri, Jan 15, 2021 at 02:11:25PM -0500, Arvind Sankar wrote:
> > > > That's how build-time assertions work: they are _supposed_ to be
> > > > optimized away completely when the assertion is true. If they're
> > > > _not_ optimized away, the build will fail.
> > >
> > > Yah, that I know, thanks.
> > >
> > > If gcc really inlines p4d_index() and does a lot more aggressive
> > > optimization to determine that the condition is false and thus optimize
> > > everything away (and clang doesn't), then that would explain the
> > > observation.
> > 
> > One difference is that gcc does not have
> > -fsanitize=unsigned-integer-overflow at all, and I don't see the
> > assertion without that on clang either, so it's possible that clang
> > behaves as designed here.
> > 
> > The description is:
> >     -fsanitize=unsigned-integer-overflow: Unsigned integer overflow, where
> >      the result of an unsigned integer computation cannot be represented in
> >      its type. Unlike signed integer overflow, this is not undefined behavior,
> >      but it is often unintentional. This sanitizer does not check for
> > lossy implicit
> >      conversions performed before such a computation (see
> >     -fsanitize=implicit-conversion).
> > 
> > The "-68 * ((1UL) << 30" computation does overflow an unsigned long
> > as intended, right? Maybe this is enough for the ubsan code in clang to
> > just disable some of the optimization steps that the assertion relies on.
> > 
> >         Arnd
> 
> That does seem to be an overflow, but that happens at compile-time.
> Maybe
> 	AC(-68, UL) << 30
> would be a better definition to avoid overflow.

Eh, that's an overflow too, isn't it :( Is this option really useful
with kernel code -- this sort of thing is probably done all over the
place?

> 
> The real issue might be (ptrs_per_p4d - 1) which can overflow at
> run-time, and maybe the added ubsan code makes p4d_index() not worth
> inlining according to clang?
