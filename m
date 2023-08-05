Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA13F771248
	for <lists+linux-efi@lfdr.de>; Sat,  5 Aug 2023 23:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjHEVHG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Aug 2023 17:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjHEVHE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 5 Aug 2023 17:07:04 -0400
X-Greylist: delayed 42538 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Aug 2023 14:07:01 PDT
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909B2F3;
        Sat,  5 Aug 2023 14:07:01 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 46A4F40E01E6;
        Sat,  5 Aug 2023 21:06:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mDR1zX95AhXg; Sat,  5 Aug 2023 21:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691269617; bh=ZNbE/iR1y4P73xSiZEC5dDVZ23AGSXnmOFS5oE7dhng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KMH7zU4LY2DjyKu8xkZz1P5GpzWLeIzcg3SM43GmghShJIbZLW6yOGu0MkLTRYWhu
         5CgQnW5MavBfLmzk+YBiy3ONIMixXIZPFmJHWpD9RtrO2WQcPqYhCS/HTuRNIg58Tv
         Km6glkL3WpDP1KgamTWdrg9Ihtu9K2kykgYxAHRi1j7HCkuBIb8pCOdk2MksZs1c15
         RBgccIm5OFsq/IxjSf880N1GMJZ7pITPRDSTY1eyRLhBUC4TbGQgt3lsEiY9nuy2s9
         oPp4DjPOpmwn3NjeUKSwhtffs4sdSRAxUO3w7ZcBwkYRY6/WdX9OCxK/dipjMVfS0p
         FxFwVnkQm47/EjDubWYpN0NtrRwxUYWI9zloki2SUUQAGXUK1pV/8yY/yekm/029dd
         OKuioXvd0r5VfpwQQVzSepxn2snpOEKqn148EoAamI7lwnB0cGLQXWf2iDqGJE6Zso
         2ipxwlo5YrfV7RI+Qt4ZArQO+ZbhG8mtMGOh+HIP9mAEGuytv1vuGA1eLhPfcBRksJ
         NwYjXBUiWQkxhSTCnD3iEhQZkeLjjCffFdntdfacOoj43u+37FveRwKUft1mTkpJ16
         XY6iUz/uTIJPMtOysPptsZKFvQIiwa23y0edDNEhm4I1zvETxektly/H6zGlPfuiOG
         swa+qUoRLAiByKRkMiEknpsQ=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D122A40E0193;
        Sat,  5 Aug 2023 21:06:37 +0000 (UTC)
Date:   Sat, 5 Aug 2023 23:06:31 +0200
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
Subject: Re: [PATCH v8 00/23] efi/x86: Avoid bare metal decompressor during
 EFI boot
Message-ID: <20230805210631.GEZM6518W3qOCYYgNK@fat_crate.local>
References: <20230802154831.2147855-1-ardb@kernel.org>
 <20230805144030.GDZM5fXvaqXBLxwXfj@fat_crate.local>
 <CAMj1kXEFC6LwNiWrGGsXot4SO0wivqN_3Yi=T9OS0XJ4=MeNew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEFC6LwNiWrGGsXot4SO0wivqN_3Yi=T9OS0XJ4=MeNew@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Aug 05, 2023 at 07:37:17PM +0200, Ard Biesheuvel wrote:
> So this is the host booting, right?

Yes.

> So is the position of the C bit perhaps getting detect incorrectly?

I don't know yet. But the evildoer is someone else:

02d47ce2ae02 ("x86/head_64: Store boot_params pointer in callee save register")

after bisection. More staring later as to why...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
