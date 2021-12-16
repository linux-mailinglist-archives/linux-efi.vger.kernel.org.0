Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660ED477905
	for <lists+linux-efi@lfdr.de>; Thu, 16 Dec 2021 17:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbhLPQ2y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Dec 2021 11:28:54 -0500
Received: from mail-bn8nam11on2071.outbound.protection.outlook.com ([40.107.236.71]:32225
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233854AbhLPQ2x (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 16 Dec 2021 11:28:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXPkmwQbV9UgszPDMsW01F8QIBt2PdLSMI0xQ3q96HMmYXuE2JxnX1aEVrOOrkOOxzMDnHuvRd5wPOyyQEYLk7cyk1ZJBHsDlgeH7eEhseB/BSLjsXg7KGPTVWwvAp/JBSM0LVY2lj2c6tWVRV8tWNfkk2XE5QOUDoUUAEJ/h+nQErfR39MebzXsfCjPkY/KqIiTF7KnH8MujbLzzevV5vXlB42FklX8MkwMb6HUt0XmqPe/EI/VaiJ2aaprJ/wopeBM8DSSsLYuEKrKDU7D3iWXSaPBXOhzX130LJ0lD9lhknKT3Hs3jfWDXhQrNFj/MKuC9GTtM/5WWQyIV+Jmrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7OhKhPHsQ5ychtqhgnYj+OJWkZfAGF52K7lrOqPGJo=;
 b=IwIGyR36c3YsdxodQ6Z3n1QhORLRG59vMchjo7Vjb9XGwK9MkfsjF5iP6RZ2t2wwsJrYqYcR0lRwxtrViDJFrwL1KqbA/zNM+/hbia4Sxq7UyZcA+Ltr47c0Vi2HF35owiPQoCP9VU7npKfIRzA3H6tUi9QeWwslmJsh7jLVLwVRpEYdcog1fz6kbx6ji9UvXJm2m8rFu9cqJBWW6mgE6tJYqkDp1pJkNFqpuvKGJtmkzMG8jFibbInxEtWqCrNMNOsu3pGMt7H8MLeZvjlX0k5IRRFouqSUS8bJ7QJ98BzsLuGdRUJd6KFDnMf2iTcK69Aip776QJf9FoS42CmSYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7OhKhPHsQ5ychtqhgnYj+OJWkZfAGF52K7lrOqPGJo=;
 b=mic58NHjPDFKV5K8dO325+f6CeDQQZMjgHNMLMm+USESo6+ufYLyupVrJWqVsrLHTcHFRG4bJfmExSjENBb3GMcjgRgYLXV3R6GWLn/dHdF3pxb3HvEsC7T1Jm4O+h4oLEDaWNMc4ZKXQIOjsQ6myHdygFP6CFyyXwByM/4+lOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 16:28:51 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c%6]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 16:28:51 +0000
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
Subject: Re: [PATCH v8 06/40] x86/sev: Check SEV-SNP features support
To:     Borislav Petkov <bp@alien8.de>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-7-brijesh.singh@amd.com> <Ybtfon70/+lG63BP@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <225fe4e5-02de-5e3e-06c8-d7af0f9dd161@amd.com>
Date:   Thu, 16 Dec 2021 10:28:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <Ybtfon70/+lG63BP@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:610:20::41) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2febced1-6ea7-4c4a-184d-08d9c0b1249e
X-MS-TrafficTypeDiagnostic: SA0PR12MB4384:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB43848A8EEB5130A85DD2639FE5779@SA0PR12MB4384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A76Tjz2mI9VXobBu8vGONoY08sZA2AFJA3ul8nhyVBniPsNtzb+N7ryR8Uw4oCesFO7YZd7e0IxbXHS8jxdkGmh1j5mtcTZYfYcftBxmbjqBVz/wyvCDVHrZxFCXUOxrTcZQYzbh9xck+HmqByo65DF3aBUtm0ZVYwckKB2ULIjHbbljtO6xboqlaR0z9c304sKp1fl5mw3bUVqwjC2BEaN1L5w2z4560jrt9LBZS9D9bEef1cSQLZgLa4qH0nTiY7t4YnAja09r09HFgPR7Y69i84klRHFxVruyGx1i9V+0zxq8Wm0m5dlqzu/R8vLaQkQTpMAOM+/e2JW6oC4pKvP0gCCS+0Gt1uvI3TEEi/OwzZ50vbc8H2bQnNIi8OCZQnNI6kUHeWUQKKKsHz9FjG6QxLwdQSsFcpEBdqVT2K5TAKlrkogU2iCS8epn6cot5eV5Ky3qOj5ICo75yDPM3jEx4SPgiTzEkSBGJ82bvcIlA5Ey5vuy+zsr+xsDeubVmONdmq0MwPD7Gy0m8ZiIGiUumKSGX65Yiy/Mre2uFLfjjpaskgGCiwTBAyD1jGcvesfnm9nrGGbP4vSwZiICfLbplzVaWNNLUXKvBo+oNtJ32yvwxOU9t22b4MzWn3vqKXV3/J597DCXvqLkZACeKuV4NzrRg7EEDwZ1lq0WZBT/Ao93bkFl02pHlA/wJmUV/ktbLLWoklIk47cMej4fQnybRw1bEIqXrlhDgKFXXME=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(7416002)(66946007)(6506007)(7406005)(5660300002)(53546011)(44832011)(66476007)(4326008)(2616005)(6512007)(38100700002)(316002)(66556008)(186003)(86362001)(8936002)(31696002)(31686004)(508600001)(6916009)(8676002)(54906003)(26005)(6666004)(36756003)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHd3M0UwMGVFUFlWY0hWL2t1Y1JmaEdrZ25YWFhZWmx4RktjMFBFVTI1dzlN?=
 =?utf-8?B?VFA3TkdZOGNVQmsyS2FHRVFLdllGZnkxK3lhYURRRTAyeER0ZEtFRUxpTldG?=
 =?utf-8?B?Z05PZlJzamNiRVJBdHU1TFdBSXhIMHZYVXBEbGFkaHVxZzNndEhHUnZqclg0?=
 =?utf-8?B?VWgwNmNYNktodG01YS9UTHdQQlBkNnNVU21WMEprbDFydmdldU1NRmNjK29X?=
 =?utf-8?B?cnhpakM3M3Q0TGhYajgxMDMySklueG03YU56bWF2WE14TXhOVlBkSnB2aHZ1?=
 =?utf-8?B?M01GUFRBY2R4cXNjWGVpYngvQ1BjM0dsZVpmUEZadUlvN3QvVWRYYW9VbEpy?=
 =?utf-8?B?YnA5c0thY3BTNFZYTEg5YU5CTXgyL3pOTzlTTWpGY1U2M00vTGxzTmtnWE10?=
 =?utf-8?B?emF3eFNxRy9ob1U4UEdDdFJCOXp4MDlrNzFCeGtmQmtCRHVaUHNMa0t0NXBQ?=
 =?utf-8?B?eG9yVnNNK0hkZnVHQTlTMFpBbWd1SG5WdWphOUNyNUZCUXBYSEhJbEVRVHo3?=
 =?utf-8?B?WFRJOFFwSDlBeTAvRTgvWnJ6bXBVNkVoSmlvbkM4QUJqTm55UjF0bE5OK1da?=
 =?utf-8?B?YkkwRmhhRXRoSFdxWnkrK21ZMGZGdnVpM0h6dGgyTW4zQit6cGRPcVJKeTNI?=
 =?utf-8?B?RCsvUjZDWmtMd01iU1RYOTgwVkRvaUlLM2lQZ3Eya3NBMEM3b01pUERlbFQr?=
 =?utf-8?B?S1Z5RGpvNmNLRVM0cEswY0dROENOajVQNGpycjRlYlZmanVLQXVZZDVvY1lq?=
 =?utf-8?B?UlNZWUg2TkNqQ3BjcE9UTTdnZ1R5N2VFb3pYNi9PWm1CWlBnWVkwT05jZzZm?=
 =?utf-8?B?N3FwaGpVZFoyRjZEK3FLeG1GWCt2bmROVU9vZmkxMjNTNHFTTWM5WTNONzFT?=
 =?utf-8?B?by9rRnBwczRraVRQbFUzaSthWmdTTDBuWDF0VWJxSFRzd2lUQ0lNZk1zek1v?=
 =?utf-8?B?K0tHTVFzZjF2SDVEZ2tpempHc2ZqOFpCTnRrQytoOFJUcWp5djhtSEZENXMz?=
 =?utf-8?B?ejJKVnMvVXJXaXRSYXhmOUFLcnBJck1zYjRIYlMvU1FsajVsdHpocXNHMGE5?=
 =?utf-8?B?RVRGckgrdDJ2SHRCRmlBeHgxSlUwYXhjN20xNmY2WFQyL2hXRDhTL1hSQzFC?=
 =?utf-8?B?KzZ1NWlOK2FVTFhZYUpHWE9BcW1Iekovb2ZDTlR2ZGhpSktKZFJ3N2pFOVkr?=
 =?utf-8?B?OUNkWUZjU2h4eGErUUFiTkxJdkxMRzBrQUlpeUJiRFpFSGkvMkNncFkzbU5H?=
 =?utf-8?B?aHR3LzV0V1Q1ZjVkTyt1d3BUNEZOaHZ6b2ZxM25mQ040NkI2dEdsMm01NTFV?=
 =?utf-8?B?bFFJR2IyaDFMQlBMeUd0ZWs2VDRheUNzcm5UR2FydjFQQlBmSHpDcTlyZlFR?=
 =?utf-8?B?QlhMWmtQNEIyYlVVY3lreWp2NDMxWFJ1SWVlbmU0NGd1THdvYmorejZKd0dq?=
 =?utf-8?B?enhvZE11RVQzci84RVhITTBaVWRtbE50WkJGc25pWUxVVDhHYkRJbmJyalFG?=
 =?utf-8?B?aFJtNVd3QnZ2bjVqU1JGbGdMRDZuVUFPZW1oUTc1TG1YSHJ0VXJKNTA2ZERx?=
 =?utf-8?B?VzgwM2hTT2RXU0xXanJrQUFZMStnYW9SZ2Y3M29pcEZ3elU5THM5ZjJTQW55?=
 =?utf-8?B?dENaMDA4MllNU1F6RjhMZ0RqbVpCYnErQWcwM2luVDNzTll5WHViNkpiYmh6?=
 =?utf-8?B?OUY5aHcxN2d5VkhWN0xSeVloc1dNYVdUeEQxQXlGV3h1YjN6ZXRwc1hnVC93?=
 =?utf-8?B?czNZZStoL3IzTXBLNWRoZ2o3bnF2Z2lUdFhOa2V1L21EYi9reFFrVjhac0tL?=
 =?utf-8?B?RVBNQlV3QURxR1Y0ckRKWStVUjBxVDZ3WFc4c2NWWFJUNm05WEVPNkFDT21L?=
 =?utf-8?B?RkhSaXBydVpBUkFFRWtFU1pFTFpTbS93NGxwK2tjOUNxb3UzUnlXY2cyTHd0?=
 =?utf-8?B?WDVicTJiYjE3aHhuVTdTK1VjWExxNm4rdlZBT3g0UmRTWTFTYmNGOTZnOGVq?=
 =?utf-8?B?dGh0dGY4dll0UkJKWG93OWppQ3YwN2Z1QUJDQ3NxR1hkZjM2TjRnTDhpVTJa?=
 =?utf-8?B?eXBDV1V3VW9TVDhGc0VwU3dhMWlrMmVrZHBERURRWE5iRnNtZmhnQUFxaXIz?=
 =?utf-8?B?a0hycUtCeEZLbnZWbjNoYldkY3lPcXhIK1pnMmRjd0FNcUxFcS9QbWoxRXdT?=
 =?utf-8?Q?PIiZPgX6+s9uzKZOLcPmvOQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2febced1-6ea7-4c4a-184d-08d9c0b1249e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 16:28:50.9978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6X0JeOm/yt296F8R6PE/GyJptm3ZKIstT6Tl0oqgRxTSLtv2ZaRjOuAraaMgwi+nxmIdazcPdJcS0pnDAdg6zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 12/16/21 9:47 AM, Borislav Petkov wrote:

>>   
>> -	if (!boot_ghcb && !early_setup_sev_es())
>> +	if (!boot_ghcb && !early_setup_ghcb())
>>   		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
> 
> Can you setup the GHCB in sev_enable() too, after the protocol version
> negotiation succeeds?

A good question; the GHCB page is needed only at the time of #VC.  If 
the second stage VC handler is not called after the sev_enable() during 
the decompression stage, setting up the GHC page in sev_enable() is a 
waste. But in practice, the second stage VC handler will be called 
during decompression. It also brings a similar question for the kernel 
proper, should we do the same over there?

Jorge did the initial ES support and may have other reasons he chose to 
set up GHCB page in the handler. I was trying to avoid the flow change. 
We can do this as a pre or post-SNP patch; let me know your thoughts?





>> +	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
>> +	 * features. If SEV-SNP is enabled, then check if the hypervisor supports
> 
> s/SEV-SNP/SNP/g
> 
> And please do that everywhere in sev-specific files.
> 
> This file is called sev.c and there's way too many acronyms flying
> around so the simpler the better.
> 

Noted.

thanks
