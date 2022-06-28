Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4237255EAAB
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 19:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiF1RLs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jun 2022 13:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiF1RLr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jun 2022 13:11:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D882C13B;
        Tue, 28 Jun 2022 10:11:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94242B81A9D;
        Tue, 28 Jun 2022 17:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61554C341C8;
        Tue, 28 Jun 2022 17:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656436304;
        bh=xQrtsnH9s5+o2x7Rh57LfqDZAM3vdxeFWjlFcpe5rkU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MrAXjvVjGmDtbMBfpn3zM0vzuZVo5bM6g2OYylt+Cs+32+1cB4b7n6p7O8rlAVsaE
         ZWOAAFuVANSTlH7yf3Qbsy6EAz6fONIt8MfYKeBFdMUmX3gGjgHgtIhOJu/154gYt9
         wZs76HSvzU7vSpkx/gI0i04yG2vb1LLR/Xo/2JxKXEVOuO0r+iIg5K+9FrjmKYjafU
         s9jco2Fq4SVZ/d6OG7bG5ZqmRdvbC96nZj7Nf6YalyB1853y8o24pe3p9J8ec0ByEH
         uR053EouaEwwBHgswDHuL8cRSHeGvxWIHiifcXnlptgj+yqK2qY2nZXHWajjfRbefd
         UJG682x8zfbow==
Received: by mail-oi1-f176.google.com with SMTP id h65so18020456oia.11;
        Tue, 28 Jun 2022 10:11:44 -0700 (PDT)
X-Gm-Message-State: AJIora8c3BOkETRdZavOYLZD8hnKYMKS8ke5QElxiP75Or6cSGsF1WuI
        O2UqnII5KD/hlMMdErmDgcynmpDdKExPuvg15c8=
X-Google-Smtp-Source: AGRyM1vYq5QjyyL4Wqpsj8JGgs/H15t2PDcV0jIde5DdRoGhSKnPi/817McyHUI5TKPlKMyEyp4EG5Zq9/0jjOH/zq8=
X-Received: by 2002:a05:6808:300e:b0:32c:425e:df34 with SMTP id
 ay14-20020a056808300e00b0032c425edf34mr423079oib.126.1656436303505; Tue, 28
 Jun 2022 10:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220628125346.693304-1-sudeep.holla@arm.com> <20220628125346.693304-5-sudeep.holla@arm.com>
In-Reply-To: <20220628125346.693304-5-sudeep.holla@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 28 Jun 2022 19:11:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFVmJEWE3kWqMRLZ6QDQp4hgs8PDP7ZrSYL1zpFweMvqg@mail.gmail.com>
Message-ID: <CAMj1kXFVmJEWE3kWqMRLZ6QDQp4hgs8PDP7ZrSYL1zpFweMvqg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] ACPI: Move PRM config option under the main ACPI config
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jose Marinho <jose.marinho@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 28 Jun 2022 at 14:54, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Currently PRM(Platform Runtime Mechanism) config option is listed along
> with the main ACPI (Advanced Configuration and Power Interface) option
> at the same level. On ARM64 platforms unlike x86, ACPI option is listed
> at the topmost level of configuration menu. It is rather very confusing
> to see PRM option also listed along with ACPI in the topmost level.
>
> Move the same under ACPI config option. No functional change, just changes
> the level of visibility of this option under the configuration menu.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

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
> 2.37.0
>
