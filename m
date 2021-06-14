Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1843A668C
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jun 2021 14:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbhFNMau (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Jun 2021 08:30:50 -0400
Received: from mail-co1nam11on2071.outbound.protection.outlook.com ([40.107.220.71]:4768
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233076AbhFNMat (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Jun 2021 08:30:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGWRcQJQcw4M6kdJedipem+W2wh+iKI5NpzYySoyrGzhXDsE32tuX14c+u3pDlL9soW9dERQnOWEm7htmZkBFGBfQQBqs7mK6O9Wu6YU0Gw82YGuWBpWozAD7nEJpKjPxq2OPZtutoh94ZI3StNiVdqLX+/S/2681vOK9EXfpv6nfCsHx4RGbI/l9fJq5FhGRq+WtnlXjrp4pa42KUXdQM1DWxgyeeqcyAA46dl6lTuBpnqBCpFFQ2y6GOV1xelT6IxHAfwjfycBHOD5fG5YjkJaB7Cu6k6UOkXs2as2HBHIycDE6TwM4GM01jibGoolifPuwAiCALzQ11MBGfHR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaVspl0IhuuoD4kg8bxKkM3M7ksxFE8O5EKPJBtL0oE=;
 b=RwTC50EIVOQOyvVOZja8vixRrwhsDccMtBZByLktiqMqNKcs7XN8+rQi/xMu+D20rP3yk2i3SmXJkE6E72yULus9p/tj0Nt5s8DizuXRlTYqjU7c6KcFPlltfGGEkMnLTo4+6TPMCPD/9QIwTcTJw8jmLQmX4UKSM0mBingtd9G+M0vwAXkLpwk/BEOT/yZVOu11Z8XNmFN00jxUBNFXExsVXlIkuh6IfqCXdVy8L5oOUgsmcxiNVDXZHx+/whwyQbFI5AY90/odrN60N4UuPX3D7CgHVbFCPJsRtw9cWJZm12+iZlMsPmwzU/mCekRJlJsLvQe7fYM7muEdcsZe8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaVspl0IhuuoD4kg8bxKkM3M7ksxFE8O5EKPJBtL0oE=;
 b=Jpz/CRPMhWTXswfkdf5Gg0vzrM3GdnjtdAGSHde/fnnO/UMnCjKqG7OG6Em3VVwOjDyihSjjUesO6XgK/QX5Mq+N/M+EhbePyqxweG7F+tiIsUH/ZlJqMVdqSZDgLWZrguQ+k22sw5hW+r7CfiqwP6Vsdoy4O6gEczXwoRNteyI=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2714.namprd12.prod.outlook.com (2603:10b6:5:42::18) by
 DM6PR12MB3130.namprd12.prod.outlook.com (2603:10b6:5:11b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.25; Mon, 14 Jun 2021 12:28:43 +0000
Received: from DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b]) by DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b%5]) with mapi id 15.20.4219.022; Mon, 14 Jun 2021
 12:28:43 +0000
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
Subject: Re: [PATCH Part1 RFC v3 09/22] x86/compressed: Register GHCB memory
 when SEV-SNP is active
