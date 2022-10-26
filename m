Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AC060D8B0
	for <lists+linux-efi@lfdr.de>; Wed, 26 Oct 2022 03:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiJZBG2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Oct 2022 21:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiJZBG1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Oct 2022 21:06:27 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20619.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::619])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDC572EC2;
        Tue, 25 Oct 2022 18:06:26 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=CuJBUW2LgTkaXVPmaDaATQHke8UgbZARp9dw9UN9kU4ZWXaDU1q2q7re+vhw++lXd+hR0J+9HcGL5oTs1ZSWNzXGTF2XBALzXgZvEuzIXJAl/mOukQo6pBSchVjXE/PeyanjZQNJR6PXJ0Ufp5MFaFWzStcUfYh6DGVxgza7tMm0xMIa4SXVTZZ755HzmWQ2JHliV3Jkdhb8m76ot2uJrRH73KLuftC72Pk5DA5vXnkCXW4J2kh325+K0x28hX56BYJkg3ABmTmYvdMChmie9lsDXmvuqok9JIeCMV2tsS5SN5CCei0N65yndr9kSx+mvtBI12rX1V8GrUw9o70SxA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ziLB8hBrAiV+FBlg2NIS9oaR8v7qo6wgWfKCwL4hBY=;
 b=kczYhOoPY+JwGwGLsYf2ibFinWkQlHFXtZo/t9VlmU1wJA3Mi7c5630xh/IfFf1ymwgW5zQjOJlUWWPQ0g4nLYbMdYqG4UWpU1w0IR5KPvF9B0MNh55WotYwPfMoYWHUL50dCntiXevzHxNsVYDrmT6hRF541pcgmxUzdLZQqLlYe6/X8OGaDL+xUy0bPoA0axSGM1ddaK4mi01N2ImiZnHsrgXhq/p+P/2CQ0LDHhtub0YFivvGTsC00cMKwAF+RNnhOWojPA4LAwberOrqKiVHApVORziG/b7GdDILXqTxW30sjj7aT/rN1KCoiPQOke6LlJVICuij1C2cIregKg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ziLB8hBrAiV+FBlg2NIS9oaR8v7qo6wgWfKCwL4hBY=;
 b=l6FyN34w0Bton/tD8C9/8DQmI2V5jKGrdINLjvay02/M4ok7LHE7+3iynMoF1ELAivvA2kBkDTmbQp81vEZGCKKVxZ7Tb/RgPCosJMiBrnbEIPZlTnDkLZD+sWofTQTIzGbugdQeltNcU7QkghG98HG5jvUjfhSldCuc19SXbO8=
