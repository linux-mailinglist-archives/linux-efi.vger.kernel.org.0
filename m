Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288175FBFEB
	for <lists+linux-efi@lfdr.de>; Wed, 12 Oct 2022 06:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJLEfc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Oct 2022 00:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiJLEfb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 12 Oct 2022 00:35:31 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2064.outbound.protection.outlook.com [40.107.247.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDEBDF7E;
        Tue, 11 Oct 2022 21:35:26 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=WriMdLS3MPPaMTBZZQyNTog7R0/5zF69I179s64KElhw2BQ+dfpv0pxYS1XKKWktEGEnwdGGJ7ZfgBeAaSk/4Av2F1S+SanCkwkseRQSX1MZFi5Sgw9ihKAQWnT0H/8M23bgCvbUHJuAukqrvYS36vQ+ajJE0Q7DASFjJFkNMkoan4fyBPR2LlKZAh2mB9aVrcpMHISZ3Hd1mqJcCORnQWPn0RmDYLsQr3oisA8sXV0H+kdxrgqhery+51fWk8yGGggLAgdS9RfPz4LZHGjTHa2NylDuMEyFOaK/4mbyR9/L2GLPpKdjwEr4IQmXp9ta38qWvgDGXzL5oQlMc0sesw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMU9HkrXQhMuuy/ifFX/shOTY+p6Ss67g2VhzKM2GR0=;
 b=blqsXGimSsR0gPbITMRfIgD1lk83RMScFozqzIHgSK/L+BS2IKSPID+/BIvh/BDNGNqK0LSHt1aUimcFKQxpl0GRRXOdjb+8rRXtdCiFPVtRb+cJCPzqCWyOiXgY1ehKmZGMVQLvTa4eI96HTA8B4o9C7ZftOgQIUJhKWz6FcB5qK7wfBFeDvl4rexTofIlVDLQhKcRuofuIR/PvVCswgvphCAduam7iBgH5jryAYH/Ec0oD444bY2S+shOvoI6FxXZjcqOmzHK+2ZelU68HaLnsnOHcbZlyiKOxqF7tO0iiBy81WqXudKvlpsUHqpOf0mdjF/GLDwMWBbmBxEgIrg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMU9HkrXQhMuuy/ifFX/shOTY+p6Ss67g2VhzKM2GR0=;
 b=0/79e2LxM0fd8g7JMoNmZp1TjKHga/7R3SpXFSbnJM/HAKCQRaB8n7s/Oevb+6lPbkfyUZhVwO+TmDRQyMDTPCXgr3nbzLAyIIwPZ0GPDwBmt7JAe4hks0rvrIqLkMztC3mORwxAkZtFEbUduwBajWOqd+dJh6nIXKG5a3PGAtU=
Received: from AM6P193CA0100.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::41)
 by PAVPR08MB9530.eurprd08.prod.outlook.com (2603:10a6:102:314::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Wed, 12 Oct
 2022 04:35:19 +0000
Received: from VE1EUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:88:cafe::21) by AM6P193CA0100.outlook.office365.com
 (2603:10a6:209:88::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.40 via Frontend
 Transport; Wed, 12 Oct 2022 04:35:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT020.mail.protection.outlook.com (10.152.18.242) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 12 Oct 2022 04:35:19 +0000
Received: ("Tessian outbound 86cf7f935b1b:v128"); Wed, 12 Oct 2022 04:35:18 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: da63aeaa6e3d9328
X-CR-MTA-TID: 64aa7808
Received: from fd6639800a8f.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2CAD7B07-89A6-4571-990E-082254955E47.1;
        Wed, 12 Oct 2022 04:35:08 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id fd6639800a8f.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 12 Oct 2022 04:35:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7z+Xwv9QwCt6vL5i42iPiFgnQpLhgbApkeaMwaCzDwUTvPan5w14G41J6GSieUCfiB2V3yegZUt5puGUQQ4WkVosDAc47E+1uUPn56+XUqHnt21uyYJt5bFAiC5BPT/sHb6XIccmB7iCobNYngSU8VegeUqvfFfORd5jfVDEZ++VjRJuWshMR9Obkslh9I5wLKhLkT6wsPlXsPSg88QcR1gvGAAQU/y2o45tHkGbzvKIw9wwYZ4u3mDa8KkVkdE2jwd08KhdEYw8wOFwx7qIJBvG0tTTFv5jIhxXb/T2M+Q9HiSpULoTxTG5IqaaTrE/cv4+uR2AtD6VCao5yZmyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMU9HkrXQhMuuy/ifFX/shOTY+p6Ss67g2VhzKM2GR0=;
 b=WdwP9zQr5r68meDtmZ8au42g/xPmIPFaXHBPS6tYu2y9eWZopQVS7gCrXnfMpD+lKmsWqGlI4MX5C9a+9RBklRZsaXYHWDBhQFJV3Rpf/w+dx0TaEddq9svozcO/UOF2PdN3Vrg8irQohFUjbVyrLTZbqgF+YlIhHDPzz3XLL9I+826OgU22TsUvrHdtDxFi1WwMPGdBNVymW3d3t5fAZCMP5/+/az27B+OXCLz/MKZ5j2vFledSVPczcesJHvPG/CQYME1rzmIof/VS0Iu2CTx/PIhNQ5a+F9q7Go/NaFfHroLWAtX8TRH0JUltYljL85T50oGfpCPo5hWagJ9+dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMU9HkrXQhMuuy/ifFX/shOTY+p6Ss67g2VhzKM2GR0=;
 b=0/79e2LxM0fd8g7JMoNmZp1TjKHga/7R3SpXFSbnJM/HAKCQRaB8n7s/Oevb+6lPbkfyUZhVwO+TmDRQyMDTPCXgr3nbzLAyIIwPZ0GPDwBmt7JAe4hks0rvrIqLkMztC3mORwxAkZtFEbUduwBajWOqd+dJh6nIXKG5a3PGAtU=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by PAXPR08MB6704.eurprd08.prod.outlook.com (2603:10a6:102:130::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Wed, 12 Oct
 2022 04:35:04 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::d98f:f69a:a28c:fbfc]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::d98f:f69a:a28c:fbfc%7]) with mapi id 15.20.5709.015; Wed, 12 Oct 2022
 04:35:04 +0000
