Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DC168F492
	for <lists+linux-efi@lfdr.de>; Wed,  8 Feb 2023 18:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjBHRbC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Feb 2023 12:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjBHRa7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Feb 2023 12:30:59 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9D54FCE0
        for <linux-efi@vger.kernel.org>; Wed,  8 Feb 2023 09:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0adOUWsO7ZVtcSZJnKu8u1BiAreKIbJcwG20QisS23U=; b=JKg2v0zCYOnLwXpOz7VXicNMyV
        EWXelWVUPLjHWPUySbw/DuaopIsQYMlRfzFosl0Al75jFDq/pSfawr5j2FySEcaYPNLVmCWiqUTA3
        qoc5X/0apNnlru8TDYT78wSmQzMnhNDigSqDJjVUp0bs4M+xeKLw6dJXJRSrSvQgreDJ/1QLvC+Kf
        U94nEEAfl773hBcbIurxX8J3OSfBWHdoy2IdfU4kE1oc14mk2uO+E0Rw/ipQvfzRQayYLGkJDZckk
        lKN9NOAkU2Mw9H6czf6RIRrHaYp8PqygagxxZYT12zXnUnuL6ZCl28h0NOGpBX4lvuzLqEnyDilUo
        F8zQakyQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pPoGS-007W4w-01;
        Wed, 08 Feb 2023 17:29:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 563C4300129;
        Wed,  8 Feb 2023 18:30:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F0B6203C41EF; Wed,  8 Feb 2023 18:30:25 +0100 (CET)
Date:   Wed, 8 Feb 2023 18:30:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2 3/3] efi: x86: Wire up IBT annotation in memory
 attributes table
Message-ID: <Y+PcMTyZkeVWy8n5@hirez.programming.kicks-ass.net>
References: <20230206124938.272988-1-ardb@kernel.org>
 <20230206124938.272988-4-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206124938.272988-4-ardb@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Feb 06, 2023 at 01:49:38PM +0100, Ard Biesheuvel wrote:
> UEFI v2.10 extends the EFI memory attributes table with a flag that
> indicates whether or not all RuntimeServicesCode regions were
> constructed with ENDBR landing pads, permitting the OS to map these
> regions with IBT restrictions enabled.
> 
> So let's take this into account on x86 as well.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org> # ibt_save() changes
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Looks about right; would be lovely if someone with a fresh enough
firmware image could actually test this though..

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
