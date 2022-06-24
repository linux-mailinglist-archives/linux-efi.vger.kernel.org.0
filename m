Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07720559FD4
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 20:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiFXRm2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 13:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiFXRm1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 13:42:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3057C517;
        Fri, 24 Jun 2022 10:42:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B645E61F5F;
        Fri, 24 Jun 2022 17:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4F7C341CB;
        Fri, 24 Jun 2022 17:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656092545;
        bh=LF2SHOm4r17rRet4Wnn5vy1AmxEoTlBW4PCJIg4inWA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PSMMrMK07gFSEFdyAmLvi13+8WQUr4Ro3aky6QFgZ50Us07pfSNa1HItsAmMYCO06
         wJiHAY1ay8Ns3P+0RHedp5xKlrvIH8Tb7k5zsNA0L5PHYdw0WJV4/r6cA9jVm9MuQ/
         GUNGy0c4eD1KdMfCUoR7AVizxnSj8VRfz4DvIhn1++0LBwJpmXE6jBAmDUmVLBmT/A
         qKGo9RlETCXQ0yGJ9tx2Kzcia/arfYd9hjheJDVldwhgNjfztoZn3X5oYV/NKWyb0y
         FRuVzPxefHwKQd8izcPqYQGaicPV7PyZdZrHc7gYtN4AAqtlqNeQgxpGW6WaVhUEqL
         9MDEyG3+8QOcw==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-101bb9275bcso4690717fac.8;
        Fri, 24 Jun 2022 10:42:25 -0700 (PDT)
X-Gm-Message-State: AJIora8nXLBCMdFetPbvCgJt8JAE366UGiSrCcMk4qfLIah5WaWyUvAH
        Nyh7XMusQGkcwJJKGz9OjjVP9V053g7cE36Zh6o=
X-Google-Smtp-Source: AGRyM1urfEjxd1IK/VX60Siu2XV6KeXkE3snPHlR/G5Gj+IvQvlh7jg3WsjtBtQqulSynE4oE4e2nL+cR3LyJ5RpQfs=
X-Received: by 2002:a05:6870:5b91:b0:108:374a:96b0 with SMTP id
 em17-20020a0568705b9100b00108374a96b0mr90061oab.126.1656092544307; Fri, 24
 Jun 2022 10:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220624152331.4009502-1-sudeep.holla@arm.com> <20220624152331.4009502-4-sudeep.holla@arm.com>
In-Reply-To: <20220624152331.4009502-4-sudeep.holla@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 24 Jun 2022 19:42:13 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFskTNcSwfiGomndZNyR2XaMhixiQvB=9h83-++kp_6-w@mail.gmail.com>
Message-ID: <CAMj1kXFskTNcSwfiGomndZNyR2XaMhixiQvB=9h83-++kp_6-w@mail.gmail.com>
Subject: Re: [PATCH 3/3] ACPI: Move PRM config option under the main ACPI config
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
> Currently PRM(Platform Runtime Mechanism) config options is list along
> with the mainA CPI (Advanced Configuration and Power Interface) option
> at the same level. On ARM64 platforms unlike x86, ACPI option is listed
> at the topmost level of configuration menu. It is rather very confusing
> to see PRM option also listed along with ACPI in the topmost level.
>
> Move the same under ACPI config option. No functional change, just changes
> the level of visibility of this option under the configuration menu.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  drivers/acpi/Kconfig | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index d08b7408f0a5..218b5b59df31 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -572,6 +572,21 @@ source "drivers/acpi/pmic/Kconfig"
>  config ACPI_VIOT
>         bool
>
> +config ACPI_PRMT
> +       bool "Platform Runtime Mechanism Support"
> +       depends on EFI && (X86_64 || ARM64)
> +       default y
> +       help
> +         Platform Runtime Mechanism (PRM) is a firmware interface exposing a
> +         set of binary executables that can be called from the AML interpreter
> +         or directly from device drivers.
> +
> +         Say Y to enable the AML interpreter to execute the PRM code.
> +
> +         While this feature is optional in principle, leaving it out may
> +         substantially increase computational overhead related to the
> +         initialization of some server systems.
> +
>  endif  # ACPI
>
>  config X86_PM_TIMER
> @@ -589,18 +604,3 @@ config X86_PM_TIMER
>
>           You should nearly always say Y here because many modern
>           systems require this timer.
> -
> -config ACPI_PRMT
> -       bool "Platform Runtime Mechanism Support"
> -       depends on EFI && (X86_64 || ARM64)
> -       default y
> -       help
> -         Platform Runtime Mechanism (PRM) is a firmware interface exposing a
> -         set of binary executables that can be called from the AML interpreter
> -         or directly from device drivers.
> -
> -         Say Y to enable the AML interpreter to execute the PRM code.
> -
> -         While this feature is optional in principle, leaving it out may
> -         substantially increase computational overhead related to the
> -         initialization of some server systems.
> --
> 2.36.1
>
