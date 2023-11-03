Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7837E0562
	for <lists+linux-efi@lfdr.de>; Fri,  3 Nov 2023 16:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjKCPQc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Nov 2023 11:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbjKCPQb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Nov 2023 11:16:31 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6539FD4D;
        Fri,  3 Nov 2023 08:16:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdvrnoZfYPNQupXLkLKdzBtONF5f8wK64n4wbT5UrTsmTzKv9+kBq18788GG/MgfP3ckgvM611Au+2nQpLNZ4PtdouB3wUTO2/nNzqNvgqPSp3Mp/J3RfUy54TRSI6BYXacchDvGWQp7VX3GGP1PSLX3NOWtBBLoAsC3GDiDhLndcdvE9z3AtPYg0kMJo0Tr0HTsWyVBxSgPBxwiFLEbRp6oCjvTiQXiryODQn+ilSW0pZoC/aLhc/+KS8dBHFKMIU/U344LJorqIaAn428VrLUiNv7o6FC8FTGxViOy3USG/IK0lYCT/IfF9YTvRm0s8etsw9bW37L4vN1IziTHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a08XbWVO9YN+VZwYojSl2NmshVyjXkTdRSViiHM00wY=;
 b=nde/r4SFrpgGAqZo5qEgKzwF4kPbOKYjWuQLlanKZtLWQmrsZE42jn9GyU6ZyAkKXV2853z/xf09uAughBFbqvYRQRbSfvuFRVKzbXgNQBUJlV85mzqhPqHwAqUcdn0P+X/TjkM16qmnBEchpz+Gai+g2NYMErrohwcUtbVMT+X5+9ldLryVFKFdAoVfQf1vzUvNPT9N44EFquK7cuyj92VhxkmYiapdo87B/KMUWuaT1VHyKXTGhDBDzOm+1RUmG8muU8+xmC+OLIlNEH0qxvL68KgsNMuYos7jWrtNZ49rCuEsWh7wFuiW0lI94xiV6PCa0ilwhq/0EOYnQPf/6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a08XbWVO9YN+VZwYojSl2NmshVyjXkTdRSViiHM00wY=;
 b=Jn5qwq6sB2Q3cwcamt3Ia1jHjHGAKKzH6oCCOKWq1KZSfjAxf0YYd0sOioJB3HvDVekMCCfIFppOMxdpsXVXvYV1eTTDv0DgLUv4nz29ulSSzpA0E+LY/sgjWM41eM3rbPom1XRTSEpxCF43I46OGS2PZoPUuxsBXKc0xX6E9Ko=
Received: from MW4PR04CA0358.namprd04.prod.outlook.com (2603:10b6:303:8a::33)
 by MW4PR12MB6973.namprd12.prod.outlook.com (2603:10b6:303:20a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 15:16:18 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:8a:cafe::e4) by MW4PR04CA0358.outlook.office365.com
 (2603:10b6:303:8a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 15:16:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 15:16:17 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 10:16:16 -0500
Date:   Fri, 3 Nov 2023 10:15:31 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
CC:     <linux-efi@vger.kernel.org>, <x86@kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        Nikolay Borisov <nik.borisov@suse.com>, <stable@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] efi/unaccepted: Fix off-by-one when checking for
 overlapping ranges
Message-ID: <20231103151531.7e374teoxeekcrlm@amd.com>
References: <20231103142650.108394-1-michael.roth@amd.com>
 <20231103145353.5wzcwc5znkzt6vzf@box>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231103145353.5wzcwc5znkzt6vzf@box>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|MW4PR12MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: bfd83ada-b658-4e81-e058-08dbdc7fd442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kwmS6Gj6MuNB3KzmVfngxdirQ6BTVNQT84rWdW/Z37mfOSIOWzpXnp5dJ5faDnNRzwzI8AACu/KMq//OQSNYaA/7wqXfqnidJ2WkXKfUVXSzJ2xF8IgiuWl/1X5gLslgRjAn3ym49frCPbxmfC8L2Brz7QZd1DC3jKyht1WPROKbAXBIZnmjaHql9KhAj0bmnICiAbY5vzJRbiy0bGEo0pJW7Wq4+IwSdDWhQ0ENvQZF/ygpFXkngAnqH7AM34QBu5DoTb6ZMSUWnAD4RFsFu6sv2k27F6346JMN/0VT7S40Bkda6hfO9arRg7bF864TMzdYiV+dqpo1HM+OgIbUV3oSdKHhSDMYNnBeofYuBPdvi38Gb816zHbPHW1tkwLKdN8gZO6Uf7lT7yqoTPXSrkqj50bQFdXTtWm5rX2kV46OC2mAmFCBP2Q2DrwNq3YuZPwOdZ5YTdeP+KIf0AMl877IpLu1B2FjH7uMgR8HJkQgEkXHKEAazkE/U6R/HyQChckBkfzFV0XBSkmO1GdnWvZFmsv1zgMDcVJ8xOUGsmT/FalZD+xGlrWT4+j0IlOZYB8rt7by6d6u6x1zxNkneD8AdHhAhyY/O0pbhHlhX6CxyqMrngj7CFiaXcY+ler1M3YJ3kjQpAAV3h7F855TauXNfObPRPOBbLdVL6Rk6guIhHEHzqOuXmDReMAL3MOR6GLj544xurLOWiJaUpmWMAZIo9mT3AKd4HcpTnq9+lndplUimjoBkaS8pwqjYMoM
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(86362001)(316002)(6916009)(54906003)(4326008)(6666004)(8936002)(8676002)(70586007)(70206006)(426003)(2616005)(478600001)(16526019)(26005)(36756003)(1076003)(966005)(336012)(44832011)(41300700001)(5660300002)(83380400001)(7416002)(2906002)(47076005)(40460700003)(40480700001)(36860700001)(81166007)(82740400003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 15:16:17.9729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd83ada-b658-4e81-e058-08dbdc7fd442
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6973
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Nov 03, 2023 at 05:53:53PM +0300, Kirill A . Shutemov wrote:
> On Fri, Nov 03, 2023 at 09:26:50AM -0500, Michael Roth wrote:
> > When a thread needs to accept memory it will scan the accepting_list
> > to see if any ranges already being processed by other threads overlap
> > with its range. Due to an off-by-one in the range comparisons, a thread
> > might falsely determine that an overlapping range is being accepted,
> > leading to an unnecessary delay before it begins processing the range.
> 
> Maybe s/thread/task/g ?
> 
> > Fix the off-by-one in the range comparison to prevent this and slightly
> > improve performance.
> > 
> > Fixes: 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused by parallel memory acceptance")
> > Link: https://lore.kernel.org/linux-mm/20231101004523.vseyi5bezgfaht5i@amd.com/T/#me2eceb9906fcae5fe958b3fe88e41f920f8335b6
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> 
> Otherwise, looks good:
> 
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Thanks! Sending a v2 with suggested changes.

-Mike

> > 
> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
