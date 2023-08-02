Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1937676D319
	for <lists+linux-efi@lfdr.de>; Wed,  2 Aug 2023 17:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjHBP5k (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Aug 2023 11:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjHBP5j (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Aug 2023 11:57:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF201999;
        Wed,  2 Aug 2023 08:57:32 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 57C621EC0178;
        Wed,  2 Aug 2023 17:52:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690991548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yqMHR0Z0aVeHPdU7GGghI4+MBQDdK48qYp/dKJdytGY=;
        b=fT59unzFBkw1LjdFVUcEWkZwDYLDCa4u6LhyMRHlRs1qaS2uf4k3rrgWeO/XyYVc9CU7aO
        aP/24yaaFPT3H11gEh98HTvol4ZN8Ik2uwG5qkUcm5nKo1MxhT8YQdwiAP0q/YPweozBUp
        FD5zcPLrRpmxr9wn8fbyVYBZlOQiwHo=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ewxjwJTfMDVa; Wed,  2 Aug 2023 15:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690991533; bh=yqMHR0Z0aVeHPdU7GGghI4+MBQDdK48qYp/dKJdytGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cvk4t1AzQEkxxA1E1hNXYfPbU+DrxTNYnBKuVbuaYiEHytSWvEY2M9wg6Xs5YHYqF
         PZOnPuMj0tMFH4OI6+hAVN9PGFor8Yiw86CQUimpbSS6m+3xEZ3VBhcs+t2xZZKKWt
         ewoDr0HoPx6phDZvvud1M7alF2hYrBIGltul36nEt7VSm+pm4Fab6UqkovVQQpLs16
         O0mZN/8Hf7mDRwzgK0ct8RY9yBs8KkgNTniRqujZRUN0ddh6S/txFz486yxq/IBAMe
         xUSgDZAhAQWbfdIF/dKv3Q3ozRb6QniDTu0t+r5xxWCD0FpuvaNLNqkwzcE1KZDAyD
         CIM+jb+TJ1UARVj5dLhouk5RVCQdsGRgm/hZwIaU/uZ3+23Fssw7kRNw0NUt5OQUVm
         i23AcHfJmkKxQqcjmyk5nG7jV9brmNy3WSBEQuJiQGXs8OeY58T94trayXPNWHRxdv
         j5umebvH5TFZp5tAgu659Onukc8T9MvPNUZ+F9R3GhBAU2PxXZzmGOS3slBCii93Na
         FZmqYb+NPGSNlnHWNWRXdQG+F9ZLvaE0BjY7PRXLA2e2Tn5hZtUD3QX5jkdRLeh6N/
         3xzX/nvWoUl6mV+S6DUlkIgm3qwOsdqm1vr7MgxyQ7DdtoYaqr5cBYpQeFlY+L6hRr
         UDQYujMgkBcUV7CzNnifx2pg=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8448040E020F;
        Wed,  2 Aug 2023 15:51:58 +0000 (UTC)
Date:   Wed, 2 Aug 2023 17:51:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>,
        =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>, Tao Liu <ltao@redhat.com>,
        Michael Roth <michael.roth@amd.com>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, bhe@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <20230802155146.GCZMp7ksDdN2ETVzKV@fat_crate.local>
References: <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
 <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com>
 <20230717141409.GGZLVMsU6d/9mpJvMO@fat_crate.local>
 <CAO7dBbXJv9JzDbSa-DLT03+osYCQXNUXFwz63gbq=NGDxEVyEA@mail.gmail.com>
 <20230728165535.GDZMPzB/ek5QM+xJqA@fat_crate.local>
 <CAO7dBbVyuLHH6RfdVQkU5ThXaJ-F4yvFAYD1PDNGkOpph9xvnA@mail.gmail.com>
 <20230802093927.GAZMokT57anC5jBISK@fat_crate.local>
 <99cb3813-1737-9d10-1f24-77565e460c55@amd.com>
 <20230802135856.GBZMphIHHLa3dXRRVe@fat_crate.local>
 <CAMj1kXEM5hGknVGwHh_w99D4L8yrYrTFycwGHZ0CQun70CLipw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEM5hGknVGwHh_w99D4L8yrYrTFycwGHZ0CQun70CLipw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 02, 2023 at 04:55:27PM +0200, Ard Biesheuvel wrote:
> ... because now, entering via startup_32 is broken, given that it only
> maps the kernel image itself and relies on the #PF handling for
> everything else it accesses, including firmware tables.
> 
> AFAICT this also means that entering via startup_32 is broken entirely
> for any configuration that enables the cc blob config table check,
> regardless of the platform.

Lemme brain-dump what Tom and I just talked on IRC.

That startup_32 entry path for SNP guests was used with old grubs which
used to enter through there and not anymore, reportedly. Which means,
that must've worked at some point but Joerg would know. CCed.

Newer grubs enter through the 64-bit entry point and thus are fine
- otherwise we would be seeing explosions left and right.

So dependent on what we wanna do, if we kill the 32-bit path, we can
kill the 32-bit C-bit verif code. But that's for later and an item on my
TODO list.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
