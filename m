Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B5C3EF160
	for <lists+linux-efi@lfdr.de>; Tue, 17 Aug 2021 20:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbhHQSIT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Aug 2021 14:08:19 -0400
Received: from mail-bn8nam11on2053.outbound.protection.outlook.com ([40.107.236.53]:53920
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231452AbhHQSIS (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 17 Aug 2021 14:08:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBL4HR54hCmsLY0hoSazrc8TxUI/WGe5LC0R7NTG22Mqwk+sW7BAE//9u1b68Bn81sROndLaRok+uSY5rQbaTAaqlQ5v/s/2cnxGoHtVC5HVv13of9SEithT6fqqGj7T6K/S+CTWf0b4RB7QDCVo44slJ2D5FaKDemodADA5smN7EEWa5u681mW4NtrVFd2FE6LOIZveB6sZkpQIYaojDxEnztA7L7my23jZnWJoxvwAzC9LfY7bQeu/eYrX/P+2v7yf//l1ant5FLBrp4A113UsDjDywdSUm1mDQWbNqewq6Xlvkiy89hJXnasJchAF5mpjBFflzMWvZj1NAOx27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XTh8DMdSjrMYv2eDdJl/uasRRbmRmutbvPIgKB7lFQ=;
 b=j0gjfiHLvlFfdcLWKm1Hnvrj0Y4VNdE6BIAYio+Z5jYGW1snk61g9E5ZY2CUkU/qcvX2z5PX9AjgtFam8nW8xD+ogH1w4o0fh70qXtN4zTDKDuUXKuzOUhFBGWD3TqqY5UACVgZlRHIz6VYcupS9t116ghm9JcdcKqlKyhKW86W/HD9/5nDso3dftuU6xfsCSrDplBq7cTMg9XIZu0S8YQlqziUgxrcmspn9jqCE7i9ogiwP+0rV3GvJ2WRmK5pz6JcAlTh9TLzwRiQrF30/cAWW60d07O8a+9MlVIwppebqN0V7QhwA67NiZeKKmRQ1DxnMP+94jTcHwgCCicZA5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XTh8DMdSjrMYv2eDdJl/uasRRbmRmutbvPIgKB7lFQ=;
 b=u+fJM9SnzWW+El29VopP15Md2GtsSdFwtcD+bA1S3NSpBzMS6FUj2o9zM1oPMEJkG7tW0pjR1FVDtWsAaTr1RKlQVK/y5L/rJb+Qb7xWnpAurzSk3CAJ68VDBz7z4DK0FBXEHmu1l0GismvpNlcV+5T2LxjlqDE00ykEooTZEOI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 18:07:42 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 18:07:42 +0000
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
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part1 RFC v4 15/36] x86/mm: Add support to validate memory
 when changing C-bit
To:     Borislav Petkov <bp@alien8.de>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-16-brijesh.singh@amd.com> <YRvxZtLkVNda9xwX@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <162d75ca-f0ec-bb7e-bb47-70060772a52c@amd.com>
Date:   Tue, 17 Aug 2021 13:07:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YRvxZtLkVNda9xwX@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0801CA0007.namprd08.prod.outlook.com
 (2603:10b6:803:29::17) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN4PR0801CA0007.namprd08.prod.outlook.com (2603:10b6:803:29::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 17 Aug 2021 18:07:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfaef9bb-8de0-438c-bf8a-08d961a9e81d
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4512547AFE84A2FC203BAB5EE5FE9@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BdivRqcRWaehpNz8VU5WKJK+ze+6UpRXIRlzgO6xfWE1WDZc90jaldNjP4uftOtQjbYzMwo4BAwnJ24bLJVothECLPC6JT45AQYXkhQCNR7AbRmUep77oonuyZwz1PrzwGjyJqq6H1/2HKfm2Sa3+rsDZ8UxtLNkw3ugPPbis/YkfMCxAode+B4MLu+eQgXkIjegpuICNTFlolw3UzbMQJQMAO5OpyRN3VRNFi9m15Aq29UevcI0XHjq5juB+ZohPPf05l+RcMSaVs8EqyXHXvD12zxxUg/JywLzVtGg6DaN2E0gAu9Zyau2vLGNxY6tB5uDQXkWEPie7KsK6Ze71FQBUFTRwAn2ZjnL87cjDWfUz1b4lQuSA2YiI5u5xc9xb0zhq+eObmYLbMHoyA7/Yhebf1iRuiE7k3YeNyLgfrRL+m0LvLV4TreVCVIzaoFvZlL2APv70p3iLNIeLdDLsfb9JiHEhFWk+AYU1tGv1TPd3R+nNovIRdlOR95ZivR3/hcvaO8wCEeKXkGOnxMT9q8mM4Jb4LErkZ62YKLcCk61RtiRvDQUJLjxLxL9tZwRJv2Lte5KXUQyRL2hHHHi6xAJtmrMw5STzHSi30+x7uGn5/3hho4cwb3pwhNA3PjlNEPK5uu9KgGbMEMdkUt1E9OHdOaqsIyM7MKsLcWyYHjpuoi9QCNC8hjaoiaMt1fnPIUGAbpQUOqSq8ioNkVQE72aLn2SuCJ/dZoRsTD8MNI+1oul0XaHblx2Rde70C34lMMZVeyu52rByQgp/J5u9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(6486002)(38100700002)(26005)(53546011)(316002)(54906003)(52116002)(478600001)(186003)(16576012)(66946007)(31686004)(36756003)(66476007)(66556008)(2616005)(38350700002)(83380400001)(7416002)(8936002)(86362001)(6916009)(956004)(7406005)(31696002)(2906002)(44832011)(4326008)(5660300002)(15650500001)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXU2L0Urek9sYk1qSFQ0dXNXaXFyYkNpdmJyOXF5K1JQSVhtVThITGM1cXp5?=
 =?utf-8?B?OE9Ncks4QUdVY2dybGhjMENzV0NYWktIUHQ4b000ZVR0YjVURk9MU0M5Zi9W?=
 =?utf-8?B?bXNLWFBtN2F0WXMzbXBFNG1wTlg0UVJ0Ky9LQlNHVEVab1h3Z002elNLQWdx?=
 =?utf-8?B?eSt1L1MxdjhwYW9iSGV2RjlUV3YwVXFHd0FhNU0yS2pHb1VkTlVjbVNpZEVB?=
 =?utf-8?B?MUN5ekQ2aDFIZkhYVEZ2QXNXd0l4TkhOeHZEY2Y1c00yZ2J4cElLeWFydW9W?=
 =?utf-8?B?eUVmU0hlRENjSTlpYnpYSUExcXR2Q09mZUhESEZ5MDlFejV1NUhGY2JvTUxx?=
 =?utf-8?B?V25wcllZNks3bjJ2eDAvZGJ2S1E0NlZYbmlMYXBjZzJOQlU0OVpnZzJPYU84?=
 =?utf-8?B?YWNhYkRmOW5JRTNDbmFiMFdKOWhSWTJHdGlORXFhV29Ca2FiR3ZTVVA5V2p5?=
 =?utf-8?B?NVY3eEhoTXJ4QWk1bTdqdjE4ZHF6TXdBSzAzcEMzNXdQRmpMUjlsZDJwamhw?=
 =?utf-8?B?eVRwbVUrVjFuZlJxQk12cDFSNDBTMTNyNlh6Qk1LeVpkUTlPODg0aFR3a2Nh?=
 =?utf-8?B?V0QrUzFJeG5SRHl2bm1BSHhUejlVQmc4WGk5U2dDLzl0Z3BvY21VeDJUbmFq?=
 =?utf-8?B?a2tLRDZMeHFRT2c0ekFDcTZQejFtcUJRbURyZzB2Y2V1UEFJbit6WnBuQzlp?=
 =?utf-8?B?dENrNEUrUmxzTUJQWkNZKzFWYmgvbDgwNm9qSEUranREeXRydm9rTEttQnVt?=
 =?utf-8?B?YStWeWM0ODZnQzZ1UmlsYkp3dFlYbkthQ09taUpXazRHQkRvTkd5WHlNcVdM?=
 =?utf-8?B?YzJlYzhmamsrZHBGQmNNSjdzd2VUT2xRSUJTSERtZ01FVDFXN2l3NndzZmJE?=
 =?utf-8?B?Nkw1UGU5RS9DNEV2S1hnZkdjdEFJZmVzUUpGeHd5V0hpbllCZjRQWWUwSWFk?=
 =?utf-8?B?OGNWUkJSYkFoTWxON01rdkRXblJHczY0eldFYmtCN3hPZHhUWWhLbGRIWEU0?=
 =?utf-8?B?cG1HZHlMM2tDMEpxdnVFWE5FSFMrUng3VkZFR3Y1ZnpqSXN4NEUvSXUwUzBE?=
 =?utf-8?B?SUVCZHFSVE1RbDZnandNcEkrZE1kcFNZeFV0dFNpTWZQZXhVWjdBOUlXR0N0?=
 =?utf-8?B?T3pUWk9ZRWZHcnprUS8vWFc0TTJvbjhGNzcvV1JUOTJ2c2NPcUVzVzh1ODAz?=
 =?utf-8?B?TkJZZU95NndaVG9aRmtmOGk1OStlNloxRFlLMlM4ZG5aSTJkd05lQ1l5bEFz?=
 =?utf-8?B?cXl1MmRIY3kwUUh0V2VUaHRHR0tqWU9LWUI3R2RFdU83bzhrcWRuRmRNdG5D?=
 =?utf-8?B?TWJUc0E1Y1N5THd0S1hZOVpVblFIeUZCNmMxRVJDU0pza0t2WG93YmNKdFVj?=
 =?utf-8?B?MEhIME5oajlsVXdFY0IyQlIvZmg0OVdHS0ZDdXRhZlVMYnFoZmNGTndXYkpU?=
 =?utf-8?B?ekc2Z04zbUgrNFNOTUMyMUZBUEtTR0JuM3BlT00wWmErVGJqbnkzM2NTdE5Y?=
 =?utf-8?B?L1BOcHZ0TzBlRUoyNzdQaDJLbkRiS1gyem1hNlFaZ3ZIdmR5bVBDVEtEakUx?=
 =?utf-8?B?WWtIaFgweWxVejIxMUszNjcyOFBXR1ZYYi9hVVVwQ1FTMW01eHhEaWxJV2xW?=
 =?utf-8?B?R0tQc1hrdXJUWnk0djFNeEtRVHgrVDRPZGJFMW5VZFU5elhwQTBEem9YMVpm?=
 =?utf-8?B?dy81KzIwNGlzVlgzMVNxbzFKVnBuTXdxQTB5UmNEN1hKUHArQ3FSZzBMa0tC?=
 =?utf-8?Q?UtGT+DOr06FBxJuZNN8JqGURNKx/2O2Dw6QSjyB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfaef9bb-8de0-438c-bf8a-08d961a9e81d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 18:07:42.5424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLcSnRylZj4ZNxfVYCu4bX9oQKbI+U3F0smPE06eHIWQ7gzZ4EdHmAhkjvM4WCnuLagFrEv/MmG2glZft7k4aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 8/17/21 12:27 PM, Borislav Petkov wrote:
> 
> The majority of kernel code puts __packed after the struct definition,
> let's put it there too pls, out of the way.
> 
> ...

Noted.

>> +		if (WARN(ret || ghcb->save.sw_exit_info_2,
>> +			 "SEV-SNP: page state change failed ret=%d exit_info_2=%llx\n",
>> +			 ret, ghcb->save.sw_exit_info_2))
>> +			return 1;
> 
> Yikes, you return here and below with interrupts disabled.
> 
> All your returns need to be "goto out;" instead where you do
> 
> out:
>          __sev_put_ghcb(&state);
>          local_irq_restore(flags);
> 
> Yap, you very likely need to put the GHCB too.
> 

Sure, let me revisit this code to fix those path.

>> +		/*
>> +		 * Lets do some sanity check that entry processing is not going
>> +		 * backward. This will happen only if hypervisor is tricking us.
>> +		 */
>> +		if (WARN((hdr->end_entry > end_entry) || (cur_entry > hdr->cur_entry),
>> +			"SEV-SNP: page state change processing going backward, end_entry "
>> +			"(expected %d got %d) cur_entry (expected %d got %d)\n",
>> +			end_entry, hdr->end_entry, cur_entry, hdr->cur_entry))
>> +			return 1;
> 
> WARNING: quoted string split across lines
> #293: FILE: arch/x86/kernel/sev.c:750:
> +			"SEV-SNP: page state change processing going backward, end_entry "
> +			"(expected %d got %d) cur_entry (expected %d got %d)\n",
> 
> If you're wondering what to do, yes, you can really stretch that string
> and shorten it too:

Okay.

> 
>                  if (WARN((hdr->end_entry > end_entry) || (cur_entry > hdr->cur_entry),
> "SEV-SNP: PSC processing going backwards, end_entry %d (got %d) cur_entry: %d (got %d)\n",
>                           end_entry, hdr->end_entry, cur_entry, hdr->cur_entry))
>                          return 1;
> 
> so that it fits on a single line and grepping can find it.
> 
Noted.

>> +		/* Lets verify that reserved bit is not set in the header*/
>> +		if (WARN(hdr->reserved, "Reserved bit is set in the PSC header\n"))
> 
> psc_entry has a ->reserved field too and since we're iterating over the
> entries...
> 
Sure I can add that check.


>> +
>> +	desc = kmalloc(sizeof(*desc), GFP_KERNEL_ACCOUNT);
> 
> kzalloc() so that you don't have to memset() later in
> __set_page_state().

Depending on the size, the __set_page_state() can be call multiple times 
so it should clear the desc memory before filling it.

> 
>> +	if (!desc)
>> +		panic("failed to allocate memory");
> 
> Make that error message more distinctive so that *if* it happens, one
> can pinpoint the place in the code where the panic comes from.
> 

Now I am running checkpatch and notice that it complain about the 
message too. I can add a BUG() or WARN() to get the stack trace before 
the crashing.

>> +	while (vaddr < vaddr_end) {
>> +		/*
>> +		 * Calculate the last vaddr that can be fit in one
>> +		 * struct snp_psc_desc.
>> +		 */
>> +		next_vaddr = min_t(unsigned long, vaddr_end,
>> +				(VMGEXIT_PSC_MAX_ENTRY * PAGE_SIZE) + vaddr);
>> +
>> +		__set_page_state(desc, vaddr, next_vaddr, op);
>> +
>> +		vaddr = next_vaddr;
>> +	}
>> +
>> +	kfree(desc);
>> +}
>> +
> 
