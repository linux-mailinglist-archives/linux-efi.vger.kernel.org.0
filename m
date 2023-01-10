Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC8D6642F4
	for <lists+linux-efi@lfdr.de>; Tue, 10 Jan 2023 15:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbjAJOPy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Jan 2023 09:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbjAJOPq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 Jan 2023 09:15:46 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B872DF4;
        Tue, 10 Jan 2023 06:15:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8E1D3CE178F;
        Tue, 10 Jan 2023 14:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D262CC433A1;
        Tue, 10 Jan 2023 14:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673360141;
        bh=QCMqb710Vb2qR8xQ9o5XLbvRa0QoV7APy78TNWBPGtU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N+Dj0Y6x+d/XA8heNnvIJJ9HFdF6ObvNejgdnlKTnjYoHhvKJQMiBaheSEkjIJmhO
         FCZnF8LFn4LsRRjAbUDPWzCBrXhICRxekE9lTD5QSnqQwUPZTppOd6Df++W/UNuX/U
         qRbDViNjPk1ki9LYt8KzniWNbmcudUZvwe/TD1RVvuWGinJaHYgSJfyY6rz6WALoid
         RN7hBQHoj/jOLXXwTSLnwJS5mL8QdvRSZGKjs1VOKQ1Mg8eXouGIDXFinQJxJXSfP5
         XFWkvU/Ln6v/P7RFnYviCoBEHvnmAQ8zaZbMAEN0DwYCmen1nB0wGyArs2disAwiZH
         JTbd8n7bwPY0g==
Received: by mail-lf1-f46.google.com with SMTP id bq39so18679555lfb.0;
        Tue, 10 Jan 2023 06:15:41 -0800 (PST)
X-Gm-Message-State: AFqh2kobrGGarY678SA2RixYCLRm6tgyDaPdxdOLJZF4NxuossuQfijF
        tv4wWyDdA4p5PrOCcfOBuNIFTVYpFPfg9UQ7tE0=
X-Google-Smtp-Source: AMrXdXvRSvgcrKUl+cRp4ITDJtAmYYlkzzcEbCFzT6kt5rOnxeWPTNprfhIok8q16FYnewS0coJKRnO3uo7N2P6dDC8=
X-Received: by 2002:ac2:5d4e:0:b0:4b5:964d:49a4 with SMTP id
 w14-20020ac25d4e000000b004b5964d49a4mr6013598lfd.637.1673360139832; Tue, 10
 Jan 2023 06:15:39 -0800 (PST)
MIME-Version: 1.0
References: <20221208221217.56354-1-andriy.shevchenko@linux.intel.com> <Y71u/Hn+khg/Nuj7@smile.fi.intel.com>
In-Reply-To: <Y71u/Hn+khg/Nuj7@smile.fi.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 10 Jan 2023 15:15:28 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEWLcBTR5z0aC9=n1rLT=Z2yMNW8D-HpLd6e8YCz1hMJA@mail.gmail.com>
Message-ID: <CAMj1kXEWLcBTR5z0aC9=n1rLT=Z2yMNW8D-HpLd6e8YCz1hMJA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] efi/earlycon: Replace open coded strnchrnul()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 10 Jan 2023 at 14:58, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Dec 09, 2022 at 12:12:16AM +0200, Andy Shevchenko wrote:
> > strnchrnul() can be called in the early stages. Replace
> > open coded variant in the EFI early console driver.
>
> Any comments on the series?
>

Looks fine to me. Queued up in efi/next now.
