Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F36C3FA09C
	for <lists+linux-efi@lfdr.de>; Fri, 27 Aug 2021 22:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhH0Ucv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Aug 2021 16:32:51 -0400
Received: from mail-co1nam11on2047.outbound.protection.outlook.com ([40.107.220.47]:3168
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229591AbhH0Ucu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Aug 2021 16:32:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXVZuca7gR9OuG70mJTi0A1gM2ILZONlmhbte5EvlBEQ4AyAjQUIN1qZcatQ7A+h+8s5kdDyN2d/IKUpZ8VNtSlHyFbC3+01C3isXSK7vAnhV0RhHJW/uZ4oaDB16iRbQmb+v1cntimGG2YDBaddAAAGLgRm/4IhE5qSGazLaie7r+/lseABw4SGDBO2RO9ivOdSa0Dcw5GkI0kYRSn8zSEpjn6ybrbl9YHfS6C26i+CzvGaVZC+KZPjgNDStqF1PE7uozvxe7Drql0U8LZnTORvwzmUd63SsG3PI2IIY4wqgeTC1Et/ApocN06SgVXCy4syeTX45Nw+RTAcEu7rxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fodOHMh13MwWwA5D04Ni394435Hv1ODYhQdSW2VKnyI=;
 b=IL0G73Z35FnnUFj8GTAAZdvmp6AwGmb5NFWD/gc7Dg1MOAPqus2XvjwJKKgnUV97QZN62SC1E9hmTUEblib7N5qzWg2zfj3AafHOsiPsqUJ+K9qMxQ9Jw3GXs2WjBNdM/5tXHKSxfcBHPJcIt8W0g42eRQpK9SLrwdTpRIPfn2iD2QWs5Sy5sjNTAu7MRFd8S9UU5tFtiM2aiRXTlt0hz2GLAx+K9aAVac2JFH/HzAf+wBSzKA1A0r796XAbL/Ir6lh1jNIqm0ZQs92IT6qrAbcG5iWZmLIGLqAbdW5/wH32jhR+pG4W9Tzk48FYLSGLTjzksaW3At7msxlrRWXVrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fodOHMh13MwWwA5D04Ni394435Hv1ODYhQdSW2VKnyI=;
 b=zBEwlpdktxBkwGWmJqhdfIh03wvD8Ppwmj/ho3UNK01mxNfCgQ74TDaK4MRMHiRdSPwCKIB4DN3gPLVIcqkrLsnrAXOSvn6kSJgB/nvsX8CAD+VCHzNEu07CfaiaAQ8SD1lybWk4hXHIredYPzJhvrL9dxjZsHljxCs6u8FUmhA=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM8PR12MB5431.namprd12.prod.outlook.com (2603:10b6:8:34::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.19; Fri, 27 Aug 2021 20:31:59 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4457.023; Fri, 27 Aug 2021
 20:31:59 +0000
Subject: Re: [PATCH Part1 v5 33/38] x86/sev: Provide support for SNP guest
 request NAEs
To:     Borislav Petkov <bp@alien8.de>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
 <4acd17bc-bdb0-c4cc-97af-8842f8836c8e@amd.com>
 <20005c9e-fd82-5c96-7bfb-8b072e5d66e6@amd.com> <YSlIVRzTGHjou3eA@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <973eaa59-771c-1908-5f85-94cfb56870a2@amd.com>
Date:   Fri, 27 Aug 2021 15:31:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YSlIVRzTGHjou3eA@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0401CA0048.namprd04.prod.outlook.com
 (2603:10b6:803:2a::34) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-ryzen.texastahm.com (67.79.209.213) by SN4PR0401CA0048.namprd04.prod.outlook.com (2603:10b6:803:2a::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 20:31:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02f4bb77-33a2-4079-29c9-08d96999b80f
X-MS-TrafficTypeDiagnostic: DM8PR12MB5431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB543183EAF5C0E75D1EAC80F0ECC89@DM8PR12MB5431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RpXlYEJOIu6GHjrH7/EXwsOGx4IQQpP3XtVnyfiGmeCZtPY6u8tnEK3DtSt2+6j+22p9d1mSU72tCsvIoq/w0FVcq4PYEDCEA6VyarR4lErIKnHlK49EXvEZP8mm3HKQqM94DdQYK+QkqsrCQPzpy7/cC/qITMefgCwI5DIBSvzWXtGAKQVOHKuH5ozWjZeLf7P7xQV4oT1+qEwbdR3fYpp4nXKiCvrgDbE169k2ywDTIVX2gr/dPSUS5znUZVlVTgP9m3Yi3+tlWJ2QJk6sFG45OAABkmNmse4ve7GmaoxlObYrD9Sz5ykZY6sYlDH4Jk/3uMr5nh0sE30uSEbR9bJrhRMVlh81oDr5cMvCEF9A0YjDjo1vYx7gHeoDHNIu2Ng1PF2MU3eyM0E9PaBSHfsCLiDbHCJVrogSITU/j8GitKJy7N52SmIfmce7KV7O8lc28DfMWg0g/xMAbxQiu+o8SEUEMIAgXYUIVvyTPC63yLhhSYXwLJHGZHGu0HhEamFhPiINNNXg2Jgt7FHp56dBPAjNg/nPx+/cT1/owel7XVptv4xtwA79RWBVL2wqQ9eavYiwvUBdgypmJgQ63z9DI1/PquEpfdyiXXGAanl/ThDABIFozd1eQTEGx0IfVRnHacdBLmQZqSeKX7NNtp1ZKGFD9789bZYDTVAbfBzmo5IRxeDxFN0MsmZ26XvVdRUOhB5hLRi2drysU8+vaaz3esQHoIJAkZq9N5TGbOI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(66556008)(316002)(2906002)(8936002)(38100700002)(6916009)(54906003)(5660300002)(31686004)(956004)(66946007)(478600001)(8676002)(66476007)(4326008)(26005)(31696002)(7416002)(36756003)(7406005)(83380400001)(6486002)(186003)(2616005)(53546011)(6512007)(86362001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXltNUpOSEk5bkRrZEZkeVB1S0NyZW5iTUVWNk4xRXRqV0RyZzlPeFZ1clI4?=
 =?utf-8?B?ZU1rdGZWZWxRL2JTTFNIWkZNUUNmNVBvWDBXZU1wYUYraGNkK0lOU0llMit0?=
 =?utf-8?B?S2R2MXdjbk8zb0E5WUlFUDBHMGE1ZUhEWE1zRHVpaUdRb2t3T3loUXpTNFNl?=
 =?utf-8?B?OFl4ZjFmUGpKOVJmMDlnNjZJa2pkeElUQlJmVEZqTVkxUjhkd2J5dk52UlpU?=
 =?utf-8?B?NWpSajRrdFBFeSs0V2VnemprSFR0bGkxR3lRQVM5MW1Udld6Tk5HMk1LN2xB?=
 =?utf-8?B?OHFwV1QrQ1lIVU1EVk9NVlRVbFN2TnZPeU9lSmc3Z0t4M3hBanRwZWJwUnFn?=
 =?utf-8?B?bEpoTWk2TWo1ZHFvaXVnYkl2YW4zc0wwNTlUS3JocXJjelluREpMcTlCUENz?=
 =?utf-8?B?a0V2WWEzek00MFRxYS9TS3V0cUpzZUR5NEFQZ052V1BGQ2d3dWtOQzFVSkhL?=
 =?utf-8?B?TUxjeWplalVHUUl3cnk1eTErTW5Iald0eS9xOVhxam5lS0tiZ1VXQTJZV01X?=
 =?utf-8?B?VGFWd2RCQlh2bzdYMkNROU5tZjFDL1BFK3haV3VUR05uUXhUc2hZZ1hlLzhK?=
 =?utf-8?B?KzV1ZHBmY2swQWErZk5SeUx5VXY2eGU0K1BlcG5jL1VoMzd1WklCd2ZDdkw4?=
 =?utf-8?B?d0dnTlNITkIrRW5mK3o5aVA5Nk4reGRkK3BJNzh0UGgrK1NKWjN6VkNYeWR3?=
 =?utf-8?B?eDZwMGtIallZYWQ1Mi9LWWI5bGczZGNEZlhyK20rM0RmYzZLMmVYMXFwV0c3?=
 =?utf-8?B?c3lrdDVRa0tGZ1NCT1A0YjNtTFJEMG5DV3JaNDNxSEo5d3hScVNxK0NnY0Ru?=
 =?utf-8?B?TU5UZFMrdE1JWHBuZnI3aGhLbjczT01HNDVJUEI0L21XcC9nZDRSVmxQa3Iv?=
 =?utf-8?B?SFdmUzVSL2FJZ0RkbyswaXoyRDRnU2YwelJWK3ROQlBtY29UbDNxSThtTUI2?=
 =?utf-8?B?SFhvcDFQWCt6NDJsNEFKVnJXQzhIdDMzM2Z2MGdxSFczMEY4UEtlc01QVmJx?=
 =?utf-8?B?cUJWSXM3VXZ6WExLcDFxMUx5QVBEeWkzRTVjcmJHcVpOT29ydGFiOVJxYzJJ?=
 =?utf-8?B?TFdWalVFYlJqY1ZicGxFR1h1V1dYTGV2elRXcWVSd3M2WUxRZUVNRUR1ampP?=
 =?utf-8?B?c2pQdzZlQ3VpdEdLUkNmczNBWVlUNmQ0L25xRnZqbEpWYlh6aFJkbm83K05k?=
 =?utf-8?B?ejVudjRoRWtEamZxTzZ0UkY2OVNSY0xTOXNUanZCbmkrYlE0dkxXaXB6dXZa?=
 =?utf-8?B?dUhBUnBXZGI5Nk1pUGNoQ01nOUE2ZXpONHdqTHlyV2VJK2JXaVJtL2k2U0xa?=
 =?utf-8?B?RUhxVUdYbXFab0MvWmhWSEkvMDFmUVBqNFVFeGhMMVFGazJZQmxOSlVTemlq?=
 =?utf-8?B?N09GZ1pmNXlwZ0t5ZnNNR24reFFiRjI0ckZyQjlyZzBkR0dXNEhJQXlVOXFP?=
 =?utf-8?B?blAzK3dnTEYvRjBSWWwwT3Z0R2phS0ZyV0w5V1pTSElFTkluUWQyMHdLbEVs?=
 =?utf-8?B?SXhiQ2R5UUh0SmZUOVg4UDdlT05PWDU3OUVxUWJSbjdLLzlzc09tWk4veGR6?=
 =?utf-8?B?R3ZacTdpRkxoVXU1K0pBS0I0K2FSZXZrNzRUb2dwQzlmSk1Cb0p4c3FCOE1H?=
 =?utf-8?B?OXFOcGIyZlBkbWp4Y0p6akZKQzJQQ0Fid0pMbk01V0UwaUdYbTNaemNXcWVF?=
 =?utf-8?B?ZnFUdmJEeEdiMEdYRUYyOGNwSGNrUmkxQS94NWxtNlNLaEQvN1F4c20xNzNu?=
 =?utf-8?Q?5M3l7HA2g6cmTjHx8glESJWrhIWkCKIg417R3V/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f4bb77-33a2-4079-29c9-08d96999b80f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 20:31:58.9953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWKC0XfyY0HQyV0WQMd0GpVaqZZu2EpwkqLReJ8Oi0tWLokM95OA0jcI2rjnE3VvHTH5FOJ512fp7x0OeQJTvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5431
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 8/27/21 3:17 PM, Borislav Petkov wrote:
> On Fri, Aug 27, 2021 at 02:57:11PM -0500, Tom Lendacky wrote:
>> The main thing about this is that it is an error code from the HV on
>> extended guest requests. The HV error code sits in the high-order 32-bits of
>> the SW_EXIT_INFO_2 field. So defining it either way seems a bit confusing.
>> To me, the value should just be 1ULL and then it should be shifted when
>> assigning it to the SW_EXIT_INFO_2.
> 
> Err, that's from the GHCB spec:
> 
> "The hypervisor must validate that the guest has supplied enough pages
> 
> ...
> 
> certificate data in the RBX register and set the SW_EXITINFO2 field to
> 0x0000000100000000."
> 
> So if you wanna do the above, you need to fix the spec first. I'd say.
> 
> :-)

See the NAE Event table that documents "State from Hypervisor" where it 
says the upper 32-bits (63:32) will contain the return code from the 
hypervisor.

In the case you quoted, that specific situation is documented to return a 
hypervisor return code of 1 (since the hypervisor return code occupies 
bits 63:32). The hypervisor is free to return other values, that need not 
be documented in spec, if it encounters other types of unforeseeable errors.

Thanks,
Tom

> 
