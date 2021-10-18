Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E67B4326BC
	for <lists+linux-efi@lfdr.de>; Mon, 18 Oct 2021 20:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhJRSmi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Oct 2021 14:42:38 -0400
Received: from mail-bn7nam10on2083.outbound.protection.outlook.com ([40.107.92.83]:61824
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229924AbhJRSmg (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 18 Oct 2021 14:42:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6wjmFllfRmx2oMERxdbAqwqq+F5djjr3pJdpiXEmJJX5KoYl6DLu+yyJGEIjgKcWzQLZa+/0eYYMf/ugGKZaxcbc2+Xo7EqMb0XO0UdULn8qM2+pOxRNQ40CgJH0B68dZrvPQ5SJObbbgZB7g4HtYZz/0NcgKSlaV/gKgj0jhUhpY/MRgNbA2Z0QXOtxB/iFWn5YHfWDMHTIOlN3Vg/X5O13trN/goAhAQDaJ7XfaESmWWYZst2Z7grhkVuLwBtfknB9fhG0PcJO1oRVuav8W2/vYOoSrWgrOEaaWn9zMhGOapGiO2Kb1NozZhS4EydIGU9AoUsasCwCZNjpQVnUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgaVr6PaotS4bcURExUPbk0EQPfpoFdxlptKO/tHqB4=;
 b=RLij/sGkRQ9tYqZ+fsogUluZCGYd5fuhWaKqfH5HN1Vtf+ynEMoXrMZKfTAjJJ+iJ5S6dQ5SOd4CURGxErV6BG1xOpF9ykYLOgykmtqGUZDhmmysBCCwS5M52lsvzNsH0HvuoCl50jQk6MIeauxOFbM0JbJcTzFoAeRgF//iwtMJEMpRDLls0wkW8hRcmPy/CWuJRa6+/zuZDo56xLs/wmwxeMUQe2HnNDEq015v3HXkBOvBsjXf4FMAKpv3Afvc+E+xisaIZfotQ1tcNZM6qxsQhdUAf13ff5c9sZhViLFNlen+rWNTqUVikJeIoyLH2Q4TMFsKwrgqNkpKR4x6yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgaVr6PaotS4bcURExUPbk0EQPfpoFdxlptKO/tHqB4=;
 b=r54EMrKtFimT4NMNUN4TsINbf8Qav5hOS/ogployBuUsmJZRajK3felw3Tveid3FIy0mJTiOtayfw+j7iK191qCxAIhXBiBPwmNLB2ly+TBB2BsgH9ngV5ASBmqPgJF7VZ7Vvy3rke46/q1E5p0MHq8i15qrPqe34WmxTXUwg2U=
Received: from BN8PR04CA0021.namprd04.prod.outlook.com (2603:10b6:408:70::34)
 by BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Mon, 18 Oct
 2021 18:40:21 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::92) by BN8PR04CA0021.outlook.office365.com
 (2603:10b6:408:70::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17 via Frontend
 Transport; Mon, 18 Oct 2021 18:40:21 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; alien8.de; dkim=none (message not
 signed) header.d=none;alien8.de; dmarc=temperror action=none
 header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 18:40:19 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 18 Oct
 2021 13:40:18 -0500
Date:   Mon, 18 Oct 2021 13:40:03 -0500
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
Subject: Re: [PATCH v6 08/42] x86/sev-es: initialize sev_status/features
 within #VC handler
Message-ID: <20211018184003.3ob2uxcpd2rpee3s@amd.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-9-brijesh.singh@amd.com>
 <YW2EsxcqBucuyoal@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YW2EsxcqBucuyoal@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9dd4b43-02f6-4369-9bd6-08d99266bc36
X-MS-TrafficTypeDiagnostic: BL1PR12MB5157:
X-Microsoft-Antispam-PRVS: <BL1PR12MB515791D8B89EB8C1E69D2A6695BC9@BL1PR12MB5157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OUJkON7hSvmDukSprEeEI11HL4IhoEbQLcw2w4JKeTz8AFswI95Bd7KRq/vR9mUwrwJ3XsJL+6NI4NUe/TIiP25UEEF7fbTjTXShySClXCRTpb7wAghkzrPp+qRcTkKf/D8XItbl9gjdnr7Jfk21LjjHCRB/H/er0uW4aoZvBvxe6VxrcenD/p1kvm0WySS+DbGbaJZJshiqCx0l5U7SHVesmLDZ8ZHYFzhS7yJet93Zf11X52J0ROJjMwZaU01aqBqkQ91FqHDVcz7jlrlC94oqqfRXm2U2wflXUWIwBqY6E+sCUNzeJes+fyk7OqfwmCfdBQRNvODVpCvD4TzBWyCpgD601+Ehj7ttnu/uvQoMREsuq50IgSs1AXG4nW8Hwh0YwdjEVtJYVb42iWKnwgcgWbdYogDN1T+jMZlySnfvKQfm62l0+/yregJmuWdytej4BZ46LNWbC3BxvZDKcXTogSfSmPvLUvCBTe5it2oUGYbClo5Jt5e1jou+NpOpjDrDPNibhrytjLC/pR5R61+WJcrVTtG4mGEMatgcZh0qvYHLj9Wvp9oMGPapavGBqycmU9WY8kYOx3iPIxUcrj3yV2eceOURWj1qrSJtVTFrpqfX50JdT4niO54kNeVI22uYHB+RSM8krpmuFB8qujrJ7NjV3jd7JkqWZztBitbq4+I2vyuZtd/yNRw3+NLP/UAKHs4pCGze9ozOS6jlZRkCCZOQPrpS3gSOpV4h8kPKqjXCzefJ27GaxHl1hcWarUerEq45yRLeXER0dWmp22XCfabgq74fXeBS5JtU31vx2uzC/ilFL8/fIgz/WLx7YKhz9p8y+sJmXUAXGzJ9QmLKZ9FCoQbq11GC5N9otts=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36756003)(8676002)(81166007)(47076005)(36860700001)(82310400003)(316002)(5660300002)(26005)(70586007)(186003)(54906003)(45080400002)(356005)(2616005)(508600001)(966005)(4326008)(6666004)(336012)(2906002)(8936002)(1076003)(86362001)(63350400001)(426003)(16526019)(83380400001)(6916009)(7416002)(7406005)(63370400001)(70206006)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 18:40:19.1211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9dd4b43-02f6-4369-9bd6-08d99266bc36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5157
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Oct 18, 2021 at 04:29:07PM +0200, Borislav Petkov wrote:
> On Fri, Oct 08, 2021 at 01:04:19PM -0500, Brijesh Singh wrote:
> > From: Michael Roth <michael.roth@amd.com>
> > 
> > Generally access to MSR_AMD64_SEV is only safe if the 0x8000001F CPUID
> > leaf indicates SEV support. With SEV-SNP, CPUID responses from the
> > hypervisor are not considered trustworthy, particularly for 0x8000001F.
> > SEV-SNP provides a firmware-validated CPUID table to use as an
> > alternative, but prior to checking MSR_AMD64_SEV there are no
> > guarantees that this is even an SEV-SNP guest.
> > 
> > Rather than relying on these CPUID values early on, allow SEV-ES and
> > SEV-SNP guests to instead use a cpuid instruction to trigger a #VC and
> > have it cache MSR_AMD64_SEV in sev_status, since it is known to be safe
> > to access MSR_AMD64_SEV if a #VC has triggered.
> > 
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> > ---
> >  arch/x86/kernel/sev-shared.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> > index 8ee27d07c1cd..2796c524d174 100644
> > --- a/arch/x86/kernel/sev-shared.c
> > +++ b/arch/x86/kernel/sev-shared.c
> > @@ -191,6 +191,20 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
> >  	if (exit_code != SVM_EXIT_CPUID)
> >  		goto fail;
> >  
> > +	/*
> > +	 * A #VC implies that either SEV-ES or SEV-SNP are enabled, so the SEV
> > +	 * MSR is also available. Go ahead and initialize sev_status here to
> > +	 * allow SEV features to be checked without relying solely on the SEV
> > +	 * cpuid bit to indicate whether it is safe to do so.
> > +	 */
> > +	if (!sev_status) {
> > +		unsigned long lo, hi;
> > +
> > +		asm volatile("rdmsr" : "=a" (lo), "=d" (hi)
> > +				     : "c" (MSR_AMD64_SEV));
> > +		sev_status = (hi << 32) | lo;
> > +	}
> > +
> >  	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EAX));
> >  	VMGEXIT();
> >  	val = sev_es_rd_ghcb_msr();
> > -- 
> 
> Ok, you guys are killing me. ;-\
> 
> How is bolting some pretty much unrelated code into the early #VC
> handler not a hack? Do you not see it?

