Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65343A9DB5
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jun 2021 16:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhFPOjt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Jun 2021 10:39:49 -0400
Received: from mail-co1nam11on2079.outbound.protection.outlook.com ([40.107.220.79]:62551
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233563AbhFPOjt (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 16 Jun 2021 10:39:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAvkly4N0aWsKZtks7uUEYGvL96aEFLWEunOilLjb+go18FCD+zbUAm8p/tzGwU4LkNS8ZNa1OU95S9EUWpMb8OP/YwZpePJL0DOvA87hpeSaIqj3QEnut4oEzP5nE06FzzCoMMSO8PNmc8li+Aua/4ZoXEz2p54knbPa3JJS2NFTgo/ljSyMwULkqV6yusSzWe1+XjuxuydoMqTCeaydvUVXoqrZ1KwS76aqS36/XN+fjw/f+Lug/t4hJOjLPHI54q/edOD9cBfMcuxTh3HF8BXM9+DwyouNavmZYZ9qkHSNQXoJ+8vDgpFiZQZgzFOM9Z9rbRoxlxLSQvEihQ/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBoLkF67ESvNjPF8brhVKT5lCNzmUCVWdQZ56D5zHt8=;
 b=lQuBnDrgs1z9RIc/r1fjeQRb9d1jAvnycbp5f4X2i+dKqc7lDn30k9JGCR7vXwEj1BBH8y/vjhDBEgx7rs9lm9dEpn9zsvhw1OYhfudFW6YOkKZWT5jKJfAWVpBZwYGbFNF+4zmh0z+ifDP5gJyqelFdxSJrfWMV/QQqdBMAeyVjbGcUsA7jYG+7GUITuBFdNcq1TxEcT7/ZyEkfcffMHmy19EWsvKAztgnkOQVIwtprz1vD9AB4oh8xfXfbEOQ0Sa92nrnDwjXOkdDxPzxRMAMHN9wuVRMXRO5bCW7vxzT1isjI0iECGW/ehRFUi9qUOszP57bHwjD77siqOTydzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBoLkF67ESvNjPF8brhVKT5lCNzmUCVWdQZ56D5zHt8=;
 b=dgwFuawgmty/N2J2/vQn/wPUmphisYVKtCV9ylglI6ILXQq884jpoe43TO8zTshz/SYu4Wx2fEbJQOK06C4A6wulpJfCRwVvIhTloxuyc2pvBgXJ9KbQgGEAxNyCtwgsSVZGt5lFc5emF9698jz1kgStQyyRJn7a5RjbCS9MNiI=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2714.namprd12.prod.outlook.com (2603:10b6:5:42::18) by
 DM5PR1201MB0268.namprd12.prod.outlook.com (2603:10b6:4:54::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16; Wed, 16 Jun 2021 14:37:40 +0000
Received: from DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b]) by DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b%5]) with mapi id 15.20.4219.022; Wed, 16 Jun 2021
 14:37:40 +0000
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
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 11/22] x86/sev: Add helper for validating
 pages in early enc attribute changes
To:     Borislav Petkov <bp@alien8.de>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-12-brijesh.singh@amd.com> <YMI02+k2zk9eazjQ@zn.tnic>
 <d0759889-94df-73b0-4285-fa064eb187cd@amd.com> <YMen5wVqR31D/Q4z@zn.tnic>
 <70db789d-b1aa-c355-2d16-51ace4666b3f@amd.com> <YMnNYNBvEEAr5kqd@zn.tnic>
 <f7e70782-701c-13dd-43d2-67c92f8cf36f@amd.com> <YMnoeRcuMfAqX5Vf@zn.tnic>
 <9f012bcb-4756-600d-6fe8-b1db9b972f17@amd.com> <YMn2aiMSEVUuWW8B@zn.tnic>
 <91db9dfc-068a-3709-925b-9e249fbe8f6f@amd.com>
 <c3a4419e-4b05-cf4d-2fe7-0d046cb36484@amd.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <06ffeaae-259c-67ea-617c-f1d8c1e1c015@amd.com>
