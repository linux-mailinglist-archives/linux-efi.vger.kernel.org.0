Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9583ABC15
	for <lists+linux-efi@lfdr.de>; Thu, 17 Jun 2021 20:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbhFQSs3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 17 Jun 2021 14:48:29 -0400
Received: from mail-bn7nam10on2046.outbound.protection.outlook.com ([40.107.92.46]:12278
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233040AbhFQSs2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 17 Jun 2021 14:48:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3FIaBolGyW/FQSq80i8RuYkm8h4omqESbIDoyU0yVzHAILFCfut/MSy6IwQ+h8cCOM/Cmi66n09cey20SCk895r9aOVRLJqU1WFoCyt2a+QzReQup6rT+aQLDZlbrjOadAMGWGSrwABFKLh372mxLfwb4nX7bti9jP1q9yC4VGq0wLJDW68nsDaJlDSBFmEhmvL0A8o1abElPwibW6RbF0vEfPdTpDmiDJsTmEAcdye5E0j4mInpV/UBXSA+huEPZ/DGnvfRgmLjiZkzIW8Ifs+hxD1U3TJYig01pyfcO9p8bG09ilYmq6h/NgAhV2naYgnD38LBfae0EV0jCrusg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoB28LGbzw6CufgVrXYQ5ruVMnpRzOlNv6COUXeGkgA=;
 b=IVB7B0Z7OPSuIzVQevnidmQ4EyLwl1OS0zhmMYqQyyLtEJka2pJJ0S5goJmycz1/eQpvmgnr7BWzW+tC7x1VyweUxaS+3QJsIdcRq2mvQMp8jbUMgRCOkQgLF05cKUcTwIJ/xnKpxzsZy0zPf3if2DLsmudbHwIYBinHc12C8EofqJvVFSweyO/66M11Otb+3BwSV7VhBDvkBNIuaCpRL1h67tYWQJ4TknFt/9MLrv4Tth8IsXOYMSPINv2IpKT9wtGBMBf7nuGpMW2VmTypliYOqM9PICj2iW7c9Pubuz3nwB63R5turKp0yRb4xqx1HmURtwBxntTQDrW8mw/2iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoB28LGbzw6CufgVrXYQ5ruVMnpRzOlNv6COUXeGkgA=;
 b=XDVYEORxaGbpCIsj7ZYO8c5HpKCF3pS03sxbFWbdCDhi1cTsRagnWGTe0eRumPrZyDvsNU4b/LDbHS/Oqcndzo9V7tHjrOfES7RcaHfZN5Y2/ST+F4yeBj4p4Z1Inr3ObGc801ptGtPa+JIjqO4FBRnQ9JucCAZTMvgy2s+FqPc=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2714.namprd12.prod.outlook.com (2603:10b6:5:42::18) by
 DM6PR12MB3035.namprd12.prod.outlook.com (2603:10b6:5:3a::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16; Thu, 17 Jun 2021 18:46:15 +0000
Received: from DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b]) by DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::7df8:b0cd:fe1b:ae7b%5]) with mapi id 15.20.4219.022; Thu, 17 Jun 2021
 18:46:15 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
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
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 06/22] x86/sev: check SEV-SNP features
 support
