Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2774ADAAD
	for <lists+linux-efi@lfdr.de>; Tue,  8 Feb 2022 15:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377456AbiBHODi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Feb 2022 09:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377460AbiBHODf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Feb 2022 09:03:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0695C03FED4;
        Tue,  8 Feb 2022 06:03:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BCBC61019;
        Tue,  8 Feb 2022 14:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE259C340EF;
        Tue,  8 Feb 2022 14:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644329013;
        bh=Xa3UBrXhuGTsrY6ZL5Pdx4rWJE7m4s0PC5jjWeIEjew=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gRMnHXKD4D83mDb93SFgR40rK+dqWAHmuiZlcspcGEev+KgSKZU9Mq5lhMLuEwOzU
         hj71f3lKsgUESjNZ/rChvgROSK1ndTz7fryQUzEc2cosLNIr7BInc0v3EXiiSgFb6/
         VHtHYWBcZAm2ZsWzjnCvkPmbmoKsT4Yi4NhJ+c9CUKAFOUOReYKXTCUH8OyinDht5u
         16VL1ociMYbXeziEy/bwSvaCqKWJUfDmtmjfiMT0s6hfvBuCwo72dru72gTQRLWhSY
         mSCDuA3yiBCHtGEC3jDhN5SPFeTxxOQefA7xXaU9Y9Jmo88ZmMJAVvZsNU9yi3ZZj9
         6z+sxaJ8L43eQ==
Received: by mail-wr1-f49.google.com with SMTP id e3so16991292wra.0;
        Tue, 08 Feb 2022 06:03:33 -0800 (PST)
X-Gm-Message-State: AOAM532j/DSi/DnRyJFtRkozhFwKxtPnnaKIDy+pPSXKw0SKVx5G19Kd
        6VbD/APTynsFgtRp/Qoo6RxQQ6b/M5nyp/S+hHE=
X-Google-Smtp-Source: ABdhPJyi+Kijy3/qJKCYBCr9I63+NQlNBMxsy+QBROXXF12wveFBs6WamrDlOJ04QNZaDx+f9yZ34KVqpMmjT9dGhx0=
X-Received: by 2002:a05:6000:1b88:: with SMTP id r8mr3744166wru.447.1644329012050;
 Tue, 08 Feb 2022 06:03:32 -0800 (PST)
MIME-Version: 1.0
References: <E5DB4C43-F2AB-412A-9891-C13255374AD9@live.com>
In-Reply-To: <E5DB4C43-F2AB-412A-9891-C13255374AD9@live.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 8 Feb 2022 15:03:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEUudnnX8FaAhtUmcKB+jt237BUTsMrNC8ZoOepf4P3pQ@mail.gmail.com>
Message-ID: <CAMj1kXEUudnnX8FaAhtUmcKB+jt237BUTsMrNC8ZoOepf4P3pQ@mail.gmail.com>
Subject: Re: [BUG SEVERE] Failure to enable EFI Runtime services on T2 Macs
To:     Aditya Garg <gargaditya08@live.com>
Cc:     Jeremy Kerr <jk@ozlabs.org>, Matthew Garrett <mjg59@srcf.ucam.org>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 8 Feb 2022 at 14:55, Aditya Garg <gargaditya08@live.com> wrote:
>
> On using some specific kernel configuration, on Macs with the T2 Security=
 chip, EFI Runtime services fail to start. Some logs which may be useful ar=
e as follows :-
>
> Feb 08 17:11:11 MacBook kernel: [Firmware Bug]: Page fault caused by firm=
ware at PA: 0xffffa79840068000
> Feb 08 17:11:11 MacBook kernel: WARNING: CPU: 11 PID: 150 at arch/x86/pla=
tform/efi/quirks.c:735 efi_crash_gracefully_on_page_fault+0x50/0xd0

This means the firmware is broken. There is very little we can do
about this beyond disabling EFI runtime services entirely on such
systems.

...

> The kernel configuration where this bug is seen is on https://github.com/=
t2linux/T2-Ubuntu-Kernel/blob/Mainline/templates/default-config
>
> I had an old kernel configuration, where I did not face this issue and wa=
s easily able to write to the NVRAM. That kernel configuration is on https:=
//github.com/t2linux/T2-Ubuntu-Kernel/blob/b5c20b8c7689251dd943e22dbe02cef9=
020db8d1/templates/default-config
>
> I believe these lines in the kernel config, which are present in the form=
er but absent in the latter are causing the issue :-
>
...

> Especially CONFIG_LOAD_UEFI_KEYS=3Dy is which I guess may be the culprit.
>

Yes, that seems likely.

> I request you to reply to my issue as soon as possible
>

Please stop demanding attention like this, even though it is thinly
veiled as courteous.

If you want to run bleeding edge kernels on non-standard EFI hardware,
you have to be able to sort yourself out to some extent. I am the
EFI-on-Linux maintainer, but that doesn't mean I work for you and have
to be on call to fix your problems.
