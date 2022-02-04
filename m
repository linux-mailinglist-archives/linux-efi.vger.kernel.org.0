Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A2B4A9F7E
	for <lists+linux-efi@lfdr.de>; Fri,  4 Feb 2022 19:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355878AbiBDStP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Feb 2022 13:49:15 -0500
Received: from mail-dm6nam11on2055.outbound.protection.outlook.com ([40.107.223.55]:34946
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231779AbiBDStO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 4 Feb 2022 13:49:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYLaxdOdFeHLNZJ8qSNHDgCh+5575F3l1BIfZ8hxKS3WPW3ui7cmdMtwtWRjSc3gZ5DWNsNQGWuXRuqcUaoH4hsgYYT5RY0HbPHe/JV4pxStgqJLLRzrT3HJT3T81499nViilUULDRTjos7XpLqb0i6/FF1w+jJeR8BTQmcI5nr0llgop9TnexbjAaGtM8FKFeFeHQGZOJ8Rx+ALWYPo0VLPF4AzF99lDRwaMsXqxg1YH8Zsn9PPlQLdS4lTwvb/Nc3la7Ckjv7LoJFsXAKILdrJ1voWHkm6Cxf/NL/wLy7YjrAUyBe0PY3Yc3fJsOp2GkgOdBmXvMXudiHlBzJ+IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKwMvn6/wg6wzPAL9NJjubP9y5cy/fiy4m9rEZcwLFU=;
 b=i7P4HQ1me3Tb2itZ09aSBHgnuaQ9ZEifsPr+NUhK+wdcU1TTY/SF/8zwkEsan6pdR5cZ8GZt4Q4dfNfNNnN03wCStsZLnKmZyTuFZaXwGOCkVOQgJCzVZO/w71XVAKe5xoNHxDKlgev0ZK0ttcc7O7QGD10qPbYxgX0d8WRzomKNWmSSgCNLYH2hsgySg9emvLwtEt1fVTYm+xOOKVU1rdDFBI5k+BGGBqNADspLdErdlIaAr+m7IEWzblRuqb+t7paz+xKsU2jysU3LeyPmYkEcsF/O2gNkyAvE+nTyCFuxgjmqgYdgs5PF0x41nxkJlE5hGqMKkxaXRnjD1Y4jKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKwMvn6/wg6wzPAL9NJjubP9y5cy/fiy4m9rEZcwLFU=;
 b=b9KrBJRo5zD7aYxNVI3bEnzY1o3L2/luRkJz4n5umAtksm8c+qsWtwYTdNRzvyrb4sAXL92PSOhnM5dYdT1a+kdEzulDkZRl+DJ33gjD7V+1me5/lihuyGvLZVurDpRCbgWG6otaw86OqTIMXH43G2s33rqZQMvs8jkbAjkDFcs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9)
 by BN7PR12MB2596.namprd12.prod.outlook.com (2603:10b6:408:29::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 18:49:12 +0000
Received: from BL1PR12MB5221.namprd12.prod.outlook.com
 ([fe80::b9af:8be3:36e5:1a13]) by BL1PR12MB5221.namprd12.prod.outlook.com
 ([fe80::b9af:8be3:36e5:1a13%7]) with mapi id 15.20.4951.017; Fri, 4 Feb 2022
 18:49:11 +0000
Message-ID: <c0007699-61ae-6df3-0675-2ac6ee58a59c@amd.com>
Date:   Fri, 4 Feb 2022 12:49:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-7-martin.fernandez@eclypsium.com>
 <67d2711b-200c-0894-4ff7-beb3eb304399@amd.com>
 <CAKgze5YM2+BRjj2nvb+_dnuCg5WtWvQ6FQyNYJ1c8G6Orn=aQw@mail.gmail.com>
 <5c5ffe29-d3d3-2955-cf78-ad275110f012@amd.com>
 <ec9e29a4-0d2b-1423-d92e-6f025b56f8cc@amd.com> <Yf1UO6jF91o9k4jB@zn.tnic>
 <5ee34cad-8daf-6282-f2ed-cbc92a89d013@amd.com> <Yf1p0ZjPf9Qaqwtg@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v6 6/6] drivers/node: Show in sysfs node's crypto
 capabilities
