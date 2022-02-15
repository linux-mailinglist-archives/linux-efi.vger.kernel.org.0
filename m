Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1399B4B6CBF
	for <lists+linux-efi@lfdr.de>; Tue, 15 Feb 2022 13:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbiBOMzC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Feb 2022 07:55:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbiBOMzC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 15 Feb 2022 07:55:02 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B6F434A2;
        Tue, 15 Feb 2022 04:54:52 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B93571EC0535;
        Tue, 15 Feb 2022 13:54:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644929686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lpJF0DPW1QUFslGQlkPrAV/yjkWVm5bvn5fjtUyMI5I=;
        b=hPdzK/P8wr/BQRHcNE7GCCG73SydOg0ztOwVWavDyYXP1xHLStzPoPF9L7G1/xyKJb03rd
        XQccaz/cSgNE76wjLP5r28HUq3WX/Wn3loTq/NL5I5SeP/lnt6u3H+pBlrNdIsElFhr/GB
        zzZ7ZiihZWxpZpJEaEE33jXMPf+JrV0=
Date:   Tue, 15 Feb 2022 13:54:48 +0100
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
Message-ID: <YguimA5Au4t2A4oj@zn.tnic>
References: <20220209181039.1262882-1-brijesh.singh@amd.com>
 <20220209181039.1262882-22-brijesh.singh@amd.com>
 <YgZ427v95xcdOKSC@zn.tnic>
 <0242e383-5406-7504-ff3d-cf2e8dfaf8a3@amd.com>
 <Ygj2Wx6jtNEEmbh9@zn.tnic>
 <20220215124331.i4vgww733fv5owrx@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220215124331.i4vgww733fv5owrx@box.shutemov.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 15, 2022 at 03:43:31PM +0300, Kirill A. Shutemov wrote:
> I don't think it works. TDX and SME/SEV has opposite polarity of the mask.
> SME/SEV has to clear the mask to share the page. TDX has to set it.
> 
> Making a single global mask only increases confusion.

Didn't you read the rest of the thread with Tom's suggestion? I think
there's a merit in having a cc_vendor or so which explicitly states what
type of HV the kernel runs on...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
