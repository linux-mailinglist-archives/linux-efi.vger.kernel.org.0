Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9CA3A66D9
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jun 2021 14:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbhFNMrW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Jun 2021 08:47:22 -0400
Received: from mail-mw2nam12on2068.outbound.protection.outlook.com ([40.107.244.68]:35968
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232764AbhFNMrV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Jun 2021 08:47:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXX5LF9N+HdLb+0lIrcuvaarzQKki/UF3luyRiNl1ady/2QVlxMwPHVhsO5UkDN84zWowAPXX34DkqdILf8cfF+GDBfvJNFb3g2l3HDu3yPhx2vwxyZGaVFJP4VuPE2y19u1dtV4uaqBReK2So4V3IQz9aGXgwKWBlwfGC2dR5l8v9v/SHBMSAnDQv7uYGWlmmfz8XQXUNkkLjjBqRXCsZd3/6yWcSNV+Xs0ZezyY9A6WmtKO3hYVdGLqnkjgFVFaM48fkTYV6Ev7ppecHMqXWGiXUJYFHvHB+4dvkr0Ai7ZMPpSjeG1I9nt88iRGUmyxQg9hU0ij9q9SnemBnWf5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9dvZu/xE+SqMBNp7L4Fk504MaY8+hJPN7eOd1kjBLw=;
 b=ROKSzc7lZ79XDszoUf5vuvY3PlcIGRNMc743pM++JJctG7WYWNfd2ydDsoFK3r2INdd5hlj+aaNuI6v3ewHMmePq+Yv7dHhgbK962yKcZuCDhRDyC4qHVzxNnttIcTrLgcWphwrXtVARM0IkpDiEppdZf6ra3JytZ/FIvF18yD/FgAUuqCisyIowcFKi8g1OvfAVEglwrbLr1XZJL547lebKhY+uII3SVULS+09cRc3osNAP5IBNtt5tAla3WaAhdBmsDnOU08qIZCQI4w1P/DTQEYsvW8DXL96qDxK4k9h5u9gv/oH7Xrgorkl8EazzJ13Y4rfrdJ8cJ26K33H6oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9dvZu/xE+SqMBNp7L4Fk504MaY8+hJPN7eOd1kjBLw=;
 b=EqDYluvhF1JdNpSMx1clqUAUufVMI07gtRe2M4uV2smxv9FykUEBKDF0EwEUvDF1fefCv4AJijK8ySOSJACmqg3KGrygubmFQnlT5J3aoz65SLy3Pfr9p/q+3jIaR8c815YfRux3/HDuFr8+io/LcMuWAsFiODRMJVwUu1ga1j0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2714.namprd12.prod.outlook.com (2603:10b6:5:42::18) by
 DM5PR12MB1626.namprd12.prod.outlook.com (2603:10b6:4:d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21; Mon, 14 Jun 2021 12:45:15 +0000
Received: from DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b]) by DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b%5]) with mapi id 15.20.4219.022; Mon, 14 Jun 2021
 12:45:15 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
Subject: Re: [PATCH Part1 RFC v3 11/22] x86/sev: Add helper for validating
 pages in early enc attribute changes
