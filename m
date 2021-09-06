Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3632401F3B
	for <lists+linux-efi@lfdr.de>; Mon,  6 Sep 2021 19:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243962AbhIFRjY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Sep 2021 13:39:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37542 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237281AbhIFRjY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 6 Sep 2021 13:39:24 -0400
Received: from zn.tnic (p200300ec2f0c240054be6003e2b88cf4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:2400:54be:6003:e2b8:8cf4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 36C451EC04DF;
        Mon,  6 Sep 2021 19:38:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630949897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ic9idha1eNRSeBbKjXxejnqYa8Nsdxsy/xZxuh1y44E=;
        b=PPM9iAzRTqGs9JPf6ALMDL2Vgz1dUv1TO1PLsi8TBnLEGNydqiBXeH71rVHga/8DD9iDnS
        wRmuA8ywktfe9FKU9LtxfmbGBqTZ8c/6KxLqToTiI6fRf3s9ig5kXgJmpDyBMtn0CyzenZ
        +/XaZvLq7O0pvAJ06c5tURTgK4zgBoE=
Date:   Mon, 6 Sep 2021 19:38:08 +0200
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
Subject: Re: [PATCH Part1 v5 36/38] virt: Add SEV-SNP guest driver
Message-ID: <YTZSAB5H9EC2uk8z@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-37-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820151933.22401-37-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 20, 2021 at 10:19:31AM -0500, Brijesh Singh wrote:
> +===================================================================
> +The Definitive SEV Guest API Documentation
> +===================================================================
> +
> +1. General description
> +======================
> +
> +The SEV API is a set of ioctls that are issued to by the guest or

issued to by?

Issued by the guest or hypervisor, you mean..

> +hypervisor to get or set certain aspect of the SEV virtual machine.
> +The ioctls belong to the following classes:
> +
> + - Hypervisor ioctls: These query and set global attributes which affect the
> +   whole SEV firmware.  These ioctl is used by platform provision tools.

"These ioctls are used ... "

> +
> + - Guest ioctls: These query and set attribute of the SEV virtual machine.

"... attributes... "

> +
> +2. API description
> +==================
> +
> +This section describes ioctls that can be used to query or set SEV guests.
> +For each ioctl, the following information is provided along with a
> +description:
> +
> +  Technology:
> +      which SEV techology provides this ioctl. sev, sev-es, sev-snp or all.
> +
> +  Type:
> +      hypervisor or guest. The ioctl can be used inside the guest or the
> +      hypervisor.
> +
> +  Parameters:
> +      what parameters are accepted by the ioctl.
> +
> +  Returns:
> +      the return value.  General error numbers (ENOMEM, EINVAL)
> +      are not detailed, but errors with specific meanings are.
> +
> +The guest ioctl should be called to /dev/sev-guest device. The ioctl accepts

s/called to/issued on a file descriptor of the/

> +struct snp_user_guest_request. The input and output structure is specified
> +through the req_data and resp_data field respectively. If the ioctl fails
> +to execute due to the firmware error, then fw_err code will be set.

"... due to a ... "

> +
> +::
> +        struct snp_user_guest_request {

So you said earlier:

> I followed the naming convension you recommended during the initial SEV driver
> developement. IIRC, the main reason for us having to add "user" in it because
> we wanted to distinguious that this structure is not exactly same as the what
> is defined in the SEV-SNP firmware spec.

but looking at the current variant in the code, the structure in the SNP spec is

Table 91. Layout of the CMDBUF_SNP_GUEST_REQUEST Structure

which corresponds to struct snp_guest_request_data so you can call this one:

	struct snp_guest_request_ioctl

and then it is perfectly clear what is what.

> +                /* Request and response structure address */
> +                __u64 req_data;
> +                __u64 resp_data;
> +
> +                /* firmware error code on failure (see psp-sev.h) */
> +                __u64 fw_err;
> +        };
> +
> +2.1 SNP_GET_REPORT
> +------------------
> +
> +:Technology: sev-snp
> +:Type: guest ioctl
> +:Parameters (in): struct snp_report_req
> +:Returns (out): struct snp_report_resp on success, -negative on error
> +
> +The SNP_GET_REPORT ioctl can be used to query the attestation report from the
> +SEV-SNP firmware. The ioctl uses the SNP_GUEST_REQUEST (MSG_REPORT_REQ) command
> +provided by the SEV-SNP firmware to query the attestation report.
> +
> +On success, the snp_report_resp.data will contains the report. The report

"... will contain... "

> +format is described in the SEV-SNP specification. See the SEV-SNP specification
> +for further details.

"... which can be found at https://developer.amd.com/sev/."

assuming that URL will keep its validity in the foreseeable future.

> +static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
> +{
> +	struct snp_guest_dev *snp_dev = to_snp_dev(file);
> +	void __user *argp = (void __user *)arg;
> +	struct snp_user_guest_request input;
> +	int ret = -ENOTTY;
> +
> +	if (copy_from_user(&input, argp, sizeof(input)))
> +		return -EFAULT;
> +
> +	mutex_lock(&snp_cmd_mutex);
> +
> +	switch (ioctl) {
> +	case SNP_GET_REPORT: {
> +		ret = get_report(snp_dev, &input);
> +		break;
> +	}

No need for those {} brackets around the case.

> +	default:
> +		break;
> +	}
> +
> +	mutex_unlock(&snp_cmd_mutex);
> +
> +	if (copy_to_user(argp, &input, sizeof(input)))
> +		return -EFAULT;
> +
> +	return ret;
> +}
> +
> +static void free_shared_pages(void *buf, size_t sz)
> +{
> +	unsigned int npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
> +
> +	/* If fail to restore the encryption mask then leak it. */
> +	if (set_memory_encrypted((unsigned long)buf, npages))

Hmm, this sounds like an abnormal condition about which we should at
least warn...

> +		return;
> +
> +	__free_pages(virt_to_page(buf), get_order(sz));
> +}
> +
> +static void *alloc_shared_pages(size_t sz)
> +{
> +	unsigned int npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
> +	struct page *page;
> +	int ret;
> +
> +	page = alloc_pages(GFP_KERNEL_ACCOUNT, get_order(sz));
> +	if (IS_ERR(page))
> +		return NULL;
> +
> +	ret = set_memory_decrypted((unsigned long)page_address(page), npages);
> +	if (ret) {
> +		__free_pages(page, get_order(sz));
> +		return NULL;
> +	}
> +
> +	return page_address(page);
> +}
> +
> +static const struct file_operations snp_guest_fops = {
> +	.owner	= THIS_MODULE,
> +	.unlocked_ioctl = snp_guest_ioctl,
> +};
> +
> +static int __init snp_guest_probe(struct platform_device *pdev)
> +{
> +	struct snp_guest_platform_data *data;
> +	struct device *dev = &pdev->dev;
> +	struct snp_guest_dev *snp_dev;
> +	struct miscdevice *misc;
> +	int ret;
> +
> +	if (!dev->platform_data)
> +		return -ENODEV;
> +
> +	data = (struct snp_guest_platform_data *)dev->platform_data;
> +	vmpck_id = data->vmpck_id;
> +
> +	snp_dev = devm_kzalloc(&pdev->dev, sizeof(struct snp_guest_dev), GFP_KERNEL);
> +	if (!snp_dev)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, snp_dev);
> +	snp_dev->dev = dev;
> +
> +	snp_dev->crypto = init_crypto(snp_dev, data->vmpck, sizeof(data->vmpck));
> +	if (!snp_dev->crypto)
> +		return -EIO;

I guess you should put the crypto init...

> +
> +	/* Allocate the shared page used for the request and response message. */
> +	snp_dev->request = alloc_shared_pages(sizeof(struct snp_guest_msg));
> +	if (IS_ERR(snp_dev->request)) {
> +		ret = PTR_ERR(snp_dev->request);
> +		goto e_free_crypto;
> +	}
> +
> +	snp_dev->response = alloc_shared_pages(sizeof(struct snp_guest_msg));
> +	if (IS_ERR(snp_dev->response)) {
> +		ret = PTR_ERR(snp_dev->response);
> +		goto e_free_req;
> +	}

... here, after the page allocation to save yourself all the setup work
if the shared pages allocation fails.

> +
> +	misc = &snp_dev->misc;
> +	misc->minor = MISC_DYNAMIC_MINOR;
> +	misc->name = DEVICE_NAME;
> +	misc->fops = &snp_guest_fops;
> +
> +	return misc_register(misc);
> +
> +e_free_req:
> +	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
> +
> +e_free_crypto:
> +	deinit_crypto(snp_dev->crypto);
> +
> +	return ret;
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
