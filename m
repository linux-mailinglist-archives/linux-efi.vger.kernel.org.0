Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A965A206AA4
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jun 2020 05:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388665AbgFXDbr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Jun 2020 23:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388292AbgFXDbq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Jun 2020 23:31:46 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9FCC061573
        for <linux-efi@vger.kernel.org>; Tue, 23 Jun 2020 20:31:46 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a45so1797896pje.1
        for <linux-efi@vger.kernel.org>; Tue, 23 Jun 2020 20:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IahJt8/KJJjCX5znAGwjVoLhoLAi5KgGttIopC9m27U=;
        b=MvLV62bGP7HuCujPeBIHKz13XUI8YQmFtRra1vib+8tF+xHHQRVE/n3L2rgdukvz0W
         tXgg5gRG56BP2uOmEc+oEMf47b4I2KLwUM3lCVukC+NRxgYxHqsxLKDUjSfA6R0sfqEo
         TgggLZp03MNbl6iiR1g9B+Tdp9CA3YajVJsQpkFoRyIFXvFULZrBVh7rUaJHmg4R6nNH
         1qsvb5gRGuCH3ZPUtMEqqFW/A+OofiC/qMD5DJlvOz7Ilyyt2ZStv6KM1sJPos9n372w
         0UbUY406dJ7GN3qOL01soPCDMdymvlW2KSQp3fukKyBl3YvdOFBaJIjT8ZDn4ePN1mFb
         xD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IahJt8/KJJjCX5znAGwjVoLhoLAi5KgGttIopC9m27U=;
        b=aQ3YPZZCfrjAKK2D5AmpW84lYoctOS/7QQADndw9NyCLHW4gv5Ty/pMeURk0FCvWDr
         tq1XPCFXjkamHElXPpOD3kknuKLIigLSRZMoIcB0XVnPvDLRklL/EA4XKcparRwmtXBz
         QaiQM6mATK+uzwkWgaFzx3EuGD1WN6peM7MocnrG1w0p8t6k45WcAXqddBbHMLQ8+wEN
         vB5IbNfT6DbBzp686VAgNHFm9Am0VkSknHU6Ma/04Cp+TOj67nQpF657P3DF8tZxWJxA
         byxaqxURg93Ulgs3gCs6U6hPpROvudnIf90bDjL+Nz3Q//FbaBqT7+/vpCsbybXcP66q
         MLdA==
X-Gm-Message-State: AOAM533dnayOlsmzPb62TxuHBIqlrFUg6Kc273CAn01+rbX9BjdOQJz9
        Od7fWR4hvxJH6rRi9JxY8HtzjQ==
X-Google-Smtp-Source: ABdhPJwO/hYz95xUwT1OWmJI4vtUw4+LYaBqYL3FPsRivwPfG7ygEmvTnhPAC6hvl2WpJppN7B6bFQ==
X-Received: by 2002:a17:90a:1ac3:: with SMTP id p61mr27689014pjp.23.1592969505744;
        Tue, 23 Jun 2020 20:31:45 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id c2sm14702791pgk.77.2020.06.23.20.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 20:31:45 -0700 (PDT)
Date:   Tue, 23 Jun 2020 20:31:42 -0700
From:   Fangrui Song <maskray@google.com>
To:     Kees Cook <keescook@chromium.org>
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
Message-ID: <20200624033142.cinvg6rbg252j46d@google.com>
References: <20200624014940.1204448-1-keescook@chromium.org>
 <20200624014940.1204448-4-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200624014940.1204448-4-keescook@chromium.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2020-06-23, Kees Cook wrote:
>In preparation for adding --orphan-handling=warn to more architectures,
>make sure unwanted sections don't end up appearing under the .init
>section prefix that libstub adds to itself during objcopy.
>
>Signed-off-by: Kees Cook <keescook@chromium.org>
>---
> drivers/firmware/efi/libstub/Makefile | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
>index 75daaf20374e..9d2d2e784bca 100644
>--- a/drivers/firmware/efi/libstub/Makefile
>+++ b/drivers/firmware/efi/libstub/Makefile
>@@ -66,6 +66,9 @@ lib-$(CONFIG_X86)		+= x86-stub.o
> CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
> CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
>
>+# Remove unwanted sections first.
>+STUBCOPY_FLAGS-y		+= --remove-section=.note.gnu.property
>+
> #
> # For x86, bootloaders like systemd-boot or grub-efi do not zero-initialize the
> # .bss section, so the .bss section of the EFI stub needs to be included in the

arch/arm64/Kconfig enables ARM64_PTR_AUTH by default. When the config is on

ifeq ($(CONFIG_ARM64_BTI_KERNEL),y)
branch-prot-flags-$(CONFIG_CC_HAS_BRANCH_PROT_PAC_RET_BTI) := -mbranch-protection=pac-ret+leaf+bti
else
branch-prot-flags-$(CONFIG_CC_HAS_BRANCH_PROT_PAC_RET) := -mbranch-protection=pac-ret+leaf
endif

This option creates .note.gnu.property:

% readelf -n drivers/firmware/efi/libstub/efi-stub.o

Displaying notes found in: .note.gnu.property
   Owner                Data size        Description
   GNU                  0x00000010       NT_GNU_PROPERTY_TYPE_0
       Properties: AArch64 feature: PAC

If .note.gnu.property is not desired in drivers/firmware/efi/libstub, specifying
-mbranch-protection=none can override -mbranch-protection=pac-ret+leaf
