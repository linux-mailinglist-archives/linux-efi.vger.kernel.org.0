Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9712C3CAC58
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jul 2021 21:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243856AbhGOTdA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Jul 2021 15:33:00 -0400
Received: from mail-bn8nam11on2047.outbound.protection.outlook.com ([40.107.236.47]:61664
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237288AbhGOTbB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 15 Jul 2021 15:31:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbkPrWv3bXzBqBE1PMghSfx4EcGU4CQh1CC4VRIh6bKqtqnEj8SU18EWovK8DgD/y/GCncgXyc3hTvWtHJqbwZ7/4nCW5i+gbeUkAH5i/dvmpcS3GfVrqm99ZGvDAPRpiYwANEB0R7S1jTBYymS4rZPPWmW+MftInx2W/NpUnURr9OB4M6XP69Wj5nM/airgtbP4mvYIc+oGODJTGKlT0JpFSpgvpaUjeCEhTjHPiPIl98tPtZRBkUQuEVMEuqDaHCSu+momsEGtpY28KD+GDwko10BZG6ClH2Agr5B+uix3SyyQVwJNhMG2bnEQhf0yUtMsAYBsZ5evSL1WAN0yPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhPrq+s8LWTOX1eWSzVu0wTfhNWv1zsPHKDazECJdE8=;
 b=GCiaa2gasf0lXorvVqgxtamVxDLmDp71G2HPSMhtFXNMq8X4EBMxnnNmzsFTQg+FXF55n+wgImhey/00UZU7D3/RTxlXNu8K5HvrnaSKoSWPYGfUbljv0MPO+nzr1twrRKBAtGplcbvYvimOqFQtEQxk+Pmpv4riGpb4UEysKGBmO77Ce+vn4KRNULOhGMqRal38Q5iWCIMnZgTxDjNbvOaTs9uIwwJYXwTSY8gvOXNP6qNlcNgNqMIGN29c7pViuOqYq2CsvSRoW3C7BQtlvhC0GCJpSrPrtj5Y6rU4JMoohRyfYvHvP+J1brkmuz4PK085Wiiiu3Od909uUwOSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhPrq+s8LWTOX1eWSzVu0wTfhNWv1zsPHKDazECJdE8=;
 b=4XTswqqrtx3mCQyAzs1Qi6ek8cm6W1tb0cZtsgYk5RoMWEAS1+yJ9WjaLPP6iqFb5cP1kE+CxW9AW9lVEQ59LhG3BbSev2MQ2Ijt53d1ll/oc2WNvve904OMml3vYCUK5RTWlIm3VpcTax+PNfXqbvJ8PxxPrlUWamtaDPXa6yo=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB4671.namprd12.prod.outlook.com (2603:10b6:805:e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.25; Thu, 15 Jul
 2021 19:28:05 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 19:28:05 +0000
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
Subject: Re: [PATCH Part2 RFC v4 05/40] x86/sev: Add RMP entry lookup helpers
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-6-brijesh.singh@amd.com> <YPCAZaROOHNskGlO@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <437a5230-64fc-64ab-9378-612c34e1b641@amd.com>
Date:   Thu, 15 Jul 2021 14:28:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YPCAZaROOHNskGlO@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0072.namprd11.prod.outlook.com
 (2603:10b6:806:d2::17) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SA0PR11CA0072.namprd11.prod.outlook.com (2603:10b6:806:d2::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Thu, 15 Jul 2021 19:28:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad85a0e2-6f8a-4628-17e8-08d947c6ab2f
X-MS-TrafficTypeDiagnostic: SN6PR12MB4671:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4671110F2DA27AA4058C2A78E5129@SN6PR12MB4671.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2LZN9Y5rPsg0B3A4cLK5wqXrGP1e5yPDVFgQpvRlLyP+yj0uDPa7jswTRehIFZNPam9HiMKICKJMtn6GB9hrM9JOAmkROILTKd+3jWdWaHCtvbUzbvLKkN6gMan9VIBWviyM/CVXgZ3XW6uQvDTTVt/TPtSEv2duBBURsAPr1c0mADuQyvJHtA6TRYowCEbWIiuxKWwZkrxzRAbScDf9WUBGNiYrQFkfg7guiQCfcH6ratij3WtpEMZerhR+E3MdMcZZtDBinWahzsi8xku4AsD8CxMx3Q3zxNJJn0WzVtyD0WnzA0NOE4bcw3vWIIost8SNFDwcZjOYUO7IfyvrqGlo4cn1ayGhoMnW8tuJFXgSiStsAGICb3eDu/KBaSVSel5fTeMbcIbQMIBadvDQ0VDBiajR4Xgwv9xhszz9og32hXG184bbqCUv7N3LrwSG7L9RfDPCXWixqNdReupxZXGJ5HbtjesdABBn7b/zid8ztM60mo1KzG4N9kE4F05oZJ7AFkBwKJ9Vi8/rGLgI4CHSHPTu6Hc8kBIcXBKP1NDd6omHBxhPvgP+BAZCoLq77ru2Tio3QakXoXMDTbjkXJgay9JMXeF+ZX17UCv1+8k9eA15H/E4w0WSmUhkjTMQErt5XFUfhFEOiTckCwGVdGiTkmgRt5SzLuBuM49KZ1j9pFZRZGv6zymYO/wNYMW8bO+SVVhbKLzZJXt+K/LyKjoTsNdUWrBkp6AEZtpBMjg+5jmZx4sJ9sHl7k+rwu2lRdUbJ5IRk1bU2XIAHNr1bEVJNQW1Sv92D5yg2Ytx/SYGSyAigdwcui5drYkwbroWykUU67iuzOnIQRVmoI1iVC90fAn6f2PmnyDET/hoRDy6cV8O3ZoKGYJmQt5WIXwL8SQ95+/aIUmFOfi2hzB2Kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(5660300002)(186003)(66556008)(66476007)(956004)(2616005)(8936002)(54906003)(86362001)(38350700002)(966005)(316002)(16576012)(38100700002)(7416002)(66946007)(8676002)(478600001)(2906002)(53546011)(45080400002)(6486002)(83380400001)(31686004)(26005)(4326008)(44832011)(31696002)(6916009)(7406005)(36756003)(52116002)(21314003)(45980500001)(43740500002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTV4UTNlK0JSTHlEY3NKQWF4enpTdDZmclE1b2JHL29nK04yV0xJWmhRYzNT?=
 =?utf-8?B?cTlJcnZkUTZ4Yk05V3dJaUxFR2JuT0IycTlwSDVqZ0FCK3h5T2RwMnY2NjU5?=
 =?utf-8?B?QjN0VEpwRldxV2VjUkE2L2NMTkxhM0xBUk1JTGdGb1NRdGxOYmZtYkNIMWpy?=
 =?utf-8?B?RkVCS2JRMjFYclNtK05zSUdRT0dLOFFiOWxacFM1QWdmNVA2bVJiWnpyYmJz?=
 =?utf-8?B?RmdheDlxRWpZSnVDclFiZThaenp4OHlkWTZOODhQMWIyenQrOGVubmFhRDYy?=
 =?utf-8?B?TWdudFpacGc1VWJIMUx1Z2ZUbmJnQ1BJT3RVanBGRThMUnliYW9kcmM1VCtJ?=
 =?utf-8?B?MW4xVm9FNEZ0V0R4MUZ3bUNaZ0ZERkk2eUJ5UUpWV3JUMlowRExDWnp0c21i?=
 =?utf-8?B?MnoyandRMk9iS3hpSXdZdHFhcUVpY1p0NExUUFR0bVV5bDcyMTIwR05KTk1W?=
 =?utf-8?B?dDFmNmlvNGpWSFc4Y2NUWTYzSW80cUsxZDM5U0loaUpqVUNpVTU2NTFOREFT?=
 =?utf-8?B?d0Q4YnIrakJaeDEvU3V4V1AvMkFJR0hYaFRoUEhWc3p2ZDlXOW91eW5wUzZH?=
 =?utf-8?B?VDdwazREMUNtUXdJRFJjRVhZeUtVdWJOK2U3ZHNEeGtoUUdac0Niclh3eW9i?=
 =?utf-8?B?ZmhZYm84R1g5a0llYzBweVNGWkV0L3pJN3Z5cGppTURRaExmMGJyNnpDbzJ6?=
 =?utf-8?B?SytnWHZWUVIrTHQzRTVQRVlCWWFYaTJCQVVsNDhoUFd5QURKelNvL2dRWWls?=
 =?utf-8?B?R3ZXc1pBK2xlZlZhMmJOWnZZT1dBYUhYM3NoSDRiMjhpWk1QTEtJQVFwaC92?=
 =?utf-8?B?THZyRVhtQ296MjUxckJMZHNxeDZPNHY4bUs0aFlBbVF3ZGVSUFM3azZoZ29w?=
 =?utf-8?B?VW5sWS9pS1luRytlOEVKRktOaUw0d3EwdUl4SnplTWJDRjZ5VmIwRHZhYytM?=
 =?utf-8?B?cjBybWVGR2Rad1Y5VmNaZmVjQ3pQRzlrdjVjRWFBY0txZGszU011TllTK2x6?=
 =?utf-8?B?Wi9kalFCN083WGdqZTArbzdiUWVOazVqSEZQZXZwN2E0WjJKeG45cGxEMDI1?=
 =?utf-8?B?WFZDdVBRUGJ2UlBrcVRBcFFuZkhmaDlPQjU0MFZVbCt1cDA5a0xFT0I5SW5F?=
 =?utf-8?B?dEtFRVM2K2tadFI4VUtPSUkvbEp1eUdtL0VSWXFKRUdxR0ZRVUFuTDIzalZQ?=
 =?utf-8?B?eWJ2bE5JSFMvcEtNTmNCOHRqcjVhdVo3TFRCdnl3OThIMnQwVElzdzRyYmJ0?=
 =?utf-8?B?QWxwMHZqZXo0eHdEUUxVZHZwbk5YNkF4MnhnOG41SHBSMkI1aStLWHJCUGlR?=
 =?utf-8?B?UUdDZm9CYm83dlMyaHRJM0Z1VDNaSUthaG8xdXRSZVovbzNDbjlHVzZUYmJV?=
 =?utf-8?B?dHNiWFlKR0NXR01sNW9yaFdjdWI1dFBXZkRsRU1ySm80Z3V0TnJEc1BDRldt?=
 =?utf-8?B?cEdSTlZBcE1PY0VMNjk4NVlsc0ZwREhBSU9EYVdYU3pvNVJpcVJ2eE9nZUJj?=
 =?utf-8?B?bjRybGszcFNkakVCVE9wdEZNdXZCVWQ4TWI5ay9NYWc1L1RJUkliMEljL2Fo?=
 =?utf-8?B?RmNSSGM1SGVzeWZmQ3l0ZU9GNGlEV3c5S01EeHVuUnhWbE92L20zWU9GVkNo?=
 =?utf-8?B?Y3Y0SFBtWUVlU05iL1NMci90NGliSkJ4cmlDM0luSDNuZ3RzTFEwajRxeFZK?=
 =?utf-8?B?dGF1WUFHRXJDb013aDBXWHRvRFpUaFpBZTZuNC9nN2ZHRkhVZDRQT3dZWkZk?=
 =?utf-8?Q?Urmq/RMMhrLWClsViG91zVHMz3aGtVRrzA1mmlZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad85a0e2-6f8a-4628-17e8-08d947c6ab2f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 19:28:05.4260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGvTpelibx3DzYDRhgWTUfzapJuCvcSmqLoT6ON0Pdx7k/SX6nrio55FtaMB3s/lwe/4NW239RsNHOPdM+btbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4671
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/15/21 1:37 PM, Sean Christopherson wrote:
> On Wed, Jul 07, 2021, Brijesh Singh wrote:
>> The snp_lookup_page_in_rmptable() can be used by the host to read the RMP
>> entry for a given page. The RMP entry format is documented in AMD PPR, see
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fattachment.cgi%3Fid%3D296015&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C2140214b3fbd4a71617008d947bf9ae7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637619710568694335%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=AkCyolw0P%2BrRFF%2FAnRozld4GkegQ0hR%2F523DI48jB4g%3D&amp;reserved=0.
> 
> Ewwwwww, the RMP format isn't architectural!?
> 
>    Architecturally the format of RMP entries are not specified in APM. In order
>    to assist software, the following table specifies select portions of the RMP
>    entry format for this specific product.
> 

Unfortunately yes.

But the documented fields in the RMP entry is architectural. The entry 
fields are documented in the APM section 15.36. So, in future we are 
guaranteed to have those fields available. If we are reading the RMP 
table directly, then architecture should provide some other means to get 
to fields from the RMP entry.


> I know we generally don't want to add infrastructure without good reason, but on
> the other hand exposing a microarchitectural data structure to the kernel at large
> is going to be a disaster if the format does change on a future processor.
> 
> Looking at the future patches, dump_rmpentry() is the only power user, e.g.
> everything else mostly looks at "assigned" and "level" (and one ratelimited warn
> on "validated" in snp_make_page_shared(), but I suspect that particular check
> can and should be dropped).
> 

Yes, we need "assigned" and "level" and other entries are mainly for the 
debug purposes.

> So, what about hiding "struct rmpentry" and possibly renaming it to something
> scary/microarchitectural, e.g. something like
> 

Yes, it will work fine.

> /*
>   * Returns 1 if the RMP entry is assigned, 0 if it exists but is not assigned,
>   * and -errno if there is no corresponding RMP entry.
>   */
> int snp_lookup_rmpentry(struct page *page, int *level)
> {
> 	unsigned long phys = page_to_pfn(page) << PAGE_SHIFT;
> 	struct rmpentry *entry, *large_entry;
> 	unsigned long vaddr;
> 
> 	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
> 		return -ENXIO;
> 
> 	vaddr = rmptable_start + rmptable_page_offset(phys);
> 	if (unlikely(vaddr > rmptable_end))
> 		return -EXNIO;
> 
> 	entry = (struct rmpentry *)vaddr;
> 
> 	/* Read a large RMP entry to get the correct page level used in RMP entry. */
> 	vaddr = rmptable_start + rmptable_page_offset(phys & PMD_MASK);
> 	large_entry = (struct rmpentry *)vaddr;
> 	*level = RMP_TO_X86_PG_LEVEL(rmpentry_pagesize(large_entry));
> 
> 	return !!entry->assigned;
> }
> 
> 
> And then move dump_rmpentry() (or add a helper) in sev.c so that "struct rmpentry"
> can be declared in sev.c.
> 

Ack.


>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>   arch/x86/include/asm/sev.h |  4 +--
>>   arch/x86/kernel/sev.c      | 26 +++++++++++++++++++
>>   include/linux/sev.h        | 51 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 78 insertions(+), 3 deletions(-)
>>   create mode 100644 include/linux/sev.h
>>
>> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
>> index 6c23e694a109..9e7e7e737f55 100644
>> --- a/arch/x86/include/asm/sev.h
>> +++ b/arch/x86/include/asm/sev.h
>> @@ -9,6 +9,7 @@
>>   #define __ASM_ENCRYPTED_STATE_H
>>   
>>   #include <linux/types.h>
>> +#include <linux/sev.h>
> 
> Why move things to linux/sev.h?  AFAICT, even at the end of the series, the only
> users of anything in this file all reside somewhere in arch/x86.
> 


If we go with approach where the 'struct rmpentry' is not visible 
outside the arch/x86/kernel/sev.c then there is no need to define all 
these bit fields in linux/sev.h. I kept in linux/sev.h because driver 
(KVM, and PSP) uses the rmpentry_xxx() to read the fields.


>>   #include <asm/insn.h>
>>   #include <asm/sev-common.h>
>>   #include <asm/bootparam.h>
>> @@ -75,9 +76,6 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
>>   /* Software defined (when rFlags.CF = 1) */
>>   #define PVALIDATE_FAIL_NOUPDATE		255
>>   
>> -/* RMP page size */
>> -#define RMP_PG_SIZE_4K			0
>> -
>>   #define RMPADJUST_VMSA_PAGE_BIT		BIT(16)
>>   
>>   #ifdef CONFIG_AMD_MEM_ENCRYPT
>> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>> index f9d813d498fa..1aed3d53f59f 100644
>> --- a/arch/x86/kernel/sev.c
>> +++ b/arch/x86/kernel/sev.c
>> @@ -49,6 +49,8 @@
>>   #define DR7_RESET_VALUE        0x400
>>   
>>   #define RMPTABLE_ENTRIES_OFFSET        0x4000
>> +#define RMPENTRY_SHIFT			8
>> +#define rmptable_page_offset(x)	(RMPTABLE_ENTRIES_OFFSET + (((unsigned long)x) >> RMPENTRY_SHIFT))
>>   
>>   /* For early boot hypervisor communication in SEV-ES enabled guests */
>>   static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
>> @@ -2319,3 +2321,27 @@ static int __init snp_rmptable_init(void)
>>    * passthough state, and it is available after subsys_initcall().
>>    */
>>   fs_initcall(snp_rmptable_init);
>> +
>> +struct rmpentry *snp_lookup_page_in_rmptable(struct page *page, int *level)
> 
> Maybe just snp_get_rmpentry?  Or snp_lookup_rmpentry?  I'm guessing the name was
> chosen to align with e.g. lookup_address_in_mm, but IMO the lookup_address helpers
> are oddly named.
> 

Yes, it was mostly choose to align with it. Dave recommended dropping 
the 'struct page *' arg from it and accept the pfn directly. Based on 
your feedbacks, I am going to add

int snp_lookup_rmpentry(unsigned long pfn, int *level);

thanks
