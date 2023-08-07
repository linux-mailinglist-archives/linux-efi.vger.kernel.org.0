Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B54772A5F
	for <lists+linux-efi@lfdr.de>; Mon,  7 Aug 2023 18:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjHGQSp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Aug 2023 12:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjHGQSo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Aug 2023 12:18:44 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C588310EC;
        Mon,  7 Aug 2023 09:18:42 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6F64640E0196;
        Mon,  7 Aug 2023 16:18:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PV_6JIZguf5o; Mon,  7 Aug 2023 16:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691425117; bh=cs/IlFqwkgFGwfimWobu7SM66u8nYP3vjCakWjS3HwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MjXv1QODbfX07eXs4W9jlThs5gHFAVi9OIQ218foGhr+I/77c9ranLAD3T9Tjqiww
         dhaH8OO5Vriq+oSz6wC1EGbxagGJuEjkyh3nuVpqIT4QH0Dk/1ySFqc/EgWZwYlmSF
         MGsCnJo0OQQHJiPORIoKbxcxzykCHe6iuYvwv+30rMdz6LEV128CD3emgcGGTHInjj
         +mKYoOCmkrrckMOzwoWL/iH66iLf+VFAN3jgtWLI035uTWUGjKLEUdgB/IVaEwdKUM
         FzreScK4mA1iEEVzcKm2LvG/0sifCtwdCOKJfpnM2MwfWSHlVMU4UGkkgN5Bt5qGHV
         NEC7Jenqs49Yejoi3XB0040sIOcAIWw6A2jx1MUWQu8vhvjhWympC05rrzWjzuBN1B
         CYFlIz1uL04JMUltSTAgC4w04eJjx8a1xjXermULNrAhsXi80eGkOuDKT013vXjKu7
         tiThg/mtapDISjEojYaf6j+1If1+r7vuOTfyNvToeGcqOcVKW0KOZZtYqbXckYm3pu
         EFjkm50F7XjINFou+wub/aQgYFgeeLR/4BdxSZVRB9NFpd5fcnmAm4/eu/52ckKMoC
         KQzl8oJyJ1zcZ4qiM3uax5z64ymGHX4OXZJP6S49Bcse9zpPIUJ7X0rEG1GKpa/rNs
         FPZQNj4z/rX6wW98hc7Bf29U=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0C3E940E00B0;
        Mon,  7 Aug 2023 16:18:17 +0000 (UTC)
Date:   Mon, 7 Aug 2023 18:18:13 +0200
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
Message-ID: <20230807161813.GHZNEZRWkRQopkEf3o@fat_crate.local>
References: <20230802154831.2147855-1-ardb@kernel.org>
 <20230805144030.GDZM5fXvaqXBLxwXfj@fat_crate.local>
 <CAMj1kXEFC6LwNiWrGGsXot4SO0wivqN_3Yi=T9OS0XJ4=MeNew@mail.gmail.com>
 <20230805210631.GEZM6518W3qOCYYgNK@fat_crate.local>
 <CAMj1kXE+jgLztL1mQ6VDkJWfAjSJnxapoUAsvqaSQmfi=kr=hg@mail.gmail.com>
 <CAMj1kXHi8=L8e=a5ci4yQFVrc=XqqJaMNvZuPXduwaAVfmm4_Q@mail.gmail.com>
 <20230806101710.GAZM9zJjwoNKFSfWD6@fat_crate.local>
 <CAMj1kXHnA=fNNpL47OFHcEs1Kr48YCnFYVE=AX+7o1YYVmCtCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHnA=fNNpL47OFHcEs1Kr48YCnFYVE=AX+7o1YYVmCtCQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Aug 06, 2023 at 12:21:36PM +0200, Ard Biesheuvel wrote:
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=x86-efistub-cleanup-v9

Ok, boots on all my machines.

Please send it once again to the ML so that I can pick it up and have
Link: tags refer to an official submission.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
