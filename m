Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C07A73E106
	for <lists+linux-efi@lfdr.de>; Mon, 26 Jun 2023 15:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjFZNuq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Jun 2023 09:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjFZNuq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 26 Jun 2023 09:50:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1404A10CA
        for <linux-efi@vger.kernel.org>; Mon, 26 Jun 2023 06:50:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9105F60C87
        for <linux-efi@vger.kernel.org>; Mon, 26 Jun 2023 13:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA6AC433C0
        for <linux-efi@vger.kernel.org>; Mon, 26 Jun 2023 13:50:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="j1hxzHA0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1687787438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R9bzjVrqz6SbM/OXdqandP//hF6s2VvAIp+iE6SNusI=;
        b=j1hxzHA0jTDRRbu4h4Lf3RpnJdsRsGVKcw7GT38Ex4zTijKolCPcF0UDwT9NpmumAN1pXU
        wZ2Tu9x3LNqH783UTXKhqcXxxMLjz+MTG7pyO9aqC3CxBwGkC4eq+MRyOSBcLcNuIGC0fy
        4GuQ8DyCBSPi/ZpT2SkZ0AMLhDOtPnQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f9560b93 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-efi@vger.kernel.org>;
        Mon, 26 Jun 2023 13:50:37 +0000 (UTC)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-440ce11f80fso725917137.2
        for <linux-efi@vger.kernel.org>; Mon, 26 Jun 2023 06:50:37 -0700 (PDT)
X-Gm-Message-State: AC+VfDySxwwBeDQeGSiXm+O17KVoMFc7c5ROej8TUaf/5txP9BF/O6Wq
        a60q1vdyRGD5WSyHyvyRamQMDCiNSmtGJdpeAnQ=
X-Google-Smtp-Source: ACHHUZ4NAly9/5ZwRN9TdpErek1S5PPWtHnAFqQM5c078tiXSABwa+W4VHXduDl0nt3KdkjiZ1W7Rw2jAA1J2ZIQ75c=
X-Received: by 2002:a67:f9d0:0:b0:443:5f26:8bd6 with SMTP id
 c16-20020a67f9d0000000b004435f268bd6mr833485vsq.19.1687787436880; Mon, 26 Jun
 2023 06:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230624180446.2048867-1-ardb@kernel.org> <ZJhSysqUcxOqh37n@zx2c4.com>
 <CAHk-=witNP7Ejgdk8YBZs5ujdxbjqYOVLdbtAsZC1NWoiPWkvA@mail.gmail.com> <CAMj1kXHkX_PfL5+VpP1EgE4AEG4jiUBYuJYtXmuXEx0y+e93Dw@mail.gmail.com>
In-Reply-To: <CAMj1kXHkX_PfL5+VpP1EgE4AEG4jiUBYuJYtXmuXEx0y+e93Dw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 26 Jun 2023 15:50:25 +0200
X-Gmail-Original-Message-ID: <CAHmME9rtXt7VPLAXBGdKq05wKHsBVz+KQgsavwpDwb=tm4ssGA@mail.gmail.com>
Message-ID: <CAHmME9rtXt7VPLAXBGdKq05wKHsBVz+KQgsavwpDwb=tm4ssGA@mail.gmail.com>
Subject: Re: [PATCH] efivarfs: Expose RandomSeed variable but with limited permissions
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sami Korkalainen <sami.korkalainen@proton.me>,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Jun 25, 2023 at 9:58=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
> > I'm not entirely sure which laptop it is, with laptop manufacturers
> > often re-using model names over several years, but "HP 6730b" seems to
> > be basically from July 2008 (going by the service manual I found). So
> > we're talking 15 years ago, and yes, EFI was likely *much* less
> > reliable back then.
> >
>
> Yeah. What we might consider is keying off of the UEFI revision field
> at a certain cutoff value (e.g., only support this for ~v2.4 or
> higher)

Oh I actually really like that idea. I didn't realize it was possible.
Let's just choose a quite modern UEFI revision, and then we won't need
to deal with the horrors of the past. And eventually what is quite
modern now will be old and widespread.

Jason
