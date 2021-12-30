Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC91C481D19
	for <lists+linux-efi@lfdr.de>; Thu, 30 Dec 2021 15:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240000AbhL3OeO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Dec 2021 09:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240014AbhL3OeO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Dec 2021 09:34:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C12C061574;
        Thu, 30 Dec 2021 06:34:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA0FCB81C4A;
        Thu, 30 Dec 2021 14:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3C2C36AE9;
        Thu, 30 Dec 2021 14:34:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DOQbkGZ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1640874848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yk5D3YltygJRnqnAb3DHUmIJGfCKz5dRZOYslsln3fw=;
        b=DOQbkGZ/Ns+xSiH27NFsObQQR18oN35W1P4hE/qY4FAaWIhXgeHFXxrg/WU/EoN76nnN78
        s+/ei5kCkDBb9YS3UiOkZTpaROk9UtcLekfAsVVutFD2VKl9x1CekPXYjaT13mPq+NigOr
        KhnL5eF03zc2LmY1qvtq6qksV3miTvQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6a21f2f0 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 30 Dec 2021 14:34:08 +0000 (UTC)
Received: by mail-yb1-f176.google.com with SMTP id d1so52268337ybh.6;
        Thu, 30 Dec 2021 06:34:08 -0800 (PST)
X-Gm-Message-State: AOAM530w08pdpV7qHutJpCk/3YzJjx11urIHPn51epQkwJ4+0rL5HUgn
        n0cIqdpCYVuobOzmW0pKadCewdeVWOQ5UvmoxHo=
X-Google-Smtp-Source: ABdhPJxeQXz55WKIr6z38GAz7zYXRqK2LDB8TQcn4k32Sb2uSx8iLun062dXTxZoB2ItCJexXelS69MVkVvC8CxqJqo=
X-Received: by 2002:a25:e6c5:: with SMTP id d188mr25250541ybh.638.1640874847683;
 Thu, 30 Dec 2021 06:34:07 -0800 (PST)
MIME-Version: 1.0
References: <20211228153826.448805-1-Jason@zx2c4.com> <20211229211009.108091-1-linux@dominikbrodowski.net>
 <20211229211009.108091-4-linux@dominikbrodowski.net>
In-Reply-To: <20211229211009.108091-4-linux@dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 30 Dec 2021 15:33:57 +0100
X-Gmail-Original-Message-ID: <CAHmME9qtms0pD-irUthLTLJpifD6ZmC-qEPwNN4DfKxUXeO0Tg@mail.gmail.com>
Message-ID: <CAHmME9qtms0pD-irUthLTLJpifD6ZmC-qEPwNN4DfKxUXeO0Tg@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] random: mix bootloader randomness into pool
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Thanks for the commit message rework. Applied.
