Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3DC3CEE75
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jul 2021 23:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350127AbhGSU5w (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Jul 2021 16:57:52 -0400
Received: from mail-dm6nam10on2049.outbound.protection.outlook.com ([40.107.93.49]:41056
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1384745AbhGSSfT (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 19 Jul 2021 14:35:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFprU6AoQDA8oKsXFJO/s/zcE78UOY7hsCGk8Dzf20l2dT0rEhJkDAiH6XPpZAfUyPkJXOPqJgW1gWXKECNsbz1dLPUlB7E4PKASieiLWjipuzGgmzYey98eUdNn+2L7CxBOtlEuoFDXqe8NeSFh+B69EY5Tod4T/AkLrhEyVHXyD5j3PwMIZN/5KsgYsUWdxmO2JGgyJ5XZGCxdYreJct+dYtmmRy+w3CFLTR0bnTFj+lNxOwcHy7LD3cwyjZ6rabTDp4EVuARpvGGwyiMmQINY7AnWOEX74UvimsQKZQlWKy8hTw7LFCbtBpeR64f411k1Fd6DBalEo3YRWZq/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvLwnqtPHmOZd5trZ438U1FZahxX3f3tUXyHUSBO+6c=;
 b=AqW7pUp5PyRryhSMdZ5O45+/K4rPzoGXQ/e55r/vDVGTsHB0+0Oie9UtpbDG7KNxb6fYYleNhsIgeA2pnsQu2x6dXkX91OPnkZvp7Us4Txp2IyrThVw98mwyWIA70m8QluReZ3hBpd5BGAl5RHesn5uCczrxFvf7OkoS51/NOW+r1NmifYmR1EB4/HQjfH9wYRuaHbirEDCZtexrews4n2WpUP2q604nkY+l5zbCkDg38ILoaaCE8+5HkcI7z0ZTuu7woqzTIGymLMz3oqCuIJYtmTNDRrsAinL0DegjGOQTYPQ0GDJBDgq/yGwQbtOq+QPcglrRrr5rl9KNBjkdOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvLwnqtPHmOZd5trZ438U1FZahxX3f3tUXyHUSBO+6c=;
 b=YvQwUO+NQnF3qI7/VNkxNBYQkZr/U2We33LGYrNBNnUj7OLso4sq3uyEbwJFBXDvLSs7jnzlk2zypHT8Cx+sCUQV2Cq/FTLQ7UxnXTj1Qbg5kVETTc/lt+yP49iW418RBwDk9Wo2WBgTUH1zuiIEGAIywV7fD6uhVBYtiWkDpFA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB4750.namprd12.prod.outlook.com (2603:10b6:805:e3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Mon, 19 Jul
 2021 19:15:56 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 19:15:56 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 33/40] KVM: SVM: Add support to handle MSR
 based Page State Change VMGEXIT
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-34-brijesh.singh@amd.com> <YPHzcstus9mS8hOm@google.com>
 <b9527f12-f3ad-c6b9-2967-5d708d69d937@amd.com> <YPXKuiRCjod8Wn2n@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <2b636096-2af3-0297-3f93-5380db89d820@amd.com>
Date:   Mon, 19 Jul 2021 14:15:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YPXKuiRCjod8Wn2n@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0042.namprd05.prod.outlook.com
 (2603:10b6:803:41::19) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN4PR0501CA0042.namprd05.prod.outlook.com (2603:10b6:803:41::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.11 via Frontend Transport; Mon, 19 Jul 2021 19:15:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 263a7078-8e80-4e67-b8ba-08d94ae9a224
X-MS-TrafficTypeDiagnostic: SN6PR12MB4750:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4750A1AE34B4C59F1D9535B5E5E19@SN6PR12MB4750.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iJh8lwDUtjZZAH/A2LP/zYwJAFsidAaOh/EJ+9+ULZDK29BXnRZfEIBkPZPj4wEtR8N9OxK8i1PQ+tcxVlH12/TSIBRuOS21xbVLxmyflVHNG3bQRDwQJkVvrP2Uk00+yUyM0HkX+AZHVoSOCN7878itXAP4SbxUug8k6OjYbqNN/6GJcfivFM5RAEsgd7u+NSutSfcpJ9JHsuf84cJ1fvxzHVM+/3QoY+18VhZThkYk0ovyAAoQEkKmLOU8BQIkHMoN7KJhZ+dWoIHRnhVQvkpXmJREjdrp6351SGz0azSumKDAwToYXRpQrmzmpxLEqgXSkOT+hXDb2ZNJrCM9Q6rWJBSC2X5kcMjRnjtQICajjYfDUd9WfmvhStEivR3DJKQ+DOXZ6EkyKTm0+6kDfx2BvTVuj5+ACF41+uEVy/mwifzLGKGvRRnnYnxzop23vw5jlX6lrpaRWTKwa4XI1TJWzJY3CNx/xfiq/d993Qo58ZveiG/0wI5+v9xNpzINPzs+cLPIq/VLKVJg7U1j6z4tbBkRyW4DyBPleOcYLNGNaSqOhjygDHooBJEX5Jti6z0YC6F6NhKh3aLJtaiRW5UXqa31TXpUP3Gy6pcwpXO7cEF7EBdSpq7UqArVnSlWyjGeRQkGvmm9Vgv9AO3u8koTtAjgEque/VoS8ea2oZbDIiitnZUwYGbjml/FT0hu02pjDGAbh9yxv11Q0cit9Xl0OKvc8Yycb895D4p2l9qPAcnQVVmqGtxFa3MmOoCJZ2lwNG2CRnWmIvKnIyw9dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(83380400001)(8676002)(6916009)(38100700002)(38350700002)(7406005)(186003)(86362001)(54906003)(2616005)(6486002)(44832011)(36756003)(2906002)(53546011)(5660300002)(956004)(31696002)(16576012)(26005)(52116002)(7416002)(66476007)(66946007)(316002)(31686004)(8936002)(478600001)(66556008)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0ZwdHBweDlqcldrR3p4MTBOVGdaSnluUzVCZ1Y2RnRDMkxBazVydTIyRmxS?=
 =?utf-8?B?VmFqQWRmTnA5WUU4S2ZCc1psQWRIOG4wMnRmeWtyVmRKK0UwSWlvMGpMZDZX?=
 =?utf-8?B?UlRNL01lR281ZFYvTVFIWXplVG50RzI5WlZPTm5uV0NwbTVrL3hFaU1SVmNS?=
 =?utf-8?B?bWpIbCtLYlFQc1k3QjcwaUxrQm5Yc3oySmlGZEUxa1B5cWh5bGFka0dBTGZV?=
 =?utf-8?B?T1dzbmljTXBhek0vSW5mYUp2bU5rNmxuampPa0hMQnJPaUFtcGIvVW1GbmdY?=
 =?utf-8?B?dnZlbWxOQ1BnMGNPT0g1Z3ZGMCt4bURndjQzN0Jtc1VrQXhSL0gvdVlsaUJE?=
 =?utf-8?B?ZURkNXBROXZXVWRMbFVFQXhINmxyL0lTT2FZUE1SRkMyRjRzb0J2WlcxMnZF?=
 =?utf-8?B?bUt4eSs1RzV2VGppUGtlRU5VZ3JTZ3pyRnNaakJxYTdMWXdUd0loMnVPTWhv?=
 =?utf-8?B?bmprRWdUUXk5bVJQVGdRSlFiS0JFY1F1UEVEaUt2YTFSdDFRMEY4cXpWYS9V?=
 =?utf-8?B?d3hsc0loZmRDSHF0d3NhMmNSSmFTbWNLZUJpRzBuV2tZQWtJRmNzbGtJRnYx?=
 =?utf-8?B?Rit2dkpPeEplc054elB4V2tGNjZYRktHWjRVTnpWUElMcXB2L09WK0xyem9r?=
 =?utf-8?B?b0ZlZWxaeDRlWGFTbWVibFRKSVg0YTJHVDNuRjVXcDJxRlVkSGQ0ekdLaitk?=
 =?utf-8?B?T3dtV3MveEd3UVExUVNLSW5hOEZZMzNuTGNvRGpkZE9CVWJwRFovR2ZhRFU3?=
 =?utf-8?B?TWpPclVmUkFpb3JhcTFGKy9xWEFObUlxVitiQ3VaSWFKUmYrYWM4SHFwVENC?=
 =?utf-8?B?RlhkL0I2VGJaNGxPa1hLQXEzMS9GVG1VSXUwTGs2K2szbk1sRkZhdkN6UTVS?=
 =?utf-8?B?V25XaE5nWjhGckFUQUUzWjNBQ29GYmFMeGZuWmZKL0IwK1doQytjbS9sRkF1?=
 =?utf-8?B?TGNwTVZ3SGtSaEhBRS9KNXkyRmpDOXVGUm0xQWF4d3lLM2dRMEg4TTBic2lw?=
 =?utf-8?B?NEtjZFdCR2VHeGljSXowaTBiMTNzdkNyMDJvcno0RWZlZnorY25vdngzY2NG?=
 =?utf-8?B?b1VQYVJrUzhGOWd3emowalF0R0xYODRNVktZcjhKRHZ2Smp4TlRITXZrektE?=
 =?utf-8?B?dG5nWmphYllYbFJOUlp2M2twVnF6dVVTT0F3V3VRa3laNkIyYmh6aDlXcmRJ?=
 =?utf-8?B?eDZ5TUdma1JFajZOSUIzSi9rQzkxbGhLOWZzczZGY09pL0tvRmtiNmhvSHdk?=
 =?utf-8?B?N1lJWXhORXRzbkRTRmlPUHJ0UGdvc0I5a3FpZFJWRk05cGJNeGExUnRSVTds?=
 =?utf-8?B?dGJFdDllbGpjMGYwMXludjIrL3V2aHVHTnpPRUYza1pBQlMwWFlEZjZtNk11?=
 =?utf-8?B?OHdHc29iZmVmVFVuWDR5NnFUd3pNdXpPTEI2cmJPOXU5bVF6aWRWL2lrZUR5?=
 =?utf-8?B?cGZrVjljSHZtOTlBV2xhcHdZYmRrZUVqSlBTZGVyeWtDRGxTTGtOSEExdnh3?=
 =?utf-8?B?TWZNMW5ISGltaHVvSG5RRndHMEdsRFcxNTM4REZVaVJCbTFRQjZQVXQ4aDIz?=
 =?utf-8?B?MWZ5RERTZ09sZkRkMThkN0VuMDVwbi9kR1AwV3RhbGJOa2plL1FpdThzeG4w?=
 =?utf-8?B?cU90MEtPbzl6SXpDK3NiQ05jdjFla3Q0VytVaUJjY0hMalhMdkZ6eDRwUHpX?=
 =?utf-8?B?dncvTHNTcmU5NjcxUzlKRlhqZFZLalV0UGswM3BpMEJucHpob2tPY1JUTGta?=
 =?utf-8?Q?7SI9QSq5e1Y4/PcpS/FgBU0lEGTQxx/NtaPwerL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 263a7078-8e80-4e67-b8ba-08d94ae9a224
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 19:15:56.0715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IADwerDdncU/qOJso/+B+ErPsa32u16LkTVYDjeL1uzVDCBMINLPQ+WM0TJeAzoRHLNUOnNjixEZYc5UgGQsWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4750
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/19/21 1:55 PM, Sean Christopherson wrote:
> 
> I've no objection to using PSC for enums and whatnot, and I'll happily defer to
> Boris for functions in the core kernel and guest, but for KVM I'd really like to
> spell out the name for the two or so main handler functions.

Noted.


>>
>> Maybe I am missing something, I am not able to follow 'guest won't be able
>> to convert a 2mb chunk back to a 2mb large page'. The page-size used inside
>> the guest have to relationship with the RMP/NPT page-size. e.g, a guest can
>> validate the page range as a 4k and still map the page range as a 2mb or 1gb
>> in its pagetable.
> 
> The proposed code walks KVM's TDP and adjusts the RMP level to be the min of the
> guest+host levels.  Once KVM has installed a 4kb TDP SPTE, that walk will find
> the 4kb TDP SPTE and thus operate on the RMP at a 4kb granularity.  To allow full
> restoration of 2mb PTE+SPTE+RMP, KVM needs to zap the 4kb SPTE(s) at some point
> to allow rebuilding a 2mb SPTE.
> 

Ah I see. In that case, SNP firmware provides a command 
"SNP_PAGE_UNMASH" that can be used by the hypervisor to combines the 
multiple 4k entry into a single 2mb without affecting the validation.

-Brijesh
