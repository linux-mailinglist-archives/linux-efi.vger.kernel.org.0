Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1964D76B3D8
	for <lists+linux-efi@lfdr.de>; Tue,  1 Aug 2023 13:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjHALwV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Aug 2023 07:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjHALwT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Aug 2023 07:52:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D15C184;
        Tue,  1 Aug 2023 04:52:18 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E19E91EC04C0;
        Tue,  1 Aug 2023 13:52:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690890736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9UpLvNUXcMFhIy3aYZgRAudsyr5ZvCGx753qbrrnVHw=;
        b=UqC+I6E2aLUVvEem3eOwrNtrraSK1fyQ7gAZzW573qigvXSqXh56Yiynbhe/vAh2k6sAXC
        5sRZqs6aQ6U+ruF6gy5THehTfTnNZqr5e1RExLuxYQ8aUqARIgpgNjjBomBo38MFwMzJbv
        Aj1Ml62hJfrAUv+NJuw6u44cUfE3fUU=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hl2nKTKgNP8z; Tue,  1 Aug 2023 11:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690890734; bh=9UpLvNUXcMFhIy3aYZgRAudsyr5ZvCGx753qbrrnVHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YyU9E4dem72Z409Oyy2mVJ0cCAYIr9RwenpG0YtqbEQRCzc4vbzO1ggS18FTu57nI
         9QWYB9SvlgCf/MZrK5nOaqHW+Y4qeGtLpNgNEfkREHvq70NsvPNKkTANt0zEJ++mNo
         fr6mnnw+1qpT02LwJedFSaeWUyhphCK0mqMWibW5Ca73CWpVsH9CkfzH9GKEWjQ5Yi
         6Ghh8wciuNM7MuG7neG/8d0ualehzXxtxs3L5inAvu2dq/jKC4ZhGuwlXm5DOo6QXr
         SbFLolm2uXfVO1AxD9NIc0/FBy+FexWjvl0JMlL5rJscldoPKscM6uokq4Q9zTqYyD
         q9JGX7b7qITKeI1uqXS8Hd18wTtR3pT6I3AZNLuY2sUUs6x/hZxUFGCsgxBQab5vbV
         5TodOpjsA4t8XfM029ncNNIdSUmLsttQ2PyrLXhixiyTVlydlt4GWhrum2ra06LaQE
         kyTsX7vUihA4qrYfs96tx4J/neG2I24Hn5jaPnp1yNOvXqhx5GLbnhMhBM4OBoD65H
         2tuxHKmxXV5aPLgInWaCsvphabVEKxizi93xqQGzT2zzKndFZsZNIifZaj8bZFmt1m
         /6QkExqXTbP0tHNFV6kfnb3UnIH6s94XrP0AwUSMWjXsZ9joWX3zckTynhymiRj+I/
         T2mBix7p3HId2DJWzt+NWEO8=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 53BFA40E0184;
        Tue,  1 Aug 2023 11:51:55 +0000 (UTC)
Date:   Tue, 1 Aug 2023 13:51:54 +0200
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
Subject: Re: [PATCH v7 12/22] x86/decompressor: Call trampoline directly from
 C code
Message-ID: <20230801115154.GFZMjx2gx6+Pgoe1XT@fat_crate.local>
References: <20230728090916.1538550-1-ardb@kernel.org>
 <20230728090916.1538550-13-ardb@kernel.org>
 <20230801114542.GEZMjwZne986ZxI6eG@fat_crate.local>
 <CAMj1kXEyApdRYNmn7Px=faANXv6JXXTAvdPUToy3-H1UZg6-eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEyApdRYNmn7Px=faANXv6JXXTAvdPUToy3-H1UZg6-eQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 01, 2023 at 01:48:52PM +0200, Ard Biesheuvel wrote:
> configure_5level_paging()? At least, that conveys to some extent that
> nothing will happen unless the hardware supports it to begin with.

Yap, and it says what it does exactly.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
