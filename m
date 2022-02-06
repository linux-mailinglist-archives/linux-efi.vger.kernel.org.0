Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E984AB2AF
	for <lists+linux-efi@lfdr.de>; Sun,  6 Feb 2022 23:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbiBFWjw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 6 Feb 2022 17:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbiBFWjv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 6 Feb 2022 17:39:51 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1BBC06173B;
        Sun,  6 Feb 2022 14:39:49 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BAAC11EC01B7;
        Sun,  6 Feb 2022 23:39:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644187184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dC6k3ztP2dvmV0DFt5g2rRLOpah9Keh6CfQVtqUmc48=;
        b=WpQHPJjZBaOnlzMDWuMOmBlWr7UrVHC1w7WE+G186DYurtWOLs6fyE4uvOfkHCfnC2KS4C
        8bcaONzpgz+Muhkrw/wmF/FzSpwpKQUvFbhWo68mbNv/R6Xz52wcTBZgb2s96DOJN/XBii
        ivw9UtRhjFZjuuO0CmSG8K2f6Ffu4T8=
Date:   Sun, 6 Feb 2022 23:39:37 +0100
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
Subject: Re: [PATCH v9 41/43] virt: Add SEV-SNP guest driver
Message-ID: <YgBOKQKXEH5VqTO7@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-42-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220128171804.569796-42-brijesh.singh@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 28, 2022 at 11:18:02AM -0600, Brijesh Singh wrote:
> SEV-SNP specification provides the guest a mechanism to communicate with
 ^
 The

> the PSP without risk from a malicious hypervisor who wishes to read, alter,
> drop or replay the messages sent. The driver uses snp_issue_guest_request()
> to issue GHCB SNP_GUEST_REQUEST or SNP_EXT_GUEST_REQUEST NAE events to
> submit the request to PSP.
> 
> The PSP requires that all communication should be encrypted using key
> specified through the platform_data.
> 
> The userspace can use SNP_GET_REPORT ioctl() to query the guest

s/The u/U/

> attestation report.
> 
> See SEV-SNP spec section Guest Messages for more details.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  Documentation/virt/coco/sevguest.rst  |  81 ++++
>  drivers/virt/Kconfig                  |   3 +
>  drivers/virt/Makefile                 |   1 +
>  drivers/virt/coco/sevguest/Kconfig    |  12 +
>  drivers/virt/coco/sevguest/Makefile   |   2 +
>  drivers/virt/coco/sevguest/sevguest.c | 605 ++++++++++++++++++++++++++
>  drivers/virt/coco/sevguest/sevguest.h |  98 +++++
>  include/uapi/linux/sev-guest.h        |  50 +++
>  8 files changed, 852 insertions(+)
>  create mode 100644 Documentation/virt/coco/sevguest.rst
>  create mode 100644 drivers/virt/coco/sevguest/Kconfig
>  create mode 100644 drivers/virt/coco/sevguest/Makefile
>  create mode 100644 drivers/virt/coco/sevguest/sevguest.c
>  create mode 100644 drivers/virt/coco/sevguest/sevguest.h
>  create mode 100644 include/uapi/linux/sev-guest.h
> 
> diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
> new file mode 100644
> index 000000000000..47ef3b0821d5
> --- /dev/null
> +++ b/Documentation/virt/coco/sevguest.rst

Adding documentation is all fine and good but you need to link that file
into the TOC somewhere so that it is visible when the documentation gets
generated... I guess something like this:

diff --git a/Documentation/virt/index.rst b/Documentation/virt/index.rst
index edea7fea95a8..40ad0d20032e 100644
--- a/Documentation/virt/index.rst
+++ b/Documentation/virt/index.rst
@@ -13,6 +13,7 @@ Linux Virtualization Support
    guest-halt-polling
    ne_overview
    acrn/index
+   coco/sevguest
 
 .. only:: html and subproject
 


And once you do, do "make htmldocs" to see whether it complains about
some formatting issues or other errors etc.

/me goes and does it...

Ah, here we go:

