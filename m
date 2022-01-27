Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A7649E8DC
	for <lists+linux-efi@lfdr.de>; Thu, 27 Jan 2022 18:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbiA0RX5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Jan 2022 12:23:57 -0500
Received: from mail-mw2nam08on2089.outbound.protection.outlook.com ([40.107.101.89]:42336
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230193AbiA0RX4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 27 Jan 2022 12:23:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mh0Dvrya+ak7wnuStDXQ8bvmXwTPOevkg2dg1RWDFy9YabC1WuZ8kS+nz5KFguQHF4QcL+6xllDp8xEA/b9WbDe9BXKbRsT+R/h1aM2p1yLC6mi6psimd556J8g29Q2XJxBN3rC+EgUTB/AYtLeJ1WSxGzfdYXiuserHxk2aIrPDlN3lw1wqEC9/SIjjXBwjJnxiQp9oM7ept3JufeKrDeoIYaNdWrdktylHUcFPrTQDEHr3EY0dvcBJKJ51d0bE7ICr0TcPpZ6ypi+p8eUUXFX5dKzmCKjXP//eXs8Qyh9dD5FLBFaUICxVe0vvLyAzFrLsCwFgsFR2Z70K9AuiZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TE1VBFnA90hYRW1pYSUROKkXBeREUPNpDB1wYyPhPJE=;
 b=jEJrbklYTYU6u+UIlB6uSdIMVcl05rW0qdfs3hpysydrhLNOhwtLS+UnYxGO0K84lIVfTn6nhLBuviILwDTgtT9bSukvqIWEuX65UWYmU6MxSCX/tx1264ztjB/z93cO0XTo/zsSaN/8gKHUhIFHy895LTAWH+AlKOUYE7Uznsmyl1R1z5hzYlIWw0u+ORUU8kIPslT+CjdT2+/WUmLkQu2G/izZ56kb1yIgBqtQLBEOE0wH6HVmOtOOy2EkIZbkl3Eo5Ihu8Uqt5lfArlxpHnlN/PcmumPBhgY39IMjib8vlASCgEatlQMyqEXiBXx0lclphDz+U4mlX/Cra4JifQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TE1VBFnA90hYRW1pYSUROKkXBeREUPNpDB1wYyPhPJE=;
 b=P55ITN/rNRdleLBP4+HU3AVWWq2tVNKm3etpcZEf/Dk0sn7OalBMF6U13RwFNqtihs0FIK4/TkJrpGHrMEbzx/YXmgZ3SyY7YplaDz/fFdgHguErAn2CrWcrthcjK7sD4EH0xjevEqGhVVpGyf0xvpn1moBByE1qwy1ch9adlcw=
Received: from MW4PR03CA0279.namprd03.prod.outlook.com (2603:10b6:303:b5::14)
 by CO6PR12MB5410.namprd12.prod.outlook.com (2603:10b6:5:35b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 17:23:54 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::ac) by MW4PR03CA0279.outlook.office365.com
 (2603:10b6:303:b5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 17:23:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 17:23:53 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 11:23:52 -0600
Date:   Thu, 27 Jan 2022 11:23:08 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Brijesh Singh <brijesh.singh@amd.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <tony.luck@intel.com>, <marcorr@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v8 29/40] x86/compressed/64: add support for SEV-SNP
 CPUID table in #VC handlers
Message-ID: <20220127172308.erfrpuwm6ivbdh5q@amd.com>
References: <20220118142345.65wuub2p3alavhpb@amd.com>
 <20220118143238.lu22npcktxuvadwk@amd.com>
 <20220118143730.wenhm2bbityq7wwy@amd.com>
 <YebsKcpnYzvjaEjs@zn.tnic>
 <20220118172043.djhy3dwg4fhhfqfs@amd.com>
 <Yeb7vOaqDtH6Fpsb@zn.tnic>
 <20220118184930.nnwbgrfr723qabnq@amd.com>
 <20220119011806.av5rtxfv4et2sfkl@amd.com>
 <YefzQuqrV8kdLr9z@zn.tnic>
 <20220119162747.ewgxirwcnrcajazm@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220119162747.ewgxirwcnrcajazm@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 975bec9a-9af1-445c-0d81-08d9e1b9ca9c
X-MS-TrafficTypeDiagnostic: CO6PR12MB5410:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB54102B7DB1569C521A28054795219@CO6PR12MB5410.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HZ0gjAw7w+vY7xxdns0CA8REuTzgDddVOIIWdRXgcIdl2PT97t8nSArgi3tedycMamY51MH6VEcJsU6l8rQYHaq/Twn0DTVtYAcqrQgRaZvferpSSaUS1j5AEmMSNw1zdoVJZgvilW8CuKA+kg3Yj0u5xwqtZYJEf+K8F+Me5DuBY4WPagLEHpAa1gYyTPNc4rdBysfhDr2AgEUbGu6Qyfva6OKqEoGCxkoBwvmDRoAa8jkmpBjqs53H+NceLvejo6G0pIZCwRL64NpjU+7G9av+L4MeNoIFSJj5DUTPJplOlYttv+nKwHHW2TxObyN63jmPRUbPVXj/Coe2CS8lwU8HRiqbRUJTZfBpHO40RPevqIVG0XYu8swGZrGefez4Cjc6DksLlbhvG9s+A3LiNB3QRFFDhwpkbQ8PPDEZ3mI5NTt1p87CZQUjzqwlZf4EqNapXZ3N/nPbRFb1v03SOCRXGda/veKhNM+IC2lEBpAhMB9NwYKL3sNNTxHLSn6fROFeBzyImsl8sdi2F39bAPGo3p9KVjF98SPsAe+zv3OJdNySYWJ5vHxU72RXMngL9E+VqKDJ24PFfnLNMapvPHxBcATrZTYLYgqIbRUZ7M21FIw3ewl6/EUsWJ8Ga4xgzaT4ouFkvR6HUXaeJdvZgR7ore6nbCCoDAlbP+q+YD5AtVIs88ogYN24FatqE2Set9L+oMsP3mnBkBUJyUfXrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(16526019)(7416002)(36860700001)(6666004)(40460700003)(186003)(1076003)(26005)(7406005)(86362001)(82310400004)(83380400001)(5660300002)(47076005)(2616005)(426003)(508600001)(336012)(8936002)(8676002)(4326008)(44832011)(70206006)(70586007)(81166007)(316002)(356005)(36756003)(54906003)(6916009)(2906002)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 17:23:53.2185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 975bec9a-9af1-445c-0d81-08d9e1b9ca9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5410
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 19, 2022 at 10:27:47AM -0600, Michael Roth wrote:
> On Wed, Jan 19, 2022 at 12:17:22PM +0100, Borislav Petkov wrote:
> > On Tue, Jan 18, 2022 at 07:18:06PM -0600, Michael Roth wrote:
> > > If 'fake_count'/'reported_count' is greater than the actual number of
> > > entries in the table, 'actual_count', then all table entries up to
> > > 'fake_count' will also need to pass validation. Generally the table
> > > will be zero'd out initially, so those additional/bogus entries will
> > > be interpreted as a CPUID leaves where all fields are 0. Unfortunately,
> > > that's still considered a valid leaf, even if it's a duplicate of the
> > > *actual* 0x0 leaf present earlier in the table. The current code will
> > > handle this fine, since it scans the table in order, and uses the
> > > valid 0x0 leaf earlier in the table.
> > 
> > I guess it would be prudent to have some warnings when enumerating those
> > leafs and when the count index "goes off into the weeds", so to speak,
> > and starts reading 0-CPUID entries. I.e., "dear guest owner, your HV is
> > giving you a big lie: a weird/bogus CPUID leaf count..."
> > 
> > :-)
> 

