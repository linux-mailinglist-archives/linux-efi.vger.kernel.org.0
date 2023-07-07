Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B0A74B593
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jul 2023 19:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjGGRMn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jul 2023 13:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGGRMm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jul 2023 13:12:42 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4E71BE8;
        Fri,  7 Jul 2023 10:12:41 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B2CAD1EC0398;
        Fri,  7 Jul 2023 19:12:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1688749959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6OzTAM5FK7zuWehbwIgNlYhTn7gz7QucEzqfEJ1uQTI=;
        b=Ofn5vYHULl96suxbDMl8V3puQxjmh25Tno5YjGIbEsBkrPiFJOa5NlyzTLaPt/R+MIeZUF
        Uizt9oJ9o7OW5R7R0wiP5jGIcMGUQymN8GRm9OGilHmdIYUahjq81dg90dw0ypAi4zDjKX
        MzwRASzQ5bETaid2gx4d3LR0NYyAHck=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id k6gAkJSP5-z2; Fri,  7 Jul 2023 17:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1688749957; bh=6OzTAM5FK7zuWehbwIgNlYhTn7gz7QucEzqfEJ1uQTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VDJmOTTLG3llFmdDaKnj+N0q1BVcJThGqAiKNp1ZUHH+UiMBMRE9/QEtwiG/3cfZa
         6rTjON9AFVVjHpGKcTOar3LrWQr0lV8K/BgOUzXLMHwOiR0/Yjk1jJq7dbJuekJCZZ
         X1L1rEMgfxlKC1xabfQg0YhvZXBAy4/oGeDF5opiQWZitjBa/mM1tWJQx2zQtPs0mE
         Slke0oVL8p5vYisoWC64IVbAy6pQR3qyMtzzqu705q4V4TaeXMJFcqZWEzLsLtSqKG
         vaIcWmD9wbRSP69U8m6r+t9uVZYxZr+bLuK0UJg52fwTrY3DIdcLtZ5PGFbb+QM3QJ
         ogtoWsUN71NuW3F1148tAjUqcyrk+mxw/qakHSeAu1/Qjg00Lo9qvzvGV8cZ3hlncG
         WcCi5e4Zqqch83l9g15JQ47DLEcuzjVt2Re6m8TlSmf0jRO/tVJuxy28y1UkjmI8Gz
         1cMm4q/vM3OOmdd/1RnoZcsln5QfAzBlHBYq8UKcev62KeIra9IrhsnYh3c7kTccoR
         6g7bNed2WfC0zbQsMSBCUBzH5xpzsES6JeHUXfHFgK/v3JyuB7rt5mLVkBpm+bwgcz
         e9yOY7qHCeETWZv6Yp/CuCVbtVWJVLhaAeysDmoY5OLOgEoPJPwT3cv6Kzl0shauJ7
         rD30uRnap9KWpwAVvKoxo2ec=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CECA740E0140;
        Fri,  7 Jul 2023 17:12:21 +0000 (UTC)
Date:   Fri, 7 Jul 2023 19:12:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Roth <michael.roth@amd.com>
Cc:     Joerg Roedel <jroedel@suse.de>, Baoquan He <bhe@redhat.com>,
        Tao Liu <ltao@redhat.com>, thomas.lendacky@amd.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <20230707171217.GHZKhHcffp4nn6RgR/@fat_crate.local>
References: <20230601072043.24439-1-ltao@redhat.com>
 <20230705173359.GDZKWphyFbNE8id6Jm@fat_crate.local>
 <CAO7dBbXdJgpO4Ym=4WME3OOrUhq2MNKpNZmhpsC7pOSugHiKDg@mail.gmail.com>
 <ZKeTX2aemPbsMiVr@MiWiFi-R3L-srv>
 <ZKfLYG_4DANc_i5r@suse.de>
 <20230707085712.GBZKfTaGJXnzhEenxj@fat_crate.local>
 <20230707152515.42gpfzjgvfwe6rf7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230707152515.42gpfzjgvfwe6rf7@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jul 07, 2023 at 10:25:15AM -0500, Michael Roth wrote:
> ...
> It would be unfortunate if we finally abandoned this path because of the
> issue being hit here though. I think the patch posted here is the proper
> resolution to the issue being hit, and I'm hoping at this point we've
> identified all the similar cases where EFI/setup_data-related structures
> were missing explicit mappings. But if we still think it's too much of a
> liability to access the EFI config table outside of SEV-enabled guests,
> then I can work on re-implementing things based on the above logic.

Replying here to Tom's note too...

So, I like the idea of rechecking CPUID. Yes, let's do the sev_status
check. As a result, we either fail the guest - no problem - or we boot
and we recheck. Thus, we don't run AMD code on !AMD machines, if the HV
is not a lying bastard.

Now, if we've gotten a valid setup_data SETUP_EFI entry with a valid
pointer to an EFI config table, then that should happen in the generic
path - initialize_identity_maps(), for example - like you've done in
b57feed2cc26 - not in the kexec code because kexec *happens* to need it.

We want to access the EFI config table? Sure, by all means, but make
that generic for all code.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
