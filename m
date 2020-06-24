Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5467E206B55
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jun 2020 06:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgFXEoO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 24 Jun 2020 00:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgFXEoN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 24 Jun 2020 00:44:13 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84D5C061755
        for <linux-efi@vger.kernel.org>; Tue, 23 Jun 2020 21:44:13 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id d6so584635pjs.3
        for <linux-efi@vger.kernel.org>; Tue, 23 Jun 2020 21:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yc7m6q+AETZbQf/A/NW3gp84TMebMUYFiYcSc962UaI=;
        b=foHqhRb7hf5KgQA5HSRO5284qQLj7K1f7jI6KtpF4wP8UIugY2Q4C+9vTK7tIsFkyu
         gCNVka1KLRgmXwoVN0JFbY5Ac/BHQH24PxKAlxSyvl0q99hluofpS33VW/NvUHVQlz+U
         gne2QItKrmtHY7DGvrNp9LyDns2aXJiINfTjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yc7m6q+AETZbQf/A/NW3gp84TMebMUYFiYcSc962UaI=;
        b=UNHO3xEOaR4ABFDGsI/fgI1ZVXNBwaTYjYSwZm7Na3A8H9eHtFhdGd9KUnpsqZeXlO
         TiTeqPb6WJLfrvcBvze8tuK4tKE+0A6pxM1HWyGl6vSO7Sb71g7HXTWld85kK4+LpLER
         QAxCi6c2YFk2Fftu7MPQvZ6v/ilH0mPPo6tuZWHWcVff+vryer1lffkF3Q1jlHXU28sJ
         ZEK69k025C+y/8fCWr1vYIrUoWXlalVd0lj0StjueGjmXiJuovL7IQhDb0arxmmrGTxg
         ZlgKz11OcI61wBHtT5eXnuirf5RGwQoJoSkUCU7DrEQ7tLa4JFJtGEzF2Ypp/8psaNia
         NrsA==
X-Gm-Message-State: AOAM532bAlX0ipPMXY21y2O91fF5S5mrHrrzXuyYvsNkNPc5vQgrp5hY
        5Nrf6U+uTYbhYSNHA7YzC/5smg==
X-Google-Smtp-Source: ABdhPJwXxE4pwrV4JSPaLhEV6G1BlATgL4ZGVyFiXtLbOqPg4UWtN+ePnA8hBS3vgqyDG0O2W9xKlw==
X-Received: by 2002:a17:90b:a02:: with SMTP id gg2mr6864076pjb.110.1592973853293;
        Tue, 23 Jun 2020 21:44:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c7sm3578791pfj.106.2020.06.23.21.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 21:44:12 -0700 (PDT)
Date:   Tue, 23 Jun 2020 21:44:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: Re: [PATCH v3 3/9] efi/libstub: Remove .note.gnu.property
Message-ID: <202006232143.66828CD3@keescook>
References: <20200624014940.1204448-1-keescook@chromium.org>
 <20200624014940.1204448-4-keescook@chromium.org>
 <20200624033142.cinvg6rbg252j46d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624033142.cinvg6rbg252j46d@google.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 23, 2020 at 08:31:42PM -0700, 'Fangrui Song' via Clang Built Linux wrote:
> On 2020-06-23, Kees Cook wrote:
> > In preparation for adding --orphan-handling=warn to more architectures,
> > make sure unwanted sections don't end up appearing under the .init
> > section prefix that libstub adds to itself during objcopy.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > drivers/firmware/efi/libstub/Makefile | 3 +++
> > 1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > index 75daaf20374e..9d2d2e784bca 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -66,6 +66,9 @@ lib-$(CONFIG_X86)		+= x86-stub.o
> > CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
> > CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
> > 
> > +# Remove unwanted sections first.
> > +STUBCOPY_FLAGS-y		+= --remove-section=.note.gnu.property
> > +
> > #
> > # For x86, bootloaders like systemd-boot or grub-efi do not zero-initialize the
> > # .bss section, so the .bss section of the EFI stub needs to be included in the
> 
> arch/arm64/Kconfig enables ARM64_PTR_AUTH by default. When the config is on
> 
> ifeq ($(CONFIG_ARM64_BTI_KERNEL),y)
> branch-prot-flags-$(CONFIG_CC_HAS_BRANCH_PROT_PAC_RET_BTI) := -mbranch-protection=pac-ret+leaf+bti
> else
> branch-prot-flags-$(CONFIG_CC_HAS_BRANCH_PROT_PAC_RET) := -mbranch-protection=pac-ret+leaf
> endif
> 
> This option creates .note.gnu.property:
> 
> % readelf -n drivers/firmware/efi/libstub/efi-stub.o
> 
> Displaying notes found in: .note.gnu.property
>   Owner                Data size        Description
>   GNU                  0x00000010       NT_GNU_PROPERTY_TYPE_0
>       Properties: AArch64 feature: PAC
> 
> If .note.gnu.property is not desired in drivers/firmware/efi/libstub, specifying
> -mbranch-protection=none can override -mbranch-protection=pac-ret+leaf

We want to keep the branch protection enabled. But since it's not a
"regular" ELF, we don't need to keep the property that identifies the
feature.

-- 
Kees Cook
