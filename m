Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDFB485988
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jan 2022 20:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243740AbiAETwW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jan 2022 14:52:22 -0500
Received: from mail-mw2nam12on2089.outbound.protection.outlook.com ([40.107.244.89]:64096
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243691AbiAETwV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 5 Jan 2022 14:52:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8gSV6fOtJco0QLCoYH9fBLT/CYNfEFNIqp37w7jiPNhN1nMhm6mDfaNAJfusqfrIcfcN1oo9r2Au+LJYos6gztwuHIFOygFPUYdSu3bNNXYEZ+PmSkF5k5oF9ftp+EkwJnsTmL/A4h3FqwL/jbvZr+4FVCmW2CWMFK5bqOKaOAwLH7OS6TVBV1TNcArpKQvpayWkQ5tlCxG6w8aQyg/tDpeci4zbu2hrQnvp9TRKUQh1qbjRs+Ug1oQfWuKb2F7vbqYNLfNih8FFo9awXCvC61gwjLZLAqdmruA7U4xAvI8oEVxYFkFsTLMH2/PFdY8A6HA8Ljd1SF93VVh8nIP4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olvjmFyYCjCvq0IhrZH73HTyCmTaZDM05XLt2XyZ+mA=;
 b=F3scrC6A9M6JaJT5/7QM2yezbd8ovKWHmm0ptSQWT6qSbUmNypDPvFwYZoS70hmIhOeEr5RUgSr4fNnhOrdqxJKNWm5zJN+Qtl9ayRiUk7RfzqFCKQyoKz5XVBmSZP6ok9mo9w4rtiAYLIBO2l9SA7xwSpYrokSz+OSWc83OR+bHk3a1fbOBpYQSM8LdJzIw4pSYiWfqL/9i/Q494n6WZLTnWjlBIa8Kq1sj2uDcBqy9RNgxFaS8IzWvtddXzZXblJv0z6cw0kJotAsukaQpVCafWj8hz3dgF/jWnCcbDz98MyY9rDn2k4D/J3l+on+271ycIE5/l1aIHSiADIcThA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olvjmFyYCjCvq0IhrZH73HTyCmTaZDM05XLt2XyZ+mA=;
 b=mqDvarSHNZRx++Ul9bIYMkg74KFhIxJX//2KXlcKBqUfzvQ7BL5KiZew895vu8NIMX7t1/TDIWPCa84+eeZ8RdVH9zOB0E3qkO9i0vX9GY0su5Hqhc++1+nP90DpbE4fa5DeYbA4yZG7jr6NP+g+bLd6Yf7dmoaEuiX6KDiTM1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4573.namprd12.prod.outlook.com (2603:10b6:806:9c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 19:52:19 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c%6]) with mapi id 15.20.4844.017; Wed, 5 Jan 2022
 19:52:19 +0000
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
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 13/40] x86/kernel: Make the bss.decrypted section
 shared in RMP table
