Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668034561AC
	for <lists+linux-efi@lfdr.de>; Thu, 18 Nov 2021 18:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhKRRqb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Nov 2021 12:46:31 -0500
Received: from mail-dm6nam11on2083.outbound.protection.outlook.com ([40.107.223.83]:39291
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231270AbhKRRqb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 18 Nov 2021 12:46:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDM0mca2idXC8kS5dGivULVfpMKkemspEwvR9ySpV4awItV7kwRlq/kIOi0Tema9iXKzDvi2jax3WpfxSJBDJFyRb3k5YuUsCG14oC2EFQMPcqx/W20fHb7HOmD1IUW5fw2AFDuJe5xTe4eIef1QAdWZ/Gtz9Zmz0ykVLIqJjlWIq4WFEUju/+k7ndf0uitcrEzG85/xK2Fc+3mJAdipErUdvOReDgcevkFRAgi2J5oUILj4w8Y+STIAHXie3A/bmX/tG+ltwyMx3jx8P4H5PQqhV+9ZThSsFrlPyQw29dtyVO0ZgAyn7XYAMXDLcuSlWpof4muCa8eqPTkM6/CzMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzah93UaCkHBw7zfFlUcefzjgI6IREtSHaFfGLw236w=;
 b=VH02foOzq0i+uGm3c7DQ54Q/YKbESbIS6l7OIeCfoDYclQC6MnZG97TNZqWEYxoItwP/rJemX1sRRUt8PD0r3L1oCm57Lc7YdiSO0keOEinMshZXRqgGdkfHNJSy5G+ktW+A+vvq4LrmaVVj+9BgKffP/hBDY4eUye0h01+Uo330j1RZr0+iwRARUZsahhgFDOsff1rX0KGjLECYicgx9pwG6uxjgfqHLzumsU2akw/XPkVEXUqfjdVCFZj7t7m6J7KNZGmxMBsmy5nQUQe0xZ+TRA4Q4Gx4rlZ8UkMU99v9jEjYCReFJZnuue0Wp1aEuHyCnuxjuzbNyAv3timM3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzah93UaCkHBw7zfFlUcefzjgI6IREtSHaFfGLw236w=;
 b=NaoWyv5Wbk7Fbzc+xBdlp6aoC6WHjSXahBxQ3Dn+KujvPCCwio6P8FnO85/1zX1Ksni1HzdDLaByi7pYofO+sZIUOlhx5BcFfL60VBNwiE3m1TjFoPN/SrHeBnTnGmvSmMdUNDurtOgaucZN4/mueC5Y9dGT3ddcEEnYBMK1WL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2542.namprd12.prod.outlook.com (2603:10b6:802:26::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 17:43:28 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::e4da:b3ea:a3ec:761c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::e4da:b3ea:a3ec:761c%7]) with mapi id 15.20.4690.029; Thu, 18 Nov 2021
 17:43:28 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
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
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v7 44/45] virt: sevguest: Add support to derive key
To:     Peter Gonda <pgonda@google.com>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <20211110220731.2396491-45-brijesh.singh@amd.com>
 <CAMkAt6qGASUFv7_bEDd3zrwt2J8kRxKdNuZCGCnsNvnGr4Uv3g@mail.gmail.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <f6214e86-019e-6b34-194d-c2b36001a19a@amd.com>
