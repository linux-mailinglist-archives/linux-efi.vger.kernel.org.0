Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770B372490A
	for <lists+linux-efi@lfdr.de>; Tue,  6 Jun 2023 18:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbjFFQZy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Jun 2023 12:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238288AbjFFQZv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Jun 2023 12:25:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076811707;
        Tue,  6 Jun 2023 09:25:49 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7E4A21EC064A;
        Tue,  6 Jun 2023 18:25:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686068747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Yc8fsBs+xKPd14gOftiVwaYwObAPlOek8WdNbu4B2Xc=;
        b=QOuL9ObSvxl7i9nUuh8XAtyi9JrErbcJ9WmVYaji7xlFyIRgQPU3msr4AtfO4nDccTWoam
        02ysCMJZqU9QTLHU/ZH557iIegZXgnauZ8/fcSWNSe0TuUxG/G3uL5TAsnSm1Ub02MNryC
        lNhmZDEhMrfkhPH56jIFtohrl4yCkBs=
Date:   Tue, 6 Jun 2023 18:25:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv14 0/9] mm, x86/cc, efi: Implement support for unaccepted
 memory
Message-ID: <20230606162547.GEZH9eC9bDNkRcU+l4@fat_crate.local>
References: <20230606142637.5171-1-kirill.shutemov@linux.intel.com>
 <20230606161606.GDZH9bxhrGnFkaLl2A@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606161606.GDZH9bxhrGnFkaLl2A@fat_crate.local>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 06, 2023 at 06:16:06PM +0200, Borislav Petkov wrote:
> Why does that tdx_kvm_hypercall() thing even depend on CONFIG_KVM_GUEST?

Amending with this, obviously:

---
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 234197ec17e4..603e6d1e9d4a 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -5,6 +5,8 @@
 
 #include <linux/init.h>
 #include <linux/bits.h>
+
+#include <asm/errno.h>
 #include <asm/ptrace.h>
 #include <asm/shared/tdx.h>
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
