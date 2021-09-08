Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173AC403B1B
	for <lists+linux-efi@lfdr.de>; Wed,  8 Sep 2021 16:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347842AbhIHOBu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Sep 2021 10:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbhIHOBu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Sep 2021 10:01:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D341EC061575;
        Wed,  8 Sep 2021 07:00:41 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0efc003bde2e7441c2ae39.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:fc00:3bde:2e74:41c2:ae39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 537511EC0298;
        Wed,  8 Sep 2021 16:00:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631109636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FPmCIettNSQ3hJ3fLlb/FqgkzqUF7CIDcbo8CDhLUf8=;
        b=Nc04+xpA2MmAZFNCVhPl1P6lsbelU/cKur7xnArKEftSArWcXYPjSXl/i8afF9fF2wOWtg
        VJya2j168umGzNSDaldIW1+0VLNiMZSefupEmUoWe5c1WKs515ik72cjV8eKRW92ixnf7s
        sBmuJxp0nGblT0trjBgJZ0lsGLFwKjc=
Date:   Wed, 8 Sep 2021 16:00:28 +0200
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
        Wanpeng Li <wanpengli@tencent.com>,
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
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 37/38] virt: sevguest: Add support to derive key
Message-ID: <YTjB/KTBsqExqylc@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-38-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820151933.22401-38-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 20, 2021 at 10:19:32AM -0500, Brijesh Singh wrote:
> +2.2 SNP_GET_DERIVED_KEY
> +-----------------------
> +:Technology: sev-snp
> +:Type: guest ioctl
> +:Parameters (in): struct snp_derived_key_req
> +:Returns (out): struct snp_derived_key_req on success, -negative on error
> +
> +The SNP_GET_DERIVED_KEY ioctl can be used to get a key derive from a root key.
> +The derived key can be used by the guest for any purpose, such as sealing keys
> +or communicating with external entities.
> +
> +The ioctl uses the SNP_GUEST_REQUEST (MSG_KEY_REQ) command provided by the
> +SEV-SNP firmware to derive the key. See SEV-SNP specification for further details
> +on the various fileds passed in the key derivation request.
> +
> +On success, the snp_derived_key_resp.data will contains the derived key

"will contain"

> +value.
> diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
> index d029a98ad088..621b1c5a9cfc 100644
> --- a/drivers/virt/coco/sevguest/sevguest.c
> +++ b/drivers/virt/coco/sevguest/sevguest.c
> @@ -303,6 +303,50 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_user_guest_reque
>  	return rc;
>  }
>  
> +static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_user_guest_request *arg)
> +{
> +	struct snp_guest_crypto *crypto = snp_dev->crypto;
> +	struct snp_derived_key_resp *resp;
> +	struct snp_derived_key_req req;
> +	int rc, resp_len;
> +
> +	if (!arg->req_data || !arg->resp_data)
> +		return -EINVAL;
> +
> +	/* Copy the request payload from the userspace */

"from userspace"

> +	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
> +		return -EFAULT;
> +
> +	/* Message version must be non-zero */
> +	if (!req.msg_version)
> +		return -EINVAL;
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
> +	/* Issue the command to get the attestation report */
> +	rc = handle_guest_request(snp_dev, req.msg_version, SNP_MSG_KEY_REQ,
> +				  &req.data, sizeof(req.data), resp->data, resp_len,
> +				  &arg->fw_err);
> +	if (rc)
> +		goto e_free;
> +
> +	/* Copy the response payload to userspace */
> +	if (copy_to_user((void __user *)arg->resp_data, resp, sizeof(*resp)))
> +		rc = -EFAULT;
> +
> +e_free:
> +	kfree(resp);
> +	return rc;
> +}
> +
>  static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
>  {
>  	struct snp_guest_dev *snp_dev = to_snp_dev(file);
> @@ -320,6 +364,10 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
>  		ret = get_report(snp_dev, &input);
>  		break;
>  	}
> +	case SNP_GET_DERIVED_KEY: {
> +		ret = get_derived_key(snp_dev, &input);
> +		break;
> +	}

{} brackets are not needed.

What, however, is bothering me more in this function is that you call
the respective ioctl function which might fail, you do not look at the
return value and copy_to_user() unconditionally.

Looking at get_derived_key(), for example, if it returns after:

        if (!arg->req_data || !arg->resp_data)
                return -EINVAL;

you will be copying the same thing back to the user, you copied in
earlier. That doesn't make any sense to me.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
