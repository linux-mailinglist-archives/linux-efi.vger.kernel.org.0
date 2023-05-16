Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACB97054D1
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 19:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjEPRRX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 13:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjEPRRW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 13:17:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2D8FC;
        Tue, 16 May 2023 10:17:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D75F63D09;
        Tue, 16 May 2023 17:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695A0C433A8;
        Tue, 16 May 2023 17:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684257440;
        bh=WElwajV57R1ZF+d3DvmtrkbIt4Bk9tb18ajBvlQX0oQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GmVJv/QRb6t7cFLx7+N00ZvbnoIHiXNmN/tOo0s7PCbTU9QPqYTS/8eTyZOGVoj/E
         rD9sLojkUUHKGso1uxKjepTnvgrevfCdJm7IMTmOp/wGIIcPeHN8OLHWrTnNINtbiK
         u3N3WaIiX2G8ZjkiD8GqAaJeh98dFFpZKS0ij/ig41IY9jbk/eEZarHO0eopMZB9nX
         2wadUj4Q2HOqXZ8lA/uzmN1YBjAETaGy8hoyiP/xeWGv9+WxGDMXE/WbOrh/oGr3oy
         Gk6hisncCPi+yD4LI1Zrfk8qza6qjaN229bTLbsmVKIG/yJqm4wJKUiYUv4xD+zIzV
         q0CUtjsFlzYbw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4eed764a10cso16462018e87.0;
        Tue, 16 May 2023 10:17:20 -0700 (PDT)
X-Gm-Message-State: AC+VfDywOI302zEQotX5DNmTOXoB83AiGITALWEc2/XBe6/29w5vDjC+
        DntdIZo1oQSwKeK3aBTTea29BUUbIh626z/BVsY=
X-Google-Smtp-Source: ACHHUZ4VMVquCoFbXiDWYhR8Guy+zOWzA/fxaWPI3piMmQSNzbFag9YgignmrUhRLyODzAtSO/Hosm6vdBHv78s5Fw0=
X-Received: by 2002:a19:ad45:0:b0:4f2:7b64:f16f with SMTP id
 s5-20020a19ad45000000b004f27b64f16fmr3971449lfd.52.1684257438252; Tue, 16 May
 2023 10:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230516160642.523862-1-arnd@kernel.org>
In-Reply-To: <20230516160642.523862-1-arnd@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 16 May 2023 19:17:07 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFTYo0HvP3izv2tgewCBT37LG0hgXKvn8zSmNfB0kUFHQ@mail.gmail.com>
Message-ID: <CAMj1kXFTYo0HvP3izv2tgewCBT37LG0hgXKvn8zSmNfB0kUFHQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] arm64: address -Wmissing-prototype warnings
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 16 May 2023 at 18:06, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> This addresses all arm64 specific protype warnings. As with the arm32
> patches, the majority of them  should be straightforward, either adding
> an #include statement to get the right header, or ensuring that an unused
> global function is left out of the build when the prototype is hidden.
>
> The ones that are a bit awkward are those that just add a prototype to
> shut up the warning, but the prototypes are never used for calling the
> function because the only caller is in assembler code. I tried to come
> up with other ways to shut up the compiler, and ideally this would be
> triggered by the 'asmlinkage' keyword as Ard suggested in the past, but
> I could not come up with a way to do this.
>
> All of the warnings have to be addressed in some form before the
> warning can be enabled by default.
>
>     Arnd
>
> Link: https://people.kernel.org/arnd/missing-prototype-warnings-in-the-kernel
>

For the record, as I mentioned a while ago, I think it is a bit
disappointing that we cannot teach the compiler that 'asmlinkage'
functions don't need a prototype. But I don't have any objections to
these changes, so

Acked-by: Ard Biesheuvel <ardb@kernel.org>

>
> Arnd Bergmann (15):
>   arm64: xor-neon: mark xor_arm64_neon_*() static
>   arm64: add scs_patch_vmlinux prototype
>   arm64: avoid prototype warnings for syscalls
>   arm64: move cpu_suspend_set_dbg_restorer() prototype to header
>   arm64: spectre: provide prototypes for internal functions
>   arm64: kvm: add prototypes for functions called in asm
>   arm64: cpuidle: fix #ifdef for acpi functions
>   arm64: efi: add efi_handle_corrupted_x18 prototype
>   arm64: hide unused is_valid_bugaddr()
>   arm64: module-plts: inline linux/moduleloader.h
>   arm64: flush: include linux/libnvdimm.h
>   arm64: kaslr: add kaslr_early_init() declaration
>   arm64: signal: include asm/exception.h
>   arm64: move early_brk64 prototype to header
>   arm64: add alt_cb_patch_nops prototype
>
>  arch/arm64/include/asm/alternative.h     |  3 +++
>  arch/arm64/include/asm/archrandom.h      |  2 ++
>  arch/arm64/include/asm/compat.h          |  2 ++
>  arch/arm64/include/asm/efi.h             |  2 ++
>  arch/arm64/include/asm/hw_breakpoint.h   |  8 ++++++++
>  arch/arm64/include/asm/kvm_asm.h         | 18 ++++++++++++++++++
>  arch/arm64/include/asm/scs.h             |  1 +
>  arch/arm64/include/asm/spectre.h         | 16 ++++++++++++++++
>  arch/arm64/include/asm/syscall_wrapper.h |  4 ++++
>  arch/arm64/include/asm/traps.h           |  2 ++
>  arch/arm64/kernel/cpuidle.c              |  2 +-
>  arch/arm64/kernel/hw_breakpoint.c        |  8 --------
>  arch/arm64/kernel/module-plts.c          |  1 +
>  arch/arm64/kernel/signal.c               |  1 +
>  arch/arm64/kernel/traps.c                |  3 ++-
>  arch/arm64/lib/xor-neon.c                |  8 ++++----
>  arch/arm64/mm/fault.c                    |  3 ---
>  arch/arm64/mm/flush.c                    |  1 +
>  18 files changed, 68 insertions(+), 17 deletions(-)
>
> --
> 2.39.2
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: James Morse <james.morse@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Zenghui Yu <yuzenghui@huawei.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-efi@vger.kernel.org
> Cc: kvmarm@lists.linux.dev
>
