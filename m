Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6028747AD36
	for <lists+linux-efi@lfdr.de>; Mon, 20 Dec 2021 15:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbhLTOu5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Dec 2021 09:50:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41314 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236384AbhLTOtK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 Dec 2021 09:49:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87554611A7;
        Mon, 20 Dec 2021 14:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5D0C36AE8;
        Mon, 20 Dec 2021 14:49:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="k6AL52Jn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1640011748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZB+YlnrmyeFEXztbZ4HD56lvMI75wzDWPgfGxZYzu90=;
        b=k6AL52Jn8WlJNjFIhOohPsH1zGF26B01uLOEqYe6OtPQfKM5dd2SspYqZfukIxn3FsJDrF
        Ch2pJ9tSJQoMCJqeUdSXU4A2fElYTtCoFHe/5s9pelCw7z0V2vHSqqK47lPWEWqr1o1qrM
        kvN9ppEUBWTFRDD1sQWbqp8cwbsS6yw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b1cf1e0f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 20 Dec 2021 14:49:08 +0000 (UTC)
Received: by mail-yb1-f170.google.com with SMTP id y68so29612532ybe.1;
        Mon, 20 Dec 2021 06:49:08 -0800 (PST)
X-Gm-Message-State: AOAM5317vKQ92CRAp6QuIgf9Rt1qw2KN4tF+rlsOpIVf1RPAA2MW5/JO
        kRtdG1DLbo3DMjvFyuSp70+nQqfBZGBJr3+EFco=
X-Google-Smtp-Source: ABdhPJyEVxPM+FkwuqnhftSYPgXpViHoiltyHD6WFrPWaqROFVl1pBGJ+E+Tr401ZCOmsSFqEGUfixqnPM7A5NoHIg8=
X-Received: by 2002:a25:2450:: with SMTP id k77mr23286190ybk.121.1640011746707;
 Mon, 20 Dec 2021 06:49:06 -0800 (PST)
MIME-Version: 1.0
References: <20211012082708.121931-1-iivanov@suse.de> <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
 <YaivhAV8LouB0zGV@light.dominikbrodowski.net> <CAHmME9qxBeBzfKCjzfAFX9ZWAGKv1TKCQw3x22d_DmJtaAewLw@mail.gmail.com>
 <YanOIvAV1iPBEXR3@light.dominikbrodowski.net> <CAJMQK-i0vZ8k8cNrUaDBdCBv4ucd-DzUWix3ui7QZ_2awZHe6g@mail.gmail.com>
 <Ya55SjgSkO+INcbb@light.dominikbrodowski.net> <CAHmME9oonMxxfEq7sjSSYc7XPwzjW4e45JTbBCJ2hFEbL-tnyw@mail.gmail.com>
In-Reply-To: <CAHmME9oonMxxfEq7sjSSYc7XPwzjW4e45JTbBCJ2hFEbL-tnyw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 20 Dec 2021 15:48:55 +0100
X-Gmail-Original-Message-ID: <CAHmME9oZZdxW3H+7UyGTqebZoBHgEARcw0ea-83ghZR8pwfRsw@mail.gmail.com>
Message-ID: <CAHmME9oZZdxW3H+7UyGTqebZoBHgEARcw0ea-83ghZR8pwfRsw@mail.gmail.com>
Subject: Re: [PATCH v5] random: fix crash on multiple early calls to add_bootloader_randomness()
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Ivan T. Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hey Dominik,

Just following up here, as I never heard back from you. These seem
like real bug I'd like to fix at some point. I was waiting to hear
back about your latest patch, and perhaps you wanted to spin a new
revision? Or not, in which case, please let me know?

Thanks,
Jason
