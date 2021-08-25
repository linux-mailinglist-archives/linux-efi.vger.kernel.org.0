Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EFA3F76A2
	for <lists+linux-efi@lfdr.de>; Wed, 25 Aug 2021 15:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbhHYNz2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Aug 2021 09:55:28 -0400
Received: from mail-bn8nam11on2052.outbound.protection.outlook.com ([40.107.236.52]:57793
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231927AbhHYNz1 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 25 Aug 2021 09:55:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELCnA4qVH6U8kaHnHvDQEvDFZcxh2FJ+Mp/exaEiXom4Zn4dhEu3NMifahsr3iMsZP4mZUXKUo/b7ofqCyIZlq4x0p2lMShWZFrnf11wry7akITAaocfVysXhocPuohROTIJrE1wLHXXs9jJiPkY34VwjG2Q1ZpWI49Ae/FllmATE4XRuMt5iSN9+4PGVXgdNQ1G80BX6ZpTFjimoZBIUHKVjr4PW4tLRC9VLNhX5n1T47ov05JJw5aaovbmMCmuWgJOYIF3r4BjEFivJfwV0DsO2lJPRA4A0bfMHKpCfFvoqVsxxC4aESaF58dUccCkB3C8OmC0ZFYtxuFCzbaTYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKxbaDS0O/tGln3o/+oe54T/in+s485/48Z2++nze2Y=;
 b=YCOFrLoeuLTthhYO3QnEn+LKIPuvv3o+e0VVH7HZ6ujAP4B8DdaayrVqmsrdbzrKDwwxjIVJDr5W26FcOPZCGugiKsUtXUQSQZOriZknEBku1r9YMU5L9IA14ghIXOxoBLDuZA3d/fvQ/F3Mn5EJweGaiTnaUQgujgpZGgOJ5vG6zgtnJxuF8A75mI5jSa9grGEjCoYr0QSXltxZhn8JicSnat4y7WtCEekvMUZM0V55rMpeVDQD0DzwI1Aw8TOkvujFzKXojnWVLG9SgpI11AMlmAJ1Q1mB+zqRComxe1SsATIuZgMLcpoYhzLJ+5NT6OQDSoxSMt8vjOTD3ahyhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKxbaDS0O/tGln3o/+oe54T/in+s485/48Z2++nze2Y=;
 b=4JOGNRRtf2031F4fjPqaE5lmpx8T5GNwOXMNWkHgbnkxKbPrPjuQOvPZgFVJQCqM9Py7/972Obbthn8C9KfLTLIDG8evrptHV9DgKOPyX6sTzqj1O1K2LPIKJSm19NrWHRxmEX+A3dhYUOBbV2/NtzDKBNPGy8+nx/wFEf7GIy8=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2688.namprd12.prod.outlook.com (2603:10b6:805:6f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Wed, 25 Aug
 2021 13:54:34 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.027; Wed, 25 Aug 2021
 13:54:33 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
Subject: Re: [PATCH Part1 v5 17/38] x86/mm: Add support to validate memory
 when changing C-bit
To:     Borislav Petkov <bp@alien8.de>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-18-brijesh.singh@amd.com> <YSYkHhAMSOotEzXQ@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <de04db4c-95e2-e921-5a2f-7fb33fed4fdc@amd.com>
Date:   Wed, 25 Aug 2021 08:54:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YSYkHhAMSOotEzXQ@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0126.namprd05.prod.outlook.com
 (2603:10b6:803:42::43) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN4PR0501CA0126.namprd05.prod.outlook.com (2603:10b6:803:42::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.9 via Frontend Transport; Wed, 25 Aug 2021 13:54:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e9d7a85-78d0-44dc-2472-08d967cfde53
X-MS-TrafficTypeDiagnostic: SN6PR12MB2688:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2688E51A6EC6D516AD1CD441E5C69@SN6PR12MB2688.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWpErSBqo3tvVMAIiXOllXkfxfi/SZVxEY4xotl+XdHrARAzOgZM7RPoAuGQ58ds6kyBsc0K3DYsSIbrS8yteLSlK6RTzJXrXEfJnzZ0mS2P47MHTBrW2m6HqpsQDkuf3QfHkzO0NCoBSvcfA3gqS5zh2cSmlVadoy7dWk8tDVIMD4Qht6DjDBdGMiH3SkAWWjmQ47FYfbY1AVV2djf6dvgjRdPQG3PEXcCGc2GbPipzCj4AJmq3spig4+/iFdtJDnAlPP34S6ePyHxBRlhTySBsXgfoBzmKI9TOUgU7iac1TpZbQnPnPbmuqEOfTWATlk9jttyUnzIywv7b4ZkYaC1zRzGmofhng9vq22oDQpJQZjwR48qWRLWO2HjLWeP+/RUCrR4vMcDqS5NuQzyWEYcZRr4WVRerDy23vx4DxIU0Ppfm9GZSLjYRS8VAZZM/nWoVNjvFmbu7CY0VG6PnUM+qwAsa5cmFtJYEw2x/LG+feSXH8EDMrm+nL1wqB4//kmLJaBLrAJq5pZka7mQKBKiU8SuUrZkoPBqHGnj8BLOkGH6K6NwYwbiXdE7MLJfhJMZn4Rjkjhdy05M5jrZf0YyGlKWCqpZzVLno496/SFr+LXZSqc2/fmPe8R5qmsnwdkvjmAIfhSxwppXUvt0Emhph0cpTQPMC4MZmefMSUnY0KHXFeOx/sCH5WWXcu9ucYmRGKxAHlNxkkTm9xZKY2de+43p8kDLzAbjBmry9kaqER5i3lqjJM/c++X5VlLYJdNJGhde/9Iij8N54SFpYJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(66556008)(16576012)(2906002)(66946007)(66476007)(5660300002)(316002)(38100700002)(38350700002)(54906003)(86362001)(7406005)(6916009)(31696002)(4326008)(8936002)(52116002)(7416002)(478600001)(31686004)(8676002)(53546011)(186003)(44832011)(6486002)(26005)(83380400001)(2616005)(956004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDk1b2x3Q1c3Snh1WFBldDh6Z3VEYVVsRHF5RWRtQytPMzl2d3czS1IyZWNE?=
 =?utf-8?B?ZHNDVTJqcjFSYnhXdmJSOEN1MXlqRXRhVFlpWTkzOVhWeW1RR0tNdERJVmJ2?=
 =?utf-8?B?WkhJOGFPSzBXQndodkFHVUhrWGIwc1FoQTZwQlRlbkh2L1c1RzZxbHUzTHZP?=
 =?utf-8?B?dkJUMVljN0hzbWlneGVhUnU3NHVId00rQ0FrQkZXbGtTdHZPZXBQL3VXdG1p?=
 =?utf-8?B?aXR1NVhIM1laOTloRmFmL2tXazY4Um1sNTVESE5VV3RkclpMRm5xYlU0YjA1?=
 =?utf-8?B?bTFqK2RvTEJqeFZYQ2JRNEk5WUxjK0R6THlNalg1LzBVcUxTMWFadE9DZUZ2?=
 =?utf-8?B?dUd6NWpaUU5zcFNhQjMrMW1Xd1hQZCtzNlplQ2JpeWI4cWJITlZiU3pkc245?=
 =?utf-8?B?eFI5NWJDdnRoOG5vOXZIZGxsUFN3L3ptcjVmbU1ZdHlVL1o0N1FHNllkQVda?=
 =?utf-8?B?WWw2SXpqMjlqV0pjek03c2g0eHdDMEVLdmg4Zno5cXI2aXl2UEtxaFF0MFdo?=
 =?utf-8?B?eHEyYzlKb1BxZFVQOXMwN0RxYXZFZEQ2clgxVkZYSDdoYTdUVDVyNXNXUzRR?=
 =?utf-8?B?cUIvNzd1dEpmNE9EcFdMODdnMXVaWjF4Q0wyZm9ZTjcvWFlGZnhZWWxGQWhv?=
 =?utf-8?B?aElSbWlENXIrcmVTc1F0R2o4TGhKU0Y3VWNFWXYwTlI1R1IxTzNtUDd6cnov?=
 =?utf-8?B?eldJY1B3bWlsTGYvbU43Z0h1YnhpWGlGamhpeGVKb2EzTjJBVjBRbVNHWFZx?=
 =?utf-8?B?SFRacnhrN2o4amVWNWxJdTZnbTNybTJyNnVLdktVdC9ydmZnbnlVSmpsV21N?=
 =?utf-8?B?RkQrNzRJRHFPdVRrT09rSFZBOFRyMk5QazlnTEZjV3dpTlhvWmNKN0RBajA3?=
 =?utf-8?B?V2x2WlVuNzBrTnZwTmtjMUw2aXcxU2RFWm44SWRISkhCWisxRlFpMXlNV3NC?=
 =?utf-8?B?eTRmdmdvR0NoajVia3JoQlNaT1R0enJsZFBqNmgxNUdMSVAwV2Q3MlQ1dnFU?=
 =?utf-8?B?eVk2aUhUKzA0bVF5VzdIN2NOM09UN1VFM29BSk53elhYY3dKc3JLM0RWNmtB?=
 =?utf-8?B?cXIyWVJRUXNtYk5KelNXSUJTaXl3NU80QzVZci9rd3RxWWkyZUFDNlVISEdx?=
 =?utf-8?B?KzlXM2dndzg0YXlTcHF2RHRBUVpDM1Vydm1lN29UQUtBeE5MODd6TCtnNWEz?=
 =?utf-8?B?eThvT3ZEdWF3eUVCOEZXU1IvUDZINi9INnVIUVYwMDEvc1JxNm1pbUE5eHBN?=
 =?utf-8?B?Rm1rZzFEZGNDK0s0SEd0aUg1dS9VbTZqR1ZlQ2ZPQTdaOUUxaFJnTkdGUmF6?=
 =?utf-8?B?dGdyYzNNckZMMWd2U0V5Nm5BU0V3ZEtyTktEK2ZSWW1ueEJycm9MUVQveUx1?=
 =?utf-8?B?cWN5SENmMmRqMWsxakIvYWlWSWdpanhIdUxwWnZlU2JZWUs5Ym9ybEdPdVpQ?=
 =?utf-8?B?d2tock8rQ0w0TjhVTWlsTTJCN0g5b2ZUS3JHTCtOSU94Zk5DT3o2cnRmZVYz?=
 =?utf-8?B?UkxRNVlyUnpGeE1EUW1BRUh3VVZ3Y1hGbS8xa2FVRkVnZmk1OGhXUE5EaGVL?=
 =?utf-8?B?UENmUGZ2T2FmMUZwQ09ZNWpFTTZpLzQxcDNCSjZMUFA5RW5CVHNkQ1RNcTJ2?=
 =?utf-8?B?YVJXS2l4MG1TMkhuUHFvZXltWmpVS2xPNkp4MnJPS2tHSzFLbTZlVUZlSTVV?=
 =?utf-8?B?dWZqTWFscDBVUXV1NDNDNXhDcWVBbWtxeW5tSU10ZTJ0S1ZRaVVOQVg2cE9N?=
 =?utf-8?Q?b0U/LUwCW9ZJRZMyPZRJYPMqZO/WdkKlByD0mEz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9d7a85-78d0-44dc-2472-08d967cfde53
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 13:54:33.8536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABwqaUbc58ELAnCn0j7GQ81qTSINsLSqXdcwtG5kgvRQsRVCjy4IfTDjJ2wLM4r3rglksLJ9Hj0uRZOheMDfAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2688
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 8/25/21 6:06 AM, Borislav Petkov wrote:
> 
> I really meant putting the beginning of that string at the very first
> position on the line:
> 
>                  if (WARN(hdr->end_entry > end_entry || cur_entry > hdr->cur_entry,
> "SEV-SNP: PSC processing going backward, end_entry %d (got %d) cur_entry %d (got %d)\n",
>                           end_entry, hdr->end_entry, cur_entry, hdr->cur_entry)) {
> 
> Exactly like this!
> 

Noted.

> ...
> 
>> +static void set_page_state(unsigned long vaddr, unsigned int npages, int op)
>> +{
>> +	unsigned long vaddr_end, next_vaddr;
>> +	struct snp_psc_desc *desc;
>> +
>> +	vaddr = vaddr & PAGE_MASK;
>> +	vaddr_end = vaddr + (npages << PAGE_SHIFT);
>> +
>> +	desc = kmalloc(sizeof(*desc), GFP_KERNEL_ACCOUNT);
> 
> And again, from previous review:
> 
> kzalloc() so that you don't have to memset() later in
> __set_page_state().
> 

I replied to your previous comment. Depending on the npages value, the 
__set_page_state() will be called multiple times and on each call it 
needs to clear desc before populate it. So, I do not see strong reason 
to use kzalloc() during the desc allocation. I thought you were okay 
with that explanation.


>> +	if (!desc)
>> +		panic("SEV-SNP: failed to alloc memory for PSC descriptor\n");
> 
> "allocate" fits just fine too.
> 

Noted.

thanks
