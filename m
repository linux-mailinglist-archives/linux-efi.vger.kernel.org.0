Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BD65BD24E
	for <lists+linux-efi@lfdr.de>; Mon, 19 Sep 2022 18:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiISQh2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Mon, 19 Sep 2022 12:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiISQh1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Sep 2022 12:37:27 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9A837FB8;
        Mon, 19 Sep 2022 09:37:26 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id r20so20281449qtn.12;
        Mon, 19 Sep 2022 09:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6fQ+1twC0Ji8Gsk3L6i3tph/pC38VH4wEOFGFdDw050=;
        b=Mmr7bRrel8/ocNZnroABkTKsQvtzI/A+XjVlKf4dB+F4JziCKqx3RYhb+xpvYOWrY4
         DTJc8O26uemqlYgwZ/dYblrzVdpXamOqBGJMqheWYs0nGZMJRxWZe/8TBcPLDg3/A+1G
         LR2fRbJaTB6L7+G9R471Jhp59Qs/zT7h+2DKbHusFxGgnJRUJST/vb14DqLZjqSdPRnQ
         bYen9qJXycNNZ88J+zgxobw+CfCsTWJk7rn0latnKc3GU822GWa1+5x6ssA6RbQjh/qX
         cZbjl2FzlvB89R1MYGvSEAklM8ALVqi5u2lZHL9+CE9s4O8tagyRZO7xke7X2GjT43Ea
         m02w==
X-Gm-Message-State: ACrzQf17fZvKBjdwCqwKUN1Ik2yP/E5SShAYEB9y2FgeWM7c2rWjIskl
        /zWcoFB3UUmP1G5W+QFKHBQjuCW/kS6r1wo1znA=
X-Google-Smtp-Source: AMsMyM7blqbSOQF2Eb+/gT/WjwNk4M3+7d9RSV0hwBTX8X90/fo4L+7TFwDreiiSDssZGSjBiZZcyiQJ08xH1VjMZaU=
X-Received: by 2002:a05:622a:104:b0:35c:cb31:c0d9 with SMTP id
 u4-20020a05622a010400b0035ccb31c0d9mr15708109qtw.49.1663605445534; Mon, 19
 Sep 2022 09:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220913163147.24258-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220913163147.24258-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 19 Sep 2022 18:37:14 +0200
Message-ID: <CAJZ5v0hC5Tif=nR2CjDcStUp+SZx3v7d7RCykzcYGYDHsNcYsg@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] ACPI: unify _UID handling as integer
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mark Brown <broonie@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Elie Morisse <syniurge@gmail.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
        Khalil Blaiech <kblaiech@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Sep 13, 2022 at 6:32 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> This series is about unification on how we handle ACPI _UID when
> it's known to be an integer-in-the-string.
>
> The idea of merging either all via ACPI tree, or taking ACPI stuff
> for the v6.1 while the rest may be picked up later on by respective
> maintainers separately (currently only perf patch is not tagged).
>
> Partially compile-tested (x86-64).
>
> Changelog v3:
> - fixed dev_dbg() specifier to be in align with the variable type (LKP)
> - made use of temporary dev variable beyond the ACPI scope (LKP)
> - added tags to I²C patches (Wolfram)

I've replaced the previous version of this patch series in my tree
with this one.

Thanks!


> Changelog v2:
> - rebased pxa2xx patch to be applied against current Linux kernel code
> - fixed uninitialized variable adev in use (mlxbf)
> - dropped unneeded temporary variable adev (qcom_l2_pmu)
> - changed type for ret in patch 8 (Hans)
> - swapped conditions to check ret == 0 first (Ard)
> - added tags (Mark, Ard, Hans)
>
> Andy Shevchenko (8):
>   ACPI: utils: Add acpi_dev_uid_to_integer() helper to get _UID as
>     integer
>   ACPI: LPSS: Refactor _UID handling to use acpi_dev_uid_to_integer()
>   ACPI: x86: Refactor _UID handling to use acpi_dev_uid_to_integer()
>   i2c: amd-mp2-plat: Refactor _UID handling to use
>     acpi_dev_uid_to_integer()
>   i2c: mlxbf: Refactor _UID handling to use acpi_dev_uid_to_integer()
>   perf: qcom_l2_pmu: Refactor _UID handling to use
>     acpi_dev_uid_to_integer()
>   spi: pxa2xx: Refactor _UID handling to use acpi_dev_uid_to_integer()
>   efi/dev-path-parser: Refactor _UID handling to use
>     acpi_dev_uid_to_integer()
>
>  drivers/acpi/acpi_lpss.c               | 15 +++++------
>  drivers/acpi/utils.c                   | 24 +++++++++++++++++
>  drivers/acpi/x86/utils.c               | 14 +++++++---
>  drivers/firmware/efi/dev-path-parser.c | 10 ++++---
>  drivers/i2c/busses/i2c-amd-mp2-plat.c  | 27 +++++++------------
>  drivers/i2c/busses/i2c-mlxbf.c         | 20 +++++---------
>  drivers/perf/qcom_l2_pmu.c             | 10 +++----
>  drivers/spi/spi-pxa2xx.c               | 37 +++++++-------------------
>  include/acpi/acpi_bus.h                |  1 +
>  include/linux/acpi.h                   |  5 ++++
>  10 files changed, 83 insertions(+), 80 deletions(-)
>
> --
> 2.35.1
>
