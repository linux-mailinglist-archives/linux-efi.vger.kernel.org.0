Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFBA544AEF
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jun 2022 13:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244568AbiFILr5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Jun 2022 07:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244613AbiFILro (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Jun 2022 07:47:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943099CF0D;
        Thu,  9 Jun 2022 04:46:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41BA7B82D2A;
        Thu,  9 Jun 2022 11:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA83C3411D;
        Thu,  9 Jun 2022 11:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654775210;
        bh=/yxLzqAjj2ZrsiJ7/7VVT2f9u68+1KplA0iIvcfew/s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c8nKB7Pjyhf7T+iNcXR1vZsGr9vjU2ODmpnedAgMBbo+h8zI8MdhgL3sk9jU/ng9w
         vK6RaFT7p/PLaE7wtvvixE0+KtTThplqB45qjQCaiDL2hEP0rK1ZKYSlPyAaVMvVkE
         6NBjM8ZTNGPq+WZn16esfNS4vLlU/qsJyTiS5Yo/KnRRrhqvm3ln/yOmmdi0rz8JGC
         DojrATrdFQ5xkUxkDqMLjD0HbaGmyQw4rh6aTcQ1+AU6UugHcl+7wGdeFMYApFmh4F
         6Q/6fCeKPBurR7mXLR7K+q/pmQamNDHGdHGzggzlNGxRuobvUXBvxnNOwSvQ3za9k7
         Gs6ZZmylo8tjg==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-f2cbceefb8so30622963fac.11;
        Thu, 09 Jun 2022 04:46:49 -0700 (PDT)
X-Gm-Message-State: AOAM530GpQhdo46aykCNI3A8zFALo9bIO2cH9WJgsdHyhqym5aCgNVg4
        lJWItbIuFtR7VgVvlzo4l9dY2M94N7W3wVgkkfs=
X-Google-Smtp-Source: ABdhPJySqpOhlxopOUar3NHF1BEitePFrjp62TaQqPlr8UadINA15pPJJKyqzfrM3qQcpaduICaeC8hRDxT/vNWVgq4=
X-Received: by 2002:a05:6871:5c8:b0:f3:3c1c:126f with SMTP id
 v8-20020a05687105c800b000f33c1c126fmr1470910oan.126.1654775209137; Thu, 09
 Jun 2022 04:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220609113730.32062-1-baskov@ispras.ru>
In-Reply-To: <20220609113730.32062-1-baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 9 Jun 2022 13:46:36 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFvKAPzog7m4FFDLcGSO1F6nT5kzaDcyG635vy=UD0j6Q@mail.gmail.com>
Message-ID: <CAMj1kXFvKAPzog7m4FFDLcGSO1F6nT5kzaDcyG635vy=UD0j6Q@mail.gmail.com>
Subject: Re: [PATCH] efi/x86: libstub: Fix typo in __efi64_argmap* name
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 9 Jun 2022 at 13:39, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> The actual name of the DXE services function used
> is set_memory_space_attributes(), not set_memory_space_descriptor().
>
> Change EFI mixed mode helper macro name to match the function name.
>
> Fixes: 31f1a0edff78 ("efi/x86: libstub: Make DXE calls mixed mode safe")
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>

Thanks for the fix! I'll queue this up in efi/urgent


> ---
>  arch/x86/include/asm/efi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index 71943dce691e..9636742a80f2 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -323,7 +323,7 @@ static inline u32 efi64_convert_status(efi_status_t status)
>  #define __efi64_argmap_get_memory_space_descriptor(phys, desc) \
>         (__efi64_split(phys), (desc))
>
> -#define __efi64_argmap_set_memory_space_descriptor(phys, size, flags) \
> +#define __efi64_argmap_set_memory_space_attributes(phys, size, flags) \
>         (__efi64_split(phys), __efi64_split(size), __efi64_split(flags))
>
>  /*
> --
> 2.36.1
>
