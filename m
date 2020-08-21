Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7279924DEA1
	for <lists+linux-efi@lfdr.de>; Fri, 21 Aug 2020 19:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgHURga (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Aug 2020 13:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgHURg2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Aug 2020 13:36:28 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEFCC061574
        for <linux-efi@vger.kernel.org>; Fri, 21 Aug 2020 10:36:27 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m71so1423704pfd.1
        for <linux-efi@vger.kernel.org>; Fri, 21 Aug 2020 10:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5YwUWvLSJ7O0+W9B6CV8mGNc7AgyPS1rZYJa5IAEFSE=;
        b=GNti6X6io4bkC7V2/dWMSLLcKotdjIeAYlRtyzVBt7D1zudPC78cCRIdoJ+a/htl0c
         Ewb4JkeIFz6BfIEWSBrLZhaKmLRfJWRf7gmnhDeMhUl4AB6bv2xH/IKkVOBPAdFXIOdg
         hKv2U7FIUY3Q734E4NPstoI9JyMkRPCo+Imao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5YwUWvLSJ7O0+W9B6CV8mGNc7AgyPS1rZYJa5IAEFSE=;
        b=fvn2X7SYe4pXbXQqgYaJYFQN1OYdbPXlH+1co9vppaJlaKr2xSshk9PtcncyKfapyI
         z+8/EfF4NCDOlVRB+Vy+ccswo99F1YuWZGjZJ74Ua9RtHrbQQgTOQueIwKpl5qxI6Xty
         G03dOAsGEWqAnDwji3op71TRQEPkMZ14TCz/SrgwIIgNAlt+an2kyJQIiyyeK364HVfv
         dwZEC453p/gN1N6/chgWKP4EcQy/N0DQ92tIAOCWT6TOQrjSdb4rrm38vbKj/vkiV6cA
         1Qkqbqpw/qfhS5Mu4mlZ7jeXOl2AiOKnwWOEuQj4pkCusd8YRktOEamjAsFc+MrJ2yxg
         ugPA==
X-Gm-Message-State: AOAM532Od4y2CLvBVX8aBFtdYMyTQSe5SeciZdnrSNknCrIFhyARIl4W
        DDq9WXI9a7l1dH0oerpvc9f1XKEJIaHfuw==
X-Google-Smtp-Source: ABdhPJwyWVVPuJynVNXLdK+dNNrKynVM5caVtc2+fE0XV7EreCa1rPkUzH20EOD//p2IgzGvcDOSWA==
X-Received: by 2002:a63:30c2:: with SMTP id w185mr3092668pgw.15.1598031387251;
        Fri, 21 Aug 2020 10:36:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 196sm3344233pfc.178.2020.08.21.10.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 10:36:26 -0700 (PDT)
Date:   Fri, 21 Aug 2020 10:36:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/17] Warn on orphan section placement
Message-ID: <202008211035.36BAF567C@keescook>
References: <20200629061840.4065483-1-keescook@chromium.org>
 <20200821160237.GB21517@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821160237.GB21517@willie-the-truck>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 21, 2020 at 05:02:38PM +0100, Will Deacon wrote:
> Hi Kees,
> 
> On Sun, Jun 28, 2020 at 11:18:23PM -0700, Kees Cook wrote:
> > v4:
> > - explicitly add .ARM.attributes
> > - split up arm64 changes into separate patches
> > - split up arm changes into separate patches
> > - work around Clang section generation bug in -mbranch-protection
> > - work around Clang section generation bug in KASAN and KCSAN
> > - split "common" ELF sections out of STABS_DEBUG
> > - changed relative position of .comment
> > - add reviews/acks
> 
> What's the plan with this series? I thought it might have landed during the
> merge window, but I can't even seem to find it in next. Anything else you
> need on the arm64 side?

I need to rebase/refresh -- the plan is for it to go via -tip (based on
what Ingo said). I'm working on a v6 right now.

-- 
Kees Cook
