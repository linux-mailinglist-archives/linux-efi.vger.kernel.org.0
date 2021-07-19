Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E4F3CD52D
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jul 2021 14:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236980AbhGSMOg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Jul 2021 08:14:36 -0400
Received: from mail-mw2nam12on2064.outbound.protection.outlook.com ([40.107.244.64]:61418
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231282AbhGSMOg (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 19 Jul 2021 08:14:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBJEqLFbUzw90X457F/VBe9HOWs6vogS3b/Ae0Dcrj5sa3fEj1J8Nvva2PcqHi/cuMvQgK10CPFF9aSzRrBPAycwYBYMOEulwNxL9Gcny/OU1LyMDDAEgJaUPXbUC636mJVgElMR/ibUL5vF8DVlp+Ej7UGsN8QXIV3eXz1FctWx+Vv6RA58k2WGMTtoYAtaNVWiVbIbII30ATA2HXpA68T86dke9UrZrVKSkoYn5MbPZGC/6rztjLvZv2qyRE7R+oLG0yn4zodMLbRgqGuPkCEp2vhKaNUkmC1Yv0Ng/Lv0kUAeUv22J3PE7r4lTAutG70yGvyR8gjM+VnIe+GjQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uV+uSzOOEnM1v0o6hVcN+YdSUgyF482lkBVFQTIGru4=;
 b=Y0XseKNS4g1vrc67G8Km7z/B772gt+ldkelOiuHFlmiJVOZ/ZxpMo8UsKcYVSpVPc1iHqm0+3rv6ZsP75jCSV/v5eD8KChtlh+9QsEM6UKdGRMV7j0ERGwxxRgR8/gn0BnNUaEzP4N3qJCRRI7uUjjHcy5mns3nhhIL2zxZWD15KuMcQT1RpLgy1/lVtv9SHpEHxr2WqyaPPmgL88Z6hjhEblrdJVSjfTc7jrAsV1whwkb9vL8iio9sbp/0StEn3tV3Zi5GBirhAXxFJM9facMPNqJUOTt3YHUinA0ELMPw7dA2X5/kbk6Abpl3NwmCtZgu00OqNWnC+OSoL5X9CGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uV+uSzOOEnM1v0o6hVcN+YdSUgyF482lkBVFQTIGru4=;
 b=hrVsrMudlr3nDz+2/OWrV7c85kJ4viJT0tp5YcM/JtB6FRUIYGLGZ3rue3UovnSiE5KBng9pL1nIhtJEsou4Sg95KlR1GiTbczeojCVVWUp80yjpIxqLorkoJjuIPW5zdpN1xsN5ZXPbpPYs2dQyAZgUCeGYUTt0iivvzoILyYc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4511.namprd12.prod.outlook.com (2603:10b6:806:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Mon, 19 Jul
 2021 12:55:14 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 12:55:14 +0000
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
Subject: Re: [PATCH Part2 RFC v4 25/40] KVM: SVM: Reclaim the guest pages when
 SEV-SNP VM terminates
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-26-brijesh.singh@amd.com> <YPHnb5pW9IoTcwWU@google.com>
 <2711d9f9-21a0-7baa-d0ff-2c0f69ca6949@amd.com> <YPIoaoDCjNVzn2ZM@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <e1cc1e21-e7b7-5930-1c01-8f4bb6e43b3a@amd.com>
Date:   Mon, 19 Jul 2021 07:55:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <YPIoaoDCjNVzn2ZM@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SA0PR11CA0126.namprd11.prod.outlook.com
 (2603:10b6:806:131::11) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SA0PR11CA0126.namprd11.prod.outlook.com (2603:10b6:806:131::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 12:55:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a530491-f3a5-4a8d-89df-08d94ab47326
X-MS-TrafficTypeDiagnostic: SA0PR12MB4511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4511D166D48517FC4C8F8FCDE5E19@SA0PR12MB4511.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b5fxj1miKJr4Jv/eocbA5Iyi2oARORNnk9SZJVDkAr2zkfWyTt8mSUdWqbOsKF3l+IjRkUc1xLFw9PqHjmZLG+icKcpM/icBVSOnF2OMfWsxc+hFChKGgSbRq69rkx6eKW6vAkSbHl3zzNp6vqTajjuUWt9HZaYF8lVX1zgj9BLgjWKtW1hiLzyx/Fl8A2Gs2o1ceAYbPjQGVh9YvhwcC/dRCQ95U7KKAQnKxXh1LyFhezvVVF4KLrVin6w39suasaa3qwrwvDsoq0DXPONpmJWvRXJ7DEdHcb1zsp4+UaKSrtOmF1jGI5v71MZgzuYk3hTq8DY2ZgAZovK1BGWFRVU/7+aDgG9lDZOJpOdGw/wj9i/kQWjK+am+FwCH3rkBr0fCA5MfG4fBnCp/HYHBHaw98GJu2fb5S2dp4a6les8d7XYSqaFHp8TmpwFIjJkwlrw8UuvGRzcB+wOcML4Skru+mOPv+Ed4A3+o0+BAktUJJbtL/yXAvYGgliQo0uq70h1JMqmldTUsGPoXoYBd+s9Fs6yVQbWVu4tDL4uOJeaoGduXOXfTs5efBTtGmxhDJtg5Q/TUqWWtF3x+2n9uc9jRPW4dN2Y9p38Yt/nXVaL5jyusSzXLwtWtQI+68DshT5LJZz78vjQfm3hB5phw59takYHG9Bbfg8aPATo5ljm7z45LsXMal4q9Z1HuagjI70bg6mjsUQNLMEpGZGvHffZvG/bMQin/NB9OhwHL4ndmZcvcjnWkfIEZqLGOiNWIjx1+v46fWbX3PnZMdDjL2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(8936002)(8676002)(6506007)(83380400001)(54906003)(53546011)(2906002)(2616005)(7416002)(52116002)(7406005)(956004)(31696002)(6486002)(26005)(66946007)(31686004)(38350700002)(38100700002)(5660300002)(186003)(6512007)(44832011)(36756003)(478600001)(66556008)(4326008)(66476007)(316002)(6916009)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZndsWVRNdDg4d3RVMGZEY2dLRi81K0RhQmRJNkxVZnpOSWJxUVUxekpjcklx?=
 =?utf-8?B?TStWWkt3SUpDeVc5VjU4MnJsNjBVa3JodnFNTE5LMittbW9QVjF0WXRYNHNo?=
 =?utf-8?B?UFRDbWF4WU1hRzFJd0VoUGljS0YyWFN2MXpRQXRmSG1XbTVrd2pabTR2blNB?=
 =?utf-8?B?SmlpRGpOZ1V5YUJIYTh5MjVPZVg1VlF5blRGUEdpelRuNlNUNEs5RTlod1R2?=
 =?utf-8?B?QmlWNkk2MWsyc3FoU0xDbkxKZFZLb2Zlbk1TOFEveks3M2xFYlFmbnZsMDVj?=
 =?utf-8?B?cmkrMXVjcTAraFowNkZTc0RaN1BGS0hlVWlKS28yUFdoMmhLM3VhYVVRV092?=
 =?utf-8?B?cGZiUzVqaXhVVlFDbjN0MFIrYU5pME5pVHRETTNFSURMNmdpWS9jNGs0L2pX?=
 =?utf-8?B?WGZkaUNFWi9MbUtoK1M1OExPSWo2UTh6cnpROTJ1dDcxVkZGVzcxYkVrdmUy?=
 =?utf-8?B?d0doOVNXekxzMTNkemtaV1ZESDZQNHdya1Y2Q2FwQlBIRzJsb2NSSXEwbGZV?=
 =?utf-8?B?bGdrV0Q2Q0tWY0p3aUlsK29tdkZERVcwUVdBY1VybGhSY2wyMkZRRi83UnJJ?=
 =?utf-8?B?TmhpM3NPM0VyR3hBS2g0dUhSZTEwNzhnMFRraVovWXJDUWNUVk9ZeHNYZlB2?=
 =?utf-8?B?aU4xYVpDa1ZlSUtyU3NtM1M3bVFVWHRVZlc0TjlEMUx4cEVYL2dKYkgrbFM3?=
 =?utf-8?B?NWdNQ0ZCbVFQUDZyOE1mNmc2NXlRd2d2UmxuOEU2bmNFTE5PRFFtTjJ0K1Y1?=
 =?utf-8?B?MjlGbmxuMFV3K2F0Q3BmZ1FYRUlUWWJxbEgrbDluVjR2M0hjQjU5WDhsVjZ4?=
 =?utf-8?B?TktUM2pKM3gzSU9xcHY5WGFlSFhBdTdRbnJBL1J0Z09NaWl5OFY5N1hXWmoy?=
 =?utf-8?B?bUlsZVRiTmRCWlRqUkJxWDViaUZsTEtPaXgvYXdHVVU2Y0ZEelB6d2RvRzI0?=
 =?utf-8?B?dW5SMUxPanFqM0c4WlFsVlh4ei9qTnU1a1JHL0FYOVdyTFhnSW5ZVmNsNFJ0?=
 =?utf-8?B?Wmh1ZW1BYnh1amZ6R2hsdXVxMUZFZGl4YW9Samp0ekFIVlVjWHZBRUd3a0lL?=
 =?utf-8?B?MzY2aFVlS3lxWnhRbkQ3RmlmZXh3VXY5cVFwQkdLSGNuMU0zL1BObzF2UlBm?=
 =?utf-8?B?SldoKzdZWnp0NFBrUFh5ZDZDZUlhcEZiQnpsNE9TY21OdUNJbzRHUlBQWW14?=
 =?utf-8?B?ODZrYlNBNzhaSS9Kb09uTnJzd2Yxc2JQTE5OMDdESnRqS2M3LzdjOFdWaWpH?=
 =?utf-8?B?NVI3NTBYK0ZZb1RMNWJBb1RkcWxQbWJrQmVXSHZxUlc3NUNLZGt6MG1WdG02?=
 =?utf-8?B?ZXJhN2JYWUpBVnprRGl0R1QzSXdIQndCL2xDcFdYUFRCQ0xoazc2N2NETzg2?=
 =?utf-8?B?akhlWXllVFhtbCs2MlNZSEpacDBzeHppaWplMXhDUUhLRVVRZEJqVGpmRVhj?=
 =?utf-8?B?Q1RIR0JhMjFRZzhwM1kzb0dDUmZKMjQ3MGFuTkNUakZVUUUweVVEcmd6aU5z?=
 =?utf-8?B?L21vNFZITkRNSTg4TElHcnpaYlJLc0tRWlJRN0hxWGF4MlNITFhKaWUwcnVy?=
 =?utf-8?B?STIwbzB2Z2hZaE5obDF4K2lzVWlMOGlMMDdidGpsWndsQmtZMU5qMUdhc1hi?=
 =?utf-8?B?eDMrQ0xJdXloYUpKMWRPUmY3WS9LTEdzYi9DZnhxSERWdGtoU0grSTA4LzBV?=
 =?utf-8?B?OUl3NnV4T0pwdHJyeGRDb2NDK2RiT2FYKzJxMUZCZVpIVXhjNlJlYVI1WUEx?=
 =?utf-8?Q?7lBzq0dcGw58VP02Ed6XljpZc9lAP/d5Rijah5+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a530491-f3a5-4a8d-89df-08d94ab47326
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 12:55:13.8858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FymLvbVC/Xy+8Kg7DJ53twPmRMJLrhf0cGZWPA3qMJl0SPf84DbXbPTaeJxTUjkqPQey8oAmIsuYpR75W3dh6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4511
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 7/16/21 7:46 PM, Sean Christopherson wrote:

> takes the page size as a parameter even though it unconditionally zeros the page
> size flag in the RMP entry for unassigned pages.
>
> A wrapper around rmpupdate() would definitely help, e.g. (though level might need
> to be an "int" to avoid a bunch of casts).
>
>   int rmp_make_shared(u64 pfn, enum pg_level level);
>
> Wrappers for "private" and "firmware" would probably be helpful too.  And if you
> do that, I think you can bury both "struct rmpupdate", rmpupdate(), and
> X86_TO_RMP_PG_LEVEL() in arch/x86/kernel/sev.c.  snp_set_rmptable_state() might
> need some refactoring to avoid three booleans, but I guess maybe that could be
> an exception?  Not sure.  Anyways, was thinking something like:
>
>   int rmp_make_private(u64 pfn, u64 gpa, enum pg_level level, int asid);
>   int rmp_make_firmware(u64 pfn);
>
> It would consolidate a bit of code, and more importantly it would give visual
> cues to the reader, e.g. it's easy to overlook "val = {0}" meaning "make shared".

Okay, I will add helper to make things easier. One case where we will
need to directly call the rmpupdate() is during the LAUNCH_UPDATE
command. In that case the page is private and its immutable bit is also
set. This is because the firmware makes change to the page, and we are
required to set the immutable bit before the call.


>
> Side topic, what happens if a firmware entry is configured with page_size=1?

Its not any different from the guest requesting a page private with the
page_size=1. Some firmware commands require the page_size=0, and others
can work with page_size=1 or page_size=0.


>
> And one architectural question: what prevents a malicious VMM from punching a 4k
> shared page into a 2mb private page?  E.g.
>
>   rmpupdate(1 << 20, [private, 2mb]);
>   rmpupdate(1 << 20 + 4096, [shared, 4kb]);
>
> I don't see any checks in the pseudocode that will detect this, and presumably the
> whole point of a 2mb private RMP entry is to not have to go walk the individual
> 4kb entries on a private access.

I believe pseudo-code is not meant to be exactly accurate and
comprehensive, but it is intended to summarize the HW behavior and
explain what can cause the different fault cases. In the real design we
may have a separate checks to catch the above issue. I just tested on
the hardware to ensure that HW correctly detects the above error
condition. However, in this case we are missing  a significant check (at
least the check that the 2M region is not already assigned). I have
raised the concern with the hardware team to look into updating the APM.
thank you so much for the bringing this up.

thanks
