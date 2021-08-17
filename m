Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F052F3EF594
	for <lists+linux-efi@lfdr.de>; Wed, 18 Aug 2021 00:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbhHQWOg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Aug 2021 18:14:36 -0400
Received: from mail-dm6nam12on2058.outbound.protection.outlook.com ([40.107.243.58]:43329
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229869AbhHQWOf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 17 Aug 2021 18:14:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wb+1rkb5g3oOjlLyh+tMGerPJwM3vzeUa0yCKA/owBXiSuhw+jb+KM1gPgkd4r8mo0MnENeT8uimHrM/M9sQxyAKk8SQ00KBLr89IApcfRZn7VfrHcYww4C9awbwqRPNcGe8Sy/MeajXu9YgTEHFoiWGZBrx9PpYWD8HPBQDW7AziQa/yXUmXBw+viy3ar6t41EsbrxYCDOqEM+7CBp6ybRMNVMz7O59I8zvH83HMZi3iyLwtU55gXOZxyVcfH0jQTogi1zlrfZYU4wH9dl3yhao1+1mqRTi64z/uHAqDyyR2ggKK44LetmrxmVJsnoTNIv2T2vMqXyIXeTDCb+MOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35BH7pL4XK1kRjaV3x8R3Am0K0hm3uIKDr9dZ2/L57A=;
 b=XRuxpbi6dK/7QNfviSvpdaioCE7lB3RBuF/1y3wYBMpkFOJYzU7bh8B5PNfRTOkYQ6Y36Gk2D5tWcgqxK+cAH9N5xYCLx25B3FM0XJlFGdeyltSGpX31aOVY6Za67o/TS7h9k3/IiD9i4+qT7l6qNsWiy8cj3OdgN7Wy/SmDxY7ziHb7P3Z4Aiqjt9ggv9+xC9sS3U64q75vTO2wf01cJdAleyVeyDKtlT2BhZOktFEcJR/R6ahtb9TS+prU+Y/p6wFY8LJVXKBrkJazK3I4vnyDlS+g74EcO4KH+6c/Kx7YRWC4DYWmBgzQdjpN7vZwr/Vu1H9iZ960vhbl6FPjJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35BH7pL4XK1kRjaV3x8R3Am0K0hm3uIKDr9dZ2/L57A=;
 b=13db37pkehf1lJcWXIzgkC2jotDopyEXXi5dbsUKxknsvJwUBqqAlvPYGut58zshNfL1PFgMHzaI8wrM6PKmio2wEXDmQG4Jsuzk8MQZdeOsyRLLImK/GfSogQpxzHglfBEBdac0L5622v5RY83fx8fIpcSxRk5TjRD/LAsaC/Y=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 22:13:58 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 22:13:58 +0000
Subject: Re: [PATCH Part1 RFC v4 20/36] x86/sev: Use SEV-SNP AP creation to
 start secondary CPUs
To:     Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
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
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-21-brijesh.singh@amd.com> <YRwWSizr/xoWXivV@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <35b57719-5f31-c71a-7a2f-d34f6e239d26@amd.com>
Date:   Tue, 17 Aug 2021 17:13:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YRwWSizr/xoWXivV@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0201CA0013.namprd02.prod.outlook.com
 (2603:10b6:803:2b::23) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by SN4PR0201CA0013.namprd02.prod.outlook.com (2603:10b6:803:2b::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 17 Aug 2021 22:13:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ced03bb-ef65-4998-c2db-08d961cc4f69
X-MS-TrafficTypeDiagnostic: DM4PR12MB5103:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB51037B266727D22E2012F09BECFE9@DM4PR12MB5103.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tyHo0us+7RWYJAqLllr6UUOMbpFcpRTEdfGR5HAfoMHnoM6+GDTKJAgefEJtX6ezVrkMtmJmA1ZoWFaV7F4BwI2IUXhqYFlhwY5hZfSe3DZSY7C2TqukFL8jX3gCeN+NrQblHrqdmmXx6Gf1IRvQzvYKBgaRbEOh7/yRaKSUWrrWxNbGdJzuaWvttegdPyfUo/Izc2T8O2S3/bvNH4zy5vhu5lWAxwRAmTowjDTwUtxXGQ8kCRmjaf3b34awwuNpOkFEGQ7kdpvsbWZ0gTOfzciUbmfDPltlFfdmSngaB3nwIRu5iIxH8NoWtF+wY33kmu0zy4GPA+CD8BTNpqJtDiI6T3dCylfRD+2S/2DAdS3M1/fCWBjvlTbAsL22RkOp4T8IrCSDq63AGEgxfUdzOVpWIhg1brZy9uy5IiAB/RzAjyoVtVTHaoq/DK/tPXNR+hvQgnEHhDZ4ui/rODrbnROL6ZQZt/rLyI8IUxlwmkHiCTOV6N/rt9ONurbuF/EPS61zzcXU9227qfFtaW383VTntUfhajqibT95GpKhHFnct26MdgVXOoRgOgN5hH4K/egluC9zsre+SSdUNA9G0kdXaMJ1vYsmCYFwAjXCTiYppPxgsKaagR4MCimZoDs/tjPXKZgMg10SFFSXhuVysJbeBXS25ftmtk0l/q1jCe5+a69YKxCiGW67ntscEXFqn8sl3K74OjW0H3BrQUzfeYh11923mHPmvQi7pz5nWNw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(54906003)(86362001)(8936002)(5660300002)(478600001)(186003)(26005)(956004)(38100700002)(83380400001)(53546011)(31696002)(7406005)(2616005)(36756003)(6486002)(16576012)(31686004)(6636002)(2906002)(316002)(110136005)(8676002)(66946007)(4326008)(66556008)(66476007)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnduMkRuY0dWRWtHcldKd1BKRFRlTFVXUTUwcTN1TVhjdCtmbjhTcjUwZ1NN?=
 =?utf-8?B?TTRjY0ZZRnBOSzJERGtDSjB5S092TllRU1B1dzVieGJkNG02dm1aVXFUcytH?=
 =?utf-8?B?QlVuWmRwT2x2WWJDSFdmb1BVMVVLSHM1eksvRDV2dS9kZldtbzJDNXJYb1ZW?=
 =?utf-8?B?N1JHSWxKemVPTkJMM1RtdGFVWUIxZVBveDluL1FBVmtIN1VPSkRhL01FYWJi?=
 =?utf-8?B?OFBqUFEzdGxrZmlSYktLeGZnK1d1cTdwbHZKMnRjKytFSzRwa3Vna2JqQmdm?=
 =?utf-8?B?eE1aUVFRTU92ZXFrV2RyQWZ0T253aHEvOU5MZW1UaWdNNlgyWkdJdEpTeTBS?=
 =?utf-8?B?SzF4TEZjcFZ5ZnpKYVV1Uit6UldaaSt4Qll5S2FjVk1CUUd0WTJBeHo0NEMx?=
 =?utf-8?B?b0p4MGlCYS9Bb2pQN0hadEs0eVpyYnA3R2pmdVNQaVlxdHNHdDRrZENBMXl2?=
 =?utf-8?B?K1FLMDFkdW0xKytrZTFHTUVzTHVRTFFxN3k2VFdaRFM0YjZkWXJHS2Vralo1?=
 =?utf-8?B?TGJQVFQwUEsvTVJ2ak1hNGl3dnh2ZHcrK0lXaGxuMStVRlMwdDFQVlorWXlP?=
 =?utf-8?B?WjVvM2VPQnlyVklRZTMyZU5kRUdGMTdvWjY2WStwRWZtMnRKT3NOQ2xZYzU5?=
 =?utf-8?B?cWlFdXlLcThzampkRnk0R1lNRDlPemg3bEFSQXhNeHlXVGlhdXFydXduSTRK?=
 =?utf-8?B?SHpVR2ZuRi9sZElvZVJwNTlEUEdoRjVweXlubFZKQjl0TFZvaDFSQmQyRTcx?=
 =?utf-8?B?dW11VWZYTWpWcmZnZStGc3dsbmFneXZsUld5K1VTUUFZYVJaNVdLN1Q3WmVU?=
 =?utf-8?B?TEZFYmxXaWhMQWl0eVFYZHlDOFZCdHBwT28rVkJKWHB6cVozaEtGWXpRWll6?=
 =?utf-8?B?Wm8xd1JqbUJOdE5JSTJlSmxBd29PN1FWMlNzOEV3NjF4OHp6RFROSTRIZGtN?=
 =?utf-8?B?c3BoRUo0R1h5bXJ5WVNNdjJUMTVZbFZPdDE1ZmU4Z1gyWURHZEdKa0ZFWm5q?=
 =?utf-8?B?Qk96SUxtY0JiMGMrWHRSbnd4dzVZZmM2M2JjVlhZeHdXby9qU0xBYk9YdzJi?=
 =?utf-8?B?K2xvWjBWZWpxelJRd1JJeERLWmFvRjFiOEJZRVVQNmowRGxvOXlYK1p0VlZv?=
 =?utf-8?B?UXk0aTA0NUhlTnlIUHk0YnB1RFNEQTl6SU83RUpWMWNXUHhtOWRGaW5xUlVB?=
 =?utf-8?B?aUdHYVJhdXFoYU9BWHk5WmN6WCtZUGVYL0E3bjJpWWFDUlpEVGVMS2lpR1Jv?=
 =?utf-8?B?dlhPbDU0YXY4ZUhNa21mV3ZMTFFiS0xjK2xpbGJpRGJ6cDRpK1JMckhCaDBO?=
 =?utf-8?B?ZEg1OVpmQkR2QWM1R01RbGRwa29KMklMSXlGWkx1SDhtQXZ3eEl1ZERJbXFl?=
 =?utf-8?B?U1Jja3pJZS9jK25pbFgwWjZ4akpnTTZXd2NiVWs4clZybGdMVXAvaXkzL2N5?=
 =?utf-8?B?SElHMlU1NFNnUTBuNnovMGlqaWhJeWkySytaaWowVEVHY1NpM0htZ3Vza3hS?=
 =?utf-8?B?YWQ3U1RkSmVxRG1GWHFoTGY1eThwSlQ4Ti9tVWM1SHJNUGJVdHQ5MDc3NStO?=
 =?utf-8?B?My9xcTdlV21vb3UvdmQ2MzVwSFpPb2tWRWQxSS9DMWV3eXdNLys4VDhFSnZw?=
 =?utf-8?B?cG4vUDgyOTdteXRBb2owVzd3d2N0VW1zbktlTXR6YWE4TGdlSyt5YW1keXZ4?=
 =?utf-8?B?Znc3ODB4Z1oyU0lJdXdTR1B6WWRVdnJmUVZHVXVRelU0OXpQV2lUVXloUnpI?=
 =?utf-8?Q?/vhrUGup+JlTnao5on9baiqP4hT+7t4RYcLu8+Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ced03bb-ef65-4998-c2db-08d961cc4f69
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 22:13:58.5648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SP9Vc9TwddUauL86k8aob8dxlc3+3sLHFx1+kRkzizvTDAPTxQyUVjZVpnBL7amVBIhOQLZQvV++rfz+P4oK9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5103
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 8/17/21 3:04 PM, Borislav Petkov wrote:
> On Wed, Jul 07, 2021 at 01:14:50PM -0500, Brijesh Singh wrote:
>> @@ -854,6 +858,207 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
>>  	pvalidate_pages(vaddr, npages, 1);
>>  }
>>  
>> +static int vmsa_rmpadjust(void *va, bool vmsa)
> 
> I know, I know it gets a bool vmsa param but you can still call it
> simply rmpadjust() because this is what it does - it is a wrapper around
> the insn. Just like pvalidate() and so on.

Well, yes and no. It really is just setting or clearing the VMSA page
attribute. It isn't trying to update permissions for the lower VMPLs, so I
didn't want to mislabel it as a general rmpadjust function. But it's a
simple enough thing to change and if multiple VMPL levels are ever
supported it can be evaluated at that time.

> 
> ...
> 
>> +static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
>> +{
>> +	struct sev_es_save_area *cur_vmsa, *vmsa;
>> +	struct ghcb_state state;
>> +	unsigned long flags;
>> +	struct ghcb *ghcb;
>> +	int cpu, err, ret;
>> +	u8 sipi_vector;
>> +	u64 cr4;
>> +
>> +	if ((sev_hv_features & GHCB_HV_FT_SNP_AP_CREATION) != GHCB_HV_FT_SNP_AP_CREATION)
>> +		return -EOPNOTSUPP;
>> +
>> +	/*
>> +	 * Verify the desired start IP against the known trampoline start IP
>> +	 * to catch any future new trampolines that may be introduced that
>> +	 * would require a new protected guest entry point.
>> +	 */
>> +	if (WARN_ONCE(start_ip != real_mode_header->trampoline_start,
>> +		      "unsupported SEV-SNP start_ip: %lx\n", start_ip))
> 
> "Unsupported... " - with a capital letter

Will do.

Thanks,
Tom

> 
>> +		return -EINVAL;
>> +
>> +	/* Override start_ip with known protected guest start IP */
>> +	start_ip = real_mode_header->sev_es_trampoline_start;
>> +
> 
> ...
> 
