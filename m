Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DD76B2948
	for <lists+linux-efi@lfdr.de>; Thu,  9 Mar 2023 17:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjCIQBE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Mar 2023 11:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjCIQAu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Mar 2023 11:00:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97461F5AA4;
        Thu,  9 Mar 2023 08:00:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 293B461C22;
        Thu,  9 Mar 2023 16:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C83CC4339C;
        Thu,  9 Mar 2023 16:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678377648;
        bh=xGVkS6scNuvZhWVzQCSAM/tJ2TcWmpRwNjJ04sFqFgw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M5mlTu6hmiPeisf1qvoP5apm1YS99Su77yn/KtMZ2GaLHcMurIwkePcWzjEah8axX
         JZgNtVrRMOx8bkt84F4Zw8OKA6ZDvPyB0qBtMTlF0KyoxyY/hC+jsep4XBNzegYofk
         MiHX9LJe6pnq7fZIoMMjxbuFKmlNnS57Nc2+/E1+7/JncH1rSpn4QNx/WM0jq7oEax
         hk8HSxs3ltZbu1u9916mWiAKZ5E/2sS8NM+sbcA1UHvnTHCGqeSa7ZtM+K+864A8Xv
         eXO0hoEkfnKXHnUFmFbmmnGPMkPAvsIRslAAmPRgiAGvPI33yBIRnX3RcMRe2lG3Se
         OQ/fjcjM7Th5w==
Received: by mail-lj1-f174.google.com with SMTP id f16so2325118ljq.10;
        Thu, 09 Mar 2023 08:00:48 -0800 (PST)
X-Gm-Message-State: AO0yUKWGGvsQ2GVmvvobuvgNUYq5W1B6rt9WdZOglYHJmAmc2lYi6ngN
        gTm0utMftVisolcjLoR+hUxMG8kiDDwJYE2F9R0=
X-Google-Smtp-Source: AK7set/q/bEE3jDzwupjxsdH3cF5Xe44HjEhNbwszAPe7QVUsBz9MEFkkz91I839rXg8qCjxo0eGWWIDzvVBGP1oPZM=
X-Received: by 2002:a2e:595:0:b0:298:6d17:eaa7 with SMTP id
 143-20020a2e0595000000b002986d17eaa7mr2195444ljf.2.1678377646558; Thu, 09 Mar
 2023 08:00:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671098103.git.baskov@ispras.ru> <8945a9cd072754d8dda9961a5499fc7b0c2e8743.1671098103.git.baskov@ispras.ru>
In-Reply-To: <8945a9cd072754d8dda9961a5499fc7b0c2e8743.1671098103.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 9 Mar 2023 17:00:35 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH+vfZQMxfO+tZPnZrxaZX4ffxpzHrdCnTfP70DgO=YJQ@mail.gmail.com>
Message-ID: <CAMj1kXH+vfZQMxfO+tZPnZrxaZX4ffxpzHrdCnTfP70DgO=YJQ@mail.gmail.com>
Subject: Re: [PATCH v4 15/26] efi/x86: Support extracting kernel from libstub
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 15 Dec 2022 at 13:40, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> Doing it that way allows setting up stricter memory attributes,
> simplifies boot code path and removes potential relocation
> of kernel image.
>
> Wire up required interfaces and minimally initialize zero page
> fields needed for it to function correctly.
>
> Tested-by: Peter Jones <pjones@redhat.com>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> ---
>  arch/x86/boot/compressed/head_32.S            |  50 ++++-
>  arch/x86/boot/compressed/head_64.S            |  58 ++++-
>  drivers/firmware/efi/Kconfig                  |   2 +
>  drivers/firmware/efi/libstub/Makefile         |   2 +-
>  .../firmware/efi/libstub/x86-extract-direct.c | 208 ++++++++++++++++++
>  drivers/firmware/efi/libstub/x86-stub.c       | 119 +---------
>  drivers/firmware/efi/libstub/x86-stub.h       |  14 ++
>  7 files changed, 338 insertions(+), 115 deletions(-)
>  create mode 100644 drivers/firmware/efi/libstub/x86-extract-direct.c
>  create mode 100644 drivers/firmware/efi/libstub/x86-stub.h
>
> diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
> index ead6007df1e5..0be75e5072ae 100644
> --- a/arch/x86/boot/compressed/head_32.S
> +++ b/arch/x86/boot/compressed/head_32.S
> @@ -152,11 +152,57 @@ SYM_FUNC_END(startup_32)
>
>  #ifdef CONFIG_EFI_STUB
>  SYM_FUNC_START(efi32_stub_entry)
> +/*
> + * Calculate the delta between where we were compiled to run
> + * at and where we were actually loaded at.  This can only be done
> + * with a short local call on x86.  Nothing  else will tell us what
> + * address we are running at.  The reserved chunk of the real-mode
> + * data at 0x1e4 (defined as a scratch field) are used as the stack
> + * for this calculation. Only 4 bytes are needed.
> + */

Please drop this comment

> +       call    1f
> +1:     popl    %ebx
> +       addl    $_GLOBAL_OFFSET_TABLE_+(.-1b), %ebx

Please drop this and ...

> +
> +       /* Clear BSS */
> +       xorl    %eax, %eax
> +       leal    _bss@GOTOFF(%ebx), %edi
> +       leal    _ebss@GOTOFF(%ebx), %ecx

just use (_bss - 1b) here (etc)

> +       subl    %edi, %ecx
> +       shrl    $2, %ecx
> +       rep     stosl
> +
>         add     $0x4, %esp
>         movl    8(%esp), %esi   /* save boot_params pointer */
> +       movl    %edx, %edi      /* save GOT address */

What does this do?

>         call    efi_main
> -       /* efi_main returns the possibly relocated address of startup_32 */
> -       jmp     *%eax
> +       movl    %eax, %ecx
> +
> +       /*
> +        * efi_main returns the possibly
> +        * relocated address of extracted kernel entry point.
> +        */
> +
> +       cli
> +
> +       /* Load new GDT */
> +       leal    gdt@GOTOFF(%ebx), %eax
> +       movl    %eax, 2(%eax)
> +       lgdt    (%eax)
> +
> +       /* Load segment registers with our descriptors */
> +       movl    $__BOOT_DS, %eax
> +       movl    %eax, %ds
> +       movl    %eax, %es
> +       movl    %eax, %fs
> +       movl    %eax, %gs
> +       movl    %eax, %ss
> +
> +       /* Zero EFLAGS */
> +       pushl   $0
> +       popfl
> +
> +       jmp     *%ecx
>  SYM_FUNC_END(efi32_stub_entry)
>  SYM_FUNC_ALIAS(efi_stub_entry, efi32_stub_entry)
>  #endif
...
