Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AC83F2E4E
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 16:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240887AbhHTOpE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 10:45:04 -0400
Received: from mail-bn8nam11on2059.outbound.protection.outlook.com ([40.107.236.59]:63201
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238509AbhHTOpE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 10:45:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPaTW9l1JipghBtxVV/65WyjbOAzyLDehiX+cbzBsEI/pXd1nktuluZvJ7qFy1itsnombavIZzP+367vVcVpDxejAZTYHptBN/OJRERh79p0Xaagj0hVGFFBGYu5H30mkZPXX2QqAaFbtS3AVJuZOrTnb2QAMrz3cFnb+28d2u7bx1yaaeW92As27kJkWZsD1x5Ccuo3Fs9uTxEZWEDmAxsONagaVQWRyvOQk43Ez5fVa6PhPP8qN7KG6ebGf7frWegsVcFVKqauXkSTK+d3+bW/8GihHDl/ZvFTcAUsScXtRegGRxtWHv9qPvfWd86rfSoR6sae4TMcjlcB8kYPzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKDtsECNsHosOLJLM/6e/53wNBUP1pxulo1gTveKU/Q=;
 b=IGOV867ERuZ+W5zqI0i8bPqwzzv/zOONuAnUgtHpPjT76s33fcgzsVjSrpwvGFhfKq0NLd5gAdJCJHXf9v+AuqV4O1YNzawkNVvYy17fZX9vMt85091aczLAKMUuPDjJHKBAscKNPR4Szsbp2Asj5RvxolzROxReHfsMWvUjKnDVM3CMoaBiuor6cAupBnIdMJLxuTG5keoopciReUgtWd7UZICxtTLdqXhCiOFWTNK/+R5l/UF3r1nKIDacWYowWyrxXNy5C3Z/zusxPkS1GPzccPasWHH6154nN0r2ktoRY5S5QciQsVPUWPl/DxyPlO/GZiPZtWBtMHTQMzGH/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKDtsECNsHosOLJLM/6e/53wNBUP1pxulo1gTveKU/Q=;
 b=2+3jWKnJYvNVjx2WeWzYlQVagdhXhr7Q9eCQZRIZF3f5bjTRiQfjwJqtvfzUNT/VO8tUJ1VnwEdckfdS/xFEWqpHjXA2vQUFjgtPRUflCMI+jWs616MkL7luIQqC3+eWhG6DqL9aVOvX2jfyTnWIArUa5ucsbhvDP5xGBCqQAX8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Fri, 20 Aug
 2021 14:44:23 +0000
Received: from BL1PR12MB5221.namprd12.prod.outlook.com
 ([fe80::8ce1:ecac:a5bd:e463]) by BL1PR12MB5221.namprd12.prod.outlook.com
 ([fe80::8ce1:ecac:a5bd:e463%6]) with mapi id 15.20.4436.021; Fri, 20 Aug 2021
 14:44:23 +0000
From:   Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH Part2 RFC v4 40/40] KVM: SVM: Support SEV-SNP AP Creation
 NAE event
To:     Sean Christopherson <seanjc@google.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-41-brijesh.singh@amd.com> <YPdjvca28JaWPZRb@google.com>
 <c007821a-3a79-d270-07af-eb7d4c2d0862@amd.com> <YPh7F2talucL7FQ9@google.com>
