Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1923B48AA
	for <lists+linux-efi@lfdr.de>; Fri, 25 Jun 2021 20:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhFYSQu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 25 Jun 2021 14:16:50 -0400
Received: from mail-mw2nam12on2075.outbound.protection.outlook.com ([40.107.244.75]:6240
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229586AbhFYSQu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 25 Jun 2021 14:16:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GShsGsrUVuZmp0btBmADpxJaLMCDqICPfv8VjZYvcRUTFkHBRTYwaKzdTTCch2y/1eRGNw2gdb4eeYvOCYa5TrcxYmpfa0sixS05nB0iwqMiVnQoX4iKOyuIxm8KkgbEmFR6wCWekmfApfB2UYbuiNBPO50tJEjUBfkYPwwGJ7ig0kFCqpeC0G3fs21EBeomrAPbcjB8rr+gzXl/rO7OC8Biha4WHApoXjelf3p35mHp+o2HunpPbBvEauRllsFFNvrTNcaDfYgu8xC0updxkKubVUmpyWF2+p6VyNDgDccoyMyOSBGPrIRbgrjsIwW+mLbq26pRGAxc0aSSvzmshw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h87/xh0YFqNHZJunHaqvsjR6z/t5Xc+32WkGw33Am8w=;
 b=gwwZ+JcwVM7c/KJc9YgXcIfMOv81/mNvOYuJ7kka/dnJ9ME5l7dvxcqHFajWy8kcMAFj06qu6SFUaABBajfiBhv9Ii8OA8vqD/l7D2HZHR/pnMf0ofh/QsmPSrV8qjwNxJn4Wg/DDjDnROeykes3FtD6tH3r5GPNaL2DXH6ttjEKP8SfyV92f/XBYyDj6BJDpDqqdUms7BxpWHtwflPinJHPCQW+Qe2X433a0ozZXRf7xN5Nzo0mpxvxa0PLF/0X4OkvtsNWzTPBZuRc2iRl6W9vlCeKO91P/Tbo1dlxLQiSDKtQ5AOSNC/lgVQJo/plmJBd8qUgz4KUdYS2q4Pocw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h87/xh0YFqNHZJunHaqvsjR6z/t5Xc+32WkGw33Am8w=;
 b=PL4YAQq5lusjcWiybpNJzlKj2spb4Pvuuo8fmu6tVXrY6oEwjG2O5KBmopkQTeL6A5gha//KBJcKLS5aB4KF5rCAjMgEdZ9RoTTSkHfTx7Vppyu2H5Gp7KRYNi1H6lBeHKGozM0lKvhiwHCjMZKXrehUpwr0kBAI6Ba5VvnAnwQ=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Fri, 25 Jun
 2021 18:14:26 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::181:e51d:a4f7:af62]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::181:e51d:a4f7:af62%5]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 18:14:26 +0000
Date:   Fri, 25 Jun 2021 13:14:17 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
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
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 20/22] x86/boot: Add Confidential Computing
 address to setup_header
