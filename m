Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42BFF3CA393
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jul 2021 19:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhGORIx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Jul 2021 13:08:53 -0400
Received: from mail-mw2nam12on2057.outbound.protection.outlook.com ([40.107.244.57]:7905
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229566AbhGORIw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 15 Jul 2021 13:08:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwqIMwetePY5nSjOSeV1gIAosNfuudIT+beQqP/MFbAMBa5uvQAUcQzapuEzjTt5yKdi4n9OeDXMUL36cZFHjBrem3NnfFWWUrxVQOBCsGOPj0WMnYNlvU/zOd1Ke3szrsPMpc0ev+JbYH4VuriK907r01sqVIJIP+nEMsx9oQj6YBfS5q0+sJBtkEJ+Ty0AoRUSR05ILptwwH7eDs48yJRe/hE8Bud0ZOtXJUYnKiMbJeYKtkr4pg0V8Bpgzkk637QfwT6sy5EeZeCk54RoNuiks/SSj2Ty0V/zMHnjCB7cmiKC3lD7nm+nUXkb+j1KHVa4CUxhTxotm1Cw5hSNWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBchjtyFiOJzXoplBaTr2RPMpcVa4WNzxIAh4hTBSWw=;
 b=MrUmNuhmloMmqe6O0ZGqOb3TDrs+G8H579e5e/sZ+bWFGp+RdZtT75UujdY+25IykLeAGsxHL+FdMaJzVKfWSxRa+jK6XgMGv08dRSZYJqUDHKy0fG4Xk2tVnsWgYMwQZszNiudO01M9GTReEjd5YGtS0IczVulEcLxDoXIYTF1mtpT3ljFCplnZ0+cWmx5hr4sfjsLynJ/HR3OjMzftj25f/F8RmZcfKfo9iFyQw3/xRcXZZgt0fCb+f4gmie/uJwFFx4uHWRbZgy3gOlKybqFcuLGOMiJrNS+R1gauZh5wgIVPXKhq3ZqmwerYFSbXUUnGpzFqo3zV3XgSCwUikQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBchjtyFiOJzXoplBaTr2RPMpcVa4WNzxIAh4hTBSWw=;
 b=uNeaYQlNUTRplOE5Mmr/sMrNRiU62mw4iYsqtHvFsdX+aHznY5RPX0+gRevpF2NjruEkXQd8lrOvkKwFlcSa5rB6ahFuOka/1CHx14ANP9ALWNmWW0WYufe30gM8b03QH59UEs61aZOhEIbRdSFiApJ+eGe0Z4Ptgcf5Ctlh9Hs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB4670.namprd12.prod.outlook.com (2603:10b6:805:11::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Thu, 15 Jul
 2021 17:05:56 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 17:05:56 +0000
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
Subject: Re: [PATCH Part2 RFC v4 07/40] x86/sev: Split the physmap when adding
 the page in RMP table
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-8-brijesh.singh@amd.com> <YO9kP1v0TAFXISHD@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <d486a008-8340-66b0-9667-11c8a50974e4@amd.com>
Date:   Thu, 15 Jul 2021 12:05:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YO9kP1v0TAFXISHD@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0024.namprd11.prod.outlook.com
 (2603:10b6:806:d3::29) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SA0PR11CA0024.namprd11.prod.outlook.com (2603:10b6:806:d3::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 17:05:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60421bdb-8d1d-473a-52c9-08d947b2cf99
X-MS-TrafficTypeDiagnostic: SN6PR12MB4670:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB46709FE5F5C3DAC0A8C8DBC3E5129@SN6PR12MB4670.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hljcrTp+7fOTz/aNHBSMOTp4SfklEV3LEFcwbF4/xeswMIETLJsgo7Oj0CF3y5wyvyyR0dPGRGrfao41nxF9M/qVJS5YHJarMMnG5+ZjoFnrSZW6qZEj3mDSDqvoXYdJRv6a6TfI2LdG2JItlqss5fslYv/YVRtPoe9T+T1TWMz2g0XnD55ymFVEqYkAQ+MdctQp34lFdvgC5n7ZQveQLJdHcxXrv9CFwuIT9yA8l98aqApqdtb8Pa9iLt8SbpqJp0UVHf9SbzxCVNZxiHI2IEPVmcEWLAQq3PUmvISkoTFMqz1L9G1tNQS0ZXK+dsgoGdAm1o8WhkfCssEMmqK+FJ6aJmYaoHFU7MF8I+C7uCipx879BnIB2aoeMJ4nawk920z7JsxErSc82uzMylmPky78hUD8vP206l4hrJMIM0krvuTiQTg9L/ccBLKSWgRJRmFuAu5i41QVfsSKHHVjrtF9PdMg7t2W9od3Kpg2gUPwhejP8kX0QlaBa9m5avnIWoI4FbKL7r5yF2blWQ1pj4040eE2qBFPRR7GyFPL4xx05V+/2omvy5j4Oo6vWMgFth9uWrVyYyosTqqYvjWEMoEu6RipnRWQQnXGzg8kXsXrFDTmsL74CIyhtEk9OLn2r674PZ/lw9VmttkSrDg5ie3NL/c7CyIImiEy8F+Tejxx+hvYADRQMiHdZ8pXsFLMYCscLP8WA+0mGK1iFpSFOqFlpNwAAT4Jmpu65Ccz0/MqVkV4kEOAeO9L/EPSd7XeaRSkr2uWYKNo+peKTrOXaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(7406005)(7416002)(8936002)(36756003)(83380400001)(2906002)(316002)(16576012)(54906003)(52116002)(53546011)(31696002)(66476007)(44832011)(6916009)(956004)(2616005)(26005)(6486002)(186003)(478600001)(38100700002)(66556008)(38350700002)(4326008)(31686004)(5660300002)(66946007)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUt1aUZZRTFHOGdSMHVDMkRxb29HeTFFZ3RhY0c2THNLUkR5NFVVQjNBTEJC?=
 =?utf-8?B?WWtFQmxUU1FrK1BRR28xTFNrZytubjBlZmRWR2VZS1o1OWhRNDhPY1U3T2lJ?=
 =?utf-8?B?TXhaSVkwTWZVWlJPdHUzV29oNU4yT2pOSTFLS2dkNTFFcTBrZGlPeFNyYU94?=
 =?utf-8?B?aEpON3RwZUd2SElrd0hrVEFpV1hhWVZwdWc0T3o3d0pXclhKalkzSldJdUM3?=
 =?utf-8?B?c1BvWFZDTWNhSUh6c3ZPekU3cWkzakhnbXdnTjAyRDc5bjFrdGJUSGw0U0JO?=
 =?utf-8?B?WEQ4RWhsWHB2bGdsN3h6M2xxTzBKUEFhYlF6UUhTb1cxQXRDaEVHM2N5ZVZH?=
 =?utf-8?B?WTBvUXB5VTUvNkFFWmIwSnZtRGhFWUFXRHhITVY5UHB5UHBySTNBMTlUcDJC?=
 =?utf-8?B?ZHpxekFwZW0xNnlyTEhTR0lTSHIxYzJwWUpjSHJ2Qm9lMDlFTEN3ZGIxVTlJ?=
 =?utf-8?B?QUlYb0ZJeGZuT1VTOWo5MW8vbWlna2N4enF5WUpISGdHcmRoMHFyTEx2emhG?=
 =?utf-8?B?T3dzcnp3RFZPam1nTWlVMCsxemhTZDJDQjBJSXpYVk03NkFvZERzdys1RFhz?=
 =?utf-8?B?N3lpRlJwcXpkcjhweVhlcWdxQzdEZTgxTnM5NlpoOGxFVTM4bEJrTXBveTFR?=
 =?utf-8?B?bm5Da0dwNktzbHZVeHZ3bXNHd1RuS2h1K1EydGt5aGdBU2Y5eDVjSVA4anZP?=
 =?utf-8?B?L2JxSmV6UThGd01lazZjQldnamVuWWpDSFFuVFNBVXZ3WUJRWU84MlRXbWFQ?=
 =?utf-8?B?Z2QrMmdSbDVQcVFkRm1kTERYK2grMlBkRlkyYXo1TnVUay9sbjNjOFh5SmhF?=
 =?utf-8?B?Y3hPdjBJcEMxdDZldWxZNUphblVkTEdzVllwWjdJcEVPRUFsbU1LaEVtYmxy?=
 =?utf-8?B?N29UamZLSnpvSzdOU3NRME5tUS8vaHV3dlJMaWJ6YnowQkpOYjBKZm9zTVds?=
 =?utf-8?B?UDFaMVh5UWtydFpFa1lIWHpLYnAxWDh5bWx2L0swczdTcEZ3VnVNaVVTeUdG?=
 =?utf-8?B?WjhzUVZnUXlvZHVPUjRGTDA2bFVFb1hST0d4eWFNREtDU0NPV1FYdEp2clFs?=
 =?utf-8?B?L1NJOUQyN0tQcEw1OFRmNjVBbFg3c0xrTW5MWDFaUm04cHJZbVpFVVVRSFJm?=
 =?utf-8?B?YWdZQkUzM25YK1VuZ2RQSFd6eDhGZ2tmZDFPWlZWVTNBbmdLUnVJVnk0WHFH?=
 =?utf-8?B?c2xlWW91dW9uQ0ovcmVNUUFFUGxHYmRNSWFmTHo4YXpzUnlMemcrVzNkRUw0?=
 =?utf-8?B?TTVoN0dvZTgxUG52QVJVYnpPbm5Vbi9VVHdoRkc4Sm9zdktrbndlQmU1dDB5?=
 =?utf-8?B?ZGg5aFBNUGhoNWZGK3VET0UwNlcvVVFka2Q5S3ZwZnI4enBIVVp5Mm45WDBX?=
 =?utf-8?B?R0NuRHRzQUUvd0lJT3gxN29lcitaVTJxZ3ZTeUgrZ1lMcURnYUtaQnBYOVV0?=
 =?utf-8?B?ejgvUWo5M3ZKeHNrWXc4NTFjcEFQM2RDVVprWk5PdjNSMk5oUks4aWl3bTZ6?=
 =?utf-8?B?Uzd3M2NJUVgyWktjaWFGNUsyKzdVK0ZabHVHQTY0YkRSTGVLMG1QNUZXM0pC?=
 =?utf-8?B?RURlQkl6bFR5ajdTM1c3RktvSUp0ZmhBOHcxTElXUUpZYW03dHFZMWNzZ2p6?=
 =?utf-8?B?TUtLaURta2crMFAxN2FlRlIwTW5yOFRWU3JmSEhwVUo4MFNReW9EOWxJaE9N?=
 =?utf-8?B?RzBGN0xtRWNxVVYyMHcvaDU1a1A4bUU2MGt3b3o2MnYrN3lnQ3RPTFdqenE4?=
 =?utf-8?Q?bXWvgtxd1I6bSKIXoYK6hBd6ZAjG4tQYL/BUZsN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60421bdb-8d1d-473a-52c9-08d947b2cf99
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 17:05:56.5796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2XjJfRg1EcaS/54CTwtFCRXAvOz4Riz5ylxJO76c4weszyVLXxUf9fIkDzj6svEDa314EFzGBiVWy9N12z9kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4670
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/14/21 5:25 PM, Sean Christopherson wrote:
>> A write from the hypervisor goes through the RMP checks. When the
>> hypervisor writes to pages, hardware checks to ensures that the assigned
>> bit in the RMP is zero (i.e page is shared). If the page table entry that
>> gives the sPA indicates that the target page size is a large page, then
>> all RMP entries for the 4KB constituting pages of the target must have the
>> assigned bit 0. If one of entry does not have assigned bit 0 then hardware
>> will raise an RMP violation. To resolve it, split the page table entry
>> leading to target page into 4K.
> 
> Isn't the above just saying:
> 
>    All RMP entries covered by a large page must match the shared vs. encrypted
>    state of the page, e.g. host large pages must have assigned=0 for all relevant
>    RMP entries.
> 

Yes.


>> @@ -2375,6 +2375,12 @@ int rmpupdate(struct page *page, struct rmpupdate *val)
>>   	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
>>   		return -ENXIO;
>>   
>> +	ret = set_memory_4k((unsigned long)page_to_virt(page), 1);
> 
> IIUC, this shatters the direct map for page that's assigned to an SNP guest, and
> the large pages are never recovered?
> 
> I believe a better approach would be to do something similar to memfd_secret[*],
> which encountered a similar problem with the direct map.  Instead of forcing the
> direct map to be forever 4k, unmap the direct map when making a page guest private,
> and restore the direct map when it's made shared (or freed).
> 
> I thought memfd_secret had also solved the problem of restoring large pages in
> the direct map, but at a glance I can't tell if that's actually implemented
> anywhere.  But, even if it's not currently implemented, I think it makes sense
> to mimic the memfd_secret approach so that both features can benefit if large
> page preservation/restoration is ever added.
> 

thanks for the memfd_secrets pointer. At the lowest level it shares the
same logic to split the physmap. We both end up calling to
change_page_attrs_set_clr() which split the page and updates the page
table attributes.

Given this, I believe in future if the change_page_attrs_set_clr() is 
enhanced to track the splitting of the pages and restore it later then 
it should work transparently.

thanks
