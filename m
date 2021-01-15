Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1A62F8662
	for <lists+linux-efi@lfdr.de>; Fri, 15 Jan 2021 21:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388013AbhAOUNK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Jan 2021 15:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388267AbhAOUNJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Jan 2021 15:13:09 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41512C0613D3;
        Fri, 15 Jan 2021 12:12:29 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id c7so12936782qke.1;
        Fri, 15 Jan 2021 12:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sgKqk97F3LXGs0WSJk0LyPnfv9O5wcmbABf8xVSL5kI=;
        b=G1axieAIDZYJb/tACg7H+z3hU6I9eitIAKgpcmXudF5DwDTZF/rfFRTRvdqviR+RbR
         Qd6VvLGY2+iXdDAz+5LzYGnZbpbC62t61Sp/vzjlntkyuiPl9oyyjs9ukhgvzp+2/Z8h
         h+ay66e2tDvrPJON9NnW3/6jmOZRIb39E7GeLAZGVoaGDZ2tmwkSD96bPzU0/d0CUBNP
         kYDlDsfKrO+1MRlNr0M/pmDoZ0cC8fKygSfG3HzOsuQP4YYj+D8cUxiPAAlcJtaxJ+/5
         dGs6y1n1Lp+3sdW0CsA5awISJryBEnJTcNQ4u2p1atPkfscOnlBb7wqTAItDWDqNb4CK
         lwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=sgKqk97F3LXGs0WSJk0LyPnfv9O5wcmbABf8xVSL5kI=;
        b=Qs04ndxjh+8FXNJzwtf+WoDvdvtYHrgky3Nj98RAQCNxATbOXCNzYn2knJ7sSOb7mK
         rQuJgJLGLtILMdmSp0LP9j2Lb+jQNIzCLT6kslPdexbijKowqtzNZLCFFKH1W02umWcK
         BEXjF+2HcH/DCN82zUmJeWNAz0ohmS5xuJvC1ZNP6SN+r38Ho0fe+Ymb/z6w21xbkPyR
         MKlwFWei6j5KUkI4g5kmTwtWyI0PzAhhEAtbkekI/2wegqDmHGEp1R/MZJre7PDh1kqC
         yVtkROt675bkCTcU5Rvoybq+dojgsBmdHrRRkpdJ6t8zSogJKvefoWpsRsNA+ugwpwBh
         PekA==
X-Gm-Message-State: AOAM531FWsT4RRlWAmDeDtL9KhsVbpn0ETXX5PXeYkorQ6zOzdupaYDt
        ctURH6LlOtZoFIb1DCVA/w0=
X-Google-Smtp-Source: ABdhPJwgph2DdHibMe0SsUoCZumwuGVmjzafKDzTeUOjtCCsIUPivtc6SNEITdNCiF1QSpqVQN0RAA==
X-Received: by 2002:a05:620a:a9c:: with SMTP id v28mr13984822qkg.107.1610741548418;
        Fri, 15 Jan 2021 12:12:28 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v5sm5700419qkv.64.2021.01.15.12.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 12:12:27 -0800 (PST)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 15 Jan 2021 15:12:25 -0500
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
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
Message-ID: <YAH3KY0I2AWudkc9@rani.riverdale.lan>
References: <20210107223424.4135538-1-arnd@kernel.org>
 <20210115182300.GD9138@zn.tnic>
 <20210115183203.GA1991122@ubuntu-m3-large-x86>
 <20210115190729.GE9138@zn.tnic>
 <YAHo3ZEMu+6mESZA@rani.riverdale.lan>
 <20210115191833.GF9138@zn.tnic>
 <CAK8P3a39vtF8GvRVQtEYssc+GvX-75j9-4pwXj4qhc7LK2RgNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a39vtF8GvRVQtEYssc+GvX-75j9-4pwXj4qhc7LK2RgNw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 15, 2021 at 08:54:18PM +0100, Arnd Bergmann wrote:
> On Fri, Jan 15, 2021 at 8:18 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, Jan 15, 2021 at 02:11:25PM -0500, Arvind Sankar wrote:
> > > That's how build-time assertions work: they are _supposed_ to be
> > > optimized away completely when the assertion is true. If they're
> > > _not_ optimized away, the build will fail.
> >
> > Yah, that I know, thanks.
> >
> > If gcc really inlines p4d_index() and does a lot more aggressive
> > optimization to determine that the condition is false and thus optimize
> > everything away (and clang doesn't), then that would explain the
> > observation.
> 
> One difference is that gcc does not have
> -fsanitize=unsigned-integer-overflow at all, and I don't see the
> assertion without that on clang either, so it's possible that clang
> behaves as designed here.
> 
> The description is:
>     -fsanitize=unsigned-integer-overflow: Unsigned integer overflow, where
>      the result of an unsigned integer computation cannot be represented in
>      its type. Unlike signed integer overflow, this is not undefined behavior,
>      but it is often unintentional. This sanitizer does not check for
> lossy implicit
>      conversions performed before such a computation (see
>     -fsanitize=implicit-conversion).
> 
> The "-68 * ((1UL) << 30" computation does overflow an unsigned long
> as intended, right? Maybe this is enough for the ubsan code in clang to
> just disable some of the optimization steps that the assertion relies on.
> 
>         Arnd

That does seem to be an overflow, but that happens at compile-time.
Maybe
	AC(-68, UL) << 30
would be a better definition to avoid overflow.

The real issue might be (ptrs_per_p4d - 1) which can overflow at
run-time, and maybe the added ubsan code makes p4d_index() not worth
inlining according to clang?
