Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E9277102D
	for <lists+linux-efi@lfdr.de>; Sat,  5 Aug 2023 16:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjHEOlE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Aug 2023 10:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHEOlD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 5 Aug 2023 10:41:03 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE691720;
        Sat,  5 Aug 2023 07:40:59 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4DB6340E019D;
        Sat,  5 Aug 2023 14:40:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id u9Mjo4P_u7yg; Sat,  5 Aug 2023 14:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691246454; bh=gzr6bNjG+kYA+0nlV35Mz03INEgc4t8Z7CMMa8S45rA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aCXtD9hrZZ5sX/r+L/aHTeQApB6B4PNkUOHWMwCtJEtudlKxqao8SvFz3z+HGbDb0
         Efq9Z1GlDq79YlyYhFEGEYG+w6WvXXgsqIafTo+mvTIx39LaZEIlUFbfAEgRz/pPo4
         hhdlbwuqLl3E0qKDcem0+4kZHkD92IPgVQtFyUndt/v2Fhp2hUzaSqlpdAk+lSMWP+
         rAZHsXL4XGkiPGVN68PLtPYSQrdp28e6GksvVfZa//F7ylEJ5nXAG5vhSGJqlgPwhJ
         X0hpopm4Tw4Iad7ZGX8I9dHEm95neSmbdO49+beiLKFIFG0Jj+eV5iNRNXc7YmWpj4
         /71zMaFQI1grD9xuUxxSVrkV1eXuU0IbTT2B+FIWS53ZVPalUFwCKCK9vXJJTpq/C/
         ZVrCPnPBExSD4aVi5GnPudXHOaYMxsT/OX658rKKECpCpXa/5mb0h/upZAH+SR4C8x
         Ps7OeKRnCZxjxPRHwZU23h8OFoVFidpEmSh5vG0xpJrPr0aBY6dnDqQQLYReK/AQcx
         LlAQb/rGK74Y2PgJH3Rj+XqyYr4/SIoWYC2Eypj7dAhil4mgfwpgmrx9V2KgkhVcpx
         gUnkERWwKeqcg+6MnQ2CHchMhCkC5Lkuh6T9P+4eHJe5SRpXWTt8M9QdZu/o1ZafP7
         GRw8NjjY5F0OpOQ7xHfF3kYk=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A181040E00B2;
        Sat,  5 Aug 2023 14:40:35 +0000 (UTC)
Date:   Sat, 5 Aug 2023 16:40:30 +0200
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
Message-ID: <20230805144030.GDZM5fXvaqXBLxwXfj@fat_crate.local>
References: <20230802154831.2147855-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230802154831.2147855-1-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 02, 2023 at 05:48:08PM +0200, Ard Biesheuvel wrote:
> Update the x86 boot path to avoid the bare metal decompressor when
> booting via the EFI stub. The bare metal decompressor inherits the
> loader's 1:1 mapping of DRAM when entering in 64-bit mode, and assumes
> that all of it is mapped read/write/execute, which will no longer be the
> case on systems built to comply with recently tightened logo
> requirements (*).
> 
> Changes since v7 [10]:

My Zen1 box fails booting with those. It is related to memory encryption
because if I supply "mem_encrypt=off", it boots.

The failure is (typing it off from the video from the BMC):

/dev/root: Can't open blockdev
VFS: Cannot open root device "UUID=..."
Please append a correct "root=" boot option;
...

I'll bisect now but it is pretty clear which one is the culprit.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
