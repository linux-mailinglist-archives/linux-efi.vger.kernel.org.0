Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCF33CEE7B
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jul 2021 23:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358029AbhGSU6W (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Jul 2021 16:58:22 -0400
Received: from mail-dm6nam08on2079.outbound.protection.outlook.com ([40.107.102.79]:29513
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1385753AbhGSTIv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 19 Jul 2021 15:08:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8VKRy9lrrTJMAN6uP3MwkEsOHNyCtj7x304WnIdNvXMxDd0SG/NGFXsXjzCjDf6lcU6txNX2SZqBQCRRgpj45zZBSwYZTb4pQ2PlAy21I+qGoNhnIaPILq37h5N8dVevqTttS8wGPfvzfKM7wxMOcw0V31JrboOnRwWmjzeWFeGQa0+gw2hFYPUnAcjNB5fKRjs+Gvi7Fhjk/wUJq1DVNZjAx2NFnqBuIFPgx9w2HEihpsWfS+eZy+bD6TUJJbi3qupqLpUstE13ONol4QJo2z9Gh86J/0d4VmdYgAO+5Bu81CCCjneLu6mzexw6HWNuK6C4PlLb29x4lAMgWpCNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRCj4MLU/VvsXQvvBUccErv/rJ/yWmYT+vzfys1y+5I=;
 b=cOhAhw06Ac5TN9mgon/eNwD06V5mfTlBRScAdCO+oVlV5pskxqEwTq3jN91Im3fM3k6G4m072dZdmCMYnXsVByNhTlfAvAyZEhL5OCmSjhdn8GexMLODcTrmjTGPGtqG323mGn3V723OB3+0Yt486OJx7x09z9xZTQOkXTeOso/Mp5lu2rw9kMec067bbZZ12uQ4qY/aLr55wr0VBMzdqv2DOgjRGA/LQzSPjz+amMh9IFLtCxwzPLNZqh9V5PaRmw3r5y4rnkDWtelUCjMGD8D5W98Hit94WGsPsS3fpyT1OLO4rJWHey9QADzCxQ34TJm7TqNw8VZLXLNf6sTpxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRCj4MLU/VvsXQvvBUccErv/rJ/yWmYT+vzfys1y+5I=;
 b=UuguPCQaPfqPGCZh2ToQUhPBN5UAy6nA4O6ipJZ5bvYaU2ViMPIupHOQUI8IBRSA5vOtLBBhUUe+m6WhKLVG7naMkWR1/idKvxkPXEXVVUr2HEGPpoo6GVB10S8ZLMalk+my1odoUT0r6Lt8T1joe3KcZ1Ie/fJ0Yhw809DQEks=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 19:49:29 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 19:49:29 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 26/40] KVM: SVM: Add
 KVM_SEV_SNP_LAUNCH_FINISH command
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-27-brijesh.singh@amd.com> <YPHpk3RFSmE13ZXz@google.com>
 <9ee5a991-3e43-3489-5ee1-ff8c66cfabc1@amd.com> <YPWuVY+rKU2/DVUS@google.com>
 <379fd4da-3ca9-3205-535b-8d1891b3a75a@amd.com> <YPXPKLW8DvqK7yak@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <f056d0ea-42ff-bc35-8154-a528105309a4@amd.com>
Date:   Mon, 19 Jul 2021 14:49:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YPXPKLW8DvqK7yak@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0065.namprd05.prod.outlook.com
 (2603:10b6:803:41::42) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN4PR0501CA0065.namprd05.prod.outlook.com (2603:10b6:803:41::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.15 via Frontend Transport; Mon, 19 Jul 2021 19:49:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39973985-0ebe-4b5c-2527-08d94aee5216
X-MS-TrafficTypeDiagnostic: SA0PR12MB4384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4384557283C30FB393D2B848E5E19@SA0PR12MB4384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GLyCpXhn1hDvUfGADAEqNWM51tdv1KTy/zo6iJW90OFdNby6vw4Zx8QsZwzEMx1aiQgxmg+ZB+N4NakFY9cjxf/peDaJQyQbtXIcfpvNhXjP+7l82fsEAfRDxOvLucsTR2+kxah2dXN5AKdB97Vtx8Mcal3xo6UdrVu52xvchKNTswoMXA/Z/rsSHm4wyBsXLNDwqy5druyPj9D8xWbEAM1WF9KWxBk0cCyyN8QNnKEViexPJaRkeYzi4pZ9A3h7Ne3rR1UbvEzTqb3WfgBEm1KkMomeFo/xdKxmVbKGcuPks30y78PPM/dgjvzay1llF+vDUkOAk+2llUximE58KCOjYexGqbidYdIZsQ4AmYR186HVdx7pzm6Ps54MODHGCLrJSvxW2fW5sZrM/Rf16iCaKHXQbhzxhUpGv2y6vF0pq2eMGY8QrQtuYoKPuP51OfPkDzLbmF2vAc1mATq3kC53GIZLj+LM/qRTfJA4Xh3Rituu8AnnHPUc2/0voWE3XDRtIgjL9+pAd0t9uxaksaxn6KnP7vL1l9etDLLwmJHJzwZwrrB+ClejGvvPW1zesC4N5r71QkZ3TByczVmMRvdylClYuPvlFbE5OmlM7wBoaxm9+RhracKyQaQFbwhGPPEaT+xzvPJDwrwOOzdfNkLyFu4EfHQ4PfNJ4LFmCZU2nehMOFr4WnDiD2JeCghjkajIaGvJseBfVrPvblu8upsBqdRv3gd501E33gj6PUeT9sFd4elNU109uawbpf1X9MWbtDori6fW2XzJ0VcgKj7Y5On1yxErmYPUYu6ESHJqsEnnE9MxVR/p+dBZc87MM9xmF2kD8o3BqSXy5Bp6CenJitAarNLsDA/w/D1GykY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(66476007)(966005)(66556008)(31686004)(8936002)(7416002)(6486002)(66946007)(36756003)(478600001)(52116002)(38350700002)(38100700002)(4326008)(316002)(16576012)(4744005)(53546011)(6916009)(7406005)(2906002)(31696002)(5660300002)(186003)(26005)(83380400001)(54906003)(8676002)(86362001)(956004)(2616005)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1NKRHdjM09CenpQTTNDdHM5SkQzcWVKVy8wQk1kcTdmb1VCR1BvOUUvOThz?=
 =?utf-8?B?eEZFUmJEVG9CQ2xnNWxnc3d1d2g3MWNCRHBaVFYzS28wbE5XMmFrSktDTG5y?=
 =?utf-8?B?dEJQUmZjamZ4c3NTYlNCOG9VSC84dlQ1cy92dkVQcytLSDBnNEtmeFRjYlZv?=
 =?utf-8?B?YUFpVDhKZWdnVHZteUkxdkRTQ0tHbG1JL1k0aUFGL0hINDU1VWVSdFZXbU9W?=
 =?utf-8?B?RmJOYXcxSlJ3R0FIN0Y4cFVCbG9CWlBrZ24waVFVbHZNNmlvd2JoZWRIc3Ay?=
 =?utf-8?B?cGl4TW50YWxBQmZRV0NmQU80T2RzWnZocWtIbHJydkNRSTdTWnMvZ0dVSEd1?=
 =?utf-8?B?R29FWkV1MzlVVDh0VmdjLzJrM0V0c2pNQUZMZWVyeGZVbHIySnVhc2ZIYlNq?=
 =?utf-8?B?bmt4c1JCTS82N0c3Y1RTeE9JdUd6eE1rN0pPeUJpQjBsQnFCK0E4QlZDUENo?=
 =?utf-8?B?UmVMMjRGZnJ5eG1BbVNyRzNtYVpPckVMVnFTSm04REJXcHptNkJ4VW80d2lN?=
 =?utf-8?B?M05TTVE1alVFUytCb2QvcEhXMElCNHM2K0JyVGxWLzRSbWtuMHZpNzB5eFJ5?=
 =?utf-8?B?M1BxenpIMnI0TE9RSUx3d2p1S1FvZWk4a2NLWmdpSzRrQlpTL2pKeHl2NVBa?=
 =?utf-8?B?MysrZjdsSHcwZW9xc2tTbWQrdjNPMUdNbUxOUDNqMHJmenZ6WVU1TmtSTnA4?=
 =?utf-8?B?d1JheEEyWUUwYlVDdmZkeUQxVVFuekFhck4yRFpTUVdzRTFaK0lrRmxGYjZK?=
 =?utf-8?B?cDI5bENlY0FHaEdwRWIxdGhLbHpvTTIrdXVERkNmU3lOWmJQM1JRTkNOdmJ0?=
 =?utf-8?B?WE0xaUZZc1kzTjgyWnQrMEhnT0pyQ085Q09GSWhxeWdRTWoyeUg1S1I5WFpE?=
 =?utf-8?B?ZXc2aXoyTEUyTnZ3ODRzTmMra3o0a0VIWlNRcWFCQUR0dkdXR2M5TFRIblFP?=
 =?utf-8?B?ZytCcHVsNm9uZEdaaDJnVjYxR2twS0FET2dDRlZLZE1WNWNjVTJZY1ppYm5X?=
 =?utf-8?B?c0U2ZFlWTlYzUHducG1lYTVBa3VKR3F1aURNaUpkelBtVk10WkdJdG9wR0Vu?=
 =?utf-8?B?eE9xcE5PdjV4SlhDZVVtT1JmNnIyOTE3MnBqQW5LRFpqcy9uRFlPWXhqVnNp?=
 =?utf-8?B?YXczS2JpQk9qZ2NFYTB3NG1CeTdKNW5CeVF3dW1rQlRRTlJ0c2wwU3RYUXFa?=
 =?utf-8?B?UDhwdldyZ3p5WGdtVFJvQWo4czNVV29iclV5OGNrVllvemRqVUxMWE1sVlZo?=
 =?utf-8?B?a0ZDNHNBTjdvS2ZSeVZzRXczOWdqUjEvUWJVQUd4cTlSYlhKWkxDNEpMNGJV?=
 =?utf-8?B?ckZZUzVxQXdhTEtGeFU2ZEVPSVg1OEkzS0FkS3hzRTlTckNDM2d6ZE9KMWND?=
 =?utf-8?B?RWRWRnRMNmpHQ2daeVU1VDBwdzJoMXJ0emY4WkMvYStocm93UmtBWTcyNlVa?=
 =?utf-8?B?NW5wN2NvYzRrMlVrN1dsUDZsM0hCajIzdlVpZWtncHFEMDJnOGl1d21oOEwz?=
 =?utf-8?B?OCtJV0I3L2M2bHMwY0FzbVJxdUpNc2lZeElyNVRxbmNPVjQ5RWVrN2d2TEY4?=
 =?utf-8?B?QVBqTmFsN2ErR3pwUlI1VGpFd29wOEhiaXArVTQrQkJLYndGVTdET3d1OHZQ?=
 =?utf-8?B?NUI5MjVpaTNWWTZOemlaRit0RWV4eHdBZDFFcG84YjJFdTZQZHlneXV5aGo4?=
 =?utf-8?B?cVB1NWE2ZVI1UzF6dHZ5VlpaQ0xrRDZFckJtTlQwdllwSFBoQ2hrQXlDODE3?=
 =?utf-8?Q?tgUVcikoTDnjhywfQ5La0bJDPxWPuvrCZPRwhpx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39973985-0ebe-4b5c-2527-08d94aee5216
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 19:49:29.1829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhsr6kFfNfEvEOiwu9tTO1j+KeJQJg9XcTdrPX0pU0Fd3/IUNBHaLjN8GFAt9/OE3haohGFNSxoQlHTKYmxnXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/19/21 2:14 PM, Sean Christopherson wrote:

> 
> Where?  I feel like I'm missing something.  The only change to sev_free_vcpu() I
> see is that addition of the rmpupdate(), I don't see any reclaim path.

Clearing of the immutable bit (aka reclaim) is done by the firmware 
after the command was successful. See the section 8.14.2.1 of the 
SEV-SNP spec[1].

   The firmware encrypts the page with the VEK in place. The firmware
   sets the RMP.VMSA of the page to 1. The firmware sets the VMPL
   permissions for the page and transitions the page to Guest-Valid.

The Guest-Valid state means the immutable bit is cleared.  In this case,
the hypervisor just need to make the page shared and that's what the 
sev_free_vcpu() does to ensure that page is transitioned from the 
Guest-Valid to Hypervisor.

[1] https://www.amd.com/system/files/TechDocs/56860.pdf

thanks
