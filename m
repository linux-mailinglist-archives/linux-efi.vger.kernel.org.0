Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6F574D101
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jul 2023 11:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjGJJHZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Jul 2023 05:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGJJHY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 10 Jul 2023 05:07:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBE0C3;
        Mon, 10 Jul 2023 02:07:22 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4355B1EC0683;
        Mon, 10 Jul 2023 11:07:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1688980040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3jCwGy7jvYI7e3jAtfhAlnYpY7F4wTZormRBRvMX+HY=;
        b=J/gwSWOD1O8UaT2hv+12DqthGXDk2Rl0HtTdAumDGa72TEAPx/kJOlddS1dwnpK0uy8XnZ
        cfBnO9DZFjK7GUfU1wUEGR5U8pYuzUjJW7mVEgCmwuMAlqFnbHKaiKlEnAETx/9aUyk553
        y/oxFrFknCevHOFCysUEdr/ZW4EoN4c=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8m8axYnXC3ej; Mon, 10 Jul 2023 09:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1688980034; bh=3jCwGy7jvYI7e3jAtfhAlnYpY7F4wTZormRBRvMX+HY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YvtUfGFpu8Mk88jkAHUpDcTJeCLALS9COTUtah9DyxCRlef+AaBdyF8iP9Y4fHfVH
         3+xrYmooltK48i4lzEwn0bW9biDLHgilDGRP6vYxirhAruhO6L0wdsKw3zs8LaJQma
         xdvWbhNTpJwkP76wQhLgBmiNX93hAwtKmfbsvGWRhKVQNJUEcjhVDfiY9jwK+No0o5
         ya4OQOh09t+DLYqk19164KmxLKGevbOa/COIsmkRs+p4WeifO1d3oOm90gSxd0HcQY
         ND2c3u4jDV2QS/ycc/5wR3QgtlvyHUYdPwxBLhkXZfAa30D4IDrbeQvtCWKple2Fhq
         /h2id0hCMgP+fqu6zS0kwc+D/VJwmfUJEYD41JlXk4whB4nMrdoTKiyRGwmBBTcIPy
         TolEcTQHWI/QEKcqQJxRQ72ppeLgtgjpOu/EsdmLxtPOvL+7NMqROKTOX7D5JdmrQp
         9S9VO6+C0KpX/sUBjYbDQI3YVeL+HD3ydgC/NpE4m5thGssOpQ3bzdD0twJH4nROtU
         OFDuuPGhlaKZoqCbiOh4/69eHnAMxelAEiAAU8wJxEXw30O/hSz4ymlIaGG3nLH2FQ
         Ke2kGOlah1v+Ei3VjzU7EoZ1ijytMptPXCnskoVDCWK+I4tfe7HXvzPTnRJatbMdtq
         GPneOW8PlUJQxiF+upEL4N9o=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C62E440E01A4;
        Mon, 10 Jul 2023 09:06:54 +0000 (UTC)
Date:   Mon, 10 Jul 2023 11:06:54 +0200
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v5 06/20] x86/decompressor: Store boot_params pointer in
 callee save register
Message-ID: <20230710090654.GCZKvKLh44tzlNzPcq@fat_crate.local>
References: <20230607072342.4054036-1-ardb@kernel.org>
 <20230607072342.4054036-7-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230607072342.4054036-7-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 07, 2023 at 09:23:28AM +0200, Ard Biesheuvel wrote:
> Instead of pushing and popping %RSI several times to preserve the struct
> boot_params pointer across the execution of the startup code, move it
> into a callee save register before the first call into C, and copy it
> back when needed.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/head_64.S | 34 +++++++-------------
>  1 file changed, 11 insertions(+), 23 deletions(-)

I like that.

We do a similar dance in arch/x86/kernel/head_64.S. Care to fix that
too, in a separate patch?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
