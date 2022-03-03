Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E661B4CC12C
	for <lists+linux-efi@lfdr.de>; Thu,  3 Mar 2022 16:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiCCP3B (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Mar 2022 10:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbiCCP3A (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Mar 2022 10:29:00 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EB53EF02;
        Thu,  3 Mar 2022 07:28:14 -0800 (PST)
Received: from nazgul.tnic (nat0.nue.suse.com [IPv6:2001:67c:2178:4000::1111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 599F61EC0354;
        Thu,  3 Mar 2022 16:28:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646321288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3wkQa12TOe6L5HnGAAvvXCd9OYOioyR8PkC5Q5bDZB0=;
        b=ciJK03bk+KE2NLCrkhmmPvmEM91yiPiBgSXRnWJ4sIiDpwWLEP52w2yQp9MjTvHzkehrZQ
        ju+iK3ka4iPLgdPAWM9OaNPZz0L+bYQFt96nt8NKVlT2hSEz372BTl/oJjMUqBbQW2HzJJ
        wgRKuvFN3dDc+VpN/yEElwHAVnXA7fo=
Date:   Thu, 3 Mar 2022 16:28:13 +0100
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v11 44/45] virt: sevguest: Add support to get extended
 report
Message-ID: <YiDegxDviQ81VH0H@nazgul.tnic>
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
 <20220224165625.2175020-45-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220224165625.2175020-45-brijesh.singh@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 24, 2022 at 10:56:24AM -0600, Brijesh Singh wrote:
> +static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
> +{
> +	struct snp_guest_crypto *crypto = snp_dev->crypto;
> +	struct snp_ext_report_req req = {0};
> +	struct snp_report_resp *resp;
> +	int ret, npages = 0, resp_len;
> +
> +	lockdep_assert_held(&snp_cmd_mutex);
> +
> +	if (!arg->req_data || !arg->resp_data)
> +		return -EINVAL;
> +
> +	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
> +		return -EFAULT;
> +
> +	if (req.certs_len) {
> +		if (req.certs_len > SEV_FW_BLOB_MAX_SIZE ||
> +		    !IS_ALIGNED(req.certs_len, PAGE_SIZE))
> +			return -EINVAL;
> +	}
> +
> +	if (req.certs_address && req.certs_len) {
> +		if (!access_ok(req.certs_address, req.certs_len))
> +			return -EFAULT;
> +
> +		/*
> +		 * Initialize the intermediate buffer with all zeros. This buffer
> +		 * is used in the guest request message to get the certs blob from
> +		 * the host. If host does not supply any certs in it, then copy
> +		 * zeros to indicate that certificate data was not provided.
> +		 */
> +		memset(snp_dev->certs_data, 0, req.certs_len);
> +
> +		npages = req.certs_len >> PAGE_SHIFT;
> +	}

I think all those checks should be made more explicit. This makes the
code a lot more readable and straight-forward (pasting the full excerpt
because the incremental diff ontop is less readable):

	...

        if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
                return -EFAULT;

        if (!req.certs_len || !req.certs_address)
                return -EINVAL;

        if (req.certs_len > SEV_FW_BLOB_MAX_SIZE ||
            !IS_ALIGNED(req.certs_len, PAGE_SIZE))
                return -EINVAL;

        if (!access_ok(req.certs_address, req.certs_len))
                return -EFAULT;

        /*
         * Initialize the intermediate buffer with all zeros. This buffer
         * is used in the guest request message to get the certs blob from
         * the host. If host does not supply any certs in it, then copy
         * zeros to indicate that certificate data was not provided.
         */
        memset(snp_dev->certs_data, 0, req.certs_len);

        npages = req.certs_len >> PAGE_SHIFT;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
