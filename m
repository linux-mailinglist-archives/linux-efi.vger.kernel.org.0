Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033C93A1DAA
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jun 2021 21:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhFIT1E (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Jun 2021 15:27:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31450 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229734AbhFIT1D (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Jun 2021 15:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623266708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GUlVCJFCxf/kpI2l1b3XQm2qhyDPm/eBf8zNz2ha/rg=;
        b=PYvSfuBYG5m1vB0CkjOGbVyOGiFJJI9z3ItXQ4lKXbL3xkbiTFlie6EGnfyR0F+EBGq3fv
        fLFvF37qphO0oc3Xy1kEa+ioz9Zf1rR2qc6lc7Fy+vGwcioVZmpEAD7mIszEOOwVPzsxUV
        rK0XEvu8OLe+nMcwSNOYFuaK8CXOgEg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-xf2BaXklO6GyKsC2jwFo4A-1; Wed, 09 Jun 2021 15:25:04 -0400
X-MC-Unique: xf2BaXklO6GyKsC2jwFo4A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC1ED8015A4;
        Wed,  9 Jun 2021 19:25:00 +0000 (UTC)
Received: from work-vm (ovpn-113-168.ams2.redhat.com [10.36.113.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 34E3F5C1C5;
        Wed,  9 Jun 2021 19:24:44 +0000 (UTC)
Date:   Wed, 9 Jun 2021 20:24:41 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
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
Subject: Re: [PATCH Part1 RFC v3 21/22] x86/sev: Register SNP guest request
 platform device
Message-ID: <YMEVedGOrYgI1Klc@work-vm>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-22-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602140416.23573-22-brijesh.singh@amd.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

* Brijesh Singh (brijesh.singh@amd.com) wrote:
> Version 2 of GHCB specification provides NAEs that can be used by the SNP
> guest to communicate with the PSP without risk from a malicious hypervisor
> who wishes to read, alter, drop or replay the messages sent.
> 
> The hypervisor uses the SNP_GUEST_REQUEST command interface provided by
> the SEV-SNP firmware to forward the guest messages to the PSP.
> 
> In order to communicate with the PSP, the guest need to locate the secrets
> page inserted by the hypervisor during the SEV-SNP guest launch. The
> secrets page contains the communication keys used to send and receive the
> encrypted messages between the guest and the PSP.
> 
> The secrets page is located either through the setup_data cc_blob_address
> or EFI configuration table.
> 
> Create a platform device that the SNP guest driver can bind to get the
> platform resources. The SNP guest driver can provide userspace interface
> to get the attestation report, key derivation etc.
> 
> The helper snp_issue_guest_request() will be used by the drivers to
> send the guest message request to the hypervisor. The guest message header
> contains a message count. The message count is used in the IV. The
> firmware increments the message count by 1, and expects that next message
> will be using the incremented count.
> 
> The helper snp_msg_seqno() will be used by driver to get and message
> sequence counter, and it will be automatically incremented by the
> snp_issue_guest_request(). The incremented value is be saved in the
> secrets page so that the kexec'ed kernel knows from where to begin.
> 
> See SEV-SNP and GHCB spec for more details.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/sev.h      |  12 +++
>  arch/x86/include/uapi/asm/svm.h |   2 +
>  arch/x86/kernel/sev.c           | 176 ++++++++++++++++++++++++++++++++
>  arch/x86/platform/efi/efi.c     |   2 +
>  include/linux/efi.h             |   1 +
>  include/linux/sev-guest.h       |  76 ++++++++++++++
>  6 files changed, 269 insertions(+)
>  create mode 100644 include/linux/sev-guest.h
> 
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 640108402ae9..da2f757cd9bc 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -59,6 +59,18 @@ extern void vc_no_ghcb(void);
>  extern void vc_boot_ghcb(void);
>  extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
>  
> +/* AMD SEV Confidential computing blob structure */
> +#define CC_BLOB_SEV_HDR_MAGIC	0x45444d41
> +struct cc_blob_sev_info {
> +	u32 magic;
> +	u16 version;
> +	u16 reserved;
> +	u64 secrets_phys;
> +	u32 secrets_len;
> +	u64 cpuid_phys;
> +	u32 cpuid_len;
> +};
> +
>  /* Software defined (when rFlags.CF = 1) */
>  #define PVALIDATE_FAIL_NOUPDATE		255
>  
> diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
> index c0152186a008..bd64f2b98ac7 100644
> --- a/arch/x86/include/uapi/asm/svm.h
> +++ b/arch/x86/include/uapi/asm/svm.h
> @@ -109,6 +109,7 @@
>  #define SVM_VMGEXIT_SET_AP_JUMP_TABLE		0
>  #define SVM_VMGEXIT_GET_AP_JUMP_TABLE		1
>  #define SVM_VMGEXIT_PSC				0x80000010
> +#define SVM_VMGEXIT_GUEST_REQUEST		0x80000011
>  #define SVM_VMGEXIT_AP_CREATION			0x80000013
>  #define SVM_VMGEXIT_AP_CREATE_ON_INIT		0
>  #define SVM_VMGEXIT_AP_CREATE			1
> @@ -222,6 +223,7 @@
>  	{ SVM_VMGEXIT_AP_JUMP_TABLE,	"vmgexit_ap_jump_table" }, \
>  	{ SVM_VMGEXIT_PSC,		"vmgexit_page_state_change" }, \
>  	{ SVM_VMGEXIT_AP_CREATION,	"vmgexit_ap_creation" }, \
> +	{ SVM_VMGEXIT_GUEST_REQUEST,	"vmgexit_guest_request" }, \
>  	{ SVM_EXIT_ERR,         "invalid_guest_state" }
>  
>  
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 8f7ef35a25ef..8aae1166f52e 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -9,6 +9,7 @@
>  
>  #define pr_fmt(fmt)	"SEV-ES: " fmt
>  
> +#include <linux/platform_device.h>
>  #include <linux/sched/debug.h>	/* For show_regs() */
>  #include <linux/percpu-defs.h>
>  #include <linux/mem_encrypt.h>
> @@ -16,10 +17,13 @@
>  #include <linux/printk.h>
>  #include <linux/mm_types.h>
>  #include <linux/set_memory.h>
> +#include <linux/sev-guest.h>
>  #include <linux/memblock.h>
>  #include <linux/kernel.h>
> +#include <linux/efi.h>
>  #include <linux/mm.h>
>  #include <linux/cpumask.h>
> +#include <linux/io.h>
>  
>  #include <asm/cpu_entry_area.h>
>  #include <asm/stacktrace.h>
> @@ -33,6 +37,7 @@
>  #include <asm/smp.h>
>  #include <asm/cpu.h>
>  #include <asm/apic.h>
> +#include <asm/setup.h>		/* For struct boot_params */
>  
>  #include "sev-internal.h"
>  
> @@ -47,6 +52,8 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
>   */
>  static struct ghcb __initdata *boot_ghcb;
>  
> +static unsigned long snp_secrets_phys;
> +
>  /* #VC handler runtime per-CPU data */
>  struct sev_es_runtime_data {
>  	struct ghcb ghcb_page;
> @@ -105,6 +112,10 @@ struct ghcb_state {
>  	struct ghcb *ghcb;
>  };
>  
> +#ifdef CONFIG_EFI
> +extern unsigned long cc_blob_phys;
> +#endif
> +
>  static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
>  DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
>  
> @@ -1909,3 +1920,168 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
>  	while (true)
>  		halt();
>  }
> +
> +static struct resource guest_req_res[0];
> +static struct platform_device guest_req_device = {
> +	.name		= "snp-guest",
> +	.id		= -1,
> +	.resource	= guest_req_res,
> +	.num_resources	= 1,
> +};
> +
> +static struct snp_secrets_page_layout *snp_map_secrets_page(void)
> +{
> +	u16 __iomem *secrets;
> +
> +	if (!snp_secrets_phys || !sev_feature_enabled(SEV_SNP))
> +		return NULL;
> +
> +	secrets = ioremap_encrypted(snp_secrets_phys, PAGE_SIZE);
> +	if (!secrets)
> +		return NULL;
> +
> +	return (struct snp_secrets_page_layout *)secrets;
> +}
> +
> +u64 snp_msg_seqno(void)
> +{
> +	struct snp_secrets_page_layout *layout;
> +	u64 count;
> +
> +	layout = snp_map_secrets_page();
> +	if (layout == NULL)
> +		return 0;
> +
> +	/* Read the current message sequence counter from secrets pages */
> +	count = readl(&layout->os_area.msg_seqno_0);

Why is this seqno_0 - is that because it's the count of talking to the
PSP?

> +	iounmap(layout);
> +
> +	/*
> +	 * The message sequence counter for the SNP guest request is a 64-bit value
> +	 * but the version 2 of GHCB specification defines the 32-bit storage for the
> +	 * it.
> +	 */
> +	if ((count + 1) >= INT_MAX)
> +		return 0;

Is that UINT_MAX?

> +
> +	return count + 1;
> +}
> +EXPORT_SYMBOL_GPL(snp_msg_seqno);
> +
> +static void snp_gen_msg_seqno(void)
> +{
> +	struct snp_secrets_page_layout *layout;
> +	u64 count;
> +
> +	layout = snp_map_secrets_page();
> +	if (layout == NULL)
> +		return;
> +
> +	/* Increment the sequence counter by 2 and save in secrets page. */
> +	count = readl(&layout->os_area.msg_seqno_0);
> +	count += 2;

Why 2 not 1 ?

> +	writel(count, &layout->os_area.msg_seqno_0);
> +	iounmap(layout);
> +}
> +
> +static int get_snp_secrets_resource(struct resource *res)
> +{
> +	struct setup_header *hdr = &boot_params.hdr;
> +	struct cc_blob_sev_info *info;
> +	unsigned long paddr;
> +	int ret = -ENODEV;
> +
> +	/*
> +	 * The secret page contains the VM encryption key used for encrypting the
> +	 * messages between the guest and the PSP. The secrets page location is
> +	 * available either through the setup_data or EFI configuration table.
> +	 */
> +	if (hdr->cc_blob_address) {
> +		paddr = hdr->cc_blob_address;

Can you trust the paddr the host has given you or do you need to do some
form of validation?

Dave
> +	} else if (efi_enabled(EFI_CONFIG_TABLES)) {
> +#ifdef CONFIG_EFI
> +		paddr = cc_blob_phys;
> +#else
> +		return -ENODEV;
> +#endif
> +	} else {
> +		return -ENODEV;
> +	}
> +
> +	info = memremap(paddr, sizeof(*info), MEMREMAP_WB);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	/* Verify the header that its a valid SEV_SNP CC header */
> +	if ((info->magic == CC_BLOB_SEV_HDR_MAGIC) &&
> +	    info->secrets_phys &&
> +	    (info->secrets_len == PAGE_SIZE)) {
> +		res->start = info->secrets_phys;
> +		res->end = info->secrets_phys + info->secrets_len;
> +		res->flags = IORESOURCE_MEM;
> +		snp_secrets_phys = info->secrets_phys;
> +		ret = 0;
> +	}
> +
> +	memunmap(info);
> +	return ret;
> +}
> +
> +static int __init add_snp_guest_request(void)
> +{
> +	if (!sev_feature_enabled(SEV_SNP))
> +		return -ENODEV;
> +
> +	if (get_snp_secrets_resource(&guest_req_res[0]))
> +		return -ENODEV;
> +
> +	platform_device_register(&guest_req_device);
> +	dev_info(&guest_req_device.dev, "registered [secret 0x%llx - 0x%llx]\n",
> +		guest_req_res[0].start, guest_req_res[0].end);
> +
> +	return 0;
> +}
> +device_initcall(add_snp_guest_request);
> +
> +unsigned long snp_issue_guest_request(int type, struct snp_guest_request_data *input)
> +{
> +	struct ghcb_state state;
> +	struct ghcb *ghcb;
> +	unsigned long id;
> +	int ret;
> +
> +	if (!sev_feature_enabled(SEV_SNP))
> +		return -ENODEV;
> +
> +	if (type == GUEST_REQUEST)
> +		id = SVM_VMGEXIT_GUEST_REQUEST;
> +	else
> +		return -EINVAL;
> +
> +	ghcb = sev_es_get_ghcb(&state);
> +	if (!ghcb)
> +		return -ENODEV;
> +
> +	vc_ghcb_invalidate(ghcb);
> +	ghcb_set_rax(ghcb, input->data_gpa);
> +	ghcb_set_rbx(ghcb, input->data_npages);
> +
> +	ret = sev_es_ghcb_hv_call(ghcb, NULL, id, input->req_gpa, input->resp_gpa);
> +	if (ret)
> +		goto e_put;
> +
> +	if (ghcb->save.sw_exit_info_2) {
> +		ret = ghcb->save.sw_exit_info_2;
> +		goto e_put;
> +	}
> +
> +	/* Command was successful, increment the message sequence counter. */
> +	snp_gen_msg_seqno();
> +
> +e_put:
> +	sev_es_put_ghcb(&state);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(snp_issue_guest_request);
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 8a26e705cb06..2cca9ee6e1d4 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -57,6 +57,7 @@ static unsigned long efi_systab_phys __initdata;
>  static unsigned long prop_phys = EFI_INVALID_TABLE_ADDR;
>  static unsigned long uga_phys = EFI_INVALID_TABLE_ADDR;
>  static unsigned long efi_runtime, efi_nr_tables;
> +unsigned long cc_blob_phys;
>  
>  unsigned long efi_fw_vendor, efi_config_table;
>  
> @@ -66,6 +67,7 @@ static const efi_config_table_type_t arch_tables[] __initconst = {
>  #ifdef CONFIG_X86_UV
>  	{UV_SYSTEM_TABLE_GUID,		&uv_systab_phys,	"UVsystab"	},
>  #endif
> +	{EFI_CC_BLOB_GUID,		&cc_blob_phys,		"CC blob"	},
>  	{},
>  };
>  
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 6b5d36babfcc..75aeb2a56888 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -344,6 +344,7 @@ void efi_native_runtime_setup(void);
>  #define EFI_CERT_SHA256_GUID			EFI_GUID(0xc1c41626, 0x504c, 0x4092, 0xac, 0xa9, 0x41, 0xf9, 0x36, 0x93, 0x43, 0x28)
>  #define EFI_CERT_X509_GUID			EFI_GUID(0xa5c059a1, 0x94e4, 0x4aa7, 0x87, 0xb5, 0xab, 0x15, 0x5c, 0x2b, 0xf0, 0x72)
>  #define EFI_CERT_X509_SHA256_GUID		EFI_GUID(0x3bd2a492, 0x96c0, 0x4079, 0xb4, 0x20, 0xfc, 0xf9, 0x8e, 0xf1, 0x03, 0xed)
> +#define EFI_CC_BLOB_GUID			EFI_GUID(0x067b1f5f, 0xcf26, 0x44c5, 0x85, 0x54, 0x93, 0xd7, 0x77, 0x91, 0x2d, 0x42)
>  
>  /*
>   * This GUID is used to pass to the kernel proper the struct screen_info
> diff --git a/include/linux/sev-guest.h b/include/linux/sev-guest.h
> new file mode 100644
> index 000000000000..51277448a108
> --- /dev/null
> +++ b/include/linux/sev-guest.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * AMD Secure Encrypted Virtualization (SEV) guest driver interface
> + *
> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
> + *
> + * Author: Brijesh Singh <brijesh.singh@amd.com>
> + *
> + */
> +
> +#ifndef __LINUX_SEV_GUEST_H_
> +#define __LINUX_SEV_GUEST_H_
> +
> +#include <linux/types.h>
> +
> +enum vmgexit_type {
> +	GUEST_REQUEST,
> +
> +	GUEST_REQUEST_MAX
> +};
> +
> +/*
> + * The secrets page contains 96-bytes of reserved field that can be used by
> + * the guest OS. The guest OS uses the area to save the message sequence
> + * number for each VMPL level.
> + *
> + * See the GHCB spec section Secret page layout for the format for this area.
> + */
> +struct secrets_os_area {
> +	u32 msg_seqno_0;
> +	u32 msg_seqno_1;
> +	u32 msg_seqno_2;
> +	u32 msg_seqno_3;
> +	u64 ap_jump_table_pa;
> +	u8 rsvd[40];
> +	u8 guest_usage[32];
> +} __packed;
> +
> +#define VMPCK_KEY_LEN		32
> +
> +/* See the SNP spec secrets page layout section for the structure */
> +struct snp_secrets_page_layout {
> +	u32 version;
> +	u32 imiEn	: 1,
> +	    rsvd1	: 31;
> +	u32 fms;
> +	u32 rsvd2;
> +	u8 gosvw[16];
> +	u8 vmpck0[VMPCK_KEY_LEN];
> +	u8 vmpck1[VMPCK_KEY_LEN];
> +	u8 vmpck2[VMPCK_KEY_LEN];
> +	u8 vmpck3[VMPCK_KEY_LEN];
> +	struct secrets_os_area os_area;
> +	u8 rsvd3[3840];
> +} __packed;
> +
> +struct snp_guest_request_data {
> +	unsigned long req_gpa;
> +	unsigned long resp_gpa;
> +	unsigned long data_gpa;
> +	unsigned int data_npages;
> +};
> +
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +unsigned long snp_issue_guest_request(int vmgexit_type, struct snp_guest_request_data *input);
> +u64 snp_msg_seqno(void);
> +#else
> +
> +static inline unsigned long snp_issue_guest_request(int type,
> +						    struct snp_guest_request_data *input)
> +{
> +	return -ENODEV;
> +}
> +static inline u64 snp_msg_seqno(void) { return 0; }
> +#endif /* CONFIG_AMD_MEM_ENCRYPT */
> +#endif /* __LINUX_SEV_GUEST_H__ */
> -- 
> 2.17.1
> 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

