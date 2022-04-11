Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960AB4FC471
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 20:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242751AbiDKS5x (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 14:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349330AbiDKS5o (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 14:57:44 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB8619C0D;
        Mon, 11 Apr 2022 11:55:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDSvZGPgYZNM9yv0u5QCBUma4G33eW5fO92Sd4v6Gfe6lYAFrP/4vTnc7+XAw/bzLtiLZ1jzXew+x8kNz2H5v98hbeYYwHx16C2A22dPF4eyqzxxevU+ZLFg69YdtUxNWzoSCEwrH2UCFbs/JLANMvDj5F5d2sR+M3Z4FD6it7G/4gy51zDvvbLrF8C6h9v9ZfwCfa12aKmzfprG7XrSDgdzizXibL5Rs0EDfW7Y1nCVuCIB+8SPEXkw899T+kcWFk7TQD8LTYpYtmllGQVCartpHads3xtzLwLhIFaUBiGeX6je4O//oUkRGG1v+wFQZGNlRZqcNAfdPLkUjI6G2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oz3Ab3ZvOzc82UVaAfCiGzhOGxr5z7MSw3fYf5ItRmU=;
 b=XDizi/IrSvI6lxCioQ1MCcYYuDaYxgBNkzP3obK7U+Fnp0VUK5GWVQzS99lnffk3/hR4vM4jSNLgND+ZbobrnoGLC3BDDY+IUHXlOmqPq5iItgUsO5n64VZXjHySCGbTIf8fhrCfatGhNBEhxNl/cU82G6coYHasRWYRsYot4nseLP26jrWcWnjVvukAVDYTmHWdPybnn/8KntPxfcGhcgr1iXs/2c08lDqE/qCv/LLxTkRl6Q+ekC6+LWmdZabc9/2OV4Um70zQnfgqOxavkcmvnHqo36rqy+JxwTGacKV0seA+2c9NPCN+9yjjmfF6u5ajT5JV/nk43sqa5gqyKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oz3Ab3ZvOzc82UVaAfCiGzhOGxr5z7MSw3fYf5ItRmU=;
 b=lXr17CNWLRPasEDfahSzlwxMp/4BKOtDyFn2yqf8JPUTAbwPds4WwNYQB8qBAjR4FWHMFkFIhjcKSEhoz0S2xyuuqJobH6o+s3WmIyLQPPfkSkBqC4Jl87kdLbRz8B0W/xJhTkMZYtN/e86NV2GH+mh2To2fGWmytVq7ItV25yE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MN2PR12MB4271.namprd12.prod.outlook.com (2603:10b6:208:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 18:55:25 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1092:2d0b:9aa4:30]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1092:2d0b:9aa4:30%5]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 18:55:25 +0000
Message-ID: <b33c1fbe-a7b5-f5b0-5dc6-f017f5cfc7f4@amd.com>
Date:   Mon, 11 Apr 2022 13:55:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCHv4 1/8] mm: Add support for unaccepted memory
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-2-kirill.shutemov@linux.intel.com>
 <93a7cfdf-02e6-6880-c563-76b01c9f41f5@intel.com>
 <20220409175210.xik3ue3shpagskvi@box.shutemov.name>
 <adc87911-e1f2-4e2a-2394-17ee9213ae3e@intel.com> <YlRPdQP5c1DQqZeN@zn.tnic>
 <fae338db-f892-b234-6918-227219e45cbe@intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <fae338db-f892-b234-6918-227219e45cbe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0032.namprd19.prod.outlook.com
 (2603:10b6:208:178::45) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e60ab51-3eb8-4557-1811-08da1becd605
