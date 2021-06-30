Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECE33B833B
	for <lists+linux-efi@lfdr.de>; Wed, 30 Jun 2021 15:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbhF3NiM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Jun 2021 09:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbhF3NiL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Jun 2021 09:38:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23D6C061756;
        Wed, 30 Jun 2021 06:35:42 -0700 (PDT)
Received: from zn.tnic (p200300ec2f12c300d5c967e0b00ce97c.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:c300:d5c9:67e0:b00c:e97c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E006F1EC046E;
        Wed, 30 Jun 2021 15:35:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1625060141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wPPCQp4f4RUBchaxZp4/uDs+S7WG+9WZBgFuIygun4Y=;
        b=Qs0HTTFiFAa90rUyUBxepT0u0N2z+f59oFvbyO82BqhoqE/Gbv+Tw8E/F7ocjZDitIlU00
        53xqBC1vnJL82h158EqaU70gt8t1kjb6bO4/Fzjs7CIOgdV2ag1iGwU7XtpsbRKKC1hdPh
        DoropWwCO0f3PMQwTceqlWuVZAeqR5U=
Date:   Wed, 30 Jun 2021 15:35:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
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
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 22/22] virt: Add SEV-SNP guest driver
Message-ID: <YNxzJ2I3ZumTELLb@zn.tnic>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-23-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210602140416.23573-23-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 02, 2021 at 09:04:16AM -0500, Brijesh Singh wrote:
> SEV-SNP specification provides the guest a mechanism to communicate with
> the PSP without risk from a malicious hypervisor who wishes to read, alter,
> drop or replay the messages sent. The driver uses snp_issue_guest_request()
> to issue GHCB SNP_GUEST_REQUEST NAE event. This command constructs a
> trusted channel between the guest and the PSP firmware.
> 
> The userspace can use the following ioctls provided by the driver:
> 
> 1. Request an attestation report that can be used to assume the identity
>    and security configuration of the guest.
> 2. Ask the firmware to provide a key derived from a root key.
> 
> See SEV-SNP spec section Guest Messages for more details.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  drivers/virt/Kconfig           |   3 +
>  drivers/virt/Makefile          |   1 +
>  drivers/virt/sevguest/Kconfig  |  10 +
>  drivers/virt/sevguest/Makefile |   4 +
>  drivers/virt/sevguest/snp.c    | 448 +++++++++++++++++++++++++++++++++
>  drivers/virt/sevguest/snp.h    |  63 +++++
>  include/uapi/linux/sev-guest.h |  56 +++++
>  7 files changed, 585 insertions(+)
>  create mode 100644 drivers/virt/sevguest/Kconfig
>  create mode 100644 drivers/virt/sevguest/Makefile
>  create mode 100644 drivers/virt/sevguest/snp.c
>  create mode 100644 drivers/virt/sevguest/snp.h
>  create mode 100644 include/uapi/linux/sev-guest.h

Seeing how there are a bunch of such driver things for SEV stuff, I'd
say to put it under:

	drivers/virt/coco/

where we can collect all those confidential computing supporting
drivers.

> 
> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> index 8061e8ef449f..4de714c5ee9a 100644
> --- a/drivers/virt/Kconfig
> +++ b/drivers/virt/Kconfig
> @@ -36,4 +36,7 @@ source "drivers/virt/vboxguest/Kconfig"
>  source "drivers/virt/nitro_enclaves/Kconfig"
>  
>  source "drivers/virt/acrn/Kconfig"
> +
> +source "drivers/virt/sevguest/Kconfig"
> +
>  endif
> diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
> index 3e272ea60cd9..b2d1a8131c90 100644
> --- a/drivers/virt/Makefile
> +++ b/drivers/virt/Makefile
> @@ -8,3 +8,4 @@ obj-y				+= vboxguest/
>  
>  obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
>  obj-$(CONFIG_ACRN_HSM)		+= acrn/
> +obj-$(CONFIG_SEV_GUEST)		+= sevguest/
> diff --git a/drivers/virt/sevguest/Kconfig b/drivers/virt/sevguest/Kconfig
> new file mode 100644
> index 000000000000..e88a85527bf6
> --- /dev/null
> +++ b/drivers/virt/sevguest/Kconfig
> @@ -0,0 +1,10 @@
> +config SEV_GUEST
> +	tristate "AMD SEV Guest driver"
> +	default y
> +	depends on AMD_MEM_ENCRYPT
> +	help
> +	  Provides AMD SNP guest request driver. The driver can be used by the

