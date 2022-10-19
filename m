Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC43603AE1
	for <lists+linux-efi@lfdr.de>; Wed, 19 Oct 2022 09:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiJSHov (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Oct 2022 03:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiJSHoq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Oct 2022 03:44:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D0A1B7AF;
        Wed, 19 Oct 2022 00:44:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B82B617AE;
        Wed, 19 Oct 2022 07:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2B5C4347C;
        Wed, 19 Oct 2022 07:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666165482;
        bh=laG/TTZVBCYei5vgJF8Jt781WtjG/5mOgjJGDq5vj9s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IvFIt59F4JPs8pDaudSOGDGD6BbPXM3aQSEnS52ErG4ns+YhkHzaEFeqpGSr3tOK6
         l9plR1wO9ypq1PS0S7h41C3JAQ47DchFJY4nrO9snJS77g5OXT1Pq8hVD1pJQfoPoM
         2+yk2U+ZfgG6KTaZi/pgblZbvNQ+2AN10QL1V2Wwld51U/sQHx+aKSVt4x80lI8EU7
         4rYYASMMz8LOTazY7BMf0czj6g1YLi6G6i+7qBsJMdje9hN6GoG/gwHps8L38k8z8s
         USVDaaVJHavvzi9qFchZT/s4nLdywAPSr+5Phu5ynaVol2aJGBWntgiMjsmgvCC+HT
         22J2BwhPQzRuA==
Received: by mail-lf1-f51.google.com with SMTP id be13so11076665lfb.4;
        Wed, 19 Oct 2022 00:44:42 -0700 (PDT)
X-Gm-Message-State: ACrzQf0diQIvI7A4VO1ga13nVg1ciciGgL2+9eowiTr7KcDMh46R6GvV
        uPqW6n+jeg7Cnix6vtu3bxKIgHp+MG2xNvkH5K0=
X-Google-Smtp-Source: AMsMyM78xPUZLp3fGfd8WqNSEwjoyE7ePjMOVGDkDRzzI7GRGqK0ncCGcWapq067zvspx0wwA09NQD7xq+995Hjw/z8=
X-Received: by 2002:a05:6512:3119:b0:4a2:d749:ff82 with SMTP id
 n25-20020a056512311900b004a2d749ff82mr2499071lfb.637.1666165480606; Wed, 19
 Oct 2022 00:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <5de2d80398986b81b6cfcdd35436bba8bf62c0e7.1662459668.git.baskov@ispras.ru>
 <20221018205118.3756594-1-pjones@redhat.com>
In-Reply-To: <20221018205118.3756594-1-pjones@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Oct 2022 09:44:29 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEbY5C_UjK3O=BodGaDRMW4OYgO=SOoNwc7XA+j2L1wVg@mail.gmail.com>
Message-ID: <CAMj1kXEbY5C_UjK3O=BodGaDRMW4OYgO=SOoNwc7XA+j2L1wVg@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: make memory protection warnings include newlines.
To:     Peter Jones <pjones@redhat.com>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
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

On Tue, 18 Oct 2022 at 22:51, Peter Jones <pjones@redhat.com> wrote:
>
> efi_warn() doesn't put newlines on messages, and that makes reading
> warnings without newlines hard to do.
>
> Signed-off-by: Peter Jones <pjones@redhat.com>

OK, so this applies on top of Evgeniy's series, right? Do we need a
version for 6.1-rc1 ?

> ---
>  drivers/firmware/efi/libstub/mem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
> index 4d6c7f4fb7e..1b874096109 100644
> --- a/drivers/firmware/efi/libstub/mem.c
> +++ b/drivers/firmware/efi/libstub/mem.c
> @@ -293,7 +293,7 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
>                                 rounded_end - rounded_start,
>                                 attr_clear);
>         if (status != EFI_SUCCESS) {
> -               efi_warn("Failed to clear memory attributes at [%08lx,%08lx]: %lx",
> +               efi_warn("Failed to clear memory attributes at [%08lx,%08lx]: %lx\n",
>                          (unsigned long)rounded_start,
>                          (unsigned long)rounded_end,
>                          status);
> @@ -306,7 +306,7 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
>                                 rounded_end - rounded_start,
>                                 attributes);
>         if (status != EFI_SUCCESS) {
> -               efi_warn("Failed to set memory attributes at [%08lx,%08lx]: %lx",
> +               efi_warn("Failed to set memory attributes at [%08lx,%08lx]: %lx\n",
>                          (unsigned long)rounded_start,
>                          (unsigned long)rounded_end,
>                          status);
> --
> 2.37.1
>
