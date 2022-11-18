Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FC163063B
	for <lists+linux-efi@lfdr.de>; Sat, 19 Nov 2022 01:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbiKSAIv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Nov 2022 19:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbiKSAII (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Nov 2022 19:08:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9293F039E;
        Fri, 18 Nov 2022 15:32:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C4C262530;
        Fri, 18 Nov 2022 23:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC3BC433D6;
        Fri, 18 Nov 2022 23:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668814285;
        bh=MZRS+OxXQgl42Jjr+WbabGJEkBW38tBtHB6EUxM6AKk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C54qqpT5p8AJ9wUR+xc0T+6B4T96kvXuIeWdyAckzRkYZNZS5VAr8v3AUt9YcmNcm
         YMtZUGODSZmsu8b88G/cOHiWNVl5+LaDl65qyWwJj4sEbERq2vKDKGQpA1rhztZMk/
         hSU++cew6i/ziFIPa5YdkKdjwdo3VRe4wCu3sXB1Qrpu13VKkBKCWWHsUOX7bTt2Gd
         oKtOqmswhMZbhOCaXWgK6a2yteC/ad9lEjF2uQp5EQz5vdaIEGjc3WJXwGPvaDNVsr
         vQFQrfPtOOpuq7ptCs9nilWOU4vOq1WtV/4Mp2zgEC5Nc5NKX8jUcKeAnHNe1nBwfz
         RJaCRz831PWNg==
Received: by mail-lf1-f51.google.com with SMTP id be13so10642254lfb.4;
        Fri, 18 Nov 2022 15:31:25 -0800 (PST)
X-Gm-Message-State: ANoB5pkKlpvb/FO3LA52IKr+ho0SQdQsNUSkDp4pQH5iC8F1IgJnoAw9
        sLOHIFmcvG2+P/ZKWFoEtlvRALEGC12bECsg+kw=
X-Google-Smtp-Source: AA0mqf5CaigXvQRTaJEUHHvR2qg6mn9tSD7yXR4rp1G2sHv9y6hwBe1XtXCCBLsPJtsK9hZYMFN2gF7t5qTNUxUyCUY=
X-Received: by 2002:a19:6b19:0:b0:4a2:740b:5b02 with SMTP id
 d25-20020a196b19000000b004a2740b5b02mr2898306lfa.122.1668814282766; Fri, 18
 Nov 2022 15:31:22 -0800 (PST)
MIME-Version: 1.0
References: <20220921145422.437618-1-ardb@kernel.org> <Y3fOVRp1IlBF7nhm@zn.tnic>
In-Reply-To: <Y3fOVRp1IlBF7nhm@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 19 Nov 2022 00:31:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFbH+=NQ9e=dA3ucUzCRXhL2i=QDTkWAJ_p=5ZAz_Q-zA@mail.gmail.com>
Message-ID: <CAMj1kXFbH+=NQ9e=dA3ucUzCRXhL2i=QDTkWAJ_p=5ZAz_Q-zA@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] x86: head_64.S spring cleaning
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 18 Nov 2022 at 19:26, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Sep 21, 2022 at 04:54:06PM +0200, Ard Biesheuvel wrote:
> >  arch/x86/boot/compressed/Makefile       |   8 +-
> >  arch/x86/boot/compressed/efi_mixed.S    | 337 ++++++++++++++++++++
> >  arch/x86/boot/compressed/efi_thunk_64.S | 195 -----------
> >  arch/x86/boot/compressed/head_32.S      |   4 -
> >  arch/x86/boot/compressed/head_64.S      | 299 +----------------
> >  arch/x86/boot/compressed/mem_encrypt.S  | 152 ++++++++-
> >  drivers/firmware/efi/libstub/x86-stub.c |   2 +-
> >  7 files changed, 496 insertions(+), 501 deletions(-)
> >  create mode 100644 arch/x86/boot/compressed/efi_mixed.S
> >  delete mode 100644 arch/x86/boot/compressed/efi_thunk_64.S
>
> Ok, it all looks ok to me.
>
> You could send me a refreshed version ontop of latest tip/master, after
> having tested the EFI side and I'll test the memory encryption side.
>
> If there's no fallout, I think we could queue this.
>

Sounds good.
