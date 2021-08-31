Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922413FCB2C
	for <lists+linux-efi@lfdr.de>; Tue, 31 Aug 2021 18:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239702AbhHaQEL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Aug 2021 12:04:11 -0400
Received: from mail-bn8nam11on2079.outbound.protection.outlook.com ([40.107.236.79]:2033
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239594AbhHaQEK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 31 Aug 2021 12:04:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2Lt7HydOAHhsiouslwL4LrWuqBu+/+sUZz/nd5du/FdLG/vDhjcBXI/50TpRO3AtQLl/AFjN41I+r1YP2fgAvtw3P8JaOPzRVJS1TBsS28NcMir8n9WPLDAf/L5fTygFCJx4eO143PnHcmNJkRDmDg9hHS5cq1ib9L6RG6szdpCBKvuCjRfv+to/tZY93A5gWE+XBEWs4NAiQDFlfvgrkmLqFWE0H+HZ88MbfOTvO+4zwGpxyPKsEuuW/MQvBXHJM5u/4k+Se4N3IM1pWLXjSLuQzN7D6fuNQF1rop7/aOcmU385wys51H6SwDxJRBktXoNXukVVT4TPiFZtiaPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=UcRZYxH4LjJv2V3OdRYP0c/Cnl7zssCPUdmTEVJwFG0=;
 b=oEmKAvGGBa0GoFZljhr65kvB/+XJBwSkQJ+2r7SdjNs7EKt8QR/EV+sE51uLwZ1vVPZP+NbZuMi3/VDNpJkpRhEJQwbnSXdBkJ1AWRCC0bjtav7JTrFb4Zmh52grLoS4Wxj/MQxXiCYHZm3EVoUHN3FIQT5ezIfS5P6mEIf0wfGX1OgCpZBxSe9EyvxsUq5c5lF5BX93ly7OQ0pVGn5VEDW1B34Oi2Jlf9YlrZXCPg+2EJmJ/y6Sv+zkKlPIOQep774jxPvzdG6D042o/6t+Gz2SjGHCT7Mo9ZcDOO4h3NAg6eXt+gz9iLyqeEFTnxyZ8OrNPlWu/Cb9vCHfqO+V+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcRZYxH4LjJv2V3OdRYP0c/Cnl7zssCPUdmTEVJwFG0=;
 b=S6NDihA3XfJ1T6nXVvS4XoJ/SoecM8qFswwD3oQPOwmW02BFfrsYvN8cKdhUdtzyqG+vHE5LnpsdOPivljGnfGXQQW52buWaepA01nv5ocxJfsnuNGnaChJHg5fatyf4APT6CVULwaGKN1+fGu0AJp5Wvdq+p6oOinpWryx7uk0=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4509.namprd12.prod.outlook.com (2603:10b6:806:9e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Tue, 31 Aug
 2021 16:03:13 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 16:03:12 +0000
Cc:     brijesh.singh@amd.com, Thomas Gleixner <tglx@linutronix.de>,
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
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 35/38] x86/sev: Register SNP guest request
 platform device
To:     Dov Murik <dovmurik@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-36-brijesh.singh@amd.com>
 <56b37edd-6315-953c-271c-f2c4025be3f7@linux.ibm.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <ada086eb-2a27-ff25-6db1-3d629cb31868@amd.com>
Date:   Tue, 31 Aug 2021 11:03:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <56b37edd-6315-953c-271c-f2c4025be3f7@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0701CA0004.namprd07.prod.outlook.com
 (2603:10b6:803:28::14) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN4PR0701CA0004.namprd07.prod.outlook.com (2603:10b6:803:28::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Tue, 31 Aug 2021 16:03:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89484ea9-2214-4fd8-988f-08d96c98d5b0
X-MS-TrafficTypeDiagnostic: SA0PR12MB4509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB450934FC3B41C553E9981BCCE5CC9@SA0PR12MB4509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pUw12PYpTEIzujCO+LpYPp8UJ6IXDn6a37+Fl8ZI8TVp0lhBm31dhL2Ukf5NsMCCd6JE3/xBJ9UiVlCm0txYjHXn5IMprrAgnNtIWNqqQSOnkSL35tQEY09toQFIL5j9ZRAFVReSoIPK+eVcr6Wn/ab4b+3s40nYbTgYuP/R3CB1zwrOr0nGHU10e2GekEo5sMIFaY/0mn1UUhFZmawaWzoa/RCmSUz0iEr+M3P4yo7bUrOTvaYaiu+LD8+vo6w2Y+TanB0mYgxYoZbWrUaD7xj0VycNy821Wz8lgQU7TmoSTRtDTyKdy/Y6WT++4cscr22oDl+XvLXcDHygEv6GLza9EI/IoyVtGzlBrBF3f3wpn89SXU8rWGhF9qAlU2afcqxV159hmZKA4uKS9Q7wj/Kb1m04r5iik28XtCcx2HDv8K3jonGt7js5TGEqjVf8OLqHrJXWBK/8KBN73+1EzUHwjazC+ctBhONY1BD34LMySBFYXVZ4t7Wjgdtncj1Ckldpd6EiGxle9Xwh+y5Pwos/2hSLdYGYaiqPAd2s9JwX9rjtUnumaqpQEp/UdOUh3OK2ML1nu6B38zYjc0/Ug5dF6uhgxqWhkV10EbFEmhx3s7fvYq1PhMiIQnGyy66bhEVdXrlZ+OlcWmmg5Y9z6a4s5YA7lbnf7buQYQ1nmJKBkIua1sfXqO/SzApFaLUn4riLjt7y5fA1Hx+jzK1XEdUQLQMUjtasnuqplJHHUWXAmaPPgY5FF5EWUXD9iMuK2az5SThl2DU6DjBo9/hrtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(956004)(38350700002)(7416002)(8676002)(38100700002)(2616005)(44832011)(53546011)(7406005)(4744005)(6486002)(86362001)(4326008)(2906002)(8936002)(508600001)(31686004)(83380400001)(16576012)(5660300002)(26005)(54906003)(66556008)(66946007)(316002)(66476007)(186003)(36756003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU1EcHZnalpqa0xsVFc1cnFHd2pEa2IxYnNKMlhFV0d5Y0NWOE5BZy9YNi9D?=
 =?utf-8?B?dytZWHNHSHR5Y0xrSy9SR091TFJRZUI2VGhVSkp6cUYrRWtZYXljRlFva0dh?=
 =?utf-8?B?Nmo3Q2xuR1ZwQ1UyejBhUWhJNXV5bVdPdDNrMktQNFFWajVSUFNqSmZYQVlr?=
 =?utf-8?B?UmZIa2RlaGNnWnBTQUErcHUzbHcvNGQrVUk0QU9Kc29SVDV2UWdlZ0l5L0l1?=
 =?utf-8?B?RnhOSVJTOG90U0VrZlJHbmhDNmE1dVlESGxnSTBXdUozd3JNOE90bmoyVTNE?=
 =?utf-8?B?K1lXRzVPZVE4S0hRY0QvSHhST1VFL1hBMXIrV1RxMC9FWStnTldjY2xvRGow?=
 =?utf-8?B?blptK0N4MkpFNDRrNVZWM1J2NFB3cUNGVU15WElYSUY2QkhDSUNLaitOcHk1?=
 =?utf-8?B?TENNRHdIdzdPVkhQaUNuUHYrNzg4WmhoSzRPUGNQNDZYNTAzNlN4Y2ZPandv?=
 =?utf-8?B?WGJ3eTliVnVCWSs4cTBWWWY4UFJGRjlpcWZWYlk1VXc1dno1aGUwMWlhNG5W?=
 =?utf-8?B?NWVaTTZaTmhTblNkTHdJc3BqdWQrd1c0NVFsVUpJTjY3UUxFL2M5RkNoWGJK?=
 =?utf-8?B?bmh2aVVuOTg4Nmh4T1hYaHNEZVhYU1dNazBkM1FmUWN2eWtFTVBkbVBLUHFh?=
 =?utf-8?B?cHhzWENGUGYxWUNEbUl3VmJUMlo3eEIvd1A0ZU5UTENoaW00S2VjRjFzbkNk?=
 =?utf-8?B?TVJZTk9zbHJrREpIdkdpc2VETVRySGc2UDg5cnNGbGlEeUYzamtzTE5PalZq?=
 =?utf-8?B?QWc4eHRpakJlQks3bHQwYmFvYlBWcXRYNmhIeGxVU3EyWTJrV0ZudzJFVVEr?=
 =?utf-8?B?S3g1dzlLTWIvaFZEamFrYTg0ZkF1OFFIUkQ5UXBOWCtaVWxiRHpjS0ZQLyti?=
 =?utf-8?B?em9VRkZMSTBTblEzbk9DOUZFdUs2Rm50M0F1WlFTbGZpRDc3enJ3dXJkNWgy?=
 =?utf-8?B?S3VZb1JPMjhqMVNZUU4yUklCbUZocUtOdnBuSFpuZDByL1o1NjFqVjhrTyta?=
 =?utf-8?B?d1IyZnBoZ0FaU2w2ckpoZkpuMWNoNTM2TWxFbDJFVTU4ckhnenl6YjJaSkJo?=
 =?utf-8?B?alVEc0NTN09scjNsTG9uS0xmcHdMQno0R0tFdW9yYUxJWkwzQkdYajBtaUdN?=
 =?utf-8?B?V2ZYT0YyTlBNWEpEMnZyUTg4VmdUSW5TYVFzSHcvVkdTQlVsZmJha1VpZVpk?=
 =?utf-8?B?OXBlcXNUVEJjQmJFaTdiSFFqOU4rOTB4OVFtV3VtakpibXZXRUFPRUNmd2V6?=
 =?utf-8?B?SFdZOXp2b1l2Q0pVU3ZrU2pjak9RaTl2NnY0UVRPL21vSEZzVVpmNEFockp6?=
 =?utf-8?B?TU1MQW9xQ1RIRytIdHZBZE80Ung0dWVuMHNPT3FwRVowK3RxRTN5ZFJXRnk3?=
 =?utf-8?B?ZGlLNEJJUW14eDh2OTFEaGhnWjJidHZ5RCtzb2RyTGlRQWdaZ2RyRDZhN0dJ?=
 =?utf-8?B?SkhabFhMeG85Y2ZXS1NXM0ZZQlVmcURnb0doVGlTTithNVF3T2t1ZWZhNHQ4?=
 =?utf-8?B?eTV1QmVTbCtTVURvdHdvS0RIczdWQ08yU2p6Q2d6YURML1dpQjVmTVFPcTJv?=
 =?utf-8?B?cUZ1bE53NFZHU3JRQVlrbVdkMHBXNG0wVGlCbmFCakIyMGszaHBmS1FyeU5o?=
 =?utf-8?B?TjdxdFFnekhSRy93cDMzUFdyNTFsUFBjL2RoMmJqT2J4RkNPNkY4d0hDdTN1?=
 =?utf-8?B?V1NJM0Y0VzE1dGRnSWl6cm8vQ0M0NTVQOXFiYXk0Q0VPQVFBb1pJcTY2NWVm?=
 =?utf-8?Q?jD9A1OtMEyLS4LFXSeUdS3W5/4+jFOr7rbtGCJ9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89484ea9-2214-4fd8-988f-08d96c98d5b0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 16:03:12.9332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +LnUMIGqHS/GdLSHaiERKenK5EnOdA5iW1VzzaWO5AHzM4QBDcQrRoHzDVVBd9seI17qEOSjFbE/fYpmZda6TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4509
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Dov,


On 8/31/21 6:37 AM, Dov Murik wrote:
>> +
>> +	if (!platform_device_register(&guest_req_device))
>> +		dev_info(&guest_req_device.dev, "secret phys 0x%llx\n", snp_secrets_phys);
> 
> Should you return the error code from platform_device_register() in case
> it fails (returns something other than zero)?
> 

Yes, I will fix it in next rev. Will return a non-zero on failure to 
register the device.

thanks
