Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C123FCECA
	for <lists+linux-efi@lfdr.de>; Tue, 31 Aug 2021 22:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241161AbhHaUtZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Aug 2021 16:49:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52638 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241304AbhHaUtX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Aug 2021 16:49:23 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17VKWsDi055140;
        Tue, 31 Aug 2021 16:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5SEIGlnGc8oTzqbskdKFl6dz77HkP0RWasi51mYGyHw=;
 b=UDVGyuaFwJQKJN1Nrdq4psQa1D0xq47DvqOTIdg0ARM24se9dwFMJYSnC9QTXoyMdMs8
 6mwRm1QNPouXudxrmRQjMBbkmL90VXspQQMDYItdaJ0pSdsQNosk77R/KloitXXSfpFx
 QmGcCABnCMzve+zecVz1jLSp/WzfLinB/VeM/Eo2JM0iKvzhCfS8u3iBUJPbj+C32t7u
 FnMZMveOAf/lwYSM/xwQVRuF6kSAZmlaXOUs745E90MpeKS33FC4PtfwuXe4SKxaKsdb
 hYDmOBHeF81nkWNYYwGmqqv6p6Xp7Xgp8AHR/dOIsBhj2pLAPRPNzN1MF17nJlsVbDe3 Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3asu350wq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 16:46:25 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17VKZ2MC062318;
        Tue, 31 Aug 2021 16:46:24 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3asu350wpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 16:46:24 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17VKggRQ009957;
        Tue, 31 Aug 2021 20:46:23 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma05wdc.us.ibm.com with ESMTP id 3aqcscpkc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 20:46:23 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17VKkMK537683624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 20:46:22 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B06C78064;
        Tue, 31 Aug 2021 20:46:22 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D51F078068;
        Tue, 31 Aug 2021 20:46:13 +0000 (GMT)
Received: from [9.65.248.250] (unknown [9.65.248.250])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 31 Aug 2021 20:46:13 +0000 (GMT)
Subject: Re: [PATCH Part1 v5 34/38] x86/sev: Add snp_msg_seqno() helper
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
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Dov Murik <dovmurik@linux.ibm.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-35-brijesh.singh@amd.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
Message-ID: <f68b77aa-3420-bb6a-712e-bf029bc727d6@linux.ibm.com>
Date:   Tue, 31 Aug 2021 23:46:12 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210820151933.22401-35-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q1l8sXmQHBYU6aRE2St-9-9diLjyEzM5
X-Proofpoint-ORIG-GUID: CZJBUWK8feiryETO61iGNGcquVErxZ1h
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-31_09:2021-08-31,2021-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 spamscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310111
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Brijesh,

