Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB7057F62D
	for <lists+linux-efi@lfdr.de>; Sun, 24 Jul 2022 19:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiGXR2F (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 24 Jul 2022 13:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGXR2E (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 24 Jul 2022 13:28:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5705220D
        for <linux-efi@vger.kernel.org>; Sun, 24 Jul 2022 10:28:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CBBF01FCEB;
        Sun, 24 Jul 2022 17:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658683680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wzfsiw8ZlcskU2nqSWByWEzgGhFE2hdppcQ4jWRoqD8=;
        b=a+4df5/ccPELDA7DlIpSJ9DJ3uT4qpypn9sDPB8sYkBNRJCzRVuNo/k4Oi7glwEMIfQpSq
        jr7AXeapIPpwbDDnE7LFYi9CUbIqjdRzjN8xW2gQ7cspUM24w8RmnpjU20yhNQNDfFWawH
        dJCNGWx8ocfeTL4VIDKJ9sARl31wmtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658683680;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wzfsiw8ZlcskU2nqSWByWEzgGhFE2hdppcQ4jWRoqD8=;
        b=NtHUjPQh3JpL8NQ1iohkCSQHy2AVXGmdRMPkypG+AcuVOz8oHQMTV4YanISxTkJDM7YzNE
        QzXu+9jrmygnEwAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8AC013A8D;
        Sun, 24 Jul 2022 17:28:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fIOdLCCB3WJjWAAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 24 Jul 2022 17:28:00 +0000
Date:   Sun, 24 Jul 2022 19:27:56 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH] efi/x86-mixed: leave RET unmitigated but move it into
 .rodata
Message-ID: <Yt2BHIMhXPd0cuMt@zn.tnic>
References: <20220722160612.2976-1-ardb@kernel.org>
 <CAHk-=wgBM5n_q76tTqLae0YddpzY=LX90s_wWge_JpnqjSK2YA@mail.gmail.com>
 <CAMj1kXGT7OEZc3Y6B-AcWWmec2POZFYb+UpE1eMcHuVag9LSew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXGT7OEZc3Y6B-AcWWmec2POZFYb+UpE1eMcHuVag9LSew@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Jul 24, 2022 at 10:39:45AM +0200, Ard Biesheuvel wrote:
> Fair enough. I still think it is better for general hygiene to apply
> these changes, but if there is no urgency, I'll leave this for now and
> revisit+rebase somewhere during the next cycle.

Best it would be if you do that early in the cycle so that it gets
maximum testing in linux-next.

Oh, and my compiler doesn't like it for whatever reason:

/tmp/ccLB2vIC.s: Assembler messages:
/tmp/ccLB2vIC.s: Error: invalid operands (.rodata and .text sections) for `-' when setting `.L__sym_size___efi64_thunk'
make[3]: *** [scripts/Makefile.build:322: arch/x86/platform/efi/efi_thunk_64.o] Error 1
make[3]: *** Waiting for unfinished jobs....

But otherwise, I like the direction where this is going, of us not
mapping as much into the EFI PGT. But I've said that already...

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
