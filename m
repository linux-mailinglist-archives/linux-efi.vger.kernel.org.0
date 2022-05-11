Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA0E5228D4
	for <lists+linux-efi@lfdr.de>; Wed, 11 May 2022 03:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiEKBRW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 May 2022 21:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238832AbiEKBRV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 May 2022 21:17:21 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2112D381B8
        for <linux-efi@vger.kernel.org>; Tue, 10 May 2022 18:17:20 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id q130so686327ljb.5
        for <linux-efi@vger.kernel.org>; Tue, 10 May 2022 18:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l/R7CNjWmMZ859kdXkriliqHFZFmcdN2UKowY7vVOHU=;
        b=8CJByluZYe0dkhytOZ7LANy/Q36T2SzxDWXpHLGeWnfxyvns0y176nq5wqABdl8MuS
         8JWwhkw/8Dz/zjo0vYLE6X4ieGVgty19A6fmFFJfTAkZf0XwfmaUvEBa51chzTSw2fNk
         NCZFjZAzOuQZeVDNUshWB0ME+BKf6rAkRWyRi2suCa4HnC5cIEI70C8pbRMMhYKfUACy
         lHeDeT9I/k+fOz1ysSaU8nlyyAjEfuSDDWejsXcoXUidz55t1Wl6dZHJV9vvCP+L3IFs
         RWxkEh2zXcgX0WJ+D7S89UL9SGee8sjbbN4mdh9bgMFty7a0McfOFAswPU9H9kpsEhbS
         0otA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l/R7CNjWmMZ859kdXkriliqHFZFmcdN2UKowY7vVOHU=;
        b=NAi95QrXVqtnzot4U/CPa0yOK2HV3fbCDHHXqGDaP5j/e4pFlYQ+IKkZrFaHf6/4JY
         xmDOpKh+awSjLELsSkpBvXozakkkBfzlniA3hrurDBRcHu1zVaCIer2D3e2OF8gOtYVj
         pWFWvNk2yRK4ZSXWAqYLGyfW2k7CWeSRmWwKeqFNP2mi9K0lL4IhUH5G2KElyb5yj3Tr
         76d8phDD05e3gs8FaX2tN1/cgE/fJUYW5pUNxR3UKUDcs3AC6J64E/P2uIsGxAny3tnm
         S+HklrgJxzfeedsSs911iODZz4Dip5aIIgrY5VNyUeOJpWKryq7nXDL1soCfTPUr4AQI
         hGiw==
X-Gm-Message-State: AOAM531UXGr0U8pVizGVlXhvdTvjpOoDSJjRXkMCLH6MQ/LvDY0qdwS9
        rAnKzlefyMJp0IA9kVqpS5hlvg==
X-Google-Smtp-Source: ABdhPJyrXOYBkxfOLvXU9Mn81RSN5B1FseXt9b41D13lneI6qmBsXWNhAHs+SC3qXiT0Ejz37PQkVA==
X-Received: by 2002:a2e:a810:0:b0:250:a19f:8b30 with SMTP id l16-20020a2ea810000000b00250a19f8b30mr14868052ljq.397.1652231838459;
        Tue, 10 May 2022 18:17:18 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c20-20020ac25f74000000b0047255d21187sm62003lfc.182.2022.05.10.18.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 18:17:17 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 78BFE104757; Wed, 11 May 2022 04:19:06 +0300 (+03)
Date:   Wed, 11 May 2022 04:19:06 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
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
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 10/12] x86/tdx: Unaccepted memory support
Message-ID: <20220511011906.el4m54fns7ilh7fr@box.shutemov.name>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-11-kirill.shutemov@linux.intel.com>
 <YnOjJB8h3ZUR9sLX@zn.tnic>
 <20220506204423.gu6jrb53kmuxze5r@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506204423.gu6jrb53kmuxze5r@box.shutemov.name>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, May 06, 2022 at 11:44:23PM +0300, Kirill A. Shutemov wrote:
> > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > index 7021ec725dd3..e4c31dbea6d7 100644
> > > --- a/arch/x86/Kconfig
> > > +++ b/arch/x86/Kconfig
> > > @@ -885,6 +885,7 @@ config INTEL_TDX_GUEST
> > >  	select ARCH_HAS_CC_PLATFORM
> > >  	select X86_MEM_ENCRYPT
> > >  	select X86_MCE
> > > +	select UNACCEPTED_MEMORY
> > 
> > WARNING: unmet direct dependencies detected for UNACCEPTED_MEMORY
> >   Depends on [n]: EFI [=y] && EFI_STUB [=y] && !KEXEC_CORE [=y]
> >   Selected by [y]:
> >   - INTEL_TDX_GUEST [=y] && HYPERVISOR_GUEST [=y] && X86_64 [=y] && CPU_SUP_INTEL [=y] && X86_X2APIC [=y]
> > 
> > WARNING: unmet direct dependencies detected for UNACCEPTED_MEMORY
> >   Depends on [n]: EFI [=y] && EFI_STUB [=y] && !KEXEC_CORE [=y]
> >   Selected by [y]:
> >   - INTEL_TDX_GUEST [=y] && HYPERVISOR_GUEST [=y] && X86_64 [=y] && CPU_SUP_INTEL [=y] && X86_X2APIC [=y]
> 
> Ughh. Any ideas how to get around it? (Except for implementing kexec
> support right away?)

I reworked this to boot-time kexec disable.


> > Also, it doesn't need to be bool - you can simply return accept_size on
> > success and 0 on error so that you don't have an I/O argument.
> 
> So on the calling side it would look like:
> 
> 	accepted = try_accept_one(start, len, PG_LEVEL_1G)
> 	if (accepted) {
> 		start += accepted;
> 		continue;
> 	}
> 
> And the similar for other levels. Is it really better?

JFYI, I've reworked it as

		accepted = try_accept_one(start, len, PG_LEVEL_1G);
		if (!accepted)
			accepted = try_accept_one(start, len, PG_LEVEL_2M);
		if (!accepted)
			accepted = try_accept_one(start, len, PG_LEVEL_4K);
		if (!accepted)
			return false;
		start += accepted;

looks good to me.

-- 
 Kirill A. Shutemov