To:     Borislav Petkov <bp@alien8.de>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-12-brijesh.singh@amd.com> <YMI02+k2zk9eazjQ@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <d0759889-94df-73b0-4285-fa064eb187cd@amd.com>
Date:   Mon, 14 Jun 2021 07:45:11 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <YMI02+k2zk9eazjQ@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SN7PR04CA0109.namprd04.prod.outlook.com
 (2603:10b6:806:122::24) To DM6PR12MB2714.namprd12.prod.outlook.com
 (2603:10b6:5:42::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SN7PR04CA0109.namprd04.prod.outlook.com (2603:10b6:806:122::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 12:45:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f152b170-f079-4c1a-c1ad-08d92f32422e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1626:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1626E284FCDF0807E75D6891E5319@DM5PR12MB1626.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v0XSIhH1IaSRsjQ6tZBitrOIKK2+e1IM8kX9mxy4evS+GI0VfebHVUQyz9gfDvI6OqiGIB5VpbBzK8ssUT7VbB+R/RjZ/EtJQIGXfpK6ZRBNT+2eOD9roGx/2qLkwlPCnY7CI0owb2D0J40+s1IXGEdjb4pxUdz1EYVOtpuIXJY58g6RxjtQgOhi8n/zMY1lcgdYN7uWFU61i6kK3940Bztp+UFg07tQq54rI7QppkCbI/tjZVISKUaMCozDoXxKfBOSwG11gy4akWIt55POBJKMlxzGhUk09MPtij9Gsp6iVnXowJhia0SEp7iMmmlRC3UxiIUPtnrMIhJPx+b7YB0wMj/y9Ed6udsG5/9/LWTKFZNi8Aef+jPQ6E7MlAy9UrFCRPbBqtSCZaCT025DTu7ySYpIe9u6fx67ZVu3RIXKpAV1sxeCBndrGpSax+QZDN1jo3fhqy7s5A0tuhs9VdFLD4EXSqbGLL5rfO7IY7Aka4JI9gCkEnPYPZ1YasKzT8CT3Me1cph1U+iUUF42D2PhLA5zKiqGa3kMRASt7KgOf4N+hTIV5g+eJjZffagqzAPIzzj7azbWjk+XVbZ80xqs/nvQQIvmDpG9k3gGydTQsepaI61F32OTm2ZiVRcXfQN+QXMX2kib7nrbsjYBZXy6ypre4BrMiRaeAhgCh3dQIL0kwOTX5I5dKX6cMngxFm3XKv62wXtsH2y3JQNM8k9e8u8evz0QkQOdpx1ws+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(2906002)(86362001)(6512007)(83380400001)(316002)(956004)(30864003)(36756003)(6486002)(54906003)(5660300002)(38100700002)(478600001)(8676002)(53546011)(16526019)(44832011)(26005)(7416002)(8936002)(66946007)(4326008)(31696002)(38350700002)(6506007)(186003)(2616005)(52116002)(6916009)(66556008)(66476007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGpaUmNCSmxYQ3dlSTQ1bGI0WlcrSjljUFo1SUo3SkZvVVV0U2hvT3Z6emZ3?=
 =?utf-8?B?WGNyakRFUzNMakNyNjVWc0Q5eUFHQlE5am9qV0svN0JIQkNmTDYxYzJOVnhv?=
 =?utf-8?B?Rm4vVXZaWHpQbFpVdTFXYkdIQ0pHR1Fod0xHS0FsVTV3dVZVcEY3dUIwdWhy?=
 =?utf-8?B?M0VOVE0yV2R2c2dZS1FRZXJlMWJIUWh3QXlRM3hKNGozc0ROL0ZuREVrS0tQ?=
 =?utf-8?B?TEJGdW4rZUxXRFdvSFBmTldDM1A5bHcvdkRvMzVCY1VqVG14LzRTRklpTHVv?=
 =?utf-8?B?ZGpBTHdpQm9UVmtESDRkdGtzS1g5ZEtxcTVlMXlhSzZDU0dYRGl3cm5iQ21P?=
 =?utf-8?B?SUpzMlJZdGo0VUhXcURhVE9CSmhHVDg0aHhnSGdld1ZVaEtKSGFyMTRuTDZm?=
 =?utf-8?B?TjQ1WkgySGhGdkF2SHFRRUpjSHdQTk5odG5Ibk1HRVlESmZGU3IwTG9Va3h5?=
 =?utf-8?B?VlBjTURhOHpMa3ViaGh6SkZxdTFaSUR1dkUxVnRndVpqSUR0UmcwMDNjVk9l?=
 =?utf-8?B?WFJFY0U1Y1NpUlVybEVydS9IK2wzSFNQZnVOd0RYdEJpbnpnTEtUNXIxdUN6?=
 =?utf-8?B?YVd0aGdES2l4dC9rRmJ1MUh5TERjUzcwZWtnK1JTdnYvZmowNnR1LzJrbFY4?=
 =?utf-8?B?UmRmOFBSL2lINnRrRHVsRk90NDZtUlJnZjBIa2tqSXRxVDR5YjFzY0ppVzdH?=
 =?utf-8?B?WGhkOG9xbmRIWXNsUXdlOXp1dGVEYllCOGFJOWwzc1YvU2w2OFJUbzlhUlhI?=
 =?utf-8?B?QXk5U2VrS1FIOWFtYnlVK1JYcGJDZ0NUcmtja1paYzRsNDNGNHdIQUFKZUkz?=
 =?utf-8?B?VDdVektQYUE5a3BManNVaTNyckV0c3BNTXBXMXlueUZ3VWlIbGVSMFVmbnhD?=
 =?utf-8?B?VmlRejJnVDYyQzNUVE5uTVNWQmsyNW5SRUptSUJETVhCb1BXVlNQVFM4N0Vs?=
 =?utf-8?B?eUR3RnRWNlZpc0Zacy85ajYvSTRVMDNIZWQySXovNjhGNjdzbWpKVjljUXJk?=
 =?utf-8?B?TUQrb1Z6V3ZkRm80OVU5cHRydWZIeS9oWEZuNzgxL2k5UzgxMFpZbmlzVVB0?=
 =?utf-8?B?WXdRZmFzdmFHQXd6emZUWllNMmwvMURvRFRPN1RWUUpoaEw5elkyeWtTbG1R?=
 =?utf-8?B?RnRHK1FkMDAxRVppOUlVUm5wMFF1VUdQakthS2hGZGI1aW45cUdaQjZtMWVT?=
 =?utf-8?B?K0xXdjc4L3RMTGd2ZkNaOGR3RzZkakNTWUdKR2ZpME01ZFpGaS9tWDRyY0sw?=
 =?utf-8?B?MXBRZ2lJb3A1aGYwRTBQL3VLUHpUdFZUbzR5cWFObXVwYWpKdTJTK3JVb3RV?=
 =?utf-8?B?UGM5S2VTQ1pVamZSR2JmdE84eE8wc0M4S0I4d2RrdkxYb0ZZeWlmNmFiZGZI?=
 =?utf-8?B?N0pqRjVLeTk4dVEzd2lzTnhsQThEL0Y1UFVQYW9UVUVqN1IzMXJ1QUlvM1l5?=
 =?utf-8?B?c25mSVFZWUxiemR4RjVjUzZLVStRMzhUZWFlV1llRFdlS2ptTUcwbkxzdkx6?=
 =?utf-8?B?UkZ2Y2NVa2hMTHMvN2pBNDQyckhyNVFxODg1a2Z2bkFnM0F5SHJoc1FoVWNH?=
 =?utf-8?B?Tzd3ZHZWNTcydW5JMloxTWpRNUkvcDF6Q0thSG51RzJvbk1ZUXF4VXZpQU9G?=
 =?utf-8?B?dDR4SGcrTFpLaHlPU1RxV2EwTUdXQW1wc2NtVW5UMmt3RisrV01JazJid0Yx?=
 =?utf-8?B?Ykx1UTMza01yWW11VFlqTnVER0l5U0haZE5pUzBBZHJpd3lQcVpYcnp4TjlR?=
 =?utf-8?Q?V+5Mi4nhNdPQQgGLUZaeq2cLNVan7eZGDAnp94T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f152b170-f079-4c1a-c1ad-08d92f32422e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 12:45:15.6865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Rwgu/7Dvb/kORSHlpFT+ELfKqR5ZCLyFToMy3IPxWyKX4v8F4wzmJNDT63B7HIqvYuWBDtSXrN+5FGs5fi5QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1626
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 6/10/21 10:50 AM, Borislav Petkov wrote:
> On Wed, Jun 02, 2021 at 09:04:05AM -0500, Brijesh Singh wrote:
>> @@ -65,6 +65,12 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
>>  /* RMP page size */
>>  #define RMP_PG_SIZE_4K			0
>>  
>> +/* Memory opertion for snp_prep_memory() */
>> +enum snp_mem_op {
>> +	MEMORY_PRIVATE,
>> +	MEMORY_SHARED
> See below.
>
>> +};
>> +
>>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>>  extern struct static_key_false sev_es_enable_key;
>>  extern void __sev_es_ist_enter(struct pt_regs *regs);
>> @@ -103,6 +109,11 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
>>  
>>  	return rc;
>>  }
>> +void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
>> +		unsigned int npages);
>> +void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
>> +		unsigned int npages);
> Align arguments on the opening brace.

