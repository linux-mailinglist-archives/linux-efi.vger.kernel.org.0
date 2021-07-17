Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712CB3CC038
	for <lists+linux-efi@lfdr.de>; Sat, 17 Jul 2021 02:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhGQAiw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 20:38:52 -0400
Received: from mail-bn8nam11on2077.outbound.protection.outlook.com ([40.107.236.77]:61504
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229578AbhGQAiv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 16 Jul 2021 20:38:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChmQExhh9NJ2qJ/lVcWRgsoeF5t4UHitrg336FDLaFijmO/GdPeaoPJ/f2gjrTOt9xiWvksEInj1ll0+TjFfVCCLTyjnj8qWJkAmVkEecFco4lXlMjUH84ZqqBhv2m57Bg9YnvvwUPSxgtza9uMdpYJqDHAIP8uduJto0AzodBW2ZvfH2Jeb+GFKhId2RH6JHWpHpOoLtJwX2RRhEhTzMhse5e12y1lTJJie1O5sxw4/UHNP1cD1i/MfeuMJ7QMl67bJpJbh01g6rIbxyG9Iw7RNNLG7uG3jAXcQFf4OHmJckUD0wi1oBiBaPIXA0aXPFcWKQcR2X4C1gSohs46tpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jn/a/dO6WMLp4S/LetM4T7mAiXnQezAYAbsZC7Aa/QQ=;
 b=nl/FLFx3IIe428UXeSuq1+0xVvbkr5nOQsJ7r8SE9rtR7B0QFuhFVxb1fWwLZ5gTdhXresOPBesaKEWxY4MkWwHx6zhuZgTbVqjH1P3ghes2Q3y3d9amW8+phwquZEufQ4LwoRDKQqNQLfDw7GO34uB2e/mqwBOHfsXeH4NuGXznGwHSHWuiSnx8A1aBNCztxsvXOK/HJeo1RouHGP7RFhDGEJmHOHjWDlwQMmD957o2QLWbaVFgc00vMtXNSzk9HAxzdZYPPQH3I0qGu0H0G99eLb0U9863DEu0DR0MIWKP0ITb38CTglYzmhc3Z88pgL9EMhpKOyttsJzl6EjA9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jn/a/dO6WMLp4S/LetM4T7mAiXnQezAYAbsZC7Aa/QQ=;
 b=zZyZH6CA7tmdS/PkuJMc74uhphWNwqT0kTdPB7hr9pnUMbHuQb69Nps7aTDvl98JIQG12Fsh6ML7JPe19XFkAoyzWl9/n6TaDvTFxOoKGc+GAmlE4O4//QyG0lM4CZrZwP+vK0G0oGriAFQFmP5nlPCFF3Z3jtF29fiB9K/FgBE=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB4672.namprd12.prod.outlook.com (2603:10b6:805:12::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Sat, 17 Jul
 2021 00:35:53 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.024; Sat, 17 Jul 2021
 00:35:53 +0000
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
Subject: Re: [PATCH Part2 RFC v4 31/40] KVM: X86: update page-fault trace to
 log the 64-bit error code
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-32-brijesh.singh@amd.com> <YPHrVkFJwRsMm9V2@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <c7c668e1-d013-6df8-78d3-08cae8bcf252@amd.com>
Date:   Fri, 16 Jul 2021 19:35:46 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <YPHrVkFJwRsMm9V2@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SN6PR2101CA0027.namprd21.prod.outlook.com
 (2603:10b6:805:106::37) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SN6PR2101CA0027.namprd21.prod.outlook.com (2603:10b6:805:106::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.3 via Frontend Transport; Sat, 17 Jul 2021 00:35:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5c83b40-d855-482c-8c16-08d948bad5a2
X-MS-TrafficTypeDiagnostic: SN6PR12MB4672:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB467287A1707BF7E3B9EDEF6AE5109@SN6PR12MB4672.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bVKzVlDqGugTvDaPxjceGdI8Ue3V9WKIWfncYBWwK7Th2Pm5i6Mvtocs1qaZJ7GziQ0gDZpyt+RS+0I3n3/Y9eas59STiQ2Dm9R/Q8ps+jTnYvPZ3AB9b9c+7KJ7JXY4+0ulNtOOZiEQEKKqOIt6n8B/xVlmfr0/PRFP+X2iTPq+aZGNBp2XzDdJGcCfXjDIVMzZr2iG2fQsajZrQBrmfnfGKlmCjJgcIswvJ1qacwOZCsnuksz5pP9CVqUJfusTu1H9gZzLwl6qqDrCFw6fUBeB2rHILnP+Ka/Ih0nH08on3VBRBwYv3P6xPWp/76woaetMn/yn+exDSUXUD/wAROdBpU8+95/fqJ3LRTuTPDKBD2XlFPdtvHvEDpmRCsxTL/KT+mhA3h0GIIREHYdf5w0kQc2anBL7OnearbcHkwGsjuSFohL409CEyJ9MtFgR9lgI/YcXimlQSCEYXELAiSah9Rxmi0xE6rw4dOPs+xAXDRcN6hQSCCo5djGstMEh/48rf9EmdiK/A/QF4eVZFPf/lYXWqlNmYI+0VM3NlSS5AtE7OkwiLN6GOdIzjoHj9/h1EN+dfs3E6BB/zyBtOcnsvd00/LRWydHhUezJ+bTtUSazb5eldrIe6/iuieVRhByfLTSv+1E/+qg7KtBUO9MH818DA2POOYb0/pfNIpdZ3tnT+L9a6faCnCSHNs1c4AkxsDlcOCUxqK/CHHMaeYo92oXv5HNiEx90WJNVhsdfz4KpINYGkTD3QvkTcjT40jUW+diackIjxjY3iaTrhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(7406005)(7416002)(8676002)(4326008)(2616005)(31686004)(6916009)(956004)(186003)(66476007)(66946007)(44832011)(66556008)(26005)(31696002)(478600001)(5660300002)(8936002)(38100700002)(38350700002)(6486002)(316002)(2906002)(36756003)(52116002)(54906003)(4744005)(86362001)(6506007)(6512007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STZ0cnpyOG12S3BMNWtITjFEdlNCVWpDL0tMQlYwekZQb1JvWHRoRlFpNlFM?=
 =?utf-8?B?ZmhVVG9pUzYxRjJCZjZlMnRXN1prQ1dIYjBtcHppQ2JrclFHK3ZzcjdSRVZO?=
 =?utf-8?B?MnMzbXRiU1o0ZEZ3WWNFM1ZsaHVvZDh0TDk2eE8vczZHclZQSGl1Uzc0WXMr?=
 =?utf-8?B?aTdyKyt1R01RQmFsdnZXclU3TEhPWVRUNlF0Nks4STFSQWJtbzhRTHQxWG5j?=
 =?utf-8?B?Q0E3MUtQc0hKMUZTS0NIQTFxRG94RityVjVIMlFjNlRJVnp4cGtBWm5meEFY?=
 =?utf-8?B?elJaamdBbzNEYmRBa2RzY2VRSUpPalpLVDM2eTMrQmhNS0k5QXltZVE3L2I0?=
 =?utf-8?B?Nm1KTGl0M2IrVzRleUZPMHN3NW1xWG5rQjVTUEh3UHNpSWFXS2Z3VFJ1Wm5i?=
 =?utf-8?B?VE5pcEN0RVZHcThrZUZyclFxbm5DTjhHaXQ4YVliY2ZlOVcyeFo3RWpieFJo?=
 =?utf-8?B?cVBzbUxjVGdlVVBKSUwvcks0SUZvWEFqbEJwaE4rNzNOdUYrck4yWDRPZ1BX?=
 =?utf-8?B?WkY1SWN4WUZEQVBaWFhzMFBKUkZBMDRRZnRnaDBWcFJWd1l3NjFoMy92WlJY?=
 =?utf-8?B?U3lKdGo5RllTN0VJakRNdS9qRy9iM0FJRFZMSHlwMlBDbEtpNjRHd1pIcFlS?=
 =?utf-8?B?aVdIRUEwbnZBL0lKYkZVaFpUVUJENzBxQmR0djZ3eXdHQW9WZlBDc0VqWnVY?=
 =?utf-8?B?S0FEa2JkZWxXTlJJREFVWktkOGdhSTNjK0hCTU9nK1NQcDJLajZMZDMyRTBZ?=
 =?utf-8?B?V2FMS0MxdXN5ZCszQ0V6NjZUbHFqTDU0UFNPSGJDc2wwdi9rd3M3WXc0aTVh?=
 =?utf-8?B?dmdBWHZtZzZoNll0UFdKS3gwejV0VjFxVzMwNEpyRzZZZVA0S2Y4bStKdWI1?=
 =?utf-8?B?TnA4YkpVY3hCVkxkczZHY0g2MGJLSmM2b3RpSGRlS0pjQ0dZTmU3U1dLNWk5?=
 =?utf-8?B?RXBuZkRuQm5YRW5MVXo1SEpSZk9ZNG8rRWJQK2NWRFNvSDNtK0FwZG1jY3l3?=
 =?utf-8?B?N3gzWm5KTEJVSWE0N1I1elY5SFBCa1hYZmkyMmNpeWxCcXBUWE8zdlAxSXNp?=
 =?utf-8?B?ZHpwRTMzZGpieTZpKzR3SjZLc1c3YVV1UEliWEZ1ODFjTm1VL292UzBLQk55?=
 =?utf-8?B?OFZydWVZVC9tTWl3bXN4ZXNVKzFnQmM3bVZrRzcrQnJMckk5L1VCYys0MDhJ?=
 =?utf-8?B?TTN4amZkZVJ1WFp0bmVOODkzQ0VIdk94dFMyMGVmSUs4WGdPaENrU0Jqd0JE?=
 =?utf-8?B?bll4dzJPam9QRVIyRG1DdU5vTTRPRDIzMGZ2WVlCT3J4eHhsR0ttS1AxVytO?=
 =?utf-8?B?a1R4aFVIMnNESStKTkV1S0MzeTZWTFVtY2VCZGplWWJLdmRITi9DbHQ2QVdl?=
 =?utf-8?B?NFhKK0p5YlJqd3hmYk91c0JldkhBbURsbjY3K2pjV1BTR29qRzJSdmE5Vnpx?=
 =?utf-8?B?WTZQdGFHUnF4T2E5SVhIa0phdCtJL1FCTEN6YzZjVkM2MzJMRUNPbHBKaHZ2?=
 =?utf-8?B?Wm5ucnFkaHBEMmlpZ3VQcUdmVGtOaDRrOWVUMjB4YzRMQmtYRUo2SDJWUy8r?=
 =?utf-8?B?blBXR0NRdVlhZXhaQnVIcmVQaXVnY3FwNGsyOE1iOGxSYUxYTzhMbU95aXFh?=
 =?utf-8?B?ODQzVUxwcVRHdCt3dU5EeDN0RkowbzJjT29tK21iQjJHdmY5NnFjUVZ3Kzh4?=
 =?utf-8?B?aWlGeklFR1I4bjdhNWlTYjM5SDhrejlWbWlJbUpQQVEyOEJaMWp5b2VQd0N0?=
 =?utf-8?Q?uedlNDCqy93pz6ImUjl7LFosgRNZghQpNlaPy4y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c83b40-d855-482c-8c16-08d948bad5a2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2021 00:35:53.7550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtI67VbnpAFgtUpQv61hZtZBETJ7cl53l8VoH6UI+1Bhq31trGpV8gCcVxdnmqGE226kAIQOxLGDySFo+Cc1Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4672
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 7/16/21 3:25 PM, Sean Christopherson wrote:
> On Wed, Jul 07, 2021, Brijesh Singh wrote:
>> The page-fault error code is a 64-bit value, but the trace prints only
> It's worth clarifying that #NPT has a 64-bit error code, and so KVM also passes
> around a 64-bit PFEC.  E.g. the above statement is wrong for legacy #PF.
>
>> the lower 32-bits. Some of the SEV-SNP RMP fault error codes are
>> available in the upper 32-bits.
> Can you send this separately with Cc: stable@?  And I guess tweak the changelog
> to replace "SEV-SNP RMP" with a reference to e.g. PFERR_GUEST_FINAL_MASK.  KVM
> already has error codes that can set the upper bits.

Will do.

