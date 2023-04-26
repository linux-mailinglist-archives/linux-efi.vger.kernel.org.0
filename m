Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2B56EF1C6
	for <lists+linux-efi@lfdr.de>; Wed, 26 Apr 2023 12:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240411AbjDZKSD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Apr 2023 06:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjDZKSB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Apr 2023 06:18:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ACC35AC;
        Wed, 26 Apr 2023 03:17:59 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0ECD81EC0666;
        Wed, 26 Apr 2023 12:17:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1682504278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BzFp9UTkit55n4G1B1tLt+bHSM18YHNZYgQD7TIcCfw=;
        b=ExC7kmQdSNPRo+YUhZwnm1FfqsRQoNAgdZ1TeOelIKOhMdcLXiua9EYw+HR/gmWQLSjQeW
        xvZzPs0c+E6SH5MUE7NLn6JpYqGOWRr/NiYzcGUoUAaDpSrlkx0ruabJ7TxWDGpoNRrtFa
        j/7ufgwq4afdwzHPw016WeO8cMIHvLI=
Date:   Wed, 26 Apr 2023 12:17:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/6] efi/x86: Avoid legacy decompressor during EFI boot
Message-ID: <20230426101754.GBZEj6Un+ahT4iZ9fs@fat_crate.local>
References: <20230424165726.2245548-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230424165726.2245548-1-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 24, 2023 at 06:57:20PM +0200, Ard Biesheuvel wrote:
>  arch/x86/boot/compressed/efi_mixed.S           |  55 ---
>  arch/x86/boot/compressed/head_32.S             |  24 --
>  arch/x86/boot/compressed/head_64.S             |  39 +--
>  arch/x86/boot/compressed/misc.c                |  44 ++-
>  arch/x86/include/asm/efi.h                     |   2 +
>  drivers/firmware/efi/libstub/efi-stub-helper.c |   4 +
>  drivers/firmware/efi/libstub/x86-stub.c        | 360 +++++++++++++-------
>  7 files changed, 279 insertions(+), 249 deletions(-)

Upon a quick scan, I can't argue with that diffstat and would prefer
a lot more if we did this instead of Evgeny's pile which touches a lot
of nasty and hard to debug code which gets executed on *everything*.

So if people agree with that approach, I'd gladly give it a more
detailed look.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
