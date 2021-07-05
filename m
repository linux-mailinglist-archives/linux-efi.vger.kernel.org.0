Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B2C3BBB59
	for <lists+linux-efi@lfdr.de>; Mon,  5 Jul 2021 12:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhGEKlw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Jul 2021 06:41:52 -0400
Received: from mail-co1nam11on2072.outbound.protection.outlook.com ([40.107.220.72]:27201
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231132AbhGEKlw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 5 Jul 2021 06:41:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6Cp62xpwQlaj5N3ns+8HK3u0shmkFy5dNxX1b98RCZr/Ya8QlM1mmbovsrX9OonCALcu6zJ6CaVQkfN7pS8VjBOZ7VnqFf+5yUTraXNhsH5kkY4GkWoY0HTfcXWVspJCgVDPN7SG1XMfwwFfFq4Z3kId8PVTzvLYwlEtwr62s2k00P0XktJmXP1nqYfn3l78AA6jHAC0/Afodz1HXKrNVvQE5E9g2EJUCH8PXBjPLWam0bZMiGxLE275dl553Cb2ztaLf5z/2aXtCJgXH24CvUtBGV6coQCmq7ugSTDLbPlKuerXPdHj4w3UJKciWbU+axbwqXsW6neY9czTPFFkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ttdNd5gJxm+Oyy4vh4A0iUmWkaHPfUjtbn3zIDpEqg=;
 b=b6vma36xLTN0E4liswyK/nrE9hb9zeIlkKzahJjH9tJSnOs7HeF8KOi3iQPhxF+1Kmm+lni6Gdn8cfHyeMVL5RiWGq/khrT+KyPTl54Yhc+icXdiZZApHibmgaY1bwpJ9jI18VjPZV5KMgJ90QCj5d6y+DsxYZBZfjJUarcGElDD3aqBjrReqPzrgOCwLlLnIMo2ObXlVzbjgDCEoC0iiBwBJVF76kr5IatYYtzmq9C2za6mXTJGMJg6cZYMnJValgutL2xNDKCZMGm401xmSJYBTI7JThrWjzhxazc4C0uI9YGqHaWSDm29K8Iv5qdGdtKlotj9ahsAxAATF1cn8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ttdNd5gJxm+Oyy4vh4A0iUmWkaHPfUjtbn3zIDpEqg=;
 b=3xpaMVZcJb08y+IhXrigDrCtQ734tJwl5s+4ld5ua8OLlj07UbXZu+BzSIpGL8YoQbpN2AsZTuyMCjV8u7o6opCmnRxisE4HET74Hv4NOuaw0cM7NRuxyNP9CrYLL7G6ItsNdRuVmPL+6qoPPo48isNdpdgKIPHCP8MR0FmLHeQ=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB4728.namprd12.prod.outlook.com (2603:10b6:a03:a3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Mon, 5 Jul
 2021 10:39:08 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 10:39:08 +0000
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
        npmccallum@redhat.com, Dov Murik <dovmurik@linux.ibm.com>
Subject: Re: [PATCH Part1 RFC v3 22/22] virt: Add SEV-SNP guest driver
To:     Borislav Petkov <bp@alien8.de>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-23-brijesh.singh@amd.com> <YNxzJ2I3ZumTELLb@zn.tnic>
 <46499161-0106-3ae9-9688-0afd9076b28b@amd.com> <YN4DixahyShxyyCv@zn.tnic>
 <5b4d20db-3013-4411-03b9-708dd18dbe64@amd.com> <YOCOIy1AW5RUfbx4@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <9c5037b6-d9a7-78e3-f2e4-bf8bebc12da7@amd.com>
Date:   Mon, 5 Jul 2021 05:39:04 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <YOCOIy1AW5RUfbx4@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SN4PR0401CA0007.namprd04.prod.outlook.com
 (2603:10b6:803:21::17) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SN4PR0401CA0007.namprd04.prod.outlook.com (2603:10b6:803:21::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21 via Frontend Transport; Mon, 5 Jul 2021 10:39:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b9313a0-b717-4254-80f7-08d93fa11e5e
X-MS-TrafficTypeDiagnostic: BYAPR12MB4728:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB4728244C0FDC7F2C24E4FF29E51C9@BYAPR12MB4728.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fJl4UDfYWxl9tDkMtbshyYofrig8ulSdTWr2BhHFeuxOD4o9iMosz1Gmog1hl2wWyAI+iwUlC7SFXBQvaMKtkWvU6qr7nk/x+dvw0YM0SE/hislrKj7U/NHc58RxrC5bqZOy1fjUD0sOxH2gmAHN/Kmuiw0Eu3WOfx14q62TM+/K/K0ee3r6X2rBeaK3ShsIP8qsr0BWUB5S9uAg8247QWvnmzvfsR6WhROkr4chq5YMbB8GGC7mog3w/k73hixZmu7sBEynOU6GdZKHtNg3J8ZBHb1vLhfIduN9rJP+bqTSwAqx9cg4cFOKerDuvefQu2SCw7vwSQtkHzlCqaJDpKTur12JIkZ1g1hnnBEwtLD83o+zopYVOk/Rsin1bYbNSzpX0WcyjbbQEQW7t9uxW+2/ujNss+VQ/NRMXKL8eVTjqRyJJfDLRY4WPpAfyHYonbpjgJASG4v59Qu+/BbFMZv38DCyNzxFQNDO3d9IMDgEYBoyQgNvMudk78f04rWW157oxteMTg9AA9Z1oe8sNSi2ky/cvhPuGkanerTpwRdrjouxIeWJTlJejgZ+O0nx944AgJfiGD4icaz/NAKg6/kkf36MgSjk5oRp5bblt0PWIse13HmsBjpi6B1pnEFSLOUwzWqVoUHYBUAF83RKf3Xcowzf5BJV03WTW0XZPVUkGTgT6+9HOGJuyMLasUGjx/4wA4OgZwFy37sdUcNX9xEbfTBiby6kQP6w3GX+0K1gs9fMO14vG7ze8ZYqwA54ZG5FSnvFSwAN5nGtS00ihQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(66476007)(6512007)(66556008)(38100700002)(31686004)(53546011)(6506007)(4326008)(38350700002)(66946007)(83380400001)(52116002)(8936002)(8676002)(316002)(44832011)(54906003)(478600001)(26005)(16526019)(186003)(31696002)(86362001)(6486002)(2906002)(7416002)(956004)(2616005)(5660300002)(36756003)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG5uVmM1QU9HSHFEYWEyODlscm1DK3dFaW1rUHdSZjl5Zy94d1pDTHMwMlhS?=
 =?utf-8?B?WWgwblhGRmoyOFpMek45cFhVUERHS1BqOFFjUTdLQUJWQjZqZGN4MTZGUFlw?=
 =?utf-8?B?WkcwZlMxL01ZWHRxc0xsNHZvNUhqS0ZwR1JaNGdSM092bGNzSFpBSFh4bDkz?=
 =?utf-8?B?anE2YWZLVTY1Mk92Z3ZLS3lMM0tzOTJGWENZSk9reTIyZzBpN2VrTnpPaDRO?=
 =?utf-8?B?ZzZCVTU3dkJvZml4cHlUWGd2STQvS0ZPblJ4QytRT0o3K2VXU1orN1U5OGox?=
 =?utf-8?B?dlY1STBpQjZ1N2k1OFN0TDhiZ0VEelBVY2tIR01ZZTJ3dE1sTEtlQU0xWE9B?=
 =?utf-8?B?UTRhSjZwMVdpQURaTFhMQ2V6MDh3R0x1RFJaWWJ6WVVjZlF4c3hESnRoS1NW?=
 =?utf-8?B?TnFJMnMyWGthaFphdlBJSnNLNCtFWTZxaGlyQ1ltbkZYQ2NRbmNTcXlxRk9H?=
 =?utf-8?B?NWFkdURTazdPd2xRYUZXajZIWFBEZHRYK1JNam1ydTVWZ0IwamJLb0hpYzdB?=
 =?utf-8?B?bnJoMnRaRHUvWmFVNDhvNmU3V0p5S3FkL2tZak9mYm54RW9ONUVHWnRzR1Fa?=
 =?utf-8?B?a2dybzhpclRIMmZRQ2tJazhZVWszWlRtTmlMWGx5OFhLOFdQamxxQ1VuTUZG?=
 =?utf-8?B?RmR3ZjliQWlJTklvMTRWeDF0eUxVT2FNU1NEb0tYMVF2NkVjZDloOWdNYlk0?=
 =?utf-8?B?QkEyVWtnaGdNdy9mRDJQUWZST3BVQndPQnl3cC9nalA1a3h0V3RTWS9meTJz?=
 =?utf-8?B?UzhOVnJ3U0VuYWhrZnVCbU5JSWx4NkRBdzM4MkIzcVc2VEREOFNibDAzb1dW?=
 =?utf-8?B?ME1IWTVSZ0dyWTJIdTJoa25NRVVTNjhZQlA3am5qTWtKRFI4N2ZGVmtvcE96?=
 =?utf-8?B?TVhPdVRYNVpNL3hxalg1d21GYWtGWmZOU2NiQ3hhZEgvOTNtMHkvb0kxT1Vn?=
 =?utf-8?B?MVhFSkJpdnF6cklTSzJzRGk0TnF2c2ZZMEI3SW5aVEtlRU9vVzAwK1BETGox?=
 =?utf-8?B?QWNydzFIbkV5NGovZmpXYjQyVmhrYWowSHdDQkxPa3NKREdSYUJIZS94cE9j?=
 =?utf-8?B?bTZTNFBBRkt5alg3NVpnU2hUcC9nMTZTK0xTamNjdUFBQnAzMTZYcGI4b1c5?=
 =?utf-8?B?ZE5KTDBFZzh4dExsU3NVdXl3eHhqaUovNmZGWmxmdVlOZDlOKzVBQWtJT20w?=
 =?utf-8?B?cDlPc0NRVnVmM3E0TytCTjJDcnJ0NjBUOGhteVQwTEMzS1hBMlJIZi80WmNV?=
 =?utf-8?B?SmpHZEJ5U05mRjgwWTI5Ky85bHFLeEZQRGlBYkhtcVFxenkwSUhUZU5kamN1?=
 =?utf-8?B?ZkhVZEd0V2VWNU9rd25BbnNNMWdsME4vV25Rc09UZ0tEREpQZ3lYOTIzREVD?=
 =?utf-8?B?QTIyVUxLdE55b2hXYmpOY0pjb3J2SGZtSjF0dTNkWDVwcWhVd2grRnllTVJi?=
 =?utf-8?B?ZXduenBBdnNyZng5UHg4NTdrNkZYSWYzc2xMSm1taFNVN0tzY2Nvd25WNGQ3?=
 =?utf-8?B?RllycWUrVjN1Q1ZxZUs1cUhrSldyaTRZQVZtVUxINnNncUJjSFFaUXAvWXBr?=
 =?utf-8?B?Z0RTMHFyQTN0aWd0QVM2MFMxM3ZZS3Y1SmdRc05JdjhENi90SmNHS0V5SzE3?=
 =?utf-8?B?OFhmU1BXdWpsaFVMN3l4UkFQNTcyUmJoWGFJUjVYYStFYk1TdFVJZDFPUnB1?=
 =?utf-8?B?ZnhwaVBYTDUreGVoK3ZyZW8yYVJmSitjeGdyeko3L2JibTlubXEydkU1aGxr?=
 =?utf-8?Q?EV6oUfCtyx/oAZtSAr+lXtcOvS2PpKlM543CS+X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9313a0-b717-4254-80f7-08d93fa11e5e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 10:39:08.4448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BzJNYDKIJiQTcUbow747cQX49QR9ChnSSYw4gQ8tL7Km7iF/ynjKraxsRD5TqJO7Mmk3LXA9pVA3VaENt/QFRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4728
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 7/3/21 11:19 AM, Borislav Petkov wrote:
> On Thu, Jul 01, 2021 at 04:32:25PM -0500, Brijesh Singh wrote:
>> The spec definition is present in include/linux/psp-sev.h but sometime
>> we don't expose the spec defs as-is to userspace.
> Why?
>
> Having such undocumented and maybe unwarranted differences - I still
> don't see a clear reason why - is calling for additional and unnecessary
> confusion.

Because some of fields don't make any sense for the userspace interfaces. 


>
>> Several SEV/SEV-SNP does not need to be exposed to the userspace,
>> those which need to be expose we provide a bit modified Linux uapi for
>> it, and for SEV drivers we choose "_user" prefix.
> Is that documented somewhere?
>
> Because "user" doesn't tell me it is a modified structure which is
> different from the spec.

We have good documentation for the SEV ioctl and structure provided
through the KVM interface.

Unfortunately the the documentation for the ioctl and structure provided
through /dev/sev does not exist. We could look into adding this
documentation outside this series. The structure provided through
/dev/sev is identical to the structure documented in the spec with minor
changes such as not exposing reserved fields or rename from paddr to
uaddr etc.


>> e.g
>> a spec definition for the PEK import in include/linux/psp-sev.h is:
>> struct sev_data_pek_cert_import {
>> 	u64 pdh_cert_address;  /* system physical address */
>> 	u32 pdh_cert_len;
>> 	u32 reserved;
>> 	...
>> };
>>
>> But its corresponding userspace structure def in include/uapi/linux/psp-sev.h is:
>> struct sev_user_data_pek_cert_import {
>> 	__u64 pek_cert_uaddr; /* userspace address */
>> 	__u32 pek_cert_len;
>> 	...
>> };
> And the difference is a single "u32 reserved"?

Mostly yes.

>
> Dunno, from where I'm standing this looks like unnecessary confusion to
> me.
>> The ioctl handling takes care of mapping from uaddr to pa and other
>> things as required. So, I took similar approach for the SEV-SNP guest
>> ioctl. In this particular case the guest request structure defined in
>> the spec contains multiple field but many of those fields are managed
>> internally by the kernel (e.g seqno, IV, etc etc).
> Ok, multiple fields sounds like you wanna save on the data that is
> shovelled between kernel and user space and then some of the fields
> don't mean a thing for the user API. Ok.
>
> But again, where is this documented and stated clear so that people are
> aware?
>
> Or are you assuming that since the user counterparts are in
>
> include/uapi/linux/psp-sev.h
> 	^^^^
>
> and it being an uapi header, then that should state that?
>
Yes, the assumption is user wanting to communicate to PSP through
/dev/sev will need to include include psp-sev.h from
uapi/linux/psp-sev.h. The header file itself document the fields
definition, and then user need to refer to SEV SPEC for the further
details. I could start documenting the SNP specific ioctl in
Documentation/virt/coco/sevguest.rst and it can be later expanded to
cover SEV and SEV-ES.

-Brijesh


