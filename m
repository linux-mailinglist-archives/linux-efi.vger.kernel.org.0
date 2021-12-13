Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453FA4730F1
	for <lists+linux-efi@lfdr.de>; Mon, 13 Dec 2021 16:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbhLMPzf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Dec 2021 10:55:35 -0500
Received: from mail-dm3nam07on2067.outbound.protection.outlook.com ([40.107.95.67]:12288
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232606AbhLMPze (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 13 Dec 2021 10:55:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luiEGDTH9NGLVOcMV6YEQ0zcD1LPCrXN+MzBjchV0bDVTJyJSG1cptS3/ZR/r1Xk9p+QbldaWOwYe5lLnIbZpchF2rB4Gq/xHtyLvdk33jSvKmfBPH3yNbbykzmdQQRTLXReKrvqvJTRyqhIWm3tpD9SXV5hXFC3BOEOWFSrQtTqtyWc+Xe1E8yUzY4aZ2caBkL7vTFVgnIZLaFeJjUl9LE5oOlmJtmR7UO5vWBgz1xlJjB4hjAHx4vUIdnTxA8Q6alTjqAa7wnFbiPVIkjL2vaWvJGVV0KQ09u1mKPxAoGN56MYqSlZO768rthO/HYlBCg1oi36JjJ3vc6rO1ZnzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxIVFxYZPdmVHJMWZMgMNB6CgcvCiHCJuuDMXfRVIlA=;
 b=IAj+XoXGfE0jb7RRcxQS1neRZNcdvdMczTmYg1VWpDPv5yUo1HsGG2LMXF/iCY8LmtzJ7Mlaj4ht5RVyGdgCAJG7tBdDu/E8kSVRr/bcE+cpu99MCsfSGMK4ycOXhFEC27eysqLBQJj7fE/12yBpRDo5Xv0M9CXx7zVB1iZP0VJ8SZuyDqwi3skqpkgLbHNDDboOVAj/2VFWN/cRZWJAhT6LjXVe0Q8U6nIm9hdWoEL6ozho1iqAaFkWTIlZ1wq2AcfU0m2AVBouiQM71VNJcC7idgImI1OfD7KgdNhBd1Dh+fsmwwvXEcsxZoQx00EFwWM2iVrEjhc4yLg/Im5U8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxIVFxYZPdmVHJMWZMgMNB6CgcvCiHCJuuDMXfRVIlA=;
 b=oVEAJQ8m5Lf6t8ZpyLhKMHA+KWqZ86AUA3xXzjjsW70IPvHS5tfkn167g8Bl/WQmORXaKwpNSyExz2Gud2iwZEoXhpMFtM3uwAROY68maIpk5HMYQhZyQ670okb62WgktbilehDzqInry7RFSF3vRXntaMoxETDLxoMzPnsC888=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 15:55:32 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c%6]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 15:55:32 +0000
Cc:     brijesh.singh@amd.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 27/40] x86/boot: Add Confidential Computing type to
 setup_data
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-28-brijesh.singh@amd.com>
 <1fdaca61-884a-ac13-fb33-a47db198f050@intel.com>
 <ba485a09-9c35-4115-decc-1b9c25519358@amd.com>
 <2a5cfbd0-865c-2a8b-b70b-f8f64aba5575@intel.com>
 <f442ca7f-4530-1443-27eb-206d6ca0e7a4@amd.com>
 <48625a39-9e31-d7f2-dccf-74e9c27126f5@intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <3eef1d45-eafc-582e-8896-6aaf741d6726@amd.com>
Date:   Mon, 13 Dec 2021 09:55:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <48625a39-9e31-d7f2-dccf-74e9c27126f5@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR11CA0021.namprd11.prod.outlook.com
 (2603:10b6:208:23b::26) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c2d969c-ccce-4399-ec0f-08d9be50fe5a