Received: from DB8PR06CA0022.eurprd06.prod.outlook.com (2603:10a6:10:100::35)
 by AS1PR08MB7451.eurprd08.prod.outlook.com (2603:10a6:20b:4dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 01:06:20 +0000
Received: from DBAEUR03FT050.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:100:cafe::33) by DB8PR06CA0022.outlook.office365.com
 (2603:10a6:10:100::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Wed, 26 Oct 2022 01:06:20 +0000
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
 15.20.5723.20 via Frontend Transport; Wed, 26 Oct 2022 01:06:20 +0000
Received: ("Tessian outbound 73ab5f36653e:v130"); Wed, 26 Oct 2022 01:06:19 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: cdbc2753db27f9f6
X-CR-MTA-TID: 64aa7808
Received: from 2666302d68f4.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1A570AF4-300D-4334-8FD5-F678936FF3DA.1;
        Wed, 26 Oct 2022 01:06:10 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 2666302d68f4.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 26 Oct 2022 01:06:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WcaQKyh9Pyri71MV1fkaCQzRgkiUcrhk4JBQZEqFESSpJM34+6kyxnR2oZQzNURD/ipPjg6lHy0fde9071FPSvucKHG8DHgMJDpGvcTgMsNtPUIvdbaCLWim2nqYitcWhBtDbE9VWSSfWLanbXSq2BZ38MRWYv19en2145bRuLNWaZPmE1qS1WXkd662GOv6P1+sZRTmf8mB6lhv45qJ6dU+lANVUmbVvxrTsBrJQ51b8KGHVn+EnHanGnHRSN9zna7WUUpJ7+ozhIGOgmmq3vUX+yiOgSVF52uBfzCU4eu+p0Cu3CKd3vRFsOh8oVhuWsKDurN2NsIHMN22kGUg5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ziLB8hBrAiV+FBlg2NIS9oaR8v7qo6wgWfKCwL4hBY=;
 b=SNQ98n3+JYHwS+wCmttR/5HVAgLnlHARRrgTEUWp6NWs4X85mPGk1LMT3K84HRxGCVjdMp6+FjbVxVOlXN9XUD3Qa6MXH5PEP1TdpiWxcZEzEOhdBvMI1reMcqVqW6qOjE0mupm6BBvAG3spvtjfeJeQi/y5x+gLAADqRIzWQLONQi9LgzoQJItc5SBPPiB55qs6Kn3nvflUzgv85LUxqkKCqOxj9ToX2JmzbvecV4elp7zwvhRqe7nxmoUkc8/8ZwFrUH7IrtERHFEHj66/u8EXn+O2bL2CevTgW0/43cWVlFHg9OYbBzU2GWsWrp1xyORyQfgsYv2VmI2A+ESQJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ziLB8hBrAiV+FBlg2NIS9oaR8v7qo6wgWfKCwL4hBY=;
 b=l6FyN34w0Bton/tD8C9/8DQmI2V5jKGrdINLjvay02/M4ok7LHE7+3iynMoF1ELAivvA2kBkDTmbQp81vEZGCKKVxZ7Tb/RgPCosJMiBrnbEIPZlTnDkLZD+sWofTQTIzGbugdQeltNcU7QkghG98HG5jvUjfhSldCuc19SXbO8=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by AM8PR08MB5684.eurprd08.prod.outlook.com (2603:10a6:20b:1dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 01:06:04 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::cad9:24f4:c80b:b81d]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::cad9:24f4:c80b:b81d%7]) with mapi id 15.20.5746.026; Wed, 26 Oct 2022
 01:06:04 +0000
From:   Justin He <Justin.He@arm.com>
To:     Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
        Kani Toshi <toshi.kani@hpe.com>
CC:     Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        James Morse <James.Morse@arm.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        nd <nd@arm.com>, Peter Zijlstra <peterz@infradead.org>
Subject: RE: [PATCH v10 0/7] Make ghes_edac a proper module
Thread-Topic: [PATCH v10 0/7] Make ghes_edac a proper module
Thread-Index: AQHY4st7TXie6jpK3USJIrY4s/Zk0K4fMOsAgAC3OXA=
Date:   Wed, 26 Oct 2022 01:06:04 +0000
Message-ID: <DBBPR08MB453810097D413A0B29D3B396F7309@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20221018082214.569504-1-justin.he@arm.com>
 <Y1ft3KxOGXd7I6F9@zn.tnic>
