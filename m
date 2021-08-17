Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7803EF422
	for <lists+linux-efi@lfdr.de>; Tue, 17 Aug 2021 22:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbhHQUfV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Aug 2021 16:35:21 -0400
Received: from mail-dm6nam10on2045.outbound.protection.outlook.com ([40.107.93.45]:25664
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234343AbhHQUfV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 17 Aug 2021 16:35:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBT4Cyrv70e3Ptt/+/GsfAAwLUpwqbfFyL4o/WWPhFKTzbopWvuFWpwRL9TDRH0PtZOWic4IoAjf2qVYqM6ukLdWVV8a1U+wjgNt1yIhoAB4u/OJBBFil2HwjUuq69imh6wcL9jHdtJ2RDfnghCN2PRCvtAmNj/oLHFAPKyAXvpmtVGzUQaYSvada//60O3VtDBULgT7vhUpd2sxbioI84uUPtIQvGD9mIsZi1IAm/HvHX9dzafQpq1ZiInO8gEGrXT7UlOZqW5cZ3CzBuZgq69hFyQpJrIQPol+/ZIw/x5zFU7NsRw3/uI4bXBn9kXVJf2qy7uVx9RoTHJJW0DGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Y3UtzYIjgoLf/dwvBTJnJRQV6+N49EKk0on1nFM4Qs=;
 b=H6k90cn4+bfMXeKIzK8RCS62JI+j2I0RfFCuIGnsZXB8caAp2SO8qKkgS09TMgCTaZnwEGyCRmM6ICgxcZjp2cX/c3mt0mQ/qzFq8G2Oo7qgkbmSkvQaL/TDj9kzPE+aAy2xIENY9Qi4dnhnMRrgNO/Q3jyHFhHXqepSF5nMbji56twwvBjxjkoeVb/Ho83YeIz65CoAtFknB3oWVfOOHkokWMo4xLTxQuaGdvONzq2CxqN7YMzOYLKi0qwOtpbrsy3+bUDz58liKPc5j+HpHVMo7JCVUX8rQ/YewKFBsiyUwuA955VmDp0Il4YVGVHEC1/5MTHh/uk4xmgCA7GdVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Y3UtzYIjgoLf/dwvBTJnJRQV6+N49EKk0on1nFM4Qs=;
 b=0Fyl9REpmsYs1g/nDCobgrx/RISdejbqj+1sc7dvxTNi6nqDfY6khI5rBqC7+4vc0uQpMArPPG3yRABseuVihKJBDA7Edku1pzO6Uo5HJiz2BI2niLVsc3scl7GQz+Ho1ZVYYF72MBK4ZuMARAxtJq23OxPlTfxgG5MfaQAMfF0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB4750.namprd12.prod.outlook.com (2603:10b6:805:e3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 20:34:45 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 20:34:45 +0000
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
Message-ID: <d9aabcb8-9db2-838c-74c7-c0e759257d3f@amd.com>
Date:   Tue, 17 Aug 2021 15:34:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YRvxZtLkVNda9xwX@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::35) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SA9P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 17 Aug 2021 20:34:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43470508-e8fa-43c5-97c8-08d961be72dd
X-MS-TrafficTypeDiagnostic: SN6PR12MB4750:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4750E7E75494535EFAEB8EEBE5FE9@SN6PR12MB4750.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ew6ZO3Ifj6XYp7Mv2Sx/XvT+p9E/I8OAxeQlm/nAoBN6L/nY0bnfsaF1jzl5yT4QslIgOsMor3hrdehX4OYsiMhiEsyWkfJ8lXTPhg7bu0tiwdDKhltzYAFX2xLL5fyUDfPirAHQLjofKs55B3EclGbyoWstjAxniQyxdAFvJQyFv0cPCPbFK1jClRsXy5z5qM7QFNl/OXj3KQi12Y1IINdDuuRyizK8gzGPtdhW6sG+UdPh9p8b4W/1NwbJyCa5TCzVoXydb0XVZC71h/8IJ6UdxZIx8w0PdpCBRC/C8urbiuECZCe+6Dbv6aLgsQSdsEJ0F7DwDCfbA3LaJ8Q98dxVvppqhquYXS6Qif5o3ig24U6pvsptM1f39m2upwNapCLZGol9KnzQYCETUDYwGiF+J8RDRRo1fJdYWOynkHDJJ8dZyI5rLjrta9ajCeXLKUSR4qkqyxqieW4Q6VMubKyjmbrq2hvpu3TXF0MHdKfM1ZdntrEWR66iseMnIqgW14qxZla+03aDl+pwGAZjy11M5BA8PvvgSMJkjtE/umfxmcWZhb9dhtrC3S9NICJUfBLPrTOUkQ+Zi0Wt5mwxWSedOjuqCndpsrICjbtM4nYziqk7BJp3Kfk1O1kuIvHatAh3bDaUJ3cnKvhtRhLQgPKxlz4+9wtpyRQox1NbgZ5SX6WBEcfflo985eu80XGKRrFW/VaChGFQRVfGQzhx0dJiFmma//J5Ckau++U4Sr+pGcIUTp2H89OWVAgYEdO9BtdaINiHjtHUSXnzVJWQwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(15650500001)(478600001)(53546011)(16576012)(6666004)(66946007)(8936002)(54906003)(66476007)(31686004)(5660300002)(86362001)(4744005)(83380400001)(66556008)(2906002)(316002)(6916009)(7406005)(6486002)(8676002)(36756003)(38100700002)(31696002)(38350700002)(52116002)(4326008)(7416002)(2616005)(44832011)(956004)(186003)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHU0MVU3VUF6dVl1NnNJM2ZoVFhPUWhDay9GaHZZQzJwUitPNGNYOE9vRDAy?=
 =?utf-8?B?c25HMnB2T1Vtb3YyVitod2ZTMm44Z01SenpBZEk5NldGSnZpUEc3d3plQnlY?=
 =?utf-8?B?YTJqUXNDNHV2UW1kUEVsYWJvU0dWZmpneHlESElLalZZaEd3U2MwbzJJME95?=
 =?utf-8?B?eHM3dTJFZ096eWljOEwwZUNhWVkrQkVQaDIrVGpZcDB6MysyMkZWWWFZbzM0?=
 =?utf-8?B?K2VMQW1nZGRVZi9NSUhtWjZyWnNrMHdkYlBLTzMwOUdHT2YyUnhibDhla2dO?=
 =?utf-8?B?b1RJMk1CR2FGVzRQK2RqWUJCbWRDdTRxVGZlOFNWb0c0djVMUTdQbVAwNVlG?=
 =?utf-8?B?cmd0NEtJZXJzTkYwMUtiNU9LTUg3dkhRcHo3Z1NuVkw3MGlFTlJZMEVZRG5j?=
 =?utf-8?B?STJKUzVzMzhndnJ6T2g1WWYvcEF3K1lvVnYzazYwcHBDNW82LzBUd1FYSS9E?=
 =?utf-8?B?dFc3azNQWDg5ajVUS0c2MmhQdWhaeEFwOWdjQUY3Y1VBaS9xVEJ4YlllZkJ1?=
 =?utf-8?B?Z2dqWmpGUVJiM2p1WEZxZkJoWXY3bUh2Zk5NL29SMGppNUdvMTNESVB2RVdC?=
 =?utf-8?B?YjBKZEJVZVBvZDIwSS93WHd6aGY2VmhicFdmenBWZXd2aExZc2hoZDE1aytv?=
 =?utf-8?B?STVpWGVwOVVvallYb3pKc2RNU0s0MjI4ZVFmRE9pamNFdXNmVEIxMDFadm1U?=
 =?utf-8?B?enhPeGl6U0Ftd3d3UXNWdHBZbC9CMFF4WFppWmpwaDlQdldyUFB4aXZ3OVZ4?=
 =?utf-8?B?NjZ6cUpNVDRQcGJQYVpUZnJ4KzE2b3ZQL1NSNzVvQUZKYmRqMFZ3Q2orSWJ1?=
 =?utf-8?B?Mm5teXlrcFVtN0pYR0JjUWs5ZlNjM1pCaEloYzVFT2JERnlneElmVWhTa3Nh?=
 =?utf-8?B?SFBUV2RvZGIxOURiOG9kdWFkN01QeXpIbmVGWmpnbTFUcmJFSFc2eXpTV1hY?=
 =?utf-8?B?NUg4Q3FtSzdBenJKdGZIQ3Z6SFQwd3g1L3puRmN2QjRsMHc5cUlqa3dlbG9n?=
 =?utf-8?B?L1lvSkd2QnAwMitJRFNzN0xRd3pTQ2tMVmRQWjVZOWVZRHVCRFA2S1lkU1N1?=
 =?utf-8?B?TXByNUpBdklxUWUveTl4TnJXRHhQVE9ZNHJJcnVDQStWdi9mZ3FMK05GRklI?=
 =?utf-8?B?K3haUGZsQVhBQ1Z2RXhVQjRRVUZWTCtkUlprMTgzSllUcGVvbUd4UHZLcVBj?=
 =?utf-8?B?Tjdwb2ozSjNQc0NOdGZnUVJORjlDa0FjQmF4emE3elhzSkRjbFNFOExnMTFk?=
 =?utf-8?B?S2l3QldUQXkyNlQ5K0pqZmo2ck9mRzhIdks2ZThhRlRwbFFYWUZmMUNZcjAw?=
 =?utf-8?B?SGhCb2hCc3dsbGVpcHRmRmEwUFk0YUN5NENxNk1xRFU5djdCSWdoZEhFemR0?=
 =?utf-8?B?czN1Y3hDTEVXUHp6OXg4aXpjMlVtL0h1bnRidEZtRmxjekNnVWNwMURPZE5E?=
 =?utf-8?B?QU5tUlprZ1FGaDVwdy8rRVprOTBrcUg5di81blJqWlY5cnZoT3AraTBVMWs0?=
 =?utf-8?B?S25reVpKOGU3S21WN3dDQ3YvQkFPNk9reXVBRE1VRVlYV0FBQkVSZFNTUW9J?=
 =?utf-8?B?VHhNUURhbjRsODcvWU1GMEZOKzE3djB3WGQ3K2hoNTdrTTV6ci9Xd3Y0MFE5?=
 =?utf-8?B?cFJ5dDRXR2RhNEF5ZStJVTJHYmFXTll6ZnJJQm1YWU0rZDl3a3dEQjVGR25J?=
 =?utf-8?B?THdETU54clpza2JOOEVyeDRYMzlCTW55bUtYdVg0ZWRGc242Ukg1SjRSL3Vh?=
 =?utf-8?Q?PTGoLqoVcN78sk+PqyjLAT/ym6ifyVXhCgIRKXj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43470508-e8fa-43c5-97c8-08d961be72dd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 20:34:45.1719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvvnaoKiZhB2RV/laUHODz8fJvKtgV1yFUC3dvzwjq6gRGROzgt9MRU86xqu87uwhaxUjfi+2ZcwSIzNLUTkkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4750
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Boris,


On 8/17/21 12:27 PM, Borislav Petkov wrote:

> 
>> +		/* Lets verify that reserved bit is not set in the header*/
>> +		if (WARN(hdr->reserved, "Reserved bit is set in the PSC header\n"))
> 
> psc_entry has a ->reserved field too and since we're iterating over the
> entries...
> 


I am not seeing any strong reason to sanity check the reserved bit in 
the psc_entry. The fields in the psc_entry are input from guest to the 
hypervisor. The hypervisor cannot trick a guest by changing anything in 
the psc_entry because guest does not read the hypervisor filled value. I 
am okay with the psc_hdr because we need to read the current and end 
entry after the PSC completes to determine whether it was successful and 
sanity checking PSC header makes much more sense. Let me know if you are 
okay with it ?

thanks
