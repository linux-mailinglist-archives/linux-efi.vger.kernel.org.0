Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340F5688592
	for <lists+linux-efi@lfdr.de>; Thu,  2 Feb 2023 18:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjBBRhZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Feb 2023 12:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjBBRhW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Feb 2023 12:37:22 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A4137F1C
        for <linux-efi@vger.kernel.org>; Thu,  2 Feb 2023 09:37:18 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 143so1854116pgg.6
        for <linux-efi@vger.kernel.org>; Thu, 02 Feb 2023 09:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wRdReY3bvVpG1aI5mOcLOqs5a0t3Nfp+QAhfdvBukN8=;
        b=gzROW/sJ+bb/ZDHkosldNPoJDpp8OEmk1czueSp/b2lopZZ7q9NwGV59TSjDHXZW7c
         8FCTBni0RcyosNs+8s2TBsAWpL8JyL6lZi0eOJ4GHFwikyeRGdP6KH3bGL0pIekW4znj
         fY7pGj8ntPz88bWA9n71OBQ3og0RoAazs2Hos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRdReY3bvVpG1aI5mOcLOqs5a0t3Nfp+QAhfdvBukN8=;
        b=Yw1bB8l3f04NUL1A3yPPKcuxDhqppP5rL61v1/qDVRckgMY/zwEDdEjKtn0ImIzn8d
         JvsbhFvQ62S0lKY9Uxu0XAZkDoUqzHtt7q+77g9BlJCzsY7l+vzeo0j3xWcywy1h7+I1
         TPaajWKnknH139wm7DhIdgO+/zyB1hFhqv2Ak8wyVxIs/+SuIaaC7jU54StXBLPx4EsP
         BuzP6aLmjJyeE/F8TqCezyjZrO/QIBTEF+iPZRePHa/rf6KsA2SvkyxTcNHWVDS7OZzZ
         vi5OAX16jBoqbU9BFEKwF3iXLhQbbIA7BLlWffM390n5R7NK0XiN3PMfh4euanDB9nSC
         NtpA==
X-Gm-Message-State: AO0yUKWb0EAqKxD3JrVSEOV5spFnA75KRrRnbEfE8Aj8CQvB5q/qeeg0
        e9z90CpRaoAzvox9V4544oXWog==
X-Google-Smtp-Source: AK7set+SdhJ8/aN0w5Hv8gSawo8N3WfH1NnxiFWBLzHbdO9qZ1Nc4jRQMvZbSR/HSVfKDWBN2DJdHA==
X-Received: by 2002:a05:6a00:410d:b0:593:ea06:7fd with SMTP id bu13-20020a056a00410d00b00593ea0607fdmr7287008pfb.13.1675359438289;
        Thu, 02 Feb 2023 09:37:18 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 22-20020aa79256000000b0058baf8694e1sm13784785pfp.71.2023.02.02.09.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 09:37:17 -0800 (PST)
Message-ID: <63dbf4cd.a70a0220.d9b66.920b@mx.google.com>
X-Google-Original-Message-ID: <202302021737.@keescook>
Date:   Thu, 2 Feb 2023 17:37:16 +0000
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/2] efi: Enable BTI for EFI runtimes services
References: <20230201132540.2196065-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201132540.2196065-1-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 01, 2023 at 02:25:38PM +0100, Ard Biesheuvel wrote:
> The EFI spec v2.10 introduces a global flag in the memory attributes
> table that indicates whether the EFI runtime code regions were emitted
> with BTI landing pads, and can therefore tolerate being mapped with BTI
> enforcement enabled.
> 
> Add the generic plumbing for this, and wire it up for arm64.

Looks nice! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> 
> Ard Biesheuvel (2):
>   efi: Discover BTI support in runtime services regions
>   efi: arm64: Wire up BTI annotation in memory attributes table
> 
>  arch/arm/include/asm/efi.h     |  2 +-
>  arch/arm/kernel/efi.c          |  5 +++--
>  arch/arm64/include/asm/efi.h   |  3 ++-
>  arch/arm64/kernel/efi.c        | 18 +++++++++++++++---
>  arch/riscv/include/asm/efi.h   |  2 +-
>  arch/riscv/kernel/efi.c        |  3 ++-
>  arch/x86/platform/efi/efi_64.c |  3 ++-
>  drivers/firmware/efi/memattr.c |  9 +++++++--
>  include/linux/efi.h            |  8 ++++++--
>  9 files changed, 39 insertions(+), 14 deletions(-)
> 
> -- 
> 2.39.0
> 

-- 
Kees Cook