Date:   Thu, 18 Nov 2021 11:43:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAMkAt6qGASUFv7_bEDd3zrwt2J8kRxKdNuZCGCnsNvnGr4Uv3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0019.namprd12.prod.outlook.com
 (2603:10b6:208:a8::32) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.236.30.107] (165.204.77.1) by MN2PR12CA0019.namprd12.prod.outlook.com (2603:10b6:208:a8::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 17:43:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96655310-a9bc-40f2-b0c4-08d9aabaee0b
X-MS-TrafficTypeDiagnostic: SN1PR12MB2542:
X-Microsoft-Antispam-PRVS: <SN1PR12MB25424B9812538CA4E2951713E59B9@SN1PR12MB2542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/XAZKOcoWU0TmU9HzrWJrQgGZEBR2to30wF5/B0usw/6XDzPTxuc3EOcXVgRV4ioRaBLSgSSDPg1siw7bh2fupYYVoeV3GDl02u8XSV6ReWU+rkkwmZu/J9f0fZgMH2ZsojP1zeJtLVhxEO9IRPpfjmwLD1fDQECkb3B7h6KNjB7xM1ARomIrYqj56WFGI5gAMxhdjUDEcY6LOzDDtdXZciwFFCUTYI0O+E3qJ1xa/7NL+18owjOfRFGxWjn7BFntpzIPmNbcCw4taljBIyktgmb0ZEX/em+ed+npG7XGVP7CvIRQQYYUVHvhHQ3V/mb67f5OuC+M2nUdRUbZbG2MtdlOA1UXBZufyZtrqW4h/BaXCi1IP5wygghns5L4JNKyshnlG5lASGQ6btVyN8bWJIYH7gFcJRlb5ne/dyEWkYZPyVOVqu2gJxtsdW9JAFRwCxIo7DGhG7zkYLVbruKI6phiThr6XIpDUv7XnsoBRiZfVr0MWon0JMfrDbEGSk+/yQUYVrEBIgBxEIqbts830Kfj/KkyrKcnIHcr+bLHBkb44Kdaeq44vOYNqitFYU6I7t/TS5cMV+sHWTd4k34m4pOf+yJankNYOaAjLYqJq/UyBf0ZrslraLFQnsYW39wAf8yFTUxdZWBlAIUrFJvHYzSlWigv9qqSUMDf2L67bJFMd5sjb01Dr91YheTCN4AFBvRaCnn6G1/b1NbgvbQ9hPd6hDwceVbTrKOAawDdQI//aiEAsNV1/99UkXGyvJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(5660300002)(66556008)(83380400001)(44832011)(6916009)(6486002)(956004)(7416002)(53546011)(316002)(54906003)(86362001)(8676002)(66476007)(186003)(26005)(66946007)(36756003)(31696002)(508600001)(4326008)(2906002)(8936002)(2616005)(31686004)(16576012)(7406005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW55eTBIVDljc2phNnJSSExaRk4zSERiRkdtZDlFclhFcGZsajN1ZWZIWXNz?=
 =?utf-8?B?dnN5VVBJQUtrMHcxSnV2TGFrbHRSNzkxc1dpM2JhMlRHMEVPbm5WSlZqWis1?=
 =?utf-8?B?N2lqalRFU01iUlAzbzhPOWxjVEZOa21wVVdCakFxa1J2aGcxbTdRKzF1cURz?=
 =?utf-8?B?eE5US0Y0MitWcGxEYjFKNlQxS3IwdlBRQ0NtTFVYTGlHcHprdHo2Q2NSOHZS?=
 =?utf-8?B?YVlFTHZZVi93LzBLdnU4RUVxZVpnNnloNlFGdythL2orNXNGbXJpVWRFVHVW?=
 =?utf-8?B?Qy93bGZSZmF0RFFQa2kwWVdtdFJ6dEZ1TjhEaDgwYUtXbWV3WmozeWU4VFhG?=
 =?utf-8?B?QjZHZnhaajhIMTFLVlFCTnBnN2JwLzVFbmEveUw5ZHhMbEQ4bjRBRWhIZ0Qw?=
 =?utf-8?B?RHRoQkJhWnZ4L25OTG5renc2VkFEMTFwS3pDOGkybjNUR2w3dlE4ekpXMkZk?=
 =?utf-8?B?TnNWOFF5L3JVQ0sxS29KNXRXSlA5YjJKZ0NmRUNYUjk3dTdid04zQW5NZng3?=
 =?utf-8?B?N3Z3WmV2UzdpdWpmd1g3VFRON1Yvdk14ZXp5QjhTd1ZwVjNEZ1M3V0ZzY3Nq?=
 =?utf-8?B?UGJ5SXhrcHhtZGxBRHp2YUFnZXF5REFLQm9uY2pRR09WVjlJNXRXa09qdnNW?=
 =?utf-8?B?bDhlSUtscFFOVmthdGdQUTJzRE1sTUJvUGNHbythRVlLUC9YSS8wVHlzVFpM?=
 =?utf-8?B?QXRPQ1FNVHY0Q3g5K0hnQzZpMVZiRmVSZ1Z2ZWg5OVpkcjlCMlByZUtnQWkx?=
 =?utf-8?B?LzVGMU15eGhvYlBpSTI4a0pkY1kxM2c5Y0N1dGdmZkNxN2h6MitFTmQyUDhh?=
 =?utf-8?B?ZWFNb0JtVUx1STh5b0ZyQ2JQd3FvWDJPUWtrckYyQ2EraGxUWjFtT2FIcFlv?=
 =?utf-8?B?ZjhSa3FYSm9SWXkra0tZNHFnRHpZalU2Yi8rN2tzdko3NUpmOHJtTkVuK09x?=
 =?utf-8?B?RE80WDB1cVNGNzk0RXQvOFV4QVRMVlV6Ti9RcWxvNFJEK3pjS3VXR0FaVkw0?=
 =?utf-8?B?S1JTVG9LcFRyMDZ5UytGSU5FZFhBblBRclJ4SytyTlloSmpRK1MyQ0xPbkt5?=
 =?utf-8?B?UisxUXlvQk1xLzFjdlp4d0tMS1pEc2xBdXdOSWRjaUJVMU0xUUxKU1N3RzI4?=
 =?utf-8?B?WVFMeWFpYWdqVHF6b090bU1Pd3ZzQ1ovSjlaRk4vZXQ0TzhDSHBya0M4VFF3?=
 =?utf-8?B?cE5DQmhkcWVqc084aFdvQmN0RWFtZW1NS1ErRVYzeDRyWHM5bzhUeG1La1Fx?=
 =?utf-8?B?dUhsNEVoUVF5cHEvR3JWdFZpT2oxenljNjBhM1BJQjNScDFyREgzbjREU1Ns?=
 =?utf-8?B?Q0xLc3pIT2NLSVJRRzNCdDAwUWlQMTlrbUJrd1ZCMEg4eC9SOWMyeUxjKzR3?=
 =?utf-8?B?N2JETDZ1R21YOUx1RE5jcWI4QWYxeHJBekNDbThlVm5JZXRwM1hxVHNTb1ph?=
 =?utf-8?B?bmNkelVwZFBqbWlLeEt5TEFGQ3IyTXRuNVd5V0ZmM1JUWk1kMjJxWGtYSVRm?=
 =?utf-8?B?bHhWOTFkMEp0S0dLVTE0OG12T3BhVHJGREoxSTFtWE1MK2RTc2k0VzgrM2tV?=
 =?utf-8?B?TmlyY3BhNWpzUXp0RmQ3WnNoQnhjOUVTUlRuaituUGsreHpibWJJMEtMUlFu?=
 =?utf-8?B?QjRtWU5ONU1xZG5iOWxiQ3JaN2hHSFRRVlEwUllOSGljOElaUmRXeEs3V2xt?=
 =?utf-8?B?anRUK3FidzVqRXY4RFg4eEdRTWMwSWI3TlVVKzFRb1pubndEYlRsczR5WHJL?=
 =?utf-8?B?T2FFVHg4SzIxSWc5cGNoQ2UyZUowYnREWnFsem5wMzEyUHU2bTRmbjJ2WEQ4?=
 =?utf-8?B?VTFjUGNOUDBKUWV6Mk42dmFqaHpJQ0NhNFBtY2NpNTlVZEgwM2NDVUc5MUFW?=
 =?utf-8?B?bFVWMzFqWXVBNTdVL1NUcEh1TlpoajhnTHpOOFFMTXd3ckU1OFNLOTUzN3M1?=
 =?utf-8?B?U2VoUlNWQnZ5eHBZQkYvYllHK3pFUWxMVzI1VysyWnU4Rk00UWdlNmR0eS9T?=
 =?utf-8?B?ZHNlbGo3Z1c2T3Z0TFlkUWk3NmZRN1BuTVcwUDMvK0pZaVpiU3J6QXlRRk9r?=
 =?utf-8?B?cDluZkpwb0JVN2ZTYytvblZuSzExK0VWcCtvUFBvM2RHUi9XeDZWRGUwOXVn?=
 =?utf-8?B?NDBTUXE1eERxN0JaUVVFdWQ4K0RpckFxcVk2cXk0S3RIUFc5RHNFdGNRN3U0?=
 =?utf-8?Q?Ieh9rciXDsXqmTTewcR0QuI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96655310-a9bc-40f2-b0c4-08d9aabaee0b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 17:43:28.5647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xw4xAZX3xvN1sQME+6CsBLokBqfLTxlNufJTM4j5onzhUCm60gs904048cTpB2tlu7+G4ozssP3FoS/RTd9guA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2542
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 11/18/21 10:43 AM, Peter Gonda wrote:
...
>> +       u8 buf[89];
> 
> Could we document this magic number?
> 

Yes, I will document from where this number came.

>> +
>> +       if (!arg->req_data || !arg->resp_data)
>> +               return -EINVAL;
>> +
>> +       /* Copy the request payload from userspace */
>> +       if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
>> +               return -EFAULT;
>> +
>> +       /* Message version must be non-zero */
>> +       if (!req.msg_version)
>> +               return -EINVAL;
>> +
>> +       /*
>> +        * The intermediate response buffer is used while decrypting the
>> +        * response payload. Make sure that it has enough space to cover the
>> +        * authtag.
>> +        */
>> +       resp_len = sizeof(resp.data) + crypto->a_len;
>> +       if (sizeof(buf) < resp_len)
>> +               return -ENOMEM;
>> +
>> +       /* Issue the command to get the attestation report */
>> +       rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, req.msg_version,
>> +                                 SNP_MSG_KEY_REQ, &req.data, sizeof(req.data), buf, resp_len,
>> +                                 &arg->fw_err);
>> +       if (rc)
>> +               goto e_free;
> 
> Should we check the first 32 bits of |data| here since that is a
> status field? If we see 16h here we could return -EINVAL, or better to
> let userspace deal with that error handling?
> 

I was trying to avoid looking into a response structure to keep the 
flexibility; e.g if SNP firmware changes a response format then we don't 
need to have any changes in the driver. The userspace should be able to 
deal with it and it can check the "status" or a new field etc.

thanks
