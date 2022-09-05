Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E445ACF5D
	for <lists+linux-efi@lfdr.de>; Mon,  5 Sep 2022 12:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbiIEJ52 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Sep 2022 05:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbiIEJ5Y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Sep 2022 05:57:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BC94054E;
        Mon,  5 Sep 2022 02:57:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F8ACB8100F;
        Mon,  5 Sep 2022 09:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1447C4347C;
        Mon,  5 Sep 2022 09:57:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eK8ao2kd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1662371836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y1NDX62Ou8pY1qWj5p5h2Degr6CkohGS8XMW2DOrr0A=;
        b=eK8ao2kdx+CbsGKN81KNfhfJWpZ0HFR7g13eo2h1MofsyscACjbfUqBSQbeZ5z2nAlMHiJ
        SOAaRrXD6pzCZ3kMX61eO7jAPdCtcjKfEVoCjR4BpRsGZ8WMGfXRnHTGkCjNzvdu5Q8lgJ
        64lW0BhK3qYx1HT8mCsbF7sbOTpQcCo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 381ad219 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 5 Sep 2022 09:57:16 +0000 (UTC)
Received: by mail-yb1-f170.google.com with SMTP id e126so5235882ybh.1;
        Mon, 05 Sep 2022 02:57:15 -0700 (PDT)
X-Gm-Message-State: ACgBeo3DFc+9i8mEBzEePIZbPQh0TqCT0mBNdjOTyDz2OgBNTG2BhoEU
        EAMgU3vlyfgvvhCQT1UOuYmcT6c9A12kPfFuUa4=
X-Google-Smtp-Source: AA6agR6ivM73KKWiHPVay+wo082citTJuoVK5THd4IO0vL+OIEtquR5iewnKvi3d6LGLr5G6Kr5f5quiH14oVmJFgjY=
X-Received: by 2002:a25:7cc6:0:b0:67a:6a2e:3d42 with SMTP id
 x189-20020a257cc6000000b0067a6a2e3d42mr31762626ybc.231.1662371835388; Mon, 05
 Sep 2022 02:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220904165321.1140894-1-Jason@zx2c4.com> <CAMj1kXHC9Wfr74761gPcG=N8OC2P76FqSb8FVGWM7x1p-4hQKg@mail.gmail.com>
In-Reply-To: <CAMj1kXHC9Wfr74761gPcG=N8OC2P76FqSb8FVGWM7x1p-4hQKg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 5 Sep 2022 11:57:04 +0200
X-Gmail-Original-Message-ID: <CAHmME9ozPTL7tpj-QoFK3Dfyq58VAJgmM6MjUBW4VVM_TXo3VA@mail.gmail.com>
Message-ID: <CAHmME9ozPTL7tpj-QoFK3Dfyq58VAJgmM6MjUBW4VVM_TXo3VA@mail.gmail.com>
Subject: Re: [PATCH] efi: x86: Wipe setup_data on pure EFI boot
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Sep 5, 2022 at 11:55 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Also, care to update Documentation/x86/boot.rst to document the new behavior?

Sure, I'll send a v2 with that.