From:   Justin He <Justin.He@arm.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        nd <nd@arm.com>, kernel test robot <lkp@intel.com>
Subject: RE: [PATCH v8 6/7] apei/ghes: Use unrcu_pointer for cmpxchg
Thread-Topic: [PATCH v8 6/7] apei/ghes: Use unrcu_pointer for cmpxchg
Thread-Index: AQHY3FE9MI2RuRcaLke0tv5UeBjXAK4JAUiAgAA9Q/CAAAkTAIAAy4Ag
Date:   Wed, 12 Oct 2022 04:35:04 +0000
Message-ID: <DBBPR08MB4538156B4F705A498CF88BE3F7229@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20221010023559.69655-1-justin.he@arm.com>
 <20221010023559.69655-7-justin.he@arm.com> <Y0VGkUxpqiIzIFzB@zn.tnic>
 <DBBPR08MB4538A9F831FA96545BA35D9FF7239@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y0WBklS1XpB5as+m@zn.tnic>
In-Reply-To: <Y0WBklS1XpB5as+m@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBBPR08MB4538:EE_|PAXPR08MB6704:EE_|VE1EUR03FT020:EE_|PAVPR08MB9530:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aed4afe-0a2c-4474-bd35-08daac0b2b11
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 5TN3ugUr1pc71f2T68PrdL93jXgAHSCD1NWARKZxGteYMC5ELgGnEpIfNCzDiTlZXFLrcR+Z5Qy9MBD82EBH7uphYlJdhYzt53z7oW8MDK/360sMFo/v/ZH5SPnNGWQKyApmhX6FFZqSxRO8pwTOJ7sfL9dTaahRYqbXs6yF9CjF/IZPHpSWF/N6FAWOtW91jsobAz0MpKdZu6WUeW7Ds9d1uXDAOxC9qQS7mRle0r4MN7XBmVcYISzA+K2VrkaX3dQ8EJIhAmsHSdgHuwSEVAydjxf8dljcBBkbYwwtgDvS6SnrsjgCaSRXTDlkCU5FgOxlTBtW1P4ZENL7yO4XhZPGsWlnrpjuAHitw9FFMsQbG0A5NmjyvmQnHZ7qui8fix4mnygIETsxgwWIo5rUPzmM+aJahQQlDW26/PBRt6ZErhLonpHR1zqeaAlVyjRGiDn+82IFo5nWW19PtGO9zQaBjoxyf1zFb9ZIdCa3tu6sK0669eMaBM2OxSw4HMTRzOC8Ye4jRsyHV5FKSq24mHiKjiJdXodic1EkwiSRYcT9MVFw8IMq9DPkz0lU7/mxr6KB1RxOwMGCVr14P7gf3+JKec/TX37abLgEAf38EfpjubQaYKpKKq2zlamjUSIoi2UWGIE+e/5+CGRO612TYyFCpbbSqqIB04Y+BngG4xnOch0C+PU8mGN267uYnpegOfWof4ihLKGrr0vJHCRuSAby8M6nAyR8yEYjdEA8dhF3uXSMVWaCs0ZbQpyNuQvnSZb9/BaZmmTnGsrHWEyZEynmepDHpZNfCAqIToFEQh2uoW8FisOFMz0uPzPhKW0p
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199015)(33656002)(55016003)(53546011)(6506007)(7696005)(9686003)(71200400001)(26005)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(478600001)(8676002)(122000001)(38100700002)(86362001)(52536014)(7416002)(186003)(5660300002)(38070700005)(83380400001)(8936002)(54906003)(6916009)(41300700001)(2906002)(316002)(17423001)(156123004);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6704
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 71fe0ecd-0170-4520-793a-08daac0b222d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N5FfmzN1fkV0f3/0Q+c+NdiNJh7VJSUmCAP4F3fzn1/rj+FxzmWkSr1lm2KHWLHDcyy8kgpdCxeuKAAcbBfJ1evZCiL/gN/0LP9kq1p7f5kbp16hffcgS4ilkOUtBwrYqtDAeEYFtU+EkfKExgpRcdSOWf1fG3hiU8xtMs7mJ4eqt8Ku6/tFno8q8yz80KAgtmCoR01XwNFTsz/5X4KuTLzN1NCM0RdptkD3w7hBlXEUM1Q7kK1leZ91suirjaQw+gLVnnQFJG7hUp5Z8G4iKrhb8b0+QjmsFO+AnHHOYVrIC2Hq8rNnes7gGRbpEJHYZNdFEHBInr11iamWEPGUugTFdPNMkkPZWOgxt8CWf5NnAVUT+BCtH4S8AvI1HdTn0vID1zf/gcKdI+sgonMy0q0hhMg9Dqt6H60P8Sp+Buda1DNXHqldBC4g1dhGKsVGtEPmYe1H07iJFV4nHiZ9r1vTwdiGPWhxsxGjJZ54Myd2YoNIS+v0a8R6n1aGivh0JDxa4MAs8f8XMy3mdd1xdOy15034R3gmUs7Mvl/RtCuPVumhaRmDYX/Rm0/xGNdrQXYUr1E2c1NrFDWXoypMSY5GHV9HayzvEz+BOEhBGxY35DnsWz7dH16o+DBMVKrilfsCjkXW1ChudZDdOBZ+y6KZfTdwYRLurhheEIwIhbWa4nXy+89y8k6AbAaHiyJwiCFSI+lJOzZ+t0yK/FdZ0mxFPANRmvKxZ879HWye2VIw973CDHC7kAHYWTcPdsS3yTGPthvUO1tPsK9H4QljfywObzwxxTwQfvnZiGJ3vhNq9ZCyphcKyEO9llhQxSk7
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(52536014)(6862004)(8936002)(2906002)(5660300002)(41300700001)(70206006)(26005)(9686003)(478600001)(54906003)(82740400003)(55016003)(40480700001)(40460700003)(107886003)(47076005)(53546011)(4326008)(8676002)(316002)(6506007)(86362001)(7696005)(70586007)(356005)(336012)(82310400005)(186003)(36860700001)(450100002)(81166007)(83380400001)(33656002)(17423001)(156123004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:35:19.1359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aed4afe-0a2c-4474-bd35-08daac0b2b11
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9530
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXNsYXYgUGV0a292
IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMTEsIDIwMjIgMTA6NDYg
UE0NCj4gVG86IEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5jb20+DQo+IENjOiBMZW4gQnJvd24g
PGxlbmJAa2VybmVsLm9yZz47IEphbWVzIE1vcnNlIDxKYW1lcy5Nb3JzZUBhcm0uY29tPjsNCj4g
VG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPjsgTWF1cm8gQ2FydmFsaG8gQ2hlaGFiDQo+
IDxtY2hlaGFiQGtlcm5lbC5vcmc+OyBSb2JlcnQgUmljaHRlciA8cnJpY0BrZXJuZWwub3JnPjsg
Um9iZXJ0IE1vb3JlDQo+IDxyb2JlcnQubW9vcmVAaW50ZWwuY29tPjsgUWl1eHUgWmh1byA8cWl1
eHUuemh1b0BpbnRlbC5jb20+OyBZYXplbg0KPiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5j
b20+OyBKYW4gTHVlYmJlIDxqbHVAcGVuZ3V0cm9uaXguZGU+Ow0KPiBLaHVvbmcgRGluaCA8a2h1
b25nQG9zLmFtcGVyZWNvbXB1dGluZy5jb20+OyBLYW5pIFRvc2hpDQo+IDx0b3NoaS5rYW5pQGhw
ZS5jb20+OyBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPjsNCj4gbGludXgtYWNwaUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWVk
YWNAdmdlci5rZXJuZWwub3JnOyBkZXZlbEBhY3BpY2Eub3JnOyBSYWZhZWwgSiAuIFd5c29ja2kN
Cj4gPHJhZmFlbEBrZXJuZWwub3JnPjsgU2h1YWkgWHVlIDx4dWVzaHVhaUBsaW51eC5hbGliYWJh
LmNvbT47IEphcmtrbw0KPiBTYWtraW5lbiA8amFya2tvQGtlcm5lbC5vcmc+OyBsaW51eC1lZmlA
dmdlci5rZXJuZWwub3JnOyBuZCA8bmRAYXJtLmNvbT47DQo+IGtlcm5lbCB0ZXN0IHJvYm90IDxs
a3BAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDYvN10gYXBlaS9naGVzOiBV
c2UgdW5yY3VfcG9pbnRlciBmb3IgY21weGNoZw0KPiANCj4gT24gVHVlLCBPY3QgMTEsIDIwMjIg
YXQgMDI6MzI6NDhQTSArMDAwMCwgSnVzdGluIEhlIHdyb3RlOg0KPiA+IE15IG9yaWdpbmFsIHB1
cnBvc2UgaXMgdG8gbWFrZSBpdCBwYXNzIHRoZSBzcGFyc2UgY2hlY2tpbmcuDQo+IA0KPiBUaGVu
IGRvIHRoaXMgcGxzLg0KPiANCj4gVGhpcyBpcyBhIGNvbWJpbmVkIGRpZmYgLSBkbyBhIHNlY29u
ZCBwYXRjaCB3aGljaCBkb2VzIG9ubHkgcmVtb3ZlIHRoZQ0KPiBzbXBfd21iKCkuIFRoZSBzbXBf
d21iKCkgdGhlcmUgaXMgbm90IG5lZWRlZCBhcyB0aGUgY21weGNoZygpIGFscmVhZHkNCj4gaW1w
bGllcyBhIHNtcF9tYigpIHNvIHRoZXJlJ3Mgbm8gbmVlZCBmb3IgdGhhdCBzZXBhcmF0ZSwgZXhw
bGljaXQgb25lLg0KPiANCj4gQnV0IGl0IHdvdWxkIGJlIHBydWRlbnQgdG8gaGF2ZSBpdCBpbiBh
IHNlcGFyYXRlIHBhdGNoIGp1c3QgaW4gY2FzZS4NCj4gDQpTdXJlLCBJIHdpbGwgaW5zZXJ0L2Fw
cGVuZCB5b3VyIHBhdGNoIGluIG15IHY5IHNlcmllcyBpZiB0aGVyZSBhcmUgbm8gbW9yZSBjb21t
ZW50cy4NCg0KVGhhbmtzIGZvciB0aGUgDQo=
