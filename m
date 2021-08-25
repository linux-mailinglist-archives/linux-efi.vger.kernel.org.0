Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5089F3F7800
	for <lists+linux-efi@lfdr.de>; Wed, 25 Aug 2021 17:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbhHYPI2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Aug 2021 11:08:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44856 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbhHYPIR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Aug 2021 11:08:17 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BC62A2220A;
        Wed, 25 Aug 2021 15:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629904049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/d2RSJXoiYvwpdqa3PewAfBc2yP4smGwYb0V6Y+Upzo=;
        b=TnJjPPz5sXKClNliDjj4T4y6yB7BO3Bnlji44QSDi6x9FmXeHnuOl2sw2OT7lHgAFFMR1H
        nvXRGufQSECWgwOALkzxELpxvuYmk1PMMKiRVIWRU5rCa0ee71bnhrInvklZyqdKSMURhW
        V138+hugf8845aj1TAlhbsJ2PIN3ja8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629904049;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/d2RSJXoiYvwpdqa3PewAfBc2yP4smGwYb0V6Y+Upzo=;
        b=oSObJPLqgQ8+K13tqXXWh+49QBGbp+vhvWoO7oX+EBb3fzHcO9HiouywQud9QIG8HYHAQu
        mrZcEQgt8+sd4CDw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 91F4113A85;
        Wed, 25 Aug 2021 15:07:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id xVtWIbBcJmGIVAAAGKfGzw
        (envelope-from <jroedel@suse.de>); Wed, 25 Aug 2021 15:07:28 +0000
Date:   Wed, 25 Aug 2021 17:07:26 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 23/38] x86/head/64: set up a startup %gs for
 stack protector
Message-ID: <YSZcrtqExehVwvhf@suse.de>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-24-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820151933.22401-24-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 20, 2021 at 10:19:18AM -0500, Brijesh Singh wrote:
>  void __head startup_64_setup_env(unsigned long physbase)
>  {
> +	u64 gs_area = (u64)fixup_pointer(startup_gs_area, physbase);
> +

This breaks as soon as the compiler decides that startup_64_setup_env()
needs stack protection too.

And the startup_gs_area is also not needed, there is initial_gs for
that. 

What you need is something along these lines (untested):

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d8b3ebd2bb85..3c7c59bc9903 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -65,6 +65,16 @@ SYM_CODE_START_NOALIGN(startup_64)
 	leaq	(__end_init_task - FRAME_SIZE)(%rip), %rsp
 
 	leaq	_text(%rip), %rdi
+
+	movl	$MSR_GS_BASE, %ecx
+	movq	initial_gs(%rip), %rax
+	movq	$_text, %rdx
+	subq	%rdx, %rax
+	addq	%rdi, %rax
+	movq	%rax, %rdx
+	shrq	$32,  %rdx
+	wrmsr
+
 	pushq	%rsi
 	call	startup_64_setup_env
 	popq	%rsi


It loads the initial_gs pointer, applies the fixup on it and loads it
into MSR_GS_BASE. 
