Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874012F8529
	for <lists+linux-efi@lfdr.de>; Fri, 15 Jan 2021 20:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbhAOTMJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Jan 2021 14:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbhAOTMI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Jan 2021 14:12:08 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74710C061757;
        Fri, 15 Jan 2021 11:11:28 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 143so12692090qke.10;
        Fri, 15 Jan 2021 11:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mcPqm+ALLmKYyfXL3d5GTSykbXw6V8Jgdo0h2nfOwvU=;
        b=YVcbxd9AcY/GqmKfrSs5Gqainwg+CF/U0iQngcddKXWni3elIAu4REpuwQhpc4hO9m
         +DsP1D7OTfyOWM4PL0sM2nBemFwbxIQxoyO96Q45lfudK4vLNMZfkwnlZLQKpS7D1t7D
         vMikXDTa5bNHKDSKAXlyARtRNkInXiCNSOv5XAkmF03vbQpu6AIOgM+j+QC/kXylKu9Y
         76XiC9PxxHNbj+6MLL2FL5E7R20332AY5flB9ixS59HLfASgk93+GrfbrHPENMIuAp1r
         o496yfSoc+Zpmb7tuI2xlfq77rLCrpC06kCqB4xsGRaSvWp9G/opsbWoY5cXHQaJ443v
         NkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mcPqm+ALLmKYyfXL3d5GTSykbXw6V8Jgdo0h2nfOwvU=;
        b=RZHNWBXorkZT4VGlFunvQyk7JHLIkc8090a3civ7tFuyNIAIM9LkSO9FE3w1USKgS9
         pl8GEs/e8hftyu8UB651YEBqIO7aixrwk9OcB8sqL8ipjThvLYbhXhGmQfgD3aT/dfI/
         7CJFtvYHiTm64weYEt8dKGLm0AQulDNLBa2IJfdYr/FuzpE3B0X2b+7LAmDT+Vzwo+qr
         F5DfjvYkgLIFrZcdyVD+eEEqDzrgQRDP5zjK5i9ivMdHnYjJJROcMUzi3CvamvqL+L4x
         u97VSM7ZqjNUr9Di6OLDHtVUZLPVBO0ppoSfBaibwIpNRoml73JZbmYDsGTFUoMpHeuJ
         GfaA==
X-Gm-Message-State: AOAM530hCWNDmsGibVOxl1E5XkyJSsVRX7mb86I/Cq35NsVIYANGtjlz
        msdRGwCzFhxCwJqWKVgTT2GLFjzgvUI4Qg==
X-Google-Smtp-Source: ABdhPJwl8b9vArV0qIAzP5JBVNtv0oRdMUZzpfwTsFtEKZjoAfZik2uxsmp/LYDqhlztSl/DWOAJAQ==
X-Received: by 2002:a37:7907:: with SMTP id u7mr14106962qkc.472.1610737887654;
        Fri, 15 Jan 2021 11:11:27 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id b12sm5253330qtj.12.2021.01.15.11.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 11:11:27 -0800 (PST)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 15 Jan 2021 14:11:25 -0500
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] x86: efi: avoid BUILD_BUG_ON() for non-constant p4d_index
Message-ID: <YAHo3ZEMu+6mESZA@rani.riverdale.lan>
References: <20210107223424.4135538-1-arnd@kernel.org>
 <20210115182300.GD9138@zn.tnic>
 <20210115183203.GA1991122@ubuntu-m3-large-x86>
 <20210115190729.GE9138@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115190729.GE9138@zn.tnic>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 15, 2021 at 08:07:29PM +0100, Borislav Petkov wrote:
> On Fri, Jan 15, 2021 at 11:32:03AM -0700, Nathan Chancellor wrote:
> > I triggered it with CONFIG_UBSAN=y + CONFIG_UBSAN_UNSIGNED_OVERFLOW=y
> > (it can be exposed with an allyesconfig/allmodconfig on mainline
> > currently).
> 
> Yah, I can trigger with that, thanks.
> 
> But I'll be damned, check this out:
> 
> clang preprocesses to this:
> 
>  do { extern void __compiletime_assert_332(void) ; if (!(!(p4d_index((-68 * ((1UL) << 30))) != p4d_index((0xffffffffff000000UL))))) __compiletime_assert_332(); } while (0);
> 
> The resulting asm is:
> 
> .LBB1_32:
>         movabsq $-73014444032, %r13     # imm = 0xFFFFFFEF00000000
>         testb   $1, %al
>         jne     .LBB1_33
> .LBB1_34:
>         xorl    %r14d, %ebx
>         testl   $33554431, %ebx         # imm = 0x1FFFFFF
>         je      .LBB1_36
> # %bb.35:
>         callq   __compiletime_assert_332
> 
> so the undefined symbol is there, leading to:
> 
> ld: arch/x86/platform/efi/efi_64.o: in function `efi_sync_low_kernel_mappings':
> /home/boris/kernel/linux/arch/x86/platform/efi/efi_64.c:140: undefined reference to `__compiletime_assert_332'
> 
> Now look at gcc:
> 
> It preprocesses to:
> 
>  do { extern void __compiletime_assert_332(void) __attribute__((__error__("BUILD_BUG_ON failed: " "p4d_index(EFI_VA_END) != p4d_index(MODULES_END)"))); if (!(!(p4d_index((-68 * ((1UL) << 30))) != p4d_index((0xffffffffff000000UL))))) __compiletime_assert_332(); } while (0);
> 
> 
> Resulting asm:
> 
> $ grep __compiletime_assert_332  arch/x86/platform/efi/efi_64.s
> $
> 
> That thing has been optimized away!
> 
> Which means, those build assertions are gone on gcc and they don't catch
> diddly squat. I sure hope I'm missing something here...

That's how build-time assertions work: they are _supposed_ to be
optimized away completely when the assertion is true. If they're
_not_ optimized away, the build will fail.