In-Reply-To: <Y1ft3KxOGXd7I6F9@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBBPR08MB4538:EE_|AM8PR08MB5684:EE_|DBAEUR03FT050:EE_|AS1PR08MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: b962ddf9-8af8-498f-3f19-08dab6ee4ae9
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Mz98c01c+nVSxUm9MBWYCuAwJTfD8jrfY2379dRCsj4TmO3XS65hWfGHuoWsR0uckfLRhdM71EHvyHZpTjMTWhMqVACNJqG5sfWWkPPauhS8VrKhZMzMz0sRSUmN3SrAUI6R8QWDiNLixBGuOYngs7dhnYTS/nIF9qrre+lPmXuJQntttYONkfx5SkLfVzhVuUaIDVoOqD9VNC534zNlYYjoeN523mKumt6fSnI3QFXX5RrQcIGU4JzPSRkWqsrco66De2wI9lipkT0Qxo2NaMNeeOExf+0K1oSvZey5jtm5xFwDtWkkIdgywtQ6H63/9D9lmPa4oBo9EDWh0mo9287sl66nEAPiCjEksXVqZ73/scWmHO91tP8ltOHQsYc04bGSjSTjO8FV+XbdCsfyEWx5WP3OGg8W36tTxBpur+m1CJVXlJ/wWsWL6erRRf+81BWIOPWomENvVPBs6WEqhwbIXkIoMKVTeHCwj1A6w6FURhnalbYwhfdYTO7CEJjE9yhVxB93jmR4ZTRREGvU7uKNFCewRyVj8UX91HeBbMhtER6rH+M7/dAg0qXR2SNW4PxaYKgpdMm1qnU0UuwGhn3m6DtT1feG7LnkOwNzW3dm8YV8cnEK5blycBHWxONqRtX8wmYaPz5rd9Ra/cL6jt8RgUtMr/YAXZbYaelmdyHcDEEZWMhqWNMsZgyvb94fKnHlUjY3XgxzLVUP3S98RttqDwVUVMHC+4z2vj6fVt2YByifkWTNypXnUzEtCZWkHSXPsPH1etD6zNgGjToksg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199015)(86362001)(33656002)(38100700002)(122000001)(38070700005)(5660300002)(7416002)(83380400001)(2906002)(55016003)(8936002)(53546011)(6506007)(7696005)(186003)(26005)(9686003)(110136005)(54906003)(66556008)(71200400001)(478600001)(41300700001)(64756008)(8676002)(66946007)(316002)(66476007)(76116006)(66446008)(52536014)(4326008);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5684
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT050.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1e2ab426-31eb-4df7-aeb3-08dab6ee41c6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dCDjJlfiarqJ81Y5a6W8w/NQhORq7EoM85YiEkWeafXrL8DRf2HL0qOeBgvGHWI/0jOpx5TU5D890hIuAUCwx5zD7weLda6KfucD2R4kMlszA6YusPmZQPRE2irnt1L1u8gYv1rPSoxom+vJ1gE3D9QMEkgA0lEJUjkyIbSIDdtkhU1N1V8wdQK9mO9sZi7J8ZShktHacOES0enffF+S7Vwj3EmT6n96RaG73J8wFzgc/kXMPzjEe/dMRlwHiirh7pEp5JhrEnlDRY1RHIsOERJVe1hKG71q1mxT5Os1KIzENMdYxn3HUeONgqRHjVCSSthvb7u3vWBuQLpEf5p0g7cKLAx34tfCsoXmighZI29zonVQDnIJT3iAPThIbPKhhD3WelBy+HxryS9r730P7kPXJgAW4CwS3Wigxf9GA6hp9R8VJm6j+xLoQiv3VTUYx13iWlsXFRw+EwejYxpjbpgWg4NLZ7YwGg/dBSEXvEfh/QvS5NWpSiz+P/f3CwkIGWS7+wKtexc/Ngpo1JYblCSTsyFhD3su2LW25q3EtIEEvw4tX3RU9iotPqg5jXeeoawK4oc8iWAFdKShSzZ8jxeEu9Uzk0ZmglERQtLzuDDMBrbbt4hhhtQwEGt0A5KnwPIqLz0zAdGugJqe0/R15+mwQ/ZUJZAyL1nwkfqYEfsiIxjhIRHpnGfqWYvLycBgza4G9qm7/V5Q4XPoi1YFz7z2Ot3wLsf7s7EiQgPEm8YThFZJLQYyCLbFjdPNFskrffFgz8dk2eghDNNTEDQYVg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(40470700004)(46966006)(36840700001)(5660300002)(26005)(9686003)(110136005)(54906003)(41300700001)(8936002)(52536014)(55016003)(336012)(40460700003)(70206006)(40480700001)(47076005)(107886003)(186003)(450100002)(8676002)(7696005)(4326008)(70586007)(53546011)(33656002)(2906002)(316002)(86362001)(83380400001)(6506007)(356005)(81166007)(478600001)(82740400003)(36860700001)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 01:06:20.1305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b962ddf9-8af8-498f-3f19-08dab6ee4ae9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT050.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7451
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXNsYXYgUGV0a292
IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjUsIDIwMjIgMTA6MDgg
UE0NCj4gVG86IEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5jb20+DQo+IENjOiBBcmQgQmllc2hl
dXZlbCA8YXJkYkBrZXJuZWwub3JnPjsgTGVuIEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+OyBUb255
DQo+IEx1Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+OyBNYXVybyBDYXJ2YWxobyBDaGVoYWINCj4g
PG1jaGVoYWJAa2VybmVsLm9yZz47IFJvYmVydCBSaWNodGVyIDxycmljQGtlcm5lbC5vcmc+OyBS
b2JlcnQgTW9vcmUNCj4gPHJvYmVydC5tb29yZUBpbnRlbC5jb20+OyBRaXV4dSBaaHVvIDxxaXV4
dS56aHVvQGludGVsLmNvbT47IFlhemVuDQo+IEdoYW5uYW0gPHlhemVuLmdoYW5uYW1AYW1kLmNv
bT47IEphbiBMdWViYmUgPGpsdUBwZW5ndXRyb25peC5kZT47DQo+IEtodW9uZyBEaW5oIDxraHVv
bmdAb3MuYW1wZXJlY29tcHV0aW5nLmNvbT47IEthbmkgVG9zaGkNCj4gPHRvc2hpLmthbmlAaHBl
LmNvbT47IEphbWVzIE1vcnNlIDxKYW1lcy5Nb3JzZUBhcm0uY29tPjsNCj4gbGludXgtYWNwaUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWVk
YWNAdmdlci5rZXJuZWwub3JnOyBkZXZlbEBhY3BpY2Eub3JnOyBSYWZhZWwgSiAuIFd5c29ja2kN
Cj4gPHJhZmFlbEBrZXJuZWwub3JnPjsgU2h1YWkgWHVlIDx4dWVzaHVhaUBsaW51eC5hbGliYWJh
LmNvbT47IEphcmtrbw0KPiBTYWtraW5lbiA8amFya2tvQGtlcm5lbC5vcmc+OyBsaW51eC1lZmlA
dmdlci5rZXJuZWwub3JnOyBuZCA8bmRAYXJtLmNvbT47DQo+IFBldGVyIFppamxzdHJhIDxwZXRl
cnpAaW5mcmFkZWFkLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTAgMC83XSBNYWtlIGdo
ZXNfZWRhYyBhIHByb3BlciBtb2R1bGUNCj4gDQo+IE9uIFR1ZSwgT2N0IDE4LCAyMDIyIGF0IDA4
OjIyOjA3QU0gKzAwMDAsIEppYSBIZSB3cm90ZToNCj4gPiBDb21taXQgZGM0ZThjMDdlOWUyICgi
QUNQSTogQVBFSTogZXhwbGljaXQgaW5pdCBvZiBIRVNUIGFuZCBHSEVTIGluDQo+ID4gYXBjaV9p
bml0KCkiKSBpbnRyb2R1Y2VkIGEgYnVnIHRoYXQgZ2hlc19lZGFjX3JlZ2lzdGVyKCkgd291bGQg
YmUNCj4gPiBpbnZva2VkIGJlZm9yZSBlZGFjX2luaXQoKS4gQmVjYXVzZSBhdCB0aGF0IHRpbWUs
IHRoZSBidXMgImVkYWMiDQo+ID4gaGFzbid0IGJlZW4gZXZlbiByZWdpc3RlcmVkLCB0aGlzIGNy
ZWF0ZWQgc3lzZnMgL2RldmljZXMvbWMwIGluc3RlYWQNCj4gPiBvZg0KPiA+IC9zeXMvZGV2aWNl
cy9zeXN0ZW0vZWRhYy9tYy9tYzAgb24gYW4gQW1wZXJlIGVNYWcgc2VydmVyLg0KPiA+DQo+ID4g
VGhlIHNvbHV0aW9uIGlzIHRvIG1ha2UgZ2hlc19lZGFjIGEgcHJvcGVyIG1vZHVsZS4NCj4gPg0K
PiA+IENoYW5nZWxvZzoNCj4gPiB2MTA6DQo+IA0KPiBBbGwgcXVldWVkLCB0aGFua3MgZm9yIHRo
ZSBlZmZvcnQuDQo+IA0KPiBJdCdsbCBhcHBlYXIgaW4gTGludXggbmV4dCBzb29uLg0KPiANClRo
YW5rcyBmb3IgeW91ciBoZWxwIGFuZCBwYXRpZW5jZSDwn5iKDQoNCg0KLS0NCkNoZWVycywNCkp1
c3RpbiAoSmlhIEhlKQ0KDQo=
