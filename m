Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E24070BEB5
	for <lists+linux-efi@lfdr.de>; Mon, 22 May 2023 14:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjEVMtA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 May 2023 08:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjEVMs7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 May 2023 08:48:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5DFAA;
        Mon, 22 May 2023 05:48:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 392E31FEE4;
        Mon, 22 May 2023 12:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684759726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lEvi79Gxxvx/sIBVBrhlm6IyM6SGPlhsdaMWWu+eBGw=;
        b=j5n2JGLl2PokKhR7aCRJKHIjtIlTZ2AExnbbXGFj6BAI7B2aJa2Pwd9TYM5znONq5vf7Y8
        YJKv+8P3luHLpKEQigD/Pk4oS/zNRmO8syCZwUcbfxtoPBARcNFrsFd2noo/0jX4M3fpse
        XywmrAl58ETlkzBpDeo902xCLk2fggw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684759726;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lEvi79Gxxvx/sIBVBrhlm6IyM6SGPlhsdaMWWu+eBGw=;
        b=2zvpZoK09aSf2WjE+Bxc8gE4PdywUgtYSUO+KYGuOBjxI2EZGVjWKCKVOoIJacsCFyGcji
        jROBhmgFLOx7fUDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A315D13776;
        Mon, 22 May 2023 12:48:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2vlZJq1ka2QJZAAAMHmgww
        (envelope-from <jroedel@suse.de>); Mon, 22 May 2023 12:48:45 +0000
Date:   Mon, 22 May 2023 14:48:44 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 17/20] x86: efistub: Check SEV/SNP support while
 running in the firmware
Message-ID: <ZGtkrKhxqUiTlXY0@suse.de>
References: <20230508070330.582131-1-ardb@kernel.org>
 <20230508070330.582131-18-ardb@kernel.org>
 <ca76ed3b-5835-9f1b-7e10-dd417249b7bd@amd.com>
 <CAMj1kXE+7SKVZN3p2_NXg5VeH+hbwnqwaGTj6HLE1a89QGtraw@mail.gmail.com>
 <b6192de1-26a4-a7a7-63bf-76c36f55a8ff@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6192de1-26a4-a7a7-63bf-76c36f55a8ff@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, May 19, 2023 at 09:04:46AM -0500, Tom Lendacky wrote:
> Deferring the checks is probably the safest thing to do, since that would
> match the way things are done today and known to work. I'm not sure what
> other things might pop up if we stay with this approach, for example, page
> state change calls using the GHCB MSR protocol that also don't save/restore
> the MSR value.
> 
> It is possible to audit these areas and stay with this approach, but I'm
> wondering if that wouldn't be better done as a separate patch series.
> 
> Adding @Joerg for any additional thoughts he might have around this area, too.

If I got it correctly the patch actually moves two things before
ExitBootServices:

	1) SEV features check

	2) SEV initialization

I think it makes a lot of sense to have 1) before ExitBootServices. It
allows to soft-fail in case the kernel does not support all required
SEV-SNP features and move on to a kernel which does. This check also only
needs the SEV_STATUS MSR and not any GHCB calls.

The problem is the GHCB protocol negotiation with the HV, but the GHCB
protocol is downward-compatible, so an older kernel can work with a
newer HV.

But 2) needs to stay after ExitBootServices, as it needs resources owned
by UEFI, e.g. the GHCB MSR and potentially the configured GHCB itself.
Fiddling around with the GHCB MSR while it is still owned by UEFI will
bite us in one or the other way (e.g. UEFI, before ExitBootServices, is
free to take IRQs with handlers that rely on the GHCB MSR content).

Regards,

	Joerg

