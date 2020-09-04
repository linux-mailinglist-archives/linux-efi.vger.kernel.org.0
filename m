Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9C525E171
	for <lists+linux-efi@lfdr.de>; Fri,  4 Sep 2020 20:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgIDSUs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Sep 2020 14:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgIDSUr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Sep 2020 14:20:47 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D246FC061244
        for <linux-efi@vger.kernel.org>; Fri,  4 Sep 2020 11:20:45 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mm21so3583603pjb.4
        for <linux-efi@vger.kernel.org>; Fri, 04 Sep 2020 11:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HGsb6HyUfkAH720RyRI2xnBGVpFj14UXqV80lfeeAHQ=;
        b=Il3Jp+GbZKeQBVyig5AB6ptKPeBzRng/54pElXbWFgDDwVZtfonwW/fIvn12LwA16M
         q+/RGW9N8udNPgZyH15iLM+vRSiGyHrin+pGX1aElmkbmidG8ekkDrYXabwm5ci/epUm
         czoHI1JGeVOuHvY1/0vF8Z8gvengMt1dzX9XM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HGsb6HyUfkAH720RyRI2xnBGVpFj14UXqV80lfeeAHQ=;
        b=OUg74/Np/FhxFVTvy6RPHlsR501sgTV4r08jjQWGP+cmhcMVPsM/N5D+QvQTvYZvUY
         nlYTFPTw7B6W8Pvb5SsOBhKoJX4uP3Xnzds/pHhYxBHzY3Y9riT+Q0+YIClah2rurrfe
         m4Jl2m3KhvFYohCE4OsHptUnlbNF381MuWkQ+wbdk5Mr7umU4EV9+0mF1091SM4vHBkL
         T5Uto0Q1oxwjxoqd0ygNGVkzu8C7lX1qK7EU1+uaoR7lv2HlXxPCOpUX1BHhWOVbK+NX
         z6tp2xStmAz1qa328wuLdFlSMxmdtYrTSLpv4TmIswr15B0FgyUCRfkdS0I7hIB/tSts
         2+hg==
X-Gm-Message-State: AOAM532ctmNhcgya45lwSlMmtOdTn3SRCKvXJBDkaz0XW1uwPmeAps81
        HSYu8W/fFUvQxPSq57oF6FCvsA==
X-Google-Smtp-Source: ABdhPJw3OHa/KfnDP1eX5u9yPnVXyHpsyvjqvNAIiJCIEcH0n6a9Xn4DsL9UahB90tHSeMz9ICNHhA==
X-Received: by 2002:a17:902:bc44:: with SMTP id t4mr8920312plz.77.1599243645065;
        Fri, 04 Sep 2020 11:20:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gm3sm5689028pjb.31.2020.09.04.11.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 11:20:44 -0700 (PDT)
Date:   Fri, 4 Sep 2020 11:20:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/5] Warn on orphan section placement
Message-ID: <202009041117.5EAC7C242@keescook>
References: <20200902025347.2504702-1-keescook@chromium.org>
 <CAKwvOd=r8X1UeBRgYMcjUoQX_nbOEbXCQYGX6n7kMnJhGXis=Q@mail.gmail.com>
 <20200904055825.GA2779622@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904055825.GA2779622@gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Sep 04, 2020 at 07:58:25AM +0200, Ingo Molnar wrote:
> 
> * Nick Desaulniers <ndesaulniers@google.com> wrote:
> 
> > On Tue, Sep 1, 2020 at 7:53 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > Hi Ingo,
> > >
> > > The ever-shortening series. ;) Here is "v7", which is just the remaining
> > > Makefile changes to enable orphan section warnings, now updated to
> > > include ld-option calls.
> > >
> > > Thanks for getting this all into -tip!
> > 
> > For the series,
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > 
> > As the recent ppc vdso boogaloo exposed, what about the vdsos?
> > * arch/x86/entry/vdso/Makefile
> > * arch/arm/vdso/Makefile
> > * arch/arm64/kernel/vdso/Makefile
> > * arch/arm64/kernel/vdso32/Makefile
> 
> Kees, will these patches DTRT for the vDSO builds? I will be unable to test 
> these patches on that old system until tomorrow the earliest.

I would like to see VDSO done next, but it's entirely separate from
this series. This series only touches the core kernel build (i.e. via the
interactions with scripts/link-vmlinux.sh) or the boot stubs. So there
is no impact on VDSO linking.

> I'm keeping these latest changes in WIP.core/build for now.

They should be safe to land in -next, which is important so we can shake
out any other sneaky sections that all our existing testing hasn't
found. :)

-- 
Kees Cook
