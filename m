Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4246B59CE0C
	for <lists+linux-efi@lfdr.de>; Tue, 23 Aug 2022 03:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239071AbiHWBuU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 Aug 2022 21:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbiHWBuT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 Aug 2022 21:50:19 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326D25A3FC;
        Mon, 22 Aug 2022 18:50:18 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=PaghukkaieRN7IEoFKZ/534abMKXfFh3kags2jwgVlPH+cxHLhbMUXCTxaGaSzff8Egyjkomb7GPRe3y0LiS0Gzs8iYPPX1q6cZz+eHxFr/FFg1vptq+p0dAkFUILruJ2cHVvw5rE+4nZurJ1F23St5MXK0xqF8zE6dBkAWhyZ8M8ndzfWToSgXu/G4biWby8qw+GHE+MWJM8bo5yi4Zil/Zo7gM3SlkIqxzDtwirn6mB8Omf+2iN8UsbP9NDwKEsOVxArqyvJrtIxby/IWFH2/E2qmTiC0DGP2+0qHI88/H3huDTHA6ed6hLF/qQTxME22gv6fFTF/GKXORIy0uUg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUArLcKh0KQHvEEGseyuXOFAwEVLNyMnW4qY4bcUr34=;
 b=eEH6r8A1DjzXdOiKDxd5WAZ4KJCCRwGMneVYWaqPBPB9Q66Ww/ed3v6xt7/zTIbaWDpQ2s8zHGDdPPwMtccdZ3QFR8+FNiCueH42XvuEAV1AYlMHFHV/GLVH4Cr7IhbxmNyJbpJ1DijxB3QJRiRtthkI9VZhL2aUpnCDun4mpcxRr1c4a52Pr8GspKteCs+PRu8feGFae0tY/gEox4rEwRJf08beEVVlfbyMCOHb79V8/v8sflQ1Tq103wEqh+BIBqgkLUlSgq+RgFsznX/I93GRRpM/Rp9LuFovzgpUOjAIU4FvuRL7SxK6U2H1xJHr0HjX5lpQ/wKmN4c8rEwDgA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUArLcKh0KQHvEEGseyuXOFAwEVLNyMnW4qY4bcUr34=;
 b=QEnR6f7q5pSHzgs0nMgoQlCQncyAxF5QvQGPRDg+xi3gEYLfo9zphNcXbpC3uxTU2onI+C2d4w87czpCF9qtjK0PJfJSDOno5/8I9COmX7L/Y7JruNr4bHE0p8c4g12LxykTEKGF1o28XH6WiRJJ1UboLk118Fortdru6JKrKWs=
