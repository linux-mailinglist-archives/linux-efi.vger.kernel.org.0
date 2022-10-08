Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D64C5F843A
	for <lists+linux-efi@lfdr.de>; Sat,  8 Oct 2022 10:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJHIOo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 8 Oct 2022 04:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiJHIOm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 8 Oct 2022 04:14:42 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0743CB1D5;
        Sat,  8 Oct 2022 01:14:41 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=OucF++F5ITHRyoH/b9W5sAekvg7mkj0FLUXOWgeOADY7YXm4vzPJPV57Euz5/M/epPL3H0jVy8iYyl/bfhMgMCS0Zk+QAwpI4HDOrjK0lUte/zufuO9KugVu6hFc1FDp55i/3jKerTw76TgXDixG9RPMVtGg8LuQWHrL2OfRk6NRzgVjovgN4mO6fsMHF1WkeKN1vxT7hJsCi0SwlBrLXgqyWOuvJWY/crfGi4M7RgcB2xNOZv4k9FXvjJsa4tRF2l4ZmbEpKhfum5mydmxlqoh6CVr2ufkNlXcD0qB7shPY3Fh6+giF5jiZOUgEXoFAA3EsyDMhDaJMW2RgW+iHpw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRnuEPZCgAhpxAnAB9qowQeA5/OqiOo6f1cYZnRU6pQ=;
 b=NQaqtvdqsDDIFZ2c48oxyx/P+2rCbifs9CWyet6BOLzUqKj9LuKFVYCHBmop+O7ANkXsNGF7Gv9HPUswxBDMqmoxEL0tB2UilJWFTSRG8zPJDkv1xR8CKtmBqNepAjfnolAw79+IRK3U/mU6rHy5hhreiX+kfQixEXlejs5AV+twWZFo2/B4qnOLxiteY++niwLKNwR4iFu3gRg5sYJexn2rXU3SqQ7uRpJMT76VAUXsbwKHv7vdfLnnMsThJAKDdAzCD76f9xp5BnzAbt4isVhqk4CwwaeZzmrm2hDTVeyuSMyqRIts4tOmybdfIIY+lDIWm5Js6lJsgczn/DCruA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRnuEPZCgAhpxAnAB9qowQeA5/OqiOo6f1cYZnRU6pQ=;
 b=gPeZFNRqui7UzBzDbC9DJOntoFiCqcYuEuyn8y5TmCeCdnPOLeP9CKBVGJ66yXsRBSgXWliTOMX7eeTQYDAugj61X3h96+FbG/gUE1fVVL0vUyo8nm/q6jJYZjpeYMtrXOtwPGa61GoJHdqzd0oUQXHA9VhN/4QI+usCi5SkMx8=
Received: from AS9PR06CA0090.eurprd06.prod.outlook.com (2603:10a6:20b:464::7)
 by DBAPR08MB5622.eurprd08.prod.outlook.com (2603:10a6:10:1af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Sat, 8 Oct
 2022 08:14:37 +0000
Received: from AM7EUR03FT008.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:464:cafe::99) by AS9PR06CA0090.outlook.office365.com
 (2603:10a6:20b:464::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Sat, 8 Oct 2022 08:14:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT008.mail.protection.outlook.com (100.127.141.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Sat, 8 Oct 2022 08:14:36 +0000
Received: ("Tessian outbound 86cf7f935b1b:v128"); Sat, 08 Oct 2022 08:14:36 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6e7416fc764fc43c
X-CR-MTA-TID: 64aa7808
Received: from d8e23a819ca4.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3D3FAD23-F757-4C7F-BB8A-79CB97C9C188.1;
        Sat, 08 Oct 2022 08:14:26 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d8e23a819ca4.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Sat, 08 Oct 2022 08:14:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JW6R8D1fGMOhFmV1V0zNw5vtl+A1dqpZKDhhwZ2HBC8sTHgDxp11wXHXrOCM39UT3twiaGQaeHZC3cVbobwktkV2f/hRAQNHp13RvxlEc8i+hvkLAWpmkK7bTnBXryjc4hiHTvshn65kn6yz8LQoXoOLxZX1PSsEGgyTbGeMpddun6DgQsTNJhiKlD93GnMLPh6JWTrow5i0oZ51kbPwWZSrK5S4ddGqCA2ao84Rg5PPYb0DQ0Za2BxE6kDuL2gz/iA5kRHnYX7SicJRXkNijV+uhrlatdiYCyYgkCwyCzEgcN/yaumcvjqp5VZ1TsCO8oDUdHcGuCKKWhP6tCn9Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRnuEPZCgAhpxAnAB9qowQeA5/OqiOo6f1cYZnRU6pQ=;
 b=LtcZAP5PRNbRK5Lj1PB+ddYwkPscavRmih4BhChrdln/sBo+QKZXtUEdqxfTP0HTowwwhsCm0p4rRyTVDNGCcfjy0qEMHySMWEWBym4slKCcjhqiqqpNYK5/H/hg4BEWLUpioxo4n75yxrOjx9Vo+cwsdjDWWOJ1LJZJqYJ84xq7krlrgslQh5N2ADzBM2uk/Asar/nAshRPhAyYGJil9NFYtLzMUlFOHwcPD1mExT5krkz90fzmiuHSss7XFBDmYneY3BMehiVS9ZmbknmceRsU4uvlSOpk+pr1ythLbuC92I/gvK+oG8Ic+0HofXcxMU6UU0o21LLk5QH6JE2Dcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRnuEPZCgAhpxAnAB9qowQeA5/OqiOo6f1cYZnRU6pQ=;
 b=gPeZFNRqui7UzBzDbC9DJOntoFiCqcYuEuyn8y5TmCeCdnPOLeP9CKBVGJ66yXsRBSgXWliTOMX7eeTQYDAugj61X3h96+FbG/gUE1fVVL0vUyo8nm/q6jJYZjpeYMtrXOtwPGa61GoJHdqzd0oUQXHA9VhN/4QI+usCi5SkMx8=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by AS8PR08MB9621.eurprd08.prod.outlook.com (2603:10a6:20b:61a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Sat, 8 Oct
 2022 08:14:12 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::d98f:f69a:a28c:fbfc]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::d98f:f69a:a28c:fbfc%7]) with mapi id 15.20.5709.015; Sat, 8 Oct 2022
 08:14:12 +0000
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
        nd <nd@arm.com>
