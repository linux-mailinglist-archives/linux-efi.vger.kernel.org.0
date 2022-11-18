Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5160262F71B
	for <lists+linux-efi@lfdr.de>; Fri, 18 Nov 2022 15:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242284AbiKROUX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Nov 2022 09:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242268AbiKROUW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Nov 2022 09:20:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BB6F35;
        Fri, 18 Nov 2022 06:20:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CFA5B823FD;
        Fri, 18 Nov 2022 14:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBA2C433D6;
        Fri, 18 Nov 2022 14:20:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="p40NF9Ef"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668781214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VltvVNJPgF0epXga2UaZFcjhpjZH9fZKs1OjGrUkPR8=;
        b=p40NF9EfwanauT72TJ+4xJBqE4xEdOlqG8AWouq8BIs+HgLR0XCfS/1ezUZCv+RLzrw8lZ
        g1gGWPFzphMc4I1uW8b6iME97Hdlx1Gx/7aQPMDfvUqCeGecWgudNiK6cksFg81ybThF5E
        zQkRzdZLKZ/OfCxwhCqKSg80eFsPBi0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d18f2dbc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 18 Nov 2022 14:20:14 +0000 (UTC)
Received: by mail-vs1-f42.google.com with SMTP id d185so4881354vsd.0;
        Fri, 18 Nov 2022 06:20:14 -0800 (PST)
X-Gm-Message-State: ANoB5pm9xaTPi9ZSP8vVqrMBzUylMi/Mu4qw37I/VWZkVoI6vAEFLm8Z
        WczvlaSZ8Oj6sV9+KbbG9GZYDL4XPolhyYQlOLQ=
X-Google-Smtp-Source: AA0mqf6nozL9K1B8kmagvKjPpB4NXAyDNN+NMXMLKL+46fYaNyrnWrU+pFlukaEUfG7iR9Zs6fcaF992xLqMxO92ChA=
X-Received: by 2002:a67:1d41:0:b0:3aa:3310:174 with SMTP id
 d62-20020a671d41000000b003aa33100174mr4497136vsd.70.1668781213971; Fri, 18
 Nov 2022 06:20:13 -0800 (PST)
MIME-Version: 1.0
References: <20221116161642.1670235-1-Jason@zx2c4.com> <20221116161642.1670235-3-Jason@zx2c4.com>
 <Y3eT0fd/t270Qeaj@alley>
In-Reply-To: <Y3eT0fd/t270Qeaj@alley>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 18 Nov 2022 15:20:03 +0100
X-Gmail-Original-Message-ID: <CAHmME9pdPCkk=yiT74QjxkgX7TH24-YVb-0NU-=D7WrP95NcEw@mail.gmail.com>
Message-ID: <CAHmME9pdPCkk=yiT74QjxkgX7TH24-YVb-0NU-=D7WrP95NcEw@mail.gmail.com>
Subject: Re: [PATCH RFC v1 2/6] vsprintf: initialize siphash key using notifier
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Nov 18, 2022 at 3:16 PM Petr Mladek <pmladek@suse.com> wrote:
> > +     return 0;
>
> I believe that we should rather return NOTIFY_DONE here.
> It is rather a formal change. The value is 0 as well.
>
> That said, I have never really understood the difference between
> NOTIFY_OK and NOTIFY_DONE.

Ah yes, the varying degrees of apathy:

#define NOTIFY_DONE             0x0000          /* Don't care */
#define NOTIFY_OK               0x0001          /* Suits me */

In a sense, the fact that there's this return value at all indicates a
notifier block isn't *quite* the API we want, since this happens only
once and it really should never stop. But it's so convenient and small
to use that I think it's fine. Anyway, I'll use the right constant
here as you suggested.

Jason
