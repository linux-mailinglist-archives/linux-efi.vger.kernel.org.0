Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E2B1DDD4B
	for <lists+linux-efi@lfdr.de>; Fri, 22 May 2020 04:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgEVCm7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 21 May 2020 22:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgEVCm7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 21 May 2020 22:42:59 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4579C061A0E
        for <linux-efi@vger.kernel.org>; Thu, 21 May 2020 19:42:57 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 145so4465854pfw.13
        for <linux-efi@vger.kernel.org>; Thu, 21 May 2020 19:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9r9+AoRulBVTVcXSeonVL+yRisP4PacBY1m16VwmigY=;
        b=Ql4DdAx+Z6DwJjA83EV09jrKk68FZYu3Bm3rLke8pnfQ/Q7kXUTy3jvYPEop4/NXZl
         K+IzbettpsGshyvxo7+xc9qLsQGgYAbRQrGQRDAfF9sMnYaiGJp0j0mQnbhWZdEp9AYD
         JDqpc7g0LbNf42DLCJN1rwESbRnXACLWh9/9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9r9+AoRulBVTVcXSeonVL+yRisP4PacBY1m16VwmigY=;
        b=U9K6GOZwx0UGjg6EEvgTLGv4foPuFyY/Vei+J9gz7AX5qm9PFMrgmakpwAwJhybP+g
         Vup6bojAdsVQVlPSniWXfFLxEhAq+SkJG5u0gDBBTz7H00NlPVup3h7OMYU2wR8sKKsc
         PtIJGXIezk3/ZoFjpcRAyQLosOYhQorp5xANDNa42cKr3SwLuiWzFbj3zVaGPoku0tU8
         iUJrq6sJh6ZXr6g7OIk0JfiCR0UVSXN+X2rdy3V3OvaPlUcldryabvyLQl+NXGTngBBg
         9watffCT8E+F4UupE/YWcjelh/UlOV5clsvh4NfbmTdy2vnE85raJlEBU9j1uK3Fxe0/
         X1TQ==
X-Gm-Message-State: AOAM533VZVRFbJ90w2fBjg+w8d5oVeUxTuENmIPd79/2zsir1dZlnI37
        S4QslytwUUZxHLNzfJzkpqI0KQ==
X-Google-Smtp-Source: ABdhPJzmeDBf9HLHA2qDD0PNsu/oBjEzUL2rLcxQdzAZv2r6xmMyL/Z/Y+fl/h2GM064YdCGaa3pPg==
X-Received: by 2002:a63:7e5a:: with SMTP id o26mr12055854pgn.134.1590115377175;
        Thu, 21 May 2020 19:42:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u4sm9767336pjf.3.2020.05.21.19.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 19:42:56 -0700 (PDT)
Date:   Thu, 21 May 2020 19:42:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Fangrui Song <maskray@google.com>
Cc:     x86@kernel.org, Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] x86/boot: Discard .discard.unreachable for
 arch/x86/boot/compressed/vmlinux
Message-ID: <202005211942.6E5061433@keescook>
References: <20200520182010.242489-1-maskray@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520182010.242489-1-maskray@google.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, May 20, 2020 at 11:20:10AM -0700, 'Fangrui Song' via Clang Built Linux wrote:
> In the latest efi tree, ce5e3f909fc0ed67e58367b9c56a54c20a51080b
> "efi/printf: Add 64-bit and 8-bit integer support",
> arch/x86/boot/compressed/vmlinux may have an undesired
> .discard.unreachable section from drivers/firmware/efi/libstub/vsprintf.stub.o
> 
> .discard.unreachable contains an R_X86_64_PC32 relocation, which will be
> warned by LLD: a non-SHF_ALLOC section (.discard.unreachable) is not
> part of the memory image, thus conceptually the distance between a
> non-SHF_ALLOC and a SHF_ALLOC is not a constant which can be resolved at
> link time.
> 
> % ld.lld -m elf_x86_64 -T arch/x86/boot/compressed/vmlinux.lds ... -o arch/x86/boot/compressed/vmlinux
> ld.lld: warning: vsprintf.c:(.discard.unreachable+0x0): has non-ABS relocation R_X86_64_PC32 against symbol ''
> 
> Reuse the DISCARDS macro which includes .discard.* to drop .discard.unreachable
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Fangrui Song <maskray@google.com>

Yay macro usage! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
