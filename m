Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733A24BEABD
	for <lists+linux-efi@lfdr.de>; Mon, 21 Feb 2022 20:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiBUSSD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 21 Feb 2022 13:18:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiBUSQA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 21 Feb 2022 13:16:00 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F39CDFFF;
        Mon, 21 Feb 2022 10:06:33 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6FFC01EC0531;
        Mon, 21 Feb 2022 19:06:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645466786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MWw/afFsOSxJd3d13rKUZHwqChPZ/A+IszeqZt9+ZxE=;
        b=Zk1raW6/fw1YdurcyqLzeJQ7rNXBWPIoUVEVWPfTnDlK2Nwh9wuLji4gF4dQ7Po3Fh4lTz
        UOJLIha0PKE4e4iR6cRUEl0q+kqm+K9Gv+Fppz5xJ2HVXKKgBiY4u3QfZGeYH6b7LHNOMA
        suVVW2daCREEY+ZHQxlrBtkZRhicKz8=
Date:   Mon, 21 Feb 2022 19:06:29 +0100
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
Message-ID: <YhPUpauLlfsPnfbr@zn.tnic>
References: <Ygz88uacbwuTTNat@zn.tnic.mbx>
 <20220216160457.1748381-1-brijesh.singh@amd.com>
 <20220221174121.ceeplpoaz63q72kv@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220221174121.ceeplpoaz63q72kv@box>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Feb 21, 2022 at 08:41:21PM +0300, Kirill A. Shutemov wrote:
> On Wed, Feb 16, 2022 at 10:04:57AM -0600, Brijesh Singh wrote:
> > @@ -287,6 +301,7 @@ struct x86_platform_ops {
> >  	struct x86_legacy_features legacy;
> >  	void (*set_legacy_features)(void);
> >  	struct x86_hyper_runtime hyper;
> > +	struct x86_guest guest;
> >  };
> 
> I used 'cc' instead of 'guest'. 'guest' looks too generic.

But guest is what is needed there. Not all cases where the kernel runs
as a guest are confidential ones.

Later, that hyperv thing should be merged into the guest one too as the
hyperv should be a guest too. AFAICT.

> Also, I'm not sure why not to use pointer to ops struct instead of stroing
> them directly in x86_platform. Yes, it is consistent with 'hyper', but I
> don't see it as a strong argument.

There should be no big difference but we're doing it with direct struct
member assignment so far so we should keep doing the same and not start
doing pointers now, all of a sudden.

> This doesn't cover difference in flushing requirements. Can we get it too?

What are the requirements you have for TDX on this path?

This is the main reason why I'm asking you to review this - I'd like to
have one version which works for both and then I'll queue it on a common
branch.

This is also why I'd like for you and SEV folks to agree on all the
common code so that I can apply it and you can both base your patchsets
ontop.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
