Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851AF603A52
	for <lists+linux-efi@lfdr.de>; Wed, 19 Oct 2022 09:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJSHHE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Oct 2022 03:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJSHHD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Oct 2022 03:07:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ECF76471;
        Wed, 19 Oct 2022 00:07:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC66461775;
        Wed, 19 Oct 2022 07:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E584C43141;
        Wed, 19 Oct 2022 07:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666163218;
        bh=yoFgMajtWV7an1yfwg8IYr/rspfAgCFORTLMjanwwBA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fXKFKIQcr91GLqbnyXtgNp4qmI5kK24I29WYt6Ttwu9F5CmGxtoiluPTO8iijOBX6
         6KQSbTDT/q6Ai3SB+qxcqUFjUsFzCkaWSAK+Hv8702OutDsJvgdM2xxnv3yY7OJNfT
         bh67lddAgob6T52gHu9kuSK9RK+UcafpLkAgGn1MjEH5gO/LdibeuLOVBo9PLxmpie
         EYm360zCuVq27aTPjT77XZGN3b5VucbadAHoHdU7RnlhoPuO2NveWCklubU+ONZBc+
         hiEOZYz/G83i29W2DcKjJAVSp0naGJ0V34TZR1p4EKVUMBhlrcn0swXtrxxAVHzRJa
         Dr74VDX0LCeRQ==
Received: by mail-lj1-f180.google.com with SMTP id a25so21010619ljk.0;
        Wed, 19 Oct 2022 00:06:58 -0700 (PDT)
X-Gm-Message-State: ACrzQf04JcOC4nYhA75HpOU3TE7Z0ie6Yn65LN8zb3NioQtrg296lQ4w
        Ak96QEBCNDej2zF3IxtWtpiVtcROaLLMxdx/nlE=
X-Google-Smtp-Source: AMsMyM6OEIoiU2iJptVjgoz/VOK0nXEXN5nJpgpFx9cPvkbXXAOTBWF3VSHV4IhBqAxVbopJP+TiNczYU49pIWO1/w4=
X-Received: by 2002:a2e:b635:0:b0:26e:989e:438f with SMTP id
 s21-20020a2eb635000000b0026e989e438fmr2160401ljn.189.1666163216227; Wed, 19
 Oct 2022 00:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662459668.git.baskov@ispras.ru> <a155c20eec6343d34b3bdf40c024ce8b35a90e02.1662459668.git.baskov@ispras.ru>
In-Reply-To: <a155c20eec6343d34b3bdf40c024ce8b35a90e02.1662459668.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Oct 2022 09:06:45 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHUiBO0d926eWTtWZp_hvwHsVLzzn+fdS1EYoXHxpH+iA@mail.gmail.com>
Message-ID: <CAMj1kXHUiBO0d926eWTtWZp_hvwHsVLzzn+fdS1EYoXHxpH+iA@mail.gmail.com>
Subject: Re: [PATCH 03/16] x86/boot: Set cr0 to known state in trampoline
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 6 Sept 2022 at 12:41, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> Ensure WP bit to be set to prevent boot code from writing to
> non-writable memory pages.
>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> ---
>  arch/x86/boot/compressed/head_64.S | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index d33f060900d2..5273367283b7 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -619,9 +619,8 @@ SYM_CODE_START(trampoline_32bit_src)
>         /* Set up new stack */
>         leal    TRAMPOLINE_32BIT_STACK_END(%ecx), %esp
>
> -       /* Disable paging */
> -       movl    %cr0, %eax
> -       btrl    $X86_CR0_PG_BIT, %eax

Why do we no longer care about CR0's prior value?

> +       /* Disable paging and setup CR0 */
> +       movl    $(CR0_STATE & ~X86_CR0_PG), %eax
>         movl    %eax, %cr0
>
>         /* Check what paging mode we want to be in after the trampoline */
> --
> 2.35.1
>
