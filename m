Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEE643CE45
	for <lists+linux-efi@lfdr.de>; Wed, 27 Oct 2021 18:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237771AbhJ0QKY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Oct 2021 12:10:24 -0400
Received: from mail-dm6nam12on2088.outbound.protection.outlook.com ([40.107.243.88]:15569
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237245AbhJ0QKX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 27 Oct 2021 12:10:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZkkfmJSZ4MSQ4orCajIag3idOkyJVmYMs3TY6VwEz+SVUoSSWiVZqaFDSyQYao0G1L62XgC+1aLgNQQEMMK2xtfmqdA5hjLs44jIq09dloncxpS2l3awZwBwc/04bUaA23t8vEUcQ52L0obKI7wbG75iAUVtJWbs+Iq8Vz3+vH49dDUWKxPZRWaY5WbjBv2Ixot5+3mjObl5I9WCZgh+Cq6AtP4ObFANG0MB05+YqHQzKZaoobXzekt6fBPsTk9Y9HRVFABylgAD4ZpNVzsXG7AAEWNlsaXelilRTXdD5ppdSrTdnGYnwPHiWxe05xkMGgXa+FWvuqPB8HcgLgsng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ilndn4G3qYmm2cLg2qJkpeZiOiaH4HIrsNuvmxP6qWc=;
 b=VEF7QQbuqF5ikfdzDbnTWm567XMxt4zjSBc/UbMZTuXQ/tbY77ywHhUfCVWzGSC1erwLYRQY90rEReddhzylGedEeT+o53my6KmhfImZX5hEeZQlEqG05BxzSezzabvdxuCEVOJDFWkkWoQjCuhPtU8qBSzmMhEjvEfMc7HdCGoncvFB/mhZ4G2j4HDiLbFzYMM4sI3FooDefIjY2gdKBTrDOTGtz2w49thU1PipHkb2oHOmxbrcf2Dvg0wIgQ5aJV4KcGXp3Jq6AI/WD8eUgrsgtXihUDxbzwnMlBxXHJkefnJMJ3Wo1/3Cl456jMNCcM92rmNrekaE0HWhN5Xlhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ilndn4G3qYmm2cLg2qJkpeZiOiaH4HIrsNuvmxP6qWc=;
 b=VhLdXejdRjKfU/X9nezXuTbTv1jkLPKy6BBZFlCPvrChw4Cm+Aei86XwRcfNONZbZD3soaNN/9mEnKbV9I7J1S6RgJNGlDNzHHs0wk08/hS5cuSlGxlPXlDuWIL/Zcv18m0q/1HSEARiXaeJK+k/59RyQ9jawTmMW03DG5FqH94=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4590.namprd12.prod.outlook.com (2603:10b6:806:93::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 16:07:53 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::e4da:b3ea:a3ec:761c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::e4da:b3ea:a3ec:761c%7]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 16:07:53 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-coco@lists.linux.dev,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, Marc Orr <marcorr@google.com>,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v6 40/42] virt: Add SEV-SNP guest driver
To:     Peter Gonda <pgonda@google.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-41-brijesh.singh@amd.com>
 <CAMkAt6rPVsJpvdzwG3Keu3gv=n0hmYdDpYJMVoDP7XgwzvH7vQ@mail.gmail.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <bf55b53c-cc3d-f2c3-cf21-df6fb4882e13@amd.com>
