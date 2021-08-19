Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F228D3F254B
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 05:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbhHTDaR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 23:30:17 -0400
Received: from mail-dm3nam07on2048.outbound.protection.outlook.com ([40.107.95.48]:5601
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238069AbhHTDaP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 19 Aug 2021 23:30:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/Kpr4EKW5UC0iAIM/EUgPqcxi8lx09nxQP5nu7oN56GVBg/G/BfcJpQxV1aY9g+qljvpl2erwr7IQaeqSqTCmHEtf/eHFdYhXmw1pmULSKJktToHkvROtjA8vblqBv2mz3Moxea3riVyYv+UsZeOwSgSYWuqfU1Sczh/2fMGhNK3T08tg49jCbe8JUZRQORcr1EBf/hRqYgdK2YW3MC9R5c1CEUlgyZXKk6MpPkGWMnRMDtu0Dr+It946hweHV49xl8/RlJ4kggUFweJRhr0bsJmUdCtT9jES7ZgfooVpKUDkHl8li/+jE3kkibvXPhkfymdQkh4N15BMfpWC/OYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAEepqksv1hZbO8bByQqarnykxMa9JTCMjNo3XGp1r0=;
 b=ZXZR31fk0Q59J61BZR5UX6agBljKDprVULXSTk/ss3gAz5O1UXx34eEApg2DAlDg1zTGllO6HlOag1g7fP9vwEnDn59Zf0odlmClc+4+95JVo5dmuWJaJzdFLbDXWeOIax3PdALiluGB0VllG0O5i+7R+BtCiU8K56i8RzsK6AWNaZOxuuZM6HyvI2Jo3QfJ/zNM0cbiqZojh2eeDKoVy8U7YTBrJo7jsGleutoKiw7A9OLqBq3+NimolgxCSQ9b3pyLePRpAHg0XFPBgNWTpjtCFtBqfV8VWAYHLMyzCef0sqVETV10h7nh30zaGBakNWDDXkpGD/Hs4LrkYP9Aaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAEepqksv1hZbO8bByQqarnykxMa9JTCMjNo3XGp1r0=;
 b=XaXDDvQD2n7ia11F1PAqn9M5CTWNDOfdXxdDiV3zlwCLXh7+Zxb85K6WtceXbJYSowcHdU/DyVo5FK6iQZWYi0OYRNy/+ttpcIkUrrRYfShbEEmVMzsD8ufD+/+HFOIB32GPnbVv2+MKZbSMaArdNIZOWVXjf9NR/iPGIuym0Ik=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4005.namprd12.prod.outlook.com (2603:10b6:610:22::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 03:29:35 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0%8]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 03:29:35 +0000
Date:   Thu, 19 Aug 2021 18:42:58 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
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
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part1 RFC v4 24/36] x86/compressed/acpi: move EFI config
 table access to common code
Message-ID: <20210819234258.drlyzowk7y3t5wnw@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-25-brijesh.singh@amd.com>
 <YR42323cUxsbQo5h@zn.tnic>
 <20210819145831.42uszc4lcsffebzu@amd.com>
 <YR6QVh3qZUxqsyI+@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR6QVh3qZUxqsyI+@zn.tnic>
