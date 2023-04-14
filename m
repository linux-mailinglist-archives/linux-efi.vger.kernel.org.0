Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BBF6E2393
	for <lists+linux-efi@lfdr.de>; Fri, 14 Apr 2023 14:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjDNMpJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Apr 2023 08:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjDNMpH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 14 Apr 2023 08:45:07 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA2E59E7;
        Fri, 14 Apr 2023 05:45:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tr3hpSCMuOCYUkxLrLDpoSr57iYCP68uslpAWzeFxiN4yEpEwG96c5CF27Y1QTNsMxTYqqgPqJyOH69cycYroZOzbLb6Rt2hp7g7vdY32FUZyTNLMUqVeKKorhpet5DHHe73H4yrbeAg8yVBmqZeH7/Iznuz/2Oa7NhVrRapJyfCKbsoK3VQVs9wDQjmiZd3xezFFKob3hVFlveTZrXiAQXHCY4zp7Wg/liAgyPLxOFUJi0E6+ozIE3CCvArBOPJeSO4ww914NEg1QUiYBc/GOhIEJlWszTsBtSC+8wL7z4rJO5PE48y8FDBek6HbpZ4i/eePTnTFFadJowlaSfqEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzRJo/kNuRJuKLWiqZic4qgXwlntMVZdTx2XPhDRTSc=;
 b=kSnZcqfBDxguzvdYRANLrsLynPFI5pbDWi+FYgWzV3px3D4+OaeJVccFdIr3EmOfORGyU7gu6zB/R4cEc1QxpwHnhB1jFg488zKmryLeervNQUHyvwAFYjh+kWmKIgrSp3Q1ES30vSRIJbFTHewBbXpWWw7j5UxxMp3IUtvvtYiFTKObnBqeYdim7CVE9JC8vZLX7J4fQi7t1QiZYm1dLWzqPdH3TM+eA7kKnh/hQZTk0BVW3uwkhi6bb/95aeGfJG6qKa06hNf5/G2Vkt/2gDujy3zUle1c2o6kzPai1syVN+NRGjN9B7KgceVkxARMcGB/6ABexj7fere9+FEDoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzRJo/kNuRJuKLWiqZic4qgXwlntMVZdTx2XPhDRTSc=;
 b=1tIhBnpO06f95Y3hXrcaB7FMlxp/mcEqIo+gZkVZ1ruP10Ap1Gq2ZoeNhEf5F4nljlyvQCREQ8QlUwQEb6OhU+f2rU2mZzpLrHJziIMTUgq07qp2Eom9uP3gn35fWeyvp/F1Xn49nQXm10mvVRIt5sw6AZh1cE/JcScCX4v6xs4=
