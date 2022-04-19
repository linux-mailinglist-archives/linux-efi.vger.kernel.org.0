Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E40507A2F
	for <lists+linux-efi@lfdr.de>; Tue, 19 Apr 2022 21:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348965AbiDST0l (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Apr 2022 15:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbiDST0k (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Apr 2022 15:26:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BB43E5E0;
        Tue, 19 Apr 2022 12:23:57 -0700 (PDT)
Received: from zn.tnic (p200300ea971b5839329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:5839:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 94A9C1EC0559;
        Tue, 19 Apr 2022 21:23:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650396231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=29ILHsZsLNI1cHkGwMzPc7ayyznGcYHN5+bzv1pE4pk=;
        b=aOCYh/K44Q0EvpEMzkaAkbuIouuG5B+e3XnIHMcNGSqGDlq43m1JcEwpdibQBrvwv4q3/4
        lpCszkih78a7WOxtjAwh9GrByUAHbvIgTuaQBP/HCbisa1Dwtwg3qHo3J0+uWJAwYS2ems
        JD2I1GH9VQDeinJxeKVOZFTVW7jM0CA=
Date:   Tue, 19 Apr 2022 21:23:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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
Subject: Re: [PATCHv4 3/8] efi/x86: Implement support for unaccepted memory
Message-ID: <Yl8MRA6MxgNiLYv3@zn.tnic>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-4-kirill.shutemov@linux.intel.com>
 <Ylnwmvygp796+qcA@zn.tnic>
 <20220418155545.a567xnxa6elglapl@box.shutemov.name>
 <Yl2UHOQ4iZJ29k0q@zn.tnic>
 <20220418202431.whvql4w57c7l5vpw@box.shutemov.name>
 <Yl3RmPhdZieSr8W2@zn.tnic>
 <20220418235015.mnujtlmmlyin7y6m@box.shutemov.name>
 <Yl5nSSC4HpSWqfY7@zn.tnic>
 <20220419153002.ffh2ybdl7x2mm7zw@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220419153002.ffh2ybdl7x2mm7zw@box.shutemov.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Apr 19, 2022 at 06:30:02PM +0300, Kirill A. Shutemov wrote:
> Hm. Dave was worried about having copies of _find_next_bit() and
> __bitmap_*() inside compressed/.

That's fine.

> How do we rectify code duplication and making decompresser self-contained?

Also fine - as long as the decompressor and kernel-proper are
independent.

> Do we care about multiple copies of the same code in the kernel?

The copied versions in the decompressor should be simply sufficient for
its use. And there shouldn't be that much of duplication.

Note that we're using the same strategy with perf tool - it does copy
kernel facilities when it needs them.

> Do we care about keeping them in sync?

Nope - as long as they're sufficient for the decompressor. My
expectation here is that the decompressor won't need too many
facilities.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