Documentation/virt/coco/sevguest.rst:48: WARNING: Inline emphasis start-string without end-string.
Documentation/virt/coco/sevguest.rst:51: WARNING: Inline emphasis start-string without end-string.
Documentation/virt/coco/sevguest.rst:55: WARNING: Inline emphasis start-string without end-string.
Documentation/virt/coco/sevguest.rst:57: WARNING: Definition list ends without a blank line; unexpected unindent.

There's something it doesn't like about the struct. Yeah, when I look at
the html output, it is all weird and not monospaced...

> @@ -0,0 +1,81 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===================================================================
> +The Definitive SEV Guest API Documentation
> +===================================================================
> +
> +1. General description
> +======================
> +
> +The SEV API is a set of ioctls that are used by the guest or hypervisor
> +to get or set certain aspect of the SEV virtual machine. The ioctls belong
		^
		a

> +to the following classes:
> +
> + - Hypervisor ioctls: These query and set global attributes which affect the
> +   whole SEV firmware.  These ioctl are used by platform provision tools.

"provisioning" maybe?

> +
> + - Guest ioctls: These query and set attributes of the SEV virtual machine.
> +
> +2. API description
> +==================
> +
> +This section describes ioctls that can be used to query or set SEV guests.
							      ^^^^^^^^^^^^^^^

That sounds weird.

> +For each ioctl, the following information is provided along with a
> +description:
> +
> +  Technology:
> +      which SEV technology provides this ioctl. sev, sev-es, sev-snp or all.
						   ^^^^^^^^^^^^^^^^^^^^

Marketing is going to scold you - those need to be in all caps. :-P

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

Those are negative: -ENOMEM, -EINVAL

> +      are not detailed, but errors with specific meanings are.
> +
> +The guest ioctl should be issued on a file descriptor of the /dev/sev-guest device.
> +The ioctl accepts struct snp_user_guest_request. The input and output structure is
> +specified through the req_data and resp_data field respectively. If the ioctl fails
> +to execute due to a firmware error, then fw_err code will be set otherwise the
> +fw_err will be set to 0xff.

fw_err is u64. What does 0xff mean? Everything above the least
significant byte is reserved 0?

> diff --git a/drivers/virt/coco/sevguest/Kconfig b/drivers/virt/coco/sevguest/Kconfig
> new file mode 100644
> index 000000000000..07ab9ec6471c
> --- /dev/null
> +++ b/drivers/virt/coco/sevguest/Kconfig
> @@ -0,0 +1,12 @@
> +config SEV_GUEST
> +	tristate "AMD SEV Guest driver"
> +	default y

Definitely not. We don't enable drivers by default unless they're
ubiquitous.

> +	depends on AMD_MEM_ENCRYPT && CRYPTO_AEAD2
> +	help
> +	  SEV-SNP firmware provides the guest a mechanism to communicate with
> +	  the PSP without risk from a malicious hypervisor who wishes to read,
> +	  alter, drop or replay the messages sent. The driver provides
> +	  userspace interface to communicate with the PSP to request the
> +	  attestation report and more.
> +
> +	  If you choose 'M' here, this module will be called sevguest.

...