In-Reply-To: <Yf1p0ZjPf9Qaqwtg@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0001.prod.exchangelabs.com (2603:10b6:805:b6::14)
 To BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f21543e2-7dfe-44e2-7aa9-08d9e80f0864
X-MS-TrafficTypeDiagnostic: BN7PR12MB2596:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB25960C1D62897C7D495EC638EC299@BN7PR12MB2596.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AdlZstgIKzevcEHdrAQVeWyHag7hgLeqPLFLw8T9sd27pcBivw7tbScOHcMaea/gGHdLCdOHc/h70NYvaO4VrM3kl8H5PhitpQ3ivQ5lnSKXqv9xV7uIZOA6+PedlRE/F9gsmcJKYOWRfmYI+nsZNeT49Oi5s3Z5QTb2QY2fONFs9hWps5WnKZ5W9ai3uftQ1mWtY/XrsbiDDWDbbFsR9CH7c/XeK9v5Zr+G1jVWZsIm/14Pe7ULBT3uYMOcIhQhVlI9s6RSWSd/Jq6wwIFwVhbJDZlEDkg5vEIZxwlVmJwte3QVSsRd4yXBsDH8fmjijWRJ29ngvXsgvT+B28FDp3wH7w2ObS7yeu0IQurnXYNcIbKmuSnmRsha2iuvUH12dYRiRb9Ga6qkdA2w/l96nJl0BTsY5Y84vaYuTfn6VDywp7BuCv3Awj4tcgrdX3d7ClaAdrEeGiLW4Q7qwUXI1yTmkLsZM8tt+BJgwKj9XSBBzH1CB1t5ds6nSxLQC92rwgRAVkgXRloNGpdYZX1Mu58z7UT+unihfaBbZ6oi6hw3yQPZSRuqFPgKU3qJJ0tMZHboDhK8bDGduMGczmpJ1nNF0bSxZm6De0UBnUEI2+KtECf0s9u5zI0ZntvjXC+cwWrAEmfXHf2hkkWYcgTdzjydEEW21bxBbog7KEsLQpZzLQuv6vpow+WUPmBrc0yDJiRUCs73LbH3XtYIWqB52Z/I8MEy5c1iYxVIvbTZybYb1W8fUkqLnGIQWEpwpsaEfp2Fl81R71nOUv40WVxDr8Wmn/eRfnKn1dwNkQAb39OFf1K6MnEGj/axD+ng6GrX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5221.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(66574015)(86362001)(83380400001)(966005)(6486002)(53546011)(6666004)(186003)(38100700002)(36756003)(54906003)(31686004)(2616005)(6506007)(508600001)(6512007)(7416002)(5660300002)(2906002)(66556008)(66946007)(8676002)(8936002)(66476007)(316002)(26005)(4326008)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L25hTVZucVpQa2tjOTJOakRKMU9YWWllTmlZd0twSFc3RHhjMkxnbnA2a1ln?=
 =?utf-8?B?dld5MFVrWnJQay9qM1h6UWpIV3l3L3JxSVNsWlRSQXlnemF2bDhNTDZVd0Nj?=
 =?utf-8?B?eklGbWIrSEo4VE14TUxiYmEwdWNHejNwS1Q4KzdlcmNZZXEvaUI4VTFtdEcv?=
 =?utf-8?B?QzVSb0hOQUVDSkZrbzhydndmRXIxZnFMa2hRSEdBYXlzLzdrSEExQmlDL0pX?=
 =?utf-8?B?N0N2b25sNXZPUEVyQlM5MmRhYjZNcFI0WHIrK2U3Q0RnaDlKUkpVOEpRVmlC?=
 =?utf-8?B?clNZZ2VXdURwSGpYam9NenZGMmQyam1KZHJ2OUhFbzZ6cFc4Sk1lS0VZM21N?=
 =?utf-8?B?MFI2cHVYT2hkcTFpOXVIOGlaMXo0Znluci81c1hIa3Zwb2FlRjNCSlc2ZHRW?=
 =?utf-8?B?enNhN3VneUg2NTJlR3VXeVkvZk5SOGhmeFA0V1U2ZWVpbjNFQ0NNYm1aOXJh?=
 =?utf-8?B?ZmlJM1lCaU90VmloQUtnL2FpUGJHK3RsbnQrSk03cnVNWGtyaWtVbVNMNFFo?=
 =?utf-8?B?cTV1VHhlM2JZUEJFVEorR3JONmVDSFlZUzBKQ1EzYnZMN2Z0MVJjRmlMVU1z?=
 =?utf-8?B?UEUvcFpIazNqQ2Q5enhXU2FONEwzY0dkNXJNRCtVQUt1RC8vU1dyUVZqWEFL?=
 =?utf-8?B?U0dMRXo4NVJ2QlNIdmhyRHJ5aCtPOWNsTDdTVjFUQ0NNYVVjbEpVamJKT2JW?=
 =?utf-8?B?elRpVHlOUUQzNFI3V3VTOW5jUkxXWU1iS24zSTlSU29Sb003dTdPSVBIZzFH?=
 =?utf-8?B?dFF3K0UwenkvOVoxRHhFRkJ3eHBVMWxsbGxCRXNJNmlmaVBMcXdKeHNSa3Ju?=
 =?utf-8?B?TndNMGV3cTIrR2NBdkV6S0MxbW9FcUJJVzN4dlZyOERCMUNMWHIxSFZMeWI1?=
 =?utf-8?B?eXdXamZaMThvMmkreE5jenJ0N0RXOUdEdFUzTm5kTVZ6N3ZkeDdWTnF2UzRk?=
 =?utf-8?B?MnVnaFJUbC84ZmM5ZldicytxRjY0SWRkd1JpZnErTEJuREV6dHdEbEw3VXBB?=
 =?utf-8?B?TU9PTDNDSG9TK21PSjlxTG0yaXh4VnFiUXJYUGJSdGtrR0txTlNTSTZvblJn?=
 =?utf-8?B?OHMyenQ4WEN0VXkvY3BlQnhnejF0cytxc2hvVGlTUExaZ2psakEvU3ZQcXhz?=
 =?utf-8?B?Y2NCcHV3SDlVSmlVOUM0a0NkTG5aRWVnNUdpUEJlcWJpZ1ByaU4wdTQ2RnRp?=
 =?utf-8?B?bFNmTjdoc0hsSUJiQXJLZUtDeTdpZmxvVDh2Uk04MzRqRjExQ1djVmszNk5z?=
 =?utf-8?B?Q0xDOEtUVDMxa0htZlZYRmJ2RWRPYkx3RWxSWmpkVzcwb2k1V1YwY1BIRG5R?=
 =?utf-8?B?QWVSNGdoU3JuRlVUQkFWY3JXd2VNZlBPUjd0Mllzbnd0K2dWNjB2UXphZ0RN?=
 =?utf-8?B?cmNZYVlQM1NmbXpMeW4rY1VaWDhIU3JTc0hCdXg5clhzaVJDODE3OUxhcjhx?=
 =?utf-8?B?TnFHako1REQvM3VDMmdCbEdJNmN3WU1pbXpIVEMwUjhya0VvMkJqMFV6cTV2?=
 =?utf-8?B?WUhxT2ZuTWRoUStybU5MaE1oQ0MwK0x5K3h5Y1FwaC8xVUJadjkxNk5ZMSsr?=
 =?utf-8?B?L3JJaUcyYVplT0ZCakRRVEdXbEhiTmpnNmhJUWNmdjV2RnBSdG5BSlRBekZt?=
 =?utf-8?B?OEJVWEFtSTFwZFhVd0t2bjhnN2ZoT0RHUkhZNkEwK2lkSFU3a1NuWWUzMUJo?=
 =?utf-8?B?TWsvTGdaT3lZdkxMZlBRTWVKb0lYS29uQ05sdHBmZ2lUMmVOMnVjUVR5NWZR?=
 =?utf-8?B?NVd6amlQZWNkTzUxYVpadEljbWRwdmdKYk9qQTZMRVVDUStWaUFqUUxGalcw?=
 =?utf-8?B?dlY2Ry8rREdCQlNadVhJcmw1WXlTL0c1TnhFQ0EvcTlidldkRklvZ2M5dU1Q?=
 =?utf-8?B?bENFN1BvWkUvb2Q3NnFpczBrQWxSTkJ3SWdZQ0QvcEx4RTV2bmxFS1lWd0dD?=
 =?utf-8?B?UXl4N0w0aVFQb0J0cFlyYnc2dzhQeElTUmJEQzFwTHhFVTJjQ0x4WXpxeno5?=
 =?utf-8?B?WWVCT1FlcFc4Y05RUnhXWWF5R201cWxQRTZ2ejJrMXh4cFdrMUFFV3ZuZWgv?=
 =?utf-8?B?RUZyUnVBRnd6Rjc1bnhzMVlrZy9yNVRSTmtPRXc3TlprRk5LWndCd2dhbmlJ?=
 =?utf-8?B?RFdzMUFEb29oVG83VUU5WUZmNFU2RWdEQldTYVp6Vzd1MkJ6bSt5SnUxN2pv?=
 =?utf-8?Q?CEyLTdDVrCqTM21F4KkAgcE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21543e2-7dfe-44e2-7aa9-08d9e80f0864
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5221.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 18:49:11.6497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wFTqCgUoalYUAZhTH9T/0Yu+hAlJ8HAp5cpzJh3oOfmqAj1syWk9TKh8FIa8PJOtEQzqFmOfBsNRaPpXBZw1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2596
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2/4/22 12:00, Borislav Petkov wrote:
> On Fri, Feb 04, 2022 at 11:12:04AM -0600, Tom Lendacky wrote:
>> https://elixir.bootlin.com/linux/latest/source/arch/x86/kernel/process.c#L761
> 
> For those who won't open a browser just to see what he means :), that's
> this snippet:
> 
> void stop_this_cpu(void *dummy):
> 	/*
> 	 * Use wbinvd on processors that support SME. This provides support
> 	 * for performing a successful kexec when going from SME inactive
> 	 * to SME active (or vice-versa). The cache must be cleared so that
> 	 * if there are entries with the same physical address, both with and
> 	 * without the encryption bit, they don't race each other when flushed
> 	 * and potentially end up with the wrong entry being committed to
> 	 * memory.
> 	 */
> 	if (boot_cpu_has(X86_FEATURE_SME))
> 		native_wbinvd();
> 
> 
> Well, we do clear our *representation* of CPUID flags for other features
> - see output of
> 
> $ git grep -E "(setup_)?clear_cpu_cap"
> 
> for examples. We do that for SME even: early_detect_mem_encrypt().
> 
> Which means, since this needs to be "processors that support SME", this
> line should change to:
> 
> 	/* ... test the CPUID bit directly because the machine might've cleared
> 	 * X86_FEATURE_SME due to cmdline options.
> 	 */
> 	if (cpuid_eax(0x8000001f) & BIT(0))
> 		native_wbinvd();
> 
> I'd say...

Yep, and that should be safe. We would have to look at the generated code 
as there can't be any memory stores after the native_wbinvd() and before 
the native_halt().

Thanks,
Tom

> 
