Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9965AE80B
	for <lists+linux-efi@lfdr.de>; Tue,  6 Sep 2022 14:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239955AbiIFM0e (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Sep 2022 08:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239784AbiIFM0H (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Sep 2022 08:26:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDB47FE62;
        Tue,  6 Sep 2022 05:22:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20B30B818B0;
        Tue,  6 Sep 2022 12:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7D9C4347C;
        Tue,  6 Sep 2022 12:21:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BmUAtERM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1662466909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=87p6evS16rOwfc+reZpx2sDISz3k1kYdRZgIQ45xujk=;
        b=BmUAtERMAG4pDGmc2MVJ+DDFkzxv39wTbd+wJehM8wt6pNwTSw7frPubYqm0o9GM0COy0H
        aAcWJ0sRLrh0tPi0e1hjH7SujW96aIXOr2hXXEl1JCVipnTL0Uvrn4bcS7+QMIYjW+j0o8
        7a4Ojo/M8AOIa36WtKW7ZXoDQwHaHbQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f6fdb045 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 6 Sep 2022 12:21:49 +0000 (UTC)
Received: by mail-yb1-f174.google.com with SMTP id e126so9722820ybh.1;
        Tue, 06 Sep 2022 05:21:48 -0700 (PDT)
X-Gm-Message-State: ACgBeo1FyhV/DO5q9xIHlhWP27jxWn32jJo59E4KDu//5e6y14htCYFq
        yPxo6GCrbm4PxysnRB7zmUFtJRGKfoF3nWYBsmg=
X-Google-Smtp-Source: AA6agR6DlHZ2DQP25Da/H2mYl2dvW4b6xOX/+PgxLgff1j6vFIRgOZ8E7MS0iPzUnrZlFlm8vyq612vY+96rTE56Qsw=
X-Received: by 2002:a25:3211:0:b0:6a9:19b2:43ab with SMTP id
 y17-20020a253211000000b006a919b243abmr7116752yby.24.1662466907857; Tue, 06
 Sep 2022 05:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9ozPTL7tpj-QoFK3Dfyq58VAJgmM6MjUBW4VVM_TXo3VA@mail.gmail.com>
 <20220906104147.287726-1-Jason@zx2c4.com>
In-Reply-To: <20220906104147.287726-1-Jason@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 6 Sep 2022 14:21:36 +0200
X-Gmail-Original-Message-ID: <CAHmME9qM+wygTbRoSQ3EiobjDqD=2RMXOYjM48Adfa2DgHb5XQ@mail.gmail.com>
Message-ID: <CAHmME9qM+wygTbRoSQ3EiobjDqD=2RMXOYjM48Adfa2DgHb5XQ@mail.gmail.com>
Subject: Re: [PATCH v2] efi: x86: Wipe setup_data on pure EFI boot
To:     X86 ML <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Borislav Petkov <bp@suse.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Hi Boris and other x86ers,

On Tue, Sep 6, 2022 at 12:41 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> When booting the x86 kernel via EFI using the LoadImage/StartImage boot
> services [as opposed to the deprecated EFI handover protocol], the setup

Just FYI, while this is an EFI change for Ard, it also bumps the x86
boot protocol version, so it needs your ack or input on the matter.

Jason