X-ClientProxiedBy: SN7PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:806:f2::34) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by SN7PR04CA0029.namprd04.prod.outlook.com (2603:10b6:806:f2::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 03:29:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72df3fc7-eb2c-4948-b7d8-08d9638abb34
X-MS-TrafficTypeDiagnostic: CH2PR12MB4005:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB400520FED0F33BE3A6894A0695C19@CH2PR12MB4005.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wIpLG1cuHuoUZAvFO4GCjJ1e3sq/euyjP9yjvpl6lymCIbZH+y/y6sM3gEnM1hrjuhpOk64gW964D5Qcq3yoCHYfyemJdqjW2xR+aHH5pwCRmCSEwIWHkRVLLGzhls2RiNidkve/O3mC97VqDhKPktsAeDYR3Z30JYNnlhriPMpeZmQofBEBaUpk3BvPPy5zNmRH97NZVxH/ji7pIEi6SdqS0dn2t0/5PI86wGj0A2S5L5SAgVX7W7gGmgQDFdtEPrkKn6otipK4vn4KO6h9PAJaDeg60nlfybkRHkRxSUJ520aCaZp4jT9T55kAJFxO7z9uRxeonP9bHwwa70wZ9nBMmwxpZTKjDQTc/n5N4jnnDsE83gk+7n2IoIbtRd1/2s0ii9MTw0p3kucuvtmyFOzDfymi+7Xb8Sw7FweFatXvLjspjs8jP5iYte7Clwr7izAJ1xbDRixygDpEnFBh7yRM5rHa9+bkyblrgtwcw2ORimy6X3cejhgPe14b/2jrzONXM/lv/egwxnC3j2IpSmFSazPpbw4BOk9dmOvmNTNjK+YkxFjcozILhEfHWLDfn0iylJPCSF8G4vhGSz3DXMPWRxy1QL6z0Mo4mXghsUkriiZiqYKTCON8s+Svbx3FSw9lv7ZN1ckmGQzemvOmT89cfuPDGSxIS0vZDJiK5Coh+zgVHRnkFgUIPLPkW9vil3k+aP00ESth3ePY1fUiApX84yZ+nSoQuhscDYW4tI0e686jgQkNcScFBDSWAgbHyDpnNl+ZiLCDF8Sjvshfqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(4326008)(54906003)(83380400001)(5660300002)(966005)(36756003)(45080400002)(186003)(66476007)(52116002)(1076003)(6486002)(6496006)(66946007)(478600001)(6666004)(66556008)(26005)(7406005)(8936002)(6916009)(7416002)(8676002)(2616005)(956004)(38350700002)(44832011)(38100700002)(2906002)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vweFfnElvbXHBDMUDyjsmNuz75vS+IeJ23nxMF1ce8c5z9GyzkJeCLIsLSIh?=
 =?us-ascii?Q?InnLkSMt9tspJOfOIOozUKXh/Xhj6iibmbKyyOVWG1r6EfJx07/YuDjfBnaQ?=
 =?us-ascii?Q?QG0yErgs1HaClM5pMvqSs3IuYwjiwHscmQdS2PjkJFvqSQfofnlb3bnaCCfe?=
 =?us-ascii?Q?GnFL1dGJhj7RfSMDwhZOQzKIz5G9xA0H/ViPFt0J0l2Xuy7REUHZVp75OWgz?=
 =?us-ascii?Q?LItYUi7WIhwxVFUEMPkHAvJwlKZRVCdpN6IQArI0kdnUhSehpXdKUHcHfIET?=
 =?us-ascii?Q?c605ktmbYlwnYcgYKcA7d4fqDgKhdTblKCBoToB2NZhOQ2tNZb+dFCW4GpBM?=
 =?us-ascii?Q?05r59An7CGmg4vADrbsXOZeOX2sLBN4EpIpdPVjoPJ15euApxFhXuYcBoU9g?=
 =?us-ascii?Q?4rqciOstfRFC8FXeeqdtRcmxu4A0w8rVtvB+Qda/PwTgP7koqrG+NMurlEP7?=
 =?us-ascii?Q?8mr9TkTO5dBbtJsYXBK6KG58Z2ExeCiEkBpyqL7zlx4UnQWRlDyVK+TPhy0O?=
 =?us-ascii?Q?7pBLoNARAHePoo6W9gvL5PptzKauPujnCTBdE2PqAzGAziTKP5771c+ihche?=
 =?us-ascii?Q?c38KOs0XYN3ZzdnCiHh/lrt1F7KKEY2konFQSat9ffqnbSz6BCYFuW6GwrLV?=
 =?us-ascii?Q?Sk8un/QY3OeFabHGf4R8K8vW5NlxO8+RhEBYEosyXIPqpcqdXnxwNs7GmQCY?=
 =?us-ascii?Q?4wfAcm/8Iah+XjkO984QndTgIZj1nrU+BBmbp1pltgBqjuHiQk1j3kW4gRcF?=
 =?us-ascii?Q?hOj2M5VjHdJ65cwsWzbKGB5ZREhCMSCsLVIekd2V/5WEaQ1GfjCf6VkhYfy4?=
 =?us-ascii?Q?Mfk7zsAaUb9bAV0fFanEkul0HwscI57cRpRf8QviMJJREHotBUjGvp8O65Wv?=
 =?us-ascii?Q?DdrrSBeWfUY+TqGUl9fMSP9vw08kBojTDmZHhhfRTRt8c+BB7uITa+vOZJvj?=
 =?us-ascii?Q?eKlyFwc2To6R+NEL/yWJjEv9NgyvFt1WooHfS3c7CWhBOKNPy7RG7dEGv+HE?=
 =?us-ascii?Q?+7Ea6Dh/Q9I+SKXQ37ESkvPwpcHU7y0Rlnurxgc0uAxKlX/mIdw/mRQMa/aj?=
 =?us-ascii?Q?nvFZkXEB2rY2+uU9g993Z2izzGXbXSA1seI7U+wGOF8wzPiCErhK1j8rGBoj?=
 =?us-ascii?Q?u2/NBH1LAxgDyhYDoeAoWYuN5XgnYJIqG7+5ZO7z19GZKTbrjwIDr7guRoK2?=
 =?us-ascii?Q?OBuwoV0C9qgigm+y4j63zBEXk/JIt6qil469+GIV/lhVp9EboWbrMiruzJBh?=
 =?us-ascii?Q?Jj21knDs8XaehnKhbiue1+pExAgGtyNXdM9+HPwCDSFQbyCUG1e6ZN07BCCj?=
 =?us-ascii?Q?f48GZMtKJXHJCumpx+lzEAxx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72df3fc7-eb2c-4948-b7d8-08d9638abb34
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 03:29:35.6714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1LoElluitC5lRWD9vh7TZQ595Ap9WWphGMwUVbHA5Iwww2mgjToXchFiTuNb0cwaS61fgTIg8pm52OvNOiAHxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4005
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 19, 2021 at 07:09:42PM +0200, Borislav Petkov wrote:
> On Thu, Aug 19, 2021 at 09:58:31AM -0500, Michael Roth wrote:
> > Not sure what you mean here. All the interfaces introduced here are used
> > by acpi.c. There is another helper added later (efi_bp_find_vendor_table())
> > in "enable SEV-SNP-validated CPUID in #VC handler", since it's not used
> > here by acpi.c.
> 
> Maybe I got confused by the amount of changes in a single patch. I'll
> try harder with your v5. :)
> 
> > There is the aforementioned efi_bp_find_vendor_table() that does the
> > simple iteration, but I wasn't sure how to build the "find one of these,
> > but this one is preferred" logic into it in a reasonable way.
> 
> Instead of efi_foreach_conf_entry() you simply do a bog-down simple
> loop and each time you stop at a table, you examine it and overwrite
> pointers, if you've found something better.
> 
> With "overwrite pointers" I mean you cache the pointers to those conf
> tables you iterate over and dig out so that you don't have to do it a
> second time. That is, *if* you need them a second time. I believe you
> call at least efi_bp_get_conf_table() twice... you get the idea.

