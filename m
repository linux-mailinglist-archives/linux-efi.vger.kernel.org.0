Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576394A75C3
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 17:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiBBQ1p (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 11:27:45 -0500
Received: from mail-bn8nam11on2078.outbound.protection.outlook.com ([40.107.236.78]:40321
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235947AbiBBQ1o (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Feb 2022 11:27:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jczGj2YV0+u64Wtr15GCxebDA/O8I181zKufKnVwPtY6KtGQwcIRHtX+G267Pvmb4a7QcPdPPWV0JWTBkMCTElGoyNosGyBW6T+Sbvh5kqKtg5cKBRpNa6ssyCa5j2KhkRYk5G8Oobuco/BhrraftGDLs/3pKrUGsU2EmglI+b1QTlW3jJvgNpgnH0blk/uALU6QYwgu2dR+xTzLv8Jx65+PGAw7eVEcrv5OSY8n7gm4yzWPFOYGUiZ+qsgqXx+qOafQ7Fqzfp5fhbJG0qvZu6zdgI8aptQffZ+DWRSxS751IKDTGfmu2OxvzLD7h/ldz2Or6yRA1im2FsqLl5wITg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtFPxoq3mQvMv1CMfPzwWcYiw0SyKrl+Icl8tI+O0Dc=;
 b=BfzsRU82ZDJWjXxs/WC+nbw/fKQZk0znEa7VuaZKhawcJL0+q/XEJxmK+a1xY0UyYiNisXSm9qY9Ic5LzxRZ4TBXvKlgveZ7p+jkBj2FhEKYIglg23iSPslF93gWY9Z3J8VDXri49y7zvJDHvzpnwVYGUF5oMgPz1Pf0ynD3SIRfXArGVOqHhVnjz+kXM/aahJ1+gv9JTwp88c4t3joVTrKLxkj+unwyaDsVB7ZkC64TyuOrnvHwrkCy/V6OhIMbRzQEYEDpsto7TSGK0HT2BdLP5MfWYegQYIZsPkgJ7ztEv7czKIxWI0oA18qYOus8ByM+sk6i5o8ozsKuaweaRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtFPxoq3mQvMv1CMfPzwWcYiw0SyKrl+Icl8tI+O0Dc=;
 b=ep6ljmDs9O/3uWwOGrlZuRnkRlrWJosQR1GUwD6C0a/uUq1ySd36uRJmkOQ+LPzsK4jmnszgU3lIlv2fOyN2RTfk/rUXkhWNKhuKyARmuvdIc8r4CEGZTrcw8C0ywWybrdkSPoRY4VjI5qdxizf4LaBwUlNX3CeSY3qW/hKkdmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by BL0PR12MB2356.namprd12.prod.outlook.com (2603:10b6:207:4d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Wed, 2 Feb
 2022 16:27:42 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817%4]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 16:27:42 +0000
Cc:     brijesh.singh@amd.com, the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-coco@lists.linux.dev,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
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
        brijesh.ksingh@gmail.com, Tony Luck <tony.luck@intel.com>,
        Marc Orr <marcorr@google.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v9 40/43] x86/sev: Register SEV-SNP guest request platform
 device
To:     Peter Gonda <pgonda@google.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-41-brijesh.singh@amd.com>
 <CAMkAt6rfTbQB8kZp1Nkh7GpEsWXETAPNoEOhqiMx7o68ZHgjww@mail.gmail.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <fcf3dd81-bb09-9c76-2985-c6524260442f@amd.com>
Date:   Wed, 2 Feb 2022 10:27:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CAMkAt6rfTbQB8kZp1Nkh7GpEsWXETAPNoEOhqiMx7o68ZHgjww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0055.namprd18.prod.outlook.com
 (2603:10b6:610:55::35) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87aa6edb-5f15-47d5-3451-08d9e668ef68
X-MS-TrafficTypeDiagnostic: BL0PR12MB2356:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2356CC7B3825E47B257CFF4EE5279@BL0PR12MB2356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TeDYYp7yZfhrX6LoXzQT9oNrOecQx9V+OKzMafy9opgOn3fMZtFVrcUUtjQE32qO1nkc2aMAwUY+zZdO31LMLyLZz9iPBo/At+SQPlkwlV7c1qBwgiACsIUcWClEbzlQO2YzjBz/WPuqxHRFJjl3CVs7EmRd5OLQ9589gfTmu0Rl+Ux03/fxZZycoPJ7u7Ik/OYyAfnpYh6fIgMR+/qf49XnUgOzUFnirp7Vcip9hhxIZgcGq+8argRp3JztO3FARaScn0+t8cKdPI1uwSfeldlZPjvYFIkdi9esn4yh8+dlaq0eCbN9np4QSuyhJPU+fbCWt2B8SKZGP1m2+snEnR6g8AtCO+hCw+fysheUaGH+rKcTU3CbCdOleWKpx8FMOEZSVfiJ5d9R86NIBBF97v3vBVLEwomUJlPydUTYLaMbqXitEUige3yCd1IsyhVeZfTToOXAmQb2a/U9D38VlMDyN99k3hbrtyqj0lQPlK5Ls/dC26sRoUzrYzVSxkgxyu7+JCLoKlBKFnUjcO5hVySfSvj3ZIQQSOY+s7WFjpmK5HM2ynqiko9aV9VbHABmV97Dml2lNzU7iaa/k0oIgh3nmMGMSRWiEMW5jEGAT4jB8n1/I3Rfn+o/NreDDfacCONLyaEJ/5FhdhhJQgyAR1dl3IOf5x82CMAPxIc4H/kR8i7PpycgqvzAVBl1/BjyoVpXj6ucjzKQzyAO1m2I8sURSJgmDDIky060QXKRy5w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(66476007)(31686004)(66946007)(31696002)(6916009)(316002)(54906003)(66556008)(7416002)(508600001)(2616005)(86362001)(4326008)(6486002)(4744005)(36756003)(6666004)(6512007)(53546011)(6506007)(2906002)(44832011)(26005)(5660300002)(8676002)(8936002)(186003)(7406005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1lFS05pNVh4SytYVThiVFN4TWkvQTZoaHlIbm1hMWZsZXg3aWQ0OGl0NGdD?=
 =?utf-8?B?aWxmang1OTN0OWNFTXdkQVV6RVJncktVZ2FqVitERnBOS1lRbWUyazlubGdZ?=
 =?utf-8?B?TVRaRk0yanQxRGtnL1NSQURLa1ZaM0RnVEZCd3RyVHRVS3lBc2wvUFB4eUI0?=
 =?utf-8?B?SnFta3pGaFZMTy9Rc1lFVHBBWkZsMGRZVmdrR1FjSWNhV0tya1NYcTRib1Zx?=
 =?utf-8?B?dzJkKzY2UVU4UW82YmhadEZLZFdRTCtZOEhRS2hYY1RiNktDZWlidDlBVExh?=
 =?utf-8?B?M24wbnA3UVdidHpDZWFHdGwwMFd4WWU3bkpnUEpPaFhITEs2Q2xWVGpmRlZ2?=
 =?utf-8?B?cUozK0M1dGFMTktzVzhCRUdUOUdyY0dDaFlLL3BaVWpMUkZncXJidlVkd0Fy?=
 =?utf-8?B?bnQrWE9jdDJOKzZkQ09WSko2bUMvRU5xRkc3cldJNWpTMTZGR1MrQ0Q4Nm1L?=
 =?utf-8?B?Z1JaZXJFN0t0Y012L1NpdU9Ud2FCVjhUUGF6VkR3UXBudXlxajI0UjVUS0h6?=
 =?utf-8?B?RnhHejZWWWlwNS9mU1V6N1U2NWpadWp6VXRzazlFMUp5dS8wSWtQaW16M0tT?=
 =?utf-8?B?b2pWMHdESTJoZHlQaUhBWTZ0ZlRGVnlITGR2WC82VU1sSklXSTkveUs5V3dK?=
 =?utf-8?B?WVFJVUdpc2tOLytCUkVDSkNLZTJQTzYwb1p5SXl1dFVtTlZNR3doa0o4TERC?=
 =?utf-8?B?aGQxOVgxQ2JpSkdrWVJKVFR5NVBvQkozQjRHVXhWM05DVElQdUdxQ1g0bWpi?=
 =?utf-8?B?NlBPeTRmOXA1SDlHNmE1eFZjTHk0MUZXcGVZTGRMVFg1ZlhIaG9MSFB3Q2ty?=
 =?utf-8?B?ekg1SHFKNTNCekpCb21KRXFNMkNtNEpMSnQvWExQQ3VmQnRSN0hNLzBxKzJX?=
 =?utf-8?B?eTY5d2NLb2l4U2pTaW5ROXBtWXViNHRWSTVRQXRRMktjWDFKWHR5WHp2bi9S?=
 =?utf-8?B?WXhidlpBMzdXUTRodXlNbGROdStFbjJyeW8zeFNJNlMra2laNGVtVnplSEor?=
 =?utf-8?B?akNpVFFKLyt5WFVOQngwRHFNNkpxalI1TkJrTkI4ZjRGdktnNGRTaU5kQ0FS?=
 =?utf-8?B?YXhrSXlwUTQzeWhFZjRkVytBVTRzMjhlOVVpNk16MnBub0FxNGdma1paeXh5?=
 =?utf-8?B?cVVPZStkMzFheFBpenRQOHZEVEo0TjlWOEo5SzNWU2FRbFBaSFBCbDR2SDlk?=
 =?utf-8?B?dTFQZkY4bkU5Ky9iQzdzaHZlOEZjZzRxVENXTk90cHVBd21aeWhsTjVnS2tY?=
 =?utf-8?B?ZGsrQVUzUTkydmVWdW9iYWhickdROXlOVk1iRkI3dkYxSi9vYm9GYm1EWmhK?=
 =?utf-8?B?dVN5Z2svVDNuR3dqZDNaY2wza0ZJMnZWK0ZRMENLOTl5RUJjZTBaeUN2ak5N?=
 =?utf-8?B?dXlUU05WMGh4M3RNaDNRNTIyMjE5TCtwM3NxMkxEZThOUWtUZHo2V0NIaUVX?=
 =?utf-8?B?dEw2ODVCNlpMSnBuOWNZSlMwS2FkM3FLdXUzdnJEZExpOHZDSzlIY0hQNk83?=
 =?utf-8?B?WVpyclQ4QXJYVVZSdVlsbHhFNGxyTC95TkQ0R0ovblU2b2JtWExQdGJmaGQ4?=
 =?utf-8?B?MnVzdFRoMVBBb3RkakV3dU1SK0tmbDRJQWNPa3VVVVV5azFMcjN1RnRqTngw?=
 =?utf-8?B?aU4zeCtaak8vamdRdzZUR0FSek10TVViZlI0dDBISzFSSmNpc1pETUFpVmNE?=
 =?utf-8?B?b1dFeHNqeE8ralhOYk9udGFORzZBaVY4TGhFQ1hNQVExWExmTWk4N1cvQjVC?=
 =?utf-8?B?UCtOeE53RHJ0SmpONE84QkFyL3pNRTA5YmViaTg2UkhVYnFtVy82VWlnU2d3?=
 =?utf-8?B?YXJHb1VuRnFaUXQ0UFlZZzRISHhXVERXam1PUCttbnFNRlBwRkxOclpXbzdw?=
 =?utf-8?B?bmYzRUhCR3R6ZFlqZXlmQ3ZTUUl0dUdrdEVlajVXcUJhR09TU3c3bFgrcXRW?=
 =?utf-8?B?ZUg3dDlodk9sQ0hiNHZ4S3NaZTR2VW9HTzZaY1dpdXd0a3VRWTVmbXJsSVU2?=
 =?utf-8?B?aW9JRmZZMWdES29NRnZLTHRHUnN2VkM0TFRxYVg5T1ppbmxtZjZXUzJjWGgw?=
 =?utf-8?B?R3R4MmVyM1crb3JteTEyZUora0FiRWV5eVZESWMyb2lHYzM1QktMSmlNUTdZ?=
 =?utf-8?B?VTJ3clBkS1ZVaEJlOUdnNk52ZFNDZHFzT2lwQWpOdWFobjNWSzFlVVdhTXdF?=
 =?utf-8?Q?XVSvdRmYCo7N6AhbkBhojXY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87aa6edb-5f15-47d5-3451-08d9e668ef68
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 16:27:41.9391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSfJbNo7ZogZWfJkzF10sidOsIV4Q9AabFGiSypjOJzS13KgMSFy+vou87ntMBUTGAAAzDaFJ5rfaN814tKVtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2356
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 2/1/22 2:21 PM, Peter Gonda wrote:

>> +       /* smoke-test the secrets page passed */
>> +       if (!info.secrets_phys || info.secrets_len != PAGE_SIZE)
>> +               return 0;
> 
> This seems like an error condition worth noting. If no cc_blob_address
> is passed it makes sense not to log but what if the address passed
> fails this smoke test, why not log?


If the smoke test fails, there will not be the /dev/sev-guest device, 
and userspace should log it accordingly. Having said so, I am not 
against logging if it helps.


thanks
