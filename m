Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB53C469C61
	for <lists+linux-efi@lfdr.de>; Mon,  6 Dec 2021 16:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241384AbhLFPV7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Dec 2021 10:21:59 -0500
Received: from mail-bn8nam11on2062.outbound.protection.outlook.com ([40.107.236.62]:36160
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1358275AbhLFPTm (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 6 Dec 2021 10:19:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibBlY6A6okpylftxtq1ONK3Sofo3BxhPNQiUFCUnIdlttbB/BhXOjvdXXaorKk1FYvFVofyCSh2MaqHP1ErRwul/C9i5OkjxoRdcVmKETGGJSwIC38H6oYHsyUV3M8JwoHMjtoa73SJu5ubqKwe289/AiHRz4HSmX5IJQCfR24a2MP9xywjCQjS6ETyUFP2J4umb8VnnpghYHnc0ZT2ITiGyPG5wPB29JdCMBo6eNYOOGsOK3RdeI9q8RunviMxNE9PIALZrJb8XNpr47HN5/D6thwVExc0ElW8AsArZuSMe1vVeoSa7q9OZqRAMABM8Uqs5asbdX73tXXnwW6NjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ehk9+XooOeWVJ5ZDJmmA5LuMUA5fV9eI0pOcs8X3zyc=;
 b=Xd3atJUBcHEo0/M6bc5l4Z2TE72ESrzlMWUjiCvAjhLaca4PjDXPxlifHnavgxQ9icLzaWow9i/sV3Vazlcj+u5ao58dr8K8SBm4J2f03eDSIIC164xSJbpPIwNmisECa9S665MpIZ1e3A/FSK5mSKbuseeBPnyxRnDYE8/TEmJ4FjPpB0AAL3Ivd3GPVMu1mnvBfel7nTj89WQ4APc1HeRQTh1aXuBV/djXA3plrj1BC/sgElwddUon3l623ipOlaJg+QkkkvBSrJEmenK2VlSrX1pfBDN1pJJRMA0p1IR51zlmkU2FzCLURo9sRJidzpAajtkVhfyGCWdNW8vf8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ehk9+XooOeWVJ5ZDJmmA5LuMUA5fV9eI0pOcs8X3zyc=;
 b=Clm8auuwScvSou4P0Q1vBE1wMNP50fTI1rxgWKvXo6RQlXuSk1zxk3+lgXO83pefy249111hacM/13TsU5xCTR1bZDT9sxWHBQAFBXAJSFPYws4iW4TYYsK8JFui4rdcgf0iuBHs9oEclZQ0iYDqqm5Y+BPtNfzOTlO7F1ltqz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2416.namprd12.prod.outlook.com (2603:10b6:802:2f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 15:16:04 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c%6]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 15:16:04 +0000
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
Subject: Re: [PATCH v7 10/45] x86/sev: Add support for hypervisor feature
 VMGEXIT
To:     Borislav Petkov <bp@alien8.de>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <20211110220731.2396491-11-brijesh.singh@amd.com> <YakHz5WCPcbNOPum@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <453e1ccd-50c6-d6c9-e4e8-49fff6382101@amd.com>
Date:   Mon, 6 Dec 2021 09:15:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YakHz5WCPcbNOPum@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:208:e8::28) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.236.30.107] (165.204.77.1) by MN2PR20CA0015.namprd20.prod.outlook.com (2603:10b6:208:e8::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Mon, 6 Dec 2021 15:16:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30410f77-fe9d-4b21-0022-08d9b8cb522a
X-MS-TrafficTypeDiagnostic: SN1PR12MB2416:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB24167DA7FF5E02EAD5EBA2ACE56D9@SN1PR12MB2416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m3ehpvNig/jhfXbDsr2EJUF7o3k0P1sBujtorsT9AKY2KwiM6TlKahw5UmLLr8P8bzB2dSoRta+AgLyuXK+vXWwBWmA9TdCrpyNulftVj517+/ucxvAo5D2HWptqYaDx3sfCC/51C21hQkvfFzcSQP+acNCsdJB2+vZIsuG6ofAlY/ez09Bz4iobsGNHftphXPjjcJQ7WPWnWPjoG+RfkAPKx+g/SEHGr0UVCF+bLYpeV3aSskRzoYnXIaKqCboZ2GRVZic0tGOCb2TYSpNeFgwybdg7rmbDD9Nc7TktYvHOMS7zOeOYRPy8DzZE1HPqrUacf19rA2sy/Ap2OKaHat6HaaimBgN6ZUkVJjP15+LbmtWOqTlZB9yOXaa6Wb5jU8IchWVKkupG9wPXpuOFp84jz0/NIAdszAPb+UV2BavKGt9wktKFpdUeOdk7E3OExnyfy2LGyB4qd3z/wrl7Dylkwl4LRQCkFr17kQ3XxN1axLuyn6pW+cfc++mxugX5z9FkTdZHQqPAsKLTZuSF+wlPU3HeT0WL6sQi06wHD7k9ZWRF4JwVioW5qVEvgh8kDQJjlV6SqaOKWGfAnsEnKcoTVSUfZpgKQxAXsdqXEsIgiqb8Nm6JHsaulHHTp0VXWKgG878FGPsKth2muWW1SEw6VKKfO/06YFuZT0VfPuC1eq3CROrhJgHehaRYPBoWMEpXF/gBkFQZ3RlHmiPqcxHDc33dLNN4j331yoORICs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(38100700002)(5660300002)(6916009)(8936002)(7406005)(7416002)(83380400001)(53546011)(26005)(66946007)(31686004)(4326008)(186003)(66476007)(66556008)(44832011)(16576012)(36756003)(956004)(316002)(86362001)(2616005)(508600001)(8676002)(54906003)(31696002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cko0cFpVTzRRU243RXliU2NjcWR2WXZ3SDkwbi8rdndnL1NJMUoySE44VW5G?=
 =?utf-8?B?MDYzb0lCMmx0OER2SG13cTNtOHNaaDB5MjZhUjVNVVFuUlh0ZDZYcUprWkIy?=
 =?utf-8?B?ZTZQcDlEVEJURXUwaUE5THBnYm5zL3ZyNy9aTFowUjMwWVVEODVkVW1jbXh3?=
 =?utf-8?B?QVlaVHJtRnNMakUzZVZHc0dSTzU4T3RxbEZyZFF3c2FQYWZ1TE11U1dxb1JW?=
 =?utf-8?B?cEhIaXg5QyswOW01Tk9BenhyWW5jZXFBM2d1VGg2ZTFCRS9NVjJKUW0wM3cz?=
 =?utf-8?B?QVphRE95bVFNbTVqcHp1S1hrSkpXbDZ6WDFCeUpZTHJzS0IzeCtIVUwrdUxL?=
 =?utf-8?B?OW1GNEJnR2F4RnZwOUV0bU0yanI3WU56QjdiYTVGN0F4OHVXYUhmS0U1Qzdr?=
 =?utf-8?B?MzJ3TmRkdVJJd2JydTJ1cURiUXFLbm5hSXZvK3JyQWtmcDQva3BQS1Q1VnZ0?=
 =?utf-8?B?enRTekF2UVN6OHdMY3Zqb0hnemZoUXYxb25jVzRKVHYzMGRYVzlQYXNUTkNO?=
 =?utf-8?B?VGVGT1FjcVRNV0JxYWtQcEJneXhuNmVtdkZFWlRXS09rdHoxUGxMVXJ3ZTlW?=
 =?utf-8?B?cGMxdHEyVXFLL015Mll3TmZJTVErMXBRNW1BTit4T1J3RERDTmRDQnA1WWlY?=
 =?utf-8?B?cDhNRENHcEZpSkZQUVp4TTdRTFZKbDVXZlBFNjA3dVdpeE4wWTVIQlZ0ZVRU?=
 =?utf-8?B?Slh4VmdvTWx4SWcyRzZtb2gvcVB1emF1YkQyY2wxWWNpQWRhSzFwb1VRTGti?=
 =?utf-8?B?RStBb1Z4NGp0UzE0M3ppWUVhdXVMN3hRanFkTmNqc1pnK0xOdVc3OVBmYVlG?=
 =?utf-8?B?cDYwUlB0WTRYd0pWcUYxdFlScG1XRHRDRTJhcFVpUDZKemZ0ZnN5YVlBOXBi?=
 =?utf-8?B?bU0yNlBJQWF4V3dHcGIyUTdTYVViMmRQQ1VpMXRMS2RLekQ0UWxTMitjSWlU?=
 =?utf-8?B?UFYzaFpYdDU1YmI3ZXlKUHBLcTJFbExhSlJZOXBCR3llR0xLaXo4T0Z3L3ZK?=
 =?utf-8?B?TG9lZXY3MlF2eFZQSlNTYWlmMGpwRWxTSHlDOTlJa3dTRHZaLzFaQ3JOOUE0?=
 =?utf-8?B?VDhtQUdaTFIydXBrMXdvRm4yVy82aUZLdWtrQnRBYWkzVlRwZVhua0Rqc2py?=
 =?utf-8?B?S0hmL25HMjJqVlMrK1VkdlVBSXRzLzFvVFdQWmdtSVB6THNQc3E3dnFGOTRL?=
 =?utf-8?B?ZDhhRG4xYTh6QkJUa3FEVEorZTRkRzluVncwbEFUdVRJSHJUa2JUaW8zREY2?=
 =?utf-8?B?bytYM1NCOUc3bGlacEovNm1jZ2xXeHd2WW84QjEzZVRaaU1ZdnZ3aERyRHZk?=
 =?utf-8?B?K1hvemRtSDF4Mnh6eWxDT2UzTTNEaSs1ejFrUnhFeFJVUFZOcXBuTk5UU0tj?=
 =?utf-8?B?Um5uelM4eXU5TTJ4Q2pHWXNRdkUvQ295Z1hUOEVyMzZTU0NzSmZGaGNQbTg3?=
 =?utf-8?B?UnpBSW1ob2gyVU16bEVCbnZReXNuOWJXL050bng1TTRGeWRpM2d2dVVFTGx5?=
 =?utf-8?B?bFFQMlRmODBzd2JxSm5ZbUFFRnd5eHZvRjlBd2tmY1FTaDNMaUhnbFRQbEJi?=
 =?utf-8?B?QUVrMDIvSU9HZThvUkdRUFJWUGYrWVV0UnZWQlhDYjRJMHpOeW1iRzI5bkN2?=
 =?utf-8?B?N2w1TUhWOUVTWFF2V1pEUHZCZ2tWR2JuTjZJNm9qRFZPYlROSktlREcyQm1D?=
 =?utf-8?B?cmJ6dURLMXRnOVJVTWwvTGE4MXZZVkZNb3FaUVdKRnFQeVFLcFJLbEhpZEhp?=
 =?utf-8?B?UEJMa2VGUklLRzd0eVRyUGhKTFpVZm5GeHEzeUZTMmlNQnp1Wlg4UVpyeWI2?=
 =?utf-8?B?VVdEYlMxWkFQMUpDR1g2dU5nU2R0QlY4alorYkJTNEV3TTBIdWRMWThqdzds?=
 =?utf-8?B?NzZtbnYzTVc5RTErd2pxb0dSclQwYWxYNjJ4cGZvNy9qdDRocnIwTUhVQk9J?=
 =?utf-8?B?MmZ1ZVNaWG9TcXFDWTAzbU1DVnU0WlFFSlBCVkhHWnhzNmtJSHRkVGF2MjQ4?=
 =?utf-8?B?Ly9scnVsWXMvVktHTmI4QU9xS1pGbjBabm1tVDYrMlBOUTFqeW9HaE9hVEFE?=
 =?utf-8?B?U3V1ZWg1dm1ubE9VTnlSOVN3V3hzbHFKc2o3dVkwVEpkWXVjTVUyZFhrUmtX?=
 =?utf-8?B?NGpXZ2Vqb01tbWNKK000eklnRDZyRm5rUlNZbmI5bjBtZkQ5SFhCMzNMdFNv?=
 =?utf-8?Q?nu4S2sEHJOXndSWyhND4uNs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30410f77-fe9d-4b21-0022-08d9b8cb522a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 15:16:04.7720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5bD2nGIYO6aBgMhpv4rsoOden1aJf3dgokGBRlUBQQYbW27ITQrQq2OCPOvZySPpm2WZuEDpi9h05W+/h0a4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2416
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 12/2/21 11:52 AM, Borislav Petkov wrote:
> On Wed, Nov 10, 2021 at 04:06:56PM -0600, Brijesh Singh wrote:
>> +/*
>> + * The hypervisor features are available from GHCB version 2 onward.
>> + */
>> +static bool get_hv_features(void)
>> +{
>> +	u64 val;
>> +
>> +	sev_hv_features = 0;
>> +
>> +	if (ghcb_version < 2)
>> +		return false;
>> +
>> +	sev_es_wr_ghcb_msr(GHCB_MSR_HV_FT_REQ);
>> +	VMGEXIT();
>> +
>> +	val = sev_es_rd_ghcb_msr();
>> +	if (GHCB_RESP_CODE(val) != GHCB_MSR_HV_FT_RESP)
>> +		return false;
>> +
>> +	sev_hv_features = GHCB_MSR_HV_FT_RESP_VAL(val);
>> +
>> +	return true;
>> +}
> 
> I still don't like this.
> 
> This is more of that run-me-in-the-exception-handler thing while this is
> purely feature detection stuff which needs to be done exactly once on
> init.
> 
> IOW, that stanza
> 
>          if (!sev_es_negotiate_protocol())
>                  sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_PROT_UNSUPPORTED);
> 
> should be called once in sev_enable() for the decompressor kernel and
> once in sev_es_init_vc_handling() for kernel proper.
> 

I will look into it, I will improve the sev_enable() to call GHCB MSR 
protocol query the version and feature.


> Then you don't need to do any of that sev_hv_features = 0 thing but
> detect them exactly once and query them as much as you can.
> 
> Thx.
> 
