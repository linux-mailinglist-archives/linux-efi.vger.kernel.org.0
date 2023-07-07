Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57BF74B24A
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jul 2023 15:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjGGN44 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jul 2023 09:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjGGN44 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jul 2023 09:56:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA721FC7;
        Fri,  7 Jul 2023 06:56:55 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 87A131EC0773;
        Fri,  7 Jul 2023 15:56:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1688738213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iNn8Lobuwq8oGyKnx/IrJ5I2KhzyBS1z7FSQ9+iwXAw=;
        b=eRR9ZBaJGfBlMs+WLlyj2EELekTQY3VLN25t86xinriciYkfqKGtav3JpbkaUp7gP5jiM6
        w4Mwi42Hx7dlP0djiUcKW1UYFu6UTxwBCpQhmaToWHZOWIZMzH/r7yF2E9ejYiDo6wmjg+
        gmLDXQ/9+ofDiFE0d9D+cxZT1gXvTxQ=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Td-cmWnxeZ-a; Fri,  7 Jul 2023 13:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1688738210; bh=iNn8Lobuwq8oGyKnx/IrJ5I2KhzyBS1z7FSQ9+iwXAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NnchMBN7vx1cZyjXa/nEErc3VaRGeJVSvPTmkee4HYTv4Kwg44wRr0dEg1gjU92fJ
         N9tmvhchhtzR9ACfCEiOUDiZeRVYPHV8rFFxJeiMtmVLzuLMjxMXNZvToRV9Fqka0w
         GA1kN29bgwOVkLKWd+XftyWFa/K9vDiLTNvtXYZbD7HDEbZ/5ANDLpyIWilf/mkEBl
         uvxk+Z+IVn2SwyDDHoIQ63Nqclbzu6kp3vsoby/+S9BtfP6+s26IGPHn+HVqJQq9Ez
         J+/NDo4fbmM6D6vdatjDLyK9yG8n2vcXK11fykyBncBUV4Y0AXoBQFifJKCRqjvh/a
         HIPG52ObPed1kQwductDSeMY3Hv3Xeubvc5U4lYZBwaji++krp4/QE7OGvqEF7GLki
         9e0GOWEq0TkAurCd4fJamvGpNJwWnyU2d8LCV+P6IlT0f+iwaYk9iAGyh7e9JieRzw
         WN9DPPF8JwTQh+IC6+1Fgb1+/OIGp6XAMh0fIe2RbtPm1fe9wOu6IWYsD0GmIwk5ey
         3RyFx8HMw7AqUb85wRFJXYMBmuM9a8R0n1O3fPWA4hUhdjxBDaY0AfDSRSy7bPnD07
         y8KcN5lC05sKqfO5HI8t/r/HMchEzktEdsDF3ecs6qpq+axvVlfDTPkkYQCIFtt+8/
         GkgkN1+KIXkvE+lXjnRKvG6Q=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 927F440E0187;
        Fri,  7 Jul 2023 13:56:31 +0000 (UTC)
Date:   Fri, 7 Jul 2023 15:56:27 +0200
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
Subject: Re: [PATCH v5 05/20] x86/decompressor: Use proper sequence to take
 the address of the GOT
Message-ID: <20230707135627.GEZKgZizdtbMokdz2u@fat_crate.local>
References: <20230607072342.4054036-1-ardb@kernel.org>
 <20230607072342.4054036-6-ardb@kernel.org>
 <20230621110852.GAZJLaRAuGBCc5R4yb@fat_crate.local>
 <CAMj1kXEyWJ7GgcLBdqd1GkEGEEX=4vi7d6ZVEAJ0zjU1Y+ioUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEyWJ7GgcLBdqd1GkEGEEX=4vi7d6ZVEAJ0zjU1Y+ioUQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 23, 2023 at 04:00:30PM +0200, Ard Biesheuvel wrote:
> if you assemble this
> 
> movl $_GLOBAL_OFFSET_TABLE_, %eax
> movl $_GLOBAL_OFFSET_TABLE, %eax
> 
> you'll end up with
> 
>    0: b8 01 00 00 00        mov    $0x1,%eax
> 1: R_386_GOTPC _GLOBAL_OFFSET_TABLE_
>    5: b8 00 00 00 00        mov    $0x0,%eax
> 6: R_386_32 _GLOBAL_OFFSET_TABLE
> 
> So it is not possible to take the absolute address of
> _GLOBAL_OFFSET_TABLE_ via an absolute relocation, you will always get
> the relative offset instead.

Right.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
