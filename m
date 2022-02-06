Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4951B4AB1E6
	for <lists+linux-efi@lfdr.de>; Sun,  6 Feb 2022 21:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiBFUFZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 6 Feb 2022 15:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiBFUFZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 6 Feb 2022 15:05:25 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00996C06173B;
        Sun,  6 Feb 2022 12:05:22 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 491F71EC02DD;
        Sun,  6 Feb 2022 21:05:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644177917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+21t1u1IZ/DXSmDNGuY7CZg1bJNoX7TMMApbDOaYGnM=;
        b=EsQ5n6lUIseFFg6Ip/WrZGc3l5i1ZKojKis0VQ4XJ8xqdCSrk704FLOgENIOo43Dg9qZYn
        wVH6sXxY5zO4+fKByBmh2vQyWCqLBmr67x52yRmIOc8bd8ar/gE9ZQjbZdeET+fDUx1Qp2
        e/KrT8L83lMhpzrB3AGPjpmXYrBSFcA=
Date:   Sun, 6 Feb 2022 21:05:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v9 40/43] x86/sev: Register SEV-SNP guest request
 platform device
Message-ID: <YgAp9yat6M7f1THf@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-41-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220128171804.569796-41-brijesh.singh@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 28, 2022 at 11:18:01AM -0600, Brijesh Singh wrote:
> Version 2 of GHCB specification provides Non Automatic Exit (NAE) that can
	      ^				  ^			   ^
	      the			  a			   event type

> be used by the SEV-SNP guest to communicate with the PSP without risk from
> a malicious hypervisor who wishes to read, alter, drop or replay the
> messages sent.
> 
> SNP_LAUNCH_UPDATE can insert two special pages into the guest’s memory:
> the secrets page and the CPUID page. The PSP firmware populate the contents

"populates"

> of the secrets page. The secrets page contains encryption keys used by the
> guest to interact with the firmware. Because the secrets page is encrypted
> with the guest’s memory encryption key, the hypervisor cannot read the
> keys. See SEV-SNP firmware spec for further details on the secrets page
> format.
> 
> Create a platform device that the SEV-SNP guest driver can bind to get the
> platform resources such as encryption key and message id to use to
> communicate with the PSP. The SEV-SNP guest driver provides a userspace
> interface to get the attestation report, key derivation, extended
> attestation report etc.

...

> +static int __init init_snp_platform_device(void)

snp_init_platform_device()

> +{
> +	struct snp_guest_platform_data data;
> +	u64 gpa;
> +
> +	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> +		return -ENODEV;
> +
> +	gpa = get_secrets_page();
> +	if (!gpa)
> +		return -ENODEV;
> +
> +	data.secrets_gpa = gpa;
> +	if (platform_device_add_data(&guest_req_device, &data, sizeof(data)))
> +		goto e_fail;
> +
> +	if (platform_device_register(&guest_req_device))
> +		goto e_fail;
> +
> +	pr_info("SNP guest platform device initialized.\n");
> +	return 0;
> +
> +e_fail:
> +	pr_err("Failed to initialize SNP guest device\n");
> +	return -ENODEV;

So when someone tries to debug why the platform device doesn't register
properly, this error message is ambiguous and two of the error paths
don't even issue one.

Either issue a different error message before you return each time or
remove it completely and let someone who really needs it, add it.

I'd vote for former...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
