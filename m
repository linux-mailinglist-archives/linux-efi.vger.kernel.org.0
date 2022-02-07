Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3998C4AC701
	for <lists+linux-efi@lfdr.de>; Mon,  7 Feb 2022 18:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiBGRPd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Feb 2022 12:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383626AbiBGRBD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Feb 2022 12:01:03 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9AEC0401D3;
        Mon,  7 Feb 2022 09:01:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ajdjg1DooZj7P9dlkfwUtydCqB64WxkM8NsLRpwiF4OCCDq/Fz4qBGdHCUlObs2rMlEFKjV70vGMS+6Dibm2WWv4UItcxbeTPLRsPfspg0LEZBGKMmLvvoh4ofnwIiVkInoh85GGdimnGLdw/N7y+Aj4dYGFWYgJc1EcG0+CC0u8m4YhhE9PfJ+Q0MaCX/J9WymaQLuVsgW6HbIkFzdCYPP4gwxCr0nuUDK8wYs95rXZPg5BF1IR8qPuP2VpsB49nT3AJbvAnzNxmv267bt2jAeVjkxCnofMm6DUmUH1oHd1Diwp5+Ox66Ot35glg3f77zI9f8/H/9VOuHn+VUsCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wf5OG8grb/ydZodepXa/bVLJp/Ct/qkUax6e6N+FcsM=;
 b=B3Iq6oGIWltafnInmapKA/n4HAbfPRdI+BElN/seMMf9zCdGslfJm5jK9YBOaNu9OXBifPc4f0R3/cfz2khGHWnTR8GjYJ48pwkqh7PFbOovWsoidAYPiPyebFRrNKRKIqA3H0BPRPX8pZUpFxwd8yBB5+oWaicdNaw2cRSUBA+gR3EoH/a3f0NrWAw56lzhjbPiziPIlwSHP6eOG38piHBhaWKrI6+PYBuuwxtuyarVz24kg40eTeOBovpxSXfa+3YeLNGCNoKHiURg5Hp4RSE+8jZMEoJ4pYbzAVrG2rVMiLhnMwsahjji7cisL76JeMk1EvKASWVe86uve5cT8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wf5OG8grb/ydZodepXa/bVLJp/Ct/qkUax6e6N+FcsM=;
 b=pGDHOGdR9+k6Z+YKE71PTEwRzI4/oygd9RQpDyUCwKheM0NK8qdYCMJaXGouUjvGza1t84moK5u1U7VLGkHCKQnHokFgltZ3Kms3CQrb5hlCu5hvWmt/okbAITlTIk0j34xIgrun1GByUqr7nensEo8pPaioRhM3FzYmdiP2moY=
Received: from MW4PR04CA0036.namprd04.prod.outlook.com (2603:10b6:303:6a::11)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 17:01:00 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::1a) by MW4PR04CA0036.outlook.office365.com
 (2603:10b6:303:6a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Mon, 7 Feb 2022 17:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 17:00:58 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Feb
 2022 11:00:56 -0600
Date:   Mon, 7 Feb 2022 11:00:18 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-efi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
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
        <brijesh.singh@amd.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v9 38/43] x86/sev: Use firmware-validated CPUID for
 SEV-SNP guests
Message-ID: <20220207170018.sg37idc6nzlzgj6p@amd.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-39-brijesh.singh@amd.com>
 <20220205171901.kt47bahdmh64b45x@amd.com>
 <Yf/tQPqbP97lrVpg@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yf/tQPqbP97lrVpg@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 268ee093-a3d7-4d00-16eb-08d9ea5b69b5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4157:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB41571BA913381BE5BF8EB3D8952C9@MN2PR12MB4157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tZyRfQ6rPdpg1swbtme3sgr06Bd1/+XZ/ADE5QOqMWVHaOm5urap1gHK+gtw/uU6w0j6JStLG1DMo9iw6P+hz928ZTrASgUI61U6LBsBPAyCaojMqDr1/iEdbVXO+YQcybtfr65TohNy4R9I5ci17PcOqvlKkcK35iIizpkyynWvieg4DWe7nws7xpcvFgH2zPNaq+/iNf/QxYziImWp30SjW+KZTCZkQu1FdkvbhWn+u2GMwIcbTR+pJOY0r1PVl6pcF6deYTi7LuA693+vkZesQek8FWD6i482gb/bOWxsmHXsEvdx0EM4rhmVcumZ3D6h0Mk1CLJdj7sj7qjEsoSCGNKK79JR4SP5rEVM9zsvGr1+RelV1ZoJqXFm+WVvKfyggZV3o0kw1NMk3idkhtPWvJGGtROwwzHLVYPgE20h8rCIw+BoWjCAcukYWinbwOQgjil/riKn1HYtVbW1U3iKm1kdFqfJfmv1nqmw3NDoO+zkHbVeBcvJ8xA0J3UxC0XyHkTtApUd4JBGItFQ8kWlbBvbjPTuKyPuH24kbtcj1b/yjWI+YvvbKb+dVrlHtW/LUASxVFj8iHFZAMLpnosi0m0wh9qMOYD4D9bXSZnBksR13uyVyeS7y0X/sAJt39aoTEowaePufvVAmNOXtQsy+CTQr9iKGWhXiRxyDCqPD5ib/Vmo5A/1M07XKgSRH0CBa0A6m2uLN8GGzJrxraWa8eTtrqxr88GtdT2ubelTHT/NvxvradQ7oR7KdwVqcdHrO5YzWOZ1zY0eCI+1NqFvXa/PD710tI5SuzUWf0J+hoWk5HjSeJwuibuBBXyaZnGGsyaKGQkgMdyVKhpOmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(2616005)(45080400002)(2906002)(16526019)(86362001)(1076003)(26005)(40460700003)(47076005)(82310400004)(186003)(316002)(15650500001)(54906003)(6916009)(7406005)(508600001)(70206006)(81166007)(4326008)(8676002)(5660300002)(6666004)(70586007)(8936002)(44832011)(336012)(426003)(7416002)(966005)(36756003)(83380400001)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 17:00:58.4316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 268ee093-a3d7-4d00-16eb-08d9ea5b69b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Feb 06, 2022 at 04:46:08PM +0100, Borislav Petkov wrote:
