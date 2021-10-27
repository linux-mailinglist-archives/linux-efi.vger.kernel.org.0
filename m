Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D561843D39E
	for <lists+linux-efi@lfdr.de>; Wed, 27 Oct 2021 23:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244218AbhJ0VPe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Oct 2021 17:15:34 -0400
Received: from mail-dm6nam12on2056.outbound.protection.outlook.com ([40.107.243.56]:38721
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244223AbhJ0VPe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 27 Oct 2021 17:15:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtTmlVNCH4ULO6RbZBRojQ7dihCsWcbEMe8cLHWknfNuFKtTQhUuIU8nboumg/yv0B2jESOM/qJdKUfkMJTcrFVREoux7pN1PAGtTKmNWhXx4ERKS8/L0mucdqNM+7+RMTJAzWo+DIayhcwQPBGU+93CNhAklkTvlNTnS57MOei6mmGhhgLTv20ITtI6lBBKlaCekPi7SKwHsjHhkCK0V/Bv/7X/VXesxU3o/65WYivTBse7YSb09/LFJY+FcPb5rq6w3gkES68p/6mBorvno710TEqibBKUSmZgR93o+dwI1Td3fAhLMX51NwaFL0Pbfbm4CtEDK7XG6mtOYmVq1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVgcmrN+4juaFuT4BdQI/tZYI26k7dKLq3axyMk8+TM=;
 b=C3ZR4yKdldBHpLlJyHaYn+BZ8sPcIbh+gZJYZmmqGTOBVW5YY+AJMG4wdZY8/xHViAqEV3fV5yFnwpLdgLOwY/jt3QO+Anb7drQNteZbVdfJOOBDSm0ikrKNp2PWKWzVaOQlmAjy+Qi9MDpY3ER8x1YucZSYNkqYymzmpG/+Bt0x2NLRg0Sciy6JkImEvzvo/w7A3NmBHAOdJxhOQPxzXL7uD37UZh6w8b+aSbHHN29KDXzmru6kYjAWcvXbuaJTCi53WNRi1wQpzqIH3i6XbMrikZ9Jy4e7FHOowJqwI+PyxHTeCF6UlPLoisl7oBWJ8lQyeiaB/t5768kLTcGdig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVgcmrN+4juaFuT4BdQI/tZYI26k7dKLq3axyMk8+TM=;
 b=OTi/9jbmqjYChqeKhaoWsWxIDGDlJ4WcvFQDSOcqggD+M2oroHpi6oHS/eGDmGMiXW04dEUuUvu+OoTgj+15jLvbgHuPOdMdHJ9+gNEAawP0ZteMeQyOgVBO5OQLmogGquhUexQbdJa+aI25DsS0dL6UV1JplYcmKONt248ibZs=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2368.namprd12.prod.outlook.com (2603:10b6:802:32::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 21:13:05 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::e4da:b3ea:a3ec:761c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::e4da:b3ea:a3ec:761c%7]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 21:13:05 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-coco@lists.linux.dev,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
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
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, Marc Orr <marcorr@google.com>,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v6 40/42] virt: Add SEV-SNP guest driver
To:     Peter Gonda <pgonda@google.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-41-brijesh.singh@amd.com>
 <CAMkAt6rPVsJpvdzwG3Keu3gv=n0hmYdDpYJMVoDP7XgwzvH7vQ@mail.gmail.com>
 <bf55b53c-cc3d-f2c3-cf21-df6fb4882e13@amd.com>
 <CAMkAt6pCSNZiB7zVXp=70fF-qORZT0D5KCSY=GrJU0iiLZN_Mw@mail.gmail.com>
 <943a1b7d-d867-5daa-e2e7-f0d91de37103@amd.com>
 <CAMkAt6qPHtOy8ONBtjn4V28P5F5qqQtnP2sD5YrBjbe_Uwkdcg@mail.gmail.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <ecfe3b3a-0a7d-86e7-08fb-f693bfa9255b@amd.com>
