Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF83120779E
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jun 2020 17:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403931AbgFXPgX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 24 Jun 2020 11:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403982AbgFXPgX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 24 Jun 2020 11:36:23 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB32C061795
        for <linux-efi@vger.kernel.org>; Wed, 24 Jun 2020 08:36:22 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e18so1588560pgn.7
        for <linux-efi@vger.kernel.org>; Wed, 24 Jun 2020 08:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XJUzgH5TgVAKrlAz/oLGoEzf+4q4DR2SPe5g3v8Hoz0=;
        b=L87UOx1rFbEBv6EAXMjq42JQm86UtPUvAjrSDFUjZV7/S2Fdwtz80FtkbJzD8kccUr
         iRuRTc98qsUUvW4wRLaZIRPNfFKjSXe1ODNggmES4VHyXOVp9NEfQINR136Asyjj1o/J
         v+lhjyzt2oK0bGeFeFUl+FR9FpGwVWyk6cXTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XJUzgH5TgVAKrlAz/oLGoEzf+4q4DR2SPe5g3v8Hoz0=;
        b=oBakQw9vc8XhdkZeM2GG30oGKGEa3ESkzWP1dLlUzR/lLCBPRs2WCySRV4A7vkzeMT
         r54CQ6d3RbCs0bhhdS++4YcxhvDao82r7Qlk0OJkp2irzsLwx4zh7zpoDC4UkJesyHqQ
         q5LmK1br5PPr6fQscS59sxCTAkqp1RupWFxXBRxEjIhRzEITj5eptQrhARr6fCMXFOmh
         TFN86ADFEgaesLCrTZmAmQVQ3wdPIHJuCDf6Z3JUOSp9Ew8JkMEN56lzwhAH2K0MB4FH
         6fkkIys+Af+ZX/GQ73wqCTwMz8dX8LrVgvgfjMNlMCbPmDJXARBdFVt+WVQmvupbFgYC
         9aeQ==
X-Gm-Message-State: AOAM531ev3LMIuOfeX15fhgmIS8OrZ4m4xTNWEJaP5dn4Z0m0gBUyY5c
        PB7YyuntBiUPFt8lLaq7z0P8qO7j1t0=
X-Google-Smtp-Source: ABdhPJzh0NIgxXcoqTxHGxMf5jIULfS15W7YCEH1YCRk0fdSR5z7SraN22S3afSROtaHxZ0aAd1AOA==
X-Received: by 2002:a63:aa42:: with SMTP id x2mr21604671pgo.361.1593012982182;
        Wed, 24 Jun 2020 08:36:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j36sm17984549pgj.39.2020.06.24.08.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:36:21 -0700 (PDT)
Date:   Wed, 24 Jun 2020 08:36:20 -0700
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
Subject: Re: [PATCH v3 9/9] arm64/build: Warn on orphan section placement
Message-ID: <202006240835.E474048BBF@keescook>
References: <20200624014940.1204448-1-keescook@chromium.org>
 <20200624014940.1204448-10-keescook@chromium.org>
 <20200624075712.GB5853@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624075712.GB5853@willie-the-truck>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 24, 2020 at 08:57:12AM +0100, Will Deacon wrote:
> On Tue, Jun 23, 2020 at 06:49:40PM -0700, Kees Cook wrote:
> > We don't want to depend on the linker's orphan section placement
> > heuristics as these can vary between linkers, and may change between
> > versions. All sections need to be explicitly named in the linker
> > script.
> > 
> > Avoid .eh_frame* by making sure both -fno-asychronous-unwind-tables and
> > -fno-unwind-tables are present in both CFLAGS and AFLAGS. Remove one
> > last instance of .eh_frame by removing the needless Call Frame Information
> > annotations from arch/arm64/kernel/smccc-call.S.
> > 
> > Add .plt, .data.rel.ro, .igot.*, and .iplt to discards as they are not
> > actually used. While .got.plt is also not used, it must be included
> > otherwise ld.bfd will fail to link with the error:
> > 
> >     aarch64-linux-gnu-ld: discarded output section: `.got.plt'
> > 
> > However, as it'd be better to validate that it stays effectively empty,
> > add an assert.
> > 
> > Explicitly include debug sections when they're present.
> > 
> > Fix a case of needless quotes in __section(), which Clang doesn't like.
> > 
> > Finally, enable orphan section warnings.
> > 
> > Thanks to Ard Biesheuvel for many hints on correct ways to handle
> > mysterious sections. :)
> 
> Sorry to be a pain, but this patch is doing 3 or 4 independent things at
> once. Please could you split it up a bit?
> e.g.
> 
>  - Removal of cfi directives from smccc macro
>  - Removal of quotes around section name for clang
>  - Avoid generating .eh_frame
>  - Ensure all sections are accounted for in linker script and warn on orphans
> 
> That way it's a bit easier to manage, we can revert/backport bits later if
> necessary and you get more patches in the kernel ;)

Yeah, this one patch did grow a bit. ;) I've split it up now.

> You can also add my Ack on all the patches:
> 
> Acked-by: Will Deacon <will@kernel.org>

Thanks!

-- 
Kees Cook
