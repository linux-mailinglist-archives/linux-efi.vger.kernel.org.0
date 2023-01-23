Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931B9677599
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jan 2023 08:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjAWHa1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Jan 2023 02:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjAWHa0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Jan 2023 02:30:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DE417167;
        Sun, 22 Jan 2023 23:30:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 612F3B808D5;
        Mon, 23 Jan 2023 07:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1027AC4339E;
        Mon, 23 Jan 2023 07:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674459023;
        bh=yqHRmBM/5HKjzaBie8odadDl/b5Q4ya5gnQh2zFliW0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iGq5+eY5tyMw6oahuiHN28IBRDzPcwah1Tj6QMnoc1/Er+SEnF1kUj3FyEewGhNAL
         2oNaeTuCjq9wQ3S3cN+Qi8Ti9iMARl2TUxhxKLUgDjaq0Ips8RY8Rvz4gPVCo155uX
         DxdsLaADc4afozv2jPJRMwYKItIWNsUWIoia9NUqTKLnegidJJXvHDXSchAiqXvk5a
         3tuFLLfahb1o891CjD83Y6UCad/u+SmZyAfnsBOyFjiVOfUMZE39xhev/Zpcjye+ze
         b09krGV86uoDA0XlqIxHr35Y2sao3CduQgPq6gK6B39SY9wjZbdPIsVbZrDHvqbhvd
         2eWEn/ASR54ug==
Received: by mail-lf1-f47.google.com with SMTP id f34so16823029lfv.10;
        Sun, 22 Jan 2023 23:30:22 -0800 (PST)
X-Gm-Message-State: AFqh2kq06hdaC/xvt1rFydBqwFQFLpmnJ/KW7rCAg2Ltglyt0vmr/y1A
        dpNqG1G2p0DErYOzxROuBFhYKbb4ZODgzvoO3+k=
X-Google-Smtp-Source: AMrXdXvLGWnD0SLJx80UTiS66Ijd6HhijiZdhKVE7te2RkGIhVL2UPwS2V4brcBlC75bspAFezet9YOtuuT2k/ow/ZA=
X-Received: by 2002:a19:675e:0:b0:4b6:f37c:c123 with SMTP id
 e30-20020a19675e000000b004b6f37cc123mr1643063lfj.539.1674459021083; Sun, 22
 Jan 2023 23:30:21 -0800 (PST)
MIME-Version: 1.0
References: <20221003112625.972646-1-ardb@kernel.org> <b18879e0329c785d35f2aa2164413bb56419c684.1674153153.git.demi@invisiblethingslab.com>
In-Reply-To: <b18879e0329c785d35f2aa2164413bb56419c684.1674153153.git.demi@invisiblethingslab.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 23 Jan 2023 08:30:09 +0100
X-Gmail-Original-Message-ID: <CAMj1kXELH7+d5141yhBudrA0vtOOkCfVucwGBpag9u4mU4Q0iA@mail.gmail.com>
Message-ID: <CAMj1kXELH7+d5141yhBudrA0vtOOkCfVucwGBpag9u4mU4Q0iA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] efi: Support ESRT under Xen
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 19 Jan 2023 at 20:04, Demi Marie Obenour
<demi@invisiblethingslab.com> wrote:
>
> This patch series fixes handling of EFI tables when running under Xen.
> These fixes allow the ESRT to be loaded when running paravirtualized in
> dom0, making the use of EFI capsule updates possible.
>
> Demi Marie Obenour (5):
>   efi: memmap: Disregard bogus entries instead of returning them
>   efi: xen: Implement memory descriptor lookup based on hypercall
>   efi: Apply allowlist to EFI configuration tables when running under
>     Xen
>   efi: Actually enable the ESRT under Xen
>   efi: Warn if trying to reserve memory under Xen
>

I have given these a spin on a system with a dodgy ESRT (the region in
question is not covered by the memory map at all), and things are
exactly as broken before, which is good.

I have queued these up in efi/next now, they should appear in -next tomorrow.


>  drivers/firmware/efi/efi.c  | 22 ++++++++++++-
>  drivers/firmware/efi/esrt.c | 15 +++------
>  drivers/xen/efi.c           | 61 +++++++++++++++++++++++++++++++++++++
>  include/linux/efi.h         |  3 ++
>  4 files changed, 90 insertions(+), 11 deletions(-)
>
> --
> Sincerely,
> Demi Marie Obenour (she/her/hers)
> Invisible Things Lab
