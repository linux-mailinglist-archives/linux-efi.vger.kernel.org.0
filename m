Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05874481EFF
	for <lists+linux-efi@lfdr.de>; Thu, 30 Dec 2021 19:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241599AbhL3SFl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Dec 2021 13:05:41 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43136 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241595AbhL3SFk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Dec 2021 13:05:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0CB6B81CD9;
        Thu, 30 Dec 2021 18:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC132C36AED;
        Thu, 30 Dec 2021 18:05:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MuZQZeY3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1640887535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G5mF3LI5nypD4r/oSkoaGAuHjwCFw9cBOVQMtb6LgxE=;
        b=MuZQZeY3LtmUFrFNQCLvYLoQ5fR29kpIH7lO/9LQsvyDmKdHuZcwM6mVn4HGsatJGa77vO
        IL+bspsG36ddi/OxQi0phW8b65cB+tO71sXTV6V/lOzatomXLiOcpnPFResVLzXQaCETZe
        q20uGbjcHKZMRMXMm7MuQwbFwTfYbnA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 95a9b6c7 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 30 Dec 2021 18:05:35 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id m19so56851530ybf.9;
        Thu, 30 Dec 2021 10:05:35 -0800 (PST)
X-Gm-Message-State: AOAM531RBsmC8Hgw27Hgexh1VajUTrGdxkcnq6VjGLZE0CX2EDEwFezJ
        kFbHJuX+41I75GvBrqjC8EwVcDuhCtJ0TAUvoog=
X-Google-Smtp-Source: ABdhPJy+emTaHOsS12qbBqKNh+HWMpUMULgRvE95E0YyVv7icXN/TVk54maJffeMODdrGE4OqubM1aHcSu1sarQQeAs=
X-Received: by 2002:a25:854f:: with SMTP id f15mr30169067ybn.121.1640887534304;
 Thu, 30 Dec 2021 10:05:34 -0800 (PST)
MIME-Version: 1.0
References: <20211012082708.121931-1-iivanov@suse.de> <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
 <YaivhAV8LouB0zGV@light.dominikbrodowski.net> <CAHmME9qxBeBzfKCjzfAFX9ZWAGKv1TKCQw3x22d_DmJtaAewLw@mail.gmail.com>
 <YanOIvAV1iPBEXR3@light.dominikbrodowski.net> <CAHmME9qGHo4n6QGxnE+O46pagOR0bA+9E8bi8ZLPAzMuMZpPwg@mail.gmail.com>
 <20211206081431.e3cl2rbvgpvbouff@suse>
In-Reply-To: <20211206081431.e3cl2rbvgpvbouff@suse>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 30 Dec 2021 19:05:23 +0100
X-Gmail-Original-Message-ID: <CAHmME9q6DnMk=p5kL0c1e4TxJOLpdxJpm3RbbgsNE8x1PWwi9g@mail.gmail.com>
Message-ID: <CAHmME9q6DnMk=p5kL0c1e4TxJOLpdxJpm3RbbgsNE8x1PWwi9g@mail.gmail.com>
Subject: Re: [PATCH v4] random: fix crash on multiple early calls to add_bootloader_randomness()
To:     "Ivan T. Ivanov" <iivanov@suse.de>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        "Theodore Ts'o" <tytso@mit.edu>, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hey Ivan,

On Mon, Dec 6, 2021 at 9:14 AM Ivan T. Ivanov <iivanov@suse.de> wrote:
> Initial bug report could be found here [1]. Comments 14 and onward are
> probably helpful. To reproduce the issue I have downloaded "assets"
> from [2] and recreated test environment as found in autoinst-log.txt [3].
> Search for qemu-img and qemu-system-aarch64 in the log above. Login
> credentials for the images could be found by searching for "password"
> in the same file.
>
> Regards,
> Ivan
>
>
> [1] https://bugzilla.suse.com/show_bug.cgi?id=1184924
> [2] https://openqa.opensuse.org/tests/latest?arch=aarch64&distri=opensuse&flavor=DVD&machine=aarch64&test=extra_tests_in_textmode&version=15.3
> [3] https://openqa.opensuse.org/tests/2052459/logfile?filename=autoinst-log.txt

After a few rounds, Dominik and I converged on a set of patches that
are now in the crng/random.git tree. Do you think you could try this
tree out against your various test environments to confirm it fixes
the issue SUSE was seeing?

Tree is here: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git

Thanks,
Jason
