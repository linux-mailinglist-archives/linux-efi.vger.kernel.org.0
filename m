Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12F276B4EC
	for <lists+linux-efi@lfdr.de>; Tue,  1 Aug 2023 14:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbjHAMl0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Aug 2023 08:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjHAMlY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Aug 2023 08:41:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6701FDC;
        Tue,  1 Aug 2023 05:41:23 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EF5571EC0532;
        Tue,  1 Aug 2023 14:41:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690893682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wdD0gmcxbWFimRZiZzuzXYFet8aJLbJrBnDDYA2OVKk=;
        b=o5CxPxzn0sx5Cic4beP+R5gan3i+Fubx00C3bHtGM+CVf50tRwBanEc8j6cERxQR6Yd0Zz
        jtTXYyEWHiGJ0m6sxy1sABifiZKx6idI21LqJFauH71a9R3btmvoO8X43lzimkNHyYIhTL
        a0H/GkaVZGIBgefbzjVVDNsjdsTP+Q8=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9m7qIA0UC0oz; Tue,  1 Aug 2023 12:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690893679; bh=wdD0gmcxbWFimRZiZzuzXYFet8aJLbJrBnDDYA2OVKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g3pnl47MDlrYeocpp0JSPEjdmlY2ERB6VXoYJpDVtAGtVvY0GvqFLaz+6lKp2Sdyi
         bgBmJd4LmwI+wv8+ooTfS4HMaH8UmvcsYM2Gog4qwvb8jCaBEQZeUBJLiPclx8xWvQ
         vGZaVi2JVRlIDq8NCWTkxY813XpfjS/v5lgt7p915YXIYJJzDD01r6dNLlMohdUvhz
         aKf6LI4gRabvMG5Ft+LzyA7jK+/gTGLn6O13L4D9HQM8aOX+pCpfcWHbHEYjkCEVJF
         mr8YXvvYJGexVgX2GyrCF/DQM0KxO2Wro1Hxcznc0/uLaVtN90SbLYo33tHL6ng5th
         0051QjG9XUd3gJ7rbcPFyMbJyjYyNVTbZoDQmRvy9+eq6yok9NSMl6L2jVOA0jZmy+
         MN7g3FRcbhMwS9FdPjAH/ynAgqnKXRhsg/rXBCmLrM2FI8iiASGHOILoBoAgIwOUap
         ynUNVhBK31FBC74A5kbHcYttg/no922JoimON87dd4Fa+PCRF4hEXsAnKNA62HCxep
         1DhoXioBKQwNzAn5KhUGjnZpMhHtce3oBYjuuixZYBYEGYyEa3bY/MeCAMLK4pPG89
         Vx6MA+31WUNRLksV03Ff/xT9PsrZSKPxXk1ZEY8QUWNRPSLTN9hlHZ3HDVMhjCTTtD
         mO3ILHjinbya2p6J75NhUtTc=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CA40440E01CE;
        Tue,  1 Aug 2023 12:40:59 +0000 (UTC)
Date:   Tue, 1 Aug 2023 14:40:54 +0200
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
Message-ID: <20230801124054.GGZMj9VrrB+4a4NiZs@fat_crate.local>
References: <20230728090916.1538550-1-ardb@kernel.org>
 <20230728090916.1538550-15-ardb@kernel.org>
 <20230801120827.GFZMj1uzNMDs2gIi1f@fat_crate.local>
 <CAMj1kXF+=W_oe7MS87rWdJ_z555iz2A8iR42fJ1mwZ+bgCgjmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXF+=W_oe7MS87rWdJ_z555iz2A8iR42fJ1mwZ+bgCgjmw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 01, 2023 at 02:11:21PM +0200, Ard Biesheuvel wrote:
> Removing it breaks the build for !CONFIG_X86_5LEVEL

How come?

$ grep 5LEVEL .config
# CONFIG_X86_5LEVEL is not set

and it builds fine here.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
