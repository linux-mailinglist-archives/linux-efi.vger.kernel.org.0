Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8EE940C337
	for <lists+linux-efi@lfdr.de>; Wed, 15 Sep 2021 12:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbhIOKDc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Sep 2021 06:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38537 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232046AbhIOKDb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Sep 2021 06:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631700132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T7eYhM+mNQgmtkp4huwTGvse0/UecO0jjpzbRrCPdJE=;
        b=cJYCzjS8rrp5IJ8g1wSd5q+ieD+UHnT31Gcs7++X/WabEh7oG0qvRUfMjsNcJIbNPJ1jHY
        B9IYjg1keKrZYOwM14f7UcoF2Ytv3pOIiPnBTeXPeFIN8MbZ9qJDD0/6xywD2k2VUS/rjn
        MDX2iV326V0OivtXYvmQmSJBb2NJpQ8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-EueYAAP2NV-Aw9buTJnXVg-1; Wed, 15 Sep 2021 06:02:11 -0400
X-MC-Unique: EueYAAP2NV-Aw9buTJnXVg-1
Received: by mail-wm1-f69.google.com with SMTP id r125-20020a1c2b830000b0290197a4be97b7so352940wmr.9
        for <linux-efi@vger.kernel.org>; Wed, 15 Sep 2021 03:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T7eYhM+mNQgmtkp4huwTGvse0/UecO0jjpzbRrCPdJE=;
        b=d61f7dBUd1NxOdcU9BSniMY6afZMQ2B7s8bWCf4+qSJXgJTQV92zKrzIA2o539SN5s
         gBbBJ36T/B6tuhf0p7wqkpNZPmHgmQ8Dd/LR4GgIP9Jus6seAKJ3vvU+pv/Bthz43Cqv
         nQdeCYall8da33Cecda8UzuhKRuu7hBwui7l6Bv8NwjZiAWt1gRvy5QMqDquuWzwt3Lz
         dqxwDmMMUL53JLfCuqcdwXrSwanQNtaWf/jDNk3YieYNkTzfit5fSqoBnQ0OjvbGvz72
         MGAyoYjf4EqTLjsHdHdUksj0zzR3dMsbWTT3O2aLw5z8u2kayCGZxlKUsMKY6sPPoVZb
         FwAQ==
X-Gm-Message-State: AOAM533VPgoEhgU/S/zwyWpUJoshmrMxs/qGw3SAPXDcU2jW/ZC0J7w2
        QcAgvt9PV4eH22xaNDkPCOFUdWN3OEZ7NNaRgnBaGFH3L0ZcrFzD6yhxbFu98NqYWj2PYQAxQV+
        UNnZ+K2gnfBuvn5vzhpQB
X-Received: by 2002:adf:fe44:: with SMTP id m4mr4151058wrs.206.1631700129460;
        Wed, 15 Sep 2021 03:02:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+vesNYqkbvKmnGn0DYPdg1QzoVRvbyOCGWnlcCErhvrjU+9MMk6+cZQT4KhTefn5/6tlZ1g==
X-Received: by 2002:adf:fe44:: with SMTP id m4mr4150976wrs.206.1631700128848;
        Wed, 15 Sep 2021 03:02:08 -0700 (PDT)
Received: from work-vm (cpc109021-salf6-2-0-cust453.10-2.cable.virginm.net. [82.29.237.198])
        by smtp.gmail.com with ESMTPSA id x5sm3818031wmk.32.2021.09.15.03.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 03:02:08 -0700 (PDT)
Date:   Wed, 15 Sep 2021 11:02:05 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
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
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 38/38] virt: sevguest: Add support to get
 extended report
Message-ID: <YUHEnTDKEiSySY4a@work-vm>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-39-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820151933.22401-39-brijesh.singh@amd.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

* Brijesh Singh (brijesh.singh@amd.com) wrote:
> Version 2 of GHCB specification defines NAE to get the extended guest
> request. It is similar to the SNP_GET_REPORT ioctl. The main difference

^^^^^^^^^ is that 'report' not request?

> is related to the additional data that be returned. The additional
> data returned is a certificate blob that can be used by the SNP guest
> user. The certificate blob layout is defined in the GHCB specification.
> The driver simply treats the blob as a opaque data and copies it to
> userspace.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

I'm confused by snp_dev->certs_data - who writes to that, and when?
I see it's allocated as shared by the probe function but then passed in
input data in get_ext_report - but get_ext_report memset's it.
What happens if two threads were to try and get an extended report at
the same time?

Dave


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
> +and snp_ext_report_req.certs_address will contains the certificate blob. If the
> +length of the blob is lesser than expected then snp_ext_report_req.certs_len will
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
> +
> +	/* Decrypt the response payload */
> +	ret = verify_and_dec_payload(snp_dev, resp->data, resp_len);
> +	if (ret)
> +		goto e_free;
> +
> +	/* Copy the certificate data blob to userspace */
> +	if (req.certs_address &&
> +	    copy_to_user((void __user *)req.certs_address, snp_dev->certs_data,
> +			 req.certs_len)) {
> +		ret = -EFAULT;
> +		goto e_free;
> +	}
> +
> +	/* Copy the response payload to userspace */
> +	if (copy_to_user((void __user *)arg->resp_data, resp, sizeof(*resp)))
> +		ret = -EFAULT;
> +
> +e_free:
> +	kfree(resp);
> +	return ret;
> +}
> +
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
> +
>  	misc = &snp_dev->misc;
>  	misc->minor = MISC_DYNAMIC_MINOR;
>  	misc->name = DEVICE_NAME;
> @@ -460,6 +582,9 @@ static int __init snp_guest_probe(struct platform_device *pdev)
>  
>  	return misc_register(misc);
>  
> +e_free_resp:
> +	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
> +
>  e_free_req:
>  	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
>  
> @@ -475,6 +600,7 @@ static int __exit snp_guest_remove(struct platform_device *pdev)
>  
>  	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
>  	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
> +	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
>  	deinit_crypto(snp_dev->crypto);
>  	misc_deregister(&snp_dev->misc);
>  
> diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
> index 621a9167df7a..23659215fcfb 100644
> --- a/include/uapi/linux/sev-guest.h
> +++ b/include/uapi/linux/sev-guest.h
> @@ -57,6 +57,16 @@ struct snp_derived_key_resp {
>  	__u8 data[64];
>  };
>  
> +struct snp_ext_report_req {
> +	struct snp_report_req data;
> +
> +	/* where to copy the certificate blob */
> +	__u64 certs_address;
> +
> +	/* length of the certificate blob */
> +	__u32 certs_len;
> +};
> +
>  #define SNP_GUEST_REQ_IOC_TYPE	'S'
>  
>  /* Get SNP attestation report */
> @@ -65,4 +75,7 @@ struct snp_derived_key_resp {
>  /* Get a derived key from the root */
>  #define SNP_GET_DERIVED_KEY _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x1, struct snp_user_guest_request)
>  
> +/* Get SNP extended report as defined in the GHCB specification version 2. */
> +#define SNP_GET_EXT_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x2, struct snp_user_guest_request)
> +
>  #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
> -- 
> 2.17.1
> 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

