Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DF94AB7A8
	for <lists+linux-efi@lfdr.de>; Mon,  7 Feb 2022 10:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbiBGJaf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Feb 2022 04:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353674AbiBGJQl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Feb 2022 04:16:41 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A983CC0401DE;
        Mon,  7 Feb 2022 01:16:39 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 934AB1EC0354;
        Mon,  7 Feb 2022 10:16:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644225393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RhZCvESkq4uv/MnXkVCgST7XyZ/TXxrvV+qyZmcFnNo=;
        b=eAKkrWkC+wccOlnhlbQ0D0g7WmKJasDAmaBpYzOdvOmVRMP0ZaG1AwvCvcMmCdqGiXFPhB
        mDdy3SsIbwarUgR8GGZzsL3BbYqfAh1nXlT2ZSnFtaxZcLh1lIS3GFFk2oPLpdP7wfNDOf
        Y74CWeSnp3mCrLoztWbkxIjH5UWMU8I=
Date:   Mon, 7 Feb 2022 10:16:27 +0100
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
Subject: Re: [PATCH v9 43/43] virt: sevguest: Add support to get extended
 report
Message-ID: <YgDjayeFRpzh1xEu@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-44-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220128171804.569796-44-brijesh.singh@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 28, 2022 at 11:18:04AM -0600, Brijesh Singh wrote:
> +static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
> +{
> +	struct snp_guest_crypto *crypto = snp_dev->crypto;
> +	struct snp_ext_report_req req = {0};
> +	struct snp_report_resp *resp;
> +	int ret, npages = 0, resp_len;
> +
> +	if (!arg->req_data || !arg->resp_data)
> +		return -EINVAL;
> +
> +	/* Copy the request payload from userspace */

Useless comment.

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
> +		 * Initialize the intermediate buffer with all zero's. This buffer

"zeros"

> +		 * is used in the guest request message to get the certs blob from
> +		 * the host. If host does not supply any certs in it, then copy
> +		 * zeros to indicate that certificate data was not provided.
> +		 */
> +		memset(snp_dev->certs_data, 0, req.certs_len);
> +
> +		npages = req.certs_len >> PAGE_SHIFT;
> +	}
> +
> +	/*
> +	 * The intermediate response buffer is used while decrypting the
> +	 * response payload. Make sure that it has enough space to cover the
> +	 * authtag.
> +	 */
> +	resp_len = sizeof(resp->data) + crypto->a_len;
> +	resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
> +	if (!resp)
> +		return -ENOMEM;
> +
> +	snp_dev->input.data_npages = npages;
> +	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg->msg_version,
> +				   SNP_MSG_REPORT_REQ, &req.data,
> +				   sizeof(req.data), resp->data, resp_len, &arg->fw_err);
> +
> +	/* If certs length is invalid then copy the returned length */
> +	if (arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
> +		req.certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
> +
> +		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
> +			ret = -EFAULT;
> +	}
> +
> +	if (ret)
> +		goto e_free;
> +
> +	/* Copy the certificate data blob to userspace */
> +	if (req.certs_address && req.certs_len &&
> +	    copy_to_user((void __user *)req.certs_address, snp_dev->certs_data,
> +			 req.certs_len)) {
> +		ret = -EFAULT;
> +		goto e_free;
> +	}
> +
> +	/* Copy the response payload to userspace */

Both comments are not needed.

> +	if (copy_to_user((void __user *)arg->resp_data, resp, sizeof(*resp)))
> +		ret = -EFAULT;
> +
> +e_free:
> +	kfree(resp);
> +	return ret;
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
