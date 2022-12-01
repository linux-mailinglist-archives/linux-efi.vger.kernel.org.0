Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC1963FC45
	for <lists+linux-efi@lfdr.de>; Fri,  2 Dec 2022 00:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiLAXrw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Dec 2022 18:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiLAXrv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Dec 2022 18:47:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F5D45A0E
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 15:47:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 107E1B82058
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 23:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9824C43143
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 23:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669938466;
        bh=uLr1mBAN5kyW6tNawzSLOuL89dQ691BlLcpQ0xhLM5c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ijzfxmBktpgqmDgvpHmFyHplaUsD3sl2GWR4FoUO1TtENq2vBrSDx6Bb+t/kULd7n
         MOvykAd3eRfcg5WD5rrJkhA9qufI2mFFs9ft/rExrTvEunyEec9h1TYCkhrheOz4hF
         oF5tidp7Am7rVxJv2i54oI/kN2dEdGljeDLvazv676PXTMxcCwABsqenXrOBWY+Eqy
         zwIKv3ErEIm1dhM9x0PccLYOksIVPK/GPusUfSUozviXbRV36+Z2MzcC+KxGDUrHm9
         5PJWN6deCP02nMJpxG60roAIL8SDSFO5arkBvf5NzM92tSGQdqM6pQhRnZKevyPDAP
         9N614jBN8gCfg==
Received: by mail-lj1-f170.google.com with SMTP id bn5so3686290ljb.2
        for <linux-efi@vger.kernel.org>; Thu, 01 Dec 2022 15:47:46 -0800 (PST)
X-Gm-Message-State: ANoB5pmYnjvpSAe1X5rB/Ejk4MMWh/b5ZvjyF9ID0PVInwATMZ7MMCmx
        7xTC7DcS9PRe4AWCXmgGyHl0GVmi7IK69X9DcQ0=
X-Google-Smtp-Source: AA0mqf4LxSd3aDTJGJuwGoP8eDxP56UGci0XZ5SeTPjEYQdsM09BI3JmLrn16x3tyW+GlB2h2ho6aFmNn4PBIpHrC8U=
X-Received: by 2002:a05:651c:1601:b0:277:3a1:e86d with SMTP id
 f1-20020a05651c160100b0027703a1e86dmr18137386ljq.152.1669938464694; Thu, 01
 Dec 2022 15:47:44 -0800 (PST)
MIME-Version: 1.0
References: <20221128094939.801232-1-ardb@kernel.org> <202212011544.2AA7C8A5@keescook>
In-Reply-To: <202212011544.2AA7C8A5@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 2 Dec 2022 00:47:33 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGBSv6jODKgayeChn5wPO0m0ahLGt+2GdU4OF8JBeQdmQ@mail.gmail.com>
Message-ID: <CAMj1kXGBSv6jODKgayeChn5wPO0m0ahLGt+2GdU4OF8JBeQdmQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: efi: Make runtime service wrapper more robust
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 2 Dec 2022 at 00:45, Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Nov 28, 2022 at 10:49:39AM +0100, Ard Biesheuvel wrote:
> > Prevent abuse of the runtime service wrapper code by avoiding restoring
> > the shadow call stack pointer from the ordinary stack, or the stack
> > pointer itself from a GPR. Also, given that the exception recovery
> > routine is never called in an ordinary way, it doesn't need BTI landing
> > pads so it can be SYM_CODE rather than SYM_FUNC.
>
> Does this mean x18 is now being spilled to the stack? (Do we already
> spill it in other places?)
>

I've found a better way of addressing this, by moving this code out of
the kernel .text mapping entirely, and only mapping it executable in
the EFI page tables (which are only active while a runtime service
call is in progress, and only on a single CPU running with preemption
disabled)

https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?id=47f68266d6ad94860c6cd9d2145cb91350b47e43
