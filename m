Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24EF492FE5
	for <lists+linux-efi@lfdr.de>; Tue, 18 Jan 2022 22:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349508AbiARVFo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Jan 2022 16:05:44 -0500
Received: from mail-dm3nam07on2070.outbound.protection.outlook.com ([40.107.95.70]:41568
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245732AbiARVFm (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 18 Jan 2022 16:05:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceXgHx2qZxcD8QYg6QEZpxZ2Lo/JOLF0iEkuZqD1LpnA3I/q4wPUprw3AZ7zE3m36Yi6mGbcRe57+NTOfHoTp/Z5w0V9ImNL/KqcRrM6saLE0upIc0YCTxlV/0m4BqS0T0WJQyPpZvXVZfn8aI5QzZOuLXZzKrInMB9TH7k3RNpu0BMp72wfn2IbdUPTmVZs8h/Lc6yig0VTNMNBXBA2MPnkqvenGpUcT64xpzVrKv+F7WbMu3Qlk5x03F3JwG2e96Oa+3E9dwVbqVoQnbDOLcSL9yFi7kjDI3teAR1QaRKaFfXfCtwcils7vImIjNjusAAexGJ7UaGvGXU+2aYlBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWqUBjlKoI17ecD6Ueboid5tRgFtIPGH6ntO/kC19yk=;
 b=LWraGqCRihE/6gCIee1GUVd+lJ90zsxbCh1tnuHzEMvzH2eVahB1/gj00Ma8C85Mu91o1aFMQqir7fbgFZ91pP5UUPKK5nCOwZvQZsNPELKs+nGoxGURZLmBxSF7Qp0ahWDVTpqSpj2uzqQ/54D7ThGuQmAic/hRGMtlv9/rCHt56U2WTHSURTzIoZBRA/yKCQGvTlg44NDomomhjEGYm2weqwihDOHTa5g2/m5wsL5NMlPGanpbpTR3c+iWTMBInJk1fLsZjSaMiO2YaUFDrq5/pt1IgQRgPO+1r/IP9CpSCN43ZT1wropAe6rC681QSwsHQrkVWri4gukp5eC4pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWqUBjlKoI17ecD6Ueboid5tRgFtIPGH6ntO/kC19yk=;
 b=JtoJZI3Igo2kuzi35UcA8f7XNdHZKyt9QtGcXgok3fiL4GOpXEO6xpreG48xkKLNlxHxxXqCQVtYjYz+k6tzEl9A+cqKKZW6qFSowP1p0Wnh9xO1d9fP20D2DRzDWgKIfh2pJlu2mFqquT+YRP0UdihJbs58xXBFwQKXafEPGvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2416.namprd12.prod.outlook.com (2603:10b6:802:2f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 18 Jan
 2022 21:05:40 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 21:05:40 +0000
Cc:     brijesh.singh@amd.com, Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 0/7] Implement support for unaccepted memory
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20220111113314.27173-1-kirill.shutemov@linux.intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <05067267-494d-beb6-a935-9f39f5c120ae@amd.com>
Date:   Tue, 18 Jan 2022 15:05:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220111113314.27173-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0011.namprd20.prod.outlook.com
 (2603:10b6:208:e8::24) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cba6f552-4caf-477d-acf7-08d9dac64821
X-MS-TrafficTypeDiagnostic: SN1PR12MB2416:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB24164EEF60CD005A30CEB99BE5589@SN1PR12MB2416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f/x11DOP5oxTrZv8DdA08u8JiHfSv7XdOa/lFG9xBjzKWaoTTAKZqi9H/K95xkbWDoHTAnfyy8gOb1EdtZpok7yO0EfrlsetnK3r/cIlBaUMI+7zABF3b/zj/+og9Lx+moVUUTtzczWzXpvPtXlyPZxfSFQp3V2f+rnLOENH4YHyn6uZiZTXDdOt05Oeb1k0ngeAie297W3cmM+P5sF6N1t8KODaviTwKGzuV5KzM1tftCPcGtfJOmrTaG1ztebRyuajgO+ISTWFTYjeM9i5E4h4Zfs5Qs3gFTBNPUEh8D8niLxe9son6KXv05qD5f9eLrAf9SkVrDLjbJhTfRIGFAF1gAWMrGtHiSeDKx4lpDNyMh7dN8lz+w7hAxc+wHL866r5UWOhfOqtvl9xtKDmy4wtPonmYCtcB1gWorEuJ3/gYjif5UZOY5TrWvz1RLxdngHDGUaKUfE5R27eFwuZDMClf2o9vflbD+mvj09mPVFNu3i2BH1C4sSz2Mn8HKMYl8s7on1wVBF0vCv31j03FnZjkEHcRx2IBCqEBe4rnTuLsQGGnALmH6i6QMv4Zn9tBTWlX3XC02fVI8QblNhiVNRlRO+OPPB+F4cehXiZs4XCVI/IdrW04WxTNHCQZrx0v+ReOcbn+xeHmVC/2zPSlMYe5Uo8qg2kgdZLv0qKQwgpCCO5idyoPkygEfw9HkilWBbvOE0U3tpRu37Avb8YkdvT8zYpmavVUBPEHz+kWaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(66946007)(2906002)(2616005)(7416002)(8936002)(44832011)(316002)(6486002)(38100700002)(110136005)(4326008)(6666004)(66476007)(66556008)(4744005)(8676002)(54906003)(6512007)(5660300002)(31696002)(86362001)(36756003)(6506007)(31686004)(508600001)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWVhVmtRWDVGOGI3NlpMSDI1YkFHclUyWGZ1WDhRWCtKS25oZmI2ZjN5a3NZ?=
 =?utf-8?B?ekVHdGdPOGVidEtocW1HY3ZIaEh1a0ZGVExnNDhoVGJiY2pFL25QRkdwNU4w?=
 =?utf-8?B?QjJId3hzUjZhcjZPa1RCTEVkR2dHRmtyeEVoVFVNL2RiYWJQVnY4K2xWYVl0?=
 =?utf-8?B?N2FSMklSa0oyY0pJYzJWVUxlNjg2aWdDWW1NVEx2cEU5TVhsaEhjdUZVU212?=
 =?utf-8?B?LzRZVWJFc2Q0TGNRaDZBOXgzcTQ1Yi9OUkQzUnlwOFN3ZXk4MEFXOGt5aUov?=
 =?utf-8?B?N1ZJNkN5dk4vRkdnTmE1N1VlVlpyWW9IUFdUdTZrU1VJckoxU0NrN3RzeDBK?=
 =?utf-8?B?cW5BVElUdmhmRGw4MjlZQ2s3alh6K1g2bXVGSUxJZHZKbWdDRE5LSUlHSTN3?=
 =?utf-8?B?U1ptNTY4SlVabHRjdXBZMDlWUjFtL1k5emZWbGZDUlRLbE85NE5nZ1FPTDdE?=
 =?utf-8?B?N21JaWJlTUhXTGZaeFh0QUhFTnU5alRrRklVQWhxdTJuVEZsZlpCT09uSGlN?=
 =?utf-8?B?cVZhSWlDT0Y2U2JLREFPU2JpZ1RQVE1lNXhBWSs0Si9qd21XUnB4RUVhZFF6?=
 =?utf-8?B?MUc0ZjkvR0cySzZhalJlOE4vbUJBeVh5b0Z3ZEVsTm9Qa3M5citRVCttc1Fi?=
 =?utf-8?B?Rm9kOTlsOU1nSC9GUGVzUzV0dlFoYUZVUy9SZy93OFVmbUdHaDJ5UFNzdHhP?=
 =?utf-8?B?RTZ1T1BaQWNtSzVnQ3VqeS9xMmZtVVd3RkRIUnV5VTlxN2FwQzdjWEtPanI2?=
 =?utf-8?B?dFY1bVQ1NFZKQ1Z0Y0VTb3lnTGFrUTRpZG5scVpsU3YrQmZZajgzdWNQdUw3?=
 =?utf-8?B?aTdwdTZOaG5iRDh6UnBNMkJHRFB0Njg1TFFjVHE0cEJ5cTRkMGJISkRNMFJR?=
 =?utf-8?B?SklWajBWUVFER0RLOFJSQzhOVjErOUs5bFVIbEVkV2dSaTU3RG42VWpOaWtI?=
 =?utf-8?B?UUdXenR3OHBTWXpzZ1hhZlFPVDAzeDh1N2RyMEttL3dVeEJYUDlFaDM5OVNT?=
 =?utf-8?B?WWY2dVNhOFJ3MVdqemVRejk4ckxySWRzcGtFT2wzajI2M1RWU0cwT2FvWnpQ?=
 =?utf-8?B?Z0JnMTRKS0V1N0NWVVJjNVFCVC8zRm9NMHhKM2ZZSkJVdWJBVDNjK1NiV2Y1?=
 =?utf-8?B?SnZiKzVaYVlZcWZqMGRPZ3RHVnpSOUxXSERXZGNNUG0zMytmSDlpVGZUR0FD?=
 =?utf-8?B?czVWRDF3cldXREZ2ZzJ0SXBONWJLcjE4VFNGTUhGZzQvdzY1ckVBVXlnQm1S?=
 =?utf-8?B?Z1RPWnVlWEJkNmR2dzZ3UElpb0VXNW9RSWpDMXNGdDFPWHNSWWtPQVdOKzR1?=
 =?utf-8?B?VTlNMDFKbUJKdUdYRERMMDZzSC9iY2I3Slc4KzRVVmhFbFJmWFNBZHJBSGd5?=
 =?utf-8?B?S2sxWWF4YUJXYTBhWEVQSWE4a3NYb2VyUDVFOEw0cjgvd3ZGWm5PbDllME1E?=
 =?utf-8?B?UHZEWXJtSm9DdDY4TnFoUVpjMWdOaFBFaW0za09TNVg5cW1TcXc4SVdwbnFW?=
 =?utf-8?B?YUc5Ymd2VCszVDQvR0x5TFdJUWh3ZzMvRi8xbFNFYWI3NStyMFpyejBvUGc1?=
 =?utf-8?B?bjNpRHhpWjdLSWE4L1RvTUNIb0FKU3gxQVR5d1dSSW84YmRwbnBUVnp3K1VR?=
 =?utf-8?B?NlFzR3p1ODBSZ2FHbUFubmRQTUJOV3BOSUdrQXhZcjBWb2tlc3UzMDdWa29x?=
 =?utf-8?B?c2ovMVpjWjQranhWaElrNnJlV2dvb2Iya3NIbXpOdUJwNUVxYW44ZkFLVDVV?=
 =?utf-8?B?MG1YN0xTNWw3YUQrclcxVTJSeUZ1TGJXYzQ5aVBjWUFZSnNPRmdhaE42YTlH?=
 =?utf-8?B?dXFZaW1PRUZ0TDFpakREOXF0ZXErZ2I2Si9kOTBjK1YrY2puVVp5TjNZeThN?=
 =?utf-8?B?U2tTeFV3enMrc0pnS256eElaay91V0l4KzRZdDc1MzZZV1VFNVFYLzhzNVNr?=
 =?utf-8?B?M1NSUm1Qa05WaFNGbVEwSHloV2YrdGtIelBTWnBycnBxQ3NUM2RBTjNRWndR?=
 =?utf-8?B?b2JubWtxaUxiTks1aVFDQWxaeEdDVlo0MUZYbFQwcTlPcDFIZ1JnekMvNlFR?=
 =?utf-8?B?aW5GWWhob0c3WXdqS1Z2V2xxKzlWcGZYMzhvaTdnVUQ5TGhpL3d2WlplNHVK?=
 =?utf-8?B?bU1aajlsRmUySmt1UzMrM05wOTRMWnhyMG5iY0MxQ25RVXBTQStrMDllTDlo?=
 =?utf-8?Q?/Dl7d1vftnB+rE1K9tmBzJQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba6f552-4caf-477d-acf7-08d9dac64821
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 21:05:40.1650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y2/672kwmDoHtIgf0tAfH2O0Bfr7w1ngl944W8pal4X9PeWbSZPLB1w+/wBSpX9bHbdZF7QKjs28r7qd06sfpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2416
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Kirill,

...

> 
> The approach lowers boot time substantially. Boot to shell is ~2.5x
> faster for 4G TDX VM and ~4x faster for 64G.
> 
> Patches 1-6/7 are generic and don't have any dependencies on TDX. They
> should serve AMD SEV needs as well. TDX-specific code isolated in the
> last patch. This patch requires the core TDX patchset which is currently
> under review.
> 

I can confirm that this series works for the SEV-SNP guest. I was able 
to hook the SEV-SNP page validation vmgexit (similar to the TDX patch#7) 
and have verified that the guest kernel successfully accepted all the 
memory regions marked unaccepted by the EFI boot loader.
Not a big deal, but can I ask you to include me in Cc on the future 
series; I should be able to do more testing on SNP hardware and provide 
my Test-by tag.

~ Brijesh
