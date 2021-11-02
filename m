Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF9344357C
	for <lists+linux-efi@lfdr.de>; Tue,  2 Nov 2021 19:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbhKBS0w (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Nov 2021 14:26:52 -0400
Received: from mail-dm6nam11on2065.outbound.protection.outlook.com ([40.107.223.65]:42465
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230230AbhKBS0v (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 2 Nov 2021 14:26:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQYHsnC+X5bpCIzz7RW7luAwlpNuvIOceNlP1ppApbRZZIfdyCfL4BSBnLw6a+MoVNqa7EtuiJWd1nXI/psFkymAtfvMoezllnXi/2NZN4FEGf41AL1SPzrAHBI9EjnQAZ4DR8aew/ueYHwsM4nCBKnbfUnmPnZmVrFgqoWPNQuZoqjivzmuglEKovHJlZ/w2lRZzDLy7UodgtmxOMpxgUb+JoauNT/S7Z+oZjEIBg/7trbcKJxKznUZjzFhrqi3Hp9RVY1VQ6X+DBmEIl3unQJhBCEsvgFvoAT7N+2Iv4PtrnJGRb3++Ya0GwV4uNmjIq0FI9l+y2b1LAYXbfnDUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTK9r1HC7NochYIi1+l1cGqLYsg1L58z/SkklSuvulE=;
 b=WmDuPvyz6DlPOwy8Rrwo4O3iC6/OBBztPLWWb6XCdS0mRm05Hpz097BUkfREPDNMLQNLqjQc7E5sXw1GivymzlTvE+8hP4PmIHyMr2HeCrZg7HgjN1ML6jp5HzjrHbY73W70SURzJwJ+XK2fYrhFC5COXCLFlKsnbAPXzBXXUhaTR50tHCVy0HziaTIFZ0FbSs197u3LxXMG102oilFF2OWL2QvS4cVfW1ublTr1vMZ2wuxNHdl0PzcXFkbVbLVAZl0TJI2hl9qxNB/yGrF2WsMlN/o9letR/nJz0nd5ZZ/4rh/8ufYmVJNODTfOkcJxr2uCGX1SUx+NPNfNkQMP/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTK9r1HC7NochYIi1+l1cGqLYsg1L58z/SkklSuvulE=;
 b=ii7QDrPEmc7ekVX50ZLfH1Xr5an6RUieJ/fVK9IXoFPqBChsilx7i1Cj5dWLaoPdFPGHaBrRCkd6eyWQ/g3EZmmSuZ6qo817YS1V26nyF/lg1ndBJgahq0Dp16xqcncXHg6Sm2Y7utJhwP+39B1E7o7C07TxldKuzUeVC7IEC3M=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4573.namprd12.prod.outlook.com (2603:10b6:806:9c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 18:24:13 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::e4da:b3ea:a3ec:761c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::e4da:b3ea:a3ec:761c%7]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 18:24:13 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v6 14/42] x86/sev: Register GHCB memory when SEV-SNP is
 active
To:     Borislav Petkov <bp@alien8.de>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-15-brijesh.singh@amd.com> <YYFs+5UUMfyDgh/a@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <aea0e0c8-7f03-b9db-3084-f487a233c50b@amd.com>
Date:   Tue, 2 Nov 2021 13:24:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YYFs+5UUMfyDgh/a@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0285.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::20) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.236.30.107] (165.204.77.1) by BL1PR13CA0285.namprd13.prod.outlook.com (2603:10b6:208:2bc::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend Transport; Tue, 2 Nov 2021 18:24:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ce1e88a-187b-48cc-5049-08d99e2df8ad
X-MS-TrafficTypeDiagnostic: SA0PR12MB4573:
X-Microsoft-Antispam-PRVS: <SA0PR12MB457359AF12060A0E991C698FE58B9@SA0PR12MB4573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DcraXHCpfVdvhtnfBSW1tLwQxLENajg6vIC5UYqFMCmwClBjnreqwFJpyjXB+WdU9d7IwYM7NqzOpux6CnSbrBtZLubvxTh3SeZ9HkFeGFTTZ2gJO3VQ/H3HHoMpm2ivF+ps9q6p+HkAa0Flkgx5KL+pwOV5Ix7BHN1Owh8u7erd1stj0vhN636fBU/7/xo+Z9Lq3lvevlPPhasfMWdvg8f4mk4dp/vCEw7+JVFtdMMAPzzXEAPOxTO2Mb/Syk/9B5hMxqFnb46NIRRJyA36xQdpwrpuUcts2WncomJpHcWrZh1CBRHVlscSZSZGcaKKpLrXw9aV9IDcZlfLEiCm/uJATLjwWbjrN4P/DrNLeMly2JLHfKZenwtfuOFMWjnWry22bbu8KRN7tBAhHjtMsJrNoXMw6QXOPckGaqubvuJDPZbdro9a9jgRHqlTUtUmUIse1ccG2+M6WiCWLX9BI8/RThnteVQoa6G8KTX+LNnHvrztlpTnPB/77GG539+8sZRLHYL67i4drLDy5MhGlC9p/lVhXxqHA3W812tSVCvuo0yzqEyWmueIjRglQtT+9a0HkEFUcrllXZ2esb/+uMI1FOupcGL1wsZPw+kzG8lcZUcobAbmrIwNfpWXfPsuNTaUULk0N7ulV29gpoVpR7aI65ZUjbxmbvG6rvmVqcQSr8mZ/RITwAqhbT7XIAKmYuxnQ1yiJ98IArto/0uVjppJlWG3HpOZ+MR24dQOORlF24+mF06kUvhJwUFPuxgGeqTYowd/lILccEDCiH6GdzICIg/+8oJ1meSZoilkfMPNYggzVed67SrtWXydD0Iav5yuHlIH2YIpuZsBB22K4K6CvdsKkAP6qZ7JezFHl1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(66476007)(2616005)(508600001)(5660300002)(6666004)(7416002)(66556008)(7406005)(44832011)(66946007)(956004)(4326008)(8936002)(53546011)(966005)(186003)(6916009)(31696002)(83380400001)(2906002)(31686004)(316002)(36756003)(38100700002)(26005)(16576012)(54906003)(8676002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1RTcWVrK0VKNGpXY1BFd1F3QjRvL256a05pYiszekh0UWJzM29UY3JJcUpr?=
 =?utf-8?B?RGVFNm9oUU5tM29Id0hFV25JTElmUDA4WUFZcWV6dzNXYjR5anNMcHJBeWpT?=
 =?utf-8?B?TkdvUFJTaGM5NzlhaGQrTXUvWXk3QVI1c3VQSlVjcitkSlI4SHN5RFpQT3J6?=
 =?utf-8?B?U1NndWRlTnBUTjlWemZrVXA0UG1ZczkxZnJ2ZktUZXlmbFUwaFZPZzRoZkVh?=
 =?utf-8?B?bWlObU45ZmFvWFNPeW53eTZLdXgydUQ3VGxqeGNvZ2Zhb0UvUXJNS0tLd2Vx?=
 =?utf-8?B?WTN2bWoxSitqczBFcGpud2VGUUswNW15ajI2WW5va3FCS2JJOXVqYXdWWXNj?=
 =?utf-8?B?T0lHYmltODNOZkVMWVdqemlsNXljbmYvNklMWEhzRTRkQzBNNFlFd2N4WjhW?=
 =?utf-8?B?YW14cEYwVEZCczA2N0lYazVDR2x5Qzgyb3l1NU16UHVwdHlLV2hLUFNYQTVP?=
 =?utf-8?B?MVFyaGR1OXFMMTVyNnppMm1qR0xMUmsvMU05djVSMVlZa1FLcVZaRU1BYVpk?=
 =?utf-8?B?SWU4WGdSTUVVeWg3YzFiZE16VGs0eXZDdlVaVHliZmJvT1hGQXUwOVF3UWNW?=
 =?utf-8?B?R0Y4NTNDVDZnd2xsUlVoRzQwNXJNRnh3VTJKS2tsaTNpTnA2aldtNjdITmcx?=
 =?utf-8?B?Z0FTN1k1MVlZR29IUlNFZmNoODV1UVZXUkRFaGN0WEpSZVlSbnNmOVU0OVN1?=
 =?utf-8?B?UXFyMVhveEFqeEFjSk1LcjRucFdJWWxFY3gvQytLMlVPdnpUK0tONU1SaWcy?=
 =?utf-8?B?WTFjNloyalJyTFM1bVZVVFUxK0N6Z05xSEV6RkViL0FpSE91K3dvbWFScitj?=
 =?utf-8?B?R0xoOGFTMXBJSU5GUld4RUtvcVlObDRVUmxObkFucmJNOUpzaFN3UGwxcEJG?=
 =?utf-8?B?a01sY29WVGxXZldZOS9WdHhRUjVCeC9BL1d3MllhYUZodzNweU9jdStwL1JN?=
 =?utf-8?B?YUpoYnVUUG9DODVqenVOUnRKOWJNZU1EY3lRWW9sMHM5UDg1NVExaVMrTXRR?=
 =?utf-8?B?NGcxY2xyT09MTDdQTlFodVcrYlZqMFVqQWVGZ1ZGSFNUakJkK2xSRFBCWElQ?=
 =?utf-8?B?N09FU2FTQTVES052SlJ6MERaSW8zOFFkRk5FclpITlhFTTQ2dzFaLzB5RlFI?=
 =?utf-8?B?WTBNcGtwMkVzdGYramV3RG9RZy8yN1ozQk0zUUFkb0xCL2QzY3Fobm5UNU1o?=
 =?utf-8?B?a1lOZ040Uy9zSlNTSS9ybFRydVJ3Tm43OWhNdUZLWlptMzFFcTdmZ1B5SmY1?=
 =?utf-8?B?am5xR051ZDV1ZXFLK3FyWHB4aTVCZ3RHdXVxOGJJZnJSeFQyb0NNYXFnT1FO?=
 =?utf-8?B?b0laQ0pUQm0yMFFWQlliak92V3F0Y1BjNjZ2aU5YZG1PYkx1bndRUmZ2Nmps?=
 =?utf-8?B?RUZYNU85MStNVGJ0d3c5ZHJPYUcyTUtnRXV0a0I1WS9UeXJrend4YnNGVjJs?=
 =?utf-8?B?bExQUVV2aEd0K2pRSEg4bEJsRFNITzF0V0ZDREl5bC9VTUNoRDk3VEQrdUww?=
 =?utf-8?B?RnNNRW1zd3VBZXZ5VC8vdFBVZmpEK0xDMTVzVEU3UWJFNEtMem5LbktVeExH?=
 =?utf-8?B?R2VtUVZyNW42YU9JQi9qRlVScHlXaVVPazQ5RlYzVWw4QUZvemlLNGVGZzY5?=
 =?utf-8?B?Ym41Z1pkaFdGQW5PejdLeEZ2SSsvUVh3N1hpM3pRRStaYkRVVnJVMGVEVGtS?=
 =?utf-8?B?SHZ3K1pUbHJ1QUhCeFo4QUVEdTFXcDQxa2ZZdFVyNTJ4a2JEQmtaU2NzdUh6?=
 =?utf-8?B?QUlrQWovRWZ5OCtZaGVvRmp0YUM1S0NsenZrQUU5aEZEWDByV3M5aWFXQ1Ew?=
 =?utf-8?B?TnNrZ25RbmduQU9mQ3hpdFJrNGFyS2R2RUszYkI0K2J1OG9GcTkyZFF4UmRy?=
 =?utf-8?B?NUR2dzcxSzZoQm1LLzJvL3IwUE1iS0l1Vml3QmRNczJ1bC9JRTBOZTBYRjh2?=
 =?utf-8?B?Y3l4R2VSSFpnbkdmbEFIS0xWTjNYbXpmWkU0NlV6Tnd3RG5jbkV1cUZ6MmxZ?=
 =?utf-8?B?QmFkL2lpcEtLSDBzMkZXckE3ZEhEUWxlajdoY3lRMmlBc1BMMVFRaWZ3Q2Zw?=
 =?utf-8?B?REF1eWJKZWhXTGlFQnovYm5IbythYXV2Y2RJRmhmWlIvWlZZaHlZQTkzNlhO?=
 =?utf-8?B?VmVBWmVLa3B5UVlCVEg4ZXlTZ0hwVWhCOXFBcDRlNnYyNGpsQTJLSUtGa0hR?=
 =?utf-8?Q?93S3gbk8JhT4RIeaUR9j9K4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce1e88a-187b-48cc-5049-08d99e2df8ad
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 18:24:13.4779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLM/zMCC+k/w33HZHB61531EQxU9SXQuCBr4LkUyR64cVYgFAaJZvXztjXgo8mog8ta/h78A828nN60oLUxgkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4573
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Boris,


On 11/2/21 11:53 AM, Borislav Petkov wrote:
> On Fri, Oct 08, 2021 at 01:04:25PM -0500, Brijesh Singh wrote:
>> +	/* SEV-SNP guest requires that GHCB must be registered. */
>> +	if (cc_platform_has(CC_ATTR_SEV_SNP))
>> +		snp_register_ghcb(data, __pa(ghcb));
> 
> This looks like more of that "let's register a GHCB at the time the
> first #VC fires".
> 

There are two #VC handlers:

1) early exception handler [do_vc_no_ghcb()]. The handler uses the MSR 
protocol based VMGEXIT.

https://elixir.bootlin.com/linux/latest/source/arch/x86/kernel/sev-shared.c#L147


2) exception handler setup during the idt bringup 
[handle_vc_boot_ghcb()]. The handler uses the full GHCB.
https://elixir.bootlin.com/linux/latest/source/arch/x86/kernel/sev.c#L1472

To answer your question, GHCB is registered at the time of first #VC 
handling by the second exception handler. Mike can correct me, the CPUID 
page check is going to happen on first #VC handling inside the early 
exception handler (i.e case 1). The early exception handler uses the MSR 
protocol, so, there is no need to register the GHCB page. Before 
registering the page we need to map it unencrypted.


> And there already is setup_ghcb() which is called in the #VC handler.
> And that thing registers a GHCB GPA.
> 

There are two cases that need to be covered 1) BSP GHCB page and 2) APs 
GHCB page. The setup_ghcb() is called for the BSP. Later on, per-cpu 
GHCB page is used by the APs. APs need to register their GHCB page 
before using it.

> But then you have to do it here again.
> 
> I think this should be changed together with the CPUID page detection
> stuff we talked about earlier, where, after you've established that this
> is an SNP guest, you call setup_ghcb() *once* and after that you have
> everything set up, including the GHCB GPA. And then the #VC exceptions
> can come.

See if my above explanation make sense. Based on it, I don't think it 
makes sense to register the GHCB during the CPUID page detection. The 
CPUID page detection will occur in early VC handling.

> Right?
> 
> Or is there a chicken-and-an-egg issue here which I'm not thinking
> about?
> 