To:     Venu Busireddy <venu.busireddy@oracle.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-14-brijesh.singh@amd.com> <YdSKQKSTS83cRzGZ@dt>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <18eadf9d-8e31-0945-ccf4-2cb72b8e0dd4@amd.com>
Date:   Wed, 5 Jan 2022 13:52:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YdSKQKSTS83cRzGZ@dt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:610:32::32) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 477b968f-64fa-4ad2-b535-08d9d084e1cc
X-MS-TrafficTypeDiagnostic: SA0PR12MB4573:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB45735E035885FC4F0DC41121E54B9@SA0PR12MB4573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILfJZDI2hbqRQrmnlwGyfXevrEXLdjRPK+hNfy3+1uILz9vDazNdSx9q2yi2DzxeWHVZtPQIEjcKe+z0l6Jcv9g0AjFo79jnoKAq7sJS+y/XrYHmudx2zO8QFn0kNsByi4vAzwnSbhpfVCs8heaREkEHSmGJu0rYmaaoGdnZexBARkVg8XbfQc4/t3JXrs6/UlMF/otm5V3IAVnULO1+3JGcKN4VjG2qBqvoj994gFLKHxcoFDzmeHenpDEvn4nHA/pB142QZvWJHLyyHBa7asFAnxRiGPhucZECRWnvwtFIDhCOnlZH2ozY5gbnDvf6uxHl0Xiu/dZkO4ySvReWfHA15V3vqGcNcV48VvczzsfmIxHotZRlQ4Eyyl1V6fW+U14gOEQYtgNl5BM9OK5Ftaw6HGKHdBpUJDYZbEZyhEvLgT7CJi2mcign5EODg2ESWlIlgAX4huSWHGPKmeZS81ltAhvs173drSLHIgprdM8H6kiw8ik6IUafOoZLBt3X+dVrgMsprfMqIKSN4BdtFBUxbUmU28qWLf+xxStPYbWrG2VDIXnjBKEcZoIhkN1tTctH5rJMzJuOPo3+KANkcJKngw/iBRFuii10mU1OUuXYbC/zemXBLaE4BjufLp7Tha5fYev0Rwry4UTq8BxuidXlCjTRd3uJYT3F/NoY9jPB/iBG7rdOLiT26/suUeR1Zvsu4dWdbZPCI95XVO+3yMkBNwvhYHcwOqOcEfxPM90=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(66556008)(66476007)(44832011)(83380400001)(316002)(6916009)(38100700002)(6666004)(6512007)(2616005)(6486002)(7406005)(7416002)(508600001)(8936002)(8676002)(53546011)(36756003)(31686004)(186003)(31696002)(26005)(4001150100001)(6506007)(4326008)(5660300002)(2906002)(54906003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sld4SWp5eDBmd2M5clVaK1ZhT1V5UENMSVhKTXJhSU8zUEMwZ2tXS1NBTTZO?=
 =?utf-8?B?Y296ck5lYzhET296Z2N4UEFwc3czYnVmS2Y1NjQ5clg0YlMzZ2hScFRZUTVy?=
 =?utf-8?B?aDhRQ1FuZCtpZjZQNmppRndxRk1aVzBENndIQ2VnMkdscW9jbFVkcVhtTjFz?=
 =?utf-8?B?MC9jeWdaVGI4M0lDWGM1d0xIR3NESVpOYWRoaUxZK1piTEtsUHdiR1JjUHFZ?=
 =?utf-8?B?T0V6NDlSRnh2K1MzRG85aktUd05zdDNicE5aL0o3YzV4ZTNvRzdQakJtS3Bv?=
 =?utf-8?B?SzJOdGRpK3BOZkxwckUwMmxvSHIyYlU4UVA2T3NjTXl5TWgzQ0ZQR3JwR3Va?=
 =?utf-8?B?b2RObVU5dlkwcy9TWVl6QTBHRXB4LzJEcnBFQzVxR0U2S2VJU1JvMUZTRUZR?=
 =?utf-8?B?d3lHRjdWaitHRG9GNlU0Sm9hcFQrQ3pEemV2VWI0WGhOSWRCdHlkMEhBMzhO?=
 =?utf-8?B?WUJRSWt3bUduSTVvaENhZElLRitKa3JkVWVVd1N4NElKR2Vsb0VjN1R6Uk1P?=
 =?utf-8?B?aDJPWTJvZVZ6R1JrMm83NnQ2V2t6Vi91VFFqdWNFVWxqVXBpT2pPdk9ocWNM?=
 =?utf-8?B?cGRLL2RBWmRDU24xREw3SUpTdGJMNmpONmtudEhaODFqUk1UODRUOXRGSEo4?=
 =?utf-8?B?eHQ4dCtVZ0lwcGZtSjNWZHNVc2pBcjE2M0pzUWI0Ym5OZGl5TTZheHVMSGN0?=
 =?utf-8?B?K28xT01xcTNTN3ZmeWp6NUVSR2xBK2F5Y2VhZmRseHQ4SUdEb1Y5SlZFR2FU?=
 =?utf-8?B?dXkwSUxTSjJ4T1YrOGljRXRQUmtFbXgwMVd6NTFmK1pvdTk0RGpObW9PMU9r?=
 =?utf-8?B?WGxsellGVEFuSTNOTzNjaFJ1TGV0dC85WVBSYW9XaEZvSHE2Y2QzSmt2UWRC?=
 =?utf-8?B?RXF6cU82L0ZpOWJOT0lVL3MzWlJWN2NZVjVBemllRGd3NUg2cDIvSlpPVmJ3?=
 =?utf-8?B?aGR4bThHd2R4Yy80Ym5mbzJHMlp5Vit5d0pnSnpwMFZFU0lOODR1Q2srclpE?=
 =?utf-8?B?aDFkMHBiREJBT3JNZUxYYkxiYVVDRENncTUrYUlWeHJ5T2x1M1hna0pzbjho?=
 =?utf-8?B?bVIrdTRlejBuY1Z0VTZhVnBONUlQd0gzTjdCZmp1d0YrYU1YK0JGT3ZPUlp0?=
 =?utf-8?B?Y054M0ZiR2FReWtNNkFzLzY2cjlOVDRQN2I3VjhQbldRTFA1UXlpZE91SEY0?=
 =?utf-8?B?Y2hSbUhxamVFc05vZXEybERseEdDU1NYa0NDWFpDb0xTdGJSMGdqd0RtdXBT?=
 =?utf-8?B?Z1BkanpLeURjaHI1bVNOUDF6TzIyL2RoSDZuSk9mK2FUYW9tWUlDY1JsY1Fy?=
 =?utf-8?B?QThCS2dtRExGVDlaRlZJYyt2Y3p6ZDhKcjFpOUloTnFzZERKQllpZnlJaTFE?=
 =?utf-8?B?SHFOakVsVk9VQzA5bXdHZ3phSmp6aWp3K2VGblQrZDcxdkdxdVFNbmloOGdV?=
 =?utf-8?B?aE5tYng3WE5iWkhBdUhvY09PVGlnU1NGSkYzL1NzSmtEOEwzUTM0VXFlU2pZ?=
 =?utf-8?B?d2RsNzhQcVFyeXYxV1VJL3VrcFE5dmJRbjg4RHhKTVhpMmNaWEprSlRxTUYx?=
 =?utf-8?B?UjM0SUgzOSt6SERMLzg1UWlvbkpLcjlNZXJNcHpFZkJXOTJ5d0djS1owYW9S?=
 =?utf-8?B?d3V4QlpUUzdQYXVLTHVEdE5FbXFSNmxCekFEcUJBdkdxSG5tYzAyeHZ2RXgx?=
 =?utf-8?B?UDNQNUR1VE5NZHhqYnR3dWhZRzdaZmJXTnZTUlduVVpiNzdUdGQ4QTdWTUl5?=
 =?utf-8?B?c3lIakJLR3RRSFFGdWpLOGduL1UvbmJxU2VnMkYyY3lqTk5laE9QZnMweWtO?=
 =?utf-8?B?L0JkclFuazBGODZGUkttYWc1UUdMS2J4bHNDQWpDOEs5Tjd1RExwYk5aQ29w?=
 =?utf-8?B?a2ZFMEtyeEN4aWhTSTRic3FwQVlaZjkzYnVxOVZKOExDM29sa1hCbURDRFlj?=
 =?utf-8?B?NUtmSmpOeDNZS05SeVhNMldjVkZYSVIxekJwNVlZQlJibEk2MkdSaEdFbHRi?=
 =?utf-8?B?dWZOTys1QUxXT1ZUTGZPNEdMWnZabzAzQUtRM1UwNzBvaXRLdHVrNEFUSndh?=
 =?utf-8?B?VkROTnY0bTRQK1NkcWNQd3kxR1JFWGc3K2xMUytXbWZLREZKd0x3bGxWNk9U?=
 =?utf-8?B?bUlIKzZyN3NNUmZrb2cyS2REVHVoYTdxYjhmQUlScHFrNkFUNXUrNDgvSkJs?=
 =?utf-8?Q?MnQ2EaGbLLK8v0KgL+wmZrg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 477b968f-64fa-4ad2-b535-08d9d084e1cc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 19:52:19.4494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cr1exdPyNOKWEo7xp5egweCyaS3lZezhUhz3IxmTMBlDl170U0KftjGyjWElcytOMlb2SFlvyOjdjn+7gk7zqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4573
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 1/4/22 11:56 AM, Venu Busireddy wrote:
> On 2021-12-10 09:43:05 -0600, Brijesh Singh wrote:
>> The encryption attribute for the bss.decrypted region is cleared in the
>> initial page table build. This is because the section contains the data
>> that need to be shared between the guest and the hypervisor.
>>
>> When SEV-SNP is active, just clearing the encryption attribute in the
>> page table is not enough. The page state need to be updated in the RMP
>> table.
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>   arch/x86/kernel/head64.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
>> index fa02402dcb9b..72c5082a3ba4 100644
>> --- a/arch/x86/kernel/head64.c
>> +++ b/arch/x86/kernel/head64.c
>> @@ -143,7 +143,14 @@ static unsigned long sme_postprocess_startup(struct boot_params *bp, pmdval_t *p
>>   	if (sme_get_me_mask()) {
>>   		vaddr = (unsigned long)__start_bss_decrypted;
>>   		vaddr_end = (unsigned long)__end_bss_decrypted;
>> +
>>   		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
>> +			/*
>> +			 * When SEV-SNP is active then transition the page to shared in the RMP
>> +			 * table so that it is consistent with the page table attribute change.
>> +			 */
>> +			early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);
> 
> Shouldn't the first argument be vaddr as below?
> 

Nope, sme_postprocess_startup() is called while we are fixing the 
initial page table and running with identity mapping (so va == pa).

thanks

>     			early_snp_set_memory_shared(vaddr, __pa(vaddr), PTRS_PER_PMD);
> 
> Venu
> 
