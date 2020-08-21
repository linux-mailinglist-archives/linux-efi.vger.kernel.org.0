Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167A924DEDE
	for <lists+linux-efi@lfdr.de>; Fri, 21 Aug 2020 19:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgHURtH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Aug 2020 13:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgHURtF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Aug 2020 13:49:05 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E60AC061573
        for <linux-efi@vger.kernel.org>; Fri, 21 Aug 2020 10:49:05 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id i10so1354460pgk.1
        for <linux-efi@vger.kernel.org>; Fri, 21 Aug 2020 10:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/GMuE4utOPjO8y1lqv+OxzSdgWvuN+Qw8CbwkSqlnRQ=;
        b=eCrDRDas+JgyG8vEvUBUgIPw2N0eqtQG+RYzV7XhtoynuOnlhuZrdDQKbyFFclHrPn
         41Z9Xw1JtPUYek4ggdgXpKsZFiJa3q15fhr1kziwDYEDNpfhigdXs7VY5AbnexGH6F6H
         IR7D2Fb0exwgeUNMSrGrEH3RoaO/zxNkwt0yE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/GMuE4utOPjO8y1lqv+OxzSdgWvuN+Qw8CbwkSqlnRQ=;
        b=AMpSfg3i9bekjGFF36ZWYK29ImLX9+dNdzeHgxf0Yxubd16V3QDdCOayxolEn1Xh5r
         tJ9F6b7lW9/HA6WP7zddVUnHkWbDravGENrLxXcfpTATqvSs3u7oZt6JV+uCr8yva7wQ
         kOSuzvxicxKvIsgLoHkbo+i9fwcwO1ehRRgYfRZzeIZE1HGgzYf20/Ef7EwADHRYeaWl
         aRtGhnAflvTX4JRudbEF8imB+qipO2hVbY+mkRhlhNI7MFnjO0EFlPGA8Lew8L++j2Nn
         wbdcd0ong3FRcAzJEGTy6iIW2Djp1LOTkbI8FuXZHeUJoiO9U4oSrudxJeHnPJlgwixs
         UNBg==
X-Gm-Message-State: AOAM530wBI3ftRosoew8g1lc9nGy6YBfPBgJFHXU9RapztDeSXPDZVRq
        rBE3sDgvfIedu8ZnCs9iJsp/Pw==
X-Google-Smtp-Source: ABdhPJzUl78taPwahfjnA2wW/6wLLpPTFwhGbButfOHh+DcCELkk9TL4PVM8Ve4ZrX5sUSPgeYg/vQ==
X-Received: by 2002:a63:cf03:: with SMTP id j3mr3144186pgg.14.1598032144842;
        Fri, 21 Aug 2020 10:49:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c10sm3107533pfc.62.2020.08.21.10.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 10:49:03 -0700 (PDT)
Date:   Fri, 21 Aug 2020 10:49:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 29/36] x86/build: Enforce an empty .got.plt section
Message-ID: <202008211047.9088D8571C@keescook>
References: <20200731230820.1742553-1-keescook@chromium.org>
 <20200731230820.1742553-30-keescook@chromium.org>
 <20200801021248.GB2700342@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801021248.GB2700342@rani.riverdale.lan>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jul 31, 2020 at 10:12:48PM -0400, Arvind Sankar wrote:
> On Fri, Jul 31, 2020 at 04:08:13PM -0700, Kees Cook wrote:
> > The .got.plt section should always be zero (or filled only with the
> > linker-generated lazy dispatch entry). Enforce this with an assert and
> > mark the section as NOLOAD. This is more sensitive than just blindly
> > discarding the section.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/x86/kernel/vmlinux.lds.S | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> > index 0cc035cb15f1..7faffe7414d6 100644
> > --- a/arch/x86/kernel/vmlinux.lds.S
> > +++ b/arch/x86/kernel/vmlinux.lds.S
> > @@ -414,8 +414,20 @@ SECTIONS
> >  	ELF_DETAILS
> >  
> >  	DISCARDS
> > -}
> >  
> > +	/*
> > +	 * Make sure that the .got.plt is either completely empty or it
> > +	 * contains only the lazy dispatch entries.
> > +	 */
> > +	.got.plt (NOLOAD) : { *(.got.plt) }
> > +	ASSERT(SIZEOF(.got.plt) == 0 ||
> > +#ifdef CONFIG_X86_64
> > +	       SIZEOF(.got.plt) == 0x18,
> > +#else
> > +	       SIZEOF(.got.plt) == 0xc,
> > +#endif
> > +	       "Unexpected GOT/PLT entries detected!")
> > +}
> >  
> >  #ifdef CONFIG_X86_32
> >  /*
> > -- 
> > 2.25.1
> > 
> 
> Is this actually needed? vmlinux is a position-dependent executable, and
> it doesn't get linked with any shared libraries, so it should never have
> a .got or .got.plt at all I think? Does it show up as an orphan without
> this?

Yup, I see this:

/usr/bin/ld.bfd: warning: orphan section `.got.plt' from `arch/x86/kernel/head_64.o' being placed in section `.got.plt'


-- 
Kees Cook
