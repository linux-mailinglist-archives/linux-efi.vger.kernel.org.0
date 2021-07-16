Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDBA3CBE76
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jul 2021 23:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbhGPV2Y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 17:28:24 -0400
Received: from mail-bn8nam11on2046.outbound.protection.outlook.com ([40.107.236.46]:45152
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235304AbhGPV2W (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 16 Jul 2021 17:28:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+9ynfEkpqS5IXn2sdW1PXUiaIcLMdz7cFTe2bWwKXA7gOX39NV/nR3pvvYtyamfmQUtnBenGrSMebX1Hb/y28MEbyVnpstdZtH+ZIwRVfsbPAeJqOwWQiG9i5Ble/icP8JPXIj7Lo16gMCI3gXs0WoV5VhLGEoLs9rrgF6gBrNRFxXO5gqGOd3PUw47dzTYd/tQZj5Hd4lCUHu1bOZa7dAF0D1+AhyH6HIFLzySF4DruoadnX6vfCkxZua9kZu74KEjTiADoeSm/vJ4pbVfmYAaHcMhvK6Q44StIjgxfuea+zZ9QrGemJBxUALWi6Xs7WSB7fbeM327nmxFWpZX6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTdI+fTA1UXZazDgnLPmbujBWrZtwQ9krVHPN5u35V8=;
 b=PaetAvH9mD1twDpdZKJsFGL9DhXxZ/wQtKAkEjr3o02XELasOtR9pLHDa6EVexhUHzw+WT+qAztmGD3PC3nzMbllOC0a0Vy5By1L56mVnB9sNvDbSYLCEpnzfrClbL8OkWL1UVOomF7jJggx9Cg/EsTsE3BGTsK4aBk25hz/JNWp3laNNJcHTSBZdi0fJ1oOA7/hFFVDPwmiP90B5FVpDjWOKUHwXhtLhL6Yd8sDxxFYuri/Ep8sc0MBoOSwU+bjZ5h9NHkUEJUDfAqVfljlhgmkWp/Kq/612HPyHyN7JOsp4+lq9vZaozW8ZpAoG8Icc+HVpU0JbFGn1xwdPc2owQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTdI+fTA1UXZazDgnLPmbujBWrZtwQ9krVHPN5u35V8=;
 b=d3GT4j5tHJQ2DEysGmlsUwU6kOsPN/J+IcHBEvOv9jCPC8Aalf6qMyV3BKKDDUtHaKyR58pyhH3rqsbxqTVUmpj6t5D7tY8YN3ecFiRvDfZQrBqtgogCAqJco91aWXsHiMaSsxejnBSK2Nv3NIw/nBEQgyQOdtEvCUinM5FM5pc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Fri, 16 Jul
 2021 21:25:24 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.024; Fri, 16 Jul 2021
 21:25:24 +0000
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
Subject: Re: [PATCH Part2 RFC v4 22/40] KVM: SVM: Add KVM_SNP_INIT command
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-23-brijesh.singh@amd.com> <YPHfC1mI8dQkkzyV@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <3f12243a-dee3-2a97-9a1b-51f4f6095349@amd.com>
Date:   Fri, 16 Jul 2021 16:25:16 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <YPHfC1mI8dQkkzyV@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SN4PR0501CA0126.namprd05.prod.outlook.com
 (2603:10b6:803:42::43) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SN4PR0501CA0126.namprd05.prod.outlook.com (2603:10b6:803:42::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.15 via Frontend Transport; Fri, 16 Jul 2021 21:25:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32789d18-78ec-405b-c9cc-08d948a038fd
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB244747FEC188CEF388808375E5119@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eccvAwDbtApsu+038/bLJy20xak/D3bCHktERZIPnwnT2BZPf/NlLhYHFZR722AZcF5FYlI5IT9T8r+BOKMxxqzWno4UxAFYVKyZiU80ZN/eztNx6x07ZMZBmKBwVyAr3f8oZCQZvLyMFunAWaAwB7StgNERDojUxJp3iLGkqr8PTkeF3BnHm05xEr4aDOlvkhuXeqXtEu9z2s9747Ob4M/kWeI9wPtEMR6ml0LRBxCey2l9VbvT730HPeIyg/Z0KReOvR2lNNWo0S5lbx9zxgAfvJxyDUUjkP2q3nUZ1jesVTTK+PccJuRcmEbWB/sCjXSEA1m1QQdovdN4ut1YNeZY6DNCWaAkYCCaaBGLwi8ew2VlxIPdoFWbArv46CyHyrPTYbW9xzxWaTr4XixiRC/A/rbkmr/9CBlcKiNOGCEu+m9a8tIOKsnahYqeAObalTUvMyYKZxZ7lMABQ72W1PwrijZkrk3VuPCWQzXMGY8hGN+14Ml9NYYHYGVcOEWkmJHHr8DNC+9mUwcq4PolLRn+jDgZEvyUB94WxaozpMyc/MtE4dzpino55UHpGVP20d53elFJKjHJQQMTvl28XCsBd8ATK7SyK0S7WlpTPjuU5yIy3iXGbpoxbltMc+luVRfJkS9epJfBfs0Qw7GbcIIzqBfYid34/67k5dGwzozswl+qlGnPQsXdS+C9Ascl1i4Xthsvw4SZ0g+B2H4+YvqUep8YWf+eDh1hEEBtWD2yijTDVI8O0fibdDEIvwRLaP2an6M1fY651wAqsbxX/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(44832011)(54906003)(8676002)(52116002)(83380400001)(7416002)(316002)(956004)(7406005)(8936002)(66476007)(66946007)(2616005)(6666004)(31696002)(5660300002)(4326008)(66556008)(6916009)(6506007)(38100700002)(86362001)(6486002)(38350700002)(36756003)(26005)(186003)(53546011)(478600001)(2906002)(31686004)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUJ4YitkMzdSVi9MUnlQUVFISmoxbUN1U01rbDJwOVhmNzZhbGtPKzlEaEVa?=
 =?utf-8?B?ajRrYjlEU3ExQzgvZEJESjQvdlNuZEhaOTJFRDV2WmxjUGJsdnNHSmJBTkJq?=
 =?utf-8?B?WlNubERBRUIwTVprNTd4WVcvRS91dHhCVENwbkl5R1NnOWxySEhxQkltR3pS?=
 =?utf-8?B?SENDWERYaCs3Y1FOUDYwd2VYdU96YU15RjV0SE16YW5RU1d1a24wemxpWHpy?=
 =?utf-8?B?UENQanYwb012VHM3MEhMU1dBTzB0enFxRTdPT3RRbkREQkxmb3daNCt3ZmZS?=
 =?utf-8?B?VHdrZlBaL2U4R1FTQng2S2VUSFhmQWJmemx0RUdHUDFhWkhURUdjbWNOQUdX?=
 =?utf-8?B?SU1YRGkvYzVURFJmckRaOVFpMTRzSkxONnI1NnRhbDIyaUZlcVpGZ1RtVFVr?=
 =?utf-8?B?T1k4ZktMc0YyUmNJbGQ1eGx2cjJpUVFVMXBvTnNXNnJyNTVxY2szY1hjMTFm?=
 =?utf-8?B?bGtQNHlsTlJXT2ZScGZlbm1lTXlldG5HTFhUQzZVM2xoeVlSSmZRWGpnTlYy?=
 =?utf-8?B?dVJsRjBtRjZ6VXE4ZHEwU0ErNXVvK28vc1R5TjduVDV0anZabzkxdTNoeFdV?=
 =?utf-8?B?SWpHZklkMUU3T28wT3ExVHFKdjVnam1OMEFMR0FBRDJUZ3dPT2RSQ2Z0UTRt?=
 =?utf-8?B?cFlJN2p5cy85RndwM2wrTko4WmtIdXl1ZVc0QkkzVjFvcVo1QWlyNVZGMnFk?=
 =?utf-8?B?Qng4dWVaRThzbkNSOTEveUVIZ29nL1hUcVlMZ1lHSkRRb0FhS1lrS3RpUGM1?=
 =?utf-8?B?d0VmVnFSaG1LL0dsZnpVTTdGWkxWcTNKZWZDcDROeklVc3pwMjVMT3ZEU1pR?=
 =?utf-8?B?WUI4N2t5QmdqYXlKc2ljMHpQbWpPa0lRV1FyU0tPOVhJY1RtS0NCWWJSQ3NI?=
 =?utf-8?B?UDZkY0xERVpSYU1mWkp2YXVza2VCek44bnlnWlg4NW1BSGpRZ3JkMUdFSnpF?=
 =?utf-8?B?eHZMeXBPMHRwZFdXcTUvTmlEeFZKYkIzZlJsOTBza1JHTE9WNFZzRW0vek45?=
 =?utf-8?B?NG1LQTdoNWFqQTFaL3FJaVZPL1RtSDMzbXU3N09vTTI5Yy9KRFYzWm9tRjhP?=
 =?utf-8?B?T2pQVmlLNWg1cWVnNVRhc2lCc1ZPbmNHdFJCZUJLNjdQYVk4V1JiM1YwV1NO?=
 =?utf-8?B?TE9QUmxDRUhOdGtNVTIwSENFT0RRUWtBOGd3SHpwTmZjUTdCMWtJRWlQVUhJ?=
 =?utf-8?B?KzArUTZtY04ySWY2dGtGNEo2djZoQm9QQ21rMEw5TEFERUJGMzRGM1FBM084?=
 =?utf-8?B?QVA2UmU1dU5JRGpsUklKNUw0SXJ1dkhZNEo4QVdhZC9rYUNtS2pTd1NQME9Q?=
 =?utf-8?B?aU5HcXF2R2JFYmxjc3FKSUJvS2M0ZjRzemRNQlFKQVQvcU1mdDIyWHIxR3ZC?=
 =?utf-8?B?cFZ1blpQTUQ3YVc1bU43L3ovcDAyZzhVMCtnbTJDV2syN1hnNzNzYTE5Znh1?=
 =?utf-8?B?ZUhhOFdpeWZ5bVdpcXVIM2xyS1lWUjlEYkJ1VHp1RWowMG9TOTUzM3ZhaWFh?=
 =?utf-8?B?NHBESTczK0tUdTAvQzhYd0R4TG5vNTFOTU42aXVTQ0ZuejB4STFsV29NR3Bn?=
 =?utf-8?B?a1pUWm5lYlp3QjltSWpKYW5sKy9NNzRCNXhpZWZUYXkzSjVSWkEyQ1ZkTnlQ?=
 =?utf-8?B?bDBVM2toS2xoVk1TWEd6ajRPcDNXVkRRTE9NM3RrVnloeDA3U2Y2MktGSXAz?=
 =?utf-8?B?RHplQVhlZEt6Z1p6WjJWcGxwMzFwLy83MEZ1RmpIcWcyK0FHdW9kWGh5R1NQ?=
 =?utf-8?Q?gMeEcODntyztcHs5xfdrApgNCuHRxeBwQs3ncMa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32789d18-78ec-405b-c9cc-08d948a038fd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 21:25:24.0108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLTJPuBH/GV8NGpJcVw6GmOGvGxqqYwrUFYWAlUzJsgkdhM71vNjdLSn29AyHzl53QInysqz1v+GUO1UKzPIbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 7/16/21 2:33 PM, Sean Christopherson wrote:
> On Wed, Jul 07, 2021, Brijesh Singh wrote:
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 3fd9a7e9d90c..989a64aa1ae5 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -1678,6 +1678,9 @@ enum sev_cmd_id {
>>  	/* Guest Migration Extension */
>>  	KVM_SEV_SEND_CANCEL,
>>  
>> +	/* SNP specific commands */
>> +	KVM_SEV_SNP_INIT = 256,
> Is there any meaning behind '256'?  If not, why skip a big chunk?  I wouldn't be
> concerned if it weren't for KVM_SEV_NR_MAX, whose existence arguably implies that
> 0-KVM_SEV_NR_MAX-1 are all valid SEV commands.

In previous patches, Peter highlighted that we should keep some gap
between the SEV/ES and SNP to leave room for legacy SEV/ES expansion. I
was not sure how many we need to reserve without knowing what will come
in the future; especially recently some of the command additional  are
not linked to the firmware. I am okay to reduce the gap or remove the
gap all together.

