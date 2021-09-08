Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F63403EAB
	for <lists+linux-efi@lfdr.de>; Wed,  8 Sep 2021 19:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351974AbhIHRyq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Sep 2021 13:54:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37338 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351800AbhIHRyp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 8 Sep 2021 13:54:45 -0400
Received: from zn.tnic (p200300ec2f0efc00b7f29acf52797616.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:fc00:b7f2:9acf:5279:7616])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 883E51EC04E0;
        Wed,  8 Sep 2021 19:53:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631123611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gFBT5jisyD5OrPPKazcB1aYXRhJJSDNKlvdqZzQSdQQ=;
        b=S3VFqKiSqcTs+sO6UecCnNAoJuOHJ5Rs8otpd7OJz937BI0HOTXiPW9XiO7OpLvRIMTW2A
        reIy8yKyC1m7Wf23muvyO5KZMm6BXPEvUWunssdohr4aG0CiUE2lKXooDcDz6DqYXPrQUK
        92hDjjGcgEmJmmtuM3khaoSP58GTSf4=
Date:   Wed, 8 Sep 2021 19:53:21 +0200
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
Subject: Re: [PATCH Part1 v5 38/38] virt: sevguest: Add support to get
 extended report
Message-ID: <YTj4kZCTudDauIn1@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-39-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820151933.22401-39-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 20, 2021 at 10:19:33AM -0500, Brijesh Singh wrote:
> Version 2 of GHCB specification defines NAE to get the extended guest

Resolve "NAE" pls.

> request. It is similar to the SNP_GET_REPORT ioctl. The main difference
> is related to the additional data that be returned. The additional

"that will be returned"

> data returned is a certificate blob that can be used by the SNP guest
> user. The certificate blob layout is defined in the GHCB specification.
> The driver simply treats the blob as a opaque data and copies it to
> userspace.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  Documentation/virt/coco/sevguest.rst  |  22 +++++
>  drivers/virt/coco/sevguest/sevguest.c | 126 ++++++++++++++++++++++++++
>  include/uapi/linux/sev-guest.h        |  13 +++
>  3 files changed, 161 insertions(+)
> 
> diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
> index 25446670d816..7acb8696fca4 100644
> --- a/Documentation/virt/coco/sevguest.rst
> +++ b/Documentation/virt/coco/sevguest.rst
> @@ -85,3 +85,25 @@ on the various fileds passed in the key derivation request.
>  
>  On success, the snp_derived_key_resp.data will contains the derived key
>  value.
> +
> +2.2 SNP_GET_EXT_REPORT
> +----------------------
> +:Technology: sev-snp
> +:Type: guest ioctl
> +:Parameters (in/out): struct snp_ext_report_req
> +:Returns (out): struct snp_report_resp on success, -negative on error
> +
> +The SNP_GET_EXT_REPORT ioctl is similar to the SNP_GET_REPORT. The difference is
> +related to the additional certificate data that is returned with the report.
> +The certificate data returned is being provided by the hypervisor through the
> +SNP_SET_EXT_CONFIG.
> +
> +The ioctl uses the SNP_GUEST_REQUEST (MSG_REPORT_REQ) command provided by the SEV-SNP
> +firmware to get the attestation report.
> +
> +On success, the snp_ext_report_resp.data will contains the attestation report

"will contain"

> +and snp_ext_report_req.certs_address will contains the certificate blob. If the

ditto.

> +length of the blob is lesser than expected then snp_ext_report_req.certs_len will

"is smaller"