Message-ID: <20210625181417.kaylo56pz4rlwwqr@amd.com>
References: <162442264313.98837.16983159316116149849@amd.com>
 <YNMLX6fbB3PQwSpv@zn.tnic>
 <20210624031911.eznpkbgjt4e445xj@amd.com>
 <YNQz7ZxEaSWjcjO2@zn.tnic>
 <20210624123447.zbfkohbtdusey66w@amd.com>
 <YNSAlJnXMjigpqu1@zn.tnic>
 <20210624141111.pzvb6gk5lzfelx26@amd.com>
 <YNXs1XRu31dFiR2Z@zn.tnic>
 <8faad91a-f229-dee3-0e1f-0b613596db17@amd.com>
 <YNYMAkoSoMnfhBnJ@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNYMAkoSoMnfhBnJ@zn.tnic>
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SN6PR01CA0031.prod.exchangelabs.com (2603:10b6:805:b6::44)
 To CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by SN6PR01CA0031.prod.exchangelabs.com (2603:10b6:805:b6::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend Transport; Fri, 25 Jun 2021 18:14:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c188246-55d0-43c5-5a67-08d938051112
X-MS-TrafficTypeDiagnostic: CH2PR12MB4264:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4264AE5E5A248B0C9C707DD595069@CH2PR12MB4264.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0l08VZzPy8EUcnUi26AInkG9hUX1oF8yNCC4I5XfCLo/VFm/WdLDBVReTgkolJQT9CXXQxCEmVLLcnaJGgecwKRb7Qh+M3ST3WGYx5E5AEwU9csDaXP+5IA21H0MpcTrQy1oMUy35jzwgWAA+S6FORKkTCuCf9p9Y9wSGSCeZz3dBg5bP690dxCwudQTYVz/YuHflgFy3gM+vhCVlSCwerwFyn536BWtLx/n1cmSLVcrAKouDEAaInqXZoqvjS5WQGS25jrirppZzaypoJZuwyrEtP/GFj1gR3/ixf5CrWLAMJrv/vCt2XPdQU6G+KEuwtruSkxAtzJlfGrbPLpPhYhOwajKJdUJbNF0NuVG+golJV8vgfZku3D+hDOJgC8mCPsOz1H+ruXIydAJp44av74c46WEcbzjCCyhHY0uhwJdi085q3ELgkbGc1CymaN3sKB7yqEX5AO/lSZA7Huwo97KvPeUrvs2yIp1aAMLb6EBoPIzzCQ6+sRHX4QhaGAP2xjUVSh3DEYUPT//w4OWPbAVgYMo+rG/aa0fe6TvxZPD8pFrycMh6XrUv1llvnhEUg5HG8K7tMXoMjVA9hhYquj2vTHS5sKwKvx2w2ZlhyLdaThKySxbh5WYFcZDwkP+O//00jjNjatWDVRwd8t/YuRVFrZ3dpPmCmKWUpXCeb6b0E8Qqfy1Izj14i3UJm7wTdF6KDdCrTfUGMcSE7SWtHzrcKflOE/MKn+TqWEtSSYulhm4JJ36rTSYGHEND3wjpGUYCdDrJrnE+Vgx952L5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(66556008)(6496006)(66476007)(44832011)(316002)(54906003)(186003)(26005)(16526019)(2616005)(956004)(52116002)(1076003)(66946007)(86362001)(4326008)(6666004)(36756003)(7416002)(966005)(478600001)(45080400002)(2906002)(8676002)(6916009)(8936002)(38350700002)(38100700002)(83380400001)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3UB0A6SHxUrLBDdjzwZaDcO3Hz7DGUdWnGRniLylMWw/KgsPAuGWIp85iKGV?=
 =?us-ascii?Q?wBwm0Qt9eeC/VKHtTf7HlvrC9guiTTuLia7xkDGwRWOraewP9lu+4yqvfh1X?=
 =?us-ascii?Q?F0fmUVldjwA3+X567rJjmvmzF8Qbewtry7DbTZXCwDQgAGLVO2mXfqTYRA0b?=
 =?us-ascii?Q?FJpkgqUS8iwrSd04t/e6s69WN1d+MF7QDUb2UbZ7zsSfyTOBsEunoVNOdN6r?=
 =?us-ascii?Q?1jFKrHGMsyhn5TIzctdv5siQCUhoABK1eJc271LD/GZxgK5dYygV10VvG1s1?=
 =?us-ascii?Q?TgUzx37JiX8gE0LaaeyBBf/4mpkbCnaW9j+TI/Zz04TGsE9tI5qsHoles9S/?=
 =?us-ascii?Q?satW2yUwa91VesS1g2vfHrFGHsWEtBRnTbGClOEqCAS1jMKrU6AY47BGH2Z9?=
 =?us-ascii?Q?AZ+jisUubCwaMuhu+yIeopBEzTPNwfu22NYSeDtw+rhsmpo2mkJU5ji+fEBz?=
 =?us-ascii?Q?/tUBrHiNbq3cYs4d5lmEAYDmbPexITWPsnbwmVMi/wgocVqgor5V9j5yVFxr?=
 =?us-ascii?Q?yCVxtI98B13xi0Xnz4vQPsQeOdA4ocn5k7bIhE93sS8Og9QmM28m3Ppma/uP?=
 =?us-ascii?Q?6n8UAP2bZYxeLbHIgvvFmKxA2Otr3ifu+OR2cB764WwiLaamcQCVaWyVXyv3?=
 =?us-ascii?Q?jxHqBaCwlk991rTzmU8aWVZ2h0v6Cg8c6ShhSCTXZ/L2lU2KOfIkU5lQ/XAg?=
 =?us-ascii?Q?NRQvgZD+iqorR3cthxmrZ/M/HvVj5b2fI83QLXG2Hy3oMh79VLEJfhtHueIR?=
 =?us-ascii?Q?T+Xl4ctNKnxwm+E15JjxjsPjnBJpnibndwi4s+VKCXa6BgJjtkXoBCpovFwI?=
 =?us-ascii?Q?qb+2Wf5Jx6V9HHtSZ3bNJN68p9u9zCTjYpMZ3vlWyP8LMRN7MFCbzy7QCiJ6?=
 =?us-ascii?Q?K1pCiHWTN5S8vfKJHs6pAZejThCghF8HmJrYWmGhVz5pmLutCaUqvljWD0zQ?=
 =?us-ascii?Q?1MrwilSFYloel4sCXUYPc+eqPUgo4Ic7++doy+lfNIwBVHck97QebeFtma3Z?=
 =?us-ascii?Q?A1DIy8GmBGenqcQO2lsk76ixrDlKZH+myK3LeXYVixhMSCOB0U2sZOpAGY6A?=
 =?us-ascii?Q?HIOQk4dxPZOhGRhBrp9exv+y2rF7fC/hPvd673dOGNGySvATfO5oZ3C4dDLr?=
 =?us-ascii?Q?AE0hCKapUfWNeUbQxKO3LJwoNWJMjDPkAyt3AIbBlni/Siwvbv4mxQU7os3U?=
 =?us-ascii?Q?XjF2ve9gQDUTL9HFSiTqZGFAMoFLK15YXn0pKJ7ZSoCjoyGXt/15khRtR4O+?=
 =?us-ascii?Q?ifWDb2I0HIp9K/syUIKuhXMwPiINYJsgU8EA5rKOZWjyCMFnYw1yXa9xXwR/?=
 =?us-ascii?Q?FJlZ/7YpkWn6INqpXfAlJOGp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c188246-55d0-43c5-5a67-08d938051112
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 18:14:26.6105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71UpN9Egw+hiwI8eJvjbDEZ3Mc95xFKofgTmF5owssHq76HvdGCSZ2HK+CxsQLbkStj9iDzgKO8cjLMawSDe/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4264
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 25, 2021 at 07:01:54PM +0200, Borislav Petkov wrote:
> On Fri, Jun 25, 2021 at 10:24:01AM -0500, Brijesh Singh wrote:
> > In the case of EFI, the CC blob structure is dynamically allocated
> > and passed through the EFI configuration table. The grub will not
> > know what value to pass in the cmdline unless we improve it to read
> > the EFI configuration table and rebuild the cmdline.
> 
> Or simply parse the EFI table.
> 
> To repeat my question: why do you need the CC blob in the boot kernel?

We basically need to be able to access the CPUID page in any place where we
might need to emulate a cpuid instruction, which both the boot kernel and
proper kernel do very early on for things like probing paging support and
checking for SEV/SME features.

> 
> Then, how does it work then in the !EFI case?

Currently, based on your v3 feedback, I have the following order of
precedence for getting at the cc blob to get the cpuid page:

For boot/compressed kernel:

  1) Search for CC blob in the following order/precedence:
     - via linux boot protocol / setup_data entry
     - via EFI configuration table
  2) If found, initialize boot_params->cc_blob_address to point to the
     blob so that uncompressed kernel can easily access it during very
     early boot without the need to re-parse EFI config table

