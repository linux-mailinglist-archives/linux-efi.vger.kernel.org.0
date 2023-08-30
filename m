Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF84A78D981
	for <lists+linux-efi@lfdr.de>; Wed, 30 Aug 2023 20:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjH3SdS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Aug 2023 14:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344000AbjH3Ryb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Aug 2023 13:54:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F98193;
        Wed, 30 Aug 2023 10:54:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35CC9622A8;
        Wed, 30 Aug 2023 17:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB38C433CD;
        Wed, 30 Aug 2023 17:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693418067;
        bh=rt/hnc5Zf5SvOK4V7TwKX86XH/xhfkZIEuWMAJko7Oo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Np2zGK4TLWp0cphvLVxcUlj5wXDzTyjj5YxDnjeCxuvyrjDbgLgWvhSZkXk5vCmFs
         NDp7omZg21RY2TTKlpXpT2RUyo6epc8oZBDdbDbu1SFOI3Nkci3O/E7iqjYNe4J8Ay
         6aTwpm+3voALdVhQptWSD2O8YslVbIv/e6lKUokdwzoFPo/Zp8bJ4l0FredImpl8BP
         N6gZXPdJ93XSpj6LzRzjLXFJZBv/fg4ooibDFDWDcfyU/BTvmLfMqy9rSqbJHzYlx0
         vLJFBlrv116pFEum1qt4zIu62R5mMrt5stOsRfzQv4dvw7JIwBwMfFxELHcWsCPu1n
         eUKk4flJKZEMg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4ff9b389677so147117e87.3;
        Wed, 30 Aug 2023 10:54:27 -0700 (PDT)
X-Gm-Message-State: AOJu0YxE+Q6WLdG/Z9QXHnXBp7bh1gpMQwWomx5xX9ja7888itCyB7uk
        QA6/7gVprND1VaZJR57M30GUIq5EJjsEu+eGKaA=
X-Google-Smtp-Source: AGHT+IEqQMN+IcRmtTMXd59iAF9ILtW7KZkiubAGa7hIsI/KtNSzlic4NfqcZz+mVUoS/phIzlMP38SZKD0dScnHdWk=
X-Received: by 2002:a05:6512:3d9e:b0:4fe:993:2218 with SMTP id
 k30-20020a0565123d9e00b004fe09932218mr2879577lfv.31.1693418065528; Wed, 30
 Aug 2023 10:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230830-missingvardecl-efi-v2-1-818081a204d2@google.com>
In-Reply-To: <20230830-missingvardecl-efi-v2-1-818081a204d2@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 30 Aug 2023 19:54:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGbBx=gWsDJ7nXPwygOvX=Ek3tPQmZ_fQpBNmVg5_7u9A@mail.gmail.com>
Message-ID: <CAMj1kXGbBx=gWsDJ7nXPwygOvX=Ek3tPQmZ_fQpBNmVg5_7u9A@mail.gmail.com>
Subject: Re: [PATCH v2] efi: fix -Wmissing-variable-declarations warning
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 30 Aug 2023 at 19:51, Justin Stitt <justinstitt@google.com> wrote:
>
> When building x86/defconfig with Clang-18 I encounter the following warnings:
> | arch/x86/platform/efi/efi.c:934:23: warning: no previous extern declaration for non-static variable 'efi_attr_fw_vendor' [-Wmissing-variable-declarations]
> |   934 | struct kobj_attribute efi_attr_fw_vendor = __ATTR_RO(fw_vendor);
> | arch/x86/platform/efi/efi.c:935:23: warning: no previous extern declaration for non-static variable 'efi_attr_runtime' [-Wmissing-variable-declarations]
> |   935 | struct kobj_attribute efi_attr_runtime = __ATTR_RO(runtime);
> | arch/x86/platform/efi/efi.c:936:23: warning: no previous extern declaration for non-static variable 'efi_attr_config_table' [-Wmissing-variable-declarations]
> |   936 | struct kobj_attribute efi_attr_config_table = __ATTR_RO(config_table);
>
> These symbols are declared extern in drivers/firmware/efi/efi.c. Move
> the declarations to linux/efi.h to resolve these warnings.
>
> Also, trim a trailing space from efi_set_variable_t typedef.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1920
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks, I'll take this as a fix.

> ---
> Changes in v2:
> - Don't use static. Instead move symbols to header file (thanks Ard)
> - Remove duplicated warnings output from b4 (thanks Ard)
> - Link to v1: https://lore.kernel.org/r/20230829-missingvardecl-efi-v1-1-13d055a55176@google.com
> ---
> Note: build-tested.
>
> Also, a question: Why does the compiler warn at all? The extern
> declarations _do_ exist as Ard points out [1].
>
> [1]: https://lore.kernel.org/all/CAMj1kXE_xs+wWno4G4U+6CFCOwO7JWcmNv4et5=W=ZRrQatWnQ@mail.gmail.com/

Those declarations are not observed by the compiler when building .c
files other than drivers/firmware/efi/efi.c, so they essentially don't
exist when compiling arch/x86/platform/efi/efi.c.


> ---
>  drivers/firmware/efi/efi.c | 3 ---
>  include/linux/efi.h        | 6 +++++-
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 1599f1176842..7b4e59ccf09e 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -161,9 +161,6 @@ static ssize_t fw_platform_size_show(struct kobject *kobj,
>         return sprintf(buf, "%d\n", efi_enabled(EFI_64BIT) ? 64 : 32);
>  }
>
> -extern __weak struct kobj_attribute efi_attr_fw_vendor;
> -extern __weak struct kobj_attribute efi_attr_runtime;
> -extern __weak struct kobj_attribute efi_attr_config_table;
>  static struct kobj_attribute efi_attr_fw_platform_size =
>         __ATTR_RO(fw_platform_size);
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index ab088c662e88..32f7ca60b0e9 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -287,7 +287,7 @@ typedef efi_status_t efi_get_variable_t (efi_char16_t *name, efi_guid_t *vendor,
>                                          unsigned long *data_size, void *data);
>  typedef efi_status_t efi_get_next_variable_t (unsigned long *name_size, efi_char16_t *name,
>                                               efi_guid_t *vendor);
> -typedef efi_status_t efi_set_variable_t (efi_char16_t *name, efi_guid_t *vendor,
> +typedef efi_status_t efi_set_variable_t (efi_char16_t *name, efi_guid_t *vendor,
>                                          u32 attr, unsigned long data_size,
>                                          void *data);
>  typedef efi_status_t efi_get_next_high_mono_count_t (u32 *count);
> @@ -632,6 +632,10 @@ typedef struct {
>
>  extern unsigned long __ro_after_init efi_rng_seed;             /* RNG Seed table */
>
> +extern __weak struct kobj_attribute efi_attr_fw_vendor;
> +extern __weak struct kobj_attribute efi_attr_runtime;
> +extern __weak struct kobj_attribute efi_attr_config_table;
> +
>  /*
>   * All runtime access to EFI goes through this structure:
>   */
>
> ---
> base-commit: 706a741595047797872e669b3101429ab8d378ef
> change-id: 20230829-missingvardecl-efi-59306aacfed4
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>
