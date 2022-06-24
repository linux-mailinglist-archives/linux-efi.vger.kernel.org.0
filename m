Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B960A55A06F
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 20:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiFXRlr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 13:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiFXRlq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 13:41:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5017B22BE9;
        Fri, 24 Jun 2022 10:41:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5F2561F0D;
        Fri, 24 Jun 2022 17:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A89C3411C;
        Fri, 24 Jun 2022 17:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656092505;
        bh=pe98CI9kCtS1Z+q8yXfT3SeDJPX3/R3m/CosNWDamWI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ibE5U0/j9jkIKhC+tjYF3b1ypWLCXgHEjiJqJVE3ZE6yeqT4rL3D6PFuUZw0COffu
         QaX37rbWvwf9hkyEsOb4Xeloqr3Rm4U1NZyhxDigTiQkCkdoKXjcl84nuaTixGnqAZ
         11dKeRstUuvLSkanhit98+qbHdzBPpbo4LSAqw6I0e1qNAX8R5jCjxIFt/7Am1WWT6
         ikH9+O7x78mXervpgP4eXAEImBXWVKFqDXFJjP1OMOKEQ/te0Z/zmxB9aPXXDq6Exx
         LTFeQWTGut2psennWZlMXRJvNW1nU4bIvBvRQmA3VzBF1ftRt6HGfPd1VA4RavcEDv
         Tyk1sipTDbZ7w==
Received: by mail-oi1-f169.google.com with SMTP id be10so4460448oib.7;
        Fri, 24 Jun 2022 10:41:45 -0700 (PDT)
X-Gm-Message-State: AJIora/4M66gJLXf53wk+l56oIOW6kaLmwSfNgQbuhiq1fWjhhBfiXj0
        jBktLXMMVZJ+A5rcW8eaPRVm1Pel37FNOBMIBcU=
X-Google-Smtp-Source: AGRyM1sSG7rQV/siZ5/AO6SL294YHu79aRFgAW9PSWR9NoI5jlkbofCIbWS+/AonubZrtRC3RqqDXurne3KByTcXHn0=
X-Received: by 2002:a05:6808:13c6:b0:335:3e54:94bc with SMTP id
 d6-20020a05680813c600b003353e5494bcmr2544949oiw.228.1656092504520; Fri, 24
 Jun 2022 10:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220624152331.4009502-1-sudeep.holla@arm.com> <20220624152331.4009502-3-sudeep.holla@arm.com>
In-Reply-To: <20220624152331.4009502-3-sudeep.holla@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 24 Jun 2022 19:41:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH4fo_mm2aRTU2ehkk=gzf0r93cXk4OMX54-hGDt76U7Q@mail.gmail.com>
Message-ID: <CAMj1kXH4fo_mm2aRTU2ehkk=gzf0r93cXk4OMX54-hGDt76U7Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] ACPI: Enable Platform Runtime Mechanism(PRM) support
 on ARM64
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jose Marinho <jose.marinho@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 24 Jun 2022 at 17:23, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> There is interest to make use of PRM(Platform Runtime Mechanism) even on
> ARM64 ACPI platforms. Allow PRM to be enabled on ARM64 platforms. It will
> be enabled by default as on x86_64.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  drivers/acpi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 1e34f846508f..d08b7408f0a5 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -592,7 +592,7 @@ config X86_PM_TIMER
>
>  config ACPI_PRMT
>         bool "Platform Runtime Mechanism Support"
> -       depends on EFI && X86_64
> +       depends on EFI && (X86_64 || ARM64)
>         default y
>         help
>           Platform Runtime Mechanism (PRM) is a firmware interface exposing a
> --
> 2.36.1
>