X-MS-TrafficTypeDiagnostic: SA0PR12MB4495:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB44954EA3A97B771E0C094B07E5749@SA0PR12MB4495.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u0UP3ps1BFLV8zEWIkRARA/alH8qIxDBpAxZPscVUqg+b4u0xKayUKA/eQURUFAOOYc3D8PhkCFrVfAulWeCoDsEcnpu9p9mGkZjJPSCqy8sHGuHrBGOcBsRD+oIchzvMbazfCfzAB+RNJku4F6weu9zHoNLg9B9n/0xYbXIUXvmDZhB6auoP2SOm3Ah5Yn7lDcaVynNfmGS4EDKcC12vl+TPrvUTDcQBY6VuuxI+7SzizESeqOZFVc5Wgj9ZaJbJmb06vzAZXDSE1mCzj/6AgVw9i7GRuscHZYRqo0l0BcvaSVV6uI01c6CmfPeYGmIJ6Wn6ir2rTdAngG+/GkpFr8u2L0Y61mmkKXEHzDFln40x7Is0FFgkcR1VPTl6g32RUUbdiNB9VmV1+d1ZbEUAeSlQcZtdIzI0IMgmgJ1IX3dhz0DSfATDgqbK6eVqIgUIDHl2EDDxhQv4x68V/9IsaT++ehharjoW28e5Ou9KlPWPsuaCHh1O9ukVd8bqc8v4a1y8pmrnnwtAMOUwccZRcfBUnWv+ba3TwuwbULjkybE08cLk3mUukOLoA5/cOU3M0Z/csD2BWLV/k8HwvkuF4wmlemEF0MJMRDc6DAvm4Kk/JP86IpY46yseJCeudm2tsgjegcmqnahEU6VzDgtD/I/rJCCFpdtAc0WhE91+OazG/m7YaBD4r9cZwrjKX4vVGBQhk5y0N6VkG+JnikZOwcNw7VCokyrQ9sFCdQXQsA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(7416002)(508600001)(7406005)(6512007)(6506007)(186003)(26005)(2906002)(31686004)(6486002)(6666004)(8676002)(66946007)(38100700002)(54906003)(66476007)(66556008)(31696002)(86362001)(8936002)(5660300002)(36756003)(2616005)(4326008)(4744005)(44832011)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTJvdEUyNVlCcTZZeDRYb1E4Z3BQOUFNUWJGeWVJLzgvYWlNZzhoenAwUGlZ?=
 =?utf-8?B?d0hDZ3k4eE1RbGtIQmJHWmNyTGJFNGFHcHdyODdQd2RQbGg0bFNOVUhNcS9m?=
 =?utf-8?B?aS9KOTRMZ3RjZi8zQi9BL2FnSnRuL1dDcHI0UmtVVE5Dci9wRnJwRVBSTkdl?=
 =?utf-8?B?dUpPR09VZ3luQWJzdjZ1TzdnOFVBQzhrTWZqeXIzN3pEWXBpU0hQbkZ5RlZE?=
 =?utf-8?B?djRuNmI1akd4TlNxU1ZoSVZRMEJXWWdHNjhkdTI3Vk9rVmt1OWNiZW1UOU15?=
 =?utf-8?B?VWFtVU5uOTdUMVdGT05BQ3ZqaGVWZ2pVRlppeS9BdWlkaVh4eS9OMzRUdmhn?=
 =?utf-8?B?MTNZck43eVliOXB3aFZuMkloRHdodERKbmtjUWlXVlozZHE4Q0ZsdW1aaXB5?=
 =?utf-8?B?OVM3d0xMZkhwMndpaWVDRFhxK2VKR0JLMXV4WmVSVHkxTmY2Z1g2MVl4ZVpJ?=
 =?utf-8?B?U0IyQS9ZMW9XSFhOSFoxV0pIQlRDanFCZnkrQWN1Tmk3bUxjNHJsdnB3b3dw?=
 =?utf-8?B?SVZtM2poOXo0NUhSQ3ZubFJJd0xpQTZYcUZyQW1xVWdpcXhIMW50SFg1bGlq?=
 =?utf-8?B?OUR0REF0N0tTSlA2K2ora1VPRnZpYUpvYlRUVkhQYjlpR1pjN3M2bXlMRldm?=
 =?utf-8?B?M3dXL2lReWY1S1hWd212T0NJYUN0Mzg4Vy8rYWNaVUY5MUhsdW96dnFVZ2cw?=
 =?utf-8?B?UStUTngrVktxYWdIeUZhR0kwMUNhQUt0bU9kQ2d6cTdmTU1wSm9pazU2aE9B?=
 =?utf-8?B?YkErcTE1TjNUc1JQVVhxc0EwYTViQnovZEJjNWdiT3hPYlozYllXc0NvSFdG?=
 =?utf-8?B?VmRhZGdlalIvL2dObitCT2w0Vzd3NDR1S1JheDJLaVBjVzJsYUt2L2hsNXVM?=
 =?utf-8?B?UlpQb3U4TWg4K3FLUDB6akpQK1FuU0F5L3RLVmllajgrODJuMVhzdFQrcmhw?=
 =?utf-8?B?QmR6bWtTMGtVM0hqQ1J6T2ZJbWdUV1V2dkZUcVJzQmZCS3VWd21XOTVvQUNk?=
 =?utf-8?B?ayswcDg1SzJyZ29vZGhDQlp6cEwyM1Ryb2UreFE0WkphWTJCNk1jMThNcUhr?=
 =?utf-8?B?YnpUUjhkeVBTUVA0aHNxeTNtYWxVRnoxZzk3QitZUUlNQnRFcmZQWm9UeU13?=
 =?utf-8?B?N3ZReDJvRnZtY2JucXlkUlB1RFpCdW5kOXY3RlFqdWpiMFhGVStDblRHNGJt?=
 =?utf-8?B?c3RKdkphTTJqOE92TWQ1ait6RVU4TjRic1ZUNEduSG9jYXI5ODhhNlpMbzlk?=
 =?utf-8?B?bUdRVTRVcys1OXdrclM5M2V1ekFyeG5MNjhNdW9aU0VNbGQ3U08yTHp6bnhw?=
 =?utf-8?B?dDROWlJCanVMbEc0YzUvWnBEUXFRY3pPN2pCeHlybTJ1ZTFCdW9Fems0V1kz?=
 =?utf-8?B?eWZSYko5QzJQa2xvK3IyUkFUekF6aDRXTnlTNXA0d093d1cvbVhPU3hIVklB?=
 =?utf-8?B?M0JVaCtHdU5ZUnJkN2ZlcUFlRHc0V01HaEp0Q2o0aHZ1YWNmTkZSNDhtaHNY?=
 =?utf-8?B?ekVIR01UcFVCdDdDbmpKRThxdzNxM25ENkNoYmQ3dzRadXlTZnZNbWtvMzJY?=
 =?utf-8?B?bnVUU3AxSzE4NW5ORmQ2aWZleXpUd1ozR1JMbWJrVXNBNVV2U2ZkaUxkK2NH?=
 =?utf-8?B?NTlUSWI3cEdEMjRuTDhSeS9zVDFKNE5OOS9RMlljdG0xVyt4MmFtUjk5MUJo?=
 =?utf-8?B?NGJneGdTRnE3T01ZV3RwdW1SWXlUUy9MbXdlWFRCU0o5OEJmT0ZIYkhOREhI?=
 =?utf-8?B?ekRNT1d5QzRvRU5lcUlTbjJ5MG5FWGVzZ3ZlaFYrWlhTS3NHdGNIc2RqaWpp?=
 =?utf-8?B?clBwMDZOU3c0YVNBbkVLc01LaTJkME14Z1pmMUExS1V6YVk4bkdva2h3UFhp?=
 =?utf-8?B?cThBSGZIMm12TTJtcDlBQWNXS2xsTFRmUTA3blkwcXluVmkxMHlHNGNqdWt3?=
 =?utf-8?B?Q2JSWm1zcjJsZVVteUZFdkZ5RXJYOTBCUzcxMG1pYjZzREtWbitPQnlHQzdq?=
 =?utf-8?B?c2xrSjRlVlc5Z2FoKytJOXlnNFo1NXhnOXFacThpa3BmcHVONXlhZjBUNFV5?=
 =?utf-8?B?OXAzRlhzOFJXWTA3Q1VzbXRKbit6a2NoVGR0YWN2WFZWMWJHc2Z2VmdEM201?=
 =?utf-8?B?UHUxS0ZZd1cyMUJmTDJ2bkFrZXNyYS9jUmdDK3VnaUdjVk9yRXZCbkFEOW8z?=
 =?utf-8?Q?5oZl+t9TdlehQ31BHGnxmKA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2d969c-ccce-4399-ec0f-08d9be50fe5a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 15:55:32.5047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrvSrBwfudm6492DkWhzemykR99h1ECMYR44ubBNUUCde/QTiRPD/VgOnpVwN+ETEHskVMzvQgueiPW8CVgBPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 12/13/21 9:08 AM, Dave Hansen wrote:
> On 12/13/21 6:49 AM, Brijesh Singh wrote:
>>> I was more concerned that this structure could change sizes if it were
>>> compiled on 32-bit versus 64-bit code.  For kernel ABIs, we try not to
>>> do that.
>>>
>>> Is this somehow OK when talking to firmware?  Or can a 32-bit OS and
>>> 64-bit firmware never interact?
>>
>> For SNP, both the firmware and OS need to be 64-bit. IIRC, both the
>> Linux and OVMF do not enable the memory encryption for the 32-bit.
> 
> Could you please make the structure's size invariant?  

Ack. I will make the required changes.

That's great if
> there's no problem in today's implementation, but it's best no to leave
> little land mines like this around.  Let's say someone copies your code
> as an example of something that interacts with a firmware table a few
> years or months down the road.
> 