Subject: RE: [PATCH v7 3/8] EDAC:ghes: Move ghes_edac.force_load to ghes
 module parameter
Thread-Topic: [PATCH v7 3/8] EDAC:ghes: Move ghes_edac.force_load to ghes
 module parameter
Thread-Index: AQHY06yXLvC1kIP2LESxWQ3/WyR50a3/8tKAgARBcCA=
Date:   Sat, 8 Oct 2022 08:14:12 +0000
Message-ID: <DBBPR08MB45381BA559446CAC7C4298DEF75E9@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20220929023726.73727-1-justin.he@arm.com>
 <20220929023726.73727-4-justin.he@arm.com> <Yz2fM+IbEkKmt8Ct@zn.tnic>
In-Reply-To: <Yz2fM+IbEkKmt8Ct@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBBPR08MB4538:EE_|AS8PR08MB9621:EE_|AM7EUR03FT008:EE_|DBAPR08MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: da4638fc-cf6b-42d6-10b5-08daa90523f5
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: pgCQZjBuM3p8BHDFlR2Tte/3G/3wfpBbZX9i/tih5A2CurtqRmSCL/0Q456por20jkNja6rKCeIS1buMOC9uiFOhLMdGQbnQ1f+fQlUcUt50MYH0GQlzspxQPoYsd2yEfEMHCvMoAtfIOKXr3R0rMupeBFaUV5TC7Q7Bclk372N7zcIZadWxfH2mg28OtVbOFOpo2HpnNJdf15marmvbMyocLecML6CXgOvoB0R65/tVQZkNNsGDbvXRs40oB5GFqxKfmZvXsmU1hpT8MfaLoQjrQLAjqEShp1uhXqEvKE55ockYDk1GlyrmOVtJjKqsz1rOSuCW7IuPo3hHPgnHoHowkYhRJpYUyj2SiX12HUdEsr66GxpfUIbfie4QqogpGLasDunRFfn4OGXQl6uGfNqSjW8/2Q3FmrW6XtPSoGqnODCBPZKmKXwhz4uJ3XEZumNpcreGhE8wP1AOt0lWPbg0L9BfzgDtVL5bAqTOLkNO5gUN9tws8wNs4mksut9wMA1HLb+reYgWEPQ3QLfOynqMH29NpuqLi5tN0M0hV8F4myNeNjFzBvRTsyjmRL/Pu+kZGTP3g6r28fLAM/aTVNc1IynKSiGb276aeYVftuYY+9mJbCj4gtC2H7ZuZDcLafI8D7ThH7HPD3ImxnB4t9Qv9m4TrNCR4qIBLXEgoC2FlqXRsbOawgVX2AcPKDWkrZmzKVQgoGtSP1MC+SNVqp0CmeTgXQs1KxA2VWLZHuNrBDEW7hVkx+7G+7cK64N8j8BGAoiMhwYy1Jju1uFLmQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199015)(83380400001)(52536014)(71200400001)(54906003)(86362001)(186003)(7416002)(4326008)(6916009)(38100700002)(8936002)(33656002)(5660300002)(8676002)(76116006)(64756008)(478600001)(2906002)(316002)(66476007)(66556008)(66446008)(41300700001)(7696005)(55016003)(66946007)(26005)(122000001)(38070700005)(9686003)(53546011)(6506007);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9621
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT008.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 30acf439-d047-42c5-1a5d-08daa9051587
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IWEOl+BXnYpyuIvaBI5Nl6WvJHtBk9v2IssmejkvENlwD9ByacuyPUQU17ZPhWkwcyr312cb9gbknFtlPm0EK00zcpzHiOL7O/sI2I8Dz5sF97jSMOlBWkXPCjcfSzHKFCIy5j2GGJsFI+lFP7rtT3Q322W79dWoVFT5yW+3xvz39vWMVxXRQxHFjJfsKG6FSNgwVNJ0gY+8O3DPtG9kWewjX60731aIEolj4JBzdvbOQvibsWnX92iX6AAb51jKd+lLHA2wFyGFdwnLSAg50XbT43ca0ze+72D1gaeUkSwZB3ygPV4jbGYBFifcfrtDNH3dXVb8NtsRaW5VqY7IlFTRvD5WxcagipYswJfv4Zw3OCS6GfW2Rg+xqkU/8mkC2brwNhAcqcqP4WT3/iVWFDnel56eofhFxgLZJi2WD51CsyqPWsvKNqP66Wp8eqewqIrnvg8Z4brg6x1SU8hkI8gs9QpLlSG0ucU2W3tMkDMNGv91u1wh4T32LdkW8fx8mHTBnut7wBc0Voo+JI5b9dq44vSSEotJnqQdw1EcosK3dFB123vq06SFp7j7iU0w65ME/gx2k8cGe2OLs4Xro6tSsWQGpQebJPGBuMo8ipa3IiiU5mOw6GvuzKLj4XAhrp7NQ1mFnVMHN95rdZQF1bx+J1ykjUGkoAXxOsFHA5KaQdaO73INx0UfbEOSs8ZCZd6YGFLz1D5Ry+7O1uC+D+FQoetF8gDA/1hbSxuf1hk=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39850400004)(396003)(451199015)(36840700001)(46966006)(81166007)(356005)(52536014)(36860700001)(336012)(86362001)(47076005)(82310400005)(8936002)(186003)(83380400001)(26005)(9686003)(82740400003)(2906002)(478600001)(33656002)(5660300002)(6506007)(316002)(53546011)(70206006)(70586007)(41300700001)(7696005)(8676002)(54906003)(6862004)(40480700001)(4326008)(55016003)(450100002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2022 08:14:36.8446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da4638fc-cf6b-42d6-10b5-08daa90523f5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT008.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5622
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
IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciA1LCAyMDIyIDExOjE0
IFBNDQo+IFRvOiBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBhcm0uY29tPg0KPiBDYzogTGVuIEJyb3du
IDxsZW5iQGtlcm5lbC5vcmc+OyBKYW1lcyBNb3JzZSA8SmFtZXMuTW9yc2VAYXJtLmNvbT47DQo+
IFRvbnkgTHVjayA8dG9ueS5sdWNrQGludGVsLmNvbT47IE1hdXJvIENhcnZhbGhvIENoZWhhYg0K
PiA8bWNoZWhhYkBrZXJuZWwub3JnPjsgUm9iZXJ0IFJpY2h0ZXIgPHJyaWNAa2VybmVsLm9yZz47
IFJvYmVydCBNb29yZQ0KPiA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT47IFFpdXh1IFpodW8gPHFp
dXh1LnpodW9AaW50ZWwuY29tPjsgWWF6ZW4NCj4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQu
Y29tPjsgSmFuIEx1ZWJiZSA8amx1QHBlbmd1dHJvbml4LmRlPjsNCj4gS2h1b25nIERpbmggPGto
dW9uZ0Bvcy5hbXBlcmVjb21wdXRpbmcuY29tPjsgS2FuaSBUb3NoaQ0KPiA8dG9zaGkua2FuaUBo
cGUuY29tPjsgQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz47DQo+IGxpbnV4LWFjcGlA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1l
ZGFjQHZnZXIua2VybmVsLm9yZzsgZGV2ZWxAYWNwaWNhLm9yZzsgUmFmYWVsIEogLiBXeXNvY2tp
DQo+IDxyYWZhZWxAa2VybmVsLm9yZz47IFNodWFpIFh1ZSA8eHVlc2h1YWlAbGludXguYWxpYmFi
YS5jb20+OyBKYXJra28NCj4gU2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3JnPjsgbGludXgtZWZp
QHZnZXIua2VybmVsLm9yZzsgbmQgPG5kQGFybS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djcgMy84XSBFREFDOmdoZXM6IE1vdmUgZ2hlc19lZGFjLmZvcmNlX2xvYWQgdG8gZ2hlcw0KPiBt
b2R1bGUgcGFyYW1ldGVyDQo+IA0KPiBPbiBUaHUsIFNlcCAyOSwgMjAyMiBhdCAwMjozNzoyMUFN
ICswMDAwLCBKaWEgSGUgd3JvdGU6DQo+ID4gZ2hlc19lZGFjX3JlZ2lzdGVyKCkgaXMgdG9vIGxh
dGUgdG8gc2V0IHRoaXMgbW9kdWxlIGZsYWcgZ2hlc19lZGFjLmZvcmNlX2xvYWQuDQo+ID4gQWxz
bywgb3RoZXIgZWRhYyBkcml2ZXJzIHNob3VsZCBub3QgYmUgYWJsZSB0byBjb250cm9sIHRoaXMg
ZmxhZy4NCj4gPg0KPiA+IE1vdmUgdGhpcyBmbGFnIHRvIHRoZSBtb2R1bGUgcGFyYW1ldGVyIGlu
IGdoZXMgaW5zdGVhZC4NCj4gPg0KPiA+IFN1Z2dlc3RlZC1ieTogVG9zaGkgS2FuaSA8dG9zaGku
a2FuaUBocGUuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEppYSBIZSA8anVzdGluLmhlQGFybS5j
b20+DQo+ID4gUmV2aWV3ZWQtYnk6IFRvc2hpIEthbmkgPHRvc2hpLmthbmlAaHBlLmNvbT4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9hY3BpL2FwZWkvZ2hlcy5jIHwgIDggKysrKysrKysgIGRyaXZl
cnMvZWRhYy9naGVzX2VkYWMuYyB8IDEwDQo+ID4gKysrLS0tLS0tLQ0KPiA+ICBpbmNsdWRlL2Fj
cGkvYXBlaS5oICAgICAgfCAgMiArKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlv
bnMoKyksIDcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3Bp
L2FwZWkvZ2hlcy5jIGIvZHJpdmVycy9hY3BpL2FwZWkvZ2hlcy5jIGluZGV4DQo+ID4gOGNiNjVm
NzU3ZDA2Li5iMGE2NDQ1YzZkYTIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9hY3BpL2FwZWkv
Z2hlcy5jDQo+ID4gKysrIGIvZHJpdmVycy9hY3BpL2FwZWkvZ2hlcy5jDQo+ID4gQEAgLTEwOSw2
ICsxMDksMTQgQEAgc3RhdGljIGlubGluZSBib29sIGlzX2hlc3RfdHlwZV9nZW5lcmljX3YyKHN0
cnVjdA0KPiA+IGdoZXMgKmdoZXMpICBib29sIGdoZXNfZGlzYWJsZTsgIG1vZHVsZV9wYXJhbV9u
YW1lZChkaXNhYmxlLA0KPiA+IGdoZXNfZGlzYWJsZSwgYm9vbCwgMCk7DQo+ID4NCj4gPiArLyoN
Cj4gPiArICogImdoZXMuZWRhY19mb3JjZV9lbmFibGUiIGZvcmNpYmx5IGVuYWJsZXMgZ2hlc19l
ZGFjIGFuZCBza2lwcyB0aGUNCj4gPiArcGxhdGZvcm0NCj4gPiArICogY2hlY2suDQo+ID4gKyAq
Lw0KPiA+ICtib29sIGdoZXNfZWRhY19mb3JjZV9lbmFibGU7DQo+ID4gK0VYUE9SVF9TWU1CT0wo
Z2hlc19lZGFjX2ZvcmNlX2VuYWJsZSk7DQo+ID4gK21vZHVsZV9wYXJhbV9uYW1lZChlZGFjX2Zv
cmNlX2VuYWJsZSwgZ2hlc19lZGFjX2ZvcmNlX2VuYWJsZSwgYm9vbCwNCj4gPiArMCk7DQo+IA0K
PiBXaHkgaXMgdGhpcyBleHBvcnRlZD8NCj4gDQo+IEluIHRoZSBleGVtcGxhcnkgcGF0Y2ggSSBz
ZW50IHlvdSwgdGhhdCB0aGluZyBpcyBzdGF0aWMuDQpTb3JyeSBmb3IgdGhlIGNhcmVsZXNzbmVz
cyANCg0KDQotLQ0KQ2hlZXJzLA0KSnVzdGluIChKaWEgSGUpDQoNCg0K