Received: from DM6PR13CA0020.namprd13.prod.outlook.com (2603:10b6:5:bc::33) by
 CH0PR12MB5281.namprd12.prod.outlook.com (2603:10b6:610:d4::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30; Fri, 14 Apr 2023 12:44:58 +0000
Received: from DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::57) by DM6PR13CA0020.outlook.office365.com
 (2603:10b6:5:bc::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.7 via Frontend
 Transport; Fri, 14 Apr 2023 12:44:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT109.mail.protection.outlook.com (10.13.173.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.33 via Frontend Transport; Fri, 14 Apr 2023 12:44:57 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 07:44:54 -0500
Date:   Fri, 14 Apr 2023 14:44:51 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Terry Bowman <Terry.Bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] efi/cper: Export cper_mem_err_unpack() for use by
 modules
Message-ID: <ZDlKw9bnsxIGQWt7@rric.localdomain>
References: <20230411180302.2678736-1-terry.bowman@amd.com>
 <20230411180302.2678736-3-terry.bowman@amd.com>
 <20230413170816.0000333b@Huawei.com>
 <9d66afdb-40bd-4254-547e-05f6481dd550@amd.com>
 <20230414124805.00000479@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230414124805.00000479@Huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT109:EE_|CH0PR12MB5281:EE_
X-MS-Office365-Filtering-Correlation-Id: a8b05871-bd67-4ca8-8640-08db3ce60df5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tiEZnfjqi3Qa46yuoNPJmzHVSNw/t5jZOK0cu3lUxClHJmP7Z8Q42Vbo2euIK55uFquH17+d7yC5zMMbjtUoON8CJTVQ5562n7MaYO3uDiIwpVHxaVG/at/+OXYlGDqjHSpS0mNvCOktmAWajIpjp2ruDcmS8upavY4zUgRHx99BhuBumLkaVaHgR07HAHo9sq0fihtKl1uDUDVaStuQWG5NyWXbL0qDVQXDmbUmrN1gvpkewVIyHLdfN7NzNDH/hBStZsxWkKt+l4qs61/+Sf14zEn/AGbUo+xJDteUcL/hd0nkD0RBV+biKZ2Vml7Kv7l/trPkh9fhCqW3A/xnNED9Agklj9fp/8gbCD5bBzfoX8P92s7mE7Rgm9rIlQAwWQleOjPf2MF+mWMTdThsBu0zeokOeDGqp5COKTZPomRxMWB7lxH6P+/raYWnHS8Y0mr+w9PfbZvP5fmwFk3x2stv9P/uixXh7487slS5IcvgNspNbv2rwwrYrU/o4fJUoe4TbeIJXgc+T5QGXN67nmnF9DKIqsHbadVfW5JJTEjrXPCdY4QEg2VXHLL0etpdMWL3+3heqnrlsVcS+8LUgLAsLtKIt4nkzsbkZQhzTAkOagoIbFYK2krUVIbHpaqfFi7M4D/u/pNaP6K11O648TbYXISEHY7nPJUMct0hmOeAsjxN5J/ZYl9F2GxF/TxX0OXfdvo2vA0Ov7lAIOx9JsZNUqduJ4Xpfa04/QrDE24=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(9686003)(26005)(186003)(16526019)(53546011)(54906003)(40480700001)(478600001)(55016003)(81166007)(356005)(2906002)(7416002)(8676002)(8936002)(36860700001)(41300700001)(336012)(426003)(5660300002)(47076005)(82310400005)(6916009)(4326008)(316002)(70206006)(70586007)(82740400003)(6666004)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 12:44:57.6615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b05871-bd67-4ca8-8640-08db3ce60df5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5281
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 14.04.23 12:48:05, Jonathan Cameron wrote:
> On Thu, 13 Apr 2023 14:40:10 -0500
> Terry Bowman <Terry.Bowman@amd.com> wrote:
> 
> > Hi Jonathan,
> > 
> > On 4/13/23 11:08, Jonathan Cameron wrote:
> > > On Tue, 11 Apr 2023 13:02:58 -0500
> > > Terry Bowman <terry.bowman@amd.com> wrote:
> > >   
> > >> The CXL driver plans to use cper_print_aer() for restricted CXL host (RCH)
> > >> logging. This is not currently possible if CXL is built as a loadable
> > >> module because cper_print_aer() depends on cper_mem_err_unpack() which
> > >> is not exported.
> > >>
> > >> Export cper_mem_err_unpack() to enable cper_print_aer() usage in
> > >> CXL and other loadable modules.  
> > > 
> > > No problem with the export, but I'm struggling to see the path that needs it.
> > > Could you give a little more detail, perhaps a call path?
> > >   
> > 
> > The cper_print_aer() is used to log RCH dport AER errors. This is needed 
> > because the RCH dport AER errors are not handled directly by the AER port 
> > driver. I'll add these details to the patch.
> 
> Ah. I wasn't particularly clear.  cper_print_aer() is fine, but oddly
> I'm not seeing where that results in a call to cper_mem_err_unpack()
> 
> More than possible my grep skills are failing me!

No worries, it is used in some odd tracepoint macro magic included
with ras_event.h.

-Robert
