Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AEE55EAAD
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 19:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbiF1RLj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jun 2022 13:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiF1RLe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jun 2022 13:11:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31452C643;
        Tue, 28 Jun 2022 10:11:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E30F6157F;
        Tue, 28 Jun 2022 17:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF110C341C6;
        Tue, 28 Jun 2022 17:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656436292;
        bh=JdkQu53AselSLliWKDvntWSUMoGLrg2rdsFsZxB3KLA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OnbFjM8gg37G341sX+UmXyHRuLm5Adpw0m39qaArdcJgaEefNkePnbKCo8KDewttf
         3m0tjcK/KRKEt38aRRPJRvW8d5mcuO2Yq50lfilBmwTYkdt8qMKnLg0KpRbPgKbCdX
         EbyEcOmV4ttzZuxyOT4q2d8IhrNjsxeW8xxPsRMgf8b/0MERrv8a2xO9+ncQ8Q8N2Y
         3IQKAaRL604q/mM8gfUk/Bgf7AGj7+QhL3VibNoK0lWdgRZn4pp2cTdQAEeklb8xhT
         1S6NSAqYUEM1l9PmPKGlUnfy6l4mT2/A2fRYIqEIt0vlUSLNJ+Wz/S0LvYe7kn2meZ
         jhkW/LCelbxRQ==
Received: by mail-oi1-f177.google.com with SMTP id e131so18006521oif.13;
        Tue, 28 Jun 2022 10:11:32 -0700 (PDT)
X-Gm-Message-State: AJIora8ZK2hesvXTrJEQ3oXqLWPgE/IFMR2Mcm9SPUmwCkl++Hp1oZFB
        mAtylROC8ufO+D56+YJ+drQbwAfXQhQq9ln59Tw=
X-Google-Smtp-Source: AGRyM1vsOYiemvsdmCFIomLR/LEeDUMxh5adZ6uPQY+0ddio67mn1BJ2dsX4A2d3uwfg1Ldo0TK3c8mYKM85m8aFO3Y=
X-Received: by 2002:a05:6808:13c6:b0:335:3e54:94bc with SMTP id
 d6-20020a05680813c600b003353e5494bcmr406222oiw.228.1656436292008; Tue, 28 Jun
 2022 10:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220628125346.693304-1-sudeep.holla@arm.com> <20220628125346.693304-4-sudeep.holla@arm.com>
In-Reply-To: <20220628125346.693304-4-sudeep.holla@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 28 Jun 2022 19:11:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFo-U+QWMSue=g5QfZC+o2RyqPw24s+RmO+eL2UY3HNpQ@mail.gmail.com>
Message-ID: <CAMj1kXFo-U+QWMSue=g5QfZC+o2RyqPw24s+RmO+eL2UY3HNpQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ACPI: Enable Platform Runtime Mechanism(PRM)
 support on ARM64
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
> There is interest to make use of PRM(Platform Runtime Mechanism) even on
> ARM64 ACPI platforms. Allow PRM to be enabled on ARM64 platforms. It will
> be enabled by default as on x86_64.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

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
> 2.37.0
>