> +static bool is_vmpck_empty(struct snp_guest_dev *snp_dev)
> +{
> +	char zero_key[VMPCK_KEY_LEN] = {0};
> +
> +	if (snp_dev->vmpck)
> +		return memcmp(snp_dev->vmpck, zero_key, VMPCK_KEY_LEN) == 0;

		return !memcmp(...);
> +
> +	return true;
> +}
> +
> +static void snp_disable_vmpck(struct snp_guest_dev *snp_dev)
> +{
> +	memzero_explicit(snp_dev->vmpck, VMPCK_KEY_LEN);
> +	snp_dev->vmpck = NULL;
> +}
> +
> +static inline u64 __snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
> +{
> +	u64 count;
> +
> +	lockdep_assert_held(&snp_cmd_mutex);
> +
> +	/* Read the current message sequence counter from secrets pages */
> +	count = *snp_dev->os_area_msg_seqno;
> +
> +	return count + 1;
> +}
> +
> +/* Return a non-zero on success */
> +static u64 snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
> +{
> +	u64 count = __snp_get_msg_seqno(snp_dev);
> +
> +	/*
> +	 * The message sequence counter for the SNP guest request is a  64-bit
> +	 * value but the version 2 of GHCB specification defines a 32-bit storage
> +	 * for it. If the counter exceeds the 32-bit value then return zero.
> +	 * The caller should check the return value, but if the caller happens to
> +	 * not check the value and use it, then the firmware treats zero as an
> +	 * invalid number and will fail the  message request.
> +	 */
> +	if (count >= UINT_MAX) {
> +		pr_err_ratelimited("SNP guest request message sequence counter overflow\n");

How does error message help the user? Is she supposed to reboot the
machine or so?

Because it sounds to me like if this goes over 32-bit, this driver stops
working. So what resets those sequence numbers?

> +		return 0;
> +	}
> +
> +	return count;
> +}
> +
> +static void snp_inc_msg_seqno(struct snp_guest_dev *snp_dev)
> +{
> +	/*
> +	 * The counter is also incremented by the PSP, so increment it by 2
> +	 * and save in secrets page.
> +	 */
> +	*snp_dev->os_area_msg_seqno += 2;
> +}
> +
> +static inline struct snp_guest_dev *to_snp_dev(struct file *file)
> +{
> +	struct miscdevice *dev = file->private_data;
> +
> +	return container_of(dev, struct snp_guest_dev, misc);
> +}
> +
> +static struct snp_guest_crypto *init_crypto(struct snp_guest_dev *snp_dev, u8 *key, size_t keylen)
> +{
> +	struct snp_guest_crypto *crypto;
> +
> +	crypto = kzalloc(sizeof(*crypto), GFP_KERNEL_ACCOUNT);
> +	if (!crypto)
> +		return NULL;
> +
> +	crypto->tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
> +	if (IS_ERR(crypto->tfm))
> +		goto e_free;
> +
> +	if (crypto_aead_setkey(crypto->tfm, key, keylen))
> +		goto e_free_crypto;
> +
> +	crypto->iv_len = crypto_aead_ivsize(crypto->tfm);
> +	if (crypto->iv_len < 12) {
> +		dev_err(snp_dev->dev, "IV length is less than 12.\n");

And? < 12 is bad? Make that error message more user-friendly pls.

> +		goto e_free_crypto;
> +	}
> +
> +	crypto->iv = kmalloc(crypto->iv_len, GFP_KERNEL_ACCOUNT);
> +	if (!crypto->iv)
> +		goto e_free_crypto;
> +
> +	if (crypto_aead_authsize(crypto->tfm) > MAX_AUTHTAG_LEN) {
> +		if (crypto_aead_setauthsize(crypto->tfm, MAX_AUTHTAG_LEN)) {
> +			dev_err(snp_dev->dev, "failed to set authsize to %d\n", MAX_AUTHTAG_LEN);
> +			goto e_free_crypto;
> +		}
> +	}
> +
> +	crypto->a_len = crypto_aead_authsize(crypto->tfm);
> +	crypto->authtag = kmalloc(crypto->a_len, GFP_KERNEL_ACCOUNT);
> +	if (!crypto->authtag)
> +		goto e_free_crypto;
> +
> +	return crypto;
> +
> +e_free_crypto:
> +	crypto_free_aead(crypto->tfm);
> +e_free:
> +	kfree(crypto->iv);
> +	kfree(crypto->authtag);
> +	kfree(crypto);

The order of those free calls needs to be the opposite of the kmallocs
above.

> +
> +	return NULL;
> +}

...