To:     Borislav Petkov <bp@alien8.de>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-10-brijesh.singh@amd.com> <YMD+lpyZfYgekRsj@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <088a1fe0-9828-d384-aa10-490228349095@amd.com>
Date:   Mon, 14 Jun 2021 07:28:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <YMD+lpyZfYgekRsj@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SN7PR04CA0079.namprd04.prod.outlook.com
 (2603:10b6:806:121::24) To DM6PR12MB2714.namprd12.prod.outlook.com
 (2603:10b6:5:42::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SN7PR04CA0079.namprd04.prod.outlook.com (2603:10b6:806:121::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Mon, 14 Jun 2021 12:28:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 453e6ca5-62df-4402-71ac-08d92f2ff25b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3130:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3130AF6F3ECB98A764F48F88E5319@DM6PR12MB3130.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7wYV+C64AIrlVoVVjFaZuP2YcLiEILDzxZrMXCKytotc+0GiY/fH9s4TeHLb3Hbpm4f/Cg5RD3nUMnup+iMdb/yRXzPw4Uq8Tyr/vAQIivtU2LjiF795TYCNtWo9+gIghRcYr9cL9LuwGAZ7cQt0azC5mTKHofZbFX2ppNP+sNKz8Cz8ZlFSpakpu8DaBDFbt1EXpbUnmtyjOY9y5nWJfreJ9Mi3EL+5ALEFjI4AfJATFGLzaOMOMPvX9kDkmIwHu7rQMrXTNTC42aP4glQCN0PRptDhqrIHJHd9Yp7o3zm90Jej79AsnIATdefacrHsw3awRuG8vJFUosvAuQexsTomR0soeVIwjvPVxcRVQVNKwXMY1Tg2AmltBPCKJE4fDBh4oCF9xny1l+fb7OedXbKimxzL971VukketxorpsijIAYI+u6aLhjMP4iRHLx5CBoaYemCXUJtlohhVT8WAtikTtbEt30+WwLIgROzA1OIqF+FE1G2i3ftpRdM2lp18YEKXdS6gOBOrd2H5i2QlT8hF9zCmKUiX22Fzd4S9cxHRxC43JOkClO43WM/NC4vH6l16+WGMG5FaW5XQ+N2ldERT+JpzxpWksCi203H/G5aIJj6lSm/eYg9n7VmJTZOT8Ht7ot85+wrtY4xiYBViAjb3bJfqEuCMhMmWeyF2mMXu2TH7qOm7ohnTcoc0o0PR42qLZpsv0IysqFwsBKAPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(83380400001)(54906003)(44832011)(478600001)(6512007)(53546011)(6486002)(2616005)(6506007)(26005)(956004)(66556008)(66476007)(66946007)(31686004)(186003)(16526019)(52116002)(36756003)(31696002)(8936002)(5660300002)(86362001)(38100700002)(38350700002)(316002)(2906002)(7416002)(8676002)(4326008)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkxXMUJ4SUdmdDlBNU52VXhzS1M1N0FFQWxvSjR5bk9uRFcreVdXczRteHBQ?=
 =?utf-8?B?T3FDYjFUNnV2eHZ3U0RDVzU2LzJlaEpGcytHbWJ3WDNFWDZONnFCRC85MHgv?=
 =?utf-8?B?VERVLy90OGExZ1FtQURBU1FYaGlrczRkNVpTU0VZdXBIdEJIZjB0Q0ZldzdH?=
 =?utf-8?B?dWRsSjcrSXY2UGcvM0VoMVZwb01ETWZjUElNVjJJVkdYa04vb1lJUHg1bVNu?=
 =?utf-8?B?SzBaeHExVjRYR1JVbFFVa1FWc0x5by95WmRPUjVWemlWcXlYN1Q1WmE3eWhG?=
 =?utf-8?B?T2R3cktVNHo5VVc1ajRXUVIveGpiY1ljdmJhZHNUZXRhK2RlWkUvVmUxZzV1?=
 =?utf-8?B?dzZuanlVZzZjaFVrL2tFUHZSNnc5WFo5aVFidnBZTmxDdXcvbkcrY1djZ0VB?=
 =?utf-8?B?QW84bGpWd3RNWmV5akRZOVhsTEliSnhPUFU3SnFOUCtLM1RYd0pCZE5qdXV6?=
 =?utf-8?B?WHE3OW1XWXNGbGxrbTZBaTZEM0c2TGg2K0ovWVYyRWxzeGV0bXY4dXhDNHhQ?=
 =?utf-8?B?WTIyUjdDTzhVMTRnK05pcDBXSWUySjZsdk1GY1dGeXNIUE95aUh6QjU2WUZm?=
 =?utf-8?B?Lzk4RURhZWNEamh3M3VEZ3I4SjNjaURWRXk4TXlmbXEvdUF5SkZRQ3VsRjNU?=
 =?utf-8?B?MkpqYkJHNXNTZW91T1ZMZ0V0bGh6SmRCVlFUbnJZeGgxVXNxRGRoRjFqMHFv?=
 =?utf-8?B?bWxvUXRzRUc3WUs1aEhhWk11SlhPaWxFSkpTVUJJSUJZS0dVQVdoOVZiQUxD?=
 =?utf-8?B?UjdXVVBPaUdVZXhwR0duT3dHbFpYMS9GQ0FZdWxhZlNtSVlBOUxOWVAvMTBo?=
 =?utf-8?B?bkNFZ1hzWThJWFg4KzFtd0VwT1JPdkM5Mjl2V2pVNjdhdUYyanVCMzF5QlhP?=
 =?utf-8?B?UFA2aFhhdWw2MjlBY1VkeVh5bXRCUVZPQWs4VHZTK0d6emFwL21IcXV4bTYw?=
 =?utf-8?B?b1QvR3BhL0hIN0VEZjVidGxPWGZRSUpROGw5OUVneVNXYUdlUVhYcithVTBP?=
 =?utf-8?B?dHMrOTBlZmpVVXY0QWVaQXg3RjNnajlLMkxCTzA0YncraDZCZ3FjMGExQXd6?=
 =?utf-8?B?T1JwQURpc0s3STE1VFl2VEx2cmJ0VENqL05vdGUxT2tIbkpIblg3akxZNTVw?=
 =?utf-8?B?a3JZaGtqUVdNTytjNlFiREtrQ2ZxL3psNTF5c3NHQmUxTHp1WVRwNGRkOGt1?=
 =?utf-8?B?WFZTVi85eDBIaWV0Um5QOGx0bUdaRUlwRGlPU3JUV0xHeFlTL2J4MERPaFpz?=
 =?utf-8?B?aHJ0TDlKUk5oNW9RZ1cvSnArYmFXNWpoTVlhc0l4d0RFY3RNYWdBaUxpZXUx?=
 =?utf-8?B?eWhxbm1YcHJHOGQwOXkrSC9YU0YwWUxzVXRFTkhPWnFkWjRJcmJSY3FHOWZl?=
 =?utf-8?B?UW1USUVodjJqdUhnaGhlVGNoYzJiTnJZcjh2TFFpcllnMWtwYUM1OExuQkRq?=
 =?utf-8?B?RkxGa2hNQnpoKzI5ZjJUa00yKzAvTTNSQkZ5bnphUml4SVppb3gwZWtJaUFm?=
 =?utf-8?B?SkFtQjRPS0pQd09pc0lPc2lIc1gwL3dJcDNMd2RrcFpROWRDekg1WE51VGUv?=
 =?utf-8?B?b2k4dFRENlJ6NGVSYTZTbi9WMTZwcmRCYzE5SGRBNjIxb2tpTkhRUGF5Y3M3?=
 =?utf-8?B?RWpsQ3JpUHUzbzZHSTBucnU5RWV1cUVieHhVYVNNcm9TWmtwdTBReXEvN0dE?=
 =?utf-8?B?cHFrdmZkT3FPZHF0SlV5SGZ6R1VjMVdXeEJRbnorNG1ZNnNEMExhRG5TZE00?=
 =?utf-8?Q?H7BlJpfEHd4ONsajiByiJ6lQncGKKukGBB9shGj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453e6ca5-62df-4402-71ac-08d92f2ff25b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 12:28:42.9051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PR/s8zuL4Jg8Yp5U2xTBQHJAekAarCTNg9WOn41n6yFhgGQnUQUCo3WVXASH0Z9XHUpn56CF56xwR8MIpmU/HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3130
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 6/9/21 12:47 PM, Borislav Petkov wrote:
> On Wed, Jun 02, 2021 at 09:04:03AM -0500, Brijesh Singh wrote:
>> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
>> index 1424b8ffde0b..ae99a8a756fe 100644
>> --- a/arch/x86/include/asm/sev-common.h
>> +++ b/arch/x86/include/asm/sev-common.h
>> @@ -75,6 +75,17 @@
>>  #define GHCB_MSR_PSC_ERROR_POS		32
>>  #define GHCB_MSR_PSC_RESP_VAL(val)	((val) >> GHCB_MSR_PSC_ERROR_POS)
>>  
>> +/* GHCB GPA Register */
>> +#define GHCB_MSR_GPA_REG_REQ		0x012
>> +#define GHCB_MSR_GPA_REG_VALUE_POS	12
>> +#define GHCB_MSR_GPA_REG_GFN_MASK	GENMASK_ULL(51, 0)
>> +#define GHCB_MSR_GPA_REQ_GFN_VAL(v)		\
>> +	(((unsigned long)((v) & GHCB_MSR_GPA_REG_GFN_MASK) << GHCB_MSR_GPA_REG_VALUE_POS)| \
>> +	GHCB_MSR_GPA_REG_REQ)
>> +
>> +#define GHCB_MSR_GPA_REG_RESP		0x013
>> +#define GHCB_MSR_GPA_REG_RESP_VAL(v)	((v) >> GHCB_MSR_GPA_REG_VALUE_POS)
>> +
> Can we pls pay attention to having those REQuests sorted by their
> number, like in the GHCB spec, for faster finding?

Sure, I will keep them sorted. thanks

