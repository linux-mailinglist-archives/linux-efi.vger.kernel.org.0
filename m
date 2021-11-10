Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C2344C2E4
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 15:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhKJOYS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 09:24:18 -0500
Received: from mail-bn1nam07on2043.outbound.protection.outlook.com ([40.107.212.43]:23950
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231703AbhKJOYR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 09:24:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7kcEmZBKsb5Fo7yOb6g143rpgnnU82+haH5MN0NgDms+/ho5X7tMjzqsXOy6FJBAsmi0iVYQZ5WmK7OLoE3wT6imL+cKADKT1fMBWy+Zk/zsucD7sSCU0C+tzJEMwiR6kBXML1BjqojgwD4IpDyX14EaR5GqQv1VnMIWXiAsp58HQkuwUixoqJG6K5XMUXCObcyFaaqhjT5qkeafkf4cM/OhtTYBcZlgesLGVfBVbXKQKzTgCaldBt6L+w6qOgYPVNhrscBkXzF1MhxuwY3aoKRinr1admCgD86FS0k30Z5OJh1eijyX5rfnrSTLWOOO2NnxfLZ20DAOqHnoTYidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjagWy2HOseU2axymMbzARawBDFZuq1MtEkuGmN/KU4=;
 b=RBQNX3zeupJbpt6yKPh+9rdNzW7X37kAckt7wZt7Awjrvkja+7kwqxvPKqyLSGBQTQ0SYEkbyZfUxIAbiZuyc9j4kJu3FDjbxjxhDjJUMzc5RxG1LZ+9wL9wv2kZFFxgILzUZOr3UNh6igtSyToEPrcsGy1eE1K/gBgDqNDA7+qoy1mTqKW4PZsWN7XlsJ780SmVdtKCElGUhyGtUe635XyG3eOT3i+lVvyckuBlr/GWhrG8ucwxemZbRD4SIprePNX1sc4w8+yR4vU/uNdGwwQl56HpnczCauVM3gYvWMZrPZewNRbW1FaI8YIe1bUORHd9QDkh0NFy/BORxw65LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjagWy2HOseU2axymMbzARawBDFZuq1MtEkuGmN/KU4=;
 b=X2xrFKSklwHycZpWYGCsYIJNKm3FpttMjVlvwj6ZQz4yJNiN1DEzynTku2ogBfJxsO0JfNKOYyADwz45MwXt27fUwleFBMgUoY/1peWnyXlyGEBW1K5tyRP5mEkQGfaW+/MpfhmfKEdewz4TW+xnY47tyZ6wwdeQmzdiH3WdNEo=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.17; Wed, 10 Nov
 2021 14:21:26 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::e4da:b3ea:a3ec:761c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::e4da:b3ea:a3ec:761c%7]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 14:21:26 +0000
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
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v6 19/42] x86/mm: Add support to validate memory when
 changing C-bit