> +static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
> +				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
> +				u32 resp_sz, __u64 *fw_err)
> +{
> +	unsigned long err;
> +	u64 seqno;
> +	int rc;
> +
> +	/* Get message sequence and verify that its a non-zero */
> +	seqno = snp_get_msg_seqno(snp_dev);
> +	if (!seqno)
> +		return -EIO;
> +
> +	memset(snp_dev->response, 0, sizeof(*snp_dev->response));

				     sizeof(struct snp_guest_msg)

> +
> +	/* Encrypt the userspace provided payload */
> +	rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
> +	if (rc)
> +		return rc;
> +
> +	/* Call firmware to process the request */
> +	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
> +	if (fw_err)
> +		*fw_err = err;
> +
> +	if (rc)
> +		return rc;
> +
> +	rc = verify_and_dec_payload(snp_dev, resp_buf, resp_sz);
> +	if (rc) {
> +		/*
> +		 * The verify_and_dec_payload() will fail only if the hypervisor is
> +		 * actively modifying the message header or corrupting the encrypted payload.
> +		 * This hints that hypervisor is acting in a bad faith. Disable the VMPCK so that
> +		 * the key cannot be used for any communication. The key is disabled to ensure
> +		 * that AES-GCM does not use the same IV while encrypting the request payload.
> +		 */

Put that comment over the function call.

> +		dev_alert(snp_dev->dev,
> +			  "Detected unexpected decode failure, disabling the vmpck_id %d\n",
> +			  vmpck_id);
> +		snp_disable_vmpck(snp_dev);
> +		return rc;
> +	}
> +
> +	/* Increment to new message sequence after payload decryption was successful. */
> +	snp_inc_msg_seqno(snp_dev);
> +
> +	return 0;
> +}
> +
> +static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
> +{
> +	struct snp_guest_crypto *crypto = snp_dev->crypto;
> +	struct snp_report_req req = {0};
> +	struct snp_report_resp *resp;
> +	int rc, resp_len;

	lockdep_assert_held(&snp_cmd_mutex);

> +	if (!arg->req_data || !arg->resp_data)
> +		return -EINVAL;
> +
> +	/* Copy the request payload from userspace */
> +	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
> +		return -EFAULT;
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
> +	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
> +				  SNP_MSG_REPORT_REQ, &req, sizeof(req), resp->data,
> +				  resp_len, &arg->fw_err);
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
> +static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
> +{
> +	struct snp_guest_dev *snp_dev = to_snp_dev(file);
> +	void __user *argp = (void __user *)arg;
> +	struct snp_guest_request_ioctl input;
> +	int ret = -ENOTTY;
> +
> +	if (copy_from_user(&input, argp, sizeof(input)))
> +		return -EFAULT;
> +
> +	input.fw_err = 0xff;
> +
> +	/* Message version must be non-zero */
> +	if (!input.msg_version)
> +		return -EINVAL;
> +
> +	mutex_lock(&snp_cmd_mutex);

That mutex probably is to be held while issuing SNP commands but then
you hold it here already for...

> +
> +	/* Check if the VMPCK is not empty */
> +	if (is_vmpck_empty(snp_dev)) {

... this here which is not really a SNP command issuing.

Should that mutex be grabbed only around handle_guest_request() above or
is it supposed to protect more stuff?

> +		dev_err_ratelimited(snp_dev->dev, "VMPCK is disabled\n");
> +		mutex_unlock(&snp_cmd_mutex);
> +		return -ENOTTY;
> +	}
> +
> +	switch (ioctl) {
> +	case SNP_GET_REPORT:
> +		ret = get_report(snp_dev, &input);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	mutex_unlock(&snp_cmd_mutex);
> +
> +	if (input.fw_err && copy_to_user(argp, &input, sizeof(input)))
> +		return -EFAULT;
> +
> +	return ret;
> +}
> +
> +static void free_shared_pages(void *buf, size_t sz)
> +{
> +	unsigned int npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
> +
> +	if (!buf)
> +		return;
> +
> +	/* If fail to restore the encryption mask then leak it. */

Useless comment - the error message says the same.

> +	if (WARN_ONCE(set_memory_encrypted((unsigned long)buf, npages),
> +		      "Failed to restore encryption mask (leak it)\n"))
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
> +		pr_err("SEV-SNP: failed to mark page shared, ret=%d\n", ret);

Use pr_fmt, grep the tree for an example how and drop "SEV-SNP:" - that
prefix should be "sevguest:".

> +		__free_pages(page, get_order(sz));
> +		return NULL;
> +	}
> +
> +	return page_address(page);
> +}

...

