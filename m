Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3158848BA4A
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jan 2022 22:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbiAKV5U (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jan 2022 16:57:20 -0500
Received: from mail-bn8nam08on2071.outbound.protection.outlook.com ([40.107.100.71]:22436
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230508AbiAKV5T (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 11 Jan 2022 16:57:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2INDhvuiPqrGktetBjS7nuEDiQLn0Wm1rGFPcYFkEuyxHskW1wCbsSIrp2+RL+9xQflFBtFT8YiaIPtrzR7CsrTyKM8vJIOXWo+azWb0IaVm2ypPkoOnlF9D291J3wAE+6mISJfiBvA7e7oBtufCIdkDPzOqVkzRRrn0obpo/KdXors48xRbadeMQtf9csPWW7mYDLVUbHoLzLBpXMSSNXscQQsssYpQuIPDTl0ngynlNKew3rqF2nYlAcBMMF7w//DFAy62ydinysE8ss1V5bE01tREff2dklWvQPET6k2u9tUbBESaut7yhjzgkAo2RB6UCOHS4Dxi5FQaIaZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXfxuPekyRAgiXo5r3pReWJw86tRcNE11pct1HiPRmI=;
 b=IHozKnMUrDi1G2AJu7afDGm+oCB0hZTz6qX3LausIKpdyztpFxyLMbVSwt5/mFkKb0+qCEP67HzyPCs7A39rOLWLdv9/RPTaUX1wEO7rE+jqiF4mDU5p5jv1uiG5paL1avDOVKzPIXp2jdv5GFoGlwpjdNClEnYiJy2c7jk77bHmXilFPh4qCurQHDaUIMu3mzoUVJx4ya7+QW8jp/vL55108XlrxdJl91uPGB0cHqX0BbUzEHLm4t0LROwav4FJvwRLBkHyar9gCwUZZU5Ub2Fv8dcOwNSnTIQhvsZs5epjdSlOWcYLeg1YbLeGt+3XiyV7UXYfL0NfGDpa6hiZMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXfxuPekyRAgiXo5r3pReWJw86tRcNE11pct1HiPRmI=;
 b=SoNozr9KYS4SY4F+lcXVSbDrnMh72nsvCGLSGX3OrrIIhVhvsMZo7Cb+/T9khmZIS60TXTx7DszUfbTGsB0JHeKuTpUqFUgX/GDHxChclFqIrYfpjgsDzy9618UDEwjrnsL2/MEKffgTlIPXHhiNF9A6xLsa6GZ1GG5M7SbsZW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2714.namprd12.prod.outlook.com (2603:10b6:5:42::18) by
 DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Tue, 11 Jan 2022 21:57:17 +0000
Received: from DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::940f:16cc:4b7f:40]) by DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::940f:16cc:4b7f:40%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 21:57:16 +0000
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
Subject: Re: [PATCH v8 12/40] x86/sev: Add helper for validating pages in
 early enc attribute changes
To:     Venu Busireddy <venu.busireddy@oracle.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-13-brijesh.singh@amd.com> <YdOGk5b0vYSpP1Ws@dt>
 <7934f88f-8e2b-ea45-6110-202ea8c2ad64@amd.com> <Yd374d2+XdBD+vTM@dt>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <91194a7c-b363-6356-4148-5a5222b86a59@amd.com>
Date:   Tue, 11 Jan 2022 15:57:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <Yd374d2+XdBD+vTM@dt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::28) To DM6PR12MB2714.namprd12.prod.outlook.com
 (2603:10b6:5:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7427f637-f148-4625-866f-08d9d54d5506
X-MS-TrafficTypeDiagnostic: DM6PR12MB3324:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB332481D26E4BFD0CBC9A2FB8E5519@DM6PR12MB3324.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fOLj4NEAxmRuCfw/iO6uKzkry5T57rpuEAwX+NbwE1X6Z/HK48/hzrEz1+FicNsUsg1ZNWF5OeqXS0jx3Dgt3f6tEOWmZHcnTzCyK7Az4Hq4LGzEG6PVXFmnanXGmbdhNVxFHCNXFtWcq1ytbpubj9Uxdqbw00rM4Cp01cleNrem+xVsKlXtBoCXVdclfCZAHwG/Ujarb3S4alVYzJnh6r6fjHgKo36zka0NtVDpXH4lsWPeZtdYJTu+P/RetJHaOC6U4Rb5TD+otW9egAHOJ0wyXPyIamY5zTXj9Lnr3jDPeYXx6RdJETk0mMBKGNJzhkeKhrZYa2q8wpJXslhkMYgs0wxYGhBQMKk1OP/u2VwRTZl0dEFjeqpWrjyti5jcqX47blkevDV2Qv3Pai4oEuky0jCWOyLwCvQjv2fSe22RAagf0o7fbE5sE/ALlD7orIKeiRAOCCTo49/w1cxnfYNURfLXEuOJ17QsbhBJq9773hnimBaalvHooUlzY6Urg2PUU0qavhy4a33rqNtbtz2gzKutZnhBvfucLL6SdDT/CCLbsLnLZriz8jTIzwajOGHHyllAAu1PB0mV15HFXAc+XxLzcds8PwFGaN9c5DpeDDUkwo+/7GW2pQhY7+eqtRBTab8UUZAVnfHDKp3PKyIUdDX/GgTQ0/Lr5kpDIF3z4Z+Ek5N4DDHytmk529+3c5obqYG36me251nuD95AM4IOhgApJUi7IRnC5fMMXdwS1gK6zCBg7molyyA4CMjHHmn0sUDNbJAalcrlnfzGdvL7FD902c1m9fV9kZDQ5PshmrcJBDLqHCFX1VD0t43T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(316002)(31696002)(4744005)(83380400001)(2906002)(966005)(66476007)(54906003)(66946007)(66556008)(186003)(5660300002)(86362001)(6506007)(53546011)(8936002)(4326008)(8676002)(6916009)(36756003)(7406005)(31686004)(38100700002)(7416002)(6512007)(2616005)(26005)(508600001)(6486002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW85Umw5QjhnNjd6TnBIQVl5cHQ2enN6ZTAyUmhURnQ4YnZibitUckc1SXE4?=
 =?utf-8?B?UGpzUVVCTWVreElITmVnaldyMlNsc3BYT2pCZ0tsbWJtY3R0clFvVnNjTEl1?=
 =?utf-8?B?YWN0WnF0NnBRSld6RDBBdlQ5eUZXUzZDVDFLdnNQR0V2RG5KdGVNQzgvYXQ0?=
 =?utf-8?B?dnJ5L2lkYTRTS2lidXVtR3ZxOFNFUjhnZ2ZXS3lXTGwwNmNzS0dYN1krM1ht?=
 =?utf-8?B?Y25BY3NwUHpXSUVqZjJOM2pTUEl0OVFoZEFHeHZSUFRGaVllN25wMmpMeEV2?=
 =?utf-8?B?cjBXeXZpeEc3dnU3ZlE0dXR5QWNIWFRNSWIxV1pBTThCTUFCOXRyQU1tNmNF?=
 =?utf-8?B?RHlGaTdxb3dlWngwWXRqTkQ4VG9tUHgzUmlvTi9wR1R6MHd0Wk9najRBeklv?=
 =?utf-8?B?RllWamZMdGtrWWQ0YlNGM0E4alhVbnB6ZnhZRS9qVHY2dVRXTnJrUmQrS3Np?=
 =?utf-8?B?Tnh5c0QySkNVSzkzTE43T0pQdjlSdjRoRmVSSFFwSlZDenNQZVF6bG14SFp0?=
 =?utf-8?B?OVI3blE2TEwvVkluc2pDSno5VkFKMkJ2MzAvWE93eDlwK3BjRlc0aE0xamVp?=
 =?utf-8?B?NkpSRWM1YTRHYUNvTmcxdXFOaS9ybGZqdEFuK3RaMU5ndzhtbXlGdTBtWlUr?=
 =?utf-8?B?TGxUVVR3L0Y4SmxOOEtsN0VMMzk4THRaVW0wOXplNjllbE5ETTNDUzRKTDdp?=
 =?utf-8?B?eUF4bkVjbVNjNnZxdllRWTVtTnUrQytOYVk5NFFuanNoMVRDSElGbUh0R1Z3?=
 =?utf-8?B?T2krWGFheHJsRXFicmlGTWU1cEJYTG9wL3o2UmdxWWdXek5PZklmNkYrZjFD?=
 =?utf-8?B?OHRpOHYvQXNPdGhhRHc4OURZNlNET0NYZllFSHZtV25jQXJCRmFkMktzb1Rp?=
 =?utf-8?B?bHIwUlQxOGNxblBmNmo4L3Awa20wcngzelc3OWpYbEhRdGc1a0Mzc0JQazd0?=
 =?utf-8?B?MllkRk9xOThOVE9oandRUFQwSmhmVnpzZld6N1gyZ3NQWmNnQzNsNnA4WnBD?=
 =?utf-8?B?VStqWXZUUkN2UTlGVGs1UVc1YUxBRTNtMmVIcHQ0aXRialpqYkNTUkNKNzFJ?=
 =?utf-8?B?RDlsQllLS05RUDg4WHlmVUVUdUgwbnJUcEFrczlKc2liSFN6b0xmWElsZHox?=
 =?utf-8?B?RG9UZTNZUzRjQWZkU3lRRUl6c2lCaW1mMm1PNkxwUjd0UUxPT2xxeUhlSWgy?=
 =?utf-8?B?ZlRvclBsdnVSZDBHU0tXNzg4MGVLQ2gzYW5XMVlKUXNFYmhKbjkwSkpKSDBE?=
 =?utf-8?B?cHlLcnozVzZjL0J0b09XWGRDLzc4cGpXTVFBRnp2OW1jR01LS3lKdTBBYkN5?=
 =?utf-8?B?VjRQTi9OVk5QY3FKMFhUTG56MU0zRjZWbTVFbzZqaUgyWWNLM0R1aVZUb2tO?=
 =?utf-8?B?azdzU2xMRDlmVk1NYjI3WEpBYzJid0Y1aFF1cUF3MGpTUk82RnYxc2ppYVVW?=
 =?utf-8?B?T2Z0T3BaSG81aVUzYy9qbzBkc0xmck4zNDFxUTdKSWRWSkYxM2xrV2F1ZFIw?=
 =?utf-8?B?WEpGUWVaZzM0Zy9Ib3FqdVJ4d2pmYkVWSHhaNTdISnMrYTFEcFdrUGFQZGhR?=
 =?utf-8?B?NnczWGVrWHFrVTE4M3lpT3R5dEk5V2ViV2hMeS85NkRIMEt1TlJEUWN0S1VW?=
 =?utf-8?B?N3BGK1JWSWpvQzk5YnRuMnRkakhFa05HYktCNFYxUDgwZjhDKy9nVkhDWGNF?=
 =?utf-8?B?RUpkMHU4UXBZeVFicGpkaTFMU3E4eWdYT3pVN3UzV3BOZzJBM29vamJtUUJI?=
 =?utf-8?B?eXlhd2E3V1BQNWNWamNLeDJ0TFB6WGZrZUNMU0NVNUFnWklidVplb2tDdWpH?=
 =?utf-8?B?RDFyZ1JhcStzWUNja2k2T1hFU2krdEhNclpBa3IxRGpxVXVZNTdNSlNOVzNQ?=
 =?utf-8?B?TDFMcENnU2JqNUxJSTFOeGlKLzFDV3JObE5OdENIL1R3bFhXcUxYMVg5ZVFL?=
 =?utf-8?B?U0lhZjlzWUpVeGxpeldkZWpobCt0VysrcW9yZUQ0VDlvSWs4V0FXRUZ5d1Zp?=
 =?utf-8?B?MHFub0pBWDU0dDB4eUc5LzdqdWZnWVpWalY2QWFPdEFnNzh3VFNFTTZPcS9F?=
 =?utf-8?B?Nm5KaTAweE11L2JRc0RWTUZpV0tzNDJaUFRDb0ViSldoRWcwb0hkbERiQ1Rv?=
 =?utf-8?B?NS9hd0FyeUtpZG5WUHF3WjF6ZjVhaFFZQ2hyUU5Ed0ltZ0ZNZmFJckhWUDdQ?=
 =?utf-8?Q?+KeXteSWeBjQg0cYBlE8nDo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7427f637-f148-4625-866f-08d9d54d5506
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 21:57:16.7824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YKV5xU1QKotWg3eClCsdPQ4L95f78/DXAHF7LC6l6tC1QYwpfSdWbIIfuC9l1Fn9+fQoWz60k3uYcCeilEsEkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3324
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 1/11/22 3:51 PM, Venu Busireddy wrote:
> On 2022-01-11 15:22:01 -0600, Brijesh Singh wrote:
>> Hi Venu,
>>
>>
>> On 1/3/22 5:28 PM, Venu Busireddy wrote:
>> ...
>>
>>>> +
>>>> +	 /*
>>>> +	  * Ask the hypervisor to mark the memory pages as private in the RMP
>>>> +	  * table.
>>>> +	  */
>>>
>>> Indentation is off. While at it, you may want to collapse it into a one
>>> line comment.
>>>
>>
>> Based on previous review feedback I tried to keep the comment to 80
>> character limit.
> 
> Isn't the line length limit 100 now? Also, there are quite a few lines
> that are longer than 80 characters in this file, and elsewhere.
> 
> But you can ignore my comment.
> 

Yes, the actual line limit is 100, but I was asked to keep the comments 
to 80 cols [1] to keep it consistent with other comments in this file.

https://lore.kernel.org/lkml/f9a69ad8-54bb-70f1-d606-6497e5753bb0@amd.com/

thanks
