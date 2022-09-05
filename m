Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A345AD4DC
	for <lists+linux-efi@lfdr.de>; Mon,  5 Sep 2022 16:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbiIEOd3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Sep 2022 10:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiIEOd2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Sep 2022 10:33:28 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70087.outbound.protection.outlook.com [40.107.7.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE1344558;
        Mon,  5 Sep 2022 07:33:27 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=DWri+F+WRi0MqhONLe8fe2y1sxneugFJWJf0z2QUTlUAJ5hUojNUvQH+ndWUonq3mdau6kDVbq/Jvkgep/nBO5zDi3B81jKQJOMa3cMAWcr6EEQp2HP9/3t2a4rt2xRZKlyntlVwWtqfkjoLhwaKRPFDSzWJmDm+5rGJ3+UHr6tOXB/P6KRBm6a5TZRo/OTjWvOmWBGs0lQYEZprz1/EzqTRH4wsOkP16rz80TXZy9F388ci4F3BrFY7LbDSyN/ZEWUtuFw4UaH4IVaS8yj8nIwRVwvXxbBqGNgnlG70frzKgAwgLMeuabqnnHC+/UWkUDqdPJbqHWpUGswTfF/DnQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5k+rtzwD52E2mJV4rDYVMkPAZqJrBAs/8ARx//tFZ0A=;
 b=FC8d40E0iysA1PwCrSV4ydSH/X5RdrsbTvw2fNo43YmjwgYYtt57n/htJSTpDfkgPcN1dxGec3fKqlcW8i0fKR8U84Q2eoCxA6RYI1PGQRbQADYiVG8EgX/zwzS+fqh7XNch/2Zf+bO4FlK3T8uS9xaIBHfY2r5LGxvHCts10YNv1xYK5yB/op32K8uQD/+j1NwW8nOjR6XSwu6ha2cG30zIJND50ptKx62oJrG57OUcrygVSkuQZnBE1PqP5t0wy2M1hARf5DgcZWreRrc6BciEnBZOqoaGvtXl9ySD8CLVHlRfMhIEA4/irT68ynlfg/Wqm0YtkCOHxlx4zEUJvg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5k+rtzwD52E2mJV4rDYVMkPAZqJrBAs/8ARx//tFZ0A=;
 b=R2RJYBmvtKpPESwLRGCliUUIenrzzKjbLlFpnzUIUVHT122jZub4i8SfEZC/bGgLLyihq3D9Azwyesrqljjq5Uo3lCHhJcC24Zi8zabVWmholqpNaHZYxUtffhTcyWnf61VNnPoWSHOeyWYHJUKUQjriU1qB/v784Ik3I/Q1e4c=
Received: from DU2PR04CA0086.eurprd04.prod.outlook.com (2603:10a6:10:232::31)
 by AS8PR08MB6535.eurprd08.prod.outlook.com (2603:10a6:20b:336::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 14:33:24 +0000
Received: from DBAEUR03FT050.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:232:cafe::5c) by DU2PR04CA0086.outlook.office365.com
 (2603:10a6:10:232::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18 via Frontend
 Transport; Mon, 5 Sep 2022 14:33:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT050.mail.protection.outlook.com (100.127.142.250) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10 via Frontend Transport; Mon, 5 Sep 2022 14:33:24 +0000
Received: ("Tessian outbound 73dd6a25223d:v123"); Mon, 05 Sep 2022 14:33:24 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: bf4cc00f9f8f795d
X-CR-MTA-TID: 64aa7808
Received: from ceac383323c3.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D3762454-DBA2-4F80-B2FA-053FA6D88EA9.1;
        Mon, 05 Sep 2022 14:33:13 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ceac383323c3.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 05 Sep 2022 14:33:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrROeI8iheLu8I5On5nkCFvJ2sKmjpHdNLaj25PSmV2Y4YsqwxJLwgZ9kcOZQ4Wtv2Y2T0/yhu4DoyGuIN+CNOCjPMBJu4Ji4dytr5SOIzgpa8h47MBLihPIovAhr5UdykOZSAAC/7fnIrnsxrERvtxkeArpev+qRzBd1bSfOvm5eV+G69coxYnQPBkvdzYZmefksXDxTnpArgNIYP0lL8xkpZwvjK5RsNzbQ2BJhABVYm1QeHgjo4YktZpNeotCodu1j9Ufp7Aac837D/JLc94u+tFMaOKUI3oHi35rGSeepwmADG5biUPrbID+jgs13B88IZ3iRFFyss5UCaoYxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5k+rtzwD52E2mJV4rDYVMkPAZqJrBAs/8ARx//tFZ0A=;
 b=nahB7v0YOlZMPZlMt/+bNNRRKlgvZEBuT4ytLkk1maR/JGzBeObuAggA3vO5+SZ28PdmGCCwrnJeOQGE8xzU4sX3wKH/vnFHUHH18I7xEMAnV72x7xqXmG/0fFmFCGLdk/Nm8AgXkfUjN1cL/C2b2DFIORNyYAGKzD8w7zOKtunQcBVdV5hdSzRqyLwXpcyRO32L1C0AYRiY153HeM++Xo6OGbY6AIg4It3gH/sQFcVh0787kkilk7cpb8PnQYtdpRLDgb18aci7T+FYVT77qDY2qSWdc43gRfj8dckUUJqRoDUt28VuxdmhQHCeUvCsjMqDjIqD/jUMYJ2CtBx2dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5k+rtzwD52E2mJV4rDYVMkPAZqJrBAs/8ARx//tFZ0A=;
 b=R2RJYBmvtKpPESwLRGCliUUIenrzzKjbLlFpnzUIUVHT122jZub4i8SfEZC/bGgLLyihq3D9Azwyesrqljjq5Uo3lCHhJcC24Zi8zabVWmholqpNaHZYxUtffhTcyWnf61VNnPoWSHOeyWYHJUKUQjriU1qB/v784Ik3I/Q1e4c=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by AM9PR08MB6099.eurprd08.prod.outlook.com (2603:10a6:20b:286::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Mon, 5 Sep
 2022 14:33:10 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::c426:e28d:64d9:9d0f]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::c426:e28d:64d9:9d0f%7]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 14:33:10 +0000
From:   Justin He <Justin.He@arm.com>
To:     "Kani, Toshi" <toshi.kani@hpe.com>, Len Brown <lenb@kernel.org>,
        James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        nd <nd@arm.com>
Subject: RE: [PATCH v4 5/8] EDAC/ghes: Make ghes_edac a proper module to
 remove the dependency on ghes
Thread-Topic: [PATCH v4 5/8] EDAC/ghes: Make ghes_edac a proper module to
 remove the dependency on ghes
Thread-Index: AQHYvQ0mwst0fCgW/0KIW0mdjbCxYq3MZIKAgAR7I1A=
Date:   Mon, 5 Sep 2022 14:33:10 +0000
Message-ID: <DBBPR08MB4538916D8C9AF314A71D2C29F77F9@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20220831074027.13849-1-justin.he@arm.com>
 <20220831074027.13849-6-justin.he@arm.com>
 <DM4PR84MB1853F07391E61292D4119F21827A9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <DM4PR84MB1853F07391E61292D4119F21827A9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: a8df4ff8-2cea-491d-f269-08da8f4b971f
x-ms-traffictypediagnostic: AM9PR08MB6099:EE_|DBAEUR03FT050:EE_|AS8PR08MB6535:EE_
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ODYdUG9vP5d3fCrqDOLnQ+bLyDjyA7G+plC7y53uezVQMRIGX+9OGQ+pT+5RGyr+d3QT9WAPgI99rCbOmnhN0xJuGlUq5Avnfd/nkdr1XLCJHRYgN4l+Qe4iZMfGLpIbRevlrxFGF8XFiqx4bk8hcPVg13GsvhI+5oMgqSlNLR6PC7p6V5/rv+QjRj1W7bRVOpulamfA7nR9RmrYq+1jvuvNIHd+V/D8BDgsxZsKeW4chc5AvSK1uc7tvLwm4n0DhbxOr/SbJbAehV5Oa6UJXtlwjtPdxNEdtFroN+97uly+wuXwp/o5C4OTg36FGzjfN59ckKfXdqDT6YM3SVOzvJ456UjBVJQPV21B4jOQzo95verk2s336TZuRL2jK4iQJk1rYqEyZCdE596v1wP/UR+ySdq/gt21qLmxNJTWRB0+T903dLDsML5g4U0ynweh+xmETEWlFI5aY/oSLTU9/JPbSDAqGou3K8cYRJJmARx4gTXr2g4XvJAcmBLvTaqjhbNJ5bkHSs9hatNz0ts2/+GdZZYAll3HoKwe+1UzcklCcBBIy5Z/ckPffnZXsCkhJ3rm97wzGQCCgFeKCeBcpS0l0gOBA1Fj3OYr8b+cbMyO7M3xtwG25qUhidreXUoJ7twuL6O5OG82NABJ7LqarI+paWM861Barp0KfP7dbpIBJYZFGQWHWv1PLmvTYnfK9YNbkyb8e1OOvSrKaQo0Jmdj8j0C4TodTlPDm4vjoFYtJkLuHZyeBWoGeJWjFffMpeNH/P3GXD36f3qoLIsJKzJyUm9omX9uLps1k1Cu8E8=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(83380400001)(38100700002)(122000001)(66556008)(921005)(38070700005)(4326008)(55016003)(76116006)(66446008)(64756008)(8676002)(66946007)(296002)(110136005)(316002)(66476007)(54906003)(2906002)(8936002)(4744005)(7416002)(6506007)(7696005)(9686003)(26005)(186003)(52536014)(5660300002)(71200400001)(41300700001)(478600001)(33656002)(86362001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6099
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT050.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 449fbc3e-b99a-49e6-b976-08da8f4b8eaf
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yOWS7zELPWSZy9fK5xE2/h7xn/2ViUGwTpUKpEelMJ8BFt99RIlBNwa+DAdLwMGxVQ1N7RMOmEqE35tLG53p/6DTqikQqyGpUfPUDymqOY19l5tF8iO1wFe1XddV8Ii396WeXqrOo0bQzmXmGOeRNOCnXtJubo3/X1AeYLQeojLHnxM9cB0dNA7MvK8vpHrSoxXdf/M9GmSeiho1iRLqJjUkD1rPr8I+oBqMIZzIMw+DDc5jTCvVhvSYO9hw6E+aJzYPLVySwm/4DozQFm8nMMTuvGHhCSL3HH5nBYMdMhJN9F2n3Kmr8j6+oXHkzNIvasK6dLpy7SUS1PmIkMm6CqPGowIthY3MVBY0jYB/u4++nRxXYgCZItlBjZhZjWY1lExuDCi20tX/xgja/017YZB9UAqmCKUOhYue63DR2/ab7T+bgSEytqujyjWLnr9OTVrUJiixf/k85FzKx2lBapU8r7KW8XOX6r9mGge7UMCNAQwpzS2VjrycNKLtb4Wo8hlGfrezfzI+YQlejQcB5fc++U0m+CujNuFJUh73DSm+h4HB3CpiZRzUfcU7MlS2wX90Gwyh/GIBh8qSfa7bpEsWT1W++eUjsxTHrDvvg/OfLkEVUCKE7A2gfB+XYYuISgIGuvWqJkbxR+x2oc+InIr9uxwVWlfyfrunrubUnz/Yh7uHHWXA1NfyosV/KUieSXt9dd6R6s0WZsREFN12CmDNQ5yb7mLSu4nAAk2PWWqltoyC3Tn48XwJ3pVTlyiwnAUBy9B4jch1DCJNwd/Z2Ebs67mc7fTdGgtjPegSBcU=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(39860400002)(40470700004)(46966006)(36840700001)(26005)(7696005)(47076005)(186003)(336012)(40480700001)(52536014)(4744005)(5660300002)(8936002)(9686003)(6506007)(86362001)(33656002)(478600001)(41300700001)(2906002)(40460700003)(36860700001)(83380400001)(110136005)(8676002)(70206006)(82310400005)(316002)(70586007)(82740400003)(81166007)(921005)(356005)(54906003)(55016003)(450100002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 14:33:24.6962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8df4ff8-2cea-491d-f269-08da8f4b971f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT050.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6535
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Kani
As per your review for previous patches, I will update the commit log in th=
e next version.
Please see my comments below:

> -----Original Message-----
> > @@ -454,7 +437,7 @@ int ghes_edac_register(struct ghes *ghes, struct
> > device *dev)
> >  		pr_info("This system has a very crappy BIOS: It doesn't even list
> > the DIMMS.\n");
> >  		pr_info("Its SMBIOS info is wrong. It is doubtful that the error
> > report would\n");
> >  		pr_info("work on such system. Use this driver with caution\n");
> > -	} else if (idx < 0) {
> > +	} else if (ghes_edac_force_load) {
>=20
> This change causes the following messages to start showing up on Arm.
> Is that what you intend to do?
>=20
No

> The messages can be avoided by not setting the force flag on Arm
> unconditionally.
> This will need some change to the flag check in ghes_edac_unregister() th=
ough.
Yes, looks like I can remove the ghes_edac_force_load check in the ghes_eda=
c_unregister()
since it had been checked in the ghes_edac_init


