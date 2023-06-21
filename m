Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B7373822D
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jun 2023 13:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjFULJ2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Jun 2023 07:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjFULJZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Jun 2023 07:09:25 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683009B;
        Wed, 21 Jun 2023 04:09:24 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9BFBC1EC0645;
        Wed, 21 Jun 2023 13:09:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687345762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dW10WzO/1D1df+c5COuWituJ1H1J79DUe0LfeJ0bU1c=;
        b=dpEnioDv7ovBtKQfZ7wxK6DT7xfn47sqTKDsed0UFc+/GswtEoTwj5hL7S9Pnd/yB6jAGF
        uZvtpoAf0/ngE01Z3FWKk+/odbnqn5t6dWO0OduiC/3L5SZQBwQcb0K3mze5hA6r+1XxLI
        BULR4iuYScPkWdAJi/at72k17yqgP3c=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FHFnIBtczH5v; Wed, 21 Jun 2023 11:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687345758; bh=dW10WzO/1D1df+c5COuWituJ1H1J79DUe0LfeJ0bU1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G8Ic9iU9eL/U44nJG0zZRt/DzhRRg+4nw2s7UAUE9IIRyPJKGgN8unciTBIZ7riDN
         Kg6VYIsyEtj+xC3t1oPjPgE24bgeVdUciREBFgQgY0WLGkIigXnhOTqV7UAvfHAIF5
         ImPivRpBsWt4UPqGqmFtFB49JPzbtCjd4mVOHIVsoURVf1o6oH+ksZvSCyuGu3svws
         Iw3aWZXvY5whdHmxKeVe0iQl4tyU7KIZKxFMHTNwfh7/kAQMgS6OpbvXNVdGeFfSIj
         BV8l2r4RzgSg571NfSCx5Qeo4AX0Unn2PbNRNTQw4J35iGe1345hffB8DMy2JphCDj
         MTDbFdvIPENbXeKAVS66aA2a5F+f1ertw6ONZyEf5mCtnj4GkM6ujA7gNS2eGUpJRy
         kW5390pUCZx/RxlbUSlxgxmtydUpyKRJ3f9m8O69UqtmXkjAh5QqPR/ZQdCbXMeSsb
         AiR7bJEQ2LFbpfjaEAgTDs539ArarVFM0KMybQdey6YO1eY3ZmK9YlnECL+aHBHuml
         Lt8f3mnhCNOf/9e+mQ8ak01HIOiyKoNWdD88hR3bMUgg6D7YYBzHNAkbpqtk7/2K9n
         vRhIqjtIKVEfQIcOAUvimNUemIbt5IQLhuFsKeShB/obgfMa1n7mdbnICphbztqa/B
         YWbGx3kVCF7ZaCnK1ounlSEo=
Received: from zn.tnic (p200300ea971Dc592329c23FffEA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c592:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4DDA540E019B;
        Wed, 21 Jun 2023 11:08:59 +0000 (UTC)
Date:   Wed, 21 Jun 2023 13:08:52 +0200
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
Message-ID: <20230621110852.GAZJLaRAuGBCc5R4yb@fat_crate.local>
References: <20230607072342.4054036-1-ardb@kernel.org>
 <20230607072342.4054036-6-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230607072342.4054036-6-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 07, 2023 at 09:23:27AM +0200, Ard Biesheuvel wrote:
> The 32-bit decompressor does not actually use a global offset table
> (GOT), but as is common for 32-bit position independent code, it uses
> the magic symbol _GLOBAL_OFFSET_TABLE_ as an anchor from which to derive
> the actual runtime addresses of other symbols, using special @GOTOFF
> symbol references that are resolved at link time, and populated with the
> distance between the address of the magic _GLOBAL_OFFSET_TABLE_ anchor
> and the address of the symbol in question.
> 
> This means _GLOBAL_OFFSET_TABLE_ is the only symbol whose actual runtime
> address needs to be determined explicitly, which is one of the first
> things that happens in startup_32. However, it does so by taking the
> absolute address via the immediate field of an ADD instruction (plus a
> small offset), which seems to defeat the point.
> 
> Fortunately, the assembler knows that _GLOBAL_OFFSET_TABLE_ is magic,
> and emits a special relative relocation instead, and so the resulting

Which special relocation do you mean?

This guy:

Relocation section '.rel.head.text' at offset 0x3a0 contains 12 entries:
 Offset     Info    Type            Sym.Value  Sym. Name
00000010  00000d0a R_386_GOTPC       00000000   _GLOBAL_OFFSET_TABLE_

?

In any case, this thing came from

a2c4fc4d4e2c ("x86/boot: Remove run-time relocations from .head.text code")

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
