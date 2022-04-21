Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B3A509FA5
	for <lists+linux-efi@lfdr.de>; Thu, 21 Apr 2022 14:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384575AbiDUMb5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 21 Apr 2022 08:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238064AbiDUMb4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 21 Apr 2022 08:31:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6541030F5F;
        Thu, 21 Apr 2022 05:29:07 -0700 (PDT)
Received: from zn.tnic (p200300ea971b581b329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:581b:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CB2C81EC013E;
        Thu, 21 Apr 2022 14:29:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650544141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rpANVynhcG144hvijIFDyM1O4oiCFkqKYsRr7ZIqYwU=;
        b=OH4G7xGXALG7wCEGOI/kzTVXZWpoXlYUzCe1NPX2OMKEVd/nr+szvIV0KGAbMtARNINPnD
        Wa8xdBQ3ddmnVoJ0qzvL8K0/Xto1drh11cFCZSQ8QUV4xcfP7VTp7o0kLsoVNtwiFFbH9V
        C3Z+oWf9ngW2zLanijYUOe0+sh50M7Y=
Date:   Thu, 21 Apr 2022 14:29:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Michael Roth <michael.roth@amd.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 0/8] mm, x86/cc: Implement support for unaccepted memory
Message-ID: <YmFODfWn8pBiSjFn@zn.tnic>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <95eabe79-a13b-79b1-1196-407920531f20@intel.com>
 <20220409234458.ysisolzd7hktpfjc@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220409234458.ysisolzd7hktpfjc@box.shutemov.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Apr 10, 2022 at 02:44:58AM +0300, Kirill A. Shutemov wrote:
> On Fri, Apr 08, 2022 at 10:02:13AM -0700, Dave Hansen wrote:
> > On 4/5/22 16:43, Kirill A. Shutemov wrote:
> > > Patches 1-6/7 are generic and don't have any dependencies on TDX. They
> > > should serve AMD SEV needs as well. TDX-specific code isolated in the
> > > last patch.
> > 
> > Oh, that's quite nice.  Are the SEV-SNP folks planning on using this?
> > If they are, acks/reviews would be much appreciated.
> 
> AMD folks tested one of previous revision and reported that it works, but
> I don't remember seeing the code that hook ups AMD implementation.

Yes, they will be using this eventually.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
