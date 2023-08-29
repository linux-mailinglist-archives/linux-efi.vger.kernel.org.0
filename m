Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C4E78CFCF
	for <lists+linux-efi@lfdr.de>; Wed, 30 Aug 2023 01:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240926AbjH2XEj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Aug 2023 19:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239194AbjH2XED (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 29 Aug 2023 19:04:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4B11BE;
        Tue, 29 Aug 2023 16:04:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EC5A63CEB;
        Tue, 29 Aug 2023 23:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F01C433C7;
        Tue, 29 Aug 2023 23:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693350239;
        bh=jVzcnu/UgsHYD4Nl9qqosC0UyycvjOZKdeezuanMBlY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N5CUupjqE2hmWGcJ1w4pdoCQSaTp7vl8t22wKUpp3/GMVwelN5jFjmKIlEXlFiJ2U
         OgQ96lJCG/hLuz1SIasmSrTsTfWyq/IMNGt/CbuTEugzMBVBvUUT+8nj1zW+QcSpWF
         o25tUcVyIJmstbkNkBOHl9qd6sc4XX9HIlNNkancgRX0MZzd8d/m5QUKX0UE3ooY6i
         r8B8ApDYx7E6yoYXF1fNO9pcq1jH+4r1QD8EsoXaTNu5Y4fhxNvHLo+SaWz3+PHWnk
         BSRoEH6s+1xVdy+Tud3PqSUKgYMtIxyktWJCsUW0bpakrq0rbRAHseOH28w18DoOir
         AJG7wqrBLgEFw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4fe1b00fce2so7905532e87.3;
        Tue, 29 Aug 2023 16:03:59 -0700 (PDT)
X-Gm-Message-State: AOJu0YwCPbSXw/l9kGDfeDaextC0MGs80+MWVZghbqkLF5O/zZmOgGmb
        slhWdgDK9NEuR1g9RWYr+bJv/D+EAAeaDnTCOuc=
X-Google-Smtp-Source: AGHT+IGIqSRBbmlWliRp4UptnUYFlODvNphG0DEO9yK/aY0OPFiqZtDaXA7n3RqP+rAtqSAo4Ru1d2zsSyM1QBhvxkQ=
X-Received: by 2002:a19:e006:0:b0:4ff:7602:5879 with SMTP id
 x6-20020a19e006000000b004ff76025879mr179992lfg.55.1693350237951; Tue, 29 Aug
 2023 16:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230829-missingvardecl-efi-v1-1-13d055a55176@google.com>
In-Reply-To: <20230829-missingvardecl-efi-v1-1-13d055a55176@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 30 Aug 2023 01:03:46 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE_xs+wWno4G4U+6CFCOwO7JWcmNv4et5=W=ZRrQatWnQ@mail.gmail.com>
Message-ID: <CAMj1kXE_xs+wWno4G4U+6CFCOwO7JWcmNv4et5=W=ZRrQatWnQ@mail.gmail.com>
Subject: Re: [PATCH] efi: fix -Wmissing-variable-declarations warning
To:     Justin Stitt <justinstitt@google.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Justin,

On Wed, 30 Aug 2023 at 00:54, Justin Stitt <justinstitt@google.com> wrote:
>
> When building x86/defconfig with Clang-18 I encounter the following warnings:
> | arch/x86/platform/efi/efi.c:934:23: warning: no previous extern declaration for non-static variable 'efi_attr_fw_vendor' [-Wmissing-variable-declarations]
> |   934 | struct kobj_attribute efi_attr_fw_vendor = __ATTR_RO(fw_vendor);
> | arch/x86/platform/efi/efi.c:935:23: warning: no previous extern declaration for non-static variable 'efi_attr_runtime' [-Wmissing-variable-declarations]
> |   935 | struct kobj_attribute efi_attr_runtime = __ATTR_RO(runtime);
> | arch/x86/platform/efi/efi.c:936:23: warning: no previous extern declaration for non-static variable 'efi_attr_config_table' [-Wmissing-variable-declarations]
> |   936 | struct kobj_attribute efi_attr_config_table = __ATTR_RO(config_table);
>
> These variables are not externally declared anywhere (AFAIK)

They are:

drivers/firmware/efi/efi.c:extern __weak struct kobj_attribute
efi_attr_fw_vendor;
drivers/firmware/efi/efi.c:extern __weak struct kobj_attribute efi_attr_runtime;
drivers/firmware/efi/efi.c:extern __weak struct kobj_attribute
efi_attr_config_table;

> so let's
> add the static keyword and ensure we follow the ODR.
>

One Definition Rule, right? Better to spell that out.

> Link: https://github.com/ClangBuiltLinux/linux/issues/1920
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> When building x86/defconfig with Clang-18 I encounter the following warnings:
> | arch/x86/platform/efi/efi.c:934:23: warning: no previous extern declaration for non-static variable 'efi_attr_fw_vendor' [-Wmissing-variable-declarations]
> |   934 | struct kobj_attribute efi_attr_fw_vendor = __ATTR_RO(fw_vendor);
> | arch/x86/platform/efi/efi.c:935:23: warning: no previous extern declaration for non-static variable 'efi_attr_runtime' [-Wmissing-variable-declarations]
> |   935 | struct kobj_attribute efi_attr_runtime = __ATTR_RO(runtime);
> | arch/x86/platform/efi/efi.c:936:23: warning: no previous extern declaration for non-static variable 'efi_attr_config_table' [-Wmissing-variable-declarations]
> |   936 | struct kobj_attribute efi_attr_config_table = __ATTR_RO(config_table);

This is duplicated. Is this a b4 fail?

> ---
> Note: build-tested.
> ---
>  arch/x86/platform/efi/efi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index e9f99c56f3ce..30c354c52ad4 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -931,9 +931,9 @@ EFI_ATTR_SHOW(fw_vendor);
>  EFI_ATTR_SHOW(runtime);
>  EFI_ATTR_SHOW(config_table);
>
> -struct kobj_attribute efi_attr_fw_vendor = __ATTR_RO(fw_vendor);
> -struct kobj_attribute efi_attr_runtime = __ATTR_RO(runtime);
> -struct kobj_attribute efi_attr_config_table = __ATTR_RO(config_table);
> +static struct kobj_attribute efi_attr_fw_vendor = __ATTR_RO(fw_vendor);
> +static struct kobj_attribute efi_attr_runtime = __ATTR_RO(runtime);
> +static struct kobj_attribute efi_attr_config_table = __ATTR_RO(config_table);
>
>  umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n)
>  {
>

This won't work.

Those variables are referenced via weak references in generic code.
The idea is that the weak references resolve to NULL pointers on
architectures other than x86, terminating the array early and hiding
the non-existent variables.

Making them static in arch/x86/platform/efi/efi.c means that these
references will remain unsatisfied, and so the variables will no
longer be exposed on x86 either.
