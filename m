Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C502C76B56E
	for <lists+linux-efi@lfdr.de>; Tue,  1 Aug 2023 15:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjHANFc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Aug 2023 09:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjHANFa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Aug 2023 09:05:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3581EE6;
        Tue,  1 Aug 2023 06:05:28 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BA5291EC00F8;
        Tue,  1 Aug 2023 15:05:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690895126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=huhgM4QNcUOJXOMs6XC5tH8KvB31K03DmazQQB0Tyo8=;
        b=eRAkwh1trGobHEOSOlQqpdLyvw0MBHhJYhg/4WvhYzrqiEJCRq0FVuYsDRlBuASzwLBVun
        S/iZarGPZfnuM+cUX64IKGTHlKPpPUEN+D4m6ZNcNMsHib/Ggs3tIAREw6pl/UZfgYjoD/
        5BpDje0pn/w/H5TpDsAAQBbSg/GhpSQ=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2-ivCAcxjB2i; Tue,  1 Aug 2023 13:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690895124; bh=huhgM4QNcUOJXOMs6XC5tH8KvB31K03DmazQQB0Tyo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jGU75Dicggb51TMnod649pxf7dWVhB5vqjsPrpfEKyQA0xh+LOUsE0RVBuadBSf96
         tupG2LhG96VHAOfkw2PVGD7kkaeRGcusmxReDi+FVEXC9UXWF9fWpLF2NmaJoE8q3F
         SIeBg3+aexD7nURcOUGLW24/oZDeSDKOVj8RQPW+5K5Jyf1HIUz7x3KtAKabQRkoLZ
         8o/MxBkzH8Z5NUs2WzSH5q2WL3eQwf33P+iyZlI8d5kd4ugWFISCzGGp3Ryeg3Nvvr
         eeCFWElKTQgnqYYt6WJNiBhX7+bS4hrQ32HfpBwRWKEI3O8c5osxO/XKDS69fJwRJU
         /Wj3pJezhOZInVaw12gA5QeqOWg77y/mwCP6vt56ugH0ZXQuPSyyaNtgffHCo0RAwK
         +lvJhVYIWciIZDPPwuqd7FdyeHwONcFdt0yfhw7XE7DS7QarOdatz5ANe3eafVztOG
         oSK1tK4oe8bt6e1biNZwGytdZt/BCU1mP8woUZYKyCplQD7FmVjonAiyNqRByFDTT9
         Rkc9+k+N4TftpL2uOyrFp2mMkuHYqny8ZLiNrYd83f7zF9K+zMLpO60TLON2pF4Lzw
         O7DqvE6xCtLtihab7SsTKJm6UsmoCFUILIiWqRWymTZZvUilNVhM0MfIqnPNeTZwLv
         qCpfdqigwX+WNmrWvNC5NV5A=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F2FA540E0184;
        Tue,  1 Aug 2023 13:05:04 +0000 (UTC)
Date:   Tue, 1 Aug 2023 15:04:59 +0200
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
Subject: Re: [PATCH v7 14/22] x86/decompressor: Merge trampoline cleanup with
 switching code
Message-ID: <20230801130459.GHZMkC+0Yu8tHldm8a@fat_crate.local>
References: <20230728090916.1538550-1-ardb@kernel.org>
 <20230728090916.1538550-15-ardb@kernel.org>
 <20230801120827.GFZMj1uzNMDs2gIi1f@fat_crate.local>
 <CAMj1kXF+=W_oe7MS87rWdJ_z555iz2A8iR42fJ1mwZ+bgCgjmw@mail.gmail.com>
 <20230801124054.GGZMj9VrrB+4a4NiZs@fat_crate.local>
 <CAMj1kXFGN6DAhWk647=jHW5wBMP0y4p9wzPBz3R7h=Gh1v6VEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFGN6DAhWk647=jHW5wBMP0y4p9wzPBz3R7h=Gh1v6VEA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 01, 2023 at 02:46:16PM +0200, Ard Biesheuvel wrote:
> but GCC 13 seems to be fine with it.

Ah, ok, yeah, it bombs here too with gcc-10.

So either change the assignments, please, or explain in a comment above
it why exactly is this needed.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
