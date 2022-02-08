Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430E34ADA61
	for <lists+linux-efi@lfdr.de>; Tue,  8 Feb 2022 14:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242978AbiBHNub (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Feb 2022 08:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235672AbiBHNua (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Feb 2022 08:50:30 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812AEC03FECE;
        Tue,  8 Feb 2022 05:50:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3s7Pf3n/2O2XXkpnQaKGo4Src5i3PDbNdhqdkvp7bUJrLQ2JPUlIfaMJsJJgNAWYlUSFp/z3IsP5gs18c4H+iceUfHySYXc5MY2GeIgP6hV+qH61Ry8+f7/foKEjGhsgb+8fTqhgFHNcU7w8cramRTdF3WKf/YyK3CFni8Tw7gvtPW4U89CYgYQMNO5wkhTAiPa8uKG6R9E5+QkuuwWPERv7qrxy3VdMPR3WrRm7zuKKNhuTVZLhqw3fY7ENMBGdfnqxv/xb3d3iHrOF/hLjtsJCoglLSAr6Zt87NhUfZ0cs/aWlws4QZy9EqlsriC0iRydd206yekMr4R2EGJh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4WL+IMG05UQ1GmyxCEXUju2/ZsLw53Y/UIjKGUyM40=;
 b=GRhQQkfFxh6Jw7UUOHRCycv92+lBbC+yk4uz20ZHAdXDsMwtVjy2ysVzffTiYoFPohX1vNQnYoHCQdFLXDtJu6M9anuk26fiTtiA0zl+wzs/oCA9o4vY3vVHeIznNPACPq5g+YdwpQ5ia2nI+q3q8EfMeenOXPJMIBSi3+CzxaGW/wE8JBAg6mLhPnLqO3LulXCIXYwrxZ5wMjT/FrdULOp79DIyD3ZCzylOgGj20cZlJ+bBH0wad8Bjy3OsE9XFm6fDTkVHRl+NY/Y+wMNBeMkzYlO1eHkWpAyeV1/TcpCfHea3z3VhYc6eW2gmF8XvfuPN+1lGiGuGmX9KBsbYVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4WL+IMG05UQ1GmyxCEXUju2/ZsLw53Y/UIjKGUyM40=;
 b=2vakhQwQXWK426KouNK5Z38Q9dQ7Wpd08hhopciCWLnPJRd7nxjcHPKa6V3bC6LVhlmTA2d6nrQYMGVrxHm81DUHOqESHWP+GYcGspnSlKD74pL0TYl5pMjI65aANG8pIu/xz+x98QZDOIEAJQ0XvFWmJ9NZySecg1RhLGDC9wY=
Received: from BN8PR15CA0012.namprd15.prod.outlook.com (2603:10b6:408:c0::25)
 by BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 8 Feb
 2022 13:50:27 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::9f) by BN8PR15CA0012.outlook.office365.com
 (2603:10b6:408:c0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Tue, 8 Feb 2022 13:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Tue, 8 Feb 2022 13:50:27 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Feb
 2022 07:50:25 -0600
Date:   Tue, 8 Feb 2022 07:50:09 -0600
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
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v9 33/43] x86/compressed: Add SEV-SNP feature
 detection/setup
Message-ID: <20220208135009.7rfrau33kxivx5h3@amd.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-34-brijesh.singh@amd.com>
 <Yf/6NhnS50UDv4xV@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yf/6NhnS50UDv4xV@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ae88d64-b041-4308-4ecd-08d9eb09f66d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5126D28B6A979FD37531C8B6952D9@BL1PR12MB5126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: roLKyeWT1xUXPqG9BQX4r5eIhp8XHDm5omwOyb+/odj4K0KZUIHfbXvgCjLEebEv5/Yhs4/enjBEwClxgFmiHHUkAiU0376pgnfqFstxtM7T3/Z8ET7X4tXGF1SSehv4tGT3saWS4qwZ+xtCDi9GWCnqjHmqb/NtC0b1WCYFkWLUJdL9AOfRO+Xcv8wI2ocu3rlF0BtDixh8kB+N49qSxgGKUadAy9oGJhUCuism5dKM1FFj5AilHjcOCVK9iuLLo+prfuJFnuGlpbV/j0Aioeha0bSHKnY2cBaM65Fi23Ev5VBuuN3+eMmoHpBnNGCB+9f68sFFIPraZBH6Q9qGFtfd7dJtIJFfuAwZgsW0lsXbYgTLbcjuLN4+h6gIdHON6L+b9ooeie5OGdWa5yoh8VINCEba9jYUJLOGrU6rJP7m/jAjMtrjFqJextVAW2siHYOz3YxxXGimpizqsfwEbEYI3baN0fbK6UDN2O3ybBgFI2PQyAqg+gUYzpnXxAuu6VA2quFaYo+uHD/Ckw0SR8AHhipLmaOjECiOKnvmn0J9eM2bzG8EcJw7vNrx7zFTRrgn2YEvF1qL1jRm8+5ookx+9lpaZMPwGkyso7jRP0gTCKoxEPHhkvSNrx0onOaha3mtwclquj+c2aA3C2gM3dnf98wEwwd+fAzAE8it/Gp1gV65PA3BmRq37shZhcDR/BbYp497M4X7HKCLqxqgZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400004)(508600001)(6916009)(54906003)(316002)(81166007)(356005)(83380400001)(47076005)(16526019)(36860700001)(86362001)(6666004)(70586007)(2616005)(1076003)(426003)(336012)(186003)(26005)(8676002)(4326008)(40460700003)(7416002)(7406005)(8936002)(44832011)(5660300002)(36756003)(2906002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 13:50:27.0446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae88d64-b041-4308-4ecd-08d9eb09f66d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Feb 06, 2022 at 05:41:26PM +0100, Borislav Petkov wrote:
> On Fri, Jan 28, 2022 at 11:17:54AM -0600, Brijesh Singh wrote:
> > +static struct cc_setup_data *get_cc_setup_data(struct boot_params *bp)
> > +{
> > +	struct setup_data *hdr = (struct setup_data *)bp->hdr.setup_data;
> > +
> > +	while (hdr) {
> > +		if (hdr->type == SETUP_CC_BLOB)
> > +			return (struct cc_setup_data *)hdr;
> > +		hdr = (struct setup_data *)hdr->next;
> > +	}
> > +
> > +	return NULL;
> > +}
> 
> Merge that function into its only caller.
> 
> ...
> 
> > +static struct cc_blob_sev_info *snp_find_cc_blob(struct boot_params *bp)
> 
> static function, no need for the "snp_" prefix. Please audit all your
> patches for that and remove that prefix from all static functions.
> 

I'm a little unsure how to handle some of these others cases:

We have this which is defined in sev-shared.c and used "externally"
by kernel/sev.c or boot/compressed/sev.c:

  snp_setup_cpuid_table()

I'm assuming that would be considered 'non-static' since it would need
to be exported if sev-shared.c was compiled separately instead of
directly #include'd.

And then there's also these which are static helpers that are only used
within sev-shared.c:

  snp_cpuid_info_get_ptr()
  snp_cpuid_calc_xsave_size()
  snp_cpuid_get_validated_func()
  snp_cpuid_check_range()
  snp_cpuid_hv()
  snp_cpuid_postprocess()
  snp_cpuid()

but in those cases it seems useful to keep them grouped under the
snp_cpuid_* prefix since they become ambiguous otherwise, and
just using cpuid_* as a prefix (or suffix/etc) makes it unclear
that they are only used for SNP and not for general CPUID handling.
Should we leave those as-is?
