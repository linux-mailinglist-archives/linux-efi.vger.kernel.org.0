Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A213CEE72
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jul 2021 23:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239984AbhGSU50 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Jul 2021 16:57:26 -0400
Received: from mail-co1nam11on2084.outbound.protection.outlook.com ([40.107.220.84]:14177
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1383462AbhGSRyU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 19 Jul 2021 13:54:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqhYHDlUjaVGlvPBhPR+tudFqykCOn2Ko+9QTuM1yuICkQjXzXPRfnymK77BrBZjxEON/zuY/kgfx7VL+T5uMcVN66z0ZG4gbPZTa+Hrkve1s1Q8sH1EsYkYmRr7p1qFtvThZp4C3T0CVgWADTXd8eB2XIW5cEI0hAFtiU5AHdQTXfjlkcwkFBpax520BCrYN/JwvCcTvAEr5qfuutxP73lWBOgQV0QvwnhKr7Y/uOa393b544XHpSGSwibYgynNEipDoF5jXQKf96NFrBJrUk/4IGILNzN53QN1Hi5UROW3HUtj6kwPiRwE+h9RlZu8XjYHjxRZQpbIseLnWEbyYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C61ws8TaxAn8h/ViHcHwWJqLRnJBbQ8E7KXFXOAYkeM=;
 b=Nzdxp9O5+0TV5I22O48iKBPJbwerV/d4VtSmFUmfneREUxOJ4C3fPvX4iSMxtlwB8cqhKB5tLIdtVuA3fS2khniAkXFJHFeKne/K/7nPqgd0CmingpoouoXEtf8/CuM8BelVp65HUAvfjnuzfo4ws8QoZFqsP7bNmuIJ6QLj+1nNoDUFG8LD/xcb0V0w9rt3Xpm2H6wM5HoltfDcUvDb0CIXn61cTffDwsvtD04VtuKdAiNQntn178KkE56FhO4z3QPtPfg3RDsuMfY6C58ZD7rhanUAKu4GAEX59CbB13v5HK6Nc6LjpMmri09Jp7bHnS6KNmD60kMFZepSOdZ1gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C61ws8TaxAn8h/ViHcHwWJqLRnJBbQ8E7KXFXOAYkeM=;
 b=3NgyDUt/MtEaHulORr4kKJJ8Cg+4YPZq+R7eD6C+HGpCMRXBI/hJHaCLDKdgwumHt0u4gp89WxZ4uGBbJlgvpEZoQzpWkx7LMM9JhgI6kX0F5oVy34Jy/1v5WPLssYAVoDU637xkdpUSP0c5ifZwHo901pac+68zLW6syzOXYcg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2544.namprd12.prod.outlook.com (2603:10b6:802:2b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 18:34:56 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 18:34:56 +0000
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
Subject: Re: [PATCH Part2 RFC v4 25/40] KVM: SVM: Reclaim the guest pages when
 SEV-SNP VM terminates
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-26-brijesh.singh@amd.com> <YPHnb5pW9IoTcwWU@google.com>
 <2711d9f9-21a0-7baa-d0ff-2c0f69ca6949@amd.com> <YPIoaoDCjNVzn2ZM@google.com>
 <e1cc1e21-e7b7-5930-1c01-8f4bb6e43b3a@amd.com> <YPWz6YwjDZcla5/+@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <912c929c-06ba-a391-36bb-050384907d81@amd.com>
Date:   Mon, 19 Jul 2021 13:34:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YPWz6YwjDZcla5/+@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0008.namprd11.prod.outlook.com
 (2603:10b6:806:d3::13) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SA0PR11CA0008.namprd11.prod.outlook.com (2603:10b6:806:d3::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23 via Frontend Transport; Mon, 19 Jul 2021 18:34:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c70638a4-eaad-4b28-afcc-08d94ae3e829
X-MS-TrafficTypeDiagnostic: SN1PR12MB2544:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB254428EE4DE0A12D3DF7ECD1E5E19@SN1PR12MB2544.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0CZlxxmomZSq2BSIna/Ii78pc3pj1c6e1clx9aehpeZ8Tx5oIYCcLF1zs/HNTv1LLHGgTcx7RGz5ZHrjwUG2vZKyjX0A94VGckE7zklTsfwjtHJbBhMWz8ByZOJxg0HZk7ZfjgC2P7taK8GE/v5lqHVT8jLj+aKcj7FxniIE0FS2icIWgj/3BIu9GwlG/4dqRi4iOu0mKaDalOo/msn0Kgl1sQ1PkviGfNYrPCwkaTejyClk8g/gdVkxxpPAP4UFrlY8nTgDhrY0TKOccS8wGyiusFmN+SVmCR8zfbviNRTPSk5ay+guV20Z0Vyb02dP6aPlBBdQycpGJfWK7VHb9TXzL6CPf1tlzpJzuo1dIA4TATgJAtY+YluOP0G95rK0kslCjIlgJfc6r7+dU/+98zWoWtlZA+6QGZFmb4mfb58tDaqm8mlbjbUEA5zHHbtOiM76+tynG5hbsrxLVpz42BhWS1M9z/xJJjhdJtqqL0MLjIcqy2V+EZ3SQ2DrFj0w5w0bC9mz5W0GuNnJWq54W4IFBMaxFm/Ri05GUzJtcGM8kXQVXSSU1xaOVUAw9kZofwabAvWKS1CDVjDjHeLWi0YNGWDk3wZbzc0sQHTMvUMOy2g7zTJJPC1xErUaVTJeVXk3QTYDn3TSDLd3J0IjJXfNfTGFjD+Lk83L7cHieijSJa9oYAzrrdNTCG7MQbMWwDorHuT2UBc+mphVdO3Nhleas7j9UqU7I8QHeQsALoUC6pDRaJB3bbLAjDQVilwkH9JYR4jGa+5L+J6t2idVdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(6916009)(4326008)(38100700002)(31696002)(38350700002)(83380400001)(16576012)(186003)(31686004)(54906003)(5660300002)(316002)(2906002)(26005)(86362001)(8676002)(44832011)(8936002)(66946007)(36756003)(66556008)(66476007)(956004)(53546011)(4744005)(2616005)(6486002)(478600001)(7406005)(52116002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHZXbzVUdzRVTGpNNFNNN3Rvd2lUWFUycnNzVzRrT3YyZE5GcUhIenlBZWhG?=
 =?utf-8?B?bGl6QVYzM1ExQk9nQnA4eDdvV3dqZWxjeC94VXFDSDREaW51ZWpRQ1lNMGFi?=
 =?utf-8?B?N1IzZ3l4b1FLZ01FWDdySnNPYzMwbUFkcVBCcFN2dG4vSmRtMHdwWWo2aGFL?=
 =?utf-8?B?d3g0cHhsNXJzRVZhTTZGanh1Y2M2RWptV0o4K0xrd2JaZDZlRFg2RWZGSmUr?=
 =?utf-8?B?encrVFNtcVF3eTA0blJyZGFSMjFwUlY1UWE0cVU3bkFDazNpdGs4UDdSQytP?=
 =?utf-8?B?SndYMmJPVC96QnFudGVDdHFTRFprbnphanQ0TmZnQ1I5OWozSlhrNEY4NWo1?=
 =?utf-8?B?NjZTUzNxRG0yNG5ZQjJpOFBvU3lxYmpuYjBlS2UxL04wN3VuOFpwWEFyS2Rx?=
 =?utf-8?B?eHUyeGg0RGZ6T3RkdHJZTzc5K25hRVU3anB0SHFGWXRQVkdWSzA3WWoyR1BL?=
 =?utf-8?B?djl0Z21BYk1aWFVVMmJtSGQ4SC9DWUh3NTZKdENpcnUrc2dDS0I1a2tTVkNn?=
 =?utf-8?B?UDdMYVh5cnlhUEs3K2ZKWHQzQ080RTVka2lGeDV1ZEc3NXp0TUtNNUdsSWkw?=
 =?utf-8?B?RDREb3FOaDFKbUxWajZFWlJSVDZON3RBQ2Nra1Rua3hMY3NmK292aFFXek1u?=
 =?utf-8?B?YStpTXZOMDZndTZIMlhUeS9yRGY4Tmo5NUIwQmtvbGcrMmhSMDgzNVR6Y282?=
 =?utf-8?B?MFhwWi9ITW53MWNkWktxNEhnOXFKZzZsYWJXTWpYRHlma3huUzBMRW9tNG5w?=
 =?utf-8?B?dmhYQWpqMkJlOThmclFqY1J5dVJJMEhxQXZEVlVwTGRYWmNXLzU5Q0dmcUt6?=
 =?utf-8?B?azlOVEtOOVd0bjl0Z1JDeU12czBpSENSWnhIV1NqSnorcndNbllYUlFsQzlu?=
 =?utf-8?B?cGcrRmRwSWs2cHZnbS9XUWNRKytnanVhUENna3ZVWDVwK2sydFdld0JHRlM3?=
 =?utf-8?B?czk0R1FXRXB0cHBBTWk3REY0bDJjMm16TnZxQWF0bFowSlBsV096YllOMUVo?=
 =?utf-8?B?SjFpNTNRZDZmL2JISjVlWDhwTkFjN3hMWVVBY00wd1k0cUhHR2xvMEhZY2RC?=
 =?utf-8?B?M0tCM2pQQm50dm5IUkxnUm1vMWpRNDNobDVObGo4dmZDMHR3eUZMTk5QZmhG?=
 =?utf-8?B?c1JEM2NlaVZwN1c0cURtZ3FmUlI2MjljOVFwWG10a2xjQXc2OUw4V0Fsd1BX?=
 =?utf-8?B?dmNWN0dzOTltNE1aZktIYnFncE85T2ViVGtNSEJOSTNzMkhCcDRCZHlHK3p0?=
 =?utf-8?B?S0xEaXI4TVNpS1ZOdHdiZ2pHT0Z5cHphYXFuUFhWMDB6TEtnUjBYSzErTFdE?=
 =?utf-8?B?dVlxdzVoeTVDYWdnMUVuY0JvZ245ckF2ci9UY0JrYlZ2Vit6QWZMb21tOTI3?=
 =?utf-8?B?Y3FzTHkzVXQ1YlVGNGNrSk8wOWV6d0VYUWowRWV4cDFVcG40c1JiQ3R0NE1l?=
 =?utf-8?B?NkRJL0Y1bUpIdmtDU2UwZDAzYk5EK0RZNUI0ZzhidEd0N1lteVFuUTd3ZEZa?=
 =?utf-8?B?aS83SmFIb1JoakxhNjhzb1pMUGZIYXJUL3RrMFZjN3gySFE4NDVLSE9kTUFn?=
 =?utf-8?B?L0xuVm1JSHM3Q3ZmckxTWUcySVZvL05tQm04SDErNFp6Q0hKbnM3dkpJUjlr?=
 =?utf-8?B?bFVSMnMvL0czTHB1b3p6bVVRRjRna2hRZnhaQkZLQ09tZGtNbkVLbnhHcFVD?=
 =?utf-8?B?aGhJUFpqOVNQRmNtd1R5MmxjcktjUmRrUCtISjZta0l1dXVKRUFWWVJGV0VU?=
 =?utf-8?Q?0aKF7iYB+kLJKKh0LgWf68CMbgIWm7A0lRJMWsn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70638a4-eaad-4b28-afcc-08d94ae3e829
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 18:34:56.5042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYUaLwc4jlbfqUCMh6aVVOr5lKBFsuW1oXAX1T9mJQmDWGgmbsapIpBvq06MAp+92Vc9Pt4998r7bBnftU0vpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2544
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/19/21 12:18 PM, Sean Christopherson wrote:
>>
>> Okay, I will add helper to make things easier. One case where we will
>> need to directly call the rmpupdate() is during the LAUNCH_UPDATE
>> command. In that case the page is private and its immutable bit is also
>> set. This is because the firmware makes change to the page, and we are
>> required to set the immutable bit before the call.
> 
> Or do "int rmp_make_firmware(u64 pfn, bool immutable)"?
> 

That's not what we need.

We need 'rmp_make_private() + immutable' all in one RMPUPDATE.  Here is 
the snippet from SNP_LAUNCH_UPDATE.


+	/* Transition the page state to pre-guest */
+	memset(&e, 0, sizeof(e));
+	e.assigned = 1;
+	e.gpa = gpa;
+	e.asid = sev_get_asid(kvm);
+	e.immutable = true;
+	e.pagesize = X86_TO_RMP_PG_LEVEL(level);
+	ret = rmpupdate(inpages[i], &e);

thanks
