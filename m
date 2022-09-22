Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3F35E6F64
	for <lists+linux-efi@lfdr.de>; Fri, 23 Sep 2022 00:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiIVWJP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Sep 2022 18:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiIVWJO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Sep 2022 18:09:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6329F1129E8;
        Thu, 22 Sep 2022 15:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1693FB80D24;
        Thu, 22 Sep 2022 22:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B121EC43470;
        Thu, 22 Sep 2022 22:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663884550;
        bh=yhEq7Kx+9fokf6ojtPysLGhQGDpX6JAwF3tWtnzJsrc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gJhX1Hp4djRyMuWxZVf3Acuv01czzmRvSZjFPP8mutU4h/hFPvCVzhvmu245ghps8
         IAnLwyWX6/E5arGyeeUdB3zQtscl5q/Toi800x7GTIzXhOj0OF8Df/sb4RqrRY8k76
         Celq2oNXFx1W2YxzLWZAWMp7DSG95EKllQVC3s/HrSqtHBAoGFDY/vMk3HLLpHcfI7
         6I0UBa110pK04Dp3AfWWICL5/M0rv3QBhsohRv0R6ErClPZPMx5nPm4cbsUuqoFk+o
         jBVrbS9EnZNlARX1/1m5RTSxjBTIPm/smn6YMJ640wUH3Z2A9X8BO3ECBpSvYX8rnu
         NJEEjWDX1C9hg==
Received: by mail-lf1-f52.google.com with SMTP id z25so16954619lfr.2;
        Thu, 22 Sep 2022 15:09:10 -0700 (PDT)
X-Gm-Message-State: ACrzQf1aFIzoilw5vkLxjdN+pdF6kHhKX5UKWTvwC1bMAFZuO2E58Et3
        4ybmTTXPEAgIQBCfiJ0GlzIalqMD5z1w7qh7D/w=
X-Google-Smtp-Source: AMsMyM6tUfuFClTNZiSF+ApjyX+31uovgZsMWU9ahZv1+27FMrZppnvlxWuJjRopOTeFw/y0iOW+lL+InNHoQjN5RJY=
X-Received: by 2002:a05:6512:13a1:b0:48d:f14:9059 with SMTP id
 p33-20020a05651213a100b0048d0f149059mr2263181lfa.110.1663884548707; Thu, 22
 Sep 2022 15:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <08906193-246b-c874-8bac-1d98d2313ac4@roeck-us.net> <20220922193157.1673623-1-dave.hansen@linux.intel.com>
In-Reply-To: <20220922193157.1673623-1-dave.hansen@linux.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 23 Sep 2022 00:08:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHcF_iK_g0OZSkSv56Wmr=eQGQwNstcNjLEfS=mm7a06w@mail.gmail.com>
Message-ID: <CAMj1kXHcF_iK_g0OZSkSv56Wmr=eQGQwNstcNjLEfS=mm7a06w@mail.gmail.com>
Subject: Re: [PATCH] x86/mm+efi: Avoid creating W+X mappings
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 22 Sept 2022 at 21:32, Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
> From: Peter Zijlstra <peterz@infradead.org>
>
> I'm planning on sticking this in x86/mm so that it goes upstream
> along with the W+X detection code.
>
> --
>
> A recent x86/mm change warns and refuses to create W+X mappings.
>
> The 32-bit EFI code tries to create such a mapping and trips over
> the new W+X refusal.
>
> Make the EFI_RUNTIME_SERVICES_CODE mapping read-only to fix it.
>

This is not safe. EFI_RUNTIME_SERVICES_CODE covers both .text and
.data sections of the EFI runtime PE/COFF executables in memory, so
you are essentially making .data and .bss read-only. (Whether those
executables actually modify their .data and .bss at runtime is a
different matter, but the point is that it used to be possible)

More recent firmwares may provide a 'memory attributes table'
separately which describes the individual sections, but older 32-bit
firmwares are not even built with 4k section alignment, so code and
data may share a single page. Note that we haven't wired up this
memory attributes table on i386 at the moment, and I seriously doubt
that 32-bit firmware in the field exposes it.

Can we just turn off this feature for 32-bit?

> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: linux-efi@vger.kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Link: https://lore.kernel.org/all/d8cd7c7e-24c1-7f70-24a9-91c77aa634af@roeck-us.net/
> ---
>  arch/x86/platform/efi/efi_32.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_32.c
> index e06a199423c0..d81e379fcd43 100644
> --- a/arch/x86/platform/efi/efi_32.c
> +++ b/arch/x86/platform/efi/efi_32.c
> @@ -136,6 +136,7 @@ void __init efi_runtime_update_mappings(void)
>                         if (md->type != EFI_RUNTIME_SERVICES_CODE)
>                                 continue;
>
> +                       set_memory_ro(md->virt_addr, md->num_pages);
>                         set_memory_x(md->virt_addr, md->num_pages);
>                 }
>         }
