Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCA339DFD5
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jun 2021 16:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhFGPA1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Jun 2021 11:00:27 -0400
Received: from mail-bn8nam11on2078.outbound.protection.outlook.com ([40.107.236.78]:28807
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230193AbhFGPA1 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 7 Jun 2021 11:00:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9c3rxCKCm224b94lQBWQfPkPS5l4aov4YK3D3RFD2Jcuu/eYIgXDGqXJKfgNYUtUpHyNvh2lXzJ5so8O+RYH6MVQnVhhqooPwrrzwdZRbOvp0vdjIa89tnWaCqZDSuuxh/bc65cb/g8Dqk3BPKWgYp5Z0XvhRXPH55IbvxOqKf8hc7Rovo2kheAIpI4FrF7Qko+OOfs5ym0OGIZVezw32tGgvGR1pZO/nV7oU9VS+RIXzedeFZZ5m53Mbre4HglkX45isnYxqgMwRRi49k67jD1W1U9Y/qU+lCRHfEpxihvCM31m4AnqQQrij6/A9FXcYAnK6jBDqMCEwiV8iAVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEbSdwyh2OJnMmOBfBN5+urVCfuz+2CLuSc74os4IMc=;
 b=SdcGsY0RtkhU7IehhemeH7LutJ6qgvzbCKihcucD++iFxwF/NDYvxwN+N+cbGDWs/gmbThxoJDbhDN4R70UVcpFNxg9JdhdvSPKGMeWgb78wdIDDDI9O0RjhgLAd4oN9odBji1F482Gk2xISOeXTxvhuJc5e4zoZNo/XI4iugzvVOzTsfuRhyxOxVbxiFmkrSAktoP58pyEpos9+Nd2zZLtduW8XskNz3wBVHFhzmn1NeGpvi+VwqkdBU0xUbl8R7TZRgc6qHLK1PFXMXfjtceMRMapOmxWrcD8SjNxaWULmWppaQ1Vd+6fg/2pkoSAnn++raVLGiJF+5dEoWBDqsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEbSdwyh2OJnMmOBfBN5+urVCfuz+2CLuSc74os4IMc=;
 b=c7YXXQnkCLQylCXRKz9LPMB0Pl5CN21v6w4U5QT/EhdyMVylhP8mpEW7LHPYM1S30D7+w/koAITGu0Nk8CjXMsdWyovxZ8x0GMaSYmrOKNj+oA4Iiu91yfKsPsjVwUrkH2Gpr4RJQzY0FhkC9jfbp6dtD2vnGOhdqwuF6GUt4bI=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.30; Mon, 7 Jun
 2021 14:58:33 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 14:58:33 +0000
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
Subject: Re: [PATCH Part1 RFC v3 05/22] x86/sev: Add support for hypervisor
 feature VMGEXIT
To:     Borislav Petkov <bp@alien8.de>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-6-brijesh.singh@amd.com> <YL4q7jHYu65I11bZ@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <ea332855-fed0-d44a-267f-d2274032b1ac@amd.com>
Date:   Mon, 7 Jun 2021 09:58:30 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <YL4q7jHYu65I11bZ@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SA0PR11CA0094.namprd11.prod.outlook.com
 (2603:10b6:806:d1::9) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SA0PR11CA0094.namprd11.prod.outlook.com (2603:10b6:806:d1::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 14:58:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95bbdb2c-ea95-40ef-1fc3-08d929c4b858
X-MS-TrafficTypeDiagnostic: SA0PR12MB4432:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4432634BCD6E23B20A50A5F2E5389@SA0PR12MB4432.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DQMhzHsTqYv3wsiiPyAVcAgkAodHs0uM8c6TLcA52KzwC6/UsMAng/1mIb/f42n+DkaJOcFgrKe5T/sNPU+tdG3mRPP/VqsCRzGeEqKz9NkccVPpOk5FGIY4Ys/1jGy9YzWUpuLpsvKiuyjYXH0p/JjTp2xfK3i9tgBS0h+n5NkJIZBfnS5LprsKYIQuXRDgjwabNCAQSE8fP3O76worYHauXACKFI2Sbo7ydpXb2Z/gPZn0oxDGEG40Us2hTDEvjYm+r4tg/d64PgIacI55xxt6Teyz1l6VOsKTQ2H7Ghgfm5nf6sdLQQDaj7Q1u5TCSLKhHc1H8DY+762yzRtxz7M6jCUnPWtPkgFmbkt+ftn1qUTainKXrv47KQPcFdBjx6ijotA1HrFan9qoGCmT4iVGFq/vdoi0OwhTep6mKk/9BX6gVM8CIey8vLWXm86X9kb70RdFdJf0zL4z0y2X6TXFxIvrAU+dDxvlZIiGdihE7Bster9/hRLwkN/J2cZckVQXMvAGjvs/0COkDWtTPJsgpqyNbZloRV1TzOS4ecCCN3W2YAYv8BQT2UQ9F8bHei1jK03XZ5DbThWao7W9Fa5yxduKRFSXYhOdhx9dhfCkdNY8rUCxS5teR4Eml1VUd4GN6LAXjPOlUe+d0N2CSOqCcyBdUTXV2QXbZU6OuxLnTLR9/rs9Q1N6iWUMYQYs7IgOVAsNQiGob1u9X780u8zPNtxZKEA2lMbBNv4xybQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(396003)(39850400004)(66476007)(66556008)(478600001)(38350700002)(5660300002)(36756003)(38100700002)(66946007)(4326008)(31686004)(44832011)(6916009)(6506007)(53546011)(2616005)(8936002)(8676002)(26005)(52116002)(16526019)(956004)(6512007)(54906003)(316002)(186003)(7416002)(31696002)(2906002)(6486002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NEdTSHIwQVNqcjVEb0JQd3NVbEhiazY2N0IxNTl0VitCOUYzSHkyUG16a215?=
 =?utf-8?B?L3Z5QTFxbXdjWjRQaEF6U1JFd2VwTzlWS2p3OE1Jc1JYd0ppRGE3WUY0WmJ6?=
 =?utf-8?B?Q2JxQjcydk1Wb0FuSEpkUlJtMkJ1L2hsbUV1TkloZ2FvdmJkeHJoUUwxeVJa?=
 =?utf-8?B?b2sxOFN1UlJKaWdiV0drZFExQXFkUW13eWw4TXZhRGxROVh5akpkNEtXNEVr?=
 =?utf-8?B?M3hYekY5SWZwTXVPeTBqSjJMQ3BoM1U5RXBhU1VNOEJhZmhlZExpakV4STFE?=
 =?utf-8?B?eUxPVTZxMzlEbmQ5bkhQdlFDNjJxOWhWeGovNHdBUGE4RDFYSEVoNmhJNHZr?=
 =?utf-8?B?V1Nudm5mSVBOUDRSdHFyK3UyZjRUVmJGbUpuRFF2SWJ3bk5sTGFZQmc3NTdK?=
 =?utf-8?B?aG5JeEk2dE1pVllkOEppeGFvVW5NT3B2dlJma0xYc0hrMFdDM3RzM2RSUHZY?=
 =?utf-8?B?Rk9sZmYvamF5aWxCNWY0QnZWdWRiRlA5MXZIbjFCK2lVSk9lWkowZEV3OWRt?=
 =?utf-8?B?ZjQySXRhTjVramJmVzdCT3ByWVhFVEhiNGMzaWQyUUJ3Y2twcy9iajI5cnlp?=
 =?utf-8?B?czdDSUpVK2dneVh5MW14U1FpMithM3llV09GcFl5Mkd5MXU4bHgzRXp5a2Qz?=
 =?utf-8?B?RmptZWZiM28vaktDMmthWXBIUWRZY2s1MndQMHdkZ1lXYUx0WHpBeFAzRHdK?=
 =?utf-8?B?cUQwOEFNQVBPTVhxNEROYjBBck1DRWUwdGxhZ0NKblV2WldNcWhiOUpycGpW?=
 =?utf-8?B?UGkzekxVNFMwNE9CSGxCUGtZcXZ0Ykpwb0YzM2RYOW8rcytIalIxYXo2c2Js?=
 =?utf-8?B?Y2g1MVh3U3hHQ3ZmcUVPTEp6cmlBMjdTcVEyQXJpc25aYmlSUGZxelpIWXo4?=
 =?utf-8?B?OU9HODhiZ3cwLzQvSXozbENlU3M5VlU5UkhjeFpPWi9iTHZIbnNGSFJTTkNS?=
 =?utf-8?B?dGF5c0drbVZudWpvTmZhazUrWXNQcWFiQjVjRUc5QnhyeU9EWVZzSVdyRVdv?=
 =?utf-8?B?R1RlM0c4Nis3d2pJUnB4K012Z0xvOFhIN1NVRUxETWhLZmRtbmxFc3M5a3Ft?=
 =?utf-8?B?OFNpMFVDSGFxT1BhZWRMV245MlNIdFdQamtENjQrd3EzRSsxR3JIU0ZhL0xQ?=
 =?utf-8?B?SEUwNnZvL0RXNVppTVpKb1lRUmN5cklyZTB1cWh1TUc0SWFEb01RdjRIN0hM?=
 =?utf-8?B?Q0x0RHowVCszeXhLVlpxd3BMY21lQm9XNTNSTllyZnNrVXRxeGdoMW5tUmJ2?=
 =?utf-8?B?SWZJZERVaWcxQ1BGYXBpekk2S2ppcDNhMGdmWXZPWU43YmdnaEN4eS9Va1Vo?=
 =?utf-8?B?dWRTY1BPYWl3cWRydDFnQUIwcDJkNnNlWE96Y0EwYzRVY3prMlQvSGI1dS9B?=
 =?utf-8?B?MkhhUXJkaW12aUorbzdibENpNVZkMzJqM2FrZllzbkk4TnV0V1NmWXhnUC9B?=
 =?utf-8?B?YVNUNStWd0pmZnJtb2JiSjNWeUxXRnVONm1kcnhlWXRxRTRqMFFJWlJxUzFD?=
 =?utf-8?B?M1BMTE1VaklRZWREU0tjdUQ3Tm9JQU1NaVhPYU1BT1padWxJek1MREJJSys2?=
 =?utf-8?B?dFJZaDczMkRMQ1NIYm9uMjBQdjlDbHpVTWxrTy9CSnNTRklJZllmMzRTM0ti?=
 =?utf-8?B?d1dxZzJEU1Qra1FtR0ZoaUZoV2NoS1V3UDVKUGpsaTM0dWZRaGNDSUlnd0lU?=
 =?utf-8?B?OS9MUUtnZFhrR1JIVDlRS1lJcnFHbVc0ZTE2ZnVhUHV2cS8wcDh4aXlDQ1ha?=
 =?utf-8?Q?rH8kTmBMxDFrncu3XV1htcvnJ4RjsS/PfvmnJIm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bbdb2c-ea95-40ef-1fc3-08d929c4b858
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 14:58:33.5985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrdznQAaKiQydvB/hVDWA76Ov5Gngbyr81kCM2wsN/6C/W0Sk/GI05NAFp9LV3zOTNvBALdWf4kPgxJqFLCAcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 6/7/21 9:19 AM, Borislav Petkov wrote:
> On Wed, Jun 02, 2021 at 09:03:59AM -0500, Brijesh Singh wrote:
>> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
>> index 70f181f20d92..94957c5bdb51 100644
>> --- a/arch/x86/kernel/sev-shared.c
>> +++ b/arch/x86/kernel/sev-shared.c
> I'm guessing this is in sev-shared.c because it is going to be used by
> both stages?

Yes,  the function is used by both the stages.


>> @@ -20,6 +20,7 @@
>>   * out when the .bss section is later cleared.
>>   */
>>  static u16 ghcb_version __section(".data");
> State what this is:
>
> /* Bitmap of SEV features supported by the hypervisor */

Noted.


>
>> +static u64 hv_features __section(".data");
> Also, I'm assuming that bitmap remains immutable during the guest
> lifetime so you can do:
>
> static u64 hv_features __ro_after_init;
>
> instead, which will do:
>
> static u64 hv_features __attribute__((__section__(".data..ro_after_init")));
>
> and it'll be in the data section and then also marked read-only after
> init, after mark_rodata_ro() more specifically.

Yes, it should be immutable. I will set the ro_after_init section to
mark it read-only. thanks


