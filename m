Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9774AB0AA
	for <lists+linux-efi@lfdr.de>; Sun,  6 Feb 2022 17:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239603AbiBFQll (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 6 Feb 2022 11:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbiBFQlk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 6 Feb 2022 11:41:40 -0500
X-Greylist: delayed 11005 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 08:41:38 PST
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E79C06173B;
        Sun,  6 Feb 2022 08:41:38 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3597F1EC01B7;
        Sun,  6 Feb 2022 17:41:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644165693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Vf4uD77Lu81fzkyJFDjIK5AMPQsw8mdt+0qd3hoteKA=;
        b=X1KzWt4kENbpoTW5g4vozGTNQPANq18LmTnDQ2DAE9tecHwlnKNuJDnjMhSDBVQt8EaGwK
        isUMnTdSEnFc/dKWxahkZF0HJVXNcVjviK3CObEDSaAHBkUH1eycmrApfzGxtn8PhJEQQg
        A9rixKjewzIEXSDO6AianN5uLuVtyhM=
Date:   Sun, 6 Feb 2022 17:41:26 +0100
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
Subject: Re: [PATCH v9 33/43] x86/compressed: Add SEV-SNP feature
 detection/setup
Message-ID: <Yf/6NhnS50UDv4xV@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-34-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220128171804.569796-34-brijesh.singh@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 28, 2022 at 11:17:54AM -0600, Brijesh Singh wrote:
> +static struct cc_setup_data *get_cc_setup_data(struct boot_params *bp)
> +{
> +	struct setup_data *hdr = (struct setup_data *)bp->hdr.setup_data;
> +
> +	while (hdr) {
> +		if (hdr->type == SETUP_CC_BLOB)
> +			return (struct cc_setup_data *)hdr;
> +		hdr = (struct setup_data *)hdr->next;
> +	}
> +
> +	return NULL;
> +}

Merge that function into its only caller.

...

> +static struct cc_blob_sev_info *snp_find_cc_blob(struct boot_params *bp)

static function, no need for the "snp_" prefix. Please audit all your
patches for that and remove that prefix from all static functions.

> +{
> +	struct cc_blob_sev_info *cc_info;
> +
> +	cc_info = snp_find_cc_blob_efi(bp);
> +	if (cc_info)
> +		goto found_cc_info;
> +
> +	cc_info = snp_find_cc_blob_setup_data(bp);
> +	if (!cc_info)
> +		return NULL;
> +
> +found_cc_info:
> +	if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
> +		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
> +
> +	return cc_info;
> +}
> +
> +bool snp_init(struct boot_params *bp)
> +{
> +	struct cc_blob_sev_info *cc_info;
> +
> +	if (!bp)
> +		return false;
> +
> +	cc_info = snp_find_cc_blob(bp);
> +	if (!cc_info)
> +		return false;
> +
> +	/*
> +	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
> +	 * config table doesn't need to be searched again during early startup
> +	 * phase.
> +	 */
> +	bp->cc_blob_address = (u32)(unsigned long)cc_info;
> +
> +	/*
> +	 * Indicate SEV-SNP based on presence of SEV-SNP-specific CC blob.
> +	 * Subsequent checks will verify SEV-SNP CPUID/MSR bits.
> +	 */

Put that comment over the function name.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