Message-ID: <e9b3882c-b8f9-88ee-0df1-409fdd9b6229@amd.com>
Date:   Fri, 20 Aug 2021 09:44:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YPh7F2talucL7FQ9@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0182.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::7) To BL1PR12MB5221.namprd12.prod.outlook.com
 (2603:10b6:208:30b::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-ryzen.texastahm.com (67.79.209.213) by SA0PR11CA0182.namprd11.prod.outlook.com (2603:10b6:806:1bc::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 14:44:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdd3b7d0-955a-4b28-41c0-08d963e9001b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB534967E5F9BF5103D8089DBAECC19@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IVirDJ4OekyEgxVOrHmIgtm35Qan8hZnb88oA2BSrYOda3EV8BkuyQiIkWXeYYYxGXnz6c79+PygM/GWunP739ci2Wk/E2HGyU7TW8e+PYl5vCSrptIekUbX66Fe4flTCfUNWIdtveAKA2g/+DcWQ0oLNwEoOGBFw1zi8W1GYfmRX5UicX06I7Q8cY58F+uZPUWsuEKJiUKLHGc45P59QWfeL60lpxA+5SS6//1+P1dR8V+mT7S7LPQBwQn+MMjrveU8Mzo52qt6fIfLzwkFnGPONY+2uEcDG8Rr5zPXHiXowg3wvWkCBG+Ga2/knNGSBQ1PdQG+3Q1N2EF02PRGDypw72ZKkFFFp5zbz5VKIvy652j5vfcnwulgTtGMmvDiBK7RYPmi+qfug5UhwTK+1KUSMK4k8ot8fIWWraD5fQ3Ahw4fL5l+aQ0zkbzUZYjPUqc5icEnWZ1F66GFv9rwhfrFpVf+eclhTkzYtY1kw1Lm1Ui4KmkoFhzfypEznFuQLRw6fedwnxVUDGGEuQtqkwGC3uSHlDmMtcjtlO7h+nCnicgEDfUhjbuseS4AufoGY2ie5Tb1OjRkTp/WgG3EEbuIWvsJo+5ieCYUOxvuFrJeYDoSnTRg//LS4JCotoiE3Jyp7f5RePBo4Y3I5aJ58yLXoWqVjv571xWbXS3Qc8HIgWaBJBWhlqdF9LP7CHcroOSUVY9Ktf/y6Indbr4DVbJJsKUIB0Jt6kuo9SUyxdw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5221.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(31696002)(2906002)(5660300002)(66946007)(66476007)(7406005)(54906003)(4326008)(66556008)(8936002)(36756003)(478600001)(7416002)(38100700002)(31686004)(956004)(53546011)(316002)(26005)(6486002)(8676002)(6916009)(6506007)(6512007)(86362001)(2616005)(83380400001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K24xbnNuVFFhZ1VOclhPQWV5RXVCeHQ0NnUyVmhZMGxZQ1RBYzZ0eWZ3Z1c4?=
 =?utf-8?B?VkdyT0tvRjFCb29BOGNubllraGVyVzdzUFhTQ3NkL01HWWJaTyttRk1TdlUy?=
 =?utf-8?B?U0JqTGpHRVRBVGNaWkpUTDZUUUx3T0MxQ212a3RQQ0ovSkFjSWNHZEF1TXo4?=
 =?utf-8?B?RytHMzZsZ2dMZVFQcHE0UXB4czJ4OFhqZitiK3kzand0QzFuajlhbnFIYXlj?=
 =?utf-8?B?OUhCcUJralgyZ3I5TmhSMW0vODN4UVBwVytjWTlzV09VdHlxUjdMZFp6WkhN?=
 =?utf-8?B?eEpxOU0rWUFWZUVpV3h0T0ZweStBL3FrUjZnQkZJOGZ1YkRpbjBOa2FFdFBH?=
 =?utf-8?B?djJMVGplK1hkbENVeHVXdzUwQVhQWi9hUlJnU0dzTzIyU3pVaTlCNXo4MHNF?=
 =?utf-8?B?em56aG9nV25sVWdWR3FSTktKVDV1N2VwdGpTZVI3N0tnSGpUZkZMZGFaL2Jy?=
 =?utf-8?B?MzUzQm02QWkvQ2UxMHB5bzdtQ0QxMEZNYUErRXRHTlVRdGNJY2MyaXJ3dWp0?=
 =?utf-8?B?c2I0cjJLenBrUVVycmNVVTJIbXl1TU41WTgwZHlVZFJJY2RJUXVkU3EveVM1?=
 =?utf-8?B?bXk4VHNtQVNKUlRqTElqOXZnVmZIMU10ZTNrVzhwV1AyZGFDMHo2cHc1Z0JL?=
 =?utf-8?B?bk0zMmx0OHpUc2ZyZ2tDVDh0d0hNbHBZejBBTjRqMlhzeGFPcTUrMkEySWRj?=
 =?utf-8?B?dkRESUZycE9WYVZWWDk4cXdNbmtKaVVkaFhUMXIxZkZRVlp0Qk5JUWpXR2JZ?=
 =?utf-8?B?VGxrT3dqaDJnS3J1dUV0bWhMdU1HRUtrVUg2ZlVDWWk2bEVNOHQ2U0hMb01i?=
 =?utf-8?B?SGNlZCtNQytLSzdKYnB0VU5DR0RnQk1xVmFZN1A1c1MvVS9BVHlFS1U0VXZH?=
 =?utf-8?B?MVl4czNDY3psSVFPMGpTMi95bXM3V0dMbGd0M2xacHFNY1FFUnRQSzNzVjJq?=
 =?utf-8?B?SitubzJsZFZnMmZnV290UzBUK1dwRGo2b0xwRWhFQlVPS0lGdkJxOWt1bFMr?=
 =?utf-8?B?dTNOM0l2NTY4OFFpSGdCbDFySDF3aThBdHllbnFLbFpiaHZOUzNyTVFIcDBH?=
 =?utf-8?B?M3VQZHQyRllZQmZzbVR1ZmVydnJGWW9KOElSWGlUZFM4NWN1L21zZHVpZks0?=
 =?utf-8?B?MjdueTRSZHd0NjRqRUdYQWJLRjQzWFErb3pzZFBIUEFQTVFEN2VpT2NJbzRa?=
 =?utf-8?B?STZCTmFMMGNvU2FhYlhneHlxWmM5bDVUQkxYZDlBNGRWSFhnZE5hdnJOK1JM?=
 =?utf-8?B?bXlvYW9PTVd0dTUybGZaQUZYbEdzQVN2d2RFaEdLOStFQ091M0pVM3lNNWpr?=
 =?utf-8?B?Y3VLSGhhL3FMRGYrWDlRbUMreGNJRDZHdjZJei9OM25zOS80R1RTbzFpNWph?=
 =?utf-8?B?MzF5ckcyT3BBREhlZzVQNllIMUZQaFM4R01lbUZFWnhDd0JQQzMxcWtzcFps?=
 =?utf-8?B?eEdNN2FrSSt2M0MvUTU2VWhtWTN1azBadjY1QTlUNmQyNFpLWXpCYXFHQW0x?=
 =?utf-8?B?a3JRbHpCT21ibzdYb0d6RUxtZEZwNnRBRDFiR0JQTlVRNnRvVVZXdVNzRTRV?=
 =?utf-8?B?QXFmV1pRNjhkRlFyeDZGc25ZQ2pINjYrM1pNZzU5ditlZ2pQOU5xWlZoS3dz?=
 =?utf-8?B?eHVXeHhtckFBZUx5OHRqOTJPVm5hcXB3aWxTTE1IS2MzcW8yR1ZxRlRySzZD?=
 =?utf-8?B?M0Q0TEdDSE9ZZUFFYlR5S2Z6ZTFxUzllSklYdGFrQUFBUUltcTN3NVhGRElq?=
 =?utf-8?Q?Bls17XfnV/aUgqWk1uugzKRln5ildZnSagFG+8e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd3b7d0-955a-4b28-41c0-08d963e9001b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5221.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 14:44:23.3665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6oaKGC2ZEvdeQUBz2EF6t4CepFAvKFmoWiJ4vnBBq7rtqe705yZlHnfjcIOd+GtXk17WoiLr/vIHD4M3Dtl0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 7/21/21 2:52 PM, Sean Christopherson wrote:
> On Wed, Jul 21, 2021, Tom Lendacky wrote:
>> On 7/20/21 7:01 PM, Sean Christopherson wrote:
>>> On Wed, Jul 07, 2021, Brijesh Singh wrote:
>>>> From: Tom Lendacky <thomas.lendacky@amd.com>
>>>
...
>>> This seems like it's missing a big pile of sanity checks.  E.g. KVM should reject
>>> SVM_VMGEXIT_AP_CREATE if the target vCPU is already "created", including the case
>>> where it was "created_on_init" but hasn't yet received INIT-SIPI.
>>
>> Why? If the guest wants to call it multiple times I guess I don't see a
>> reason that it would need to call DESTROY first and then CREATE. I don't
>> know why a guest would want to do that, but I don't think we should
>> prevent it.
> 
> Because "creating" a vCPU that already exists is non-sensical.  Ditto for

Maybe the names of CREATE and DESTROY weren't the best choice. The intent 
is to replace INIT-SIPI.

> onlining a vCPU that is already onlined.  E.g. from the guest's perspective, I
> would fully expect a SVM_VMGEXIT_AP_CREATE to fail, not effectively send the vCPU
> to an arbitrary state.

The GHCB document does not require thos. To accomplish the same thing that 
a CREATE does today, the guest does DESTROY followed by CREATE. What's the 
difference, the DESTROY will kick the vCPU out and make it non-runnable 
and the guest will immediately follow that with a CREATE and set the new 
state. All of which can be accomplished by just calling CREATE to begin 
with - the net is the same, the vCPU gets taken from one state to a new state.

> 
> Any ambiguity as to the legality of CREATE/DESTROY absolutely needs to be clarified
> in the GHCB.

I don't see any ambiguity. The document states when the VMSA becomes 
effective and there's no requirement/need to issue a DESTROY before 
another CREATE.

> 
>>>> +
>>>> +	target_svm->snp_vmsa_gpa = 0;
>>>> +	target_svm->snp_vmsa_update_on_init = false;
>>>> +
>>>> +	/* Interrupt injection mode shouldn't change for AP creation */
>>>> +	if (request < SVM_VMGEXIT_AP_DESTROY) {
>>>> +		u64 sev_features;
>>>> +
>>>> +		sev_features = vcpu->arch.regs[VCPU_REGS_RAX];
>>>> +		sev_features ^= sev->sev_features;
>>>> +		if (sev_features & SVM_SEV_FEATURES_INT_INJ_MODES) {
>>>
>>> Why is only INT_INJ_MODES checked?  The new comment in sev_es_sync_vmsa() explicitly
>>> states that sev_features are the same for all vCPUs, but that's not enforced here.
>>> At a bare minimum I would expect this to sanity check SVM_SEV_FEATURES_SNP_ACTIVE.
>>
>> That's because we can't really enforce it. The SEV_FEATURES value is part
>> of the VMSA, of which the hypervisor has no insight into (its encrypted).
>>
>> The interrupt injection mechanism was specifically requested as a sanity
>> check type of thing during the GHCB review, and as there were no
>> objections, it was added (see the end of section 4.1.9).
>>
>> I can definitely add the check for the SNP_ACTIVE bit, but it isn't required.
> 
> I'm confused.  If we've no insight into what the guest is actually using, what's
> the point of the INT_INJ_MODES check?

As I said, it was requested and there were no objections, all with the 
knowledge that the guest could "lie" about it. Maybe it is just to ensure 
the proper behavior of an "honest" guest? It makes for a small bit of 
extra work, but, yes, isn't very useful from a KVM perspective.

Thanks,
Tom

> 