> +static int __init snp_guest_probe(struct platform_device *pdev)
> +{
> +	struct snp_secrets_page_layout *layout;
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
> +	layout = (__force void *)ioremap_encrypted(data->secrets_gpa, PAGE_SIZE);
> +	if (!layout)
> +		return -ENODEV;
> +
> +	ret = -ENOMEM;
> +	snp_dev = devm_kzalloc(&pdev->dev, sizeof(struct snp_guest_dev), GFP_KERNEL);
> +	if (!snp_dev)
> +		goto e_fail;
> +
> +	ret = -EINVAL;
> +	snp_dev->vmpck = get_vmpck(vmpck_id, layout, &snp_dev->os_area_msg_seqno);
> +	if (!snp_dev->vmpck) {
> +		dev_err(dev, "invalid vmpck id %d\n", vmpck_id);
> +		goto e_fail;
> +	}
> +
> +	/* Verify that VMPCK is not zero. */
> +	if (is_vmpck_empty(snp_dev)) {
> +		dev_err(dev, "vmpck id %d is null\n", vmpck_id);
> +		goto e_fail;
> +	}
> +
> +	platform_set_drvdata(pdev, snp_dev);
> +	snp_dev->dev = dev;
> +	snp_dev->layout = layout;
> +
> +	/* Allocate the shared page used for the request and response message. */
> +	snp_dev->request = alloc_shared_pages(sizeof(struct snp_guest_msg));
> +	if (!snp_dev->request)
> +		goto e_fail;
> +
> +	snp_dev->response = alloc_shared_pages(sizeof(struct snp_guest_msg));
> +	if (!snp_dev->response)
> +		goto e_fail;
> +
> +	ret = -EIO;
> +	snp_dev->crypto = init_crypto(snp_dev, snp_dev->vmpck, VMPCK_KEY_LEN);
> +	if (!snp_dev->crypto)
> +		goto e_fail;
> +
> +	misc = &snp_dev->misc;
> +	misc->minor = MISC_DYNAMIC_MINOR;
> +	misc->name = DEVICE_NAME;
> +	misc->fops = &snp_guest_fops;
> +
> +	/* initial the input address for guest request */
> +	snp_dev->input.req_gpa = __pa(snp_dev->request);
> +	snp_dev->input.resp_gpa = __pa(snp_dev->response);
> +
> +	ret =  misc_register(misc);
> +	if (ret)
> +		goto e_fail;
> +
> +	dev_info(dev, "Initialized SEV-SNP guest driver (using vmpck_id %d)\n", vmpck_id);
> +	return 0;
> +
> +e_fail:
> +	iounmap(layout);
> +	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
> +	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));

The freeing needs to happen in the opposite order of the allocations.
Audit all gotos.

> +
> +	return ret;
> +}
> +
> +static int __exit snp_guest_remove(struct platform_device *pdev)
> +{
> +	struct snp_guest_dev *snp_dev = platform_get_drvdata(pdev);
> +
> +	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
> +	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
> +	deinit_crypto(snp_dev->crypto);
> +	misc_deregister(&snp_dev->misc);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver snp_guest_driver = {
> +	.remove		= __exit_p(snp_guest_remove),
> +	.driver		= {
> +		.name = "snp-guest",
> +	},
> +};
> +
> +module_platform_driver_probe(snp_guest_driver, snp_guest_probe);
> +
> +MODULE_AUTHOR("Brijesh Singh <brijesh.singh@amd.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION("1.0.0");
> +MODULE_DESCRIPTION("AMD SNP Guest Driver");
> diff --git a/drivers/virt/coco/sevguest/sevguest.h b/drivers/virt/coco/sevguest/sevguest.h
> new file mode 100644
> index 000000000000..cfa76cf8a21a
> --- /dev/null
> +++ b/drivers/virt/coco/sevguest/sevguest.h
> @@ -0,0 +1,98 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
> + *
> + * Author: Brijesh Singh <brijesh.singh@amd.com>
> + *
> + * SEV-SNP API spec is available at https://developer.amd.com/sev
> + */
> +
> +#ifndef __LINUX_SEVGUEST_H_

I guess VIRT_SEVGUEST_H is better fitting.

> +#define __LINUX_SEVGUEST_H_

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
