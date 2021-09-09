Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC49405A2A
	for <lists+linux-efi@lfdr.de>; Thu,  9 Sep 2021 17:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbhIIP1l (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Sep 2021 11:27:41 -0400
Received: from mail-mw2nam10on2046.outbound.protection.outlook.com ([40.107.94.46]:9952
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232656AbhIIP1l (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Sep 2021 11:27:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cvd+xE73NMMOGhnZZ/FpWWnWWyA9Cj//hUq4oe2ut3CnQuesAD0cdJKiKvnquU+O92WGk/mgZPoD4IjFVQAf+1d0L6pBXxjOGtOTiitSvWWlVAUus92OT4fixmQHGQxOabPldS/tBSRZDX2SzEJGz113s30LzOG2Og/8WfabxRAp4rOHywBZQqHg97qzu1ALenzGKEd6ROqjXIpAGg0pQrALWFbWkVODlql7v3Z5N7C5XcPbEVR3/00WykeIITeqZoQeHe5k7HLYP5NgJEH2WkOepGbAR4UVbsCKxYpWdYqNwYRgKp7PWHOLsmrsmK6TPK6iHlJ/DPJ7Ic3WpuU0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Umwll2mOSlhf/cu7bIRq0MO5hLf3X06IEZRg/CnVR/Q=;
 b=cVDnEOdcdojHQr96UB7+ph95sbIz2LGNf9BmDvXYs+qvv1bXwSkNZPrXB/HogHPWAKtXbqSxBnx6DOVNf8WV0tiA4Ag+BWVpcoGqyD3IhnglmI904RyQrtaY/Xu6K+pS437fqdupHMDJzx/xZoZoqWs0aWw9gIhPYpTEmqXf7ET4ly3+UFonPOKOiBtz1yhX4Iu7GmtjDQO1SyKWlPyWg/kDirgbvNDmgjy91tiX3m3qXCvrnPWqqFtpEUMh0lBbFZJnKxVAd0QJnV9FdxyjxRS4oswZJAa3fEKOD7GctWlaTrs6u4ALG3iyC4WxoKhf2EJ16UTWhCF3vSTNr6SkFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Umwll2mOSlhf/cu7bIRq0MO5hLf3X06IEZRg/CnVR/Q=;
 b=ItHL7+ygmz5tZRhCxhYawf5Y4gh/5Jpo/qpRc+zN23KmeyvSRfVpZIF1ul85YlkyBIMpXWv5IMCOtwj9AsZtr/1jHePvBGesmf6tGZDWb7T4HFuWMcjS5yQK8qwiPtCTwPNvpcBJSdTLSpFLrsn/YktoUaXInotlSxNRRMVsKYA=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2688.namprd12.prod.outlook.com (2603:10b6:805:6f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Thu, 9 Sep
 2021 15:26:28 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4478.027; Thu, 9 Sep 2021
 15:26:28 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
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
        Sergio Lopez <slp@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        Marc Orr <marcorr@google.com>,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 34/38] x86/sev: Add snp_msg_seqno() helper
To:     Peter Gonda <pgonda@google.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-35-brijesh.singh@amd.com>
 <CAMkAt6qQOgZVEMQdMXqvs2s8pELnAFV-Msgc2_MC5WOYf8oAiQ@mail.gmail.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <4742dbfe-4e02-a7e3-6464-905ccc602e6c@amd.com>
Date:   Thu, 9 Sep 2021 10:26:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CAMkAt6qQOgZVEMQdMXqvs2s8pELnAFV-Msgc2_MC5WOYf8oAiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0109.namprd05.prod.outlook.com
 (2603:10b6:803:42::26) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.236.31.95] (165.204.77.1) by SN4PR0501CA0109.namprd05.prod.outlook.com (2603:10b6:803:42::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.9 via Frontend Transport; Thu, 9 Sep 2021 15:26:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bac0962a-1571-4655-36a1-08d973a631a7
X-MS-TrafficTypeDiagnostic: SN6PR12MB2688:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2688927708F3D0A1F8443762E5D59@SN6PR12MB2688.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: idMYvqDFn1OtGhsz1gwUyC21nsRYX2qZoedlg5RsdKrq3tpBFSdWBYFYc2n5wCbW1eH7Y9+NQEEeGuS9pYpXOeL24oDMTIx84e2YUXjm0otRVjSbACRySZlfMbtacaUCVkbVbBaQ3ncVaBo3aw9qEUSQUk9jn4f338pLtew+hWojNNVEc4Jb2JuAYAWO1HN/tbp+T3o/ogPZMOl6vmpJeEGleDTh9I4TF1sSPXJf4no+UOW4PMlJ/TKTNmRm3xORuZa9vLU1OQqJvf6bLYJJ/O5pO5thsqj8UYlWXIyzszrYhTRv4EyohdXE8DF4qHW/4grGBvBT9XkNszYwSMLOnzYzYwYZvAusHZdetK+1tFp9gDSwygUwYRBne1VpqnEYN3BjZqGbbZHrdCRkehEKl9cL6JoLpidWMWXDjMwS6WC1EubZTAPIs/B1TdGWNgSRzyVMwX82ZJd0RSKqEgaWk+2Ncnawayv2s876qoPmRUlQBZl5/S6QjbttQBiEpuDo19AWNXBmnrA2XLK0B1P+Y4F1nc6wqqqYr9cNhIZ+lWqkjZJbgIORkoEGy8n8VzaJJ4wnls75t9kuxrBUO/zAKGa78y6viJyrmtW5gx7eUlSzoS0HDk8Wmf7D2eKjLGLUPtnQc5S4i+LHFjbq8eN7JhcvJ1TR3ni7sCkvgvJGL6p6mdzxenFyLdm9+0PiZdi7jnZ8Z63gVhQAk5W7SoWNCz+ITRFPoVYWJxuo/9OSYNiH2yB5JDEBQypfoMpsEaayf0BpHkIeeL2IJ2svGwd87Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(316002)(4326008)(38100700002)(26005)(6486002)(44832011)(53546011)(956004)(38350700002)(478600001)(83380400001)(52116002)(86362001)(54906003)(16576012)(8936002)(8676002)(31696002)(2906002)(36756003)(66476007)(66556008)(66946007)(31686004)(7406005)(7416002)(5660300002)(186003)(6916009)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTRBTGROWURUbzkxbUpTblF6Si9RUmdJZ3Q1YVlUUDhDM0RQTkMzbWxhTHJB?=
 =?utf-8?B?RThnWGdJZjBOUGFkVEVDbU9NN3BuQWNxMHl3SUd4enVpTW9MbUhHUUFHdWFS?=
 =?utf-8?B?dDlOUW0rM3NPbWNqaHVSU0NpUXREN1RwWlhwbjlIOHNMYUNPUTNmajZ5MmFj?=
 =?utf-8?B?eW9EVy8vbCtEVStrMWNzTlBKRGQ2SXJuZFJnVktTQjB6UVh4cWF2ZFRtdW0w?=
 =?utf-8?B?enNCS0xxTWo0TTl3ZWl3c1RKdDZueUwyY2pRSmsxZGI3MGo5T0VsRWZvRWNU?=
 =?utf-8?B?eDFhZ3c3RmI1M0xQTFp6bGQ2UlRTL0dBVlJwbkdaRUNEL0lPYU1WWnNWL0cz?=
 =?utf-8?B?WFlEOHUvdTJFMk5td3VZWUpJc1kzeWI5LzZaeUVlUGJoZUxEU0VGUmMxdUlX?=
 =?utf-8?B?R2VYdGx6Rkp6NXZxY2pKOTRuT1hadTJvZUNnRU9ENGlBN3lPQmZ2emVha2NZ?=
 =?utf-8?B?LzROSWwrK0V6ZlJoemxCTEwxeVNyMkNNSXIvQndHWlYrN25Ndk5xVDNBcWZy?=
 =?utf-8?B?RlFUbzFYbGVuYVptSUxreTFNOWxEeTZPWGI1YUNQdEZmWFM0OVhHSCthcThi?=
 =?utf-8?B?N21rbFVKMHZ5QTdFSVUyVjVMb28wVjEwakdRUkVKNDhja1pPdTVVWHRZQmJj?=
 =?utf-8?B?VjVWUUV0WFhMbVRmblE4bDhCRDA4QkZ0azVLRm9uWFVlOHRlZU9yVURRZXVp?=
 =?utf-8?B?L2NKMHc0QzQyQktpRzlqQVNwSkp0bXJYL1lLRExJNUZQeHlCUi9XOUxYUlFF?=
 =?utf-8?B?VVJIY0ZnNUc0dTNjNGFQSGptMXl6VE1VbG9EQkR0c3FCeDJ1ejE1NUtEa3pR?=
 =?utf-8?B?Q2lYY0F1d29LUldvUHhqZ0gyOUJRaTRwZVVOcWUvZXd6cHY5a1pQNVZtTmJE?=
 =?utf-8?B?ZG5KcFUvQlFmUWh3VFhncElxOGorSW9LdkFXMlRvTmh1Z0dYZ1l4dThNdFNC?=
 =?utf-8?B?RVFicDVTbXRuYk9BUXltdFZPbFNVODhleTFNcllSaHh0d0ZOdzU0T3Q4Qlc1?=
 =?utf-8?B?Q1dMdU05Qmk3K1U0Y2I2N1V0TlFvczF0N2trT0cwaG9IQ1Z3RC9SYkdYNUxK?=
 =?utf-8?B?QUV5ajAyMnEvZjRtYVZ1bGYrN2NxQTM5RjJSSVBZVHRtbFI3clEwM3o4YWwv?=
 =?utf-8?B?cmZWdnVsSEszdElieWt5aDdDY2x5aGhRYlIwd1E1cU80c1orWXdJUGdtVFNO?=
 =?utf-8?B?MTVyWldSWFY2VWRlNHpYYkFPNXFCMWdHeDdqYWR3STJwMG1PanVtNTRFRVJP?=
 =?utf-8?B?aGVyckNia2VoSXZhYVRaNklpR292N0JlckZCYnNvVnlZQkZKY1lrMnJRWlp2?=
 =?utf-8?B?bkw5aDFoWjRsT0pteXMyUXlyeTAweGxLVTB4cTErd0V3Z2N0WUdrZC9MY1Zr?=
 =?utf-8?B?V0xGR1ZJaUpaTFRSVnU4emNiRE1NL0hEUW4zMEo0eWx4MmZ5QnhTUElkL3dT?=
 =?utf-8?B?QW5nWUFZcUFsQS95Z2F4MEJIaW0ycHB6L0Z5UTlrQVAxeCtZaXpFem9VcmIv?=
 =?utf-8?B?N0RzRTBucUxPaUQycGpLbUJXOXJqUUE3QzNOcURxRmZoSW1ydm1jVU5KV1do?=
 =?utf-8?B?T2xsa1gvNzROb1RoVVZpbm5TMk14UWFiKzk3RHhwTUFKa0dWazYzZEk5WHlO?=
 =?utf-8?B?a1hyK0RVNEpYNC9EUm4zNTJTdjBmTS9KeU1aUGVsV1ZnaGpYcExKcTNUOGY1?=
 =?utf-8?B?alFYRnFKZ3FXUUJ3YkpGbkhpeWFINFhsUTh4bGZRcy9NbDg4RHJ5U2MwVnJP?=
 =?utf-8?Q?4BUOaLnUF3L/vUYdyJm8bTb/ihFT4QR/6NwfVwP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac0962a-1571-4655-36a1-08d973a631a7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 15:26:28.7901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 62PCTQ1a7cJYF3BLh04dA/bAFSoBXoQeRlN5OIk0GYDryhKsZAVZlV1xLqhzU9vpR/kfOXTzdyCgg1lBc75l1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2688
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 9/9/21 9:54 AM, Peter Gonda wrote:
> On Fri, Aug 20, 2021 at 9:22 AM Brijesh Singh <brijesh.singh@amd.com> wrote:
>>
>> The SNP guest request message header contains a message count. The
>> message count is used while building the IV. The PSP firmware increments
>> the message count by 1, and expects that next message will be using the
>> incremented count. The snp_msg_seqno() helper will be used by driver to
>> get the message sequence counter used in the request message header,
>> and it will be automatically incremented after the request is successful.
>> The incremented value is saved in the secrets page so that the kexec'ed
>> kernel knows from where to begin.
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>   arch/x86/kernel/sev.c     | 79 +++++++++++++++++++++++++++++++++++++++
>>   include/linux/sev-guest.h | 37 ++++++++++++++++++
>>   2 files changed, 116 insertions(+)
>>
>> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>> index 319a40fc57ce..f42cd5a8e7bb 100644
>> --- a/arch/x86/kernel/sev.c
>> +++ b/arch/x86/kernel/sev.c
>> @@ -51,6 +51,8 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
>>    */
>>   static struct ghcb __initdata *boot_ghcb;
>>
>> +static u64 snp_secrets_phys;
>> +
>>   /* #VC handler runtime per-CPU data */
>>   struct sev_es_runtime_data {
>>          struct ghcb ghcb_page;
>> @@ -2030,6 +2032,80 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
>>                  halt();
>>   }
>>
>> +static struct snp_secrets_page_layout *snp_map_secrets_page(void)
>> +{
>> +       u16 __iomem *secrets;
>> +
>> +       if (!snp_secrets_phys || !sev_feature_enabled(SEV_SNP))
>> +               return NULL;
>> +
>> +       secrets = ioremap_encrypted(snp_secrets_phys, PAGE_SIZE);
>> +       if (!secrets)
>> +               return NULL;
>> +
>> +       return (struct snp_secrets_page_layout *)secrets;
>> +}
>> +
>> +static inline u64 snp_read_msg_seqno(void)
>> +{
>> +       struct snp_secrets_page_layout *layout;
>> +       u64 count;
>> +
>> +       layout = snp_map_secrets_page();
>> +       if (!layout)
>> +               return 0;
>> +
>> +       /* Read the current message sequence counter from secrets pages */
>> +       count = readl(&layout->os_area.msg_seqno_0);
>> +
>> +       iounmap(layout);
>> +
>> +       /* The sequence counter must begin with 1 */
>> +       if (!count)
>> +               return 1;
>> +
>> +       return count + 1;
>> +}
>> +
>> +u64 snp_msg_seqno(void)
>> +{
>> +       u64 count = snp_read_msg_seqno();
>> +
>> +       if (unlikely(!count))
>> +               return 0;
>> +
>> +       /*
>> +        * The message sequence counter for the SNP guest request is a
>> +        * 64-bit value but the version 2 of GHCB specification defines a
>> +        * 32-bit storage for the it.
>> +        */
>> +       if (count >= UINT_MAX)
>> +               return 0;
>> +
>> +       return count;
>> +}
>> +EXPORT_SYMBOL_GPL(snp_msg_seqno);
> 
> Do we need some sort of get sequence number, then ack that sequence
> number was used API? Taking your host changes in Part2 V5 as an
> example. If 'snp_setup_guest_buf' fails the given sequence number is
> never actually used by a message to the PSP. So the guest will have
> the wrong current sequence number, an off by 1 error, right?
> 

The sequence number should be incremented only after the command is 
successful. In this particular case the next caller should not get the 
updated sequence number.

Having said so, there is a bug in current code that will cause us to 
increment the sequence number on failure. I notice it last week and have 
it fixed in v6 wip branch.

int snp_issue_guest_request(....)
{

	.....
	.....
	
	ret = sev_es_ghcb_hv_call(ghcb, NULL, id, input->req_gpa, input->resp_gpa);
	if (ret)
		goto e_put;

	if (ghcb->save.sw_exit_info_2) {
		...
		...

		ret = -EIO;
		goto e_put;   /** THIS WAS MISSING */
	}

	/* The command was successful, increment the sequence counter. */
	snp_gen_msg_seqno();
e_put:
	....
}

Does this address your concern?


> Also it seems like there is a concurrency error waiting to happen
> here. If 2 callers call snp_msg_seqno() before either actually places
> a call to the PSP, if the first caller's request doesn't reach the PSP
> before the second caller's request both calls will fail. And again I
> think the sequence numbers in the guest will be incorrect and
> unrecoverable.
> 

So far, the only user for the snp_msg_seqno() is the attestation driver. 
And the driver is designed to serialize the vmgexit request and thus we 
should not run into concurrence issue.

>> +
>> +static void snp_gen_msg_seqno(void)
>> +{
>> +       struct snp_secrets_page_layout *layout;
>> +       u64 count;
>> +
>> +       layout = snp_map_secrets_page();
>> +       if (!layout)
>> +               return;
>> +
>> +       /*
>> +        * The counter is also incremented by the PSP, so increment it by 2
>> +        * and save in secrets page.
>> +        */
>> +       count = readl(&layout->os_area.msg_seqno_0);
>> +       count += 2;
>> +
>> +       writel(count, &layout->os_area.msg_seqno_0);
>> +       iounmap(layout);
>> +}
>> +
>>   int snp_issue_guest_request(int type, struct snp_guest_request_data *input, unsigned long *fw_err)
>>   {
>>          struct ghcb_state state;
>> @@ -2077,6 +2153,9 @@ int snp_issue_guest_request(int type, struct snp_guest_request_data *input, unsi
>>                  ret = -EIO;
>>          }
>>
>> +       /* The command was successful, increment the sequence counter */
>> +       snp_gen_msg_seqno();
>> +
>>   e_put:
>>          __sev_put_ghcb(&state);
>>   e_restore_irq:
>> diff --git a/include/linux/sev-guest.h b/include/linux/sev-guest.h
>> index 24dd17507789..16b6af24fda7 100644
>> --- a/include/linux/sev-guest.h
>> +++ b/include/linux/sev-guest.h
>> @@ -20,6 +20,41 @@ enum vmgexit_type {
>>          GUEST_REQUEST_MAX
>>   };
>>
>> +/*
>> + * The secrets page contains 96-bytes of reserved field that can be used by
>> + * the guest OS. The guest OS uses the area to save the message sequence
>> + * number for each VMPCK.
>> + *
>> + * See the GHCB spec section Secret page layout for the format for this area.
>> + */
>> +struct secrets_os_area {
>> +       u32 msg_seqno_0;
>> +       u32 msg_seqno_1;
>> +       u32 msg_seqno_2;
>> +       u32 msg_seqno_3;
>> +       u64 ap_jump_table_pa;
>> +       u8 rsvd[40];
>> +       u8 guest_usage[32];
>> +} __packed;
>> +
>> +#define VMPCK_KEY_LEN          32
>> +
>> +/* See the SNP spec for secrets page format */
>> +struct snp_secrets_page_layout {
>> +       u32 version;
>> +       u32 imien       : 1,
>> +           rsvd1       : 31;
>> +       u32 fms;
>> +       u32 rsvd2;
>> +       u8 gosvw[16];
>> +       u8 vmpck0[VMPCK_KEY_LEN];
>> +       u8 vmpck1[VMPCK_KEY_LEN];
>> +       u8 vmpck2[VMPCK_KEY_LEN];
>> +       u8 vmpck3[VMPCK_KEY_LEN];
>> +       struct secrets_os_area os_area;
>> +       u8 rsvd3[3840];
>> +} __packed;
>> +
>>   /*
>>    * The error code when the data_npages is too small. The error code
>>    * is defined in the GHCB specification.
>> @@ -36,6 +71,7 @@ struct snp_guest_request_data {
>>   #ifdef CONFIG_AMD_MEM_ENCRYPT
>>   int snp_issue_guest_request(int vmgexit_type, struct snp_guest_request_data *input,
>>                              unsigned long *fw_err);
>> +u64 snp_msg_seqno(void);
>>   #else
>>
>>   static inline int snp_issue_guest_request(int type, struct snp_guest_request_data *input,
>> @@ -43,6 +79,7 @@ static inline int snp_issue_guest_request(int type, struct snp_guest_request_dat
>>   {
>>          return -ENODEV;
>>   }
>> +static inline u64 snp_msg_seqno(void) { return 0; }
>>
>>   #endif /* CONFIG_AMD_MEM_ENCRYPT */
>>   #endif /* __LINUX_SEV_GUEST_H__ */
>> --
>> 2.17.1
>>
>>
