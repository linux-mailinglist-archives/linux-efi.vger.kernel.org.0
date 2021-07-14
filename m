Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44C53C88DB
	for <lists+linux-efi@lfdr.de>; Wed, 14 Jul 2021 18:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhGNQso (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 14 Jul 2021 12:48:44 -0400
Received: from mail-bn8nam11on2043.outbound.protection.outlook.com ([40.107.236.43]:53850
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229595AbhGNQsn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 14 Jul 2021 12:48:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESR0T7Fwsc55fwSo6Ghtq9zyPIFTV28GOyhSuU4qvF/seozrxgg3iY665vsRH1iPn3H4OyMV24GhFKnnhFtc3+irN2ShSVG+w23dMj0896SvP3XitQ7LuFBsyhCsGanytLT807qO6j599dfYDKpeqP5gbvbVtKTuYGhIVpDoYSmDWXi3p6Jmxxj2mEnPKuwQ/tcu2/ws+Acj39TxGf9xyqomhjBg/ekJQFc7CvhzFOVZ9T9z+17wQbHD7ooSxibngHo+tmrTAYC9YCZI8wwbnq+Oj0hnY4awrxNQaOToSgB4sCpCBAFZNaO3aqJL8OVp3geJP6BOgO1aHScswS80UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KelQ5Z4WY2TNpmFQRZ+ItrfLdElK7QTB9zQkGHBHyUI=;
 b=V2e2hybIAP319rgoit+hZBXsWJBoflcC0akRknhD8radLWk2QMfyNZGBLZuKGVp7g7nMXgti/f1mXWJPNRFwuhOdYDGLPELyzXxDblTetT1HOgbiYThHIz9DwZ2vt5JhI7d/sCpAYc1rFR+zei5MzSoAOflFq6tMSn3rrXqYJ5Erz5bA6qC7yxxNixYy7E+wJq4THKDQ9evro4mkcUdpUcaVoPc3alQnkvqzkbAv+tvHsO6I40hzGIySiyHlGsOPW6Z2vfla0qT1vVDFiE/QprdAjZXUJyUK6U/idUfPdz3i4sjIX/496EG2ueptBL8Rwkvm9/16B82syv7TRakHpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KelQ5Z4WY2TNpmFQRZ+ItrfLdElK7QTB9zQkGHBHyUI=;
 b=p51GeywshXOIQk3iWRriISCjIUqNJIEssGBqmramON1DD+ZATWUSAxvqZ5zWmCATjlESmm0PsDWi7vNe2zrFxjL/EtX52PVyiK/6RrLNt1gf2Lm4Pp4EUxZVE8nOw6S4UfVkBI+/LTDuGxw+ndzOZeL/JLnVEqb1fuICUXiQwjc=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Wed, 14 Jul
 2021 16:45:49 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 16:45:49 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
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
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com,
        Alper Gun <alpergun@google.com>
Subject: Re: [PATCH Part2 RFC v4 15/40] crypto: ccp: Handle the legacy TMR
 allocation when SNP is enabled
To:     Marc Orr <marcorr@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-16-brijesh.singh@amd.com>
 <CAA03e5HA_vjhOtTPL-vKFJvPxseLRMs5=s90ffUwDWQxtG7aCQ@mail.gmail.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <98ac737d-83a8-6ee8-feac-554bab673191@amd.com>
Date:   Wed, 14 Jul 2021 11:45:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CAA03e5HA_vjhOtTPL-vKFJvPxseLRMs5=s90ffUwDWQxtG7aCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0201CA0056.namprd02.prod.outlook.com
 (2603:10b6:803:20::18) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN4PR0201CA0056.namprd02.prod.outlook.com (2603:10b6:803:20::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 16:45:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8ea7d20-b8b8-467b-b841-08d946e6d561
X-MS-TrafficTypeDiagnostic: SA0PR12MB4430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4430B544115F60C7D753080FE5139@SA0PR12MB4430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NPVw3CObIclAeUBixIZxDvNBqM6COJSBMUCfldRZnYRpB/b8Bux2gCjodNN9k6XiHeyVtDulrkZUWFouzib6WHzpX6KACHP1tPro/hHgrthHOLkkzO3gJOomCyOMDE2vK/qf6VrgR2DprVEnYwbkqI709SRS1fgbD6Fn2WnlsBphitogDJ5ynpcrcV5LhcqZNxR94vC05wqXtnsdJ39yVQsn0K8nk3Jn/NYvM1HkVdLd/2fzTRke6/5wBudDgiViiqqcRIHRlbf5VRS1Yoe+GrkZutUFtF0S107aWLWc1y22zF7L2c9SmupoUsU+1Tl5+ThhlT24mgyKtJfaJMN3Vr3FVGlHDdPV8YY3zMxfMc+v2rhAsbxvETDf0zSj21l9GL0bsVzwAfVEMjAWehd5FZw1JOLqjniTb1sh0Mqsy26x+UHchG+pO6gcFDbHd3Jy3PwEZ6/hlVGHH5ZxFtvNo07LtqpsIKwk2meQxPyzaRbaXHn8wsMKc8zUIHPKr5pSdwPqD8bmlOhFVH96NHtURoj3OjufvHyJ/OEg0Ua6Ppgh0bpIWQ8zM8usmCE5KtMWWNi83Gz5/WKzC06VmAfhNzI0KWzg04Pscu37BVYm2vyUjL22UNXrv/BaS5N5k5DStWrzjrU122hgMZyCp2Af/s9x9ajAFKRo4LF4ROz7LT1bstu6L7g3HjwDwLLQY9ekU/P98ZqM0bp+93TN+kvR6BbTQvEvTXGFBXfVSOlgTZ8blhdWSQPrw4cW4pNZkIUcTpyrdC1YQflX3ll8xXToMylPck7lyUjscvPf5wyqrg+/BSg5slxKhS5MCXji+sMBDW2wGQSCseHAl1qmnwu32x2W9QoAXwPWE44aLCmNhso0XqAbXzwu6ka9a2EpOANx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(2906002)(86362001)(36756003)(8936002)(66476007)(66556008)(31696002)(54906003)(5660300002)(316002)(16576012)(83380400001)(8676002)(2616005)(6916009)(44832011)(38350700002)(66574015)(7416002)(478600001)(38100700002)(7406005)(966005)(45080400002)(52116002)(6486002)(26005)(53546011)(186003)(4326008)(31686004)(956004)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlZqd3pWcXppQkNZdDVQdnBaWXRURElkSTJmZk1JWkNzRVNIRUxtN0JZNmVC?=
 =?utf-8?B?WE14RWoxdWcybnZmdjFiU3BtdStZcUJ1Tnc1VExNU1IyVEFoazZuRmZEWnNm?=
 =?utf-8?B?UVp5c0RWekJic1pWSGxjZTRSK2dyOCs0NW9WWVBjb0o5alg5VmVUQ0dBUlUz?=
 =?utf-8?B?NnVWbGdMWFFXcFpxV3pRaUFCMHQ3OEhFNXQzY3VYL3VZZUY0QU1HQjBLRkVF?=
 =?utf-8?B?ck9VbExVek55cjMxMk50WmRmbzBGcFgvTnNlZEFVRWFsWmtqcXdWOGlRN0tX?=
 =?utf-8?B?a2V0OS9qSnI2cURhR3A0TDQ2UVIrb29nMXVZL0wwV2dGTE1LSmN6SFZIMHda?=
 =?utf-8?B?bkJhWllhbUlqRlA1VUpEUEQvOXZuV0lyMnJsU05EMDdhWXNPeUR0M0NUWTY0?=
 =?utf-8?B?MEkvMVRFSW9UUUFlYVFxbjJLUmZxTDZEcHNNZzR0a2ZkM1pGMjRRRlNmVU96?=
 =?utf-8?B?bHA5VVJVczhBSXEvRDRzVWMvcllsdG5VOENwMjJpQVNZalhPQlVNRW5xWXU3?=
 =?utf-8?B?WitoajVlTmkrSkk3ZlZRTXl2ZitsT0FKYWZtaWl3UTNNT0VkQkswTkhjT2I5?=
 =?utf-8?B?Wi9zaFpuSXp4bFVlSDJiSFlKUUJBelFMeWJac1ZaQVlzZkkxYkFpMFNwQTVt?=
 =?utf-8?B?Y3ZBa2haelJFRjZaaEQyM2tvVitRYWZ2ZldVT2N2MjhNdlBiSHpXck83RUs0?=
 =?utf-8?B?eU90dUZOcmpvWGtjWXZydlg3QjVBczVybU51SHo1azcxREVETTU5SWk5Unla?=
 =?utf-8?B?Qys0U3EvUXR6S2thZm90aTN2aGd0TDJFNWUxTU5oRkt2N3o0eVVtTk10UWs5?=
 =?utf-8?B?T0VTQ3U1K2sxYUJVQkZFYy9ROFdLMEdpRFQzdGUzOFpZaHB4WmV4eFJnWUhs?=
 =?utf-8?B?RE1PUVhsR1JsWUlJRXpVYllZVjdxOXVUZFkrNjA0Q3g4b2hXNEd0aHF3STZj?=
 =?utf-8?B?a3NPcE1jSnh0YXlNenpHV2NnNVRVUWVhZlZRdm1wSVVpU1lFcnVwSUUxa3pk?=
 =?utf-8?B?RVk5dHVMdFdWdTBYS1FEQjZ6cnBid3BURjB0a0tyVitEQVdTU21oYi9FbW83?=
 =?utf-8?B?VmdnQkdrNnp0Y0lyRWMxM3p2NkhlaWlGLy9hVEpyOXVERnMzY2JKdFdXcXZW?=
 =?utf-8?B?ZUVkZUVPT3dBcFhwQ3VsSzFIYXFWUE1aMG50b1JvRGNhVXZJUXkvSy91NW82?=
 =?utf-8?B?b3JkK3hEdGZHTHlubTlWVmo1ZEpWWUx4REVpWkNHc2FYVm5kUDdkMzFsVm1E?=
 =?utf-8?B?NUZoNk1FTy9vdDlsZTVRdjZwemdJS1YxR2o5d0g2QVl5RTBBbVZJdUJvV1FQ?=
 =?utf-8?B?enVYNDgxTUFVUjg5aGNidEVGc2JXS3lhb0YwTG5EQzcrQThKUFlTTU9sTGsw?=
 =?utf-8?B?aWFmMHlFcVhiTk0rTVQzMFRoc3FUM3F1TXpGZkJPQlJEbm4rNUErN0ZGdjhO?=
 =?utf-8?B?SUlaYm03UGJuZ3RFSlVOeDZYa3dxQlcvQjZSUmdCMC9CalNuUVFkWlFiVW5N?=
 =?utf-8?B?MUljTG1Fek1JeHFPWlIyS1VSaEJybWpCYlRNRlhjaFZEbFRzTWcydDNFc1lB?=
 =?utf-8?B?N1Z1L1Z0WHJ2U2V0NitkajdtZEhzclhmWlBnbHh2UmpxZHh0b2s4Yk9UOElq?=
 =?utf-8?B?RDNjZ2dtdFBxUWlhelE4OHd6TDU3RlZsT2hnR2N0UzBNMWNCeExPMXBUYklj?=
 =?utf-8?B?Qmg3R2IyQjF4L05aOGdjVDM2ZnNvNTVtY0RlZjMvRElQR0JRa3Q0akErM3BN?=
 =?utf-8?Q?Ci4yanwZ3PljTG1LQfx9tOyua4nIK1lTLZWTvz0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ea7d20-b8b8-467b-b841-08d946e6d561
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 16:45:48.9087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dfn+6WKgSMCVobWQL8uZUTb9fEWSjnoHvdNIsdp2pwylgtdO36jBEIhJ4nr/QpnFY7G1XgsdVcdnN7LoQra5pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/14/21 8:22 AM, Marc Orr wrote:
>>
>> +static int snp_reclaim_page(struct page *page, bool locked)
>> +{
>> +       struct sev_data_snp_page_reclaim data = {};
> 
> Hmmm.. according to some things I read online, an empty initializer
> list is not legal in C. For example:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fstackoverflow.com%2Fquestions%2F17589533%2Fis-an-empty-initializer-list-valid-c-code&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7Cda82a72de9ab40237b1208d946ca78e6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637618657748568732%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=zrK%2BUfXYGFVB5MfsmIIM0LtPDQ9UsAJxksCunosP9MY%3D&amp;reserved=0
> I'm sure this is compiling. Should we change this to `{0}`, which I
> believe will initialize all fields in this struct to zero, according
> to: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fstackoverflow.com%2Fquestions%2F11152160%2Finitializing-a-struct-to-0&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7Cda82a72de9ab40237b1208d946ca78e6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637618657748568732%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=vpyAtB%2BZ6b%2BXD3VthQy2b8JtYzYnMceWb9cdj5UGlPg%3D&amp;reserved=0?
> 

Ah, good point. I will fix in next version.


> 
> Should this return a non-zero value -- maybe `-ENODEV`? Otherwise, the
> `snp_alloc_firmware_page()` API will return a page that the caller
> believes is suitable to use with FW. My concern is that someone
> decides to use this API to stash a page very early on during kernel
> boot and that page becomes a time bomb.

But that means the caller now need to know that SNP is enabled before 
calling the APIs. The idea behind the API was that caller does not need 
to know whether the firmware is in the INIT state. If the firmware has 
initialized the SNP, then it will transparently set the immutable bit in 
the RMP table.

> 
> If we initialize `rc` to `-ENODEV` (or something similar), then every
> return in this function can be `return rc`.
> 
>> +
>> +       /* If SEV-SNP is initialized then add the page in RMP table. */
>> +       sev = psp->sev_data;
>> +       if (!sev->snp_inited)
>> +               return 0;
> 
> Ditto. Should this turn a non-zero value?
> 
>> +
>> +       while (pfn < pfn_end) {
>> +               if (need_reclaim)
>> +                       if (snp_reclaim_page(pfn_to_page(pfn), locked))
>> +                               return -EFAULT;
>> +
>> +               rc = rmpupdate(pfn_to_page(pfn), val);
>> +               if (rc)
>> +                       return rc;
>> +
>> +               pfn++;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static struct page *__snp_alloc_firmware_pages(gfp_t gfp_mask, int order, bool locked)
>> +{
>> +       struct rmpupdate val = {};
> 
> `{}` -> `{0}`? (Not sure, see my previous comment.)
> 
>> +       unsigned long paddr;
>> +       struct page *page;
>> +
>> +       page = alloc_pages(gfp_mask, order);
>> +       if (!page)
>> +               return NULL;
>> +
>> +       val.assigned = 1;
>> +       val.immutable = 1;
>> +       paddr = __pa((unsigned long)page_address(page));
>> +
>> +       if (snp_set_rmptable_state(paddr, 1 << order, &val, locked, false)) {
>> +               pr_warn("Failed to set page state (leaking it)\n");
> 
> Maybe `WARN_ONCE` instead of `pr_warn`? It's both a big attention
> grabber and also rate limited.

Noted.

> 
>> +               return NULL;
>> +       }
>> +
>> +       return page;
>> +}
>> +
>> +void *snp_alloc_firmware_page(gfp_t gfp_mask)
>> +{
>> +       struct page *page;
>> +
>> +       page = __snp_alloc_firmware_pages(gfp_mask, 0, false);
>> +
>> +       return page ? page_address(page) : NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(snp_alloc_firmware_page);
>>
>> +static void __snp_free_firmware_pages(struct page *page, int order, bool locked)
>> +{
>> +       struct rmpupdate val = {};
> 
> `{}` -> `{0}`? (Not sure, see my previous comment.)
> 
>> +       unsigned long paddr;
>> +
>> +       if (!page)
>> +               return;
>> +
>> +       paddr = __pa((unsigned long)page_address(page));
>> +
>> +       if (snp_set_rmptable_state(paddr, 1 << order, &val, locked, true)) {
>> +               pr_warn("Failed to set page state (leaking it)\n");
> 
> WARN_ONCE?

Noted.

thanks
