Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F423C92B2
	for <lists+linux-efi@lfdr.de>; Wed, 14 Jul 2021 23:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbhGNVDb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 14 Jul 2021 17:03:31 -0400
Received: from mail-bn8nam12on2062.outbound.protection.outlook.com ([40.107.237.62]:40801
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230180AbhGNVDa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 14 Jul 2021 17:03:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ic2ndTyNOi8vF/7O9Ro1q5EL3j96FsArGp08jBnLT5rBa+E+ulo2h/nm5CXg8OKIOGPP7TaIzk+dIT8UqApDmHTAIWER70xC9CvdWHP3T+0IIaQupjPadWQ3CdmdLAy3xZhLPAM2r602gSfYSvgzIWT6RLjRB0fLMN7RTCtVkVBW+5m/bKIpdpvoDu2IEkPYSVV0ak4lB752peNgMRhYR2SrhjUclicwQx/0JBwNd4kFt8cOFBzUX9AA8unLVdQhU576IbGkbR21LNDrVHaj4RKbbUWlNJ5ykYSKjzXtEFxnSmcRKP27qN3uIJlrL41fBPcirAm6PCPPyjNJdJn4LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9xvcNON9zyFPgc7JUBLK5RCavrI19ElmjmM1FNb5rI=;
 b=C1RQW3DieFw+6daes91buR1aoY17bltLaaVZyNE6yxUL3VS+hWtOJ7je/pGumngQ7R6Gdgtxxs6Ldt7/jVhY7WyQER/YbT61AbCXwScU+B35h5zOFB7P0fNfpDdR71SQh7KA5q3HFO3GcAcDCQK2D3lbnm6Ep/xSfZyR4lL7KYJBCsuIac9dFm9etv720fSA8Bkegt5hlIz0Yl3M9b/yPrwMqP/GYe1LCec7Qf0iEZVU49BLDTPqNhgbHClvf7am53qYUuuT1IEcVRoN6ZC/mFU3oMNBOIo1BPaA4QNkfNLeEma5H75IF3AcJzOf6ZDonCL5WGoTZUFlZF9TQBujeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9xvcNON9zyFPgc7JUBLK5RCavrI19ElmjmM1FNb5rI=;
 b=W3/EKb45iGzB6yyNGy+HMiBIZy3XngpGsO9DFBf3NueQxLG9Iu23RnmV5ZJ/jYcURgeLWF8MmISa9G1u4MxEzRd1l5Mr8HZs1UIUFHjtfjnwKJmd8iT/85KHlZlI5Y88ewf2/WO/e1PttgEEBFrpxeHWWxulpkBWw9ZmdmuQ8E8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 21:00:35 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 21:00:35 +0000
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
Subject: Re: [PATCH Part2 RFC v4 02/40] KVM: SVM: Provide the Hypervisor
 Feature support VMGEXIT
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-3-brijesh.singh@amd.com> <YO9K8akh1CdY1kjd@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <b73ad44e-7719-cde7-d543-df34e5acf9a5@amd.com>
Date:   Wed, 14 Jul 2021 16:00:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YO9K8akh1CdY1kjd@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0050.namprd05.prod.outlook.com
 (2603:10b6:803:41::27) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN4PR0501CA0050.namprd05.prod.outlook.com (2603:10b6:803:41::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.14 via Frontend Transport; Wed, 14 Jul 2021 21:00:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3fce9c8-3c0b-47d3-51f1-08d9470a6d0c
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB451283FB2A2650873C4C24E7E5139@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yt3zoEKKSwtJgP1UnpclJPiMAyL7O4dNyHiXFmmpjQTAdmntmXVWOqNo6j54/0TaZyCenQv9e0rHc5e+6r8ZE1llSlquvi2PwVdnDJ8mt0Xo1ekFQ7Qv2wGx38sWm5w3L54VTwOV0eLUuDQYbzu5jioCLFKAbBvUtPE4e5wIRH+6rQ5+j+mQqz0WTTnK2shnoH7gIKQPa/J8pFNXWtQ7bn5zdV+1iTDSuX4DAj/2H93Bpyra+E9gfSwMuU6jCvra8AfafI9izSFhJyEUbxwEXB/eZ1hr4vV9l/EzwFSQFUlRnM7FQF2u1FkOm8JgD2Yj4GrsaDAjYJml6yEjwuxknswZoUbcRWauCl5MUAQjfoQ9nH17Ziwi2kYlZC9dVWwPbm2/M6JtVR9tDxu4mSEBlXD4wtJqx+LkJgJywhRL1qFQIqNswf0UH2EbuEQAhUMhB89LQlDHk1CEk7dtMqtDSEZ6TJaTGhCCmYVvhxfDLc21X5AhU1sKUUSXoK7YkjyxDGICxx+TLRnFjbEQX5MBWChS+X3GmeKHx6XxDEG6GnzuzmAZz7DWkV1pjpcwzduzk68O/83kvhTvhVu+mDE1HngUTSWwxRnFXmTouYlWmw4KYqAp9ToGDQqfrZ70XhDVNdkBO+pRIkhLW4tK/QkVCh4GDnAVc7R6Ah9X1MYIoGs4uzqRrDnpbippbxlw+Jah46hYmz45aJhDBzmic6RGeA/vQmVCs6RNzC0ZjJg/bdbhvzMOpvvjY+wvDGUmNc2FngFTmGgB4D17Ztkq8YJfJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(31696002)(66946007)(86362001)(66476007)(53546011)(478600001)(26005)(38100700002)(36756003)(66556008)(186003)(31686004)(38350700002)(8936002)(6916009)(7406005)(44832011)(316002)(16576012)(2616005)(54906003)(4326008)(4744005)(956004)(7416002)(8676002)(6486002)(2906002)(83380400001)(52116002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SElIRnk0MEllZ09wU0djdkpNZW95NHhqTmlVUFNkdFNVZUFXUGY0bjB4Q2dL?=
 =?utf-8?B?QU56c05LcnRUOVFXU0RXU0w2bUI1VUorMkpqZkxibTM3NnFyaU15UXBWalpW?=
 =?utf-8?B?MjRTL3FwODdua1I1WENZSkR5cjJDVTBUSzBua2dYUjROTG9FTXpqS3o1UGRm?=
 =?utf-8?B?R1FUVkUxaTVxdHdQSThlaWFQT2JGci82NE5SNDZwRE92SE51anFtNkNOc0hO?=
 =?utf-8?B?UE55RVpyMTdSb3RZem0xcW8vamc3M2xLUG51Z3FqQURLU3Axd1hyQVlpUnJn?=
 =?utf-8?B?NHdnQjJxTDl4OEU4b2V5WW5iemNqWnhHK1E5TEN4c1hOT1RyTGhBaGc0MGtO?=
 =?utf-8?B?azdvRVcweHM1bS9vSTIzdVNXQjVFNE1YemVNMU02RzJCZTVWRHFDM3gzWkd2?=
 =?utf-8?B?UksxbWpZV1gzQlBJWEJWUkJFMEphUk1pdHZNbENtMkNKTFlpR29DN0I3UWMz?=
 =?utf-8?B?VzZPT1dIRGFtSFMrWFhSOE9mR0w5Qm5YVjFXajZWMGJmTzRXQnIzOHFwYmdn?=
 =?utf-8?B?TzhITkxGUFp0UFJPNWpWRkx6RitwekdIMWl3NW85NG5ac3UyNzEzOWUxcFVQ?=
 =?utf-8?B?OFBEOFZjb0NrUGZlYWxxZlRQaE1lU0c4Q3UrTUxXVEU2YnhEUGpRWmpyWnQv?=
 =?utf-8?B?Q1F6Yk5BTTRZdWVHUmIxb1E2MUpKUVJ6azhjQ254bWtaNVhKdFpMZUtNcUlu?=
 =?utf-8?B?bHAzeUt4b0pmTmtod2w4YVozNVBKaU9SdHlJS3pyMkdFMDUzVUNmSHJJeFNL?=
 =?utf-8?B?eC8zdVFIWmdMKzR5SjNCL2c2eDgzUnF5S3E0MXJPRWRXT3o2RmFCeXFQRkkr?=
 =?utf-8?B?blVwbE5JazkwcTJCVmFmSzhkL05yTFpOOGV1RjVFUE1iTS9aWVFIZm1PT210?=
 =?utf-8?B?RWR0OTliQnZXT0xHL1M3S09RRWsrSC80Wm1ZMGkzRHdvYXpRM0NKN3dkZVkv?=
 =?utf-8?B?Y2kzTzZYTWVMSkpKeUoyRGU0UzBwOXh3Yyt2N1luU0tsdDlCMTZwUFg1M21m?=
 =?utf-8?B?YWl1MjJaTUJNeTN4alZpMXgvakxja281bzVVVUpBY1dQMEVHekN4bkY2Y0lt?=
 =?utf-8?B?Yk1lNE1nMDVCWDZwVlRScjB6MHhmVnk5Y1Yvdndkb1dQRFdMRFkrMGhsdjZB?=
 =?utf-8?B?MGFVcmI4Uk9XNzZoa1NHZnRqOXlxanhXYmlwU0x1VlEvb0VNSGwvNWtiaUkx?=
 =?utf-8?B?RjNhbk5zTUlsN2ZqMDJoR3VQM1huL0VRTHQ3K0hOQ2FJamxRbXVzVHJnSmtK?=
 =?utf-8?B?QnVvM0NQV3pxNEZZcTVtSzV4Q1NDcjBqNjhUZTN1Syt1eXUzTElwSGRpM0RH?=
 =?utf-8?B?aGV0WFoxSkFwZytiN2Y4R2lrc2VVbXM3WnhWK1NFbVd6NjkwNWplaGY5dmx1?=
 =?utf-8?B?MGc3aWV4MURoT0pabS9zVURvZmNxNWd0czdlN0RvTDlWdUVoL0prS3VvaFZR?=
 =?utf-8?B?MUdwb3BlY2EzNnBQL2Z5d0xQSWIxUGhNbkQ3b2FWZDBTMkRMS0UvT056bVhO?=
 =?utf-8?B?andaTW5JNWlZRVlmQnRKQmRxT00ydGwzUXZRSk5RZTRXeDVKVDJodmZvQXFK?=
 =?utf-8?B?Z0VsVEJyeVVXcEIxZEhyM2xWUDRSeG1MY0VBNHJvdHZxQ1Y2TGRTVmFCazM4?=
 =?utf-8?B?dXhkRmlrMEZTa1B6ejdXelV5NXN1emhBQThHODdiOEdQM1IwZlVheURPRWNn?=
 =?utf-8?B?VWZEU0oxUTI0QnlQSVd6Wld5SDUrMVJTNnhQWmYxejRLWjZnVXZUOFBlYkdm?=
 =?utf-8?Q?XsSsH1145yuIXUbGaMo1s9tSBfqtdd0IPfYZDFV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fce9c8-3c0b-47d3-51f1-08d9470a6d0c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 21:00:35.6473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X89NXbhRbN8ZqgBepbg0q9n/xxxvqMHXeO3T7X7QIcS4IT8LjzTyjhkMBx+AqreSnYEKulqc0Eg3GvDXHSOIXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/14/21 3:37 PM, Sean Christopherson wrote:
>> +#define SVM_VMGEXIT_HV_FT			0x8000fffd
> 
> This is fixing up commit 3 from Part1, though I think it can and should be
> omitted from that patch entirely since it's not relevant to the guest, only to
> KVM.

Yes, one of the thing which I was struggling header files between the 
kvm/queue and tip/master was not in sync. I had to do some cherry-picks 
to make my part2 still build. I hope this will get addressed in next rebase.

> 
> And FWIW, I like the verbose name, though it looks like Boris requested the
> shorter names for the guest.  Can we keep the verbose form for KVM-only VMEGXIT
> name?  Hyper-V has mostly laid claim to "HV", and feature is not the first thing
> that comes to mind for "FT".
> 

For the uapi/asm/svm.h, I can stick with the verbose name.

thanks