Date:   Wed, 16 Jun 2021 09:37:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <c3a4419e-4b05-cf4d-2fe7-0d046cb36484@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SA9PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:806:24::35) To DM6PR12MB2714.namprd12.prod.outlook.com
 (2603:10b6:5:42::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.11.236] (165.204.77.11) by SA9PR13CA0120.namprd13.prod.outlook.com (2603:10b6:806:24::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Wed, 16 Jun 2021 14:37:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cadbac02-1a42-451b-6bc6-08d930d44a7d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0268FEA78745EB9738AA3B86E50F9@DM5PR1201MB0268.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TciyEop83rHJrHeCZL4KxcZJpuIOVPLnSoBIvJc4iheVl4ty8X0BcDT/8dd2bMPc4YeLo50urRgTcoxZeuMBkO+S+7NrUeZm/r+4y0M4Gto7YQAWpE6wBag2Pl168t9wZrUU7Q+O6T0YHabF2kL2Mk2c0wBL0hQ6uJVx+kR+QPIpXfYhklC7bebHJpwAKhk0+VmeLyM2gAcGXu1SptM8KjnM0xXDFY78//dTGkeT9zZ3cD5MRD1Ou58bJYh2nXdEy6audsEfr4aexgwXRE8I+CCs9dEb+sWODByZRG61mdeUAADAYIkUu8Sl08es2knt2VNSDZihtxv+638D2S1biRN4TY8TiMw00sLhMomJGMDIhPb2CgljJi2cLQosUwIuLjBvgevMMj17iAY8jUA7GxaGE1N8wVXxbiliRH7TicOI2LopfzJKp8mnRGjDZUsnI7ko52IfkFNZhPiMCn/Mx4auPbv06OBrWVOFCRd336QqbyFx5YVD3Q8ZDtAXJZvbrplRi09lZSkHvSPU1gpcEy0c2YVfgXS50TpQcJAlnQuWeVQ43SQdUtMi4qVBbihiD5gctWibaFrCzRlmhdYX/t8yF2NjDBxsgKrjXiZ5iuo2an+qhpz0TGym2UxyHmIq7lV/HiskPxbn5ayjjJiMAQQTkB89yVR9XOdWLtnuvfRkovpAWszQDXeUIFleJJxWjSrmRl6ChCo0e21+YF49ad0Q3Pig2Ycc6gB0eFdDUh8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(498600001)(53546011)(83380400001)(956004)(6486002)(2906002)(2616005)(66476007)(16526019)(38100700002)(66556008)(38350700002)(66946007)(31686004)(186003)(8936002)(86362001)(8676002)(6916009)(16576012)(52116002)(36756003)(5660300002)(54906003)(4326008)(44832011)(31696002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1NTSE1XYVFKYks4Y0ZNelJzL1J4Y3grMzlUa1NTZENoemE0bDg2RUFzL0ZS?=
 =?utf-8?B?cGFVYUxQZzlLWm5zSEJXbnc1Q2pSYWxXdEZxZ3UvOFlKUE9mNElMK2lzRWNB?=
 =?utf-8?B?ZEdXUDBBL2YxNk8wdEo4UnRRQ3lCRlp0WExtcnNnMGRSL0EycVFMcTVxVDc2?=
 =?utf-8?B?YW1sa0F5dDYyYWU5Ujd3cGR1VG9KVWFyYWx1ZVV5YWF1S1FIbitQMWhoU2Ur?=
 =?utf-8?B?dGlGYUlWNzJZTnF5eFFoMnkwQjNoNnRLZ2FQUjNOR0w2ZVRFQXVzLzgxNmMw?=
 =?utf-8?B?Yk5uek5iZHhRaXZlSmwwMzc3UTdsOTFTZC9FSUtVcGVXalV1eUdyQktRMXMx?=
 =?utf-8?B?OE1MbmFOb3hBeXFJSkhFak1oOUpCeGJ6QWVUZk1EY3VON3RwWUlqczFzN3VW?=
 =?utf-8?B?blVIazJySEo5VWJSWWlaSXkrSGl3bEdnOEdsN2NiT2hkZHpDVmM3aWkrNldX?=
 =?utf-8?B?QjFxaWM1TFJnYWVqdVBBSkI1OGJGTkphcEhyYzR2ZG83NE0yQ0liTkFNV2hs?=
 =?utf-8?B?UXFZOXpRSWRnMXRFamtiK1lTNmVrL1orL1lIOGFvbmd3ajduRTJMVHo4L3dL?=
 =?utf-8?B?amxXSlM4Mmh3aDNlMDZhZmVVVzY4SHJFc084U3dGTCt3dmZqT1dXdC9CRFZD?=
 =?utf-8?B?MURodnIrSHVXTC9oUjdwOUYxbWpnNldVcW5ZSHZ6alN1dEVxZEVIRkI5Wnlo?=
 =?utf-8?B?SWJ3bTBxaXQ5NEhDaW9sSzVMSlVNNGxvemYxa01MMTl5ZTNFcjVuZ1FQVStI?=
 =?utf-8?B?T0FDNGIwZjRXUFpSNkwzcGRoSFF5eUxXQi8yRk9QRHMwNmlLZFM2Y1RGOVBB?=
 =?utf-8?B?NGlkTHRSSzZGcC9oaGF4bjdMUGgvNG1Zc2FHam9wbWxseCsyNEtyTERuaGFP?=
 =?utf-8?B?UEpqYStiMmZ6cE9qd1hEVHNlYWZDbncza0NieCtGb25FWnd4blFYRUJmbmt0?=
 =?utf-8?B?cEF3R01wVytYeklQTERtZEF5UlgzeVFDN05xZjVEc3lxdXRXU0FSU0VKdUIr?=
 =?utf-8?B?QmF6WHZGUEgxNzRFVTdMeWxYUFRKYllvVXd4ZElPQyszNEx6TUYvWDZoV3BT?=
 =?utf-8?B?S2dUOEpmRzZpOHQzVEVlZmFsQWpKa2lxdXk3K0gzNTNBQVF2cmdmWHBuQW1P?=
 =?utf-8?B?MHBhUGRsWUtpUnA4SGtjejVxRDEyU24vdXAwOFdYUWtMUlFRbytNcFZJQ1ZQ?=
 =?utf-8?B?bEJvaEhNK1I4M1V1Sm44ZjVLaWZwc2V6YjFZZzNQbCt4dlhFelhHSmtzTFlC?=
 =?utf-8?B?ZUxaQ0ROMmlOUGhkMG9JZ2NSU1FuQmlRSkxGR2NzcmxaTGhZYkhyZ0hiUjZT?=
 =?utf-8?B?YU9HNzExT3p2YVFTV3g1dWcvYmVEWmltQkQ4SEFvdy9jaDNQc2oxVnVUcW1J?=
 =?utf-8?B?M1FjZHA3VFNzazhkZXBva2tFVldITmVFa3E2dytIUmI4UHVOS2QrMmpnbjVM?=
 =?utf-8?B?VU55ZU00eEdlUm12b1JEL2grcURnUXJJWC8wMVB5VTcxR3hGa2EvbHV6ZC9F?=
 =?utf-8?B?MFpwbm5JM0tDOXh3cEJueGhXaExHV1FSUDl1ckt4aDBNSW9RVnNKU3k0YmVy?=
 =?utf-8?B?aXB0Nm5nTXJ6UDdmSmwxYjQ0NXNUZWRNREhxb0RUMHcxb2xxMFN4VzZhdzd5?=
 =?utf-8?B?emJQSFNlYUNQcE1iRFczQ1Jpam1sM1B2RjFub1NzRW1yVk1iSERON1IyODZm?=
 =?utf-8?B?T3I1UmhTZGR4TDZ0UjVFVUw4NmhzZ2RXaE84QkdxVEpLNHRWOWc1bzVPV1RH?=
 =?utf-8?Q?AVFN3BFeKScwnLH+LKbstdI9cN40iSLTBbpDqoQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cadbac02-1a42-451b-6bc6-08d930d44a7d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 14:37:39.8594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIi0xuc/tBk3a2naSd9od9rOiymn/2OP38OTeO7WYDAYcKW/VO3MATzK0U9Ly6nvRWdlsqxg+lntpD3PoA7eWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0268
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 6/16/2021 9:36 AM, Brijesh Singh wrote:
> 
> 
> On 6/16/2021 8:10 AM, Brijesh Singh wrote:
>>
>> On 6/16/21 8:02 AM, Borislav Petkov wrote:
>>> On Wed, Jun 16, 2021 at 07:49:25AM -0500, Brijesh Singh wrote:
>>>> If you still think ...
>>> I think you should answer my question first:
>>>
>>>> Imagine you're a guest owner and you haven't written the SNP code and
>>>> you don't know how it works.
>>>>
>>>> You start a guest in the public cloud and it fails because the
>>>> hypervisor violates the GHCB protocol and all that guest prints before
>>>> it dies is
>>>>
>>>> "general request termination"
>>>>
>>>> How are you - the guest owner - going to find out what exactly happened?
>>>>
>>>> Call support?
>>> And let me paraphrase it again: if the error condition with which the
>>> guest terminates is not uniquely identifiable but simply a "general
>>> request", how are such conditions going to be debugged?
>>> I thought I said it somewhere in our previous conversation, I would look
>> at the KVM trace log, each vmgexit entry and exit are logged. The log
>> contains full GHCB MSR value, and in it you can see both the request and
>> response code and decode the failure reason.
>>
> 
> I now realized that in this case we may not have the trace's. It's
> a production environment and my development machine :(.

I am mean to say *not* my development machine

