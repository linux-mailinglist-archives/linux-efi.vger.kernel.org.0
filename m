Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB323A6769
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jun 2021 15:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbhFNNIC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Jun 2021 09:08:02 -0400
Received: from mail-dm6nam11on2068.outbound.protection.outlook.com ([40.107.223.68]:49664
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233633AbhFNNIB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Jun 2021 09:08:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVAO5uaWnkTSQMrw4bG9p41eRI36s9NhfFdqk5y0AL19MJWSrHt1rUL+0nzg/nn+eox39xIMrpaEOnsS0xqPBA6JKZI5E3piYA1cpgxGCZOG62FAY+bMagKTNw38LahTSKPMnM4l1gH1zV8JS5KPzM9JcW7VSKCBBiMDS1Rm0bvSreh3YYu5zsQ5HlZJtED9MuV+go7Ezc6yHKGOK/WEQycFaQkXF81kPaW2obedpqiqZU/UCZDuoHBUC948lYPQrAtKYHHb/+BboAcDOcc5AqivflDs2IoaJcr5JyDpQh67vEFLFUGsgo4yvpVvAExq4i5e0+oxmtb0yl80n8kWNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrU9uQTY4LccVRsyLSTQkJaFZGyuVzHq6kjmehqMyAM=;
 b=bVWNRocJICIRXP3VLqeFiocwFbJLPsQWivti9dwSITp4cUzslymiiDNv1pfi9mN0qsqKu2Nbtf/NU+xEmerC3ROCgEwCeT6YztpzBjRMw6V0x+trlilneubAXNnMyQTLdLbF7c1U2VhZQPHfi4dzricl6H7XOO3ysXOO8sUfdL5Y6P31N8p2GwKPR5UmdJLkgii8YpT0R/c+kZ0HkJaZGynlK2bfYbTAhXrYmK4DNA3ZiY4Z36do44dp6P79KBSIjOCN5ZdL9sYxFeOkx/nG1bSKk+qdeYIZyVIA5iI+qJIK3RgQZrG+Vfd3HqGJO44EzFq8WSrjHSJnc3E24000vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrU9uQTY4LccVRsyLSTQkJaFZGyuVzHq6kjmehqMyAM=;
 b=pWFSnknLht51+8mM9k5amyt6IY7FV2aIXDrzkahA7nCSGuH4/tVqRr1Lik3Sy9Ud0eq6txWaEw9i7ocOp/KMHaEwgC2blhQoZwEgstZUYyvUNUVhehEoJFIcl73AUBsSR3flGwWLA7BU+9F/zaBF/XkIpXOUMWZu5ReqorM8P/Y=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2714.namprd12.prod.outlook.com (2603:10b6:5:42::18) by
 DM5PR1201MB0075.namprd12.prod.outlook.com (2603:10b6:4:54::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.22; Mon, 14 Jun 2021 13:05:56 +0000
Received: from DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b]) by DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b%5]) with mapi id 15.20.4219.022; Mon, 14 Jun 2021
 13:05:56 +0000
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
Subject: Re: [PATCH Part1 RFC v3 14/22] x86/mm: Add support to validate memory
 when changing C-bit