To:     Borislav Petkov <bp@alien8.de>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-7-brijesh.singh@amd.com> <YL4zJT1v6OuH+tvI@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <e617a0a1-bb8d-9d75-56a4-2ac1138ebf8b@amd.com>
Date:   Thu, 17 Jun 2021 13:46:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YL4zJT1v6OuH+tvI@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN9PR03CA0431.namprd03.prod.outlook.com
 (2603:10b6:408:113::16) To DM6PR12MB2714.namprd12.prod.outlook.com
 (2603:10b6:5:42::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.254.35.102] (165.204.84.11) by BN9PR03CA0431.namprd03.prod.outlook.com (2603:10b6:408:113::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 18:46:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47f5ed94-eb52-4cc6-8a49-08d931c02f67
X-MS-TrafficTypeDiagnostic: DM6PR12MB3035:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3035E7074C11DCE4497FD261E50E9@DM6PR12MB3035.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tWmLsRq75GOFxgz5ElZdKveLYOyjCzjc803NmyHH/NgkB0W6IQObzHZ6DqwXIRvKv4GeCcaFulpv3/AvawfDRzt+nAxFsniCj2JV9XRFrhBKIBFIra8vXMWZWKJ+CPrtDbSn+8pRQWSSrq2N9+DaAoEeyvuGFj0OaT3DZ3O0fr3rst3WHK1sNG2ovB17gAXOSzpcs1zc+BbAnOkq2coPRzDF2K+Ka7WiRfKTZ4UQaQfnkQhHqZEevtD9QROPY94kmQ8o/BBjIe7mOMEHLAn1LJISd/K3etPU+QFV3PSJFjAy6ezRkMj5xR89pfJ55Grakro6jItRlwE1Eckh5fePSYSbheMiujJXSZlKFNyumNM0rcrfOXYci3maI73eitSqnZTB/VvqTpQnkuD43iaTdzH2GoyTA/aY1wgqk6AFz3KudNjKGdfSe2U34ba5nz9q/wRw5OgQDy4GuGxUraUdp21IHZaEbgxl2Y6gOH5at/ZhGtdm8WtV0OgrmhKVU2vOBDYpJgWaU3lFF8+JhgaLnP0NQQPRr5iO87EfcGkPr79Rj5JyVE2Ku6pBlRglsAI2FkGuULHApDLlZ9IG+yPpaVbbBDCado9ShZjiauBQ3VAHgQv3bCeIWHFz1PjE6j4Iydphwc4geHjIfFGqEe/J/IearrdSHvnhmyy9vc4uLzww1dffB2eBQWp9CfYERGBZoNj7+qLIl1FC2nTBeMzymA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(2906002)(8936002)(8676002)(52116002)(6666004)(66946007)(16526019)(186003)(7416002)(53546011)(26005)(31686004)(478600001)(66556008)(66476007)(83380400001)(6486002)(2616005)(31696002)(16576012)(956004)(38100700002)(38350700002)(86362001)(36756003)(54906003)(6916009)(44832011)(5660300002)(4326008)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3paWEtzdDVWbmtMbGZ6VFJVVTllMzlyMGpEcDlmOVM4RU1qaThCcGMzcDQ5?=
 =?utf-8?B?dnBJZUlaSjdTQkxoazFGY1NNRGxQYWpJSUFWVXJ2VFdwNjN0ZjF0Q2drQjdk?=
 =?utf-8?B?U05yUzBFS0FtV0FaaUpMTys2SWdkNUc5SWZvQWFSdHVsUHA0RmpCdHpmRFRG?=
 =?utf-8?B?blRUYjkyaGpXOUUwRVQ4UGZxVDBVMFhCbjN0MGhrY0hNbmZtaHdZaCtSMDF2?=
 =?utf-8?B?TGk0bHgwazRDU1ljWUZCMGdPUUdNUGZsbkNpeDF4L1RiUmNna1FUWlVHR29F?=
 =?utf-8?B?SExWUDl2ZWNmVS9VUDEyNjR2TEMxRks3VU1NdXFNY0N4ZHBZY1puVkp4QUVh?=
 =?utf-8?B?aVgvY0tEb1BOZ0YrWnREcy8zVHRjZmdtYlNzM3F0ajI4OHVKK055VG1xanBi?=
 =?utf-8?B?SzRnT3pWY1B1TG9BNHFYcG1tVDBCNzJxQ0QwU1p2M2t1TW9hVDBiOC9rNU9N?=
 =?utf-8?B?M3FhVkErUmdaMmx4VmNLR0V4bVhReEhkMk8yMmx3S0t2RHJCbnJRUlNGYUc5?=
 =?utf-8?B?TVRWbkdrRjcvT1ZxdTM4d2JMQVRuOGErdEJtMlcvVzRKNGZyZWkwdDJYMDFI?=
 =?utf-8?B?NlZoNXc5Q0liNTl5MUxHT1JZRUR4VWk3Vmo1NUw4YlRQc3ZJUXRwZk41MUV3?=
 =?utf-8?B?UDhHdU1JQXlOQ2hqR1Uxa09DZHZjd0dESHBuNkc1YUNPSy9uNGliODUxd3Ja?=
 =?utf-8?B?QThlRUlQa3BNYVAvZ3lxdTRFT1p0SXdmbGluekNZdEZoMXZuODNvZzhFMitn?=
 =?utf-8?B?c244YkVOVU4xbmkyNFFFZHlpNGI1c1NyS3dUdnNmZk9qeWNaYmlMa01HSHk2?=
 =?utf-8?B?Wmh5dXdUUnJWYTZhYitQQWtmTk1zYStHUk8vb1R6UExEOG9JbytZYk54MDdu?=
 =?utf-8?B?OVdvOE9Ed2dQbzduaEpoQ2U3STgzemcvR1RSak5RN3EvWlNGbnlHZ0N6anZE?=
 =?utf-8?B?NlBMcDB4UkUrWHhwdFhUeHl6NUlsZXZJbDZWQWx2QnR2Q1M3M1E3czZhdG02?=
 =?utf-8?B?aVNMTGlmSC92V1ZsdEtFU3hwMnBDZHhXazRZSjMzV2xHTFJhM05hd3VBTXVj?=
 =?utf-8?B?Zmt4eHNNZDRoMFlvVFk3STlHMEROZEM2V3h2Qkg2VlRGUFI2WUt5WE4vcVZ4?=
 =?utf-8?B?eTJoYmxCcDJTcGErTStoc3hpazRkUzBwS0daNFBLbzhrcTN6YVZqSndsSlpE?=
 =?utf-8?B?QWZrNHRiMlJUSC9zcVBqNS9DWWRBWXhENXYvNURaNGtUM2IrQkYwZlJ5UHRX?=
 =?utf-8?B?dnhhaUlxS2p2WUdVa2tVcUh0K0tQUW5wdC9wVU4remhMSGY3RGxkT25ibFF2?=
 =?utf-8?B?THY2SFRYU3dBNU5QVmVZcjhBYmsxSnYvY04xSlJJOG9ZU25NYmhOblg0SFZt?=
 =?utf-8?B?MUoweWI1L2owNjgzUTRMY0l0NWdBOEQ5ZW5VZHdmZkVKdWZ1dVIvODJveHI2?=
 =?utf-8?B?V2tUVXRYRGxtaVF0U3d3UTU4ckMwREJkMzUvWGdoamtZRVNrdHArVmR5Z3JQ?=
 =?utf-8?B?THpQdE91UVU2dEVaTGJZQnlDRDFtZ0U0WW1hajNOZkYyYjFrWTREVU5ETEt3?=
 =?utf-8?B?SWtnMEhvbWlqcWZ1Wit1bTQ1Wm5MRS9xMmEwVWtSNUxhaEU2VkZhaVRCQllP?=
 =?utf-8?B?TER4dDFWUlhqOTZZeGhJNElhOFFHZE0wdmFiK2lPMFJBejRpck5JeDZUQVky?=
 =?utf-8?B?M2ZoVTJDbWhjTVhZcnFrYWxsQ2Z0Q0kxeXlTU0ppK2tEL0Q4WVBhVFB1OGNa?=
 =?utf-8?Q?HxtHEZd6vXeSVt0nslYHhOu4OTMnrjZ8miHEtoC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f5ed94-eb52-4cc6-8a49-08d931c02f67
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 18:46:15.1320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3SiVCvlB9ViIunsf6TBjQ7F5CVGYxvoRg8i3fdF1RcSatcHI/oZ0ChGzAPqr4G1S5Jj0Myhutw0lDPQl3c8EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3035
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Boris,


On 6/7/2021 9:54 AM, Borislav Petkov wrote:
> On Wed, Jun 02, 2021 at 09:04:00AM -0500, Brijesh Singh wrote:
>>  static bool early_setup_sev_es(void)
> 
> This function is doing SNP init now too, so it should be called
> something generic like
> 
> 	do_early_sev_setup()
> 
> or so.
> 
>>  #define GHCB_SEV_ES_GEN_REQ		0
>>  #define GHCB_SEV_ES_PROT_UNSUPPORTED	1
>> +#define GHCB_SEV_ES_SNP_UNSUPPORTED	2
> 
> GHCB_SNP_UNSUPPORTED
> 
>> +static bool __init sev_snp_check_hypervisor_features(void)
> 
> check_hv_features()
> 

Based on your feedback on AP creation patch to not use the accessors, I am inclined to
remove this helper and have the caller directly check the feature bit, is that okay ?

something like:

if (sev_snp_enabled() && !(hv_features & GHCB_HV_FT_SNP))
	sev_es_terminate(GHCB_SNP_UNSUPPORTED);

Let me know if you think I should still keep the accessors.

-Brijesh

> is nice and short.
> 
>> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>> index 77a754365ba9..9b70b7332614 100644
>> --- a/arch/x86/kernel/sev.c
>> +++ b/arch/x86/kernel/sev.c
>> @@ -609,6 +609,10 @@ static bool __init sev_es_setup_ghcb(void)
> 
> Ditto for this one: setup_ghcb()
> 
> Thx.
> 
