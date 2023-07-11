Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B3274E875
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jul 2023 09:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjGKH6D (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jul 2023 03:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjGKH6C (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Jul 2023 03:58:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64294E55;
        Tue, 11 Jul 2023 00:57:58 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1A0681EC0B91;
        Tue, 11 Jul 2023 09:57:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1689062276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8hrjuer04YxWdK/duzpqjijBu0TXE/n4lWk/TaUwmGM=;
        b=hXuL0QTbszg3ObEo6Xyaa/DT1AqcjObCWQv8ENFezAjfOBxKkRgYNzU6jl7S8DCZd/pv11
        yNlzF9Frh7espl74sXSO3PFYyvxfnU693acxVoSFRHlWxDHbfW6cTP5wtjvOP5Ka2h8E0R
        gVOYYcN/b24Ahn3lMCnNvstLmKP3WsI=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AZk1ot6LUQwt; Tue, 11 Jul 2023 07:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1689062273; bh=8hrjuer04YxWdK/duzpqjijBu0TXE/n4lWk/TaUwmGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IoSgZ/suG8Jah1i8/uHBBRC/TyBkuHHP0SuNCfbtnKNrV6slL1LnkqtlfLGJf3Epp
         nJlf7ShrCEsviiB5R4azEAFOT2wFhm63oFW+GHnvh+2F2SvaakEkXKmZVmOs+5wn6D
         y4p9Ow2XzF4cydJoDucL7Z4+rvtjJqV/Nrlt1eii+a4a6rXLg7sGfP7bOIyP3k1Og4
         FN0Ff9gh5VIxppdeEXXGARYMHsp2r+PlzUBAq37vUHmffG1P2E9gatlZ/66heHwdYB
         AdccJKi7FrQ2nEaNBrBIFzfwqMcpMof11q8onWgWcxY7ZVbMPq9dEx2OhT34KsuuDj
         AwszkzLYrDSa1d6ErZ6YdmeAfzeaFTaD+flXlyaoCkiiRh8Xvl7mU/3ypZ1FIfhoTn
         UOlKPrDScpGdireBFLkIvlXV+QJXlGCajOZkfic2ScouwzoQheV8jq72qIQer3RgEM
         sGknuGKBBDalpLLDguPYNgfhkLFEHYY2OUVJTzWgJ33qbHJwKxvNZWWagdLlnUffrN
         W3hkcV8P6g8IWU6CDRR3gCN16bBDRs+RttyAnvQulwyfJ964+n2181N/gjsOlBCD8h
         +vj3slfwcK2Glgz/+rweGoXjCraV97kXYGQuTUu1GlhZY2qd7depIOfz2B/DaFS8xc
         a+MC+7tdiGzfMmKDLeXqKfUo=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1F58940E00F4;
        Tue, 11 Jul 2023 07:57:34 +0000 (UTC)
Date:   Tue, 11 Jul 2023 09:57:33 +0200
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
Message-ID: <20230711075733.GFZK0LbaVA/cHUbChN@fat_crate.local>
References: <20230607072342.4054036-1-ardb@kernel.org>
 <20230607072342.4054036-7-ardb@kernel.org>
 <20230710090654.GCZKvKLh44tzlNzPcq@fat_crate.local>
 <CAMj1kXGUtm2unrpwLWCXQhoE1wEYuFgvz3u_SXDFE=SJHJdYmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGUtm2unrpwLWCXQhoE1wEYuFgvz3u_SXDFE=SJHJdYmQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jul 10, 2023 at 11:55:49PM +0200, Ard Biesheuvel wrote:
> I already did, actually, but I dropped it from this series because it
> was getting too long, and not essential for the overall goal of the
> changes.

Yeah, might wanna add it, though, for the simple reason that
compressed/head_64.S and kernel/head_64.S will otherwise differ in the
%rsi handling unnecessarily and people might wonder why.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
