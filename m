Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A444339E160
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jun 2021 18:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhFGQDa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Jun 2021 12:03:30 -0400
Received: from mail-bn7nam10on2073.outbound.protection.outlook.com ([40.107.92.73]:28033
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230197AbhFGQD3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 7 Jun 2021 12:03:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgWGeNsElcdOFKUX29Bd7fj9glMF2xmCcVvk8gIciUE5nMBRwT8ABZkvhzDmePLCeLg/6a3q96uteylJzKP0MA70gNHqyCB6knye31aBJWy1jI9cBGez2Ja3hDrd068zlYKgD7k6wGV7HJrSLQaHEArAjJnRLvMJKHd1KO+0LMbEjm89hQJDE6da4puuHGstHYShC1o+E8oaMnFZijpqT4qL5ez8IO8umA/lKuqr9zzVIcBTTlOvax55o04GMVdAX3wYlZWprEtBVMNb1rkhu7uLKO7NEVBSMhPlimJdN2uwGgfqu/t571oLttHNRg+AjtNcSfkPEWRuXKhnsLPMZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nigzNm5cyzQaoGM5+FMvArHv7x9fVEDrN6XpO3PS1Dw=;
 b=nMHCbZgcj3tfvR3Ch6FfIzgtSbjlPZH+YK7NDw/Mk3NZCu30nmonorg49tHbtVqkRN49Ti67juAoVcx7Npcw1Zt9xKQVl14NzO3UF2ZJ9mqYt7VOWOqpTgOpTzwpSnmeNQvOuYRnvtcLNuGUMNGVmmR+poR+Rxmwfm2IokBn8noSGl3n32rKJG7+K1Mx9dZ0zLwDak488pUPrsi5BVyGYUkEkoWSB6vHmeTUrxo3T+WgJ8rgGgv00TF+wWbIxg5+iu0vtv/9Qp0ki0HvDPU62sct9DbjsgfgdnMyhzFIZPw5GZ/Krk0Iw1pgxU5cpOb3M3fpSHyy2ssP0qo6TGnaoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nigzNm5cyzQaoGM5+FMvArHv7x9fVEDrN6XpO3PS1Dw=;
 b=bN5+j2K6rKhjl+eMCK89s8rHtRwh4xBeIIA1nYmp4HPi1sJTsh9jOUUrjHJZpeYvFEso42lLPz7q+ObD1K1+G+qhB3Cstw7KwPL8PpO/5V4eLHuaysCNzjmtJrTtT7BHtLXnaaBqjFv3j5ysNO9tSgYwXcfgsjEJQTAmZOYAUZo=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Mon, 7 Jun
 2021 16:01:35 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 16:01:35 +0000
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
Message-ID: <57fce362-ba9a-2f04-6958-870fd4f8be5c@amd.com>
Date:   Mon, 7 Jun 2021 11:01:32 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <YL4zJT1v6OuH+tvI@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SA9PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:806:21::33) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SA9PR13CA0028.namprd13.prod.outlook.com (2603:10b6:806:21::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Mon, 7 Jun 2021 16:01:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8de45b26-7110-4410-599f-08d929cd8640
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4557F7BACE3B9364C191CF6AE5389@SA0PR12MB4557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9dzT5SYogq8ajn0HIED7Pa8DS3+NX2MyK7E2cPoVIbWQI3oaSo+j/OmgoiAAHwiTGgEfgT9FRtO9+CeSvtxaZ0dlqx+uQtjpVSgT0wLCMR+pfdeCizJyL29UZIL2hw9QXFwON5O0PaI0fi1iiQsddMtbZfZuPFubBvPNwLlOYQMnMNovB0u8CFElS1/mX+4SM/Q7EIribqeSSIU2jLM761iM5ZLRquaxkw0ogi25g6v5pDTaZ/w3rVtQpBaB8N+H/tVMP50w/y5MUog1E/sCKh2Fi06X0xdWB3yIUAQQ2/mUDxuxe4nKxIReIbQkk8PDMOeBmbByEWHCKTMV4AfqzYg8VWepUSwAIQ9XS65/B4ZiT+hcToL6gt2kBakQZ+4y8K+WEe9c9rwka51Tn6+74fe0SnlBLZQNbWi9Pw98pmK77JfyCBZGo4cOgFvgfKh5KuyG9ZqAfZaKyj6MR2FAi/fBfcW9B6+Bff42NhGNmV3H1pp5wIU8NSG1BCJZhyMgamW0SDkLqD4Otx6ikCJN7oY9QBOEhEPSSQsPjlqeaggUWGh+JBoL8qp585eMaVbVJ4++HyobVisfhX1tmgSFXS/aL2Uji97TLv8tNJJEsWceGO9pRQ075EUIA15zK1CseR8LEVUGxw5alrcYVuvJp2OAKLV9qYc5kgPvXnrnPXLf9u/ra0LnVifaJkNmhXQifaikl+CeWEgzB56DB/VW0kRhFC7OmK4g5AInL9Ne+vs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(6512007)(53546011)(6506007)(52116002)(4744005)(8676002)(956004)(2906002)(8936002)(44832011)(316002)(26005)(5660300002)(66556008)(66946007)(36756003)(478600001)(7416002)(31686004)(38100700002)(38350700002)(86362001)(4326008)(31696002)(186003)(54906003)(6486002)(16526019)(66476007)(2616005)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b1hsVU5GQVBSeUtLUHZObGpzTlBWMDlYUEIyekZpUDI1b0pJNWhsUUNRdld1?=
 =?utf-8?B?SWh2OEpBYXNPOU5hWTRHdWlwTi9KOGRzL2ZIMlZLNmpDeGVXQW14VEU1SCto?=
 =?utf-8?B?cUM3K1kzTDF5VWFnTksyV0tFazdQMGZPRFd5WHF4SHpoSUI3UFhpWHU1YWVu?=
 =?utf-8?B?cWIzUHJMSkh1RDBCR2c0TGN4elNWT3RIUHBSL0Q0NkpLcXZPTlhrbm5BSzI4?=
 =?utf-8?B?UlR6a2hIU1E3OWVJY1VzaEJCRmFTNE91SXFKMmp5djFVb2g5SkYyMEdHcjhY?=
 =?utf-8?B?WkN0cmk4dWlySDl1MUU1alRNMjVZaEhJRFVXb1diR3BWVW9NYjAvRTdickwx?=
 =?utf-8?B?ZlArYk1XRzhjVCtkeVkvaVVKQ094b2dQUVpKcmc5YjRySUpjbzZrQ3Q2dVE5?=
 =?utf-8?B?dTNLQStYTitLMG51aWVmUG1TVC82cTR4RFRJYnMva0JFYUFNNXpzanpVeXFG?=
 =?utf-8?B?NTg0c3NyNGhDYSswYlJsMWJXbkpPSCswbVd1c0ZhWnVhUEZCaCtCT2xWaDBm?=
 =?utf-8?B?Sjl2d3AvZWpySzlMdHp3eXVOZTFJVWI0ZjVRbGxkeDJxODFmMGQ2NExyZC9h?=
 =?utf-8?B?RiszYVY4Z3JETG1xMGJwcmEzZ2xUMCtZYVZUYWlOYThjMGhWMmluQ1l2ZUZ3?=
 =?utf-8?B?MzM0SUdDU1c0bFVZYWNOQ3dqZDl3VWI4ZlFFbEJObEpCNUFtRjNnM0FyVTdT?=
 =?utf-8?B?ZlhSS1Jma3B6QUlrMFdScGZiei9wQVg0RTl0OElhR1kxYkxUWHpVSW10N0xz?=
 =?utf-8?B?NWVxQmZnc3ladWlFRnM5eVFnWU9adjlUU1dNL0R5a3U3STN2cG1SRFkzRmJT?=
 =?utf-8?B?N1ZCdjA0TWlVY0dVZGV1NjNWNjMvbUFHNHkvcVVUN1dpUTRsOXJYT3JzWHZv?=
 =?utf-8?B?QStMKzlQRGlHREZZeWZxamI0eklVTllrQ2E0MmcrYmZtcXNlU2VZL3hBYnRz?=
 =?utf-8?B?NUFNOGJRSzVycUtZcS9DTVFIZGRoQjVET29aNnhZNlNCMTdJRG5RWjJDUTlV?=
 =?utf-8?B?b1djK0xKcVpVTjFZbGRhbThiU1NiQTUvaFV5dE5EOStDc2l4M2FzclVaTDJX?=
 =?utf-8?B?Z3NXeXdvVVBlbnBDZVFmL1VRMmxTeHdMZnczZHlHT1ozNFJRNHZGb0NlTnVU?=
 =?utf-8?B?ZG92R3k0SFJXU0RpY2lLWWI5UThGNFhNckp2WXJnZWRQM05wRk1OODdCRys0?=
 =?utf-8?B?ZXpGZ01xUnVTYjhLOGlGZHF2eHZqQkNzVStCcnYvSG5aSFJlQnRWQzBuaEtW?=
 =?utf-8?B?MENkM1Vsd2hFVU9FNW5JYkk5NWwrWjQwcWRibTNzWE4vVEtydWU0MEdFN1pz?=
 =?utf-8?B?bzUydDNjcEZ2bGtBSWR2UVJHRTlpNDlkMDhyVHZPY1FGUG5sdnB0dUY4UWFo?=
 =?utf-8?B?STJMNktFRU1xY0pMdVF5Vmp5YXJxUmFMY2dLTnBGYzdVSnMzS1BIblNiOHlT?=
 =?utf-8?B?UHpZbk9QMWpNWXRHZVAvVE51bW1VbS9FTmxNeDJ2UEtaU2RxcnlMenk2MkU0?=
 =?utf-8?B?a2NKWUdiaktvN1c2czQwcUtnVCtwaEJWeGxRWCthVzZROUNDa2k3SlZET20v?=
 =?utf-8?B?aW9Na3k2UW96OVgzbGtOTTBlZ1NKTlJSa1ZuekZGTUFzT3RHOC9EZVBnSlVs?=
 =?utf-8?B?c3FpcmhpYTFNUGVCd0VSeXdzWFI5dDZIYlFkcEhVclpWY2QzZzZzbHdMYzlG?=
 =?utf-8?B?M29tRm8yVFcrdG81bHp1RmxSbTd5Mnd2YVE2bU9FT05wcDlTK281QjJITUti?=
 =?utf-8?Q?IpkXkasbjkTudfmxQ1UsEVThI6/mre5Iiy7AFjH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de45b26-7110-4410-599f-08d929cd8640
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:01:35.1092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ycDPXuIoDI+tl/vZWaxIe0n5Q7EYAUNMv/DTJgNoFc+/qrMgej2zxvRf/J71K0RX84Tqx4pwVoD7Oqy1/N2kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4557
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 6/7/21 9:54 AM, Borislav Petkov wrote:
> On Wed, Jun 02, 2021 at 09:04:00AM -0500, Brijesh Singh wrote:
>>  static bool early_setup_sev_es(void)
> This function is doing SNP init now too, so it should be called
> something generic like
>
> 	do_early_sev_setup()
>
> or so.

Okay, noted.


>>  #define GHCB_SEV_ES_GEN_REQ		0
>>  #define GHCB_SEV_ES_PROT_UNSUPPORTED	1
>> +#define GHCB_SEV_ES_SNP_UNSUPPORTED	2
> GHCB_SNP_UNSUPPORTED

Noted.


>
>> +static bool __init sev_snp_check_hypervisor_features(void)
> check_hv_features()
>
> is nice and short.

Noted.


>> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>> index 77a754365ba9..9b70b7332614 100644
>> --- a/arch/x86/kernel/sev.c
>> +++ b/arch/x86/kernel/sev.c
>> @@ -609,6 +609,10 @@ static bool __init sev_es_setup_ghcb(void)
> Ditto for this one: setup_ghcb()

Noted.


>
> Thx.
>