On 20/08/2021 18:19, Brijesh Singh wrote:
> The SNP guest request message header contains a message count. The
> message count is used while building the IV. The PSP firmware increments
> the message count by 1, and expects that next message will be using the
> incremented count. The snp_msg_seqno() helper will be used by driver to
> get the message sequence counter used in the request message header,
> and it will be automatically incremented after the request is successful.
> The incremented value is saved in the secrets page so that the kexec'ed
> kernel knows from where to begin.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/kernel/sev.c     | 79 +++++++++++++++++++++++++++++++++++++++
>  include/linux/sev-guest.h | 37 ++++++++++++++++++
>  2 files changed, 116 insertions(+)
> 
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 319a40fc57ce..f42cd5a8e7bb 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -51,6 +51,8 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
>   */
>  static struct ghcb __initdata *boot_ghcb;
>  
> +static u64 snp_secrets_phys;
> +
>  /* #VC handler runtime per-CPU data */
>  struct sev_es_runtime_data {
>  	struct ghcb ghcb_page;
> @@ -2030,6 +2032,80 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
>  		halt();
>  }
>  
> +static struct snp_secrets_page_layout *snp_map_secrets_page(void)
> +{
> +	u16 __iomem *secrets;

You never dereference 'secrets'. Maybe s/u16/void/ ?


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
> +static inline u64 snp_read_msg_seqno(void)
> +{
> +	struct snp_secrets_page_layout *layout;
> +	u64 count;
> +
> +	layout = snp_map_secrets_page();
> +	if (!layout)
> +		return 0;
> +
> +	/* Read the current message sequence counter from secrets pages */
> +	count = readl(&layout->os_area.msg_seqno_0);
> +
> +	iounmap(layout);
> +
> +	/* The sequence counter must begin with 1 */
> +	if (!count)
> +		return 1;
> +
> +	return count + 1;

As Borislav noted, you can remove the "if (!count) return 1" because in
that case (count==0) the "return count+1" will return exactly 1.

-Dov


> +}
> +
> +u64 snp_msg_seqno(void)
> +{
> +	u64 count = snp_read_msg_seqno();
> +
> +	if (unlikely(!count))
> +		return 0;
> +
> +	/*
> +	 * The message sequence counter for the SNP guest request is a
> +	 * 64-bit value but the version 2 of GHCB specification defines a
> +	 * 32-bit storage for the it.
> +	 */
> +	if (count >= UINT_MAX)
> +		return 0;
> +
> +	return count;
> +}
> +EXPORT_SYMBOL_GPL(snp_msg_seqno);
> +
> +static void snp_gen_msg_seqno(void)
> +{
> +	struct snp_secrets_page_layout *layout;
> +	u64 count;
> +
> +	layout = snp_map_secrets_page();
> +	if (!layout)
> +		return;
> +
> +	/*
> +	 * The counter is also incremented by the PSP, so increment it by 2
> +	 * and save in secrets page.
> +	 */
> +	count = readl(&layout->os_area.msg_seqno_0);
> +	count += 2;
> +
> +	writel(count, &layout->os_area.msg_seqno_0);
> +	iounmap(layout);
> +}
> +
>  int snp_issue_guest_request(int type, struct snp_guest_request_data *input, unsigned long *fw_err)
>  {
>  	struct ghcb_state state;
> @@ -2077,6 +2153,9 @@ int snp_issue_guest_request(int type, struct snp_guest_request_data *input, unsi
>  		ret = -EIO;
>  	}
>  
> +	/* The command was successful, increment the sequence counter */
> +	snp_gen_msg_seqno();
> +
>  e_put:
>  	__sev_put_ghcb(&state);
>  e_restore_irq:
> diff --git a/include/linux/sev-guest.h b/include/linux/sev-guest.h
> index 24dd17507789..16b6af24fda7 100644
> --- a/include/linux/sev-guest.h
> +++ b/include/linux/sev-guest.h
> @@ -20,6 +20,41 @@ enum vmgexit_type {
>  	GUEST_REQUEST_MAX
>  };
>  
> +/*
> + * The secrets page contains 96-bytes of reserved field that can be used by
> + * the guest OS. The guest OS uses the area to save the message sequence
> + * number for each VMPCK.
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
> +/* See the SNP spec for secrets page format */
> +struct snp_secrets_page_layout {
> +	u32 version;
> +	u32 imien	: 1,
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
>  /*
>   * The error code when the data_npages is too small. The error code
>   * is defined in the GHCB specification.
> @@ -36,6 +71,7 @@ struct snp_guest_request_data {
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  int snp_issue_guest_request(int vmgexit_type, struct snp_guest_request_data *input,
>  			    unsigned long *fw_err);
> +u64 snp_msg_seqno(void);
>  #else
>  
>  static inline int snp_issue_guest_request(int type, struct snp_guest_request_data *input,
> @@ -43,6 +79,7 @@ static inline int snp_issue_guest_request(int type, struct snp_guest_request_dat
>  {
>  	return -ENODEV;
>  }
> +static inline u64 snp_msg_seqno(void) { return 0; }
>  
>  #endif /* CONFIG_AMD_MEM_ENCRYPT */
>  #endif /* __LINUX_SEV_GUEST_H__ */
> 