Received: from DBBPR09CA0024.eurprd09.prod.outlook.com (2603:10a6:10:c0::36)
 by DB3PR08MB9059.eurprd08.prod.outlook.com (2603:10a6:10:429::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Tue, 23 Aug
 2022 01:50:12 +0000
Received: from DBAEUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:c0:cafe::ad) by DBBPR09CA0024.outlook.office365.com
 (2603:10a6:10:c0::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.20 via Frontend
 Transport; Tue, 23 Aug 2022 01:50:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT051.mail.protection.outlook.com (100.127.142.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.15 via Frontend Transport; Tue, 23 Aug 2022 01:50:12 +0000
Received: ("Tessian outbound 73dd6a25223d:v123"); Tue, 23 Aug 2022 01:50:12 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e0e8c7de161cb5f1
X-CR-MTA-TID: 64aa7808
Received: from 41b583c1bdbc.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0C16F6AF-FB19-42FC-93FC-770E3565E253.1;
        Tue, 23 Aug 2022 01:50:03 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 41b583c1bdbc.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 23 Aug 2022 01:50:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdmgjS9SE856c/GfNrwVoi/g75KDPKmGpUO6s/mexlP47uWKXJgOEu5qEDkPruEWkxZ80agdLe9/uingUX/TGS+iZakiV9QrW+XIl2AaiVj7etVyQhJBQP0LjCT8dI+Ek4c0oDzGATF5vfiSIITlPLWIGKhyDEJ+U4flVMWLkkY+FNFNy4RAhS0efVZ0XkNrS5Z5dXGYyQtiGTFm2iDn534f45Fp6+7m20rgxmFqXlkG9XQ/zOLpKd/lIOUrde1vCmh6akTN9gLeIo8uqJ070QLr8Q8HYgYg4NujJ6S7seFH3yTeyf+5X3Yec4O28USI626SzJ/jgauGdoQSAc3eSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUArLcKh0KQHvEEGseyuXOFAwEVLNyMnW4qY4bcUr34=;
 b=PrdGXCZidsGpwKRIyoYIPFH9h/VBl65c6hrZm3prmYZdu5mvMi04Bgy6rvTLDYY6E05/tAxlccNFdfwC2HIo5OnBu4bU9KPekAMXr5iRtK4bWLg0+PSh6SgN34z3Y181nn4e1CYWegpHuexdUrR13yDT5ztGlNT5Dohy2hwc9dRitU7qPHcGpEkdVaujlz18OCLsF+Ng9GzaUAM31Y8WhmMGmf3KKNnYbw+nhpoyi19gwqg1ERNR7aWt/zcB8PZTL6lDD9d2VrEcMIOVpOP47Z2cjIK2zZwrTGEhU6Oz1w7Z22ZWc9K1COq/IcpPKwTirXQrdQhNEZzQYPeQB5Ds3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUArLcKh0KQHvEEGseyuXOFAwEVLNyMnW4qY4bcUr34=;
 b=QEnR6f7q5pSHzgs0nMgoQlCQncyAxF5QvQGPRDg+xi3gEYLfo9zphNcXbpC3uxTU2onI+C2d4w87czpCF9qtjK0PJfJSDOno5/8I9COmX7L/Y7JruNr4bHE0p8c4g12LxykTEKGF1o28XH6WiRJJ1UboLk118Fortdru6JKrKWs=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by VI1PR08MB3101.eurprd08.prod.outlook.com (2603:10a6:803:45::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Tue, 23 Aug
 2022 01:49:56 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::c426:e28d:64d9:9d0f]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::c426:e28d:64d9:9d0f%6]) with mapi id 15.20.5546.024; Tue, 23 Aug 2022
 01:49:56 +0000
From:   Justin He <Justin.He@arm.com>
To:     Justin He <Justin.He@arm.com>, Len Brown <lenb@kernel.org>,
        James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        nd <nd@arm.com>, "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [RESEND PATCH v3 0/9] Make ghes_edac a proper module