Sorry I'm still a little confused on how to determine "something better",
since it's acpi.c that decides which GUID is preferred, whereas
efi_find_vendor_table() is a library function with no outside knowledge
other than its arguments, so to return the preferred pointer it would need
both/multiple GUIDs passed in as arguments, wouldn't it? (or a callback)

Another alternative is something like what
drivers/firmware/efi/efi.c:common_tables does, where interesting table
GUIDs are each associated with a pointer, and all the pointers can then
be initialized with to the corresponding table address with a single pass.
But would need to be careful to re-initialize those pointers when BSS gets
cleared, or declare them in __section(".data"). Is that closer to what
you were thinking?

> 
> > I could just call it once for each of these GUIDs though. I was
> > hesitant to do so since it's less efficient than existing code, but if
> > it's worth it for the simplification then I'm all for it.
> 
> Yeah, this is executed once during boot so I don't think you can make it
> more efficient than a single iteration over the config table blobs.

In v5, I've simplified things to just call efi_find_vendor_table() once
for ACPI_20_TABLE_GUID, then once for ACPI_TABLE_GUID if that's not
available. So definitely doesn't sound like what you are suggesting here,
but does at least simplify code and gets rid of the efi_foreach* stuff. But
happy to rework things if you had something else in mind.

> 
> I hope that makes more sense.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C2a4304e70b5b4f2137f808d963340eec%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637649897546039774%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=GKDogD%2BOCN0swhmT4RZ2%2B3JmURF3e4qq%2FzgrxxFqJt0%3D&amp;reserved=0