Noted.


>
>> +void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op);
>>  #else
>>  static inline void sev_es_ist_enter(struct pt_regs *regs) { }
>>  static inline void sev_es_ist_exit(void) { }
>> @@ -110,6 +121,15 @@ static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { ret
>>  static inline void sev_es_nmi_complete(void) { }
>>  static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
>>  static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
>> +static inline void __init
>> +early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned int npages)
> Put those { } at the end of the line:
>
> early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned int npages) { }
>
> no need for separate lines. Ditto below.

Noted.


>
>> +{
>> +}
>> +static inline void __init
>> +early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned int npages)
>> +{
>> +}
>> +static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op) { }
>>  #endif
>>  
>>  #endif
>> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>> index 455c09a9b2c2..6e9b45bb38ab 100644
>> --- a/arch/x86/kernel/sev.c
>> +++ b/arch/x86/kernel/sev.c
>> @@ -532,6 +532,111 @@ static u64 get_jump_table_addr(void)
>>  	return ret;
>>  }
>>  
>> +static void pvalidate_pages(unsigned long vaddr, unsigned int npages, bool validate)
>> +{
>> +	unsigned long vaddr_end;
>> +	int rc;
>> +
>> +	vaddr = vaddr & PAGE_MASK;
>> +	vaddr_end = vaddr + (npages << PAGE_SHIFT);
>> +
>> +	while (vaddr < vaddr_end) {
>> +		rc = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
>> +		if (WARN(rc, "Failed to validate address 0x%lx ret %d", vaddr, rc))
>> +			sev_es_terminate(1, GHCB_TERM_PVALIDATE);
> 					^^
>
> I guess that 1 should be a define too, if we have to be correct:
>
> 			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
>
> or so. Ditto for all other calls of this.

Sure, I will define a macro for it.


>
>> +
>> +		vaddr = vaddr + PAGE_SIZE;
>> +	}
>> +}
>> +
>> +static void __init early_set_page_state(unsigned long paddr, unsigned int npages, int op)
>> +{
>> +	unsigned long paddr_end;
>> +	u64 val;
>> +
>> +	paddr = paddr & PAGE_MASK;
>> +	paddr_end = paddr + (npages << PAGE_SHIFT);
>> +
>> +	while (paddr < paddr_end) {
>> +		/*
>> +		 * Use the MSR protocol because this function can be called before the GHCB
>> +		 * is established.
>> +		 */
>> +		sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
>> +		VMGEXIT();
>> +
>> +		val = sev_es_rd_ghcb_msr();
>> +
>> +		if (GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP)
> From a previous review:
>
> Does that one need a warning too or am I being too paranoid?

IMO, there is no need to add a warning. This case should happen if its
either a hypervisor bug or hypervisor does not follow the GHCB
specification. I followed the SEV-ES vmgexit handling  and it does not
warn if the hypervisor returns a wrong response code. We simply
terminate the guest.


>
>> +			goto e_term;
>> +
>> +		if (WARN(GHCB_MSR_PSC_RESP_VAL(val),
>> +			 "Failed to change page state to '%s' paddr 0x%lx error 0x%llx\n",
>> +			 op == SNP_PAGE_STATE_PRIVATE ? "private" : "shared",
>> +			 paddr, GHCB_MSR_PSC_RESP_VAL(val)))
>> +			goto e_term;
>> +
>> +		paddr = paddr + PAGE_SIZE;
>> +	}
>> +
>> +	return;
>> +
>> +e_term:
>> +	sev_es_terminate(1, GHCB_TERM_PSC);
>> +}
>> +
>> +void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
>> +					 unsigned int npages)
>> +{
>> +	if (!sev_feature_enabled(SEV_SNP))
>> +		return;
>> +
>> +	 /* Ask hypervisor to add the memory pages in RMP table as a 'private'. */
> 	    Ask the hypervisor to mark the memory pages as private in the RMP table.

Noted.


>
>> +	early_set_page_state(paddr, npages, SNP_PAGE_STATE_PRIVATE);
>> +
>> +	/* Validate the memory pages after they've been added in the RMP table. */
>> +	pvalidate_pages(vaddr, npages, 1);
>> +}
>> +
>> +void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
>> +					unsigned int npages)
>> +{
>> +	if (!sev_feature_enabled(SEV_SNP))
>> +		return;
>> +
>> +	/*
>> +	 * Invalidate the memory pages before they are marked shared in the
>> +	 * RMP table.
>> +	 */
>> +	pvalidate_pages(vaddr, npages, 0);
>> +
>> +	 /* Ask hypervisor to make the memory pages shared in the RMP table. */
> 			      mark

Noted.


>> +	early_set_page_state(paddr, npages, SNP_PAGE_STATE_SHARED);
>> +}
>> +
>> +void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op)
>> +{
>> +	unsigned long vaddr, npages;
>> +
>> +	vaddr = (unsigned long)__va(paddr);
>> +	npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
>> +
>> +	switch (op) {
>> +	case MEMORY_PRIVATE: {
>> +		early_snp_set_memory_private(vaddr, paddr, npages);
>> +		return;
>> +	}
>> +	case MEMORY_SHARED: {
>> +		early_snp_set_memory_shared(vaddr, paddr, npages);
>> +		return;
>> +	}
>> +	default:
>> +		break;
>> +	}
>> +
>> +	WARN(1, "invalid memory op %d\n", op);
> A lot easier, diff ontop of your patch:

thanks. I will apply it.

I did thought about reusing the VMGEXIT defined macro
SNP_PAGE_STATE_{PRIVATE, SHARED} but I was not sure if you will be okay
with that. Additionally now both the function name and macro name will
include the "SNP". The call will look like this:

snp_prep_memory(paddr, SNP_PAGE_STATE_PRIVATE)

>
> ---
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 7c2cb5300e43..2ad4b5ab3f6c 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -65,12 +65,6 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
>  /* RMP page size */
>  #define RMP_PG_SIZE_4K			0
>  
> -/* Memory opertion for snp_prep_memory() */
> -enum snp_mem_op {
> -	MEMORY_PRIVATE,
> -	MEMORY_SHARED
> -};
> -
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  extern struct static_key_false sev_es_enable_key;
>  extern void __sev_es_ist_enter(struct pt_regs *regs);
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 2a5dce42af35..991d7964cee9 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -662,20 +662,13 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op)
>  	vaddr = (unsigned long)__va(paddr);
>  	npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
>  
> -	switch (op) {
> -	case MEMORY_PRIVATE: {
> +	if (op == SNP_PAGE_STATE_PRIVATE)
>  		early_snp_set_memory_private(vaddr, paddr, npages);
> -		return;
> -	}
> -	case MEMORY_SHARED: {
> +	else if (op == SNP_PAGE_STATE_SHARED)
>  		early_snp_set_memory_shared(vaddr, paddr, npages);
> -		return;
> +	else {
> +		WARN(1, "invalid memory page op %d\n", op);
>  	}
> -	default:
> -		break;
> -	}
> -
> -	WARN(1, "invalid memory op %d\n", op);
>  }
>  
>  int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
> ---
>
>>  static char sme_early_buffer[PAGE_SIZE] __initdata __aligned(PAGE_SIZE);
>>  
>> +/*
>> + * When SNP is active, changes the page state from private to shared before
> s/changes/change/

Noted.


>
>> + * copying the data from the source to destination and restore after the copy.
>> + * This is required because the source address is mapped as decrypted by the
>> + * caller of the routine.
>> + */
>> +static inline void __init snp_memcpy(void *dst, void *src, size_t sz,
>> +				     unsigned long paddr, bool decrypt)
>> +{
>> +	unsigned long npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
>> +
>> +	if (!sev_feature_enabled(SEV_SNP) || !decrypt) {
>> +		memcpy(dst, src, sz);
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * If the paddr needs to be accessed decrypted, mark the page
> What do you mean "If" - this is the SNP version of memcpy. Just say:
>
> 	/*
> 	 * With SNP, the page address needs to be ...
> 	 */
>
>> +	 * shared in the RMP table before copying it.
>> +	 */
>> +	early_snp_set_memory_shared((unsigned long)__va(paddr), paddr, npages);
>> +
>> +	memcpy(dst, src, sz);
>> +
>> +	/* Restore the page state after the memcpy. */
>> +	early_snp_set_memory_private((unsigned long)__va(paddr), paddr, npages);
>> +}
>> +
>>  /*
>>   * This routine does not change the underlying encryption setting of the
>>   * page(s) that map this memory. It assumes that eventually the memory is
>> @@ -96,8 +125,8 @@ static void __init __sme_early_enc_dec(resource_size_t paddr,
>>  		 * Use a temporary buffer, of cache-line multiple size, to
>>  		 * avoid data corruption as documented in the APM.
>>  		 */
>> -		memcpy(sme_early_buffer, src, len);
>> -		memcpy(dst, sme_early_buffer, len);
>> +		snp_memcpy(sme_early_buffer, src, len, paddr, enc);
>> +		snp_memcpy(dst, sme_early_buffer, len, paddr, !enc);
>>  
>>  		early_memunmap(dst, len);
>>  		early_memunmap(src, len);
>> @@ -277,9 +306,23 @@ static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
>>  	else
>>  		sme_early_decrypt(pa, size);
>>  
>> +	/*
>> +	 * If page is getting mapped decrypted in the page table, then the page state
>> +	 * change in the RMP table must happen before the page table updates.
>> +	 */
>> +	if (!enc)
>> +		early_snp_set_memory_shared((unsigned long)__va(pa), pa, 1);
> Merge the two branches:

Noted.


>
> 	/* Encrypt/decrypt the contents in-place */
>         if (enc) {
>                 sme_early_encrypt(pa, size);
>         } else {
>                 sme_early_decrypt(pa, size);
>
>                 /*
>                  * On SNP, the page state change in the RMP table must happen
>                  * before the page table updates.
>                  */
>                 early_snp_set_memory_shared((unsigned long)__va(pa), pa, 1);
>         }

- Brijesh

