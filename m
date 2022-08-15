Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0068F592760
	for <lists+linux-efi@lfdr.de>; Mon, 15 Aug 2022 03:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiHOBN6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 14 Aug 2022 21:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiHOBN5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 14 Aug 2022 21:13:57 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00050.outbound.protection.outlook.com [40.107.0.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159C71181E;
        Sun, 14 Aug 2022 18:13:56 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=eISTGYpgAJ6+txUppLATx3hIjbNTAQJT8cE/hQJq54DyKlC7wm3P9cHQPq29lWi0HUbkyNaYdKj8ezXM07y7PHE7CfKgCXEz5aPbp4YqR767lSlWXN+Qd9cqptfR7NS7q/xGFxaDfNY8Z5I7zgHfSC8fiqbct5LC3+odryhTyrVRMrPVzWGkAXGN206QOyxJCRWf3AeBkNjdDv5ghJpJ3oW6RH4JdoZP1nKYaV4sRqn7Ls3suv/J9JwnysA7pAMwYmSC4m6lKPSaRX0m1mpatTdAeSOvGdWpNF1q53OCMQjRKOHatqfLpgdrsPElIJ1hGfvF9mxfRbT4NFH+s2qyew==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/cOo/GD6dw9enMxvurwC0gHs+VdpX3GzetmiP/xjH4=;
 b=lKUmRNLNbBb09PEm8ME2R5H7DmcIeqBWQizfDMsU9thbmJh0Q2XDr4hf/oNPcdGXQVlUlq9OB7XPh/QYR27vw0Xe20ItT1/zJfNN7uTNZEElRwiLRS8zdNo1jtx9ynto1YxYP6Y8xSzjaF/JbNRQRBFQvWuSyeHHgI3t3CZbJeTY+yjt4phVsEdSrLrbM3WXGGeDc+TsTXtkAIlahFVAi/oJvCPgvDXcg5Fo1f5hY5lo2e1rUOAz50kguG0Ttbdfb3O+ub+z9h1JYZxZ2K93dcS76RE82dItz3X6RrZjGtDfE2BqLBhgvC6QNtnsCWRnCg/VP/3YSzNO/pAQGoWV6w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/cOo/GD6dw9enMxvurwC0gHs+VdpX3GzetmiP/xjH4=;
 b=1Ru6Mc6jmU+49yEN+1xMH6538dR0spCQ/LD9at2xcpNflj58c16P2VzURoXe6bVA3PI66ggnISej+jaFxCC+4i8npVQsPevkp+IXC3dJ/TXzUYZLy6TwkiPVkw1bZ0tTy+uUKUeeEYKaZLrwH+A/qVj9x6zGqBerlVFHHrAuZ6Q=
Received: from DB6PR0301CA0024.eurprd03.prod.outlook.com (2603:10a6:4:3e::34)
 by VE1PR08MB4734.eurprd08.prod.outlook.com (2603:10a6:802:a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 01:13:49 +0000
Received: from DBAEUR03FT027.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:3e:cafe::b3) by DB6PR0301CA0024.outlook.office365.com
 (2603:10a6:4:3e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.18 via Frontend
 Transport; Mon, 15 Aug 2022 01:13:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT027.mail.protection.outlook.com (100.127.142.237) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11 via Frontend Transport; Mon, 15 Aug 2022 01:13:49 +0000
Received: ("Tessian outbound fa99bf31ee7d:v123"); Mon, 15 Aug 2022 01:13:48 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1a738f29cea1d4b2
X-CR-MTA-TID: 64aa7808
Received: from d9ba9a5f3fca.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1417734B-7054-42BA-B563-A4FF97E0AE67.1;
        Mon, 15 Aug 2022 01:13:38 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d9ba9a5f3fca.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 15 Aug 2022 01:13:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wh77IAHAAHI9G9LC4cFiG8spTqdV4veFAaA6rdWdd0Q3pHCD2I/yxzPe8DppfjNEvK5EWAYGseIGi6JNPpw+mQRTDfMwbVmWwIPBErnDmymG+wjiDjmCrtpO01frkWsVw5bXWDXSWYf0nYrrwvRic8KoDfiWvgwFsQDpaTDR9j0A07fmpBXmDzkEDy5NiJeS2Nn+DixBU0CYX/KghTKGyZlN+JUwMz2gROEVnYhNShWbJXv6HujzvTk9huxubv3YL/1207HhZV5ZL1RPy6eYM8azX7tE3QE7/i7hPgvHFtfAbrhvv/fq2iBpQG6bJQ1QwlvQm0WOarZitq96WquGlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/cOo/GD6dw9enMxvurwC0gHs+VdpX3GzetmiP/xjH4=;
 b=OWMyhimEL9KzzabRu/MZYu5EEd7QAr9s9OC4G0Ep2jOpr83EEibxqmW9fBpOPpqFjDluVS7v3RVRTh5NJkE9f4ikmfvjJpwt5tBGY+ITAZ2FbdrMklACn/0tZwTG0szyWZc7ZUYpIObYb7M0Xi7kDZNxsqW6NbGmXEJO8EasSTLJrQRF2EgwgRZPaQmfpLovEMopadhdap/1qN/knfYil3sp/zUVoYbnzf7JKBf3pwQHZD5DHP5+vvb2gpJ5kT0vpli1mCaR4/jO/UkUdS60AHgjYYGQEI5ZJCRB87f6Y95uf5uKcYHRGQNa09CuwTwU13+xyoJR/G1RvINrxrWJ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/cOo/GD6dw9enMxvurwC0gHs+VdpX3GzetmiP/xjH4=;
 b=1Ru6Mc6jmU+49yEN+1xMH6538dR0spCQ/LD9at2xcpNflj58c16P2VzURoXe6bVA3PI66ggnISej+jaFxCC+4i8npVQsPevkp+IXC3dJ/TXzUYZLy6TwkiPVkw1bZ0tTy+uUKUeeEYKaZLrwH+A/qVj9x6zGqBerlVFHHrAuZ6Q=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by DB4PR08MB8151.eurprd08.prod.outlook.com (2603:10a6:10:381::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Mon, 15 Aug
 2022 01:13:35 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::9139:c501:db7f:6d6b]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::9139:c501:db7f:6d6b%3]) with mapi id 15.20.5504.025; Mon, 15 Aug 2022
 01:13:35 +0000