Date:   Wed, 27 Oct 2021 11:07:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAMkAt6rPVsJpvdzwG3Keu3gv=n0hmYdDpYJMVoDP7XgwzvH7vQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0088.namprd02.prod.outlook.com
 (2603:10b6:208:51::29) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.236.30.107] (165.204.77.1) by BL0PR02CA0088.namprd02.prod.outlook.com (2603:10b6:208:51::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 16:07:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71457eb9-f77a-41fd-f67d-08d99963ee15
X-MS-TrafficTypeDiagnostic: SA0PR12MB4590:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4590702F38C4002D89B0B3C9E5859@SA0PR12MB4590.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xnB6zYHBS5jH2luAW2fIt+4pbBL9F5pfTB0QV3r2rlHHJiZm4av/Hg6vP0ZAcWiY/eqNbhfZ5UY/PBURicjAGGK81eBcHmmNzfpzf8yzcc5UeHfS2BT5f8JndWBzXg6Iq4IC9vUkn5hBMPb5Qx/oYrB0QVqpxEbAISSfgScFHB7CxEwq8x/XRkKwIhd3gozxzCQ+FngWhTiKcZmVvmNLQY/tmTmzoy7VZn2lnAohJiAzCxIVnf6lIQUAsOQBVfCY6POCU3/MYgKCqLkhmQlVcnq7PzEEAF27tV+0WfdEnW1pDFPBEhO8A/WBwwDuZ1Qyig92WFxM0gIi6jLc2yGFzqDidAL9cYX9gL+c1LZTVWjn1CHAuZREfxJA7zWQ9yx+bIf79UG6XSYZwm6iRjaXFJv+EVTVypWTnD3xKAgRX+ExYZF7Y/p4P4UNwEUFGIZzzsKsHDEAw35n92Lcr5vVMN6vrXCUIsOi9lhEq1Rp6eCtLCsV1/wtyxCrImhoOjdh/aTgB+6TScEx4uP5yhP68jawJfPTqByzyArMI5MHktesQcj0MJ1OSSafViAwErYpPcXek2QBDtYNFhJxxfohn+Yw5m7fuyjxYRZhV8Tv2fM7GxYJ0Q/k5oJhZjrjryowNWNZATtflCldDHyqSo4MROiKfw5x69VoWHmSGlgXBTBthtU7+aTZ1qrMuPBgzlKPWEJ1vZ+xAwtbGQrnkaTqfOfsELY+VPrrDbLV7xqBXvvyXwGuzMJsuOO8KcJQNXCN2mcYuaIzk9Ufidi7tXw3OPkbpWQFrtunV8t/ahqkTgQCrGDIWS45EryTWlrmzE1F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(44832011)(7416002)(2616005)(26005)(31686004)(6916009)(66556008)(30864003)(5660300002)(66476007)(956004)(186003)(4326008)(38100700002)(2906002)(7406005)(66946007)(53546011)(8936002)(36756003)(83380400001)(8676002)(31696002)(6486002)(316002)(86362001)(54906003)(16576012)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGIvWUlTaHJTbWtQZWJRenlhallhb0FtRjFjeUtRVnI0eFEzMTdzRnRFVjlo?=
 =?utf-8?B?V0E5Wmw4L0NWVEl6K3MwSUd2UEM5Y3J2RXhFenAzZDVsV1kyNXJMNlduL0tP?=
 =?utf-8?B?TzBjZ1hKbDM4Q3VTL1VuS3YxbGRlTjFMUis4cm5QaVpmWlVCWFVoNWlFcTVt?=
 =?utf-8?B?WUVrMzVDa0VEYU1KS2J6TTMvSnFvMFJCc1hIemlOY2xIN2NzRzMyeTVkMXlD?=
 =?utf-8?B?YUxpSVl6anppd1MyM01iVnBmNTdFWk5XM0N2djZlN3hIS0lOdGJjS3hiVjBi?=
 =?utf-8?B?RXgxSXR5NkNZVy9VL2dxa2U1cS81YnUxVWJCUXVsS0xVNURtcCtnR2pZTVpG?=
 =?utf-8?B?eGxBTDE1UjluK25oZWZiMHhBeW91RXR3cU1yWWJ6NnFRYTVyN2ZTMWtvYU5z?=
 =?utf-8?B?ZktrMTNYbGdvb2FHQWh4andHblBSbzVVekNIUm1yUGZNSGt4eDJPTURxeDRK?=
 =?utf-8?B?bEdSQlBYSk1RWVk4Zi9ucyt5UytCUUV4T2E0ZkVILzZuVmNqU3NMWGpmK3NU?=
 =?utf-8?B?WEZxN1E0dXhJQ25lcnZjbHJYTVRoODQrdkZSS3o5WjhQaXl4SXNqZ3Z1dkxH?=
 =?utf-8?B?eEdkL3ovbnBDNkY4ZHVlY0QrUGJpbnM0TXUweTgyOVF4RFpWNFpROEpNR1dh?=
 =?utf-8?B?eDlvakllNHBTQ1J3K3VGQzEzVWcvaEpzU1BTNXdaWXBtSHowdmtGcnZxR0Vm?=
 =?utf-8?B?bGVYYTcxZTBFNkJzOE9QUHo3bWJMZzh3S1FlandNakxpSkJkUkU4dnNKWG1l?=
 =?utf-8?B?YkJla3ppN1NDS1g4eHAzUGZaOXlaYyttK21laTl6TU81VjNJbVJ4UXlHaXM5?=
 =?utf-8?B?THRHanZrSXlWZ2kzTFROZUdUSGpBSVZhaFk3OFgxQUJsQUxXeEJnOWxsVHdH?=
 =?utf-8?B?YTJEejFrNllyeElXQlJ0bGxvME5mbitNckNWR3BUTlRzMnZlMWQ4NHNpSVdN?=
 =?utf-8?B?OHJXRzE1NGNBbjFRWkg1MEJVM3BMWkJSZksxelRjbnJsenRtZW51OWJRK2Nj?=
 =?utf-8?B?RDh0K3duSllRY1FQdlZ5SVhHZU9IZzZYalhyc1VaQ0dyalFsdEhxNGE4Q1Vv?=
 =?utf-8?B?d1FRRFIvRFlMZzNKdGdhOGRPMHltbVdjcHZpNDdXemlnbDM1eTBpWGl6ODlU?=
 =?utf-8?B?Tm90c0dYVElEQ2ZuSWNDREozWGtkeEhXclhEc2g2elRRTE94TG1SNkRSSUxv?=
 =?utf-8?B?WUIrYUdWRktEN1RBRUpiS2tidDl5bVcwcjgyK0daSytsV09kUEJuc25VMGpr?=
 =?utf-8?B?dXBnZjYrYUFJZlNybVBQdTRhNjJ3Qm93My9CTXRTQXFwWWZ4Q0JZQ2s2U2wv?=
 =?utf-8?B?Y09WTkVwSnRZWmFESU04ZDVxSG9nZVZQY2wvd1RQZHFCYWpjR3BLRzJ6V25D?=
 =?utf-8?B?MmFjbUVZMDBpUFdwcjBHTFFrZmQ4cCtDWGVadDd1TkNMeVdlZjBraWJISGFX?=
 =?utf-8?B?WlZKaXowWUE1NlltcE9nWDRjZjJpbHRrWGdyL0xqVnlBVXJzTFpBMS9KZXNt?=
 =?utf-8?B?OExGTVhoLzI2YzVlWnlrTWZSa3REVjJvQkthZFJVanVTOG9hcEJyWU5zQ282?=
 =?utf-8?B?TVJWWFBQQ0pzWThZYzBzZ0JNQjFacmhlQkZUMWQrREVmc0pCRkFqSWl1YVBp?=
 =?utf-8?B?NGx2NHNkNzhvU1FYTXpHbXJVcnJQaFBJRld6UVNOSDFESElkb0pyM0JzQStk?=
 =?utf-8?B?VnRqRVpMazdULys1aWdQcVNvVDVyY3RsaU9VWE5NRGZ4dzBZSXl6MHM0Q1dN?=
 =?utf-8?B?bFk3dmZIYlhsRUlSeC9kWTUzVUxSK2JGVlhRMVhyWlIxRytWY29xTlUvc2hy?=
 =?utf-8?B?ZXN1L1grQ3U2QURoc0NoNXdaWHRYVXRieVdDWG5IOFMzZ0hSMUtDN1hEL2t4?=
 =?utf-8?B?c3dDcHZ5V3I2YWFUZzNFaXdWZVA1ZElnQzNWZC94ZjliUXdoYzI2M3NJcm1u?=
 =?utf-8?B?emxVZFRuOHpVcTdpTm9NYVBhbHJ2ZDE5bVJ4WDVkY2h4WE5NRFdRNHBJSDZi?=
 =?utf-8?B?TlVxYmdGM1RTOENrZE5XMGNGU0graDJMdHJ0eTlVcnVrcVlPaVVMRWdsbGRF?=
 =?utf-8?B?MW5qMzdPemRCRUdiWWl6bkNKODBNMGpSajFLR3UxNEE4THFBbW9UdE1keVQw?=
 =?utf-8?B?bXNhcnoybUd5Y0dYREFOSTN6dlBwY2dXejNUYVZMTGdXbE9rKzVBbmJuRGhi?=
 =?utf-8?Q?o/v8kyWGI6JM+9Ki2c3R87s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71457eb9-f77a-41fd-f67d-08d99963ee15
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 16:07:52.8682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9JIRpPqBsF/5HgJ0yEojTi1m8QaRE+EuCb20dkg+qyFZyAJUpvaTCXc64EkrpFy7rBwDhq1XFxzorPvoOmxdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4590
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Peter,

Somehow this email was filtered out as spam and never reached to my 
inbox. Sorry for the delay in the response.

On 10/20/21 4:33 PM, Peter Gonda wrote:
> On Fri, Oct 8, 2021 at 12:06 PM Brijesh Singh <brijesh.singh@amd.com> wrote:
>>
>> SEV-SNP specification provides the guest a mechanisum to communicate with
>> the PSP without risk from a malicious hypervisor who wishes to read, alter,
>> drop or replay the messages sent. The driver uses snp_issue_guest_request()
>> to issue GHCB SNP_GUEST_REQUEST or SNP_EXT_GUEST_REQUEST NAE events to
>> submit the request to PSP.
>>
>> The PSP requires that all communication should be encrypted using key
>> specified through the platform_data.
>>
>> The userspace can use SNP_GET_REPORT ioctl() to query the guest
>> attestation report.
>>
>> See SEV-SNP spec section Guest Messages for more details.
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>   Documentation/virt/coco/sevguest.rst  |  77 ++++
>>   drivers/virt/Kconfig                  |   3 +
>>   drivers/virt/Makefile                 |   1 +
>>   drivers/virt/coco/sevguest/Kconfig    |   9 +
>>   drivers/virt/coco/sevguest/Makefile   |   2 +
>>   drivers/virt/coco/sevguest/sevguest.c | 561 ++++++++++++++++++++++++++
>>   drivers/virt/coco/sevguest/sevguest.h |  98 +++++
>>   include/uapi/linux/sev-guest.h        |  44 ++
>>   8 files changed, 795 insertions(+)
>>   create mode 100644 Documentation/virt/coco/sevguest.rst
>>   create mode 100644 drivers/virt/coco/sevguest/Kconfig
>>   create mode 100644 drivers/virt/coco/sevguest/Makefile
>>   create mode 100644 drivers/virt/coco/sevguest/sevguest.c
>>   create mode 100644 drivers/virt/coco/sevguest/sevguest.h
>>   create mode 100644 include/uapi/linux/sev-guest.h
>>
>> diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
>> new file mode 100644
>> index 000000000000..002c90946b8a
>> --- /dev/null
>> +++ b/Documentation/virt/coco/sevguest.rst
>> @@ -0,0 +1,77 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +===================================================================
>> +The Definitive SEV Guest API Documentation
>> +===================================================================
>> +
>> +1. General description
>> +======================
>> +
>> +The SEV API is a set of ioctls that are used by the guest or hypervisor
>> +to get or set certain aspect of the SEV virtual machine. The ioctls belong
>> +to the following classes:
>> +
>> + - Hypervisor ioctls: These query and set global attributes which affect the
>> +   whole SEV firmware.  These ioctl are used by platform provision tools.
>> +
>> + - Guest ioctls: These query and set attributes of the SEV virtual machine.
>> +
>> +2. API description
>> +==================
>> +
>> +This section describes ioctls that can be used to query or set SEV guests.
>> +For each ioctl, the following information is provided along with a
>> +description:
>> +
>> +  Technology:
>> +      which SEV techology provides this ioctl. sev, sev-es, sev-snp or all.
>> +
>> +  Type:
>> +      hypervisor or guest. The ioctl can be used inside the guest or the
>> +      hypervisor.
>> +
>> +  Parameters:
>> +      what parameters are accepted by the ioctl.
>> +
>> +  Returns:
>> +      the return value.  General error numbers (ENOMEM, EINVAL)
>> +      are not detailed, but errors with specific meanings are.
>> +
>> +The guest ioctl should be issued on a file descriptor of the /dev/sev-guest device.
>> +The ioctl accepts struct snp_user_guest_request. The input and output structure is
>> +specified through the req_data and resp_data field respectively. If the ioctl fails
>> +to execute due to a firmware error, then fw_err code will be set.
>> +
>> +::
>> +        struct snp_guest_request_ioctl {
>> +                /* Request and response structure address */
>> +                __u64 req_data;
>> +                __u64 resp_data;
>> +
>> +                /* firmware error code on failure (see psp-sev.h) */
>> +                __u64 fw_err;
>> +        };
>> +
>> +2.1 SNP_GET_REPORT
>> +------------------
>> +
>> +:Technology: sev-snp
>> +:Type: guest ioctl
>> +:Parameters (in): struct snp_report_req
>> +:Returns (out): struct snp_report_resp on success, -negative on error
>> +
>> +The SNP_GET_REPORT ioctl can be used to query the attestation report from the
>> +SEV-SNP firmware. The ioctl uses the SNP_GUEST_REQUEST (MSG_REPORT_REQ) command
>> +provided by the SEV-SNP firmware to query the attestation report.
>> +
>> +On success, the snp_report_resp.data will contains the report. The report
>> +will contain the format described in the SEV-SNP specification. See the SEV-SNP
>> +specification for further details.
>> +
>> +
>> +Reference
>> +---------
>> +
>> +SEV-SNP and GHCB specification: developer.amd.com/sev
>> +
>> +The driver is based on SEV-SNP firmware spec 0.9 and GHCB spec version 2.0.
>> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
>> index 8061e8ef449f..e457e47610d3 100644
>> --- a/drivers/virt/Kconfig
>> +++ b/drivers/virt/Kconfig
>> @@ -36,4 +36,7 @@ source "drivers/virt/vboxguest/Kconfig"
>>   source "drivers/virt/nitro_enclaves/Kconfig"
>>
>>   source "drivers/virt/acrn/Kconfig"
>> +
>> +source "drivers/virt/coco/sevguest/Kconfig"
>> +
>>   endif
>> diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
>> index 3e272ea60cd9..9c704a6fdcda 100644
>> --- a/drivers/virt/Makefile
>> +++ b/drivers/virt/Makefile
>> @@ -8,3 +8,4 @@ obj-y                           += vboxguest/
>>
>>   obj-$(CONFIG_NITRO_ENCLAVES)   += nitro_enclaves/
>>   obj-$(CONFIG_ACRN_HSM)         += acrn/
>> +obj-$(CONFIG_SEV_GUEST)                += coco/sevguest/
>> diff --git a/drivers/virt/coco/sevguest/Kconfig b/drivers/virt/coco/sevguest/Kconfig
>> new file mode 100644
>> index 000000000000..96190919cca8
>> --- /dev/null
>> +++ b/drivers/virt/coco/sevguest/Kconfig
>> @@ -0,0 +1,9 @@
>> +config SEV_GUEST
>> +       tristate "AMD SEV Guest driver"
>> +       default y
>> +       depends on AMD_MEM_ENCRYPT && CRYPTO_AEAD2
>> +       help
>> +         The driver can be used by the SEV-SNP guest to communicate with the PSP to
>> +         request the attestation report and more.
>> +
>> +         If you choose 'M' here, this module will be called sevguest.
>> diff --git a/drivers/virt/coco/sevguest/Makefile b/drivers/virt/coco/sevguest/Makefile
>> new file mode 100644
>> index 000000000000..b1ffb2b4177b
>> --- /dev/null
>> +++ b/drivers/virt/coco/sevguest/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +obj-$(CONFIG_SEV_GUEST) += sevguest.o
>> diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
>> new file mode 100644
>> index 000000000000..2d313fb2ffae
>> --- /dev/null
>> +++ b/drivers/virt/coco/sevguest/sevguest.c
>> @@ -0,0 +1,561 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * AMD Secure Encrypted Virtualization Nested Paging (SEV-SNP) guest request interface
>> + *
>> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
>> + *
>> + * Author: Brijesh Singh <brijesh.singh@amd.com>
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/types.h>
>> +#include <linux/mutex.h>
>> +#include <linux/io.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/set_memory.h>
>> +#include <linux/fs.h>
>> +#include <crypto/aead.h>
>> +#include <linux/scatterlist.h>
>> +#include <linux/psp-sev.h>
>> +#include <uapi/linux/sev-guest.h>
>> +#include <uapi/linux/psp-sev.h>
>> +
>> +#include <asm/svm.h>
>> +#include <asm/sev.h>
>> +
>> +#include "sevguest.h"
>> +
>> +#define DEVICE_NAME    "sev-guest"
>> +#define AAD_LEN                48
>> +#define MSG_HDR_VER    1
>> +
>> +struct snp_guest_crypto {
>> +       struct crypto_aead *tfm;
>> +       u8 *iv, *authtag;
>> +       int iv_len, a_len;
>> +};
>> +
>> +struct snp_guest_dev {
>> +       struct device *dev;
>> +       struct miscdevice misc;
>> +
>> +       struct snp_guest_crypto *crypto;
>> +       struct snp_guest_msg *request, *response;
>> +       struct snp_secrets_page_layout *layout;
>> +       struct snp_req_data input;
>> +       u32 *os_area_msg_seqno;
>> +};
>> +
>> +static u32 vmpck_id;
>> +module_param(vmpck_id, uint, 0444);
>> +MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.");
>> +
>> +static DEFINE_MUTEX(snp_cmd_mutex);
>> +
>> +static inline u64 __snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
>> +{
>> +       u64 count;
>> +
>> +       /* Read the current message sequence counter from secrets pages */
>> +       count = *snp_dev->os_area_msg_seqno;
>> +
>> +       return count + 1;
>> +}
>> +
>> +/* Return a non-zero on success */
>> +static u64 snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
>> +{
>> +       u64 count = __snp_get_msg_seqno(snp_dev);
>> +
>> +       /*
>> +        * The message sequence counter for the SNP guest request is a  64-bit
>> +        * value but the version 2 of GHCB specification defines a 32-bit storage
>> +        * for the it. If the counter exceeds the 32-bit value then return zero.
>> +        * The caller should check the return value, but if the caller happen to
>> +        * not check the value and use it, then the firmware treats zero as an
>> +        * invalid number and will fail the  message request.
>> +        */
>> +       if (count >= UINT_MAX) {
>> +               pr_err_ratelimited("SNP guest request message sequence counter overflow\n");
>> +               return 0;
>> +       }
>> +
>> +       return count;
>> +}
>> +
>> +static void snp_inc_msg_seqno(struct snp_guest_dev *snp_dev)
>> +{
>> +       /*
>> +        * The counter is also incremented by the PSP, so increment it by 2
>> +        * and save in secrets page.
>> +        */
>> +       *snp_dev->os_area_msg_seqno += 2;
>> +}
>> +
>> +static inline struct snp_guest_dev *to_snp_dev(struct file *file)
>> +{
>> +       struct miscdevice *dev = file->private_data;
>> +
>> +       return container_of(dev, struct snp_guest_dev, misc);
>> +}
>> +
>> +static struct snp_guest_crypto *init_crypto(struct snp_guest_dev *snp_dev, u8 *key, size_t keylen)
>> +{
>> +       struct snp_guest_crypto *crypto;
>> +
>> +       crypto = kzalloc(sizeof(*crypto), GFP_KERNEL_ACCOUNT);
>> +       if (!crypto)
>> +               return NULL;
>> +
>> +       crypto->tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
>> +       if (IS_ERR(crypto->tfm))
>> +               goto e_free;
>> +
>> +       if (crypto_aead_setkey(crypto->tfm, key, keylen))
>> +               goto e_free_crypto;
>> +
>> +       crypto->iv_len = crypto_aead_ivsize(crypto->tfm);
>> +       if (crypto->iv_len < 12) {
>> +               dev_err(snp_dev->dev, "IV length is less than 12.\n");
>> +               goto e_free_crypto;
>> +       }
>> +
>> +       crypto->iv = kmalloc(crypto->iv_len, GFP_KERNEL_ACCOUNT);
>> +       if (!crypto->iv)
>> +               goto e_free_crypto;
>> +
>> +       if (crypto_aead_authsize(crypto->tfm) > MAX_AUTHTAG_LEN) {
>> +               if (crypto_aead_setauthsize(crypto->tfm, MAX_AUTHTAG_LEN)) {
>> +                       dev_err(snp_dev->dev, "failed to set authsize to %d\n", MAX_AUTHTAG_LEN);
>> +                       goto e_free_crypto;
>> +               }
>> +       }
>> +
>> +       crypto->a_len = crypto_aead_authsize(crypto->tfm);
>> +       crypto->authtag = kmalloc(crypto->a_len, GFP_KERNEL_ACCOUNT);
>> +       if (!crypto->authtag)
>> +               goto e_free_crypto;
>> +
>> +       return crypto;
>> +
>> +e_free_crypto:
>> +       crypto_free_aead(crypto->tfm);
>> +e_free:
>> +       kfree(crypto->iv);
>> +       kfree(crypto->authtag);
>> +       kfree(crypto);
>> +
>> +       return NULL;
>> +}
>> +
>> +static void deinit_crypto(struct snp_guest_crypto *crypto)
>> +{
>> +       crypto_free_aead(crypto->tfm);
>> +       kfree(crypto->iv);
>> +       kfree(crypto->authtag);
>> +       kfree(crypto);
>> +}
>> +
>> +static int enc_dec_message(struct snp_guest_crypto *crypto, struct snp_guest_msg *msg,
>> +                          u8 *src_buf, u8 *dst_buf, size_t len, bool enc)
>> +{
>> +       struct snp_guest_msg_hdr *hdr = &msg->hdr;
>> +       struct scatterlist src[3], dst[3];
>> +       DECLARE_CRYPTO_WAIT(wait);
>> +       struct aead_request *req;
>> +       int ret;
>> +
>> +       req = aead_request_alloc(crypto->tfm, GFP_KERNEL);
>> +       if (!req)
>> +               return -ENOMEM;
>> +
>> +       /*
>> +        * AEAD memory operations:
>> +        * +------ AAD -------+------- DATA -----+---- AUTHTAG----+
>> +        * |  msg header      |  plaintext       |  hdr->authtag  |
>> +        * | bytes 30h - 5Fh  |    or            |                |
>> +        * |                  |   cipher         |                |
>> +        * +------------------+------------------+----------------+
>> +        */
>> +       sg_init_table(src, 3);
>> +       sg_set_buf(&src[0], &hdr->algo, AAD_LEN);
>> +       sg_set_buf(&src[1], src_buf, hdr->msg_sz);
>> +       sg_set_buf(&src[2], hdr->authtag, crypto->a_len);
>> +
>> +       sg_init_table(dst, 3);
>> +       sg_set_buf(&dst[0], &hdr->algo, AAD_LEN);
>> +       sg_set_buf(&dst[1], dst_buf, hdr->msg_sz);
>> +       sg_set_buf(&dst[2], hdr->authtag, crypto->a_len);
>> +
>> +       aead_request_set_ad(req, AAD_LEN);
>> +       aead_request_set_tfm(req, crypto->tfm);
>> +       aead_request_set_callback(req, 0, crypto_req_done, &wait);
>> +
>> +       aead_request_set_crypt(req, src, dst, len, crypto->iv);
>> +       ret = crypto_wait_req(enc ? crypto_aead_encrypt(req) : crypto_aead_decrypt(req), &wait);
>> +
>> +       aead_request_free(req);
>> +       return ret;
>> +}
>> +
>> +static int __enc_payload(struct snp_guest_dev *snp_dev, struct snp_guest_msg *msg,
>> +                        void *plaintext, size_t len)
>> +{
>> +       struct snp_guest_crypto *crypto = snp_dev->crypto;
>> +       struct snp_guest_msg_hdr *hdr = &msg->hdr;
>> +
>> +       memset(crypto->iv, 0, crypto->iv_len);
>> +       memcpy(crypto->iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
>> +
>> +       return enc_dec_message(crypto, msg, plaintext, msg->payload, len, true);
>> +}
>> +
>> +static int dec_payload(struct snp_guest_dev *snp_dev, struct snp_guest_msg *msg,
>> +                      void *plaintext, size_t len)
>> +{
>> +       struct snp_guest_crypto *crypto = snp_dev->crypto;
>> +       struct snp_guest_msg_hdr *hdr = &msg->hdr;
>> +
>> +       /* Build IV with response buffer sequence number */
>> +       memset(crypto->iv, 0, crypto->iv_len);
>> +       memcpy(crypto->iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
>> +
>> +       return enc_dec_message(crypto, msg, msg->payload, plaintext, len, false);
>> +}
>> +
>> +static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload, u32 sz)
>> +{
>> +       struct snp_guest_crypto *crypto = snp_dev->crypto;
>> +       struct snp_guest_msg *resp = snp_dev->response;
>> +       struct snp_guest_msg *req = snp_dev->request;
>> +       struct snp_guest_msg_hdr *req_hdr = &req->hdr;
>> +       struct snp_guest_msg_hdr *resp_hdr = &resp->hdr;
>> +
>> +       dev_dbg(snp_dev->dev, "response [seqno %lld type %d version %d sz %d]\n",
>> +               resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version, resp_hdr->msg_sz);
>> +
>> +       /* Verify that the sequence counter is incremented by 1 */
>> +       if (unlikely(resp_hdr->msg_seqno != (req_hdr->msg_seqno + 1)))
>> +               return -EBADMSG;
>> +
>> +       /* Verify response message type and version number. */
>> +       if (resp_hdr->msg_type != (req_hdr->msg_type + 1) ||
>> +           resp_hdr->msg_version != req_hdr->msg_version)
>> +               return -EBADMSG;
>> +
>> +       /*
>> +        * If the message size is greater than our buffer length then return
>> +        * an error.
>> +        */
>> +       if (unlikely((resp_hdr->msg_sz + crypto->a_len) > sz))
>> +               return -EBADMSG;
>> +
>> +       return dec_payload(snp_dev, resp, payload, resp_hdr->msg_sz + crypto->a_len);
>> +}
>> +
>> +static bool enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
>> +                       void *payload, size_t sz)
>> +{
>> +       struct snp_guest_msg *req = snp_dev->request;
>> +       struct snp_guest_msg_hdr *hdr = &req->hdr;
>> +
>> +       memset(req, 0, sizeof(*req));
>> +
>> +       hdr->algo = SNP_AEAD_AES_256_GCM;
>> +       hdr->hdr_version = MSG_HDR_VER;
>> +       hdr->hdr_sz = sizeof(*hdr);
>> +       hdr->msg_type = type;
>> +       hdr->msg_version = version;
>> +       hdr->msg_seqno = seqno;
>> +       hdr->msg_vmpck = vmpck_id;
>> +       hdr->msg_sz = sz;
>> +
>> +       /* Verify the sequence number is non-zero */
>> +       if (!hdr->msg_seqno)
>> +               return -ENOSR;
>> +
>> +       dev_dbg(snp_dev->dev, "request [seqno %lld type %d version %d sz %d]\n",
>> +               hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
>> +
>> +       return __enc_payload(snp_dev, req, payload, sz);
>> +}
>> +
>> +static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
>> +                               u8 type, void *req_buf, size_t req_sz, void *resp_buf,
>> +                               u32 resp_sz, __u64 *fw_err)
>> +{
>> +       unsigned long err;
>> +       u64 seqno;
>> +       int rc;
>> +
>> +       /* Get message sequence and verify that its a non-zero */
>> +       seqno = snp_get_msg_seqno(snp_dev);
>> +       if (!seqno)
>> +               return -EIO;
>> +
>> +       memset(snp_dev->response, 0, sizeof(*snp_dev->response));
>> +
>> +       /* Encrypt the userspace provided payload */
>> +       rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
>> +       if (rc)
>> +               return rc;
>> +
>> +       /* Call firmware to process the request */
>> +       rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
>> +       if (fw_err)
>> +               *fw_err = err;
>> +
>> +       if (rc)
>> +               return rc;
>> +
>> +       rc = verify_and_dec_payload(snp_dev, resp_buf, resp_sz);
>> +       if (rc)
>> +               return rc;
>> +
>> +       /* Increment to new message sequence after the command is successful. */
>> +       snp_inc_msg_seqno(snp_dev);
> 
> Thanks for updating this sequence number logic. But I still have some
> concerns. In verify_and_dec_payload() we check the encryption header
> but all these fields are accessible to the hypervisor, meaning it can
> change the header and cause this sequence number to not get
> incremented. We then will reuse the sequence number for the next
> command, which isn't great for AES GCM. It seems very hard to tell if
> the FW actually got our request and created a response there by
> incrementing the sequence number by 2, or if the hypervisor is acting
> in bad faith. It seems like to be safe we need to completely stop
> using this vmpck if we cannot confirm the PSP has gotten our request
> and created a response. Thoughts?
> 

Very good point, I think we can detect this condition by rearranging the 
checks. The verify_and_dec_payload() is called only after the command is 
succesful and does the following checks

1) Verifies the header
2) Decrypts the payload
3) Later we increment the sequence

If we arrange to the below order then we can avoid this condition.
1) Decrypt the payload
2) Increment the sequence number
3) Verify the header

The descryption will succeed only if PSP constructed the payload.

Does this make sense ?

thanks