Thread-Topic: [RESEND PATCH v3 0/9] Make ghes_edac a proper module
Thread-Index: AQHYtj2gHrEaPSiphka6WGL6lQzOZ627t1ZQ
Date:   Tue, 23 Aug 2022 01:49:56 +0000
Message-ID: <DBBPR08MB45381EB46B4714E0DCE63ABBF7709@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20220822154048.188253-1-justin.he@arm.com>
In-Reply-To: <20220822154048.188253-1-justin.he@arm.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 302be16e-4c51-446a-c710-08da84a9d163
x-ms-traffictypediagnostic: VI1PR08MB3101:EE_|DBAEUR03FT051:EE_|DB3PR08MB9059:EE_
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ONvTcfMP7zANbleEzPhje8BWJW9/arpRIhM/+mw9L/os0EMvj5TLP9g61Zyiyx83uIp4pOIUi3YssQBM/Y0j8mTUvfQVlgHoXgRdwB5h7YrR5JR9oHf5ClGVI8Kz7qYqJZMLAuoUaLaO77EE2UIMceAcz9QxraeDw0SPzgJTId/p6UvtUsMIW7ld5baJGxc7Nl3SauJmuSZy6A0iP6+HSHjC68i+GGip+S10SS85fIOXUL0bilVLbxCR3uqUZCVCKGgoWsbbSpHmoQ0WdTL3Nbgvi+j/W74wRQwdS5mFWe5gy8C48GlAAohvshuWzxF+I5gbwNWtLgn+29Jh0SFGLBQw2SF3yjq7vuwfRPIISxjfCyL5pCom2oWudvYet5RaQRe7n6JTPljCBVs7gZPLxksN72Wovxurr6LObrJ8cIAf9D5je9d3WTePoMcmWrIBg2RYPiC5wSCt6+ZK1+A9uzdfVcn6sbq/+qzfcYDzoBB5FMgWFpyF4EmFl5sqMDTqlWlfQJ9sfxgpNJvOrbjXjuBt5ojbEiPAmtlXhnSOdoeVLAf4B9AxjrOjx4canVQ3HZ7ijceMKEIoj71HONwVxcX3hxA/ynYyCdqQMQdXVbZjmwJVQ4YK8lxHVvxQ00aJLa87cVoFD8o+83gbnr/+hnIHao03kRUoUMh4/iZNoeXcFhBle5rpQyYdUd6vBdChhjDEB+FiD+WmFCaTpxnOKRf9+v9pId1DTUZKWmXwowk6pWlnaa2+Sjd2EnDNZdL9nPGhoRSt1R1HRGd9loc1HoYUMa47/ZPNzuV3sxdO/EM=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(54906003)(110136005)(5660300002)(86362001)(478600001)(64756008)(8676002)(66556008)(4326008)(66446008)(52536014)(6506007)(26005)(7696005)(9686003)(8936002)(186003)(7416002)(41300700001)(2906002)(921005)(38070700005)(33656002)(55016003)(66946007)(76116006)(558084003)(71200400001)(316002)(38100700002)(122000001)(66476007);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3101
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT051.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c94fce48-b3be-4e16-df74-08da84a9c7c1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dLqhv4dyySDkBME2pvs98iI5K5qO04pxEuRTqEoNENVKKx2GruQI7hblQ/97vGFTvery81u9A7nMR9ehIqpFmLB79uQHGJz2UM0XDXAE/k0K76ZhcW2U/JM4A7vN56a1UIJf4YaXPoVAghIfaBaH72k7+G4oY5Urq+ds/HGgBf75rbBa01PNu5zJzEIqA1X2/nAJ0HXQ8n04C4ktEXVk64Mlbn0na1PK30DbJ7Iz+ITenRXbg190eQCsoFRbmsDAc6VmpyFW7v0mIBtVigVUPkuwTSwOQDSOJbL68Jpj9vpz3LnE3GLbV+0pjgN3u/c2DjdQ8WPzw2iI//rutggllQexmquSAH0qqM7xr8i+kghBdplKpv15WOjsTqWRXLaGJRiCjgjIiDxHo/oWdz13TpkQl+QjVmCHW0PXyAzoBVSsr6Z2Avu3CrHkVfxzB6P4IyEJCSKV64DoyCuU3su5RKzKyRzBvtAuZjve6DIuVikBCa771ncAUfDMseHxhYalF/wYpisEwMLTMVBEQKFxbhJKJoJwgBMy6Y5lfwEQ8HaMKplrs1s/PTG4J10ZwA1uT2fLUtnv46PK9lGRB9W9g7U103KSsPH6zl3/VVB8j8BWaLk9qd8h79VlYBIfxv3YCEgMWFRuSKBHplH+8+UFAbwzaYJe1jSu0jQ/+NLGoSAq2eqK/AFv3qdnVDhQhChrJJVUJ+h3uGSpFOBQ7y2A3t5EIYYf1YLlItRzRVAXbxoDiXbStbkdRtHkZ0uVCLXrLO61J2RCGtkYaacNGts02NS7uMj4sI7bwQqV7cgGbWQ=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(376002)(36840700001)(46966006)(40470700004)(33656002)(478600001)(82310400005)(40480700001)(55016003)(2906002)(54906003)(86362001)(41300700001)(40460700003)(316002)(450100002)(110136005)(336012)(82740400003)(186003)(921005)(81166007)(6506007)(36860700001)(4744005)(26005)(47076005)(356005)(9686003)(7696005)(52536014)(70586007)(8936002)(8676002)(5660300002)(4326008)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 01:50:12.3506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 302be16e-4c51-446a-c710-08da84a9d163
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT051.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9059
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,=20
Sorry for resending the v3.
There is an exceptional interrupt when I tried to post v3 at the first time=
.
Maybe it is caused by a comma "," inside the mail name.
E.g.=20
Signed-off-by: Some, one <someone@site.com>
Looks like a git sendemail issue?=20

Anyway, sorry for the inconvenience.
--
Cheers,
Justin (Jia He)