To:     Borislav Petkov <bp@alien8.de>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-20-brijesh.singh@amd.com> <YYrNL7U07SxeUQ3E@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <4ea63467-3869-b6f5-e154-d70d1033135b@amd.com>
Date:   Wed, 10 Nov 2021 08:21:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YYrNL7U07SxeUQ3E@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0071.prod.exchangelabs.com
 (2603:10b6:208:25::48) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.236.30.107] (165.204.77.1) by BL0PR0102CA0071.prod.exchangelabs.com (2603:10b6:208:25::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Wed, 10 Nov 2021 14:21:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39a3ebd1-e057-401e-03f5-08d9a4556165
X-MS-TrafficTypeDiagnostic: SA0PR12MB4349:
X-Microsoft-Antispam-PRVS: <SA0PR12MB43495E1DB7D4A3E96F77DDFFE5939@SA0PR12MB4349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r6Kv2gbbYOvRlZVTPTb1ZQ6sm8iJhymDuvivkFt7dGemq4KukaZQOJDFnpQLg+mGimLR94+SL8pJ6mb/BQJsfwcQcOg8kOw5mvB5ioKqyBA+xJ0Hm5LoewAOdZnWoNVB23R1aVevNeQJe8veRAjQFdgjrsIrFX/HGOmJbaUTPVL4vPLuMz3GVNusVzUO4xactURcCpH/INYpXuYDPNlzzP8YHP0h9VV+gQLYAbW3w60zaDaumGlhp635eCS6rodCxT8cq3pjbveY+DlWm7KoooA+pStqP2RqUPhfXFCwZJNDMntSmiVKP033KUbtGJs4O4+oenZlcNYmw1hxjrbjaiESrg1bOE7HXFcC131BOJbPeb2kehVjaByesGlj4Vc2iO4YS9vCGQVYqArOkr42N0W3anNc7/Lqmlh5tG+1Ig9XtEsvGoQ4CkW+0k0qGmJ2jcNMtAak64akTMqw0co6RZbyMqor87kcLDOWqYPbw9GjHEsuW5ZWR4wGWXAdo77OTT8MbZtLscFda57IWnra8e/bvWWzdTYYT2SKLHEd/XaaZL5edEXVsiF5c8zAQjCDg0yw6dEPcBXc/+wP5IampCYwrtVTNz8+15MPornRr8QoFlwvAHw167GHiFZBQTaH7Di7j/LMkPjhJ2PxxZeyAoR5QQXHxnEzV8ZFACfnE8xTb8iR2HyTxgrZij0HFAq3K6Rh9PN39Oe/u0CKcBzVCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(2906002)(5660300002)(4326008)(44832011)(7416002)(15650500001)(7406005)(31696002)(6916009)(8936002)(16576012)(53546011)(66556008)(54906003)(36756003)(66476007)(38100700002)(26005)(316002)(2616005)(66946007)(186003)(31686004)(83380400001)(8676002)(86362001)(508600001)(956004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1VIL2xGOGg5VFJUV0VmVGxzdU5kaDRmb1IybWFjTWRoTTAvc2w1clMyUVoz?=
 =?utf-8?B?dU9wcU9McytHbW1LMk5TaFovNVJUOFc5cHhpOXJMR0YrblU3WlQ2RndLc0dz?=
 =?utf-8?B?aGhJN3RkOHpsaFVrYWFKbTFlUWxaQUw5WE5kVTBpS3N5Rmc5M2JmMCtMUGNo?=
 =?utf-8?B?V1VuaTB3VTAyMDhmcjNtS1p0ekg0Q25obHBGRFJPbFMvMnp5eU13T2JBY3lx?=
 =?utf-8?B?RXE3K1llSVliS3o2OEUvNXlQblJBOTR5REFzV0d5UkowL1FFd2tOWTFFNXFm?=
 =?utf-8?B?MU9DRHpEZkNDMVh0aG1FOTNDY2djMnZGcFBuMWJhMXhoMFFDQXFJUWpwNmt3?=
 =?utf-8?B?bnFjcHZ6WTRwZjl2THFyVlFTanQwVzdMSjhXTU1jYVdjQnExREQrRGJmcUEx?=
 =?utf-8?B?UDNXT05rTGt5ZnpENEk0VGVTTHViSFJUMTN6eWVoWE14STVBcWR3RzR2VU1G?=
 =?utf-8?B?QzJuZE1CRnppWEN0ZHpNUUFMb3l4dGtNQWNNK1R0THpNL2VWMWFJTWluM1JK?=
 =?utf-8?B?a202YzdBOWpJdzhHOVFxdE5QdkF4eUJQTFpyeXd2YVZMamU5OG0xay8vaXBE?=
 =?utf-8?B?LzYzMmU0K2U0K1Qwc1d3M2NrcVdFS2NjbFhxWWVVc0paTk4wc2RRQmg2aCtE?=
 =?utf-8?B?eXREamVic3B1bHRNbHpCY2tGT1lWcUExTTZXaHVXeC9FZmF1RnYvVTBycGFn?=
 =?utf-8?B?ejVndUdlLzMwOXB0SnprRFFha2c4djVzekNGWmwvWWpCdGJDQmd3MzlIMW5S?=
 =?utf-8?B?U2ZiZ2s4OGxINXBocEZ3aXpia1VMTW1ETUhOYnZJNEc0SGlmOGZ3S2I5T0Ir?=
 =?utf-8?B?VzhWL3BtMnYvWDRMVGtOL3VhWVZCMUNpak1xT0krNm5FUWVvRlBWd3dBSWlJ?=
 =?utf-8?B?WldUTmg3cFN1eE5CU2t1Q3czbzBNb1Vjd0U0dVMvMzExRVk3eDlEZ2dnTjRP?=
 =?utf-8?B?bVkwYXFsd25RSG1lTzd1QmVwRTVPWlRJSnVXd1NabnBhbklXYXFrbnBYWDB1?=
 =?utf-8?B?OStTVFJYRFdyMmd3Tm02Ky9RZ2JiWU8yc2E0am1ocjIySUZVVXVuQlE5bUpj?=
 =?utf-8?B?ays3R01MSUpIOG04Y1pYVDc2TEJGb25nYXowdlZWVy9FUnlwTzJlQTBtRE85?=
 =?utf-8?B?M1Z6WjhqbjNKb2kxZjBOQVZaMmZsNmswZWtudHNMbS9tNURINjFYMFhMMVlM?=
 =?utf-8?B?Z0J5aUNBK1dSM1pkNml3eVJMS00xUi9DaCt4Nktid3BJSXdqOGdUejFPUkFk?=
 =?utf-8?B?dlpoZFkzV0lyL0ZlWDNEMi9SS0VpTWxGV1RWVU9jd09PRWNWZCtvUytldFJS?=
 =?utf-8?B?RG1yZStaNm5OK0ZSTWsxaUVzMHF3cG5XQWYxaXZFYjJsSmp5NG53bzBPR1Jl?=
 =?utf-8?B?dmZ0eFFZaUZYUVdwOFdsTDNpbW5vQVVQTEhqczUwQXc2WlkxMEdUYmVwQnBD?=
 =?utf-8?B?ckZnaVRXTjV2Sk5YOGdjOFl6WEdjM3dsSzNnVThtekZmS1QrUkxQbk5wV1dw?=
 =?utf-8?B?ZTBWRHl1SFY4cmxMSVNIYU9RZXV1UTViODJXOFNRaUxldnppbkVTUGo2YTJC?=
 =?utf-8?B?eXhDNklvZWQ0L25ydkFWNzBLMGtLLzNkenhUaWxYOVpHSlVRUDNmbWhTRE9t?=
 =?utf-8?B?RVBkKzhZbzdYMFNBQ2t4OE9pRHVqT3FQd2dBUXVIOFFLZmxValZGQ2cwTnNO?=
 =?utf-8?B?N3JDNEhNNEhQQ0dsTmtrOG1RdFZJL05OQ2J6cXJLM1VrMGlmSlF4Nnpobkxw?=
 =?utf-8?B?cTN5dTJYaHpRRFVuQS8vWWdpbEk3VVJuNWg3U0hVQXBXYXpucWo1cFcxeEpD?=
 =?utf-8?B?eFFxK0dwT09sOWtPZUdxTFRST3FFNFh5cDc3b0RxUEZITHI5ak1qbkx1cE50?=
 =?utf-8?B?U1lZdHZwKzhDVER0eUo0Tk5FRnNoY05mQWNRY1NFT3EyOHZybi9ObGJyUVdI?=
 =?utf-8?B?TmpISFRXU2RnZmFmVk8vYkVLZ1RLS2EyNWVFejJDTHF0M0VYNjlKejNUK0xS?=
 =?utf-8?B?WUY3cXVWWFhWWUpNcEVPRndMbTZlczYvVndvZXozWHQ4bXVTYTlRb2ZFNEVQ?=
 =?utf-8?B?RjRzWVlhc1loYlpXWEx3MWtaK2s3bmlZUUdtdlNxMVc4TXZpUjBEOEJxN0Fq?=
 =?utf-8?B?eXJlbEVITXlad09Cdk9wK0RmaVRyWXVrVkY0Mm43OEE3aEE4cW9zV1EzemZJ?=
 =?utf-8?Q?Sb2aa2Hg1qwCtKTMq4CdXNA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a3ebd1-e057-401e-03f5-08d9a4556165
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 14:21:26.5110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/4vZphLrao9ETQ9+TiCs6KLOMbS5/BdWdCtYq2Weljk/fnOC2oqhzKtzve1HErXZerXnlXcC00E7QRKzlmtNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4349
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 11/9/21 1:34 PM, Borislav Petkov wrote:
> On Fri, Oct 08, 2021 at 01:04:30PM -0500, Brijesh Singh wrote:
>> +static int vmgexit_psc(struct snp_psc_desc *desc)
>> +{
>> +	int cur_entry, end_entry, ret;
>> +	struct snp_psc_desc *data;
>> +	struct ghcb_state state;
>> +	struct ghcb *ghcb;
>> +	struct psc_hdr *hdr;
>> +	unsigned long flags;
> 
>          int cur_entry, end_entry, ret;
>          struct snp_psc_desc *data;
>          struct ghcb_state state;
>          struct psc_hdr *hdr;
>          unsigned long flags;
>          struct ghcb *ghcb;
> 
> that's properly sorted.
> 
Noted.

>> +
>> +	local_irq_save(flags);
> 
> What is that protecting against? Comment about it?
> 
> Aha, __sev_get_ghcb() needs to run with IRQs disabled because it is
> using the per-CPU GHCB.
> 

I will add a comment to clarify it.

>> +
>> +	ghcb = __sev_get_ghcb(&state);
>> +	if (unlikely(!ghcb))
>> +		panic("SEV-SNP: Failed to get GHCB\n");
>> +
>> +	/* Copy the input desc into GHCB shared buffer */
>> +	data = (struct snp_psc_desc *)ghcb->shared_buffer;
>> +	memcpy(ghcb->shared_buffer, desc, sizeof(*desc));
> 
> That shared buffer has a size - check it vs the size of the desc thing.
> 

I am assuming you mean add some compile time check to ensure that desc 
will fit in the shared buffer ?

...

>> +		if (WARN(ret || ghcb->save.sw_exit_info_2,
>> +			 "SEV-SNP: PSC failed ret=%d exit_info_2=%llx\n",
>> +			 ret, ghcb->save.sw_exit_info_2)) {
>> +			ret = 1;
> 
> That ret = 1 goes unused with that "return 0" at the end. It should be
> "return ret" at the end.. Ditto for the others. Audit all your exit
> paths in this function.

Noted.


>> +
>> +		/* Verify that reserved bit is not set */
>> +		if (WARN(hdr->reserved, "Reserved bit is set in the PSC header\n")) {
> 
> Shouldn't that thing happen first after the HV call?
> 

I am okay to move this check before the going backward check.

>> +
>> +		/*
>> +		 * The GHCB specification provides the flexibility to
>> +		 * use either 4K or 2MB page size in the RMP table.
>> +		 * The current SNP support does not keep track of the
>> +		 * page size used in the RMP table. To avoid the
>> +		 * overlap request,
> 
> "avoid overlap request"?
> 
> No clue what that means. In general, that comment is talking about
> something in the future and is more confusing than explaining stuff.
> 

I can drop the overlap comment to avoid the confusion, as you pointed it 
more of the future thing. Basically overlap is the below condition

set_memory_private(gfn=0, page_size=2m)
set_memory_private(gfn=10, page_size=4k)

The RMPUPDATE instruction will detect overlap on the second call and 
return an error to the guest. After we add the support to track the page 
validation state (either in bitmap or page flag), the second call will 
not be issued and thus avoid an overlap errors. For now, we use the 
page_size=4k for all the page state changes from the kernel.



>> use the 4K page size in the RMP
>> +		 * table.
>> +		 */
>> +		e->pagesize = RMP_PG_SIZE_4K;
>> +
>> +		vaddr = vaddr + PAGE_SIZE;
>> +		e++;
>> +		i++;
>> +	}
>> +
>> +	if (vmgexit_psc(data))
>> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
>> +}
>> +
>> +static void set_page_state(unsigned long vaddr, unsigned int npages, int op)
> 
> Yeah, so this should be named
> 
> set_pages_state - notice the plural "pages"
> 
> because it works on multiple pages, @npages exactly.
> 

Ah, I thought I had it pages but maybe it got renamed sometime back in 
the series.


>> +{
>> +	unsigned long vaddr_end, next_vaddr;
>> +	struct snp_psc_desc *desc;
>> +
>> +	vaddr = vaddr & PAGE_MASK;
>> +	vaddr_end = vaddr + (npages << PAGE_SHIFT);
> 
> Take those two...
> 
>> +
>> +	desc = kmalloc(sizeof(*desc), GFP_KERNEL_ACCOUNT);
>> +	if (!desc)
>> +		panic("SEV-SNP: failed to allocate memory for PSC descriptor\n");
> 
> 
> ... and put them here.
> 
Noted.


thanks
