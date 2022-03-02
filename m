Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9154CA9EB
	for <lists+linux-efi@lfdr.de>; Wed,  2 Mar 2022 17:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239692AbiCBQPl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Mar 2022 11:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiCBQPl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Mar 2022 11:15:41 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D984CCCC5B;
        Wed,  2 Mar 2022 08:14:57 -0800 (PST)
Received: from nazgul.tnic (nat0.nue.suse.com [IPv6:2001:67c:2178:4000::1111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 765761EC03AD;
        Wed,  2 Mar 2022 17:14:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646237692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=awylhfIR8fI0vfB+Q4tGaWL6X/Z9qgE2EUHkemQv5MY=;
        b=fvEIawZRy1ItnJXYqlVf415zSrdtK2Tt/7zQyoUxd71Lzc/DXKG+G31uKqqugg+TVr1B84
        DvvCmJccsylPfqGkz1z2eNFkIxtZITxjPP2y3eMK+pHEq16soA5qz0IECP9042vAqkl3Ww
        d2v50azdyWX5Dx+ruad9aYUz4bWprcs=
Date:   Wed, 2 Mar 2022 17:14:57 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
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
Subject: Re: [PATCH v11 00/45] Add AMD Secure Nested Paging (SEV-SNP) Guest
 Support
Message-ID: <Yh+YAWu3K4xBillV@nazgul.tnic>
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
 <Yh99pBI/RwZY1yf7@nazgul.tnic>
 <519f5e8e-18d1-43ac-ef90-0320d21c3a55@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <519f5e8e-18d1-43ac-ef90-0320d21c3a55@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Mar 02, 2022 at 05:09:34PM +0100, Paolo Bonzini wrote:
> Sure: https://git.kernel.org/pub/scm/virt/kvm/kvm.git, branch svm-for-snp.
> 
> $ git log -4 --oneline --reverse
> 3c95d3fab229 KVM: SVM: Define sev_features and vmpl field in the VMSA
> 0c86f9cf27f7 KVM: SVM: Create a separate mapping for the SEV-ES save area
> c5e0ec4c742d KVM: SVM: Create a separate mapping for the GHCB save area
> 88c955d1fc93 (HEAD -> kvm/svm-for-snp) KVM: SVM: Update the SEV-ES save area mapping

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
