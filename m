Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC5E5B477D
	for <lists+linux-efi@lfdr.de>; Sat, 10 Sep 2022 18:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiIJQcY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 10 Sep 2022 12:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiIJQcX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 10 Sep 2022 12:32:23 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD624A83E;
        Sat, 10 Sep 2022 09:32:22 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id f131so6899551ybf.7;
        Sat, 10 Sep 2022 09:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=GkMFjVtDr0W10OJLyjB1PHKjRI7ZFioNTd0VYLRMl94=;
        b=ThoRLvkIbjrCWL0q+TFVOHf3eGbii09QgZZ8+fnloYa65GmvZoYZxXRfi4dIf/o3/X
         CHxXNCVetlaCzlNPH7RHeluIxXBW9UaWGxJbq44/RtWKjnWMdCJeIjeGpTxtZk7sC3XY
         FC1+bATa/yirJyG/f0TfPtNbPuBdAW51Y4xNJXJOabOT0rud7KCnxWelfVT3WcqdnVvi
         S/MvEcHpaC+v+YF47p1//uEddmEbtpH4EW44HoPAx6nua0qW6qe+AO4eBtEhW/IhMKDt
         EtzYW5sIUxU/qV5nqC5OKkZTZ9vMESj0n6S0HZwEROc08lB3wnnH38cngZo5+KpEIQns
         iUaQ==
X-Gm-Message-State: ACgBeo09Bstel6aHIS4x5EoDtJZ7DCW8jizVZ0Jd0dyvtaTwHiRyqD8t
        l7KDxBTL2gsd8LWoF2CLf5zUIJz+v4ZKxTCZ4bs=
X-Google-Smtp-Source: AA6agR4n7pXTzaWGoZwbXMPbML7j3aWjxBABW4Ue2CuqwFbK1YnZzMiGo3Y8jNXuTBWAX9gMGWr6mCabLDZaslxS/Ik=
X-Received: by 2002:a25:2f0c:0:b0:6a8:f230:12ed with SMTP id
 v12-20020a252f0c000000b006a8f23012edmr15745127ybv.633.1662827541557; Sat, 10
 Sep 2022 09:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220908132910.62122-1-andriy.shevchenko@linux.intel.com> <YxnwMLvgQAPOkeeK@smile.fi.intel.com>
In-Reply-To: <YxnwMLvgQAPOkeeK@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 10 Sep 2022 18:32:10 +0200
Message-ID: <CAJZ5v0j5FO+OcX6VdiR-tuDCrHFwErquxzZGUu3ZLQ1G57T-+Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] ACPI: unify _UID handling as integer
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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
        Robert Moore <robert.moore@intel.com>,
        Wolfram Sang <wsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 8, 2022 at 3:38 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Sep 08, 2022 at 04:29:02PM +0300, Andy Shevchenko wrote:
> > This series is about unification on how we handle ACPI _UID when
> > it's known to be an integer-in-the-string.
> >
> > The idea of merging either all via ACPI tree, or taking ACPI stuff
> > for the v6.1 while the rest may be picked up later on by respective
> > maintainers separately
>
> >(currently all depends on Wolfram, other
> > patches have got the tags from the maintainers).
>
> I stand corrected, the perf patch is not tagged yet.
>
> > Partially compile-tested (x86-64).

Tentatively applied as 6.1 material.

If there are updates, we'll make changes as they go.

Thanks!