This was the result of my proposal in v5:

  > More specifically, the general protocol to determine SNP is enabled
  > seems
  > to be:
  > 
  >  1) check cpuid 0x8000001f to determine if SEV bit is enabled and SEV
  >     MSR is available
  >  2) check the SEV MSR to see if SEV-SNP bit is set
  > 
  > but the conundrum here is the CPUID page is only valid if SNP is
  > enabled, otherwise it can be garbage. So the code to set up the page
  > skips those checks initially, and relies on the expectation that UEFI,
  > or whatever the initial guest blob was, will only provide a CC_BLOB if
  > it already determined SNP is enabled.
  > 
  > It's still possible something goes awry and the kernel gets handed a
  > bogus CC_BLOB even though SNP isn't actually enabled. In this case the
  > cpuid values could be bogus as well, but the guest will fail
  > attestation then and no secrets should be exposed.
  > 
  > There is one thing that could tighten up the check a bit though. Some
  > bits of SEV-ES code will use the generation of a #VC as an indicator
  > of SEV-ES support, which implies SEV MSR is available without relying
  > on hypervisor-provided CPUID bits. I could add a one-time check in
  > the cpuid #VC to check SEV MSR for SNP bit, but it would likely
  > involve another static __ro_after_init variable store state. If that
  > seems worthwhile I can look into that more as well.
  
  Yes, the skipping of checks above sounds weird: why don't you simply
  keep the checks order: SEV, -ES, -SNP and then parse CPUID. It'll fail
  at attestation eventually, but you'll have the usual flow like with the
  rest of the SEV- feature picking apart.

