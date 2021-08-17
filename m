Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A153EF188
	for <lists+linux-efi@lfdr.de>; Tue, 17 Aug 2021 20:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhHQSMT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Aug 2021 14:12:19 -0400
Received: from mail-bn8nam12on2059.outbound.protection.outlook.com ([40.107.237.59]:23264
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233084AbhHQSMN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 17 Aug 2021 14:12:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koIdjRLIQI5W0y4LsBXedMqQiL0gWDny8kbXlaHBcds6qSv2P7uSwhylMG60nrPM8vhDGiSihDkwJdle2mZBN18FJsOhihkldp4JBGZ2/5o8pHuFVd9kQX5EFoyuHQPDsbVlDB5ZB+ZVYM2m69a1HYRiAyPh3c9j8angmarVO7KSBFiJbjLHfVYHJ5E1obnSZ9x8mYlKs9TqUKRn7u5/MuzVKts0eyo8iKMG7GbVcZJw/PuDjZZlpB6lCxrWlA3rSUjy8EZJ9TbglKyeihdP4cCEMoSEKhR8j1DDrAfObESzDOaIxXEaX5xISo/kg5A9TyA/pdPJFWTHyncdo6oWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pJspvcBeIATx3Kl/6MmCUp3yHCHVixx8d5wkNMoEyo=;
 b=a+Mm19ew2Rtxrjd53yVgntL+G2eN7utmPnTW7RH8JD/gvTC8MR+UiCWipuIippgkADpfU8gwG9M29pThWgEkHUi0mjLfbNdh/Zhb8MQ+yeFAWOGYoghmOpbh1tuczE2uMY0TTsotTMOQ+Wq92e+b49Vq+tMlrp1WzfIiEcsl/SfUxFaw7Ig9hCSfQRNrutgT6vSyyhgHAKmdmC6uCKw1OntnK5r3DCHMAws8XZB4xXwFyNoU9TO/CjV2DvRCjoKdeeRDSLlzyx+v9NVvmWUvUMnbulQgSKUWPMC18sctKuXOCchN0KnR1lN4geEFoDtkoMuBd/PhGOqY+ghMnjSjNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pJspvcBeIATx3Kl/6MmCUp3yHCHVixx8d5wkNMoEyo=;
 b=mOOHlx8gX9ocYG5ZXGe3ZhbOyzE/yoIk8WRKt3KNVXi0buzWNe/iN1lqmBFsru9bOmfiahlXu2VpRSyB7eDDIgvPB7wKnTDoFGiXYY7hLgNuECQFZn3ACVgmDzjEw657rhqzf73n67sGwKQYnkBPxsAp4cdCu4cRvMoxJsmIcQY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4511.namprd12.prod.outlook.com (2603:10b6:806:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 17 Aug
 2021 18:11:38 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 18:11:38 +0000
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
Subject: Re: [PATCH Part1 RFC v4 16/36] KVM: SVM: define new SEV_FEATURES
 field in the VMCB Save State Area
To:     Borislav Petkov <bp@alien8.de>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-17-brijesh.singh@amd.com> <YRv3x/JeNjcJ4E8a@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <9ffbdf3d-05c8-38a8-96f0-ae782280ca94@amd.com>
Date:   Tue, 17 Aug 2021 13:11:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YRv3x/JeNjcJ4E8a@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0030.namprd21.prod.outlook.com
 (2603:10b6:805:106::40) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN6PR2101CA0030.namprd21.prod.outlook.com (2603:10b6:805:106::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.3 via Frontend Transport; Tue, 17 Aug 2021 18:11:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54644afe-9218-47ca-4b94-08d961aa74a9
X-MS-TrafficTypeDiagnostic: SA0PR12MB4511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45112882171752610600FBAFE5FE9@SA0PR12MB4511.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GuRR4XPfMrYhY+AL8jbhrCcCNWJmeWj/4FnaPhSxdB884EYU0to/OYK0sXWhvDMzMuciGcaojJhJUnPsBIBZzfs+3JZIXuG0ZLoMv8DZekYw1LUZhn3hmAe5GmzyCC9rwaqEPh9GCEWVnlvs8WR16GdurdPUHhnuwsifBu+ZIAtoQz9nTIMKXjyCyRMc2MiyqvzjvdFWTOdU3xt4bclFSw0s8zU+DSG7AhtrOz7KHCAiWoej4fmFYvUrVHIjCiAdxyG0BKm/33UVR+w58WfrIA8cGJTMUxwbi9K0prN12qKeRjyIxyI/Yr1SkY7E+POwGNEFnVKBRiplmmuO/28vp0ebHunctcSlOm+m7XTCkmZ50V7yb+MpfGYP9THpdsfokJGsjpPLTVOcLDoBGVsHhMWHgBOY7URz3K84HES+uwzyoOyoWp68TSjDxoMjQKZQlZnAjN574FRtFxxIz2D2ASpJVZI4XT0ufGQZ9WNRdQ7kSQ8OSaOA4ZpUoJMw8Sdd6TvUEMM6PElxIHXWpbuMNq4O4tUQLkqAXQYyt9i08WaMEp0G/ansBWRfbdQ7FUyoOCmeyj6naja94UiKLAnzeNGDB5DMaLaRDxLdPJhpXVT3TafaLTjNEyS94N/G+whlaRIQhKffFBVIUDk/jHvbYQYJNmMMsh8RNLvroDtyXS1PQ4q1Cjfj2ATlnmWJV4V0qnvWNbl2ygtQOvuenl4cGCim8jofLEL3VAWn3Bpc7C0dB+AI/1GXXR+tlOTLHMXeiAo91CrljZBSBhk/FnWsZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(83380400001)(4326008)(6916009)(53546011)(316002)(186003)(956004)(38100700002)(38350700002)(5660300002)(6486002)(8676002)(52116002)(16576012)(31686004)(66946007)(31696002)(36756003)(8936002)(54906003)(44832011)(26005)(66476007)(66556008)(2616005)(86362001)(7406005)(7416002)(2906002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWtiMHpWRTk4NDRIbFB0dEpXYVRtd0U5ZTdPZTVSb1pHbUxuVkhtNThTWXdi?=
 =?utf-8?B?QUVpTDJKdFN3RDhHd1MxVXlIVVZabEpDOWJ2bER2ZEZ5R25yWU11OVozL2lX?=
 =?utf-8?B?REdJTkY0ekpvTGNnRTZrSkNkZVZSak16dFQwbHlXbVhhbkd0OTdSL2k0ZUtW?=
 =?utf-8?B?K0JlTEhRRFdCLy9wTkZFMmxRMGpZeVhIRFpqMitBaXBsa3NWMGlrdDl2bHps?=
 =?utf-8?B?QkhmSGdWa1h5R0lNN1hEdUcyQkQ3eFJqU2JVdVhmSVdKc2pRdFlMWEJxMGsw?=
 =?utf-8?B?bU1QT1lmdVpwNHl2cUYzcTYvNFdjSktsNlBlMTJlMGxsTS9qa2xiNUFIRXd5?=
 =?utf-8?B?OHdURDNXYmEwMkxrQ0c4MjhvMUV0SnVhKzltbW5DR3NhS0RrWDVVNjBoUHNT?=
 =?utf-8?B?Z0Z1ZzIyN3dPeURITWRPdzB3Y0ZlcmdKNXV6VXRWZTVWYnJ3M0JQZ0g1OFBU?=
 =?utf-8?B?UmxRSjQyZnN5OUV5b1lFaDdwQU5YV01QbzZHN2NpUlJxM3JVS1Z4Q2ZlREVi?=
 =?utf-8?B?eit0Y2h1OS9hWjJaUFVOTmpmdWU0ZkFEOUJUUDJjbVVLaHMxdEtWZTNZUUcx?=
 =?utf-8?B?dGpUSUVURnNoUGc0Slc2YWk2NlhnenpYWGovdzN4TEw1cmVyZDIvYVJFRUtI?=
 =?utf-8?B?QWZuZVhFRDBwV2M1c2tydVFONENiTEIvRExRdlJwVWNhVXhlcm1DNk13WTV3?=
 =?utf-8?B?VjdlV1FqZ3NXaW5KdE1wNTRrUXhkYWNMVnkxanRiS0ZlSHIrNXZOQ1QycnZw?=
 =?utf-8?B?Q2crSXpTbnNjVTFaR0VKSElzdElZeE1kZEw2QnVud2ptTHp0VytRbWJ6SDdz?=
 =?utf-8?B?VldJR1BEWklqQythc3pnOVFhejEzZjJBaGE0TVBpeDVWM0FyTzFaajc0VFkr?=
 =?utf-8?B?SkxmRFh5RE16OWVtMklBQVZCUmNXU0VnWmdkd3E0alJPN2JtdTJwZ0w4WU1l?=
 =?utf-8?B?MW1uVUkrZkRCd1ViVzllWUMzMXoxVTJyNUhOa3huWVNqV25NUFJ2RzRwQk1Q?=
 =?utf-8?B?cmdQMGpvaDdzS2p6Um1OZVh1SmxFeVp4S25NLzAweTIrQU9tN05PWFRTMmd5?=
 =?utf-8?B?YnRRa00vZ3pjc0tBVXBtc2g5ZlNDOVV4SlNoVm5qT3IrY1N0ZTZJMzVNWjJk?=
 =?utf-8?B?eTNCT005NGViY0VrNkpUSGUycDV1a3cxanROTFkzQjNOSEtOOG1qR213S2RC?=
 =?utf-8?B?V2ptRFlESkJnN2tSM1JjalRodnJHUTBRK3draDNUWFE5Q0dwMkpPYzV6aitE?=
 =?utf-8?B?NWpBV2UxblZwS3lROWowS1RJVlFuTXNMREdOdkdBQ2ZBNWRlZE40Yno1d2ds?=
 =?utf-8?B?Q0JEdVppVXlBL05wMlBmWDg0Z3hsZlhSeHFwNFlWWDdaMUxDc1E2QlIyRzdH?=
 =?utf-8?B?aDMrRWJZRkxuYWlBVFd3V0hBbG9FN2xrSTArT09sM043dkIyY2U0STVQSEZR?=
 =?utf-8?B?SzNzbjRtMEJTamZxU2QwMURVNU94WTc3czJxaTBheGdzcDFnZEMyNlFxWFJJ?=
 =?utf-8?B?L3I3eENnNlIrekYzdXRmek5xOC94TUsxNXpOWWY5WjU0THVJY091NWY1Q1Jm?=
 =?utf-8?B?VTRnMEY0WXpjVHBweXhtSnZRMUxhVDJ4SXE2ajgwSUlHakVSdzdTY3Q0VlQz?=
 =?utf-8?B?aVZPREY3RFBmYjFsWWlrY2oycEl5RDRyV21lTlExQ1RkUHdPUlR5eEtwa0hq?=
 =?utf-8?B?aVo3aE9GeS9xdXRIc2V2UzVQc2JYTkhkanVLTVc0NEQwOXJaSTNCOFpCaERh?=
 =?utf-8?Q?srGAYz97ona1VmOgMCafqYbL1EUT1ZfoWBERxyY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54644afe-9218-47ca-4b94-08d961aa74a9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 18:11:38.1850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUQTdeRPqAddbKbh+IChdYjxhEhNHhKF3ShRo8QWf2l0pSz/UOK0SKPBUJL8qTD6PiNDP2ZO9avWSw+wXUqdNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4511
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 8/17/21 12:54 PM, Borislav Petkov wrote:
> On Wed, Jul 07, 2021 at 01:14:46PM -0500, Brijesh Singh wrote:
>> The hypervisor uses the SEV_FEATURES field (offset 3B0h) in the Save State
>> Area to control the SEV-SNP guest features such as SNPActive, vTOM,
>> ReflectVC etc. An SEV-SNP guest can read the SEV_FEATURES fields through
>> the SEV_STATUS MSR.
>>
>> While at it, update the dump_vmcb() to log the VMPL level.
>>
>> See APM2 Table 15-34 and B-4 for more details.
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>   arch/x86/include/asm/svm.h | 15 +++++++++++++--
>>   arch/x86/kvm/svm/svm.c     |  4 ++--
>>   2 files changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
>> index 772e60efe243..ff614cdcf628 100644
>> --- a/arch/x86/include/asm/svm.h
>> +++ b/arch/x86/include/asm/svm.h
>> @@ -212,6 +212,15 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
>>   #define SVM_NESTED_CTL_SEV_ENABLE	BIT(1)
>>   #define SVM_NESTED_CTL_SEV_ES_ENABLE	BIT(2)
>>   
>> +#define SVM_SEV_FEATURES_SNP_ACTIVE		BIT(0)
>> +#define SVM_SEV_FEATURES_VTOM			BIT(1)
>> +#define SVM_SEV_FEATURES_REFLECT_VC		BIT(2)
>> +#define SVM_SEV_FEATURES_RESTRICTED_INJECTION	BIT(3)
>> +#define SVM_SEV_FEATURES_ALTERNATE_INJECTION	BIT(4)
>> +#define SVM_SEV_FEATURES_DEBUG_SWAP		BIT(5)
>> +#define SVM_SEV_FEATURES_PREVENT_HOST_IBS	BIT(6)
>> +#define SVM_SEV_FEATURES_BTB_ISOLATION		BIT(7)
> 
> Only some of those get used and only later. Please introduce only those
> with the patch that adds usage.
> 

Okay.

> Also,
> 
> s/SVM_SEV_FEATURES_/SVM_SEV_FEAT_/g
> 

I can do that.

> at least.
> 
> And by the way, why is this patch and the next 3 part of the guest set?
> They look like they belong into the hypervisor set.
> 

This is needed by the AP creation, in SNP the AP creation need to 
populate the VMSA page and thus need to use some of macros and fields  etc.
