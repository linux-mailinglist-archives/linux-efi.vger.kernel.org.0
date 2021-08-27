Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B493FB96C
	for <lists+linux-efi@lfdr.de>; Mon, 30 Aug 2021 17:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbhH3P47 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Aug 2021 11:56:59 -0400
Received: from mail-mw2nam12on2079.outbound.protection.outlook.com ([40.107.244.79]:17184
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237761AbhH3P46 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 30 Aug 2021 11:56:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZKRk4sXa2h+iY46x90gW1CslTkgcUXjHz38PhxyEU6d0JK/ddwjexsQbCe24KubtRBcqXeiXpb7r1urfD5V2DVx5isBTeucvxgGcTes7mA0r7+S1mVLDti65AWv8GPpqsv+TXfrqlSBhRcOQ/U57F0VLT8hl95SQ7Vzm2mjCY+zVRQIzCqMXLx39/9paHnpmoSx1UnePhnjh0+J5Bjay5Ifkqj2R4hpXNLhcfpcAJWYRBEL0thQ1WHpcW5AOGZVgMUNxppu50iqV6dv3dRirTBBhCpCySHVW92RrbsUHgXRcv8I3gZbPjGUynMZXvHYTilYENORd0Oq2qTxu/Pgrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNRaYuBjw2iNHntNVdvWq8vibTZfttNkH846z0+hwv4=;
 b=LY4s92Rlfj3YKNxVU02sl/UCVi6aQ7OLPCIwpP1QWCGlgZAwn3Y9jQ/kbwzOvODeGRvjMyjufH6UCNhSByi53gXs4nvCgNixxFShLKNDdXckbBfyLvA6RCkoQqzn79UEjFHo7dF5VgKaXaMJqaBqU8wwAojmLz0p+zA8IvlBN/KqKFeGHkcc+gretz0YENngREoNvnFjitwBnW8ITZKWoH9P9JcCbtpxGrStQGgZHa7rV7Y3yjbNcPowMHQfj7PbCt5efDa4MCsXVsFMjjhb+nnvo1TGCPOA7yYzh7Td9OQIdt58H5U7c9XI65jrBN2iyDChkQ3PdLf5qpv0B2ydVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNRaYuBjw2iNHntNVdvWq8vibTZfttNkH846z0+hwv4=;
 b=gyoMJoKnYOcGp2hpXEc778ooOwGTfWOpNdixsKIqGOVo8sUlLJkn6flCqZmw+ZgZiCk2UW64VI7yDE4p49mPftXnbzrT1Wv7oqPHKMtrSQpvjM47Qh/jnOQJdS8ZBEKzZ4EQ8ZJVADCEERIEGp7lyXFN4h68PrSPbJ1oE6PoXhc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 15:56:02 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0%8]) with mapi id 15.20.4436.019; Mon, 30 Aug 2021
 15:56:02 +0000
Date:   Fri, 27 Aug 2021 13:39:23 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 32/38] x86/sev: enable SEV-SNP-validated CPUID
 in #VC handlers
Message-ID: <20210827183923.xvgeml3etyb2glv6@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-33-brijesh.singh@amd.com>
 <YSkCWVTd0ZEvphlx@zn.tnic>
 <62e8b7f2-4e0d-5836-ea37-9e0a7a797017@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62e8b7f2-4e0d-5836-ea37-9e0a7a797017@amd.com>