X-MS-TrafficTypeDiagnostic: MN2PR12MB4271:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4271FB90AA253B1CDCB66C43ECEA9@MN2PR12MB4271.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8JzhQk6FIwJV08TejMPuL6xEibSWYUOFEvYncujv3SYEgGLXU9ZvLW1MpJPWnE+Hm/Ub2GP7F47NWFGMLwDgyDIgB2v/jRcXyiYGboOubfdkN93D8pU0PkQkczSyjK6eqWzSo6dkRQ84q8iZH9l6lDpQSJdeR8k/NS7BKXrF2iK8ZRrgFqHv1BRE3C4Ei+BeQagWytxP+qu18ih2FlUsFd2/jH/T0MOFcotHxImGNznbHkgQ/0wNZ0pwvcdG4mo0Z+Z9MQuCdR1iMJwDZq1S2YPXW094eXUHDFDuXCSIbOcFccr0SF58TI5UicnCq7cdW8czaqwjtDoKWTBU+UrndEd1YWyx8KW+ONav21xrdgc8vOr2gQfXBD6IOJxIAXLfMK9lzbEFky7a1C0gnx0l5DeMeR+h+sabOJjzmvNaBLmiAgbYQgV7WgPhFgXXdNhxwl+0URnbEr/sjcvz2gawNawdWmK+TduL1/gdyFSiVaiO8U8eaC8uqt0cQFvu7Q3CloSfk0SQJBVRpTQruCCdJip1l29htcui4S0UkpUuUf15qv5T9nkHbK8ia+nOeP2ekrYOnlKnkSDDRa0hTrBs2KNFDZh4jKjqSzd1oOhYhCrMveWcPlrcfs+W+o0aBwO1WjMRdejGoV2xMNhIxr9wWEUR1wL4KTtSVsktaoyY/Iwg7y2Q9jtcMcv4Y6iOxD1S+X4XO90v/T0EiEQgv5PjYQE3rqVH5y4BZ6fX50z10bLCk1KGqzpRqiZbwrp9RfyN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(66556008)(66476007)(66946007)(8676002)(38100700002)(7416002)(186003)(86362001)(31696002)(5660300002)(2906002)(83380400001)(6666004)(6506007)(6512007)(53546011)(26005)(4326008)(2616005)(6486002)(316002)(110136005)(54906003)(36756003)(508600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjJZaDhMUXdpeTNieUlYTUt4VkJtM1pXcG4rb1ovZnJ1UkIvNGY2eHNLVm5s?=
 =?utf-8?B?RVdZbzkreE1kbktqT1RuVmUzSWxnR3dleU5GMElpRUlhNTJRdHZqSjZFa2hK?=
 =?utf-8?B?YzJWVUJOSkJyam9ob2l5UXR6QU5razBDeTdwMWhpRHp4U01DZmEzS2N2VXEy?=
 =?utf-8?B?V2hoSEZVTWhGT1ZSU09Jdit2QlltK01wOWxMUXB2ckpDSU8wU21wNW01YWtz?=
 =?utf-8?B?Zm92eEVVWWhTZlN0Wnplb1VTbnZhOVJ6enZpQnhoQloyVnZRa3NPdmd3UjR0?=
 =?utf-8?B?SXRHOHk5V2lKMnkvZmpIM2ZWaGRwV25qOXpScXBPWk14MnNNL3NpQkZ1TkFh?=
 =?utf-8?B?NkR0VmFZVUJydWZ5ak9TRS9tM1pCN1VWSTY1M3hzWFMwTG8vTWRYQnV3K1JS?=
 =?utf-8?B?VUNleTgrSGNyL0NnVisvMTBGV2pWL2JGdzdoK0owVDNUeU1ObTZ2U2dhT0ln?=
 =?utf-8?B?Zk5BSG03U21jRmpWNGZGNnVzU0xoK2pXZlBycC8zMVV1aWZ3SmZudHdScWVV?=
 =?utf-8?B?dnYxaWhXaXNxODRpVStMSDBmZGZCSmJWb29tek1sNDNnRXBOMk9UMytaSnk5?=
 =?utf-8?B?VjltK0RBMm9qWGlMYjNiS2ptbllyUGpUVnBiK0x4eWh0eGFOd2tReUZZQ3M1?=
 =?utf-8?B?OXRRL05PVi83bzlYVmR6d0dYaStBSkdzeHhubVIwbHk4Ty81NWd4R1hHMEU5?=
 =?utf-8?B?RStkN3N5bjVyRVI5eFcwVUNNYWpDZDRJUDcwK25Ic3pocCt1SW1yajlxVkFp?=
 =?utf-8?B?TEM5bys2RzFCY3NncTBxUks0c25QSkV0UXJwWXhqU3FkUjIvcmp2OWwxUHU1?=
 =?utf-8?B?TGJZd1FDUmlGRHZyZjRwTzVlUEVVdXFEa1Q1Qkl1eEN1bkxTYnVaSE1pKzd6?=
 =?utf-8?B?ZVZYUEE2TEVKcG5QOGpzNEdES0VmbUVEbFE0TWdoVXh2TWo2QUxuVXZ4ZDNz?=
 =?utf-8?B?VWxwOEE0Y2dBQTNibG1oa0R3OFZydXhkS0NCS1dwajRXWlljOUNwNWRlREg0?=
 =?utf-8?B?WjFQcVFIVVJFN2JnRm5WcVV3b25MSWo2M1ByNHBUeE52R2hRclFIVHdoVlpG?=
 =?utf-8?B?b3U2c1UzQ0RZdjRRSVdVdTEya1dYQmhqd0FIRnYweCtLQmM5RmMzazFUNStY?=
 =?utf-8?B?eHlodU1ac3Z1c2JCZmxOZ1F2cUhoN01GcGpsR214ZjdpYTR6V0pHRFVYa0Vq?=
 =?utf-8?B?REVZd3REdzRTSFVyMzMvbS9Yc1FqQ1pzc2t2Z2VlelRwMW1oZS91SmZyc1c4?=
 =?utf-8?B?eWUvdlVoRlIyeVdEaFU0QjNDeDRYY054Y1dBVXlRWG9qUHQ1TFBLUlpsYTN5?=
 =?utf-8?B?TzZJN2t6Z2Zaa2xDeTdFT2hQZ1JrZzJFVVpzbU9UTFdwSWNBbW9VVTNCTFpB?=
 =?utf-8?B?TGJ2QUJ3NTU3Y29vMFlaNzBEdjZXRytXYnNuajl0NXR6MFYzaW9OSkJIQlIw?=
 =?utf-8?B?dmp0YVNKRzFYamduQklEclVSdnRWK3ZiM1phOFQyaHUzVU11a091SjgvSE5l?=
 =?utf-8?B?Qm0yOEVtZXVJQ0pUOEx0KzVFZWZ1RTZBYkkwMCtZK0F1YkJ4ODAxeWdGdDVR?=
 =?utf-8?B?Z2xOOUsxdGNWUTNPMENmcFI2OTUxUFRRRWlYUnRwQkx2VjcrYTZJbmszVWZF?=
 =?utf-8?B?YVlEUlVVL1VZTjdCdWcrMHkxOWpIVTQ4dkZpdEF6YUk5YlBwMG90aVBJMXlI?=
 =?utf-8?B?dk5wUzVreGRXMFkvRkxUcGpEalE1MFJOKzBIL3orQk1xeEVYV1FpTzF4RnFy?=
 =?utf-8?B?ZGxSMkYwaHhCRWZ0blZ6MW4ycTZZNkRrMEoyMnFwNGgzWDZubklKQTdZclNI?=
 =?utf-8?B?WTVQM2piN0JSa3VaSHJScGt1cm9hRnNIbmF3MVU0RkNOL1RLWEt3VHBzWnVQ?=
 =?utf-8?B?aUlnR0dYSmdua3JWUnJvanpqYlNkdFY1Yng4S2VrcGFOeldzdDZHSmRteDZL?=
 =?utf-8?B?S1pydkhhMDNscXBveGZRVDc3QmtKc2VyTWlzNUZoN24waG5waHlLWkREbCtm?=
 =?utf-8?B?NDVpcHpnVXZQeDBRb1djdFFNYTFuc2ZkVlloL2hZRXdNZjZDc09SME1ZMWVL?=
 =?utf-8?B?ZWswcGFoSko2czdoUTZXb0krS0xoSk1IemxhNi91Z2RFUGVrcTBJUWhFZm9O?=
 =?utf-8?B?OGVqVDdSUnJSOW5yN0VLcDF2SEp1cGxBb1o0VGlQd2RBUTAvNCs2MHo5L1ds?=
 =?utf-8?B?Y0tjc2lYREsyKzVPNXJpTmQ0ZXRVR2phOU9DSW9ma2xZRlhCb2xLWENVSFNk?=
 =?utf-8?B?dFhudEY5NHhIZ1JTSUREbUpKWUpLUmQ3bkxlQTR6SGlwWGFrV1VZaFg3dzMr?=
 =?utf-8?B?T1RxN09BKzI2SnFkR2xvbmN2RElBZVM0TzZGY2owMUYydFRPdWU2UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e60ab51-3eb8-4557-1811-08da1becd605
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 18:55:25.1216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtTUfUagcansPbCRXDxWyIdVCVhSOHCYLWEAHAKwkwQcrtlIXvFyciqCzc+SPpUlgOlhbFOYbNKoodkcdrmIMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4271
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 4/11/22 11:27, Dave Hansen wrote:
> On 4/11/22 08:55, Borislav Petkov wrote:
>> On Sun, Apr 10, 2022 at 11:41:57PM -0700, Dave Hansen wrote:
>>> Let's just call out the possible (probable?) need for new ABI here.
>>> Maybe it will cue folks who care to speak up.
>> Err, why would you teach the user to go poke at some arbitrary sysfs
>> nodes when the accepting code can simply issue a printk from time to
>> time
>>
>>    "Guest unnaccepted memory progress: XX%. This slows down operations at the moment."
> 
> I guess that's not a horrible place to start.  It's also not *horribly*
> different from how guests work today.  If hosts lazily allocate RAM,
> they'll see largely the same kind of behavior.
> 
> What ends up determining how much memory is pre-accepted versus being
> done from the guest?  Is that just a normal part of setting up a TDX
> guest, like from the qemu cmdline?  Or, is there some convention with
> the virtual firmware?

With SNP, some memory will be accepted as part of the LAUNCH_UPDATE 
sequences that the hypervisor performs, but that is not all of the guest 
memory. Once the guest is started, the (initial implementation of) OVMF 
SNP support will accept (PVALIDATE) all of the remaining guest memory. 
When the kernel boots, there isn't any unaccepted memory.

Once support is available in the kernel for unaccepted memory, then OVMF 
could be updated to only accept a limited amount of memory and pass the 
information about the unaccepted memory to the kernel through the EFI 
memory map.

The approaches would have to be measured to see which ends up being the 
best one. The GHCB specification allows for lots of memory to be accepted 
in a single VMGEXIT (world switch) vs performing a VMGEXIT for each 2MB of 
memory being accepted.

Thanks,
Tom
