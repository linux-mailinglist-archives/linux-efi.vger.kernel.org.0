Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A45F5944F8
	for <lists+linux-efi@lfdr.de>; Tue, 16 Aug 2022 00:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348074AbiHOW21 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Aug 2022 18:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351047AbiHOW1a (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Aug 2022 18:27:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7049D6CD10
        for <linux-efi@vger.kernel.org>; Mon, 15 Aug 2022 12:46:27 -0700 (PDT)
Received: from zn.tnic (p200300ea971b988d329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:988d:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0DFE51EC050F;
        Mon, 15 Aug 2022 21:46:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660592782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7Jn2dDDQZtD9nyeShUmyR/9VwVHO3QfD/BTYs2ygGZU=;
        b=JU6RxH9op2rqe+P1L//hEztNlPCkq3DzoTV38T+Ndye2nfGYiqEBe+5wRdt7r5vsvNPdKX
        QMp/2kayKbJkTbF1cSpc5jTLOHgoJudi0+CgPJf7NC/xvpGIRCO7tJihCHCfJlnM0SCOdx
        AoLcymst+igpXziH85dZabT8UJkJ3tM=
Date:   Mon, 15 Aug 2022 21:46:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: Re: [PATCH] efi/x86-mixed: move unmitigated RET into .rodata
Message-ID: <YvqiiKBPockZbRqG@zn.tnic>
References: <20220815132028.732531-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220815132028.732531-1-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Aug 15, 2022 at 03:20:28PM +0200, Ard Biesheuvel wrote:
> Move the EFI mixed mode return trampoline RET into .rodata, so it is
> normally mapped without executable permissions.  And given that this
> snippet of code is really the only kernel code that we ever execute via
> this 1:1 mapping, let's unmap the 1:1 mapping of the kernel .text, and
> only map the page that covers the return trampoline with executable
> permissions.
> 
> Note that the remainder of .rodata needs to remain mapped into the 1:1
> mapping with RO/NX permissions, as literal GUIDs and strings may be
> passed to the variable routines.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/platform/efi/efi_64.c       | 18 +++++++++++++-----
>  arch/x86/platform/efi/efi_thunk_64.S |  8 +++++---
>  2 files changed, 18 insertions(+), 8 deletions(-)

Acked-by: Borislav Petkov <bp@suse.de>

For some reason, objtool is not happy here:

vmlinux.o: warning: objtool: efi_thunk_query_variable_info_nonblocking+0x1ba: unreachable instruction

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