Date:   Wed, 27 Oct 2021 16:12:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAMkAt6qPHtOy8ONBtjn4V28P5F5qqQtnP2sD5YrBjbe_Uwkdcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:208:91::12) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.236.30.107] (165.204.77.1) by BL0PR05CA0002.namprd05.prod.outlook.com (2603:10b6:208:91::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend Transport; Wed, 27 Oct 2021 21:12:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca86a58c-7cce-4ce3-2931-08d9998e9103
X-MS-TrafficTypeDiagnostic: SN1PR12MB2368:
X-Microsoft-Antispam-PRVS: <SN1PR12MB236817E1E78FD88907CBDAF9E5859@SN1PR12MB2368.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: moaE/NUjfJtQUGXmkdtENHDRiVpmXqpAMX2WinhIXeAFw4LC6GhRLGBzotDu5cVrosDwNCbrCNtypFuWjZoYwaIEprIg1qctNPTt9M7CRTnFek3M95hPB04YbhQ9uTLsSCDEGBsz6EBDFL6vIBg2rPo/mWqIDEXwhs5jf+9WpfsdxBoFUmTSa1YNL9FY/BzApHVNCpga9SCe8hzOsPVFRqjMm3AgtWwtN+mRxinR1P4GGY5WO9p1ocuaK2c24Xy+x8Ky/MeZ9WEv4XjvgoDxnT+EzNwWRQVV248HRuHowxVCB9Y+w3BOMduP1Yr48ti/0qK7Gdf0Z709If+OXge+I8eV6oFaQEKVa1XivjL/1TAKD19jpu1Cu65DF8mjGgR1LU41kZxPi3CIGctAv1ZcrI28my6R3UMpLO81+9ahEMGwSdsHQBvUGtJu+WWaQANe+LJ28obWu6+z5xX/nZQXW+j7wigLRe1ryjn6oVfoPnsCrmp1POCHKZYRlg7yCcyS3QEQP+BZcw+XxIhk77dgUu8ELR2/YpcnddZIoQiGx2H9O9LrRwPdfLfMcBWJFGDVvjbybEcsCziTXsIUpiTGvtvE1+8J0uVAPZu6Rb3bFYZ5ouFVtHE6la9Xcqki9Xp80Z/2WwcO1DW61huPGzh46+p1OysdFvSKqzeSHa5o0+x8067wFdqY1y+hdXFAPgQBg+DExB7oSzwRpjPBqdC/Ml4etaJgWnXIjdcXknGi/wKvil1shrOisVSH0bfqJAPc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(83380400001)(508600001)(2906002)(7416002)(2616005)(86362001)(26005)(31696002)(316002)(8936002)(956004)(4326008)(6916009)(36756003)(5660300002)(8676002)(44832011)(54906003)(66946007)(66476007)(66556008)(16576012)(6486002)(186003)(7406005)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnRsM243RHRCdVQrUmVraC95QWlOVE9DYkxKcm1kMng4ZkhVQXlwdmJhMFFJ?=
 =?utf-8?B?QkJ2WndGNG1pMkloSmIzTmFmUUc4T056OFdMaWxqOXpYTnNjczNzcHBrUkMw?=
 =?utf-8?B?Q09tdWZzeG9JR0ZremZXMG9UUGp4TkZBWWsvY2JYcmhmbTA1aGtNditMRzZQ?=
 =?utf-8?B?R0ZCZXQwRUdya1Bsc3NwMGdwbGlZQXNuOGE3Yi9pMGdSUWVNWkZVaEJFNi9Z?=
 =?utf-8?B?Rm5DU2Z4eUlPYk1EazBVTGhFQnNpUzI1YWpNd2dEdzVCQjhuVFVEbndFQy9m?=
 =?utf-8?B?VHJzOVBXWGVBamt4dVBTcWZESGFaZ2o1Y0ZqZU5MT0R3WGhVdC9WbzFzeis3?=
 =?utf-8?B?Qk5iZkdOekxBQU5WTjVDSmtjTjc5dDZWV1BycE1vTlZocXlhWkF4V08zVll5?=
 =?utf-8?B?bU5oYzZoRVhFYnd5VjRyVmtHdXZoQTQ4YkRadHZIcWE1YVUzajNBZzB6b00v?=
 =?utf-8?B?S3NtN3hoVFoyeVNHQldYOXBPNUVhdUlWV1dZVFlXcWUvL256RkxYSEFZSVZJ?=
 =?utf-8?B?MncyeXFaRndUNS9OQmRHS0wxSHBkSGZCTVNzaUg4VURRd3hkMDhBeUEvdGpJ?=
 =?utf-8?B?b3FjT3Q4b1FJSTJjSWhYWUpWNi8yaDh4MXNvbk51anZPdUQwMkFvVzIrRHNN?=
 =?utf-8?B?MWh5eVg1NjNnUHlQN0UzNnFObXVteDZYMUFmR0pxQW9XbUgwNnZSRG4yZlIw?=
 =?utf-8?B?SEl0ZjdzeTNUcmJNSlVIb001anlHV1ZWc0hPdXRmb3J6YnA1TEdneklXV0Fn?=
 =?utf-8?B?UENyZDJTVURyUml0NjZ1eEtGT1VPUlhBYlpBbEdzNFAvb2RYb2RmN2JwdDJ1?=
 =?utf-8?B?T3MyM2dEbXBWaWNwejRYK2NDUWNBTVNLNjlLQ05DUUN1QTNJZ0lrRnBQck9z?=
 =?utf-8?B?ZHpEVEdkbFlNeHdzK0lDUVpTVmdxaitiZFpnN1NaUXlrL2hUZTVRQ09saERz?=
 =?utf-8?B?RzVFUXZybEVheHhUeGRYYk5ac0NSU3dkd0lRU1hGZzZiRStQeDMzQUdXZ3c4?=
 =?utf-8?B?elF6NGJuSkxkai8wQ1E0Q2xzYjhiZlk1VkcyVG5VL1F1dWFVWldDS1AwNDNN?=
 =?utf-8?B?djgraFVNN0Zsajg4RVZwTC9lb3ZyTWIzTUU0YjVBSTN2UXMvQkc0WUdtZ0x6?=
 =?utf-8?B?NC9IZFRFT1hjTk0wTjVLcTFCV1JFNFY2THhMT2Q2VUU3WDFCY1Q5bVdKTEov?=
 =?utf-8?B?dU1vZk8rTUFtendyZVVMVXVwaFczdFFBdzdTWGN2RGw3V3hlUDNENlZ2ME16?=
 =?utf-8?B?bStPVDFsRFpUQ2NKdTdLM3Rpd2JjOEtSQjhUR1VkMFJZWWVKZ3lnOENwZUNi?=
 =?utf-8?B?ZU5pQkxqcDNZUXdJQWNIcVVReDI5WEJ4bTh1OXg0SzZkN0M1ZDljenYrQzky?=
 =?utf-8?B?OXB2Qk1EOTJIOEdSOENUWlhTYVBpbVQyQzF4bDBwdnZEaWg0eWtVdkVkeG93?=
 =?utf-8?B?UlpCdXVGMUhQMHVIei94Q0J2MldtdzBBYlFkU1k2M0p0YjJWSjU1RUlneGxa?=
 =?utf-8?B?eWFERUExT1VYZmpzNU41bFVJVkgxM0dvNTI1MithcHBjTk9mcGJUNGxRaU92?=
 =?utf-8?B?QjIwWTVaMzlUVUI0alNvaFlBdElqNTFmTUp1bjF4K3NoZGxYay93SnVrK1pO?=
 =?utf-8?B?eXc5RGVOS0Y1VE5IcFdGSUpjcmxNbGhNamlGK0ZHdmtzNHlibVJwL1lIakxh?=
 =?utf-8?B?Qkt3dFliS01xMmh3ZHBnZmxmbU5URkQ4VjhNRW9mTW1YOHQ0Nk5nR1RZbW1F?=
 =?utf-8?B?Tk5vaDJaa1k4ekNDYWtndUZWNzMwQWZqRkRUM0hJbVRXZ1FVZjhLN2xWSDgy?=
 =?utf-8?B?a3l1ZjZpMVFPaUVzT1cwV3dSTXhvUWdsbmUwL0NYUE9abFY3c0lGeWlPWEtt?=
 =?utf-8?B?ckN4blcxWlFNRHJDODBKT2ZPYU1ta2pCNnJkUmt6WVc5WmpUTm00YWRkeDRo?=
 =?utf-8?B?Z2E2OUM1MkVra0dCZTBHNzNubEtMVDgxN0o3S2U5UTIzWXhqRnlPMHNkMFdq?=
 =?utf-8?B?OFBNRmZtN1hxczNmYjkzYjhyU0NnMG1JWjEwdWJaZVFVTy9VcjU4MFRKU0pE?=
 =?utf-8?B?UDBzNmhTelRFM1VyWWNhZHJuZHAyYmJNQTFibXJRbFBIUjNCUklENVdJRGtw?=
 =?utf-8?B?WFBHUHJiMUVFdERhZHZCM1ZmTkZGRTFQaVRzVHNsNUQ1T0x2eHdyV2xtRkN2?=
 =?utf-8?Q?yj/rPh6p2R2/wwSEZP7QBQ8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca86a58c-7cce-4ce3-2931-08d9998e9103
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 21:13:04.8913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+QxPVgAYlO4c16IdDIVzOrGYQVO7pO80mmvH4BKKvB3syme65GchAeqAdBWdd3R66tZTRjeAAxMlBDi5uJQqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2368
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 10/27/21 4:05 PM, Peter Gonda wrote:
....

>>>>>
>>>>> Thanks for updating this sequence number logic. But I still have some
>>>>> concerns. In verify_and_dec_payload() we check the encryption header
>>>>> but all these fields are accessible to the hypervisor, meaning it can
>>>>> change the header and cause this sequence number to not get
>>>>> incremented. We then will reuse the sequence number for the next
>>>>> command, which isn't great for AES GCM. It seems very hard to tell if
>>>>> the FW actually got our request and created a response there by
>>>>> incrementing the sequence number by 2, or if the hypervisor is acting
>>>>> in bad faith. It seems like to be safe we need to completely stop
>>>>> using this vmpck if we cannot confirm the PSP has gotten our request
>>>>> and created a response. Thoughts?
>>>>>
>>>>
>>>> Very good point, I think we can detect this condition by rearranging the
>>>> checks. The verify_and_dec_payload() is called only after the command is
>>>> succesful and does the following checks
>>>>
>>>> 1) Verifies the header
>>>> 2) Decrypts the payload
>>>> 3) Later we increment the sequence
>>>>
>>>> If we arrange to the below order then we can avoid this condition.
>>>> 1) Decrypt the payload
>>>> 2) Increment the sequence number
>>>> 3) Verify the header
>>>>
>>>> The descryption will succeed only if PSP constructed the payload.
>>>>
>>>> Does this make sense ?
>>>
>>> Either ordering seems fine to me. I don't think it changes much though
>>> since the header (bytes 30-50 according to the spec) are included in
>>> the authenticated data of the encryption. So any hypervisor modictions
>>> will lead to a decryption failure right?
>>>
>>> Either case if we do fail the decryption, what are your thoughts on
>>> not allowing further use of that VMPCK?
>>>
>>
>> We have limited number of VMPCK (total 3). I am not sure switching to
>> different will change much. HV can quickly exaust it. Once we have SVSM
>> in-place then its possible that SVSM may use of the VMPCK. If the
>> decryption failed, then maybe its safe to erase the key from the secrets
>> page (in other words guest OS cannot use that key for any further
>> communication). A guest can reload the driver will different VMPCK id
>> and try again.
> 
> SNP cannot really cover DOS at all since the VMM could just never
> schedule the VM. In this case we know that the hypervisor is trying to
> mess with the guest, so my preference would be to stop sending guest
> messages to prevent that duplicated IV usage. If one caller gets an
> EBADMSG it knows its in this case but the rest of userspace has no
> idea. Maybe log an error?
> 
>>

Yap, we cannot protect against the DOS. This is why I was saying that we 
zero the key from secrets page so that guest cannot use that key for any 
future communication (whether its from rest of userspace or kexec 
kernel). I can update the driver to log the message and ensure that 
future messages will *not* use that key. The VMPCK ID is a module 
params, so a guest can reload the driver to use different VMPCK.


>> thanks
