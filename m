Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CE95E891F
	for <lists+linux-efi@lfdr.de>; Sat, 24 Sep 2022 09:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbiIXH2M (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 24 Sep 2022 03:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiIXH13 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 24 Sep 2022 03:27:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36EF38A10;
        Sat, 24 Sep 2022 00:27:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F56460DB7;
        Sat, 24 Sep 2022 07:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04310C4347C;
        Sat, 24 Sep 2022 07:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664004422;
        bh=tt0jOXg97xVp5NYM4iKyzC9fLT2QSJBCxqt4QUSnBRs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cxu6aV2FnfOTOBFphC5ZhTe811lcPISTQ/85BkdTyf9dCqLA1+JcDRKlXOn5zqjUg
         cAjuCr1vgSxUem3m1D2lyUjJtIyrYez9+GmdnMeKewSy1i9ElB3HwHQ/TNApi1FYRA
         4dEQVoLmkxIAHOJDpemMDIjjVj+z8STIXyQ3iKxTjw+VmkLKNPAfCY0o7A9UWt6Usu
         gWrT+6C5BYxyIgzTzcWNC/w914r2HINcoQmuBsD2JJH3g2bXyvqeImxbJc7M0osTWN
         7FcS99mWTDdzh5vMgqu9cYt8i+mSgSOftq5xL8vK2aRlDwjHptSKG2fPMUtqWrnm8f
         yLEWtrRy/1z4w==
Received: by mail-lj1-f181.google.com with SMTP id j24so2267003lja.4;
        Sat, 24 Sep 2022 00:27:01 -0700 (PDT)
X-Gm-Message-State: ACrzQf15tQKyWMWEmzEzThxqMycTChdGnMOI2Fc+gqS+UEW8wz5nRwOB
        WvNlw4z0PKjy5sDK5e2KlUIffGiJKfbOVlbZ5ww=
X-Google-Smtp-Source: AMsMyM5i2gOhFswR/JCPJ+TrUVXIaw5UdmgNIjTgrno8/UpIa5Y24MFqIqwkWXPnisG24+Exdk5Dhk4DNzKrBpPsaiE=
X-Received: by 2002:a2e:8349:0:b0:26c:4311:9b84 with SMTP id
 l9-20020a2e8349000000b0026c43119b84mr4410587ljh.152.1664004419937; Sat, 24
 Sep 2022 00:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220923221730.1860518-1-dave.hansen@linux.intel.com>
In-Reply-To: <20220923221730.1860518-1-dave.hansen@linux.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 24 Sep 2022 09:26:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEAneXVTFenwrP5U6-SSO7Hqm07z=1w19PUS4MUHM+BRw@mail.gmail.com>
Message-ID: <CAMj1kXEAneXVTFenwrP5U6-SSO7Hqm07z=1w19PUS4MUHM+BRw@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Disable W^X detection and enforcement on 32-bit
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 24 Sept 2022 at 00:17, Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
> The 32-bit code is in a weird spot.  Some 32-bit builds (non-PAE) do not
> even have NX support.  Even PAE builds that support NX have to contend
> with things like EFI data and code mixed in the same pages where W+X
> is unavoidable.
>
> The folks still running X86_32=y kernels are unlikely to care much about
> NX.  That combined with the fundamental inability fix _all_ of the W+X
> things means this code had little value on X86_32=y.  Disable the checks.
>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: linux-efi@vger.kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Kees Cook <keescook@chromium.org>
> Link: https://lore.kernel.org/all/CAMj1kXHcF_iK_g0OZSkSv56Wmr=eQGQwNstcNjLEfS=mm7a06w@mail.gmail.com/

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/x86/mm/pat/set_memory.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 20b1e24baa85..efe882c753ca 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -587,6 +587,14 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
>  {
>         unsigned long end;
>
> +       /*
> +        * 32-bit has some unfixable W+X issues, like EFI code
> +        * and writeable data being in the same page.  Disable
> +        * detection and enforcement there.
> +        */
> +       if (IS_ENABLED(CONFIG_X86_32))
> +               return new;
> +
>         /* Only enforce when NX is supported: */
>         if (!(__supported_pte_mask & _PAGE_NX))
>                 return new;
> --
> 2.34.1
>
