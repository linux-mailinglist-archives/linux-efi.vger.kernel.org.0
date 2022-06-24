Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0682755A016
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 20:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiFXR6h (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 13:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiFXR6g (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 13:58:36 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1E03F32D;
        Fri, 24 Jun 2022 10:58:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8BqRmGR1CCOykD+272MO92wzOPkML9/4PQdMOj9xoKOeXrulFnzcm+rXmqENdjRiIseV/RGQBhdsFd4iaYhLaTNkh3a7j11jQvIIW2ymKg5BZXLbdA5ESJE1r4wZZ3DAi8GS77VpBQilYcj3Nt0FlHfV/a2lcsaN1r2/gJzj+epm3VxzuunJti2B+srnEAsHjTeKpOzihn8zRS6OQBKhF4gBULHmdIeaaFW2v92EwsKpnEA+0xRO0RAiplihYY25fxl25XGYVEuYpZhzsXcrSoDXC6ORvQbkldWCB+WpK5eODCaXwYmsiJK/8Iy2up8XiWXHOSxceWYNSmGUA+BXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xetGd/YONP5ehNaFXnqyP8R5U9RMF3G7fqt1k0+SSI8=;
 b=XzRW/RoZFar3UsajBt53rlnU4H2M8yMmpJVDnQQJx+Hi2UbpTgqwubSVBBKm7KayftS5i3vmRRu9+/tQBj9lE8XoJLjwmpAi2Y6PqDkxOM+GyAZhR/7T7R6fc5FqkEVG1vsz3DJ+0hsPCPqRdwTiC2z+nl0P0TTGyo79+57YEffSQ1XpjsMriJyv7C6TBwIKbGMlZ9XVga+yEHbz3dCVye8AowesEs2g7Vgl7M3rsVQ/UJmnOnAZr8gWrzpSQTnT8VLEOwuBGRb9fPZzuevIeMhYbgW4UEIkwq6pdjY3ShL4EQQc2A2CY4AHb/TNwY/geWUWMsiHHfHIKHuiW6zV6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xetGd/YONP5ehNaFXnqyP8R5U9RMF3G7fqt1k0+SSI8=;
 b=gHF0cj+daV5bwyISCr9hXvsXRr5wHqsxBS0v0wCp7ehCdeFJoiqmaGy5pKQy/hmsnT0zEH/qFIIR7iN6TKRF0kZnrhW0xnPRn4AZKtaDvbtLsNA3JfGOz33724AFTiOiWSzSAwF5kGxfZ8RHdbutvkYGF3GUHMf4iUC8z7WKykc=
Received: from BN9PR03CA0451.namprd03.prod.outlook.com (2603:10b6:408:139::6)
 by BN8PR12MB3171.namprd12.prod.outlook.com (2603:10b6:408:99::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.19; Fri, 24 Jun
 2022 17:58:33 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::83) by BN9PR03CA0451.outlook.office365.com
 (2603:10b6:408:139::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Fri, 24 Jun 2022 17:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Fri, 24 Jun 2022 17:58:32 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 24 Jun
 2022 12:58:32 -0500
Date:   Fri, 24 Jun 2022 12:58:16 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Peter Gonda <pgonda@google.com>
CC:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        "Dario Faggioli" <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Mike Rapoport" <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        <marcelo.cerri@canonical.com>, <tim.gardner@canonical.com>,
        <khalid.elmously@canonical.com>, <philip.cox@canonical.com>,
        "the arch/x86 maintainers" <x86@kernel.org>, <linux-mm@kvack.org>,
        <linux-coco@lists.linux.dev>, <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted
 memory
Message-ID: <20220624175816.vzwguyo2nd5k6toy@amd.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <CAMkAt6osbEGBFrgn=y1=x4mDHC1aL40BwaW0NdGHF8qmWd7ktA@mail.gmail.com>
 <20220624174057.72dwo7v36lokmoub@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220624174057.72dwo7v36lokmoub@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9547963-9fdd-4c65-7311-08da560b274b
X-MS-TrafficTypeDiagnostic: BN8PR12MB3171:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +GJ71oFw83iYnM/gNRE1OkdNOe2P+2A/wZVXhNhB5+4NivuP7ti0XOyppQ7YOkvXztZgdSMf4bYFiS2NvWer4ENJCK+FyvSmMOHypPbvrECp8LHoo/WnDKv4H6xyiCyBAGi3V0WRsBcpYOPYmGZY26cydEVjIfCFGNSWf3t+vPpQPZfu3mZkBvRZAkpADFpCZbLQj3nQ/q441njpSIA+79GicRcaNXGa1vZNT1watdOliYp+k0K8aSrAzEiK6CFhsWecHiYTBbQRqjXeAvWu5M16UoRPdJEogzLc3wOXgqHND0MutKBJW1AUyUGKONUUlGMsyrXNx0M+TXufD40xQPYBXtjL3Cx0JcBJyGafln8tuUMsbQkV33ZR+2ZO+HXIErlnO9CW+Dp4EEKKwCS6Fso+M+L7ew1f7il9HYQu+aSkWwypMUa/dOA/UaxbM374vwRLhdEg3iFZBSubAqs4+EpQLzzo1xE5BDpJbjGs/0Q+KPeqVjE3C0mXSA2ibbxeyDLocY8bwQ0WIWfKmde4HsPp63Sji15dzTCaK+xdlP85ojYwIo4T1h4X1BdzC9aB8rgvIF+vS/SiiFx+g3ZeoLIpNE4WoR0AQTkP8DU2BbOjc0pSXJJtzc2eACZrvs+Wu4Ue6wcARID1FTYsSHqaBPxfjdoU6GAJls2tcRwY16+dDrG9MXA9nYKenkpWhtF/zEJClStefV0SON5rwQdZsPxXyFTE5fIgNgheePe/ZnB04TkrjHyrtt+mFbW0b+V/H4Oi2ji+S4evprKdHrDKO/nstOVFQRAPL/uJwbpoOdgogOFVEpyH2PGWxqjBLByJebkWCuAW6/eP+RJ/oidlCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(39860400002)(396003)(36840700001)(40470700004)(46966006)(2616005)(6666004)(70586007)(36860700001)(186003)(70206006)(44832011)(1076003)(6916009)(41300700001)(8676002)(478600001)(16526019)(47076005)(316002)(8936002)(86362001)(82740400003)(54906003)(336012)(2906002)(7416002)(4744005)(356005)(426003)(26005)(5660300002)(36756003)(4326008)(40480700001)(82310400005)(81166007)(40460700003)(7406005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 17:58:32.9450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9547963-9fdd-4c65-7311-08da560b274b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3171
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 24, 2022 at 12:40:57PM -0500, Michael Roth wrote:
> 
>  1) how to configure OVMF to enable/disable lazy acceptance
>     - compile time option most likely: accept-all/accept-minimum/accept-1GB
> 
>  2) how to introduce an automatic mode in the future where OVMF does the
>     right thing based on what the guest supports. Gerd floated the idea of
>     tying it to ExitBootServices as well, but not sure there's a solid
>     plan on what to do here yet.
> 
> If that's accurate, it seems like the only 'safe' option is to disable it via
> #1 (accept-all), and then when #2 comes along, compile OVMF to just Do The
> Right Thing.
> 
> Users who know their VMs implement lazy acceptance can force it on via
> accept-all OVMF compile option.

accept-min / accept-X I mean.