https://lore.kernel.org/lkml/YS3+saDefHwkYwny@zn.tnic/

I'd thought you didn't like the previous approach of having snp_cpuid_init()
defer the CPUID/MSR checks until sme_enable() sets up sev_status later on,
then failing the boot retroactively if SNP bit isn't set but CPUID table
was advertised. So I added those checks in snp_cpuid_init(), along with the
additional #VC-based indicator of SEV-ES/SEV-SNP support as an additional
sanity check of what EFI firmware was providing, since I thought that was
the key concern here.

Now I'm realizing that perhaps your suggestion was to actually defer the
entire CPUID page setup until after sme_enable(). Is that correct?

> 
> So sme_enable() is reading MSR_AMD64_SEV and setting up everything
> there, including sev_status. If a SNP guest does not trust CPUID, why
> can't you attempt to read that MSR there, even if CPUID has lied to the
> guest?

If CPUID has lied, that would result in a #GP, rather than a controlled
termination in the various checkers/callers. The latter is easier to
debug.

Additionally, #VC is arguably a better indicator of SEV MSR availability
for SEV-ES/SEV-SNP guests, since it is only generated by ES/SNP hardware
and doesn't rely directly on hypervisor/EFI-provided CPUID values. It
doesn't work for SEV guests, but I don't think it's a bad idea to allow
SEV-ES/SEV-SNP guests to initialize sev_status in #VC handler to make
use of the added assurance.

Is it just the way it's currently implemented as something
cpuid-table-specific that's at issue, or are you opposed to doing so in
general?

Thanks,

Mike

> 
> And not just slap it somewhere just because it works?
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C462c7481ae414f7706a808d99243a615%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637701641625364120%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=6MViA5KCFEgSA2fijEx3Dg05btIEAjw55bFYRKL0P6o%3D&amp;reserved=0
