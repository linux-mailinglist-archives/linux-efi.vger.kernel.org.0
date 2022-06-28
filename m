Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B4F55D1EF
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 15:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245526AbiF1HuO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jun 2022 03:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245504AbiF1HuN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jun 2022 03:50:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D8010E9;
        Tue, 28 Jun 2022 00:50:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63ABEB81D1A;
        Tue, 28 Jun 2022 07:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADAFC341CB;
        Tue, 28 Jun 2022 07:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656402610;
        bh=aiD3eMLrH2Ct0Gn+1sj9Q8L9OK8u7ri0bzVNBJui2/g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K2YlmC8OHj3tZ17D96mYJnkccAezcnkshoerIQn1fiR0c78PH5mvlCTiEtc37AcIp
         LOoJ1sqeGgNecsBAvuV64L4FNuIh8ZhVeAFYYRFc3crhP8EWgbBfw88Rgr6x4K1PIL
         ZTReQbxfNkplNYqBkYgYdTGWSuFgdmQA0HMAnDo88Eln82O0N5jAAXMK15jgeIRLZe
         GGVEM0i24SwkkyjO4EW6T3f6cV7LzTiYuC2PNDA+l0UdHEiW7IArtdH/hf6Kmnx7Am
         MAGrb9lMEHzAb6UqBNGDqAODw6jXIDrCVw3WpK+7cLGq63iZWhotGVibhjOyKIqDWp
         35IfsH4mrbEMQ==
Received: by mail-lf1-f49.google.com with SMTP id z13so20722462lfj.13;
        Tue, 28 Jun 2022 00:50:10 -0700 (PDT)
X-Gm-Message-State: AJIora9Uxot0yiNZOu7wXUhBQGKlfk93/ufH7s/tiB39SIwZK5bImJk1
        pkIG5um0bcwtr63TUBD0mKQdSSex6WSsOU/xgJA=
X-Google-Smtp-Source: AGRyM1sS/4PxpYsRaP0D/aDfyv/NiyzYYJeulsRgvdP/7s7GSqjC8O+SpUPkZf1xLvQHfA5qDk0npmnH9xOLnp2nN8Y=
X-Received: by 2002:a05:6512:e83:b0:47f:635c:3369 with SMTP id
 bi3-20020a0565120e8300b0047f635c3369mr10406750lfb.659.1656402608055; Tue, 28
 Jun 2022 00:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220520195028.1347426-1-gpiccoli@igalia.com> <d3dd4f45-1d50-2164-447b-d4f27ac6e133@igalia.com>
In-Reply-To: <d3dd4f45-1d50-2164-447b-d4f27ac6e133@igalia.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 28 Jun 2022 09:49:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFDqhvE3R4ckD32ftkb66CjHZcGPCF0OsX6bev2MmnorA@mail.gmail.com>
Message-ID: <CAMj1kXFDqhvE3R4ckD32ftkb66CjHZcGPCF0OsX6bev2MmnorA@mail.gmail.com>
Subject: Re: [PATCH 0/2] UEFI panic notification mechanism
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-dev@igalia.com, kernel@gpiccoli.net,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Tony Luck <tony.luck@intel.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2 Jun 2022 at 19:40, Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>
> Hi Ard, apologies for annoying!
>

No worries, just very busy :-)

> Just a friendly ping asking if you have any opinions about these patches.
>

Honestly, I'm not sure I see the value of this. You want to 'notify
the UEFI firmware' but the firmware doesn't really care about these
variables, only your bespoke tooling does. EFI pstore captures far
more data, so if you just wipe /sys/fs/pstore after each clean boot,
you already have all the data you need, no?

Also, I'm in the process of removing the public efivar_entry_xxx() API
- please look at the efi/next tree for a peek. This is related to your
point 3), i.e., the efivar layer is a disaster in terms of consistency
between different observers of the EFI variable store. Switching to
efivar_set_variable() [the new API] should fix that.
