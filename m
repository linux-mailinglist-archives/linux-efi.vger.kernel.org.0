Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD974AB720
	for <lists+linux-efi@lfdr.de>; Mon,  7 Feb 2022 10:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbiBGI4c (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Feb 2022 03:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349444AbiBGIwV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Feb 2022 03:52:21 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E2EC043181;
        Mon,  7 Feb 2022 00:52:20 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E128A1EC0354;
        Mon,  7 Feb 2022 09:52:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644223935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=W5/DZokBYRxpM+GgYWtpQjoT7RaWk9dlrfIFiuzFIa4=;
        b=jUn+1eurN4z9tcFEvPAiW+VNtadYuGyS3JMfBuoiNodnP/0JZHNwGb/xOJWSbIn/2ze9Ph
        /6U9mkyDEsx+5w3M15F3iu8WvX4l8FtMSzvOUrOM7fRhuhMAgkQ6Yyzow3mEeTeiaLIvd7
        gq5mBSHT15V9rBoNG7QcM3bWD0g3WFw=
Date:   Mon, 7 Feb 2022 09:52:09 +0100
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
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Liam Merwick <liam.merwick@oracle.com>
Subject: Re: [PATCH v9 42/43] virt: sevguest: Add support to derive key
Message-ID: <YgDduR0mrptX5arB@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-43-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220128171804.569796-43-brijesh.singh@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 28, 2022 at 11:18:03AM -0600, Brijesh Singh wrote:
> +static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
> +{
> +	struct snp_guest_crypto *crypto = snp_dev->crypto;
> +	struct snp_derived_key_resp resp = {0};
> +	struct snp_derived_key_req req = {0};
> +	int rc, resp_len;
> +	u8 buf[64+16]; /* Response data is 64 bytes and max authsize for GCM is 16 bytes */

verify_comment_style: Warning: No tail comments please:
 drivers/virt/coco/sevguest/sevguest.c:401 [+	u8 buf[64+16]; /* Response data is 64 bytes and max authsize for GCM is 16 bytes */]

> +	if (!arg->req_data || !arg->resp_data)
> +		return -EINVAL;
> +
> +	/* Copy the request payload from userspace */

That comment looks useless.

> +	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
> +		return -EFAULT;
> +
> +	/*
> +	 * The intermediate response buffer is used while decrypting the
> +	 * response payload. Make sure that it has enough space to cover the
> +	 * authtag.
> +	 */
> +	resp_len = sizeof(resp.data) + crypto->a_len;
> +	if (sizeof(buf) < resp_len)
> +		return -ENOMEM;

That test can happen before the copy_from_user() above.

> +
> +	/* Issue the command to get the attestation report */

Also useless.

> +	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
> +				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len,
> +				  &arg->fw_err);
> +	if (rc)
> +		goto e_free;
> +
> +	/* Copy the response payload to userspace */

Ditto.

> +	memcpy(resp.data, buf, sizeof(resp.data));
> +	if (copy_to_user((void __user *)arg->resp_data, &resp, sizeof(resp)))
> +		rc = -EFAULT;
> +
> +e_free:
> +	memzero_explicit(buf, sizeof(buf));
> +	memzero_explicit(&resp, sizeof(resp));

Those are allocated on stack, why are you clearing them?

> +	return rc;
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
