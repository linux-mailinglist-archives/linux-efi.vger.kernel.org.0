Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294A668EF06
	for <lists+linux-efi@lfdr.de>; Wed,  8 Feb 2023 13:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjBHMgP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Feb 2023 07:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBHMgP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Feb 2023 07:36:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9D84858E
        for <linux-efi@vger.kernel.org>; Wed,  8 Feb 2023 04:36:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6500AB81DF6
        for <linux-efi@vger.kernel.org>; Wed,  8 Feb 2023 12:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEA4C4339B
        for <linux-efi@vger.kernel.org>; Wed,  8 Feb 2023 12:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675859771;
        bh=0J9PMRxhjbsevqHMJNjcVWbmEPkL/a1RE6bLygGsTsk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q90YcQMMey5PC+7g4Yp0DSG5Ylxz5cYES1hod48EzB0i2NIDWcephpUx0cB6l9/Aa
         A0XLyWYfFwHdOx5AUy4TXbHocpWMBP2OxpXc2XM2KY+k9KXCmT4zxrOdv0pm9jyO4t
         jn/GlimEbbsALtJ+nOcfyWSN5Eg3op6s1LniKTPVajpt0E7BsWw7IiLtyluT2wAmxv
         RDr++UKoInctTrzHLU7EkgndApstODLZ586gMFigP3pFeeEuzLCx65DE/QcR3c5LKi
         SJ38/L6djUX2X/VSeqGIMsXVWOWqABVEMTaPeCoPrz0GQIrXK/TXDyqFPr27Z2GpP6
         KAElLeFD/BuOg==
Received: by mail-lf1-f48.google.com with SMTP id o20so26868962lfk.5
        for <linux-efi@vger.kernel.org>; Wed, 08 Feb 2023 04:36:10 -0800 (PST)
X-Gm-Message-State: AO0yUKXb0NcsGUTysAjfKfqAXjnss2DPoi4+GiZHRmjJLmeiu1b+Iu8v
        jPsuZ5oKpsncQl86I4O6FXq/JeG4pA5VpFlnDWc=
X-Google-Smtp-Source: AK7set8qRoKGR1dGW/fwNwPKrsPJ+/5ylc9XW79ET85NXJSNth7FbQIlcg3I+tp/6TgRii83Fb9wqxS8gVn9XcEWPWE=
X-Received: by 2002:ac2:559b:0:b0:4b6:fae9:c9b9 with SMTP id
 v27-20020ac2559b000000b004b6fae9c9b9mr1231324lfg.207.1675859769105; Wed, 08
 Feb 2023 04:36:09 -0800 (PST)
MIME-Version: 1.0
References: <20230206124938.272988-1-ardb@kernel.org>
In-Reply-To: <20230206124938.272988-1-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 8 Feb 2023 13:35:57 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFK2ync+-k29YJP6mGbBcKF-oZ+z_0BjW7mCcHv3ygWnA@mail.gmail.com>
Message-ID: <CAMj1kXFK2ync+-k29YJP6mGbBcKF-oZ+z_0BjW7mCcHv3ygWnA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] efi: Enable BTI for EFI runtimes services
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 6 Feb 2023 at 13:49, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> The EFI spec v2.10 introduces a global flag in the memory attributes
> table that indicates whether the EFI runtime code regions were emitted
> with BTI landing pads, and can therefore tolerate being mapped with BTI
> enforcement enabled.
>
> Add the generic plumbing for this, and wire it up for arm64.
>
> Changes since v1:
> - enable BTI in UEFI code regions even if CONFIG_ARM64_BIT_KERNEL=n
> - deal with BTI exceptions occuring in EFI code gracefully
> - add equivalent handling to x86
> - add Kees's R-b
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>

x86, arm64 maintainers: I'd like to queue these up in the EFI tree.
Any objections?



> Ard Biesheuvel (3):
>   efi: Discover BTI support in runtime services regions
>   efi: arm64: Wire up BTI annotation in memory attributes table
>   efi: x86: Wire up IBT annotation in memory attributes table
>
>  arch/arm/include/asm/efi.h     |  2 +-
>  arch/arm/kernel/efi.c          |  5 +++--
>  arch/arm64/include/asm/efi.h   |  3 ++-
>  arch/arm64/kernel/efi.c        | 17 ++++++++++++++---
>  arch/arm64/kernel/traps.c      |  6 ++++++
>  arch/riscv/include/asm/efi.h   |  2 +-
>  arch/riscv/kernel/efi.c        |  3 ++-
>  arch/x86/include/asm/efi.h     |  4 +++-
>  arch/x86/include/asm/ibt.h     |  4 ++--
>  arch/x86/kernel/apm_32.c       |  4 ++--
>  arch/x86/kernel/cpu/common.c   |  5 +++--
>  arch/x86/platform/efi/efi_64.c |  8 +++++++-
>  drivers/firmware/efi/memattr.c |  7 ++++++-
>  include/linux/efi.h            |  8 ++++++--
>  14 files changed, 58 insertions(+), 20 deletions(-)
>
> --
> 2.39.1
>
