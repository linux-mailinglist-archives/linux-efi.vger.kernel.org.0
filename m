Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983BD3F9E86
	for <lists+linux-efi@lfdr.de>; Fri, 27 Aug 2021 20:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhH0SI5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Aug 2021 14:08:57 -0400
Received: from mail-dm3nam07on2050.outbound.protection.outlook.com ([40.107.95.50]:37856
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229617AbhH0SI4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Aug 2021 14:08:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKamdhIWBTxvIqpbGq97pAGw2oNfqmeNnJ+Tf5ffuJ3ioesG+z2OUW8uzZH3HYEhOJ62T/ezJjtV5evZEaJ1uZjPDhENzyCcRpcAUU//fgZsVZdOfKCorDoQiHw9gNp1MgKNF30G80M8OLgtl9s4x+y+7P74lM2ZvbfuZAolE/lly2FxbfTQpwgGEJC/cSKCOvyP/hQvZQQGwvF6U7ikWY3cf4xgjF2wFYodd/ZhZWWU3XRNQyKvfSEobot9fet2D6fQoBeLDNfRZ+yAEKWz44TwXkykJTGZR1+97ooHgIf4LEE+1h2ct27zdtpfU/EdCcVTcRP0GIFY3D+vjEx7gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnJhchn2eCDdVstvFQAdp4ApA6X4wbTnVStlp8fkUm0=;
 b=Fbe3e6+bc/817OitKh5D71rOdi3xfBh5i0P4sJieeiIZwMXzXR2wn5yXCS8stXEr3rTL2EuUl42FZUB0XqpNqGOAjokgYeUCKZUOoNozj8D9cQuzQiNcocRhsNZ1EWf62HGrjh6e+3JOjlzMNiz/umbAs2jVyBjx5j3gf0f4pkPaTuHE5lIhJf18odN0Jhz39uMZfuzZufcWsksF5kGioRDbgDJQHcr6qVaHX6GFzGfVpKKgCmv1in7o/zNal+AvYh/IiQdf+YxwYIWBX4jj5Xy/Kjmnz9QFId73UVyrQctq09AmoYE89AAmNDsNLojKitO9roQsSPAUUE/aGqHkLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnJhchn2eCDdVstvFQAdp4ApA6X4wbTnVStlp8fkUm0=;
 b=LTaVyJBaThwBkR9dL+uGuKA01DpFd4aP4jPTR4R0l/8HR+ZmgFAfYIiPslg8DLBbM9pbbq1gYwLt4/a1DuIg+xunM6u0FoIL/04HN1mzdtCK7ltV0GC+PzzjojMOWktfQGvBM/nnzB4NdtflBGpA4O+Sr/xH7SogdvvpdEy+aY8=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4590.namprd12.prod.outlook.com (2603:10b6:806:93::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Fri, 27 Aug
 2021 18:08:04 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4457.020; Fri, 27 Aug 2021
 18:08:04 +0000
Subject: Re: [PATCH Part1 v5 33/38] x86/sev: Provide support for SNP guest
 request NAEs
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-34-brijesh.singh@amd.com> <YSkkaaXrg6+cnb9+@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <4acd17bc-bdb0-c4cc-97af-8842f8836c8e@amd.com>
Date:   Fri, 27 Aug 2021 13:07:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <YSkkaaXrg6+cnb9+@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SN7PR04CA0211.namprd04.prod.outlook.com
 (2603:10b6:806:127::6) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (165.204.77.11) by SN7PR04CA0211.namprd04.prod.outlook.com (2603:10b6:806:127::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 18:08:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcb3472c-baa8-49d8-3347-08d969859d49
X-MS-TrafficTypeDiagnostic: SA0PR12MB4590:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45900706F148086BFE0B509DE5C89@SA0PR12MB4590.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QPY32qe6K/yjqMtRK+YAZlWPL44L+w46xMA/R5tR4YhY4uiGAFIJcBqwi59BvZWsKnlSTGVg9VdOm0m0W0msE6SWBNuv1Zg7ZD72JT6bRu1EvjhuoxYya2SntJIDUNn0j+iTAAX4dUhBkQhuDAlr77BQFI6w3P/o9rkPAzfQ/kR0kNwNoq8UnUV/8lhXFM+Br9kKT8ENJw3hBH25wYdqGNpa7451WnaJp4N5ftp156N0bH1SEob3paAnuftzoXpU1L7WsDKOsG0KtIqBJpBX7ZasKagdf0ghWv4rvoIqUslE6TeIEWrJ5fK8sfHP0IW3O7WyewCTilNAsjyJ3zf6zDqNF5mwsw2WwXKLPst0WrFiMcs6IDHrrRqi/o52bDCb7qSZolHfCbcr2+VTEwm1BTuqaD7XsxvaZRuma8oliQQMthWpEUI5uu/n/OmRsiMQtDMnoBEorQ02j2Skufd81zYecFVW/k7qq1MDG/Em3QEqlul7iljIXu3R3hM26SOAnVtedb3TOYaLBEEgzLUxOK71OBUOLPvA4wM2XBQySh/z3H7RLLuFkwqWFDO7/ztRgfPyBSTmvT/2pqijaxkfSBqTwxpP6CWyEcd3ejXPl9OY9LS9K+EREHs5MAV8e2hzzDuQPRJxNbp6mJtmm7R+wRGdlhVFH4C3Yywg1wjL22cwoJvEiEQmTxauyiuFi0hgCJyE40UdVR5Cf2oEWl0cW8WifCsyIptjUo0eYemk6Kl3P9hLHr1SiSj111iDSfZx7rA9dzArSLoByRG323MAJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(478600001)(86362001)(52116002)(6506007)(8676002)(8936002)(6916009)(53546011)(66556008)(38350700002)(31696002)(956004)(186003)(4326008)(66946007)(2616005)(36756003)(6512007)(66476007)(26005)(5660300002)(31686004)(83380400001)(2906002)(44832011)(6486002)(38100700002)(54906003)(7406005)(7416002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3NweE5rRFcvOVVyM0U2VDkrN3ZPQUtwcW44SkNGcUJBMStGOGdnZm1jWTV0?=
 =?utf-8?B?ZUE4di80Mk5uRXdaY0JHWlN3aVZzQ01ucDRhMTdtWEJjRXBzclNTa05vWFdN?=
 =?utf-8?B?dmhRVUVzeFV3UkJBMmtxem9wY2t1Vjc4UkZ4ODM1SGQ4cnZiWHJwWDNtbncv?=
 =?utf-8?B?SVBPK1JQMFpBdjdKZVg4NUNyWEdabnBVVHFSd1RoUVMwMTYzWnI5MFNKR1d0?=
 =?utf-8?B?eGs2S3N4ZnBhZjUzcGhNcnhyOWhJejdOb1dtcUJodm5Wd0dVazN2bG93bU1o?=
 =?utf-8?B?Wk1LYkRvcWVFcXVtSGI4ZlgwMDd4RDYvb3R4SjQ4Vko0TmJ5VWFmV1l0c3VY?=
 =?utf-8?B?KzQrelJySytLcVVtbXFhZFhOZ0VXU2taaWdXeXF6U1ArMitsK0V0MHZhWkVx?=
 =?utf-8?B?NVgwTUZQKzNMZDh1NXpwcUFLSWVlaUdCcktQSnRabG9BRjZaVFhKdzlxK2Qr?=
 =?utf-8?B?bm5lV1ljUWYzOXN2RVByZnQ1aWpCMVNYeWpxSGUzbXVSTmordFBuYUprM1ly?=
 =?utf-8?B?eEczeW9VVERYSUI2RkdOdE9GNFJRT2pxdjVIZXkya1Q0RWVDeU9NOFhPdEM4?=
 =?utf-8?B?WUx5Yzl3WmJSbzc3VFJ5aU1ITUhuRmgxd3RoVk1FbHkxa3llSk0vKzdRTlhH?=
 =?utf-8?B?TmZPbkhiYWZOeDYzbmF4VEdZWXhBR3hySVd3dVhLeXZ6czR5N2x6WDE5ZDVz?=
 =?utf-8?B?aG9RUzNPL3JrV0VGelEraDRSZTVmNVBnN0o0eHh1d1dLUjgxWTc5TU9Md05W?=
 =?utf-8?B?ZTh4SitSUi9STllzSUlSeG5hSlJKNUYvMmZ2SUF6ekxUa1ZhT2ZMOWhOejZx?=
 =?utf-8?B?aDhGWDN1TENPOW8vZHpoT2ZEYXlXbzJzQ0kyZnFQZkd2RU03RUhhRTR6SW5h?=
 =?utf-8?B?VjdZUVdMeThLUHRCdUVRWFh5aHdYYW9SUjdySGdOMHdCOEtZTGxqMmNHRHdG?=
 =?utf-8?B?bjBrRnMwWWg0NTRob1Y4R0d6RFMvZWxJL1padUhyRVdRNWdWNGxSYnAwYkpU?=
 =?utf-8?B?K0RUa0g1bTc0V1haRzhnNkhMdWh6TEhBbGtkRWI3azZwbVpsQ3Bpck44NnBr?=
 =?utf-8?B?b1pYN0F5ZGRlNEphUE04NFVtMnB0U3ZLNUpIeGFRSXFQcXdkZmMvZ05OQU1B?=
 =?utf-8?B?YVh1bWhJVEttWXJFSUt6R2tLcW1ZOEdOd0tZaUx2MmV0T29lRTJ1UVZJRlN1?=
 =?utf-8?B?QUhRSU12bEtCYkdNSTNERnRyV1FtbzMvNW1KRnBTdUsycDlkeEsrU2YxVmlj?=
 =?utf-8?B?Z3c4RXkxQk9ib000Rk1UV290bzJibWpCbHUvdWhNTUFnc3VVbXYxcUNXQWll?=
 =?utf-8?B?UVlsSjFOb252SkptRzFDS001Z0huc3o4VTJma2VTR3VEYW93eVJiejl4SzND?=
 =?utf-8?B?M0xCYnRYeTl2cXlCNlZrSHgrSWpHOW9EaytvdWJuY29vWXU3bG9rVHBSNndu?=
 =?utf-8?B?aU5Vb1VPZU8zbzh6TVN6N1lPalh4Z0ZxdUxBMG1saWx5d3VKdkNmZWw1ZERX?=
 =?utf-8?B?djh2VmJ3ZS9HVTFuY3FRSzFQOUhQc1FDdDc1Wnh5YUJsYzlPVkQ2ZFc2czIw?=
 =?utf-8?B?YWlBZEZWQzhsbXUrSEdGL29wVlBEZTVDSFRreTZFcWpUeG8yY2ZXU2dDa2M1?=
 =?utf-8?B?cC9DVDBDOGlSQXk4WnRZM1ZHYWxTUGNkY0RVV1p2ZnBqc3gyQ2Y0ZmtwSXRj?=
 =?utf-8?B?K1IzVkh0ek80ZVJEQXp6SGdrL1g3TzV6NHo3T296aE9BVWNsKzYzTWR1M0x4?=
 =?utf-8?Q?UkgnsXymGpYcmzD/gk7rjEBotpBVe2wmIkta4Z4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb3472c-baa8-49d8-3347-08d969859d49
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 18:08:04.2771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kV1ybvkd5+ihr8NKyKHQlrwrDhkh2Wpu+MwBIbnFr0iMA9vd4FI+ZPxLNqsoxKrXHgeoPy2QhoTt7i4jpOk1BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4590
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 8/27/21 12:44 PM, Borislav Petkov wrote:
> On Fri, Aug 20, 2021 at 10:19:28AM -0500, Brijesh Singh wrote:
>> +int snp_issue_guest_request(int type, struct snp_guest_request_data *input, unsigned long *fw_err)
>> +{
>> +	struct ghcb_state state;
>> +	unsigned long id, flags;
>> +	struct ghcb *ghcb;
>> +	int ret;
>> +
>> +	if (!sev_feature_enabled(SEV_SNP))
>> +		return -ENODEV;
>> +
>> +	local_irq_save(flags);
>> +
>> +	ghcb = __sev_get_ghcb(&state);
>> +	if (!ghcb) {
>> +		ret = -EIO;
>> +		goto e_restore_irq;
>> +	}
>> +
>> +	vc_ghcb_invalidate(ghcb);
>> +
>> +	if (type == GUEST_REQUEST) {
>> +		id = SVM_VMGEXIT_GUEST_REQUEST;
>> +	} else if (type == EXT_GUEST_REQUEST) {
>> +		id = SVM_VMGEXIT_EXT_GUEST_REQUEST;
>> +		ghcb_set_rax(ghcb, input->data_gpa);
>> +		ghcb_set_rbx(ghcb, input->data_npages);
> Hmmm, now I'm not sure. We did enum psc_op where you simply pass in the
> op directly to the hardware because the enum uses the same numbers as
> the actual command.
>
> But here that @type thing is simply used to translate to the SVM_VMGEXIT
> thing. So maybe you don't need it here and you can hand in the exit_code
> directly:
>
> int snp_issue_guest_request(u64 exit_code, struct snp_guest_request_data *input,
> 			    unsigned long *fw_err)
>
> which you then pass in directly to...


Okay, works for me. The main reason why I choose the enum was to not
expose the GHCB exit code to the driver but I guess that attestation
driver need to know which VMGEXIT need to be called, so, its okay to
have it pass the VMGEXIT number instead of enum.

>> +	} else {
>> +		ret = -EINVAL;
>> +		goto e_put;
>> +	}
>> +
>> +	ret = sev_es_ghcb_hv_call(ghcb, NULL, id, input->req_gpa, input->resp_gpa);
> ... this guy here:
>
> 	ret = sev_es_ghcb_hv_call(ghcb, NULL, exit_code, input->req_gpa, input->resp_gpa);
>
>> +	if (ret)
>> +		goto e_put;
>> +
>> +	if (ghcb->save.sw_exit_info_2) {
>> +		/* Number of expected pages are returned in RBX */
>> +		if (id == EXT_GUEST_REQUEST &&
>> +		    ghcb->save.sw_exit_info_2 == SNP_GUEST_REQ_INVALID_LEN)
>> +			input->data_npages = ghcb_get_rbx(ghcb);
>> +
>> +		if (fw_err)
>> +			*fw_err = ghcb->save.sw_exit_info_2;
>> +
>> +		ret = -EIO;
>> +	}
>> +
>> +e_put:
>> +	__sev_put_ghcb(&state);
>> +e_restore_irq:
>> +	local_irq_restore(flags);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(snp_issue_guest_request);
>> diff --git a/include/linux/sev-guest.h b/include/linux/sev-guest.h
> Why is this a separate header in the include/linux/ namespace?
>
> Is SNP available on something which is !x86, all of a sudden?


So far most of the changes were in x86 specific files. However, the
attestation service is available through a driver to the userspace. The
driver needs to use the VMGEXIT routines provides by the x86 core. I
created the said header file so that driver does not need to include
<asm/sev.h/sev-common.h> etc and will compile for !x86.


>> new file mode 100644
>> index 000000000000..24dd17507789
>> --- /dev/null
>> +++ b/include/linux/sev-guest.h
>> @@ -0,0 +1,48 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * AMD Secure Encrypted Virtualization (SEV) guest driver interface
>> + *
>> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
>> + *
>> + * Author: Brijesh Singh <brijesh.singh@amd.com>
>> + *
>> + */
>> +
>> +#ifndef __LINUX_SEV_GUEST_H_
>> +#define __LINUX_SEV_GUEST_H_
>> +
>> +#include <linux/types.h>
>> +
>> +enum vmgexit_type {
>> +	GUEST_REQUEST,
>> +	EXT_GUEST_REQUEST,
>> +
>> +	GUEST_REQUEST_MAX
>> +};
>> +
>> +/*
>> + * The error code when the data_npages is too small. The error code
>> + * is defined in the GHCB specification.
>> + */
>> +#define SNP_GUEST_REQ_INVALID_LEN	0x100000000ULL
> so basically
>
> BIT_ULL(32)

Noted.


>
>> +
>> +struct snp_guest_request_data {
> "snp_req_data" I guess is shorter. And having "guest" in there is
> probably not needed because snp is always guest-related anyway.

Noted.


>> +	unsigned long req_gpa;
>> +	unsigned long resp_gpa;
>> +	unsigned long data_gpa;
>> +	unsigned int data_npages;
>> +};
>> +
>> +#ifdef CONFIG_AMD_MEM_ENCRYPT
>> +int snp_issue_guest_request(int vmgexit_type, struct snp_guest_request_data *input,
>> +			    unsigned long *fw_err);
>> +#else
>> +
>> +static inline int snp_issue_guest_request(int type, struct snp_guest_request_data *input,
>> +					  unsigned long *fw_err)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +#endif /* CONFIG_AMD_MEM_ENCRYPT */
>> +#endif /* __LINUX_SEV_GUEST_H__ */
>> -- 
>> 2.17.1
>>