From:   Justin He <Justin.He@arm.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        nd <nd@arm.com>, "toshi.kani@hpe.com" <toshi.kani@hpe.com>
Subject: RE: [PATCH 1/2] efi/cper: export several helpers for ghes edac to use
Thread-Topic: [PATCH 1/2] efi/cper: export several helpers for ghes edac to
 use
Thread-Index: AQHYrWNDzBAUmLBftUKNypvhN4rEMa2rWc8AgAPSqLA=
Date:   Mon, 15 Aug 2022 01:13:35 +0000
Message-ID: <DBBPR08MB45380D6A2BEFD919AFB774BEF7689@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20220811091713.10427-1-justin.he@arm.com>
 <20220811091713.10427-2-justin.he@arm.com> <YvZnwIMonymPDJSw@zn.tnic>
In-Reply-To: <YvZnwIMonymPDJSw@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 9ed96026-3da2-4d07-4772-08da7e5b68c7
x-ms-traffictypediagnostic: DB4PR08MB8151:EE_|DBAEUR03FT027:EE_|VE1PR08MB4734:EE_
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: vHnwd8UGXoCpjtNny3H/gvB3ytzhC+S/RwlVP0IJAGi+S77RoNa7UZBHfu9ILUDjyQJU8n3yw3ztJLWfRrpEn/8wv+OjNc80ftmxBjLE3u7RYXl1p6cIjiejrrrHLs28xDvMfkXOtVjap2TCWqJltZjta43qInsnhR9wjtGqjgRlpfFDHoXJSdL/79/YRq9wG9ADruht7CK6CRkdXJ640CNQvbt7q8TNivLXBs5P2RTVBOGiMxPnz39N9FIbr613qb7bhOr7NC8mKhkBW1AIapLM1bi3xuOPSGLZyLX+QwuxRPVPEcRSpK2kzR56/N7ocL9sKkXOduAATYz89Md3bkuetTS829x1gcLN4cHErbxNlBiwe1pCF/ZkMrFfKNo27c84eV58vv35ozvgGd8bbjRGwS+KtF7nqP4uV0Le6ypXHSisIv5ampOuZ/6n25mhWpWJ3tNffOGEoU/1ZhOsD4giLQNwlvtRDx5IU/DslEK6Jz5nDIRVYJ2/IthRCAT7tsJMQO1p8OIXfjj2PB54cNEQBpRu0u4nl13vcb4R47fcuUwnj9nsCKTL7MFEsDMhigvSwlMDMkFD5810uh0tbVk0ZHVAxFn0C/vlWRH4u90Ikqy+zzWPKO+IQ9lk4+dn0aYYk9qKDXfKmJteXExgh9z1rCjUQTWkJjmNIFwgnliLj6FS+4IwjWwOjyJZ1nitpwJZle+pHkF9cvGLdU1pXp93cFi+OFpb8yjFoVnr/PmqDoQnr0WPsmjeXGPA4nfR+0ac7vL/D85mVEWG6NC6yG11DiBVsFFJ5t0mzmHWvoM=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39850400004)(366004)(346002)(376002)(396003)(76116006)(4326008)(8676002)(64756008)(66946007)(66446008)(66476007)(66556008)(52536014)(38100700002)(8936002)(86362001)(5660300002)(33656002)(7416002)(55016003)(316002)(6916009)(54906003)(38070700005)(83380400001)(26005)(9686003)(53546011)(186003)(2906002)(478600001)(71200400001)(122000001)(6506007)(7696005)(41300700001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8151
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT027.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 513137c9-0b9c-40fe-9b49-08da7e5b607d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CNVIK4USfVVj4nvdLpA6aoDCQussF4IaYuWuTFYZf7ygZ0UyPKb8ZkadE2cCm66YW+HyXJSlAIzA8VtclroBCCVZU5L5tMmD4CU4o1VPwpIQ0U0xP4CelTvQQDoUybdiPB6zgnisOsTu15/ET0KgiYa3Mx94oOvQeLou12lJWodOhILz2PR5WD7/JutC6mWxCKHBppJr31yVcgbZitF2xA9qlLOvMVB7dIeJbFX7WD/yQDk5daFf8+ESxKSvNEalgUeQ2aJUYuN8J8ABr+d1V5aWU31cAsTsye2f3gMJuFOtV7NOISCl+mC4bZn8N0OuCBr18Vl8efWgr7MtejJN5svq2ntCsThN5YxneOhjcVisOUykIN60dB1SgXgdow8qT+k2lD9A5AdIHJQ2uJe+bCuvAIA/ttTriFuEQIDTuTbtVVMs03uGARKQtj81eCKpOnKsRLHqeGBeOKImAgUrBYlAIeb361S5yDLYObQjPBgMqrBJIZmHCqEeC++L1fwQ5YHC+Udr9k+KXFTuRQ29bjdxL8J/BiPMF4W3/e3FbY45JFQqqUpCAXQqlawo19F9GzqSL6QhM8Q96ksC5InZUJkqPs1K8o9r93v/NiM4vod02TA6vsSDKhyZEsilpDYUsimUe8eKmIhHsjpqwfeObOMH1Sx1xOxdy3sk1xp2FGd6170BRMeOOD2WcXWDzWshPmiFh5/qdk0oO3l74Q14Wqh/D0RXl3aEyUgja9d5bc78Wxh+tjNQleN2MeFbm8B9T74nQlParA86rnquHJAVrQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(39850400004)(376002)(46966006)(36840700001)(450100002)(86362001)(316002)(82740400003)(70206006)(356005)(8676002)(81166007)(4326008)(83380400001)(6506007)(47076005)(55016003)(8936002)(6862004)(52536014)(40480700001)(53546011)(5660300002)(336012)(70586007)(7696005)(478600001)(36860700001)(82310400005)(186003)(26005)(54906003)(33656002)(41300700001)(2906002)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 01:13:49.1204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed96026-3da2-4d07-4772-08da7e5b68c7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT027.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4734
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SGkgQm9yaXMNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xh
diBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMTIsIDIwMjIg
MTA6NDYgUE0NCj4gVG86IEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5jb20+DQo+IENjOiBBcmQg
Qmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPjsgTGVuIEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+
OyBKYW1lcw0KPiBNb3JzZSA8SmFtZXMuTW9yc2VAYXJtLmNvbT47IFRvbnkgTHVjayA8dG9ueS5s
dWNrQGludGVsLmNvbT47IE1hdXJvDQo+IENhcnZhbGhvIENoZWhhYiA8bWNoZWhhYkBrZXJuZWwu
b3JnPjsgUm9iZXJ0IFJpY2h0ZXIgPHJyaWNAa2VybmVsLm9yZz47DQo+IFJvYmVydCBNb29yZSA8
cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT47IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOw0KPiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsg
ZGV2ZWxAYWNwaWNhLm9yZzsNCj4gUmFmYWVsIEogLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9y
Zz47IFNodWFpIFh1ZQ0KPiA8eHVlc2h1YWlAbGludXguYWxpYmFiYS5jb20+OyBKYXJra28gU2Fr
a2luZW4gPGphcmtrb0BrZXJuZWwub3JnPjsNCj4gbGludXgtZWZpQHZnZXIua2VybmVsLm9yZzsg
bmQgPG5kQGFybS5jb20+OyB0b3NoaS5rYW5pQGhwZS5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCAxLzJdIGVmaS9jcGVyOiBleHBvcnQgc2V2ZXJhbCBoZWxwZXJzIGZvciBnaGVzIGVkYWMgdG8g
dXNlDQo+IA0KPiBPbiBUaHUsIEF1ZyAxMSwgMjAyMiBhdCAwOToxNzoxMkFNICswMDAwLCBKaWEg
SGUgd3JvdGU6DQo+ID4gQmVmb3JlIG1vZHVsYXJpemluZyB0aGUgZ2hlc19lZGFjIGNvZGVzLCB3
ZSBuZWVkIHRvIGV4cG9ydCBzZXZlcmFsDQo+ID4gZWZpL2NwZXINCj4gDQo+IFdobydzIHdlPw0K
PiANCj4gUGxlYXNlIHVzZSBwYXNzaXZlIHZvaWNlIGluIHlvdXIgY29tbWl0IG1lc3NhZ2U6IG5v
ICJ3ZSIgb3IgIkkiLCBldGMsIGFuZA0KPiBkZXNjcmliZSB5b3VyIGNoYW5nZXMgaW4gaW1wZXJh
dGl2ZSBtb29kLg0KPiANCj4gQWxzbywgcGxzIHJlYWQgc2VjdGlvbiAiMikgRGVzY3JpYmUgeW91
ciBjaGFuZ2VzIiBpbg0KPiBEb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVz
LnJzdCBmb3IgbW9yZSBkZXRhaWxzLg0KPiANCj4gQWxzbywgc2VlIHNlY3Rpb24gIkNoYW5nZWxv
ZyIgaW4NCj4gRG9jdW1lbnRhdGlvbi9wcm9jZXNzL21haW50YWluZXItdGlwLnJzdA0KPiANCj4g
Qm90dG9tIGxpbmUgaXM6IHBlcnNvbmFsIHByb25vdW5zIGFyZSBhbWJpZ3VvdXMgaW4gdGV4dCwg
ZXNwZWNpYWxseSB3aXRoIHNvDQo+IG1hbnkgcGFydGllcy9jb21wYW5pZXMvZXRjIGRldmVsb3Bp
bmcgdGhlIGtlcm5lbCBzbyBsZXQncyBhdm9pZCB0aGVtIHBsZWFzZS4NCk9rYXnvvIxJIHdpbGwg
Zml4IHRoZSBjb21taXQgZGVzY3JpcHRpb24gaW4gbmV4dCB2ZXJzaW9uLg0KDQotLQ0KQ2hlZXJz
LA0KSnVzdGluIChKaWEgSGUpDQoNCg0K
