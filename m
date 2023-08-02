Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A63F76CAE0
	for <lists+linux-efi@lfdr.de>; Wed,  2 Aug 2023 12:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjHBKc3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Aug 2023 06:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjHBKcL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Aug 2023 06:32:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D7B526E;
        Wed,  2 Aug 2023 03:27:47 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 83EEE1EC0136;
        Wed,  2 Aug 2023 12:26:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690971987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=E5SRgg90inBEHJEYH3h/WS+6AGYSjZhAFoNjFVUNv6w=;
        b=hzBqcOno0YKB8w61ox0jTvyJ/PcjeW/EFpvzrOk2DwYRf1zXhQottn30NO2AGxW0lnkNcv
        GS/vcCAaaoKHZ+CDNZ+1+zC6ot3XSkkqpjI5IZIseo1gps2dBh2x3CV+aS6Pk0ycqUlnI/
        iG6WBdBKrMG5d7J4GW2Kq71d1Y2BOL4=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eFHyyk35vKiQ; Wed,  2 Aug 2023 10:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690971984; bh=E5SRgg90inBEHJEYH3h/WS+6AGYSjZhAFoNjFVUNv6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y1WIpX4xiDHoRO8dgoqMTctvLS0hqFszF5bom0mw1qdnVPYgoFRRe9Tih2i3RsT2Y
         H+zR8T49rcmkdRROdGOGep62KhdxCby4vKbs1gMHqd1WkYnIuQsZFfy1ITkgCXCCaI
         Ntb7Fze9hlgU0Y+dBL7CO//P8QJsqz1aFTTsPvxwN5rs9grjPBdlgr8scRT37S3x67
         sPB0raYbFBzhxt3Ag687ss8Fu/Jr+qBvr6OZXpB3rmU/G0ISNjkm1DTa9z8t6Qfv1b
         NDFV5bmutb4jpwkiU3cEkhhyXQ+I1GjEgjboe6Z9C1d+OcqbZVA+jCUgVzefbjEgbc
         HxLF9otvRyc1Yk+Vzu/OttYxJXwTRuNcI5k3GsxsR11+7gJBGD8TiWgNytTOU2IXdW
         xEkDPiZ9/B+WAAV6hJQ9yZntXq6LgJSs7T0BB4lQXtGneSKDuDkNwlLp7TUVAoTbG0
         naylcIcbteHB61rqRE4BTTmzZRF7g9C01znxwcBdRCowuh7SCoNVRb0uLhSjdh/bS6
         GOaPGC6rtwqfInTFZRMdVrlvYMHAvLQprH2w774d1G/WhFAahVESf4w1XjA7i1+wU6
         Gj+gMNdc9TlprMFKXbqXiSTj5diZwPeS6JatBO5QVGzUnxROu8XWUb7+xoHj4N9UhP
         MKWV4r+yWcHJGmoDB8goJES4=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8FEDC40E01D3;
        Wed,  2 Aug 2023 10:26:05 +0000 (UTC)
Date:   Wed, 2 Aug 2023 12:26:00 +0200
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
Subject: Re: [PATCH v7 22/22] x86/efistub: Avoid legacy decompressor when
 doing EFI boot
Message-ID: <20230802102600.GIZMovOIUDAJAXu0F5@fat_crate.local>
References: <20230728090916.1538550-1-ardb@kernel.org>
 <20230728090916.1538550-23-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230728090916.1538550-23-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jul 28, 2023 at 11:09:16AM +0200, Ard Biesheuvel wrote:
> The bare metal decompressor code was never really intended to run in a
> hosted environment such as the EFI boot services, and does a few things
> that are problematic in the context of EFI boot now that the logo
> requirements are getting tighter.

Please spend a sentence or two explaining those. After some time has
passed, no one will remember what that tightening of the requirements
was.

So yeah, other than those minor nitpicks, I like the thing, all in all.

Pls send v8 so that I can run it here on my machines. A git branch would
be cool too.

As to merging this, I presume you want it to go through tip?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