To:     Borislav Petkov <bp@alien8.de>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-15-brijesh.singh@amd.com> <YMMwdJRwbbsh1VVO@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <267dc549-fcef-480e-891c-effd3d5b2058@amd.com>
Date:   Mon, 14 Jun 2021 08:05:51 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <YMMwdJRwbbsh1VVO@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SN4PR0601CA0012.namprd06.prod.outlook.com
 (2603:10b6:803:2f::22) To DM6PR12MB2714.namprd12.prod.outlook.com
 (2603:10b6:5:42::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SN4PR0601CA0012.namprd06.prod.outlook.com (2603:10b6:803:2f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 13:05:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e599aa26-8018-4599-43e9-08d92f352572
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0075:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0075692BED159011B849320CE5319@DM5PR1201MB0075.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DkexGXIpvxQvo+/nijBu90sjew+QOdE/aAX6PCX5SM9GIYxDWeyfrIb1CtYcrlayU5KZnnpatVi+0u/Qo3pSgrPZzAYLJgHabgx8J9mRBj5KVJEpowykI90yt+oR+zqyJfwdEuRwVqondc8jpnH1ywBIQalg7XnHvZyPli04snsvvWlC87yeIzk8kriFH9lZKDODkPpGNQkjtd2e5VlRwyR+kp/f5sx4GHVknD3Wx47d5EmEULBtBT0J3n/mFqODM3FUaxV1j2b988THIZZK7zDR0GxC6cTK7e4gdz8uZFf8iQOtOqcqLyHVD1q6vgy01Ia6JEItlWouRYZnGn7ZYGQeedHY5z6c9Gtw4pB9xti7BekKz91P3zR6eygHDA234pJyccJnXvWAEgB4JnmjnO9DMzTwEc4TjQK6snnZT0lGVsHhTXcuDiE4Qw4n7NcX/Kwboz+a6qIcPHyeEvMvOMOh3anVWli2P0ijtCoUDnchL6/q6ggAqrd1dTeLuiso17k5qDjHUXSXHw3DMJZYTG/QG+uGQ0VU4KFTm1dxSHLhMryiR/w2olWKQZhJdzl6wdC+rauyD/QP/Nh3KSNrexTXa2dzvEAJbN5yYV0OqEankEZPYGSrg+XLJ2BeZUVVf9Udslq7LfjkpL/J75avOZii2bKZTTgt94NZGT3+sbuJ9oNwixTUObub6eHM8C0LMxocWt/3T1Dt+Oq95+G8rQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(31696002)(6512007)(38350700002)(186003)(478600001)(6916009)(316002)(54906003)(26005)(16526019)(86362001)(38100700002)(6486002)(8936002)(8676002)(6506007)(53546011)(52116002)(4326008)(36756003)(956004)(44832011)(2906002)(66476007)(66556008)(66946007)(7416002)(83380400001)(31686004)(2616005)(15650500001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2g5eU1EMlRLRTZWdXpXWkE4VHRXWlUvU3FnTXdneXAzU0pMaDlsWEg4VnNX?=
 =?utf-8?B?VGNDS3YrZzNpc2VNL2RWWkxaaDdZZUYwaXRiZXQ5TUFvNUtidmdGNnhuclYw?=
 =?utf-8?B?QmFERWpnYzBBOWRSblJObGRTbktSemZuTUxvWWU2emxaSkY1ajVXR1hkRXVI?=
 =?utf-8?B?SU1oMmhqU0hLTWxpVGpucWQrMHYyc1RybTBSZXJOY1YzNTE2NEkxUE5SVE1z?=
 =?utf-8?B?MTh0QzZxckVBN05mSGJVcTc3Zkg5aTMwM0JidlllUVYvaitub2hGNjZRbVFx?=
 =?utf-8?B?ZnVNdXRkbmVacVNtc2VqR0tRYW9mK0FvUHJDNVFuaXhKaGJOMHhQRk9qaXVk?=
 =?utf-8?B?Uzg5LzhjQXlrdktTaXN0cllKV01QMXkyUk12NkE2NXVEZGhsdTVxK2pzRVZj?=
 =?utf-8?B?c00yQ3lZU0xjbTZsc3hpN0hJOEJadVVEZGJ1b090cnBxazN5cE5IcFBmWk5F?=
 =?utf-8?B?YTE3ZHRPQUxRWHp6MzVCZ2tFS0tlbFFQaHpqSFBONmpPeU4yU3Z0eitERTJZ?=
 =?utf-8?B?L25ZaXZaNWdYT29hWHFzRUNJWmdtV2I3dkJKbGtrMEwrWHo0djJtZDBESnFE?=
 =?utf-8?B?YnpleERONUZ0T1FkZFg3am1jZFpqeVk4eEFTb2w4UVpMZlJDcnlYb1BITmxZ?=
 =?utf-8?B?Y25veHV1a2czaCtIS0RjMmQraGFhRG0yc0d6WG5qV3RieXJiZE5rK2VaS09W?=
 =?utf-8?B?bm01b3RVUncvZ1FqcVVuVUEzajRlTlJyS1JaS1Z2VjdlRlNnR0xDRko4bWFQ?=
 =?utf-8?B?bDVlc0IvaFhXcjkxeVRLQ3M1eU9jYkpLSVpPRmErdUw2Y3NpOUNHQml0OGJ0?=
 =?utf-8?B?MVpwRzAreGREQk1PZm1RVFU5WDhmOEZzS25yRERrMGNjUzMvM3JkUTNMUDZP?=
 =?utf-8?B?RlF2OW5UNUZ0QTVXOXpFUFZUVTEwVnh0aUh1K05FY0JhTnErczMwcFlaeHAx?=
 =?utf-8?B?VFhQMS90YmMwNzVIN21LUlZHTzZrRUpJZjlGMXoyVVhYMEg4QldYS01zQ3lj?=
 =?utf-8?B?K29KNm02enlWeVJHMWRhdGtEajNsbEhpSHJIdmJnWjBYcHRmMW9qcGhoaDZ5?=
 =?utf-8?B?djV4Qko0eWxLN1dHb0pseUE4NXR4WWZDRHM4QmdoQUtMdWxkVzgvVWpyZEVY?=
 =?utf-8?B?eC9rWEE4cG1xZFM2TlN1QkNrNDhCQWNJSndQbU5NMk1reFp4UUlFeHM1WGtl?=
 =?utf-8?B?cFNCdXJ4YVZSM3lTZU91WC9idmUzMzJpVWxGcERNV3A1cTV5L0FWYW1DTXpL?=
 =?utf-8?B?OUpFU1c2SnI0U1F0UWZiYzEvQ2kvNEtlWjduUzVmcDZFOEVSR09UZExPOUZx?=
 =?utf-8?B?Q2l0bk9lK0JaVmdVVW52bVIvZ0pxMmRYRjlMcXltZDRLSWdlc1lab1VoOXhU?=
 =?utf-8?B?WjU0Yi82cDB0MDFhWjZZdHl0bHFEakpJZld4bHlqVEliVExzM0VUd3ZqME1N?=
 =?utf-8?B?dktiTHhUTlk4b2pITTJwTGkvVFJieTlJV0p5L0JMcDNUNXgyVEVGM3MrOFFD?=
 =?utf-8?B?S1VxaEp0VmR4L0ZkOUlIY0NqMGRaZlg0UGljdGs0b1JYVDNFRGZJQlNmU0pl?=
 =?utf-8?B?NU8zOGpraDc2YU5vYm1mZWhtNTQ5Y1FONVdMOVptNUxOOThMOURmb2d5MlNn?=
 =?utf-8?B?emxBdGo5OWw4WUM0OVBBdk9vN1R0MWQwVXV3U3lPd2ZiblJUOHpobGsyNHph?=
 =?utf-8?B?c0pjWmlLVGFBL3FnOG9HOVY5UmRBZWpXalQwa01FUHFWeVhSalFIS2Qyajl4?=
 =?utf-8?Q?s+u9/XCKOfud6JHX0zFrX2/VUfgile7ax0kNXza?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e599aa26-8018-4599-43e9-08d92f352572
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 13:05:55.9182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmlL+8Ycjl0SzlZH3rlOHBGp1+ksTU7Ae/dFu2TKAOTnzg/TiDivniYr00TixSuurBNr1IMKK1MgnkqJ/47fEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0075
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 6/11/21 4:44 AM, Borislav Petkov wrote:
> On Wed, Jun 02, 2021 at 09:04:08AM -0500, Brijesh Singh wrote:
>> +/* SNP Page State Change NAE event */
>> +#define VMGEXIT_PSC_MAX_ENTRY		253
>> +
>> +struct __packed snp_page_state_header {
> psc_hdr

Noted.


>> +	u16 cur_entry;
>> +	u16 end_entry;
>> +	u32 reserved;
>> +};
>> +
>> +struct __packed snp_page_state_entry {
> psc_entry

Noted.


>
>> +	u64	cur_page	: 12,
>> +		gfn		: 40,
>> +		operation	: 4,
>> +		pagesize	: 1,
>> +		reserved	: 7;
>> +};
>> +
>> +struct __packed snp_page_state_change {
> snp_psc_desc
>
> or so.

Noted.


>
>> +	struct snp_page_state_header header;
>> +	struct snp_page_state_entry entry[VMGEXIT_PSC_MAX_ENTRY];
>> +};
> Which would make this struct a lot more readable:
>
> struct __packed snp_psc_desc {
> 	struct psc_hdr hdr;
> 	struct psc_entry entries[VMGEXIT_PSC_MAX_ENTRY];
>
Agreed.


>> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>> index 6e9b45bb38ab..4847ac81cca3 100644
>> --- a/arch/x86/kernel/sev.c
>> +++ b/arch/x86/kernel/sev.c
>> @@ -637,6 +637,113 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op)
>>  	WARN(1, "invalid memory op %d\n", op);
>>  }
>>  
>> +static int page_state_vmgexit(struct ghcb *ghcb, struct snp_page_state_change *data)
> vmgexit_psc

Noted.


>> +{
>> +	struct snp_page_state_header *hdr;
>> +	int ret = 0;
>> +
>> +	hdr = &data->header;
> Make sure to verify that snp_page_state_header.reserved field is always
> 0 before working more on the header so that people don't put stuff in
> there which you cannot change later because it becomes ABI or whatnot.
> Ditto for the other reserved fields.
>
Good point, let me go through both the hypervisor and guest to make sure
that reserved fields are all zero (as defined by the GHCB spec).


>> +
>> +	/*
>> +	 * As per the GHCB specification, the hypervisor can resume the guest before
>> +	 * processing all the entries. The loop checks whether all the entries are
> s/The loop checks/Check/

Noted.


>
>> +	 * processed. If not, then keep retrying.
> What guarantees that that loop will terminate eventually?

Guest OS depend on the hypervisor to assist in this operation. The loop
will terminate only after the hypervisor completes the requested
operation. Guest is not protecting itself from DoS type of attack. A
guest should not proceed until hypervisor performs the request page
state change in the RMP table.


>> +	 */
>> +	while (hdr->cur_entry <= hdr->end_entry) {
> I see that "[t]he hypervisor should ensure that cur_entry and end_entry
> represent values within the limits of the GHCB Shared Buffer." but let's
> sanity-check that HV here too. We don't trust it, remember? :)

Let me understand, are you saying that hypervisor could trick us into
believing that page state change completed without actually changing it ?


>> +
>> +		ghcb_set_sw_scratch(ghcb, (u64)__pa(data));
>> +
>> +		ret = sev_es_ghcb_hv_call(ghcb, NULL, SVM_VMGEXIT_PSC, 0, 0);
>> +
>> +		/* Page State Change VMGEXIT can pass error code through exit_info_2. */
>> +		if (WARN(ret || ghcb->save.sw_exit_info_2,
>> +			 "SEV-SNP: page state change failed ret=%d exit_info_2=%llx\n",
>> +			 ret, ghcb->save.sw_exit_info_2))
>> +			return 1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void set_page_state(unsigned long vaddr, unsigned int npages, int op)
>> +{
>> +	struct snp_page_state_change *data;
>> +	struct snp_page_state_header *hdr;
>> +	struct snp_page_state_entry *e;
>> +	unsigned long vaddr_end;
>> +	struct ghcb_state state;
>> +	struct ghcb *ghcb;
>> +	int idx;
>> +
>> +	vaddr = vaddr & PAGE_MASK;
>> +	vaddr_end = vaddr + (npages << PAGE_SHIFT);
> Move those...
>
>> +
>> +	ghcb = sev_es_get_ghcb(&state);
>> +	if (unlikely(!ghcb))
>> +		panic("SEV-SNP: Failed to get GHCB\n");
> <--- ... here.

Noted.


>
>> +
>> +	data = (struct snp_page_state_change *)ghcb->shared_buffer;
>> +	hdr = &data->header;
>> +
>> +	while (vaddr < vaddr_end) {
>> +		e = data->entry;
>> +		memset(data, 0, sizeof(*data));
>> +
>> +		for (idx = 0; idx < VMGEXIT_PSC_MAX_ENTRY; idx++, e++) {
>> +			unsigned long pfn;
>> +
>> +			if (is_vmalloc_addr((void *)vaddr))
>> +				pfn = vmalloc_to_pfn((void *)vaddr);
>> +			else
>> +				pfn = __pa(vaddr) >> PAGE_SHIFT;
>> +
>> +			e->gfn = pfn;
>> +			e->operation = op;
>> +			hdr->end_entry = idx;
>> +
>> +			/*
>> +			 * The GHCB specification provides the flexibility to
>> +			 * use either 4K or 2MB page size in the RMP table.
>> +			 * The current SNP support does not keep track of the
>> +			 * page size used in the RMP table. To avoid the
>> +			 * overlap request, use the 4K page size in the RMP
>> +			 * table.
>> +			 */
>> +			e->pagesize = RMP_PG_SIZE_4K;
>> +			vaddr = vaddr + PAGE_SIZE;
> Please put that
> 			e++;
>
> here.
>
> It took me a while to find it hidden at the end of the loop and was
> scratching my head as to why are we overwriting e-> everytime.

Ah, sure I will do it.


>> +
>> +			if (vaddr >= vaddr_end)
>> +				break;
> Instead of this silly check here, you can compute the range starting at
> vaddr, VMGEXIT_PSC_MAX_ENTRY pages worth, carve out that second for-loop
> in a helper called
>
> __set_page_state()
>
> which does the data preparation and does the vmgexit at the end.
>
> Then the outer loop does only the computation and calls that helper.

Okay, I will look into rearranging the code a bit more to address your
feedback.

-Brijesh
