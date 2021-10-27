Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B16943CD40
	for <lists+linux-efi@lfdr.de>; Wed, 27 Oct 2021 17:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242688AbhJ0PQs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Oct 2021 11:16:48 -0400
Received: from mail-dm6nam10on2071.outbound.protection.outlook.com ([40.107.93.71]:38772
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242681AbhJ0PQr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 27 Oct 2021 11:16:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBeHbpXsMEm0ZgaYkUyXjFAYbGRNGV40JcdzP/J6HIflEDlOBXYTvIofn9UgdPjKEBGrCdGk8OE3EDwBfhGF6nqihC63CsJQD4VYaNfKd3bprgCHlWwHoW+ivRIy8N0Kj3kQnaKOa66vD/6Zj7qmBCqAdpo//ZgHOMAm3bswKsMfwD7slyIZk50FE0JF7TQAg2F1CgsB0phMlWuK43N6f6W+dayA3O5thG8zbUd42gkSvVCjsxW8zm9xrnGxhVcNZepICQ9NFDRW6RPy0WntKGNj3DjgM2eCzGZ3Zu2CtbjH4VN6dHrpgz+uerB/tl6ZlrdzrsVSm7u+3WNTA6Xksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPod+ObHf4kgKPISc2cRbmeSv313djtHuT9BF8uRLQQ=;
 b=ILastPJMq/ttmRZ6OeGDJY0IBiwGYMXKJ0arlnEwNtMhWX3BClhNdSOnxIxcFzsI3sxLLkUd4yTHfnxw9jYdRcS+9/5BzzWnvjbTdUk3vS3f9edEyQAYvRzpUQVOaMgNngwQsQ9rAgWMND/A6RqaDtvcV+8JXWAtdjmgw7Uz06fWAekehdhAfvMyNd9IJZovLxmLSuE7LZvP6gNkZ/Qi8DLuX6g/CJm5ndQaCo2H6D4baRxdGd+w2Sg7lvse4+zL2hM9eSlAt0oxVYFrdail/m9btbJxsXuLCXT3r9848QZqaC7xgJ3wM0UTLLOszqyINbB42LnaRVTk/vapd1IXjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPod+ObHf4kgKPISc2cRbmeSv313djtHuT9BF8uRLQQ=;
 b=Xct1ifkX2noaqHa3vgHSJhZGn1Z2Um08u58aK5WKGimBRHuWWb5ddLIW7sM5S3qWvRP8USUO8nDQtB7TuBC5Dz/mzQ9MW0fKi2hNiOC1xsGeL8sF+MplwQ8S770wWBouxmJ5vtNx1BQRapDND/86fRu1u4mNDN9VR9ZfqQSInrk=
Received: from CO1PR15CA0067.namprd15.prod.outlook.com (2603:10b6:101:20::11)
 by SN6PR12MB2717.namprd12.prod.outlook.com (2603:10b6:805:68::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 15:14:18 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:20:cafe::b0) by CO1PR15CA0067.outlook.office365.com
 (2603:10b6:101:20::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Wed, 27 Oct 2021 15:14:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 15:14:16 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 27 Oct
 2021 10:14:15 -0500
Date:   Wed, 27 Oct 2021 10:13:25 -0500
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
Message-ID: <20211027151325.v3w3nghq5z2o5dto@amd.com>
References: <20211008180453.462291-9-brijesh.singh@amd.com>
 <YW2EsxcqBucuyoal@zn.tnic>
 <20211018184003.3ob2uxcpd2rpee3s@amd.com>
 <YW3IdfMs61191qnU@zn.tnic>
 <20211020161023.hzbj53ehmzjrt4xd@amd.com>
 <YXF+WjMHW/dd0Wb6@zn.tnic>
 <20211021204149.pof2exhwkzy2zqrg@amd.com>
 <YXaPKsicNYFZe84I@zn.tnic>
 <20211025163518.rztqnngwggnbfxvs@amd.com>
 <YXk1N6ApJA8PgkwM@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YXk1N6ApJA8PgkwM@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21678983-18d1-43f4-bcd9-08d9995c7102
X-MS-TrafficTypeDiagnostic: SN6PR12MB2717:
X-Microsoft-Antispam-PRVS: <SN6PR12MB271797E5EDB35909FC705D4195859@SN6PR12MB2717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 335AejeA9HH0DRMzDDGwerbr/qGVU7oe6fLBXvuyTlBPwu+Bvu5Bl0zt6tve0gioFtIfk+rei5zWfeG0itST0AcZFi9VlP0ssb/mMkTXpGLz0hZXEgrTlRS0dBuA7ATYHx0N4QJozESJpXamz+5tRu4u63m+HmkMn/LSkJ5kZpEByrUqRKP27lddmPT22oEe85MAbblpHRTKudfSLPIqQqRLEa1gXGbyeJqrUAPFo63R8Mw6DO4wUQGK6H+IyQccCbnUn/75NIkuXOWUmdND6xObU5tjqeu4Gl4S3OGqMwjB2hp78IRkkBftKEfvTbQD8PKJWBtHL6DcUY1d9rTKXZtv7h33sAw54MWFEKSeFS8DOyr2YX0y+6tS7buSy+MbhPIssHCNKugvcJIhjRHJuXiWgLp64viVR7iRsXpEIB/eJtI/okXdPcR4nAyhK8TCgFc0Jq9Tu6PGjUALNVGvV7qqTzZrwp9boMW/y/VZwkOm2lyzmwOXyt+D2mU7gFUeKlnliZXsUyIpzHw4Oya4vmdXbNOD1u6iqJkAvM2K50YPsIvL2Ji0D9kdd6UuyOuW/XzH7OXiw6uLRhCrTuoA31tBtYzKp0uK1ZNtturb93qwEfrR0gYhAgN8gyoMsIXMjRNKz/xtLc4FSzdYEQ57g2ezeZDnFla1AjpqyM5XFgwSvmangswGQ0Y9W38PhqFE1p1VgjHcLdoRjh4k5obyT2KbkT8gRL+ZPyaPvdGd8g0v5Gzdezqr8eEzbuwHmdLCVqgcvXKInFsvBaMo2FOvR4ZR4A2vWgiPfDfoag3CKXitR44zGLpje3JJffKfQBe+
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2906002)(5660300002)(316002)(7416002)(83380400001)(4326008)(36860700001)(8676002)(70586007)(356005)(54906003)(1076003)(966005)(81166007)(8936002)(82310400003)(6916009)(47076005)(70206006)(7406005)(426003)(2616005)(45080400002)(508600001)(26005)(86362001)(336012)(36756003)(16526019)(6666004)(186003)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 15:14:16.0062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21678983-18d1-43f4-bcd9-08d9995c7102
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2717
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 27, 2021 at 01:17:11PM +0200, Borislav Petkov wrote:
> On Mon, Oct 25, 2021 at 11:35:18AM -0500, Michael Roth wrote:
> > As counter-intuitive as it sounds, it actually doesn't buy us if the CPUID
> > table is part of the PSP attestation report, since:
> 
> Thanks for taking the time to explain in detail - I think I know now
> what's going on, and David explained some additional stuff to me
> yesterday.
> 
> So, to cut to the chase:
> 
>  - yeah, ok, I guess guest owner attestation is what should happen.
> 
>  - as to the boot detection, I think you should do in sme_enable(), in
> pseudo:
> 
> 	bool snp_guest_detected;
> 
>         if (CPUID page address) {
>                 read SEV_STATUS;
> 
>                 snp_guest_detected = SEV_STATUS & MSR_AMD64_SEV_SNP_ENABLED;
>         }
> 
>         /* old SME/SEV detection path */
>         read 0x8000_001F_EAX and look at bits SME and SEV, yadda yadda.
> 
>         if (snp_guest_detected && (!SME || !SEV))
>                 /*
> 		 * HV is lying to me, do something there, dunno what. I guess we can
> 		 * continue booting unencrypted so that the guest owner knows that
> 		 * detection has failed and maybe the HV didn't want us to force SNP.
> 		 * This way, attestation will fail and the user will know why.
> 		 * Or something like that.
> 		 */
> 
> 
>         /* normal feature detection continues. */
> 
> How does that sound?

That seems promising. I've been testing a similar approach in conjunction with
moving sme_enable() to after the initial #VC handler is set up and things seem
to work out pretty nicely.

boot/compressed is a little less straightforward since the sme_enable()
equivalent is set_sev_encryption_mask() which sets sev_status and is written
in assembly, whereas the SNP-specific bits we're adding relies on C code
that handles stuff like scanning EFI config table are in C, so probably
worthwhile to see if everything can be redone in C. But then there's
get_sev_encryption_bit(), which needs to be in assembly since it needs
to be called from 32-bit entry path as well, but that doesn't actually
rely on anything set by set_sev_encryption_mask(), so it seems like it
should be okay to split set_sev_encryption_mask() out into a separate C
routine.

Will work on implementing/testing that approach, but if you or Joerg are
aware of any showstoppers there just let me know.

Thanks!

-Mike

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C72940826a93b49882ffa08d9993b5390%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637709302358641670%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2BoUx7zP3RA57CwGG2q5IkUkrYQZiOL9ZoLxvIVTq%2BDY%3D&amp;reserved=0
