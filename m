Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DD4481D14
	for <lists+linux-efi@lfdr.de>; Thu, 30 Dec 2021 15:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240081AbhL3OcB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Dec 2021 09:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240000AbhL3OcB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Dec 2021 09:32:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFBDC061574;
        Thu, 30 Dec 2021 06:32:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15A44B81C69;
        Thu, 30 Dec 2021 14:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC91C36AE9;
        Thu, 30 Dec 2021 14:31:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UnV/yZLg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1640874715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jf1cAX8MP1YQfSr6X7h/KoMFoneESbOLLfRHjHtEOg4=;
        b=UnV/yZLgVpWxRcinlKBxBeVvBrwUbrYexwfzsWY5itzg+yZGD/X3SaXbJ2qFfIAmGqkmRq
        3hXj8pM3k/gfAbSXOo2MrrcRzzmcijkbTG8BDgJLE7yItDzj4X1ZmIXixn18efGURAyZSg
        FZZ6nfvNnonhpfhOlct4OTdZdsKVXsw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 36d2286b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 30 Dec 2021 14:31:55 +0000 (UTC)
Received: by mail-yb1-f174.google.com with SMTP id k69so57102789ybf.1;
        Thu, 30 Dec 2021 06:31:55 -0800 (PST)
X-Gm-Message-State: AOAM532N80uUVJ+x1o01kZgXXVkFm3omYWMOrB6iRy2sZyhSIcglaMwg
        0kdMLx+INsNqy6bRFTYi8j2IKrvltxggxbmkDtw=
X-Google-Smtp-Source: ABdhPJwkYqgRW2RKJ2QbB/X2lI/aafmE4BOamRPwglFKek+bIWQd1tNYUpoyii/w7UCsRPtC39jqX3CKZgE9cPIfdNs=
X-Received: by 2002:a25:938d:: with SMTP id a13mr24230873ybm.457.1640874714218;
 Thu, 30 Dec 2021 06:31:54 -0800 (PST)
MIME-Version: 1.0
References: <20211228153826.448805-1-Jason@zx2c4.com> <20211229211009.108091-1-linux@dominikbrodowski.net>
 <20211229211009.108091-2-linux@dominikbrodowski.net>
In-Reply-To: <20211229211009.108091-2-linux@dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 30 Dec 2021 15:31:43 +0100
X-Gmail-Original-Message-ID: <CAHmME9q6nk9sm7-i_s3+316LvqCskC3=T0V6fLHsDXYA=HsPgQ@mail.gmail.com>
Message-ID: <CAHmME9q6nk9sm7-i_s3+316LvqCskC3=T0V6fLHsDXYA=HsPgQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/7] random: do not re-init if crng_reseed completes
 before primary init
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Applied. Thanks for the review.
