Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361D86B479B
	for <lists+linux-efi@lfdr.de>; Fri, 10 Mar 2023 15:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbjCJOwR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Mar 2023 09:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbjCJOvl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Mar 2023 09:51:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52E911F631;
        Fri, 10 Mar 2023 06:48:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 598FD6196F;
        Fri, 10 Mar 2023 14:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF365C433B3;
        Fri, 10 Mar 2023 14:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678459702;
        bh=MZZ+xz3G0vilznbAM1hCF+BZtVWTz2PltybcPZKNnL8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LtvAHCO4o5meyqPkBJtVpvSiemyQ2z8bYClzjwMOCq/5vzcTeCY8oTEGpfo8x9tid
         nWdLbH6iqLpUA8ExqOON8Vk2/AelJ2AbeoRL8nIFtm+VFzm2St/rFd6Yf4Ubg+2DBV
         zyirIAGgKjgWTFA8DmM4fvzD4mGYf3niLB4Ab828kbwhuZp2IKp15TYb5O69d+cJrK
         Hpz2v1Mf8VkVUCOEecNiSBzWEQbBGueKeBJ+uaLAD4hWXqbV6nFkAZkjyIfKXfnt+y
         2DMMfsMnqW+VE/RGB5PtsfYqx8e0usUdtpN1was4RBvd2s82SwgEGbGR+9Pw0khygF
         KyMoDQT/9uc2A==
Received: by mail-lj1-f180.google.com with SMTP id by8so5529218ljb.7;
        Fri, 10 Mar 2023 06:48:22 -0800 (PST)
X-Gm-Message-State: AO0yUKWq+STV4wwV3e1OuOOqF5Zrsglq5LgZh9QMHjaEK/h2Yp/OOAAJ
        yF8+6p/iOL9bZgUp8zm7RZt/pvKVkguPuMb54Ws=
X-Google-Smtp-Source: AK7set+0BQ0DMOVyXPC1WgLMQEUn+f1e8kQdc94gXG38KqQMt70pg+KRu5rYeqlTUHvA7UYzqFKOy5zXh8GA+CzToc8=
X-Received: by 2002:a2e:595:0:b0:298:6d17:eaa7 with SMTP id
 143-20020a2e0595000000b002986d17eaa7mr3310478ljf.2.1678459700862; Fri, 10 Mar
 2023 06:48:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671098103.git.baskov@ispras.ru> <c60d49a99889cb81e177ab9e756edcfa23182b3a.1671098103.git.baskov@ispras.ru>
In-Reply-To: <c60d49a99889cb81e177ab9e756edcfa23182b3a.1671098103.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Mar 2023 15:48:09 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHtgjK8xobe3rbsxdBaGz1xMtXCV=WT7WFbHe9nMOUnww@mail.gmail.com>
Message-ID: <CAMj1kXHtgjK8xobe3rbsxdBaGz1xMtXCV=WT7WFbHe9nMOUnww@mail.gmail.com>
Subject: Re: [PATCH v4 03/26] x86/boot: Set cr0 to known state in trampoline
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

On Thu, 15 Dec 2022 at 13:38, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> Ensure WP bit to be set to prevent boot code from writing to
> non-writable memory pages.
>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Peter Jones <pjones@redhat.com>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/x86/boot/compressed/head_64.S | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index a75712991df3..9f2e8f50fc71 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -660,9 +660,8 @@ SYM_CODE_START(trampoline_32bit_src)
>         pushl   $__KERNEL_CS
>         pushl   %eax
>
> -       /* Enable paging again. */
> -       movl    %cr0, %eax
> -       btsl    $X86_CR0_PG_BIT, %eax
> +       /* Enable paging and set CR0 to known state (this also sets WP flag) */
> +       movl    $CR0_STATE, %eax
>         movl    %eax, %cr0
>
>         lret
> --
> 2.37.4
>