For uncompressed/proper kernel:

  1) Search for CC blob in the following order/precedence:
     - via linux boot protocol / setup_data entry
     - via boot_params->cc_blob_address

So non-EFI case would rely purely on the setup_data entry for both (though
we could still use boot_params->cc_blob_address to avoid the need to scan
setup_data list in proper kernel as well, but scanning it early on doesn't
have the same issues as with EFI config table so it's not really
necessary there).

I opted to give setup_data precedence over EFI, since if a bootloader goes
the extra mile of packaging up a setup_data argument instead of just leaving
it to firmware/EFI config table, it might be out of some extra need.  For
example, if we do have a shared definition for both SEV and TDX, maybe the
bootloader needs to synthesize multiple EFI table entries, and a unified
setup_data will be easier for the kernel to consume than replicating that same
work, and maybe over time the fallback can be deprecated. And containers will
more than likely prefer setup_data approach, which might drive future changes
that aren't in lockstep with EFI definitions as well.

It doesn't matter much currently though since setup_data is basically just
pointing to the CC blob allocated by EFI.

> 
> The script glue that starts the lightweight container goes and
> "prepares" that blob and passes it to guest kernel? In which case
> setup_data should do the job, methinks.

Brijesh can correct me if I'm wrong, but I believe that's the intent, and the
setup_data approach definitely seems workable for that aspect.

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CMichael.Roth%40amd.com%7Cf927ef94d7af4819892708d937faf24b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637602373266379986%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=t5iRKv6RcaPazLlON1oGyyEZdxX%2FAxZz8cjJwrz7UqQ%3D&amp;reserved=0