> +be updated with the expected value.
> +
> +See GHCB specification for further detail on how to parse the certificate blob.
> diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
> index 621b1c5a9cfc..d978eb432c4c 100644
> --- a/drivers/virt/coco/sevguest/sevguest.c
> +++ b/drivers/virt/coco/sevguest/sevguest.c
> @@ -39,6 +39,7 @@ struct snp_guest_dev {
>  	struct device *dev;
>  	struct miscdevice misc;
>  
> +	void *certs_data;
>  	struct snp_guest_crypto *crypto;
>  	struct snp_guest_msg *request, *response;
>  };
> @@ -347,6 +348,117 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_user_guest_
>  	return rc;
>  }
>  
> +static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_user_guest_request *arg)
> +{
> +	struct snp_guest_crypto *crypto = snp_dev->crypto;
> +	struct snp_guest_request_data input = {};
> +	struct snp_ext_report_req req;
> +	int ret, npages = 0, resp_len;
> +	struct snp_report_resp *resp;
> +	struct snp_report_req *rreq;
> +	unsigned long fw_err = 0;
> +
> +	if (!arg->req_data || !arg->resp_data)
> +		return -EINVAL;
> +
> +	/* Copy the request payload from the userspace */

"from userspace"

> +	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
> +		return -EFAULT;
> +
> +	rreq = &req.data;
> +
> +	/* Message version must be non-zero */
> +	if (!rreq->msg_version)
> +		return -EINVAL;
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
> +		 * is used in the guest request message to get the certs blob from
> +		 * the host. If host does not supply any certs in it, then we copy


Please use passive voice: no "we" or "I", etc,

> +		 * zeros to indicate that certificate data was not provided.
> +		 */
> +		memset(snp_dev->certs_data, 0, req.certs_len);
> +
> +		input.data_gpa = __pa(snp_dev->certs_data);
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
> +	if (copy_from_user(resp, (void __user *)arg->resp_data, sizeof(*resp))) {
> +		ret = -EFAULT;
> +		goto e_free;
> +	}
> +
> +	/* Encrypt the userspace provided payload */
> +	ret = enc_payload(snp_dev, rreq->msg_version, SNP_MSG_REPORT_REQ,
> +			  &rreq->user_data, sizeof(rreq->user_data));
> +	if (ret)
> +		goto e_free;
> +
> +	/* Call firmware to process the request */
> +	input.req_gpa = __pa(snp_dev->request);
> +	input.resp_gpa = __pa(snp_dev->response);
> +	input.data_npages = npages;
> +	memset(snp_dev->response, 0, sizeof(*snp_dev->response));
> +	ret = snp_issue_guest_request(EXT_GUEST_REQUEST, &input, &fw_err);
> +
> +	/* Popogate any firmware error to the userspace */
> +	arg->fw_err = fw_err;
> +
> +	/* If certs length is invalid then copy the returned length */
> +	if (arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
> +		req.certs_len = input.data_npages << PAGE_SHIFT;
> +
> +		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
> +			ret = -EFAULT;
> +
> +		goto e_free;
> +	}
> +
> +	if (ret)
> +		goto e_free;

This one is really confusing. You assign ret in the if branch
above but then you test ret outside too, just in case the
snp_issue_guest_request() call above has failed.

But then if that call has failed, you still go and do some cleanup work
for invalid certs length...

So that get_ext_report() function is doing too many things at once and
is crying to be split.

For example, the glue around snp_issue_guest_request() is already carved
out in handle_guest_request(). Why aren't you calling that function here
too?

That'll keep the enc, request, dec payload game separate and then the
rest of the logic can remain in get_ext_report()...

...

>  static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
>  {
>  	struct snp_guest_dev *snp_dev = to_snp_dev(file);
> @@ -368,6 +480,10 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
>  		ret = get_derived_key(snp_dev, &input);
>  		break;
>  	}
> +	case SNP_GET_EXT_REPORT: {
> +		ret = get_ext_report(snp_dev, &input);
> +		break;
> +	}
>  	default:
>  		break;
>  	}
> @@ -453,6 +569,12 @@ static int __init snp_guest_probe(struct platform_device *pdev)
>  		goto e_free_req;
>  	}
>  
> +	snp_dev->certs_data = alloc_shared_pages(SEV_FW_BLOB_MAX_SIZE);
> +	if (IS_ERR(snp_dev->certs_data)) {
> +		ret = PTR_ERR(snp_dev->certs_data);
> +		goto e_free_resp;
> +	}

Same comments here as for patch 37.

> +
>  	misc = &snp_dev->misc;
>  	misc->minor = MISC_DYNAMIC_MINOR;
>  	misc->name = DEVICE_NAME;


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
