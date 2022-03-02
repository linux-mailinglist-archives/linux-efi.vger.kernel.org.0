Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299F74CA8D4
	for <lists+linux-efi@lfdr.de>; Wed,  2 Mar 2022 16:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240276AbiCBPNw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Mar 2022 10:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243393AbiCBPNv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Mar 2022 10:13:51 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D144779C52;
        Wed,  2 Mar 2022 07:13:07 -0800 (PST)
Received: from nazgul.tnic (nat0.nue.suse.com [IPv6:2001:67c:2178:4000::1111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 60E0E1EC03AD;
        Wed,  2 Mar 2022 16:13:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646233982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Yxf1vQOo5EDfClBwLiZt1az7Yt5ajJKalO3BdVBp+QA=;
        b=sb1egNkBKdDGxHdkyKtZQQ/7E0spw3yOHMWc6B0ThWQAj37VDZmE9PtkU5Mdcc8zF3E3+j
        8frtxd7LkckpuX+1Iayb2eeuCfbS8eNFyS0c6mBY0Q1413SaI3I4S/RA9soOLaMPahX2wt
        aU+3D+0rm8CFm023uxPWX54q1rOyDYs=
Date:   Wed, 2 Mar 2022 16:13:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v11 29/45] x86/boot: Add Confidential Computing type to
 setup_data
Message-ID: <Yh+Jc20ed82Vyxge@nazgul.tnic>
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
 <20220224165625.2175020-30-brijesh.singh@amd.com>
 <Yh3r1PSx/fjqoBB3@nazgul.tnic>
 <671a6137-0d45-3a8c-433a-32448019961f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <671a6137-0d45-3a8c-433a-32448019961f@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Mar 02, 2022 at 08:25:45AM -0600, Brijesh Singh wrote:
> Yep, I am waiting for Linux patches to finalize and then sync OVMF with it.
> I will rename the field to magic in OVMF to keep both of them in sync.

Ok, thx.

Btw, Ard, ACK for the EFI hunk?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