Sorry for the delay, this response got stuck in my mail queue apparently.

> Ok, there's some sanity checks that happen a little later in boot via
> snp_cpuid_check_status(), after printk is enabled, that reports some
> basic details to dmesg like the number of entries in the table. I can
> add some additional sanity checks to flag the above case (really,
> all-zero entries never make sense, since CPUID 0x0 is supposed to report
> the max standard-range CPUID leaf, and leaf 0x1 at least should always
> be present). I'll print a warning for such cases, add maybe dump the
> cpuid the table in that case so it can be examined more easily by
> owner.
> 
> > 
> > And lemme make sure I understand it: the ->count itself is not
> > measured/encrypted because you want to be flexible here and supply
> > different blobs with different CPUID leafs?
> 
> Yes, but to be clear it's the entire CPUID page, including the count,
> that's not measured (though it is encrypted after passing PSP
> validation). Probably the biggest reason is the logistics of having
> untrusted cloud vendors provide a copy of the CPUID values they plan
> to pass to the guest, since a new measurement would need to be
> calculated for every new configuration (using different guest
> cpuflags, SMP count, etc.), since those table values will need to be
> made easily-accessible to guest owner for all these measurement
> calculations, and they can't be trusted so each table would need to
> be checked either manually or by some tooling that could be difficult
> to implement unless it was something simple like "give me the expected
> CPUID values and I'll check if the provided CPUID table agrees with
> that".
> 
> At that point it's much easier for the guest owner to just check the
> CPUID values directly against known good values for a particular
> configuration as part of their attestation process and leave the
> untrusted cloud vendor out of it completely. So not measuring the
> CPUID page as part of SNP attestation allows for that flexibility.
> 
> > 
> > > This is isn't really a special case though, it falls under the general
> > > category of a hypervisor inserting garbage entries that happen to pass
> > > validation, but don't reflect values that a guest would normally see.
> > > This will be detectable as part of guest owner attestation, since the
> > > guest code is careful to guarantee that the values seen after boot,
> > > once the attestation stage is reached, will be identical to the values
> > > seen during boot, so if this sort of manipulation of CPUID values
> > > occurred, the guest owner will notice this during attestation, and can
> > > abort the boot at that point. The Documentation patch addresses this
> > > in more detail.
> > 
> > Yap, it is important this is properly explained there so that people can
> > pay attention to during attestation.
> > 
> > > If 'fake_count' is less than 'actual_count', then the PSP skips
> > > validation for anything >= 'fake_count', and leaves them in the table.
> > > That should also be fine though, since guest code should never exceed
> > > 'fake_count'/'reported_count', as that's a blatant violation of the
> > > spec, and it doesn't make any sense for a guest to do this. This will
> > > effectively 'hide' entries, but those resulting missing CPUID leaves
> > > will be noticeable to the guest owner once attestation phase is
> > > reached.
> > 
> > Noticeable because the guest owner did supply a CPUID table with X
> > entries but the HV is reporting Y?
> 
> Or even more simply by the guest owner simply running 'cpuid -r -1' on
> the guest after boot, and making sure all the expected entries are
> present. If the HV manipulated the count to be lower, there would be
> missing entries, if they manipulated it to be higher, then there would
> either be extra duplicate entries at the end of the table (which the
> #VC handler would ignore due to it using the first matching entry in
> the table when doing lookups), or additional non-duplicate garbage
> entries, which will show up in 'cpuid -r -1' as unexpected entries.
> 
> Really 'cpuid -r -1' is the guest owner/userspace view of things, so
> some of these nuances about the table contents might be noteworthy,
> but wouldn't actually affect guest behavior, which would be the main
> thing attestation process should be concerned with.
> 
> > 
> > If so, you can make this part of the attestation process: guest owners
> > should always check the CPUID entries count to be of a certain value.
> > 
> > > This does all highlight the need for some very thorough guidelines
> > > on how a guest owner should implement their attestation checks for
> > > cpuid, however. I think a section in the reference implementation
> > > notes/document that covers this would be a good starting point. I'll
> > > also check with the PSP team on tightening up some of these CPUID
> > > page checks to rule out some of these possibilities in the future.
> > 
> > Now you're starting to grow the right amount of paranoia - I'm glad I
> > was able to sensitize you properly!
> > 
> > :-)))
> 
> Hehe =*D
> 
> Thanks!
> 
> -Mike