> On Sat, Feb 05, 2022 at 11:19:01AM -0600, Michael Roth wrote:
> > I mentioned the concern you raised about out-of-spec hypervisors
> > using non-zero for Reserved fields, and potentially breaking future
> > guests that attempt to make use of them if they ever get re-purposed
> > for some other functionality, but their take on that is that such a
> > hypervisor is clearly out-of-spec, and would not be supported.
> 
> Yah, like stating that something should not be done in the spec is
> going to stop people from doing it anyway. You folks need to understand
> one thing: the smaller the attack surface, the better. And you need to
> *enforce* that - not state it in a spec. No one cares about the spec
> when it comes to poking holes in the architecture. And people do poke
> and will poke holes *especially* in this architecture, as its main goal
> is security.

Agreed, but SNP never relies on the hypervisor to be the single authority
on what security features are available, if these fields were ever
re-purposed for anything in the future that would almost assuredly be
accompanied by a new SEV status MSR bit (that can't be intercepted),
a new policy bit (which affects measurement), a new "type2" CPUID page
that would effect measurement (contents don't affect measurement in
current firmware, but the metadata, like what type of page it is, is),
etc.

At that point any guest code changes to make use of those new fields
could then fail any out-of-spec hypervisors trying to use those fields
without the requisite firmware/hardware support. So please don't take
my summary as an indication that the security relies on hypervisors
abiding by the spec, this is more a statement that an out-of-spec
hypervisor should not expect that their guests will continue working
in future firmware versions, and what's being determined here is
whether to break those out-of-spec hypervisor now, or later when/if
we actually make use of the fields in the guest code, and whether we
need to make clarifications in the spec to help implementations avoid
such breakage.

> 
> > Another possibility is enforcing 0 in the firmware itself.
> 
> Yes, this is the thing to do. If they're going to be reused in the
> future, then guests can be changed to handle that. Like we do all the
> time anyway.

Ok, I'll follow up with the firmware team on this. But just to be clear,
what they're suggesting is that the firmware could enforce the MBZ checks
on the CPUID page, so out-of-spec hypervisors will fail immediately,
rather than in some future version of the spec/cpuid page, and guests
can continue ignoring them in the meantime.

I'll also note the type you spotted with the Table 13 reference and
see if there's anything else that can be cleared up there.

> 
> > So given their guidance on the Reserved fields, and your guidance
> > on not doing the other sanity-checks, my current plan to to drop
> > snp_check_cpuid_table() completely for v10, but if you have other
> > thoughts on that just let me know.
> 
> Yes, and pls fix the firmware to zero them out, because from reading
> your very detailed explanation - btw, thanks for taking the time to
> explain properly what's not in the ABI doc:
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fr%2F20220205154243.s33gwghqwbb4efyl%40amd.com&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C377208b805be40f55c0f08d9e987d19e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637797591858315372%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=L9McNfcn514uHmHLCtFPI2TqLKoCK0%2FKDMPk32lO8r8%3D&amp;reserved=0
> 
> it sounds like those two input fields are not really needed. So the
> earlier you fix them in the firmware and deprecate them, the better.

XCR0_IN/XSS_IN aren't needed by a guest if it follows the recommended
implementation and computes them on the fly, but they do still serve
a purpose in the context of firmware validation of 0xD,0x0/0xD,0x1
leaves, since those are validated relative to a particular
XCR0_IN/XSS_IN.

Whether a guest chooses to use the resulting firmware-validated version
of EBX for those, or compute it on it's own, is considered outside the
scope of the SNP firmware ABI, so I think the plan is to leave those
fields in the spec at least for current SNP version, and rely on the
implementation recommendations to document anything outside of that.

But since the recommendations need to be compatibile with the SNP
firmware ABI, I've updated the recommendations to have the guest to go
ahead and check for XCR0_IN={1,3}/XSS_IN=0 when searching for base
0xD,0x0/0xD,0x1 entries, so that there's no question of whether a guest
is supposed to expect XCR0_IN/XSS_IN to be 0.

Getting that document ready to send if a few.

Hope that helps clear things up, but please let me know if there's
anything else that needs clarification.

Thanks!

-Mike

> 
> Thx!
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C377208b805be40f55c0f08d9e987d19e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637797591858315372%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=0uNI0Ojku3ZIgiQRbNf0UxNXruycXsOYIUNIY9I2IiY%3D&amp;reserved=0
