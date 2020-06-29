Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1E420E47C
	for <lists+linux-efi@lfdr.de>; Tue, 30 Jun 2020 00:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391045AbgF2VZx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Jun 2020 17:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbgF2Sms (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Jun 2020 14:42:48 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6893DC033C3D
        for <linux-efi@vger.kernel.org>; Mon, 29 Jun 2020 11:37:18 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x11so7423707plo.7
        for <linux-efi@vger.kernel.org>; Mon, 29 Jun 2020 11:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mHYFnEmrPBB0EoPbZgrylZKEYeUJ7dEY2zbQRVE/TE0=;
        b=Q8HPwYcPpk6cvqNepdjj7GzG1i+hF0OU2K7lY/4cN3hqsYfjspAjYrh+e2x1oQ7izt
         iGyhkr4NRFSf1YHoPA7GUZuTdUCb2hwxF7gz7vNnMwVjF3WqMxXPlRNOJMDLab1+merl
         8ySrtV3vm5xm4BTKo0/QkZC1k/74EuL1hVQtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mHYFnEmrPBB0EoPbZgrylZKEYeUJ7dEY2zbQRVE/TE0=;
        b=i2PrbvRzJ6WbSB2BvjbPf7QWKxP+DA5dG0YH+wKjpRd+7rd1RiYM97nuwcwHQ9NKmt
         aVIjBJtDFwe/WwyrJw8TNNi6Iav+qIOLwwZiXSFhweW1mw1mzdF03sKfBo/44Ay25AM5
         PDSSFjwzcM2+MIRCYxM9qgAMMbz7EoP27UHmZUVkfsJLNlSwgvNdLMca6z68d4aHq8+3
         lVJzij8npeXlmrs4DthBtRpF/K7uZw3W82wVGWiAYZhWH0uPgMvluBAMvDNFokaLDtuc
         sqcSDvAUUlCOPyU5+AtVN9vMIjxb98T1utBJ+zeuXsTSxQdD73ryW+rQ4k3nXN74SJBC
         9kWg==
X-Gm-Message-State: AOAM531AQWt1+ZMdSpyIHuRjKcCFaEcEPdaOdU0ODPnFPhSvvP5a+nRU
        q3Debgz3T6NuTjRM+VVwx7Ylfw==
X-Google-Smtp-Source: ABdhPJyO5LBgTD5AtbVt3yk/cj+JfeKTEZLWvpJPG/3xUjAxL4UTeU1IkJQNAdsLcqAC0lW924PkIQ==
X-Received: by 2002:a17:90a:e884:: with SMTP id h4mr9418062pjy.229.1593455837971;
        Mon, 29 Jun 2020 11:37:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n15sm457229pgs.25.2020.06.29.11.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 11:37:17 -0700 (PDT)
Date:   Mon, 29 Jun 2020 11:37:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, X86 ML <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>
Subject: Re: [PATCH v4 05/17] ctype: Work around Clang
 -mbranch-protection=none bug
Message-ID: <202006291136.E6DF8242@keescook>
References: <20200629061840.4065483-1-keescook@chromium.org>
 <20200629061840.4065483-6-keescook@chromium.org>
 <CAMj1kXE+toCd=Bx-zw7D9bvDRNB2aPn5-_7CY7MOKcVGA-azVg@mail.gmail.com>
 <202006290806.3BDE2A8@keescook>
 <CAKwvOd=DMfmvfiEX7KDPLs75SbNz+LAGSwC3V_=LgGH3kjtE=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=DMfmvfiEX7KDPLs75SbNz+LAGSwC3V_=LgGH3kjtE=g@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jun 29, 2020 at 11:02:51AM -0700, Nick Desaulniers wrote:
> This is definitely better than the empty function.  Though a patch is
> posted for fixing this in LLVM. Assuming that lands before this, we
> might not actually need this workaround?
> 
> arch/arm64/Kconfig
> 1625 config ARM64_BTI_KERNEL
> ...
> 1633   # https://reviews.llvm.org/rGb8ae3fdfa579dbf366b1bb1cbfdbf8c51db7fa55
> 1634   depends on !CC_IS_CLANG || CLANG_VERSION >= 100001
> 
> So if Daniel's patch lands AND is backported into the clang 10.0.1
> release, then we might not need to carry this workaround?  Either way,

True, though as I mentioned in the review, I don't think it's quite
right -- the warning getting removed is actually quite valuable.

> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks!

-- 
Kees Cook
