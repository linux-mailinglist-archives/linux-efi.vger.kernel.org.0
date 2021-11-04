Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E6544564F
	for <lists+linux-efi@lfdr.de>; Thu,  4 Nov 2021 16:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhKDP3v (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Nov 2021 11:29:51 -0400
Received: from mail-bn7nam10on2044.outbound.protection.outlook.com ([40.107.92.44]:35937
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231283AbhKDP3u (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 4 Nov 2021 11:29:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJ5OdIj7JgpTteaC4/UzQE4F1MGpqI91rIEV6MYr9rTXoJmHCIbuxQnFNUprGGHTs8o4ZwNEv3LKGYb7asanyCxpjWGDYbqZkHTSNAxKZ9ejYSJyJsQZeVgxMh6fcNcSw4MHG6z2zxAOP3HCGFB8FkkLkBngjCQJK1mTqSe3ZO54dCZnFy59HhrS16MLEnSSvpOJcMVXi12xPBZtVGYrE6dTqJ1epqY9nfgvf6CdQpWr+DiU1qQ24sGMB3d3GiHo4SvkYe516nfiuVG0SAxZj6iYORNbgQvlKTosjYafEdSOtL0c5Ndhk8yA3RogWBDZpYKcRAkF5ZntQkJIcu8QyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdNgwUUDwYoVPZvgtQsnCWst5JcubBw/XiOq40DJgJs=;
 b=DYScDGfnWIJokBirhT7YadDHaaLEzV4QdI7eKGWtEMBzpw0ml+ewAYJqe7/G/BjXba9pYr6jmeLLu7mchVnyvV1fc6vXtwXZOljEfLSpFj7MHHdtlSrz7UrcKq6glt+RIPJyb0VN1XFV8W6QrMeBbUlIPQ5tu1GbwJTuAhx4EXBYfj1E3GZM93cVyVan/f3bPM2+nix8X68IgVgWBJd8maW97eXiN6fTEI5GjoYagGxzNxq44rXiqJmm9DW63jeGnvcMDpYslGgvNwAGUzPf2u9Gvi4Cfs7+YwVRXbPm7sDCVcSLLEHPVWh5jVPzFXh8b0T/H6TJt0wcheCxROJXpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdNgwUUDwYoVPZvgtQsnCWst5JcubBw/XiOq40DJgJs=;
 b=oFybe2xGyo8XF7KTjZT63x9Ptxea/cpRB3RtJ05Kr9VkeF7uLEyEtn5pOqWsjnWUcxqWRI9pgD1gNfzfuxUSz0sWMVmuOgcxFSW8RF42+EWEKAyMznkpnd0lRMcIJksNpeojw1DW9h+hgm14Bz9Zf4cvBf7irP0kd2EQaGvlGeY=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 4 Nov
 2021 15:27:09 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::e4da:b3ea:a3ec:761c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::e4da:b3ea:a3ec:761c%7]) with mapi id 15.20.4649.021; Thu, 4 Nov 2021
 15:27:09 +0000
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
 <aea0e0c8-7f03-b9db-3084-f487a233c50b@amd.com> <YYGGv6EtWrw7cnLA@zn.tnic>
 <a975dfbf-f9bb-982e-9814-7259bc075b71@amd.com> <YYPnGeW+8tlNgW34@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <47815dd4-f9ac-b141-2852-8f48c8299a5e@amd.com>
Date:   Thu, 4 Nov 2021 10:26:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YYPnGeW+8tlNgW34@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:208:fc::31) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.236.30.107] (165.204.77.1) by MN2PR02CA0018.namprd02.prod.outlook.com (2603:10b6:208:fc::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 15:26:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09d7f62c-b76c-487a-dac6-08d99fa79125
X-MS-TrafficTypeDiagnostic: SA0PR12MB4384:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4384A7FD748D5CCA981A09FBE58D9@SA0PR12MB4384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G0ksSp/bh+J82Y9NwYM52i6BiuRZPH7Y7b4HOQLM8oZ3G75D3EswxDQJfiK/h6ycJpfwxGPQ0Ce8UxQSSqMjMUzVAj5Ct2vaUEouwrXpIWK/Idg6bo8HJq5RVsF6hk52uzuwEA3/YqX23QHnVSmOLdHnt8aYSx4lW9MpHrpG9mQqVcN/nzhvYdHr95sO/rzDCsXhfDZTbdW61a+1cvSYvVveDS7dDvdIEz2UD5uqY0BRDHPP8msspwt6/gdvAAlCrt9ZknGXlGAIDSb5iW/j7T8Z+3qIlKCi3tl5EpmUao2OFB5AY2TPohCE90VydnVr5jlgjkW4X1x9Z4pt7h7RffId8YnWd65lnuxxd3447M9Ia9xBWuE5BOx0UUKd+8vGksJAge6TDtAR0i080cGE1NOKg2T5X2arrmJes8DhQXRaSbqBofddSIx6SZ76HUYktWQ8ak/Ei555pgRBn4vfULGiuyhPXNf4XlNNiJtlEpJGM/ZlNJtcpX9JaH1skoXQdkFmxBf/50Y4ThBuf/8JrGW+I/lrNeTu/1mcKRYq95ozRzXBshoL4TEirYFGa8mZ16XeBRIW4veE6Fn96gwsoJ/ExnlzSVJXnMeOBF71kMn2JsIsTRgDzIO2IFg6tP22tK6uxHMgDrYgowB0QzDbdb9ck0DGc/F4ovGIqwKz0kBM2CEyC4BuAqYu2Tc8gftErkgyCUiV+JZ4txEyCaY0YfYqn+LnwS4W9dy7NrhL5Wo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(66476007)(66556008)(66946007)(26005)(5660300002)(31696002)(8676002)(8936002)(53546011)(508600001)(316002)(86362001)(38100700002)(6916009)(36756003)(16576012)(44832011)(2616005)(4326008)(54906003)(6666004)(956004)(186003)(31686004)(6486002)(7416002)(7406005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0dRL3pvcURUanFxOWRIeVdKMXJhQ0hFa2hMVHpMMVZ3OCt5d1l0LzNySGVT?=
 =?utf-8?B?M0VjM2hEWi9mNmxPSkRBYXZOdVpqMVRyL2JTVEhXQWJVYmFQNS9ReHZxNmtX?=
 =?utf-8?B?eFBNanBqYzk3eVgzUFJydk1HU2xmdS8vWWh3dll2VkhNYW9vWnBPdDRXc2k2?=
 =?utf-8?B?UWdnbHk2L1R0UGVFRHQrWWhLMjVRQWZSbXhGb3M3b0dDOWhpUHFsQ2owenN2?=
 =?utf-8?B?Q3FFVW1ERTNKWEdlcnhCeVNtazk2ME1odjJ0ZXNaK2ZCVFpPR3RZODhoVXll?=
 =?utf-8?B?Y1B4ekZweTAwUm1OMHdIZmlTeTBZVVIrcW4wWkxlNVFSY2NzTW9ORlhpcmQ1?=
 =?utf-8?B?bHJyOHBaUW1wVWRLVXRHbEF1bVV4V01ZcUt3WkxpbGwybWc0T3Z0azVMVXRV?=
 =?utf-8?B?TUx6eWJMN0VJS1hWRWlvZ0hham1ESE03dmFiVGFqMG1iYTRTVElxMzRTUEcx?=
 =?utf-8?B?YnVzbzlMK290UENCY0I0dGxSTW9RUExYcEQ3RnFnaEJFRUhlbjVBSTNZQXRN?=
 =?utf-8?B?b1BFcVlrM2VQNllWRkJRck5RNVBsQTlvNEtlZnJaTlJhdzlwNHhCZ1lPK1pn?=
 =?utf-8?B?anNiY29wa2doNDFQbkh4RGRyZzhuQXZoV2tVSyszSzFtaTJvaDdtMTVickZM?=
 =?utf-8?B?c3JtZkM4YVdpaDhqb0d4WlFidVpVK3MzRVZRT3pBZWhXMDRQMGRPZmlWeDFy?=
 =?utf-8?B?VnA1eXJrYVJZUkxJbVZwNVdYZ1ZRdmIzbm9Ya3NXaDNHZjJzOW9WK2QzQzV3?=
 =?utf-8?B?eVNmYllVRHQxMGpnaWFXY20vVStYd3JpUEpqeHlYU01FSnJzV3luZ3ZpTm15?=
 =?utf-8?B?ZEluanZqMkdTR3ZkUFFQYlFWaUVGREkxdkRFM3lTdWJkOFA3SnAwTFNOcVd4?=
 =?utf-8?B?UmFzMVdPdVdjelNYOHJPTkNZeU1FUElXc05GUlRDelN5M0h6OElMRHJWNDhQ?=
 =?utf-8?B?azA5MFhsdm40UTZPOVk2R253ZjZRZitrNS9PSzk2Y2ROYm1wMVd3NFFnRG9Z?=
 =?utf-8?B?UUZrOG53L1JtK1dBSUpLb3dmRlM2SWVzMEVzK0JzSkFoUFNCZmVLcDg1Q1VN?=
 =?utf-8?B?c1pqSEI4NDlYcnduUUxtdlUyVXVzMFlLQS85ZkxBMmorL0tZZndNY2E4T3lJ?=
 =?utf-8?B?R3pJN0hXd2grejFGbk5qdEN0SWZVZzB4c2x5eEdkVUlSOUYvcDJ5TXhjNy85?=
 =?utf-8?B?Rms4eVlGMktuM1VaNU1nR0taZWJJU3RZU1Y0QytyU1Q4U3BpZFZOakNxR1Uw?=
 =?utf-8?B?b2hOcHB6TVV6NlVBcVBJMjRaWTBYWm4wYzF3ZENNTWZ3NlNBSVFZQ29PZ0dx?=
 =?utf-8?B?WFNPNndLZXlkeG5zaUdCTVRkUVRlU1ZlYWxXbjdiWlk1YjREUk9YZWtmR3Zj?=
 =?utf-8?B?OXZKcXdQcHpnNXRzdHVwNVU5WUdtMEhrR0xVRmx5aFMxWjBmb1orNzI0RzNX?=
 =?utf-8?B?bUE2RzlzZER0QUNDTVUxcHcxQm1TenUwOGNkVWJ2N1VQbDZUemtscCtGMzNh?=
 =?utf-8?B?RW55MTdhNzBjY2lwVTBXaGlBd21Pc2l0WTU0TDk2Q01kd21SMTIzRmtPSFlL?=
 =?utf-8?B?ZEo1YXl0dXcyQmJ6Y3lsQUdRMnRlTkNIY2NoaDN6SEViUXNOT3hkeXdnV3dL?=
 =?utf-8?B?STdmd01mamo2WDU3TktQaFlDelRRSm84RGlSQ1NIU005akRFQWswazFvZUlB?=
 =?utf-8?B?aVVxZjZtSjNkeHljb0xmYWFzOXpPd2EyRzVTaldzMVY2WHAzcXl1M0FMenlB?=
 =?utf-8?B?YUtTZllhY1VGUHhENTgySDBaUElhR0NOT1lJVVZidnFhK1E1aHN2VVN3bEJy?=
 =?utf-8?B?cXl1bjZDeE5FZmFsaVV6ZGNUUE10UTJMMTNJTnZvRG43bHBJd1pNekhEQVNX?=
 =?utf-8?B?ZlRTWWhkK1h0c2JBaWhaNWhHMDliejVZeDhFUStoSE9TQmlmVXUxSHQ4a3cy?=
 =?utf-8?B?ZUN4ZzlqQXZkYVFJMGNRa3NRUUUzUXNla2F2VGRkcW40YzlQeVIya1FoaUZO?=
 =?utf-8?B?Q29MOGsvcHF1aCtYYm9xMFAvR3FuTTFkbDlqTUtXOHEzdTZoK1VOSGVqNE5X?=
 =?utf-8?B?RWZNNWl6UlRwQzhxTHJnaWx1NEdSK0dVRXk2am50UVFyN0RrVENRSDJxdUVv?=
 =?utf-8?B?a1NuNjRCVHFVdG5aTGZoNXZ5Tkg1QnlucUFsU0FYQ0ozVHV0RTV0UHdoR3lt?=
 =?utf-8?Q?T1taD091p2kkWtY6753+6I8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d7f62c-b76c-487a-dac6-08d99fa79125
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 15:27:09.6425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJzsrvtEWx/TB6O9zaghZX83If1WSLGhaCZp9wzFsFIGUZ4OnKCmwJrYJZqxw/9CFZMH4q/rhpsozMyAW2fRtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 11/4/21 8:58 AM, Borislav Petkov wrote:
> On Wed, Nov 03, 2021 at 03:10:16PM -0500, Brijesh Singh wrote:
>> Looking at the secondary CPU bring up path it seems that we will not be
>> getting #VC until the early_setup_idt() is called. I am thinking to add
>> function to register the GHCB from the early_setup_idt()
>>
>> early_setup_idt()
>> {
>>    ...
>>    if (IS_ENABLED(CONFIG_MEM_ENCRYPT))
>>      sev_snp_register_ghcb()
>>    ...
>> }
>>
>> The above will cover the APs
> 
> That will cover the APs during early boot as that is being called from
> asm.
> 
>> and for BSP case I can call the same function just after the final IDT
>> is loaded
> 
> Why after and not before?
> 

I just looked at load_current_idt() and we should not get #VC before 
loading the new idt, so, its safe to do is before.


>> cpu_init_exception_handling()
>> {
>>     ...
>>     ...
>>     /* Finally load the IDT */
>>     load_current_idt();
>>
>>     if (IS_ENABLED(CONFIG_MEM_ENCRYPT))
>>       sev_snp_register_ghcb()
>>
>> }
> 
> That is also called on the APs - not only the BSP. trap_init() calls it
> from start_kernel() which is the BSP and cpu_init_secondary() calls it
> too, which is ofc the APs.
> 
> I guess that should be ok since you're calling the same function from
> both but WTH do I know...
> 

For AP case, we will be registering the same GHCB GPA twice, that should 
not be an issue. The GHCB spec does not restrict us on registering the 
GPA twice.

Of course, the current patch does not suffer with it. Let me know your 
preference.

thanks
