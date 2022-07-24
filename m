Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FA657F6B3
	for <lists+linux-efi@lfdr.de>; Sun, 24 Jul 2022 21:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiGXTRw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 24 Jul 2022 15:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGXTRv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 24 Jul 2022 15:17:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E327E003
        for <linux-efi@vger.kernel.org>; Sun, 24 Jul 2022 12:17:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 54B8A1FD9A;
        Sun, 24 Jul 2022 19:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658690269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vl6lZOjOEFjROV8d3eQcQSZkZEYmBxouwT7yKgBmhIE=;
        b=cUeJztvCUz7tJ11JPxK1cf4IYJfKe/YMeSURBo4pGkkpgJ11BUA5n/ppPNxdAegIue2z+v
        Oo9beS0ay1u0G9MsZ3HQd/4WndSGbEKQ851ZbiEXWYLDByXcXtXt0ObWyfuTR695+49ZqD
        vThTEBRqIwDgJcM64ippSiWbphlwSnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658690269;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vl6lZOjOEFjROV8d3eQcQSZkZEYmBxouwT7yKgBmhIE=;
        b=ywegGjTRhNY8OzxHPwAKWmOjUrBq94xz1vri1yLr7ruS9ooOUMoC+eVZoHaL3hox/8Zpu9
        WN8NfJwtEqqb1FBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 47C1B13A91;
        Sun, 24 Jul 2022 19:17:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cq1+Ed2a3WLydwAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 24 Jul 2022 19:17:49 +0000
Date:   Sun, 24 Jul 2022 21:17:44 +0200
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
Message-ID: <Yt2a2P69i8pHRO97@zn.tnic>
References: <20220722160612.2976-1-ardb@kernel.org>
 <CAHk-=wgBM5n_q76tTqLae0YddpzY=LX90s_wWge_JpnqjSK2YA@mail.gmail.com>
 <CAMj1kXGT7OEZc3Y6B-AcWWmec2POZFYb+UpE1eMcHuVag9LSew@mail.gmail.com>
 <Yt2BHIMhXPd0cuMt@zn.tnic>
 <CAMj1kXEM2tXxCqcjDDNSS_OHsnJ1XTDNWBGdfFc-4zKJKpkTXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXEM2tXxCqcjDDNSS_OHsnJ1XTDNWBGdfFc-4zKJKpkTXg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Jul 24, 2022 at 08:34:36PM +0200, Ard Biesheuvel wrote:
> Are you sure you fixed up the conflict correctly? It seems the
> __efi64_thunk end marker ends up in .rodata in your case.

Yep, I f*cked up the merge even if it was pretty easy in meld - sorry
about that.

Now it is correct but it complains differently:

vmlinux.o: warning: objtool: efi_thunk_query_variable_info_nonblocking+0x1ba: unreachable instruction

$ ./scripts/faddr2line vmlinux.o efi_thunk_query_variable_info_nonblocking+0x1ba
efi_thunk_query_variable_info_nonblocking+0x1ba/0x330:
efi_thunk_query_variable_info_nonblocking at /home/boris/kernel/linux/arch/x86/platform/efi/efi_64.c:787
(inlined by) efi_thunk_query_variable_info_nonblocking at /home/boris/kernel/linux/arch/x86/platform/efi/efi_64.c:769

and looking at the asm, it points to:

# 0 "" 2
#NO_APP
	movq	efi(%rip), %rax	# efi.runtime, efi.runtime
	movl	12(%rsp), %r8d	# %sfp, prephitmp_87
	leaq	16(%rsp), %r9	#,
	movl	%r15d, %ecx	# _104,
	movl	%r14d, %edx	# _95,
	movl	%ebp, %esi	# attr,
	movl	76(%rax), %edi	# _30->mixed_mode.query_variable_info, _30->mixed_mode.query_variable_info
	call	__efi64_thunk	#
#APP
# 787 "arch/x86/platform/efi/efi_64.c" 1

1:	movl %r12d,%ds			# __val		<---

this here, after the __efi64_thunk call, which is that segment restoring
after the __efi_thunk call:

	loadsegment(ds, __ds);

Weird, I don't see why though - that should be reachable.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
