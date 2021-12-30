Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0F8481D16
	for <lists+linux-efi@lfdr.de>; Thu, 30 Dec 2021 15:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240173AbhL3OdK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Dec 2021 09:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240000AbhL3OdK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Dec 2021 09:33:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082F2C061574;
        Thu, 30 Dec 2021 06:33:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B6456115A;
        Thu, 30 Dec 2021 14:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1066C36AE9;
        Thu, 30 Dec 2021 14:33:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oeb3LPNM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1640874786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e5fUqIQSYKssyh4G7SmxtXTAr2g0Dh0DHIB5ZSjzF9o=;
        b=oeb3LPNMWqdbYL1SKVGfbhDGYObZwvWS+TVFKeTfWnjKZFXiAOTFL/RLub7OX3D0dp9g0x
        JEXqoypuzhSpWA1uEhr0cOfKxq4xpYke2a99X6cIGQxAiKUM2uwIwoO2IS0BLGpmV2fJu/
        2imeDSak28T4DLmk8pqKI6jUxgPJ9Uo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d83f0a5d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 30 Dec 2021 14:33:06 +0000 (UTC)
Received: by mail-yb1-f174.google.com with SMTP id 139so41194805ybd.3;
        Thu, 30 Dec 2021 06:33:06 -0800 (PST)
X-Gm-Message-State: AOAM5337v0u0mcn/1YtDIBTo8wB7PmqJNgFeWx/+6+9wz2Obtgfmj+nn
        /gxD0TyQgvEdI1ov2DFHZQU9NAwbfgYMK3pEEtE=
X-Google-Smtp-Source: ABdhPJxWVGXM+PpYmOy/spRfWHdWSl5/8j3kz4OINFOroW6b8iD4SUwEdeaud4cLGyvFfl0JMsetrZaCMRKqUZlDzM4=
X-Received: by 2002:a25:3bd3:: with SMTP id i202mr12665243yba.115.1640874784746;
 Thu, 30 Dec 2021 06:33:04 -0800 (PST)
MIME-Version: 1.0
References: <20211228153826.448805-1-Jason@zx2c4.com> <20211229211009.108091-1-linux@dominikbrodowski.net>
 <20211229211009.108091-3-linux@dominikbrodowski.net>
In-Reply-To: <20211229211009.108091-3-linux@dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 30 Dec 2021 15:32:54 +0100
X-Gmail-Original-Message-ID: <CAHmME9rUQ4tDzZfQmV+OE=petMTX8SRyok=566SiyWZ9BEAP2w@mail.gmail.com>
Message-ID: <CAHmME9rUQ4tDzZfQmV+OE=petMTX8SRyok=566SiyWZ9BEAP2w@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] random: do not throw away excess input to crng_fast_load
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Interesting additional analysis about kexec. Patch applied.