s/Provides AMD SNP guest request driver. //

> +	  guest to communicate with the hypervisor to request the attestation report

to communicate with the PSP, I thought, not the hypervisor?

> +	  and more.
> +
> +	  If you choose 'M' here, this module will be called sevguest.
> diff --git a/drivers/virt/sevguest/Makefile b/drivers/virt/sevguest/Makefile
> new file mode 100644
> index 000000000000..1505df437682
> --- /dev/null
> +++ b/drivers/virt/sevguest/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +sevguest-y := snp.o

What's that for?

Why isn't the filename simply called:

drivers/virt/coco/sevguest.c

?

Or is more coming?

And below there's

	.name = "snp-guest",

so you need to get the naming in order here.

> +obj-$(CONFIG_SEV_GUEST) += sevguest.o
> diff --git a/drivers/virt/sevguest/snp.c b/drivers/virt/sevguest/snp.c
> new file mode 100644
> index 000000000000..00d8e8fddf2c
> --- /dev/null
> +++ b/drivers/virt/sevguest/snp.c
> @@ -0,0 +1,448 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * AMD Secure Encrypted Virtualization Nested Paging (SEV-SNP) guest request interface
> + *
> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
> + *
> + * Author: Brijesh Singh <brijesh.singh@amd.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/mutex.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <linux/miscdevice.h>
> +#include <linux/set_memory.h>
> +#include <linux/fs.h>
> +#include <crypto/aead.h>
> +#include <linux/scatterlist.h>
> +#include <linux/sev-guest.h>
> +#include <uapi/linux/sev-guest.h>
> +
> +#include "snp.h"
> +
> +#define DEVICE_NAME	"sev-guest"
> +#define AAD_LEN		48
> +#define MSG_HDR_VER	1
> +
> +struct snp_guest_crypto {
> +	struct crypto_aead *tfm;
> +	uint8_t *iv, *authtag;
> +	int iv_len, a_len;
> +};
> +
> +struct snp_guest_dev {
> +	struct device *dev;
> +	struct miscdevice misc;
> +
> +	struct snp_guest_crypto *crypto;
> +	struct snp_guest_msg *request, *response;
> +};
> +
> +static DEFINE_MUTEX(snp_cmd_mutex);
> +
> +static inline struct snp_guest_dev *to_snp_dev(struct file *file)
> +{
> +	struct miscdevice *dev = file->private_data;
> +
> +	return container_of(dev, struct snp_guest_dev, misc);
> +}
> +
> +static struct snp_guest_crypto *init_crypto(struct snp_guest_dev *snp_dev, uint8_t *key,
> +					    size_t keylen)
> +{
> +	struct snp_guest_crypto *crypto;
> +
> +	crypto = kzalloc(sizeof(*crypto), GFP_KERNEL_ACCOUNT);
> +	if (!crypto)
> +		return NULL;
> +
> +	crypto->tfm = crypto_alloc_aead("gcm(aes)", 0, 0);

I know that it is hard to unselect CONFIG_CRYPTO_AEAD2 which provides
this but you better depend on it in the Makefile so that some random
config still builds.

> +	if (IS_ERR(crypto->tfm))
> +		goto e_free;
> +
> +	if (crypto_aead_setkey(crypto->tfm, key, keylen))
> +		goto e_free_crypto;
> +
> +	crypto->iv_len = crypto_aead_ivsize(crypto->tfm);
> +	if (crypto->iv_len < 12) {
> +		dev_err(snp_dev->dev, "IV length is less than 12.\n");
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
> +
> +	return NULL;
> +}

...

> +static int handle_guest_request(struct snp_guest_dev *snp_dev, int msg_type,
> +				struct snp_user_guest_request *input, void *req_buf,
> +				size_t req_len, void __user *resp_buf, size_t resp_len)
> +{
> +	struct snp_guest_crypto *crypto = snp_dev->crypto;
> +	struct page *page;
> +	size_t msg_len;
> +	int ret;
> +
> +	/* Allocate the buffer to hold response */
> +	resp_len += crypto->a_len;
> +	page = alloc_pages(GFP_KERNEL_ACCOUNT, get_order(resp_len));
> +	if (!page)
> +		return -ENOMEM;
> +
> +	ret = __handle_guest_request(snp_dev, msg_type, input, req_buf, req_len,
> +			page_address(page), resp_len, &msg_len);

Align arguments on the opening brace.

Check the whole patch too for other similar cases.

> +	if (ret)
> +		goto e_free;
> +
> +	if (copy_to_user(resp_buf, page_address(page), msg_len))
> +		ret = -EFAULT;
> +
> +e_free:
> +	__free_pages(page, get_order(resp_len));
> +
> +	return ret;
> +}
> +
> +static int get_report(struct snp_guest_dev *snp_dev, struct snp_user_guest_request *input)
> +{
> +	struct snp_user_report __user *report = (struct snp_user_report *)input->data;
> +	struct snp_user_report_req req;
> +
> +	if (copy_from_user(&req, &report->req, sizeof(req)))

What guarantees that that __user report thing is valid and is not going
to trick the kernel into doing a NULL pointer access in the ->req access
here?

IOW, you need to verify all your user data being passed through before
using it.

> +		return -EFAULT;
> +
> +	return handle_guest_request(snp_dev, SNP_MSG_REPORT_REQ, input, &req.user_data,
> +			sizeof(req.user_data), report->response, sizeof(report->response));
> +}
> +
> +static int derive_key(struct snp_guest_dev *snp_dev, struct snp_user_guest_request *input)
> +{
> +	struct snp_user_derive_key __user *key = (struct snp_user_derive_key *)input->data;
> +	struct snp_user_derive_key_req req;
> +
> +	if (copy_from_user(&req, &key->req, sizeof(req)))
> +		return -EFAULT;
> +
> +	return handle_guest_request(snp_dev, SNP_MSG_KEY_REQ, input, &req, sizeof(req),
> +			key->response, sizeof(key->response));
> +}
> +
> +static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
> +{
> +	struct snp_guest_dev *snp_dev = to_snp_dev(file);
> +	struct snp_user_guest_request input;
> +	void __user *argp = (void __user *)arg;
> +	int ret = -ENOTTY;
> +
> +	if (copy_from_user(&input, argp, sizeof(input)))
> +		return -EFAULT;
> +
> +	mutex_lock(&snp_cmd_mutex);
> +	switch (ioctl) {
> +	case SNP_GET_REPORT: {
> +		ret = get_report(snp_dev, &input);
> +		break;
> +	}
> +	case SNP_DERIVE_KEY: {
> +		ret = derive_key(snp_dev, &input);
> +		break;
> +	}
> +	default:
> +		break;
> +	}

If only two ioctls, you don't need the switch-case thing.

> +
> +	mutex_unlock(&snp_cmd_mutex);
> +
> +	if (copy_to_user(argp, &input, sizeof(input)))
> +		return -EFAULT;
> +
> +	return ret;
> +}

...

> diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
> new file mode 100644
> index 000000000000..0a8454631605
> --- /dev/null
> +++ b/include/uapi/linux/sev-guest.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> +/*
> + * Userspace interface for AMD SEV and SEV-SNP guest driver.
> + *
> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
> + *
> + * Author: Brijesh Singh <brijesh.singh@amd.com>
> + *
> + * SEV-SNP API specification is available at: https://developer.amd.com/sev/
> + */
> +
> +#ifndef __UAPI_LINUX_SEV_GUEST_H_
> +#define __UAPI_LINUX_SEV_GUEST_H_
> +
> +#include <linux/types.h>
> +
> +struct snp_user_report_req {
> +	__u8 user_data[64];
> +};
> +
> +struct snp_user_report {
> +	struct snp_user_report_req req;
> +
> +	/* see SEV-SNP spec for the response format */
> +	__u8 response[4000];
> +};
> +
> +struct snp_user_derive_key_req {
> +	__u8 root_key_select;
> +	__u64 guest_field_select;
> +	__u32 vmpl;
> +	__u32 guest_svn;
> +	__u64 tcb_version;
> +};
> +
> +struct snp_user_derive_key {
> +	struct snp_user_derive_key_req req;
> +
> +	/* see SEV-SNP spec for the response format */
> +	__u8 response[64];
> +};
> +
> +struct snp_user_guest_request {
> +	/* Message version number (must be non-zero) */
> +	__u8 msg_version;
> +	__u64 data;
> +
> +	/* firmware error code on failure (see psp-sev.h) */
> +	__u32 fw_err;
> +};

All those struct names have a "snp_user" prefix. It seems to me that
that "user" is superfluous.

> +
> +#define SNP_GUEST_REQ_IOC_TYPE	'S'
> +#define SNP_GET_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x0, struct snp_user_guest_request)
> +#define SNP_DERIVE_KEY _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x1, struct snp_user_guest_request)

Where are those ioctls documented so that userspace can know how to use
them?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
