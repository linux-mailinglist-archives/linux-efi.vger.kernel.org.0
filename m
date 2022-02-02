Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617734A730F
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 15:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344936AbiBBO20 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 09:28:26 -0500
Received: from mail-dm6nam08on2089.outbound.protection.outlook.com ([40.107.102.89]:35265
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232327AbiBBO2Z (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Feb 2022 09:28:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sa8yhlLTTl45ND8jsHeM7/GJEBsmL8hD3poZvhE29WVDBLFZv6Zib4og17jvjO0dBn0RmQI0LGX2l+As/gLE6ctr470fWuz3fwj5+vIiEEEj3995mJM3Qth2AXQs5JMQFzErcLE+VbhOt14GkN3a662XE3qDMSHlW8omgH5A6aN5RaI8phRhv7ROI1bhHiQa8SFm1w6jLXJnAeeIBFxR1IxelRR/gZIil31zbf1AN2aUquadsIxMnuVomD7ot2ffqPzGENJGanKjV1wpHu9ThHCEpNjdOPhbHNYtiAZR17mHPg5r3r6men0RXmEqN2zHU4N7EB4a3PgPNXKBzlOTIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pV/gA8mgqsdB908CXzftC26UGYyyCVOGBIkN5ZS4y1s=;
 b=NoMiUBYBcGdZHi9CYB437S2DHfE2asErNohlUvD/a7ZyUZ5ig6zcW5aOT02iiFIdKbneKyFfDPVeyHSucVMlaTMZlCWr3uD/ggpW6RZWMOdiEc7ziY+CM39QJ0NqrQox4hsHYS563cFkIUTpBSBkSqE1LKJzLq/42kx4djPrDf8/SWhAdA0lWLy6sBx9tQ/nMdSkhmdh+nDNQWV9irEoHiHuM0BZCta2zC+NABLTE82A51vJ8R1OZ8knL6eIrq3PZYz6kVtJaHuJsQyZla7le9guc4z18DIW7GyHUK5UWu4VMF6+ysY5p7tgggZX+Mfwm5u1jWNbIddmH2TR9vdKkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pV/gA8mgqsdB908CXzftC26UGYyyCVOGBIkN5ZS4y1s=;
 b=zblZtFQGAalFFeZGrCfMWe+dyaJNWCtEx0grH02BlRUsVhymxFn0h6XCmEb+bu3d06DCBsn15EbYSigI5+xBhNCvYR9DQze2DFAvsxYoH67sRjVPvVe1TLhe30rYzRuDeIO//1ch59RBy53ExzgyY82jhFK4fYbo5BYPu9zeF7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by CY4PR12MB1784.namprd12.prod.outlook.com (2603:10b6:903:11e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Wed, 2 Feb
 2022 14:28:23 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::500e:b264:8e8c:1817%4]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 14:28:23 +0000
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
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v9 10/43] x86/sev: Check SEV-SNP features support
To:     Borislav Petkov <bp@alien8.de>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-11-brijesh.singh@amd.com> <YfmRBUtoWNb9BkuL@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <02102fda-63b9-5da0-2e2b-037761cc0019@amd.com>
Date:   Wed, 2 Feb 2022 08:28:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YfmRBUtoWNb9BkuL@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0336.namprd03.prod.outlook.com
 (2603:10b6:610:11a::8) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e88e0d54-d393-4a67-aa82-08d9e658444e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1784:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB17843353FE2286E370593919E5279@CY4PR12MB1784.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DBquErdea6El8Avck4Y4yqRaOSKiXGliIampKBzWm/i8k082PucOH8R0gTWpKXZsRtKoSMhBL1wloUM8cwBfA1eD0h3Hy/pQGx88gnwH/gGaBBCKww7yCz/AUFfpkDSZ3fpL5XlzRoOqRQwvaGPdfXnLGj4eKzJLvG+f8XfubLnIV1sNKqhzpmILYnViYmwj0wF7h1rn422pDwtQjS3kz11CPvn/4APfzh5XWnqRizospK4r3mD+SUBYsZfIUzjFBiiu26r4PmjZTdYIIHwzQhMO3oT83LCIPdx+DrABjEqQIUcNNi+K60nGs7989qh/ddc7TtpRfiv26vcgumqIh7XyIsDP4HGySAHByOhD4H4m/fOaQF/Fe2kHcoVebT82C27oXVJLlhy8Dtok1zGsU+uYBoPBPRj5qJ/7zJsoOXTCiWffEARUe+3AkAr1FGAfK5BaZNc9ourDMIS3CmwLPzEJAQ4vOxPPYw0C1PaQS/bd12r5CRJTq8Vci4QA3egQnQohaM8Pie4iJbmUflb2oX9Um/o/JQwIp4jnJUMYzCagszBfosv9jMpPOKvY/W+qgFEqisWPRAr+o7UJWf012wmXNfcvoRLlLqZYCF9TFYzzj3Nb05PvwgczhdWStudLY1tqVBu2Q1KTYusWbtNUr9Pv6/JtXIO71jXtW3BOKnPKsnwtC+jdXkkReiVK6QmqUhCp2TZDNHH+7CxUB5zo9wd7+J74NZr2hbyMbrwWSbg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(31686004)(6666004)(6512007)(53546011)(6506007)(186003)(36756003)(26005)(2616005)(44832011)(8676002)(508600001)(38100700002)(4326008)(86362001)(31696002)(7406005)(8936002)(6916009)(7416002)(316002)(2906002)(66476007)(66556008)(54906003)(5660300002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVA2TDhzMFMrSHBzTUprSzNkZjBlWG1US2Y3YWxTZWduS0s0UThxZTYzODBw?=
 =?utf-8?B?dG1kQmZRS0hIQ0FMblJXTHJ5WG5yWEQxMUlPWVk1UnRFc0k0OVV3TUkxUm1R?=
 =?utf-8?B?MXkwTGFBVE1FeFlkS3MzL2VrQnd6bmZqR2htMEJldkNENWd1YUsxYUtGb2Fo?=
 =?utf-8?B?NWR4dHZnUVVUMkRNeXRSRStpYmlobGdMVkJudDl2cHBQaThONDJORXRQMGt1?=
 =?utf-8?B?S1dxNVd3WVVYeHFXOXZXMWxrVDRvVUFGd1dRUUhLbHBSN2dwaHpHYmV0TTV0?=
 =?utf-8?B?aFc0RFY5b3R4c05DNXVZVUhFN1FHSTFINlFEdTJqTWRycUl5QWZQY0JWRVhm?=
 =?utf-8?B?Smh2dDNIWHc3OHpBRlFJY3lnSjF1c2VLME5PRXdYU0oxLzd1TFhpd3BnMEhC?=
 =?utf-8?B?cnloTnJwSTdDSXFvamVaNVNHL0FLa0NiczFFU0FIRkJJL1Zuc1BtbGJhYVNR?=
 =?utf-8?B?VmxteFVwejRjQUJtZ21wVi9tenhRZGtlTkNJeWFBUFpmT1N0UHVwdjgvSE5r?=
 =?utf-8?B?RzdFamhlN0dRcFRjUWwyUFIrZkRSckcwb2J4Y25zNWN1aWM0ZEVRQ0xIZnNB?=
 =?utf-8?B?anBBNlNCTHJwa3JZdW5ybTNyYldyOGxhTTcyQy96cnN1RFNNelFTSGZoVGk3?=
 =?utf-8?B?UjNHN0Y5YjU3dGpyc3ByZVJtOWRxL1Bpd20zMjRPVHBOQUsycFNmVVdrRkYv?=
 =?utf-8?B?MHZIWnYzaHRFS1BjUkVHb1Q2UDh0dEdTS2h6aEpIMkFGNW9UeXErKzlwWTl5?=
 =?utf-8?B?NkFXN1JhbG4rdWQ2dEk5UG9oZjB1TUh3OVQyRWpkcXF0bjVReFR4aWxZem9H?=
 =?utf-8?B?K2V1dDdnNmRwWkNVSGNjR1ZiRGtrenI5RStyWlBKRlFlQythZTRxZndGblpo?=
 =?utf-8?B?WjV0Z3NTWWNqNlNHSFBMQ1FDUDU4Z0l6MkZ4bDVoV0xGY1hoTmYyZndzY0l3?=
 =?utf-8?B?Z25DLzNpSEVNaDlUajgrbzBSc2ZWSHJrbk1EM05UMXlhSE5ZRmRQc1BLRjdu?=
 =?utf-8?B?YklFSzJ2YzNzSUEyR1hKTVRkQVlndjB1VXB2SUFGcTlDVDk2djdML0JBQzF4?=
 =?utf-8?B?UnRGQmZ1RWwyb2RCR2ZReUVsMWlRUDI0VXdTRFg1d2N4ZUg1dWlTbCsvVWha?=
 =?utf-8?B?NmhReHpMUDd4LzlCc2h3YlFsanRNcGk1Rys4a0dPL0NMamdiVHBRQWh2WEpt?=
 =?utf-8?B?SEpCN0hZQVBFdkZXcEcwMUxncm85dWZML0RxL3JNVXN3RU9pQXgySHgwRjdk?=
 =?utf-8?B?cXVYL2ZxRVhpRUVoWjYwbmtzQmNKQ2daSTFsd1Y1cmpLUXYyd1FMa3JhK0VL?=
 =?utf-8?B?NUdoVUZXZnhXcDAycGtxYzRsMlhCSkJQZ2ZQdy94cW03OUprKy90Rm5VVHdP?=
 =?utf-8?B?SzRpNUEvMzN6RmdBakRacjQ5Zmt4VXRvWEQvUXB1V2Fkbm1wbW5lRk45ZkRy?=
 =?utf-8?B?M09xRDRXcStqZWJhNW5La3lFRUNQV05ta08vcFN2YWo1WkVJdG5tWjUxZER5?=
 =?utf-8?B?SmxSZm1OWGdnc1hNeGdsT1k3S25TQ01kaXBJSWJRbWhvUUh5TlRnaVphRmlk?=
 =?utf-8?B?cEdLUmtKSnRnTmlPeWRybEFTN2M1NXZET0xleDBIa3lRc3lTdXJvTXB2emFZ?=
 =?utf-8?B?ZlVZaWNHUW1XRll5M1pUMDdtS09BdTE4a0N5ZjdkSkVtaUlseVozRWE1RnBi?=
 =?utf-8?B?WlNuOHVEYUErL0VBOG56aTdVVTRUcXA4bEczTzZYMjNjNHhucTh4dzNmSlh4?=
 =?utf-8?B?Y3AzblB5R21KcnpjUEIvcWdZTTcyVlp4Zml4b2RCQTJwMDVDcDBsaVc0aVBE?=
 =?utf-8?B?OVFKb2NoZjBlL1NIUDVKWDEzYi9PYndJN21tMmsvUEJFWkZFM1p4YmxDYzlR?=
 =?utf-8?B?Qjd0djdNYm5aWHAwNU5TOGJ3T0p1RnkyNlZoaXU4clhXODFZSzVJZmU5QndZ?=
 =?utf-8?B?ZzdLdUlZWGtFYzFJb2JaakpFK1ZmTDViM1JvNXd0SDhFL3c4NUNyZXFNdlNQ?=
 =?utf-8?B?WFdyZjFMSm5pYmxSMStvTGJsSnduekJWVWVaT0d2RkhjN3QwNUdHdmtQRDJo?=
 =?utf-8?B?cXZPRmkrMFJNalJlMmJHU3hmaW5iMHZmcmRISCtkK05jSTZYSk92OHVRRy9C?=
 =?utf-8?B?RmlpQkRBZHlYcERldFVQaEVHSkppZi9vVEJ3YVNscWlrMmlUWXluTWFLVXQy?=
 =?utf-8?Q?RUs/xefCi20UjSjSbDunzCw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88e0d54-d393-4a67-aa82-08d9e658444e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 14:28:22.8871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VA4O6DsPxTs8ARmkSZQ2JeMkgc6Vvwr4lL1DTCzCHfvuiLz5CXWIbKzmXRirTSFBvp4D0tjSKNVkSdbcHRmcVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1784
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 2/1/22 1:59 PM, Borislav Petkov wrote:
...

> 
>> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>> index 19ad09712902..24df739c9c05 100644
>> --- a/arch/x86/kernel/sev.c
>> +++ b/arch/x86/kernel/sev.c
>> @@ -43,6 +43,9 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
>>    */
>>   static struct ghcb __initdata *boot_ghcb;
>>   
>> +/* Bitmap of SEV features supported by the hypervisor */
>> +static u64 sev_hv_features __ro_after_init;
>> +
>>   /* #VC handler runtime per-CPU data */
>>   struct sev_es_runtime_data {
>>   	struct ghcb ghcb_page;
>> @@ -766,6 +769,18 @@ void __init sev_es_init_vc_handling(void)
>>   	if (!sev_es_check_cpu_features())
>>   		panic("SEV-ES CPU Features missing");
>>   
>> +	/*
>> +	 * SEV-SNP is supported in v2 of the GHCB spec which mandates support for HV
>> +	 * features. If SEV-SNP is enabled, then check if the hypervisor supports
>> +	 * the SEV-SNP features.
> 
> You guys have been completely brainwashed by marketing. I say:
> 
> "s/SEV-SNP/SNP/g
> 
> And please do that everywhere in sev-specific files."

Yeah, most of the documentation explicitly calls SEV-SNP, I was unsure 
about the trademark, so I used it in the comments/logs. I am okay with 
the SEV prefix removed; I am not in the marketing team, and hopefully, 
they will *never* see kernel code ;)

~ Brijesh



