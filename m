Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D42C4B6F07
	for <lists+linux-efi@lfdr.de>; Tue, 15 Feb 2022 15:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbiBOOl0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Feb 2022 09:41:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiBOOlZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 15 Feb 2022 09:41:25 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB872102429;
        Tue, 15 Feb 2022 06:41:14 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 165F71EC0518;
        Tue, 15 Feb 2022 15:41:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644936069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SHIy0JOracxSZUX44JRM2zOEiCF50L0BbqI7lPnq/lg=;
        b=D+daksFOoyoSLR0f2z09XUHDSNPn8LQA3tsgm5xo8bZfaH0AXftJ1PbhtIB8uFRTlDgeN3
        IhZrPaWjYY55BMCz3b9qcWUAeCmuhJ5xY1m5uq066+kwXprdzCQI0pJsdrNDTp0Rcll5OI
        qAHnm6YoNPR0BXK0WMHqnRqjx57sXwA=
Date:   Tue, 15 Feb 2022 15:41:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v10 21/45] x86/mm: Add support to validate memory when
 changing C-bit
Message-ID: <Ygu7hotAeHAFWn6Y@zn.tnic>
References: <20220209181039.1262882-1-brijesh.singh@amd.com>
 <20220209181039.1262882-22-brijesh.singh@amd.com>
 <YgZ427v95xcdOKSC@zn.tnic>
 <0242e383-5406-7504-ff3d-cf2e8dfaf8a3@amd.com>
 <Ygj2Wx6jtNEEmbh9@zn.tnic>
 <20220215124331.i4vgww733fv5owrx@box.shutemov.name>
 <YguimA5Au4t2A4oj@zn.tnic>
 <20220215131522.l3xytgmy4ufrgnlb@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220215131522.l3xytgmy4ufrgnlb@box.shutemov.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 15, 2022 at 04:15:22PM +0300, Kirill A. Shutemov wrote:
> I have no problem with cc_vendor idea. It looks good.

Good.

> Regarding the masks, if we want to have common ground here we can add two
> mask: cc_enc_mask and cc_dec_mask. And then

If we do two masks, then we can just as well leave the SME and TDX
masks. The point of the whole exercise is to have simpler code and less
ifdeffery.

If you "hide" how the mask works on each vendor in the respective
functions - and yes, cc_pgprot_dec/enc() reads better - then it doesn't
matter how the mask is defined.

Because you don't need two masks to encrypt/decrypt pages - you need a
single mask but apply it differently.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