X-ClientProxiedBy: SA9PR13CA0116.namprd13.prod.outlook.com
 (2603:10b6:806:24::31) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by SA9PR13CA0116.namprd13.prod.outlook.com (2603:10b6:806:24::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.6 via Frontend Transport; Mon, 30 Aug 2021 15:56:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a90fab4-57a0-4274-178d-08d96bceaade
X-MS-TrafficTypeDiagnostic: CH2PR12MB4039:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB403963C9942BD2F350C90B3095CB9@CH2PR12MB4039.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 140+cAnrMsxXNubzLDakAw//c3CRDXs6MwSMv2wzqwu1KGdVLzo+HVfxaeD/CPLpqNlfoR5fMyT1W4qQkEeA9vq0TAhpOzrrCoDAZzwOXej1jiPeLlS98HRw2Bit5RWSOg09SHUQeNcOs2f0r52SL2v2lPflQwcU8JE9Iyj3yZTTHirizjpLwIlyjG4ZUDCzlG3RW87/CZRUTnVVIrlpbHRpfgvoQPJLYk+EUNVLz1qDSsp3t46YFvg7fm0TIU6xXgN7x+xYfwkYAYBDjbKtLJKTGzr0JkOID+AKQfvtMvsZDEVavSqhHUA5pW8wjvCd2JcqxH2i9vZajf+iiGYXn6JYJ1fKUaO9mHznqk6vePFhL6EAhs2KQtnXEjTILzYOe7IJ6zX+gfOZMdkyoV7D16pNCRrz0dbqCyrl258JVDxkIUX8bAxVg2cTrkJ1A9Ave/xAAI05+NxxlKyBnaiDdGOWkWuLD/Kuibo3AOEpxAuOKGDL97L3jhBm5VKNOe6hvmAzyVgwhBqPWqFV/mixp4SYRVJVNRxtqv79nAbV7d2XRstg2i9MoLrM5vAnq2XBtKrqwpNW9hEzBzHO8S/0Nbmua5ZEe56HKZH5CUhv6UnihljU65dg0h+/o1cId8QFO2Y96ltoY9H7098C0CIypOLdID3yUrXyNBo5Q1ykAJXFthPlB+80wof8vdBu6kFK+VdPDAiGV3BALZHFww0Cfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(38350700002)(2906002)(508600001)(86362001)(38100700002)(1076003)(66556008)(36756003)(186003)(956004)(6862004)(83380400001)(7406005)(7416002)(6666004)(52116002)(4326008)(53546011)(15650500001)(6486002)(26005)(6496006)(54906003)(6636002)(66946007)(316002)(2616005)(8936002)(44832011)(37006003)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?nB4NrolIMDK6txR7TWNvn18/p8/jcnQWj8TRbawiJoYlFVRjNEEzirLpI7?=
 =?iso-8859-1?Q?e6MwKV3/iXtymcM4nGlHqN+TuKL06i6XpZLl1JmR7+kQ77U008QDzFf+sz?=
 =?iso-8859-1?Q?cmkTLZCl50pAXCczZk6+onC8OrvgODPwMVL36wPyBDOvW0H8s0sEnahzwh?=
 =?iso-8859-1?Q?Gs1ikRosAcWAhkeL5njLqCKvV4ujunwTBSpa7DGP0q9DSWzL6vHLx8T1u0?=
 =?iso-8859-1?Q?4C5QyfO9qyrTdnp2YO2TIi4TwR40F724DbVAl5BOzRnYPxZTzv2K3AzEbv?=
 =?iso-8859-1?Q?mATh+Q27BU7S1B1J5OlZ7IIRz0EA6uhxJKnMigcShiJKN4gkI+tRUP4cMn?=
 =?iso-8859-1?Q?djOkuaB11USBiW4VWP+nEWdwHSHWAncbg/KxiSItpy5Y/vOsFl6Ut2bjwP?=
 =?iso-8859-1?Q?3V8KN7xf6US3acYxhhNPTQ+PZl9xtoKTOCAflaNqxyOvN/2ebx3xrs/2Yi?=
 =?iso-8859-1?Q?KpoJLONJYKaDNvnM3+E/kU1q2OaT0aBnnp8MXoEFdECI5PobaKD4IuaZov?=
 =?iso-8859-1?Q?ZmHJE9S/fgcAIAFT4R2oIzHKO0Oph60f3n+U/U6fFT9DXTT6R/czdhzixO?=
 =?iso-8859-1?Q?vgiVCiRoXijvCEVbJqlUP7YFgzqkC09x6XQNoKjw/jCYc+NS/K5H/u46AO?=
 =?iso-8859-1?Q?xu9QZDvmUGy6rHoBGDrVkJSNgrHJEjghvN3fDHJ+0BvfmAbvMZBr91U9go?=
 =?iso-8859-1?Q?t5LdXjJEmBSm484zX3D1taya2CPHaYN+OpJZsMjvFGCeTBlZaIB9ucepRD?=
 =?iso-8859-1?Q?/xMGUUA9GfoEEzp5AJPCo8gW5Puqua9y4Pch55xtqEJdWo9fi9/wku/ixH?=
 =?iso-8859-1?Q?CNswVv8jF/qSbt/EXI8dwwK3xFsyRHOfFEt1AWgTtBs22nq5xYL8DfzaaE?=
 =?iso-8859-1?Q?qZgenxfap1Q4GW7gTNX+Qdn4XNubxAJwznp9JWRYN7GYDwrIyqV78zs1+n?=
 =?iso-8859-1?Q?+pqTXNi0XjR3anuIqDEHvwVZWjuH46zvkexxjChX0+ZLnIL1LF4UnvApyb?=
 =?iso-8859-1?Q?gkGCA1Aouh4WwU1qg9nO/wtX5QquYUgtoYwg7K3e+jaSplDUSO+XmqtNmF?=
 =?iso-8859-1?Q?xgKbAprAfKyYHfeQ/QW29TMjQZ1eXFfng58098P1BnK34sUgtwElrJqK4Z?=
 =?iso-8859-1?Q?DjnNnk1QX72bjcUbSckXC1aVsIDEdxO8JmNarxMnOehf9X1sNOQV7DlMAr?=
 =?iso-8859-1?Q?MLvhQNvHHbD3AHtc5FCZTINw+LtGWy/ijFhnBdlZ4zb2gD4eXlQfzn6psh?=
 =?iso-8859-1?Q?ccc5fcXfUWWe0c7X9K7+fda1jfjrAJTsg+XgJPzcsZZaNjYukXam7i2w8F?=
 =?iso-8859-1?Q?XYNxgjKLnFOljmKy0jcS2ADFa1Ebo+3UsI6s1A+Sfg5eDs+4y9sRl5S3/L?=
 =?iso-8859-1?Q?uZJMsJoMZ/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a90fab4-57a0-4274-178d-08d96bceaade
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 15:56:02.7615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIpCMWk56Kd2IFML/l6648k227lM+hbF1ttW8bcvaI8RVR+IDwHLi/7beskLME56AuOkZBiBCpwMvunUYXmm/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 27, 2021 at 10:47:42AM -0500, Brijesh Singh wrote:
> 
> On 8/27/21 10:18 AM, Borislav Petkov wrote:
> > On Fri, Aug 20, 2021 at 10:19:27AM -0500, Brijesh Singh wrote:
> >> From: Michael Roth <michael.roth@amd.com>
> >>
> >> This adds support for utilizing the SEV-SNP-validated CPUID table in
> > s/This adds support for utilizing/Utilize/
> >
> > Yap, it can really be that simple. :)
> >
> >> the various #VC handler routines used throughout boot/run-time. Mostly
> >> this is handled by re-using the CPUID lookup code introduced earlier
> >> for the boot/compressed kernel, but at various stages of boot some work
> >> needs to be done to ensure the CPUID table is set up and remains
> >> accessible throughout. The following init routines are introduced to
> >> handle this:
> > Do not talk about what your patch does - that should hopefully be
> > visible in the diff itself. Rather, talk about *why* you're doing what
> > you're doing.
> >
> >> sev_snp_cpuid_init():
> > This one is not really introduced - it is already there.
> >
> > <snip all the complex rest>
> >
> > So this patch is making my head spin. It seems we're dancing a lot of
> > dance just to have our CPUID page present at all times. Which begs the
> > question: do we need it during the whole lifetime of the guest?
> 
> Mike can correct me,  we need it for entire lifetime of the guest. 
> Whenever guest needs the CPUID value, the #VC handler will refer to this
> page.

That's right, and cpuid instructions can get introduced at pretty much
every stage of the boot process.

> 
> 
> > Regardless, I think this can be simplified by orders of
> > magnitude if we allocated statically 4K for that CPUID page in
> > arch/x86/boot/compressed/mem_encrypt.S, copied the supplied CPUID page
> > from the firmware to it and from now on, work with our own copy.
> 
> Actually a  VMM could populate more than one page for the CPUID. One
> page can include 64 entries and I believe Mike is already running into
> limits (with Qemu) and exploring the ideas to extend it more than a page.

I added the range checks in this version so that a hypervisor can still
leave out all-zero entries, so I think it can be avoided near-term at
least, but yes, still a possibility we might need an extra one in the
future, not sure how scarce storage is for stuff like __ro_after_init, so
worth considering.
