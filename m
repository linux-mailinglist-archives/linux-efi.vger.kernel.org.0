Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642AA3FC6B1
	for <lists+linux-efi@lfdr.de>; Tue, 31 Aug 2021 14:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241509AbhHaLkJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Aug 2021 07:40:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231622AbhHaLkI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Aug 2021 07:40:08 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17VBY1La104414;
        Tue, 31 Aug 2021 07:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dUKBGCDHO95leAWwVDsib3fKPcnO4BlAMhGdK43kw8k=;
 b=PYamCRvziAcupGp+My7qb5QaE3buOnBfCFWCX2WNQdQZLKJVm97/YF1gdckWA2YRXBW4
 c3UquOsignKupbnovCOcnpwpepg2dFEjteYYQAiogkmI8ut6TReO6NmPj8X2Wnx7CcYp
 +BIpjsjEdwo8BAfNLPS2ZqvUOpcU3aKsqdNDHc3aMnmcztBSdr9x0FIcyvAvTO0qaDXw
 qoC3U+18Zs2/OGUv/tI3wn+Q/c/Yj+6pbYv4jhAetqma93Zm6iQ9qK5NNjOqJcFc/ACQ
 f51pybdYeKMfVMLQKySozfBkIeOnBGLG2jA1rulJe88MrB1tsMQaatKhPU3HTLzUkApr JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3askkp06wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 07:38:02 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17VBagUA114528;
        Tue, 31 Aug 2021 07:38:02 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3askkp06vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 07:38:01 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17VBYHtc014743;
        Tue, 31 Aug 2021 11:38:00 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02dal.us.ibm.com with ESMTP id 3aqcscwabp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 11:38:00 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17VBbxmK48628186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 11:37:59 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F6B578083;
        Tue, 31 Aug 2021 11:37:59 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0905E78079;
        Tue, 31 Aug 2021 11:37:50 +0000 (GMT)
Received: from [9.65.248.250] (unknown [9.65.248.250])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 31 Aug 2021 11:37:50 +0000 (GMT)
Subject: Re: [PATCH Part1 v5 35/38] x86/sev: Register SNP guest request
 platform device
To:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-36-brijesh.singh@amd.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
Message-ID: <56b37edd-6315-953c-271c-f2c4025be3f7@linux.ibm.com>
Date:   Tue, 31 Aug 2021 14:37:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210820151933.22401-36-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YWJxgvYXhR9ZBUD9ki4NO46dg0USkdUT
X-Proofpoint-GUID: 8N_yOSQbOLDF_2tbX0_fNxVeydegp-og
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-31_04:2021-08-31,2021-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310066
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Brijesh,


On 20/08/2021 18:19, Brijesh Singh wrote:
> Version 2 of GHCB specification provides NAEs that can be used by the SNP
> guest to communicate with the PSP without risk from a malicious hypervisor
> who wishes to read, alter, drop or replay the messages sent.
> 
> In order to communicate with the PSP, the guest need to locate the secrets
> page inserted by the hypervisor during the SEV-SNP guest launch. The
> secrets page contains the communication keys used to send and receive the
> encrypted messages between the guest and the PSP. The secrets page location
> is passed through the setup_data.
> 
> Create a platform device that the SNP guest driver can bind to get the
> platform resources such as encryption key and message id to use to
> communicate with the PSP. The SNP guest driver can provide userspace
> interface to get the attestation report, key derivation, extended
> attestation report etc.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/kernel/sev.c     | 68 +++++++++++++++++++++++++++++++++++++++
>  include/linux/sev-guest.h |  5 +++
>  2 files changed, 73 insertions(+)
> 
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index f42cd5a8e7bb..ab17c93634e9 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -22,6 +22,8 @@
>  #include <linux/log2.h>
>  #include <linux/efi.h>
>  #include <linux/sev-guest.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
>  
>  #include <asm/cpu_entry_area.h>
>  #include <asm/stacktrace.h>
> @@ -37,6 +39,7 @@
>  #include <asm/apic.h>
>  #include <asm/efi.h>
>  #include <asm/cpuid.h>
> +#include <asm/setup.h>
>  
>  #include "sev-internal.h"
>  
> @@ -2164,3 +2167,68 @@ int snp_issue_guest_request(int type, struct snp_guest_request_data *input, unsi
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(snp_issue_guest_request);
> +
> +static struct platform_device guest_req_device = {
> +	.name		= "snp-guest",
> +	.id		= -1,
> +};
> +
> +static u64 find_secrets_paddr(void)
> +{
> +	u64 pa_data = boot_params.cc_blob_address;
> +	struct cc_blob_sev_info info;
> +	void *map;
> +
> +	/*
> +	 * The CC blob contains the address of the secrets page, check if the
> +	 * blob is present.
> +	 */
> +	if (!pa_data)
> +		return 0;
> +
> +	map = early_memremap(pa_data, sizeof(info));
> +	memcpy(&info, map, sizeof(info));
> +	early_memunmap(map, sizeof(info));
> +
> +	/* Verify that secrets page address is passed */
> +	if (info.secrets_phys && info.secrets_len == PAGE_SIZE)
> +		return info.secrets_phys;
> +
> +	return 0;
> +}
> +
> +static int __init add_snp_guest_request(void)
> +{
> +	struct snp_secrets_page_layout *layout;
> +	struct snp_guest_platform_data data;
> +
> +	if (!sev_feature_enabled(SEV_SNP))
> +		return -ENODEV;
> +
> +	snp_secrets_phys = find_secrets_paddr();
> +	if (!snp_secrets_phys)
> +		return -ENODEV;
> +
> +	layout = snp_map_secrets_page();
> +	if (!layout)
> +		return -ENODEV;
> +
> +	/*
> +	 * The secrets page contains three VMPCK that can be used for
> +	 * communicating with the PSP. We choose the VMPCK0 to encrypt guest
> +	 * messages send and receive by the Linux. Provide the key and
> +	 * id through the platform data to the driver.
> +	 */
> +	data.vmpck_id = 0;
> +	memcpy_fromio(data.vmpck, layout->vmpck0, sizeof(data.vmpck));
> +
> +	iounmap(layout);
> +
> +	platform_device_add_data(&guest_req_device, &data, sizeof(data));
> +
> +	if (!platform_device_register(&guest_req_device))
> +		dev_info(&guest_req_device.dev, "secret phys 0x%llx\n", snp_secrets_phys);

Should you return the error code from platform_device_register() in case
it fails (returns something other than zero)?

-Dov

> +
> +	return 0;
> +}
> +device_initcall(add_snp_guest_request);
> diff --git a/include/linux/sev-guest.h b/include/linux/sev-guest.h
> index 16b6af24fda7..e1cb3f7dd034 100644
> --- a/include/linux/sev-guest.h
> +++ b/include/linux/sev-guest.h
> @@ -68,6 +68,11 @@ struct snp_guest_request_data {
>  	unsigned int data_npages;
>  };
>  
> +struct snp_guest_platform_data {
> +	u8 vmpck_id;
> +	char vmpck[VMPCK_KEY_LEN];
> +};
> +
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  int snp_issue_guest_request(int vmgexit_type, struct snp_guest_request_data *input,
>  			    unsigned long *fw_err);
> 
