Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B216757A96
	for <lists+linux-efi@lfdr.de>; Tue, 18 Jul 2023 13:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjGRLkJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Jul 2023 07:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjGRLkI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Jul 2023 07:40:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DD51AC;
        Tue, 18 Jul 2023 04:40:06 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8A4461EC067D;
        Tue, 18 Jul 2023 13:40:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1689680405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=D1xiac6lETnnfabnTcNXYrEgT2JegDS88JpdVzFMCqs=;
        b=Rptp8x/9cPsvmQ/EXZ8oDX6skh3nmPiy+IlBhQZS+O4KG7300TNm9dOnO5kUh83UsyCBBE
        /i2N6At20G+1cr7rss5/WUH34HJpsYZ1KjmllnNVIGfl5SCU613S1FE/taKT9MAHhRVDW4
        1DezS2KNdKH50eKVfoOwe0OESXCtYqw=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tFqyjT-HLLXE; Tue, 18 Jul 2023 11:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1689680402; bh=D1xiac6lETnnfabnTcNXYrEgT2JegDS88JpdVzFMCqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mc+gAkyzso/calx98q1scp3QaGc7KVKtSCJVBSgAQi9oEilgcM9dNgXtbb4Y5H1Jk
         qeBhSW1c1wAITWwUMd3utLKpOuqCRWqdj7QpzJ2lYY/HbjxWNx5IhB9jBp6C/OFfc2
         lekdJVe1UIx+AWMI3ElXDMW9eohxujHGagLtEqgvAK6jZlIB4xSvqHOl5r6cMTpS3+
         gWt9NLf1fFOdDYzqMF/QRPZof9qpg2fewnCwrVvNboOqlPKWCtAzRZ8jd1qTzIzjUZ
         XfM4i+D6JdC8zrbNwkobAwFl4UHRQn9cZDPC68nbpL5usyOSDAFVGU6lrI/3Ih1tpc
         uedlY/+6xzlHurhJN27DegVMDq2JT1fnrVXPCJ4QR1ScRv1TdQmUTKQoBPnPUy0XGS
         wQzgFPP2a2ghot8K/VdooMHnq/5ycPp4dZRYdbuf+KiOYS2jQD5BMLy3j04ChIBTi8
         /XTJsh/VNJyFUCMHcOqwuaRNbtgSaDfag41SXnDlFHd4E2ZAERza43tsmSzwnoIh46
         yWsMyLjYC/Uw+sGO8rD2DJKArg+6eZWjC4ImLFYVDKSbiyB1xM4YgLsa9KzI26H+8C
         KmDbT7oGpnaM4yiQs/0FDiguJ3aW5JUuzuJVVY4W9bBTtZsI62/q9uXH+IBFYVXvN6
         47SstIRh+Nln7HrxmbXENvsk=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F15B840E01CB;
        Tue, 18 Jul 2023 11:39:42 +0000 (UTC)
Date:   Tue, 18 Jul 2023 13:39:36 +0200
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
Subject: Re: [PATCH v6 01/21] x86/head_64: Store boot_params pointer in
 callee save register
Message-ID: <20230718113936.GEZLZ5+ICZvIQa8Hl3@fat_crate.local>
References: <20230711091453.2543622-1-ardb@kernel.org>
 <20230711091453.2543622-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230711091453.2543622-2-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jul 11, 2023 at 11:14:33AM +0200, Ard Biesheuvel wrote:
> Instead of pushing/popping %RSI to/from the stack every time a function
> is called from startup_64(), store it in callee preserved register R15
> and grab it from there when its value is actually needed.
> 
> Secondary boot does not and should not care about the value of %RSI at
> entry, and all the C handlers except the primary boot C entrypoint all
> ignore the function arguments entirely. Avoid inadvertent surprises by
> zeroing R15 on the secondary boot path explicitly.
>  
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/kernel/head_64.S | 23 +++++---------------
>  1 file changed, 5 insertions(+), 18 deletions(-)

LGTM.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
